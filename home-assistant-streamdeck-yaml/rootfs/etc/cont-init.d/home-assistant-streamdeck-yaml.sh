#!/usr/bin/with-contenv bashio
# ==============================================================================
# Bas Nijholt's Hass.io Add-ons: home-assistant-streamdeck-yaml
# Handles configuration
# ==============================================================================

bashio::log.info "Initializing the config overwriting."

hass_host=$(bashio::config "hass_host")
hass_token=$(bashio::config "hass_token")
streamdeck_config=$(bashio::config "streamdeck_config")
websocket_protocol=$(bashio::config "websocket_protocol")
streamdeck_dotenv=$(bashio::config "streamdeck_dotenv")

if [[ -n "${streamdeck_dotenv}" && -e "${streamdeck_dotenv}" ]]; then
    bashio::log.info "Using the .env file from ${streamdeck_dotenv}"
    cp "${streamdeck_dotenv}" /app/.env
else
    bashio::log.info "Using add-on configuration values instead of .env file"
    {
        echo "HASS_HOST=$hass_host"
        echo "HASS_TOKEN=$hass_token"
        echo "STREAMDECK_CONFIG=$streamdeck_config"
        echo "WEBSOCKET_PROTOCOL=$websocket_protocol"
    } > /app/.env
fi

# Copy the Stream Deck YAML configuration file to the add-on
cp "${streamdeck_config}" /app/configuration.yaml

bashio::log.info "Finished the config overwriting."
