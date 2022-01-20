Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15319494F69
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbiATNox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:44:53 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:65496 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245165AbiATNog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:44:36 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K6iPZG000624;
        Thu, 20 Jan 2022 07:43:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=gDXr6mhqkEWYwyY2+/RvxJKbQGkez6yIwQh+9q3aN/M=;
 b=oPAJ6uICau/FfHMhfPdKafGXMGD4H4npQULgQyxYpm+J9jmOs8nOBXBGrpZ+X+rGqEuB
 wV/NSCk4KGL5cs3sSwkL9ZsAJP1ehqvuB09BFFsGLPEBIaldBf5EXz3IJamMubcVuT12
 rtZLx6iZ7D+VV1lUOdkjkmrYiet+D68klpEDZM4mNYQU2HkxOqeSPTf6oVznu+tj1zLf
 dPYbZNiG3LRWmXI0KahhFKkXd1XZSoY+UQsPqmlVUbnSfH9qQn5szHA0nwpIdaGJt+SZ
 k8cJLO0cl7noBQ8vf7JXdHcRvBEUa/XvAmjB6Pj7kTZuH7gTatJMjEkXP6PT8ssYzLio GA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dpms0h5y2-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Jan 2022 07:43:46 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 13:43:42 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 20 Jan 2022 13:43:42 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4F1BD46D;
        Thu, 20 Jan 2022 13:43:42 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 7/9] platform/x86: bus-multi-instantiate: Add SPI support
Date:   Thu, 20 Jan 2022 13:43:24 +0000
Message-ID: <20220120134326.5295-8-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
References: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gOM-tQfy0PxKoNnog76N7zxn-2PaahVE
X-Proofpoint-GUID: gOM-tQfy0PxKoNnog76N7zxn-2PaahVE
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for spi bus in bus-multi-instantiate driver

Some peripherals can have either a I2C or a SPI connection
to the host (but not both) but use the same HID for both
types. So it is not possible to use the HID to determine
whether it is I2C or SPI. The driver must check the node
to see if it contains I2cSerialBus or SpiSerialBus entries.

