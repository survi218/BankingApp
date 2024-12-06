# Step 1: Build the application using Maven
FROM maven:3.9.5-eclipse-temurin-8 AS build

# Set working directory inside the container
WORKDIR /app

# Copy project files
COPY pom.xml ./
COPY src ./src

# Build the application and skip tests
RUN mvn clean package -DskipTests

# Step 2: Use a lightweight JRE image to run the application
FROM openjdk:8-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/BankingApp-0.0.1-SNAPSHOT.jar app.jar

# Expose the application's port
EXPOSE 8080

# Add environment variables for database connection
ENV SPRING_DATASOURCE_URL=jdbc:mysql://mysql-container:3306/OnlineBanking??useSSL=false
ENV SPRING_DATASOURCE_USERNAME=root
ENV SPRING_DATASOURCE_PASSWORD=root

# Override the entrypoint to run the Java application
ENTRYPOINT []

# Default command to run the JAR file
CMD ["java", "-jar", "app.jar"]
