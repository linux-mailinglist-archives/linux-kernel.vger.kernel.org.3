Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A01496129
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351132AbiAUOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:35:39 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:46200 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1381178AbiAUOdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:33:24 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LDS7PK017315;
        Fri, 21 Jan 2022 08:33:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=SeTHs7tezQ9JTFk92AAVSYnvlRgxi9TT/qpp81Qypp8=;
 b=n+p12vG/OU8vJ9pAqhaRSmNidtczJ3nVqJaNbJqdMO5pRBJ5RoWdN6WQzAn7hXh5Lqi9
 dbIU3lGOQ9oYLLqfNz28fXLvsSusMhJVRo+1lEqpLSktZvB1w32gCExpk3vtVpgf1ptD
 6rAVWbeLHgTaWk1YP0FwlDkUTmZ67aM4Hdjlq1NwWPHlqpezkxWDDwcRKJD5RwBQZTN4
 hy/NfpxdFUBbJGEXVyBVx4z0Oh6ZLHVAEamWE3lAzjJKYVLRuljsylxtbS8rE5xdIixl
 lxexQIk903g7oRwzsVAf5sxjcUwwp55lvoRtYlY205+l76xZwd5FA6EXjQI37oN7IaL3 +A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dqhyq0up1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 08:33:01 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 14:32:59 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 14:32:59 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2733B11D7;
        Fri, 21 Jan 2022 14:32:59 +0000 (UTC)
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
Subject: [PATCH v5 7/9] platform/x86: serial-multi-instantiate: Add SPI support
Date:   Fri, 21 Jan 2022 14:32:52 +0000
Message-ID: <20220121143254.6432-8-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121143254.6432-1-sbinding@opensource.cirrus.com>
References: <20220121143254.6432-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QVaKH_74rC8gmIijxIPexmuTgSnVMBCN
X-Proofpoint-ORIG-GUID: QVaKH_74rC8gmIijxIPexmuTgSnVMBCN
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for spi bus in serial-multi-instantiate driver

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
 drivers/acpi/scan.c                           |  13 +-
 drivers/platform/x86/Kconfig                  |  10 +-
 .../platform/x86/serial-multi-instantiate.c   | 174 +++++++++++++++---
 3 files changed, 161 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8b237eb4e029..38c4f55960f4 100644
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
-	 * drivers/platform/x86/serial-multi-instantiate.c driver, which knows
-	 * which i2c_device_id to use for each resource.
+	 * These devices have multiple I2cSerialBus/SpiSerialBus resources
+	 * and an (i2c/spi)-client must be instantiated for each, each with
+	 * its own i2c_device_id/spi_device_id.
+	 * Normally we only instantiate an (i2c/spi)-client for the first
+	 * resource, using the ACPI HID as id. These special cases are handled
+	 * by the drivers/platform/x86/serial-multi-instantiate.c driver, which
+	 * knows which i2c_device_id or spi_device_id to use for each resource.
 	 */
 		{"BSG1160", },
 		{"BSG2150", },
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 5b65d687f046..28f5bbf0f27a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -991,12 +991,12 @@ config TOPSTAR_LAPTOP
 	  If you have a Topstar laptop, say Y or M here.
 
 config SERIAL_MULTI_INSTANTIATE
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
 	  will be called serial-multi-instantiate.
diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 162ec20a861a..535c80789852 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Serial multi-instantiate driver, pseudo driver to instantiate multiple
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
 
+enum smi_bus_type {
+	SMI_I2C,
+	SMI_SPI,
+	SMI_AUTO_DETECT,
+};
+
 struct smi_instance {
 	const char *type;
 	unsigned int flags;
 	int irq_idx;
 };
 
+struct smi_node {
+	enum smi_bus_type bus_type;
+	struct smi_instance instances[];
+};
+
 struct smi {
 	int i2c_num;
+	int spi_num;
 	struct i2c_client **i2c_devs;
+	struct spi_device **spi_devs;
 };
 
 static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
