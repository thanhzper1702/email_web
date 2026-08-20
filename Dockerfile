# Stage 1: Build file .war bằng Maven
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: Chạy ứng dụng trên Tomcat 9 (hỗ trợ javax.servlet)
FROM tomcat:9.0-jdk17
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]