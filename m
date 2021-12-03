Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92009467520
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351531AbhLCKeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:34:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380056AbhLCKec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638527467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vArHlsdMecG2QloyVHbd2lgxjdPi/Np+PU+dJLe52ak=;
        b=iTqb51xDuftQhMSNzcY3iignAaVEIkl5IBpqln2uRO1S8Qj9SuY1k4kGgaQ8KYg/KXG9wk
        0P/68oOmeZu5iASgb+Ua78VLEX5gUU4L1JtIHZ9IgSCZx2w7CFm7A+lB8PKzbd5EntyS22
        vDwHiBKsv43au3xzJd7Vn/nVRNPYxso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-YdBm_rJDOGS6_akgXoBlYw-1; Fri, 03 Dec 2021 05:31:02 -0500
X-MC-Unique: YdBm_rJDOGS6_akgXoBlYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED66481CCB4;
        Fri,  3 Dec 2021 10:30:59 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2462460843;
        Fri,  3 Dec 2021 10:30:55 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v7 14/14] media: ipu3-cio2: Add support for instantiating i2c-clients for VCMs
Date:   Fri,  3 Dec 2021 11:28:57 +0100
Message-Id: <20211203102857.44539-15-hdegoede@redhat.com>
In-Reply-To: <20211203102857.44539-1-hdegoede@redhat.com>
References: <20211203102857.44539-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sensors come with a variable-focus lens where the lens focus is
controller by a VCM (Voice Coil Motor). If there is a VCM for the
lens-focus, and if so which one, is described on the vcm_type field
of the ACPI SSDB table.

These VCMs are a second I2C device listed as an extra I2cSerialBusV2
resource in the same ACPI device as the sensor. The i2c-core-acpi.c
code only instantiates an i2c-client for the first I2cSerialBusV2
resource.

Add support for instantiating an i2c-client for the VCM with
the type of the i2c-client set based on the SSDB vcm_type field.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v6:
- New patch in v6 of this patch series
---
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 55 ++++++++++++++++++++++
 drivers/media/pci/intel/ipu3/cio2-bridge.h | 16 ++++++-
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index c805916d0909..7ccb7b6eaa82 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -3,6 +3,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/i2c.h>
 #include <linux/pci.h>
 #include <linux/property.h>
 #include <media/v4l2-fwnode.h>
@@ -38,6 +39,18 @@ static const struct cio2_property_names prop_names = {
 	.link_frequencies = "link-frequencies",
 };
 
+static const char * const cio2_vcm_types[] = {
+	"ad5823",
+	"dw9714",
+	"ad5816",
+	"dw9719",
+	"dw9718",
+	"dw9806b",
+	"wv517s",
+	"lc898122xa",
+	"lc898212axb",
+};
+
 static int cio2_bridge_read_acpi_buffer(struct acpi_device *adev, char *id,
 					void *data, u32 size)
 {
@@ -134,6 +147,12 @@ static void cio2_bridge_create_fwnode_properties(
 	sensor->dev_properties[2] = PROPERTY_ENTRY_U32(
 					sensor->prop_names.orientation,
 					orientation);
+	if (sensor->ssdb.vcmtype) {
+		sensor->vcm_ref[0] =
+			SOFTWARE_NODE_REFERENCE(&sensor->swnodes[SWNODE_VCM]);
+		sensor->dev_properties[3] =
+			PROPERTY_ENTRY_REF_ARRAY("lens-focus", sensor->vcm_ref);
+	}
 
 	sensor->ep_properties[0] = PROPERTY_ENTRY_U32(
 					sensor->prop_names.bus_type,
@@ -195,6 +214,33 @@ static void cio2_bridge_create_connection_swnodes(struct cio2_bridge *bridge,
 						sensor->node_names.endpoint,
 						&nodes[SWNODE_CIO2_PORT],
 						sensor->cio2_properties);
+	if (sensor->ssdb.vcmtype)
+		nodes[SWNODE_VCM] =
+			NODE_VCM(cio2_vcm_types[sensor->ssdb.vcmtype - 1]);
+}
+
+static void cio2_bridge_instantiate_vcm_i2c_client(struct cio2_sensor *sensor)
+{
+	struct i2c_board_info board_info = { };
+	char name[16];
+
+	if (!sensor->ssdb.vcmtype)
+		return;
+
+	snprintf(name, sizeof(name), "%s-VCM", acpi_dev_name(sensor->adev));
+	board_info.dev_name = name;
+	strscpy(board_info.type, cio2_vcm_types[sensor->ssdb.vcmtype - 1],
+		ARRAY_SIZE(board_info.type));
+	board_info.swnode = &sensor->swnodes[SWNODE_VCM];
+
+	sensor->vcm_i2c_client =
+		i2c_acpi_new_device_by_fwnode(acpi_fwnode_handle(sensor->adev),
+					      1, &board_info);
+	if (IS_ERR(sensor->vcm_i2c_client)) {
+		dev_warn(&sensor->adev->dev, "Error instantiation VCM i2c-client: %ld\n",
+			 PTR_ERR(sensor->vcm_i2c_client));
+		sensor->vcm_i2c_client = NULL;
+	}
 }
 
 static void cio2_bridge_unregister_sensors(struct cio2_bridge *bridge)
@@ -207,6 +253,7 @@ static void cio2_bridge_unregister_sensors(struct cio2_bridge *bridge)
 		software_node_unregister_nodes(sensor->swnodes);
 		ACPI_FREE(sensor->pld);
 		acpi_dev_put(sensor->adev);
+		i2c_unregister_device(sensor->vcm_i2c_client);
 	}
 }
 