@@ -60,6 +74,93 @@ static void smi_devs_unregister(struct smi *smi)
 {
 	while (smi->i2c_num > 0)
 		i2c_unregister_device(smi->i2c_devs[--smi->i2c_num]);
+
+	while (smi->spi_num > 0)
+		spi_unregister_device(smi->spi_devs[--smi->spi_num]);
+}
+
+/**
+ * smi_spi_probe - Instantiate multiple SPI devices from inst array
+ * @pdev:	Platform device
+ * @adev:	ACPI device
+ * @smi:	Internal struct for Serial multi instantiate driver
+ * @inst:	Array of instances to probe
+ *
+ * Returns the number of SPI devices instantiate, Zero if none is found or a negative error code.
+ */
+static int smi_spi_probe(struct platform_device *pdev, struct acpi_device *adev, struct smi *smi,
+			 const struct smi_instance *inst_array)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_controller *ctlr;
+	struct spi_device *spi_dev;
+	char name[50];
+	int i, ret, count;
+
+	ret = acpi_spi_count_resources(adev);
+	if (ret <= 0)
+		return ret == 0 ? -ENODEV : ret;
+
+	count = ret;
+
+	smi->spi_devs = devm_kcalloc(dev, count, sizeof(*smi->spi_devs), GFP_KERNEL);
+	if (!smi->spi_devs)
+		return -ENOMEM;
+
+	for (i = 0; i < count && inst_array[i].type; i++) {
+
+		spi_dev = acpi_spi_device_alloc(NULL, adev, i);
+		if (IS_ERR(spi_dev)) {
+			ret = PTR_ERR(spi_dev);
+			dev_err_probe(dev, ret, "failed to allocate SPI device %s from ACPI: %d\n",
+				      dev_name(&adev->dev), ret);
+			goto error;
+		}
+
+		ctlr = spi_dev->controller;
+
+		strscpy(spi_dev->modalias, inst_array[i].type, sizeof(spi_dev->modalias));
+
+		ret = smi_get_irq(pdev, adev, &inst_array[i]);
+		if (ret < 0) {
+			spi_dev_put(spi_dev);
+			goto error;
+		}
+		spi_dev->irq = ret;
+
+		snprintf(name, sizeof(name), "%s-%s-%s.%d", dev_name(&ctlr->dev), dev_name(dev),
+			 inst_array[i].type, i);
+		spi_dev->dev.init_name = name;
+
+		ret = spi_add_device(spi_dev);
+		if (ret) {
+			dev_err_probe(&ctlr->dev, ret,
+				      "failed to add SPI device %s from ACPI: %d\n",
+				      dev_name(&adev->dev), ret);
+			spi_dev_put(spi_dev);
+			goto error;
+		}
+
+		dev_dbg(dev, "SPI device %s using chip select %u", name, spi_dev->chip_select);
+
+		smi->spi_devs[i] = spi_dev;
+		smi->spi_num++;
+	}
+
+	if (smi->spi_num < count) {
+		dev_err(dev, "Error finding driver, idx %d\n", i);
+		ret = -ENODEV;
+		goto error;
+	}
+
+	dev_info(dev, "Instantiated %d SPI devices.\n", smi->spi_num);
+
+	return 0;
+error:
+	smi_devs_unregister(smi);
+
+	return ret;
+
 }
 
 /**
@@ -125,13 +226,13 @@ static int smi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev,
 
 static int smi_probe(struct platform_device *pdev)
 {
-	const struct smi_instance *inst_array;
 	struct device *dev = &pdev->dev;
+	const struct smi_node *node;
 	struct acpi_device *adev;
 	struct smi *smi;
 
-	inst_array = device_get_match_data(dev);
-	if (!inst_array) {
+	node = device_get_match_data(dev);
+	if (!node) {
 		dev_err(dev, "Error ACPI match data is missing\n");
 		return -ENODEV;
 	}
@@ -146,7 +247,21 @@ static int smi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, smi);
 
-	return smi_i2c_probe(pdev, adev, smi, inst_array);
+	switch (node->bus_type) {
+	case SMI_I2C:
+		return smi_i2c_probe(pdev, adev, smi, node->instances);
+	case SMI_SPI:
+		return smi_spi_probe(pdev, adev, smi, node->instances);
+	case SMI_AUTO_DETECT:
+		if (i2c_acpi_client_count(adev) > 0)
+			return smi_i2c_probe(pdev, adev, smi, node->instances);
+		else
+			return smi_spi_probe(pdev, adev, smi, node->instances);
+	default:
+		break;
+	}
+
+	return 0; /* never reached */
 }
 
 static int smi_remove(struct platform_device *pdev)
@@ -158,27 +273,36 @@ static int smi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct smi_instance bsg1160_data[]  = {
-	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
-	{ "bmc150_magn" },
-	{ "bmg160" },
-	{}
+static const struct smi_node bsg1160_data = {
+	.instances = {
+		{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
+		{ "bmc150_magn" },
+		{ "bmg160" },
+		{}
+	},
+	.bus_type = SMI_I2C,
 };
 
-static const struct smi_instance bsg2150_data[]  = {
-	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
-	{ "bmc150_magn" },
-	/* The resources describe a 3th client, but it is not really there. */
-	{ "bsg2150_dummy_dev" },
-	{}
+static const struct smi_node bsg2150_data = {
+	.instances = {
+		{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
+		{ "bmc150_magn" },
+		/* The resources describe a 3th client, but it is not really there. */
+		{ "bsg2150_dummy_dev" },
+		{}
+	},
+	.bus_type = SMI_I2C,
 };
 
-static const struct smi_instance int3515_data[]  = {
-	{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
-	{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
-	{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
-	{ "tps6598x", IRQ_RESOURCE_APIC, 3 },
-	{}
+static const struct smi_node int3515_data = {
+	.instances = {
+		{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
+		{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
+		{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
+		{ "tps6598x", IRQ_RESOURCE_APIC, 3 },
+		{}
+	},
+	.bus_type = SMI_I2C,
 };
 
 /*
@@ -186,9 +310,9 @@ static const struct smi_instance int3515_data[]  = {
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
  */
 static const struct acpi_device_id smi_acpi_ids[] = {
-	{ "BSG1160", (unsigned long)bsg1160_data },
-	{ "BSG2150", (unsigned long)bsg2150_data },
-	{ "INT3515", (unsigned long)int3515_data },
+	{ "BSG1160", (unsigned long)&bsg1160_data },
+	{ "BSG2150", (unsigned long)&bsg2150_data },
+	{ "INT3515", (unsigned long)&int3515_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, smi_acpi_ids);
-- 
2.25.1