For backwards-compatibility with the existing nodes I2C is
checked first and if such entries are found ONLY I2C devices
are created. Since some existing nodes that were already
handled by this driver could also contain unrelated
SpiSerialBus nodes that were previously ignored, and this
preserves that behavior. If there is ever a need to handle
a node where both I2C and SPI devices must be instantiated
this can be added in future.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/acpi/scan.c                          |  13 +-
 drivers/platform/x86/Kconfig                 |  10 +-
 drivers/platform/x86/bus-multi-instantiate.c | 200 ++++++++++++++++---
 3 files changed, 182 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e4fda14572e7..4fd1346d6e1f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1734,12 +1734,13 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	bool is_serial_bus_slave = false;
 	static const struct acpi_device_id ignore_serial_bus_ids[] = {
 	/*
-	 * These devices have multiple I2cSerialBus resources and an i2c-client
-	 * must be instantiated for each, each with its own i2c_device_id.
-	 * Normally we only instantiate an i2c-client for the first resource,
-	 * using the ACPI HID as id. These special cases are handled by the
-	 * drivers/platform/x86/bus-multi-instantiate.c driver, which knows
-	 * which i2c_device_id to use for each resource.
+	 * These devices have multiple I2cSerialBus/SpiSerialBus resources
+	 * and an (i2c/spi)-client must be instantiated for each, each with
+	 * its own i2c_device_id/spi_device_id.
+	 * Normally we only instantiate an (i2c/spi)-client for the first
+	 * resource, using the ACPI HID as id. These special cases are handled
+	 * by the drivers/platform/x86/bus-multi-instantiate.c driver, which
+	 * knows which i2c_device_id or spi_device_id to use for each resource.
 	 */
 		{"BSG1160", },
 		{"BSG2150", },
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 616da06aa6b9..7b49d9d1e267 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -991,12 +991,12 @@ config TOPSTAR_LAPTOP
 	  If you have a Topstar laptop, say Y or M here.
 
 config BUS_MULTI_INSTANTIATE
-	tristate "I2C multi instantiate pseudo device driver"
-	depends on I2C && ACPI
+	tristate "I2C and SPI multi instantiate pseudo device driver"
+	depends on I2C && SPI && ACPI
 	help
-	  Some ACPI-based systems list multiple i2c-devices in a single ACPI
-	  firmware-node. This driver will instantiate separate i2c-clients
-	  for each device in the firmware-node.
+	  Some ACPI-based systems list multiple i2c/spi devices in a
+	  single ACPI firmware-node. This driver will instantiate separate
+	  i2c-clients or spi-devices for each device in the firmware-node.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called bus-multi-instantiate.
diff --git a/drivers/platform/x86/bus-multi-instantiate.c b/drivers/platform/x86/bus-multi-instantiate.c
index 50f1540762e9..05bc941a38fd 100644
--- a/drivers/platform/x86/bus-multi-instantiate.c
+++ b/drivers/platform/x86/bus-multi-instantiate.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Bus multi-instantiate driver, pseudo driver to instantiate multiple
- * i2c-clients from a single fwnode.
+ * i2c-clients or spi-devices from a single fwnode.
  *
  * Copyright 2018 Hans de Goede <hdegoede@redhat.com>
  */
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/spi/spi.h>
 #include <linux/types.h>
 
 #define IRQ_RESOURCE_TYPE	GENMASK(1, 0)
@@ -21,15 +22,28 @@
 #define IRQ_RESOURCE_GPIO	1
 #define IRQ_RESOURCE_APIC	2
 
+enum bmi_bus_type {
+	BMI_I2C,
+	BMI_SPI,
+	BMI_AUTO_DETECT,
+};
+
 struct bmi_instance {
 	const char *type;
 	unsigned int flags;
 	int irq_idx;
 };
 
+struct bmi_node {
+	enum bmi_bus_type bus_type;
+	struct bmi_instance instances[];
+};
+
 struct bmi {
 	int i2c_num;
+	int spi_num;
 	struct i2c_client **i2c_devs;
+	struct spi_device **spi_devs;
 };
 
 static int bmi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
@@ -60,6 +74,92 @@ static void bmi_devs_unregister(struct bmi *bmi)
 {
 	while (bmi->i2c_num > 0)
 		i2c_unregister_device(bmi->i2c_devs[--bmi->i2c_num]);
+
+	while (bmi->spi_num > 0)
+		spi_unregister_device(bmi->spi_devs[--bmi->spi_num]);
+}
+
+/**
+ * bmi_spi_probe - Instantiate multiple SPI devices from inst array
+ * @pdev:	Platform device
+ * @adev:	ACPI device
+ * @bmi:	Internal struct for Bus multi instantiate driver
+ * @inst:	Array of instances to probe
+ *
+ * Returns the number of SPI devices instantiate, Zero if none is found or a negative error code.
+ */
+static int bmi_spi_probe(struct platform_device *pdev, struct acpi_device *adev, struct bmi *bmi,
+			 const struct bmi_instance *inst_array)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_controller *ctlr;
+	struct spi_device *spi_dev;
+	char name[50];
+	int i, ret, count;
+
+	ret = acpi_spi_count_resources(adev);
+	if (ret <= 0)
+		return ret;
+	count = ret;
+
+	bmi->spi_devs = devm_kcalloc(dev, count, sizeof(*bmi->spi_devs), GFP_KERNEL);
+	if (!bmi->spi_devs)
+		return -ENOMEM;
+
+	for (i = 0; i < count && inst_array[i].type; i++) {
+
+		spi_dev = acpi_spi_device_alloc(NULL, adev, i, inst_array[i].irq_idx);
+		if (IS_ERR(spi_dev)) {
+			ret = PTR_ERR(spi_dev);
+			goto error;
+		}
+
+		ctlr = spi_dev->controller;
+
+		strscpy(spi_dev->modalias, inst_array[i].type, sizeof(spi_dev->modalias));
+
+		if (spi_dev->irq < 0) {
+			ret = bmi_get_irq(pdev, adev, &inst_array[i]);
+			if (ret < 0) {
+				spi_dev_put(spi_dev);
+				goto error;
+			}
+			spi_dev->irq = ret;
+		}
+
+		snprintf(name, sizeof(name), "%s-%s-%s.%d", dev_name(&ctlr->dev), dev_name(dev),
+			 inst_array[i].type, i);
+		spi_dev->dev.init_name = name;
+
+		ret = spi_add_device(spi_dev);
+		if (ret) {
+			dev_err(&ctlr->dev, "failed to add SPI device %s from ACPI: %d\n",
+				dev_name(&adev->dev), ret);
+			spi_dev_put(spi_dev);
+			goto error;
+		}
+
+		dev_dbg(dev, "SPI device %s using chip select %u", name, spi_dev->chip_select);
+
+		bmi->spi_devs[i] = spi_dev;
+		bmi->spi_num++;
+	}
+
+	if (bmi->spi_num < count) {
+		dev_err(dev, "Error finding driver, idx %d\n", i);
+		ret = -ENODEV;
+		goto error;
+	}
+
+	dev_info(dev, "Instantiate %d SPI devices.\n", bmi->spi_num);
+
+	return bmi->spi_num;
+error:
+	bmi_devs_unregister(bmi);
+	dev_err_probe(dev, ret, "SPI error %d\n", ret);
+
+	return ret;
+
 }
 
 /**
@@ -125,14 +225,14 @@ static int bmi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev,
 
 static int bmi_probe(struct platform_device *pdev)
 {
-	const struct bmi_instance *inst_array;
 	struct device *dev = &pdev->dev;
+	const struct bmi_node *node;
 	struct acpi_device *adev;
 	struct bmi *bmi;
-	int ret;
+	int i2c_ret = 0, spi_ret = 0;
 
-	inst_array = device_get_match_data(dev);
-	if (!inst_array) {
+	node = device_get_match_data(dev);
+	if (!node) {
 		dev_err(dev, "Error ACPI match data is missing\n");
 		return -ENODEV;
 	}
@@ -147,13 +247,44 @@ static int bmi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bmi);
 
-	ret = bmi_i2c_probe(pdev, adev, bmi, inst_array);
-	if (ret > 0)
+	/* Each time this driver probes only one type of bus will be chosen.
+	 * And I2C has preference, which means that if find a I2cSerialBus it assumes
+	 * that all following devices will also be I2C.
+	 * In case there are zero I2C devices, it assumes that all following devices are SPI.
+	 */
+	if (node->bus_type != BMI_SPI) {
+		i2c_ret = bmi_i2c_probe(pdev, adev, bmi, node->instances);
+		if (i2c_ret > 0)
+			return 0;
+		else if (i2c_ret == -EPROBE_DEFER)
+			return i2c_ret;
+		if (node->bus_type == BMI_I2C) {
+			if (i2c_ret == 0)
+				return -ENODEV;
+			else
+				return i2c_ret;
+		}
+	}
+	/* BMI_SPI or BMI_AUTO_DETECT */
+	spi_ret = bmi_spi_probe(pdev, adev, bmi, node->instances);
+	if (spi_ret > 0)
 		return 0;