@@ -239,6 +286,12 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		if (ret)
 			goto err_put_adev;
 
+		if (sensor->ssdb.vcmtype > ARRAY_SIZE(cio2_vcm_types)) {
+			dev_warn(&adev->dev, "Unknown VCM type %d\n",
+				 sensor->ssdb.vcmtype);
+			sensor->ssdb.vcmtype = 0;
+		}
+
 		status = acpi_get_physical_device_location(adev->handle, &sensor->pld);
 		if (ACPI_FAILURE(status)) {
 			ret = -ENODEV;
@@ -269,6 +322,8 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		sensor->adev = acpi_dev_get(adev);
 		adev->fwnode.secondary = fwnode;
 
+		cio2_bridge_instantiate_vcm_i2c_client(sensor);
+
 		dev_info(&cio2->dev, "Found supported sensor %s\n",
 			 acpi_dev_name(adev));
 
diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.h b/drivers/media/pci/intel/ipu3/cio2-bridge.h
index 202c7d494f7a..4418cbd08208 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.h
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.h
@@ -8,6 +8,8 @@
 
 #include "ipu3-cio2.h"
 
+struct i2c_client;
+
 #define CIO2_HID				"INT343E"
 #define CIO2_MAX_LANES				4
 #define MAX_NUM_LINK_FREQS			3
@@ -42,12 +44,19 @@
 		.properties = _PROPS,		\
 	}
 
+#define NODE_VCM(_TYPE)				\
+	(const struct software_node) {		\
+		.name = _TYPE,			\
+	}
+
 enum cio2_sensor_swnodes {
 	SWNODE_SENSOR_HID,
 	SWNODE_SENSOR_PORT,
 	SWNODE_SENSOR_ENDPOINT,
 	SWNODE_CIO2_PORT,
 	SWNODE_CIO2_ENDPOINT,
+	/* Must be last because it is optional / maybe empty */
+	SWNODE_VCM,
 	SWNODE_COUNT
 };
 
@@ -106,8 +115,10 @@ struct cio2_sensor_config {
 struct cio2_sensor {
 	char name[ACPI_ID_LEN];
 	struct acpi_device *adev;
+	struct i2c_client *vcm_i2c_client;
 
-	struct software_node swnodes[6];
+	/* SWNODE_COUNT + 1 for terminating empty node */
+	struct software_node swnodes[SWNODE_COUNT + 1];
 	struct cio2_node_names node_names;
 
 	struct cio2_sensor_ssdb ssdb;
@@ -115,10 +126,11 @@ struct cio2_sensor {
 
 	struct cio2_property_names prop_names;
 	struct property_entry ep_properties[5];
-	struct property_entry dev_properties[4];
+	struct property_entry dev_properties[5];
 	struct property_entry cio2_properties[3];
 	struct software_node_ref_args local_ref[1];
 	struct software_node_ref_args remote_ref[1];
+	struct software_node_ref_args vcm_ref[1];
 };
 
 struct cio2_bridge {
-- 
2.33.1

