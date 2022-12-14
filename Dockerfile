
FROM golang:1.19-alpine

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 go build -o /beerpub

FROM scratch
WORKDIR /
COPY --from=0 /beerpub /

EXPOSE 8080

ENTRYPOINT ["/beerpub"]

