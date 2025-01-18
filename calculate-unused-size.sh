#!/bin/bash
# Read the unused packages from the JSON file
UNUSED_PACKAGES=$(jq -r '.dependencies[]' unused-packages.json)

# Initialize total size
TOTAL_SIZE=0


# Loop through each unused package and calculate its size
for PACKAGE in $UNUSED_PACKAGES; do
  PACKAGE_SIZE=$(du -s -k "node_modules/$PACKAGE" | cut -f1)
  TOTAL_SIZE=$((TOTAL_SIZE + PACKAGE_SIZE))
done

# Convert total size to MB
TOTAL_SIZE_MB=$(echo "scale=2; $TOTAL_SIZE / 1024" | bc)

echo "Total size of unused packages: $TOTAL_SIZE_MB MB"