-	if (ret == 0)
-		ret = -ENODEV;
+	else if (spi_ret == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (node->bus_type == BMI_SPI) {
+		if (spi_ret == 0)
+			return -ENODEV;
+		else
+			return spi_ret;
+	}
 
-	return ret;
+	/* The only way to get here is BMI_AUTO_DETECT and i2c_ret <= 0 and spi_ret <= 0 */
+	if (i2c_ret == 0 && spi_ret == 0)
+		return -ENODEV;
+	else if (i2c_ret == 0 && spi_ret)
+		return spi_ret;
+
+	return i2c_ret;
 }
 
 static int bmi_remove(struct platform_device *pdev)
@@ -165,27 +296,36 @@ static int bmi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct bmi_instance bsg1160_data[]  = {
-	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
-	{ "bmc150_magn" },
-	{ "bmg160" },
-	{}
+static const struct bmi_node bsg1160_data = {
+	.instances = {
+		{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
+		{ "bmc150_magn" },
+		{ "bmg160" },
+		{}
+	},
+	.bus_type = BMI_I2C,
 };
 
-static const struct bmi_instance bsg2150_data[]  = {
-	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
-	{ "bmc150_magn" },
-	/* The resources describe a 3th client, but it is not really there. */
-	{ "bsg2150_dummy_dev" },
-	{}
+static const struct bmi_node bsg2150_data = {
+	.instances = {
+		{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
+		{ "bmc150_magn" },
+		/* The resources describe a 3th client, but it is not really there. */
+		{ "bsg2150_dummy_dev" },
+		{}
+	},
+	.bus_type = BMI_I2C,
 };
 
-static const struct bmi_instance int3515_data[]  = {
-	{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
-	{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
-	{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
-	{ "tps6598x", IRQ_RESOURCE_APIC, 3 },
-	{}
+static const struct bmi_node int3515_data = {
+	.instances = {
+		{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
+		{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
+		{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
+		{ "tps6598x", IRQ_RESOURCE_APIC, 3 },
+		{}
+	},
+	.bus_type = BMI_I2C,
 };
 
 /*
@@ -193,9 +333,9 @@ static const struct bmi_instance int3515_data[]  = {
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
  */
 static const struct acpi_device_id bmi_acpi_ids[] = {
-	{ "BSG1160", (unsigned long)bsg1160_data },
-	{ "BSG2150", (unsigned long)bsg2150_data },
-	{ "INT3515", (unsigned long)int3515_data },
+	{ "BSG1160", (unsigned long)&bsg1160_data },
+	{ "BSG2150", (unsigned long)&bsg2150_data },
+	{ "INT3515", (unsigned long)&int3515_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bmi_acpi_ids);
-- 
2.25.1

