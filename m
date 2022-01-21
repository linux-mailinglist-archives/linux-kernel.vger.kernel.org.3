Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286634963CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380636AbiAURZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:25:19 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:5204 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1380017AbiAURZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:25:09 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LHACZD027684;
        Fri, 21 Jan 2022 11:24:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ImeccfKCvDaXakS8R3MR1+1Pe3/f5fwFgpYe0ncTsrk=;
 b=BCNLfFK/32G5L1jdP8IqhUdN9pAGjmFqD3UMaF7tHO/vvCVvcGpLtTiqiTVCAdfFsyrs
 V44rTmJQhuo9kxqUsPBzJSsx255eaiwyk3ob+z3a7H9LEKWisn3QzGdgMnGZA+4IvIAL
 NByzsb+DS+leQ8ZYDXNojvgLXXBTePEWPhQSFIQxzHfFoHv831f9rhTMuUjA8im6fmt8
 sK2+WEj63799FZwrEkjYkcfD3OqDumRVNWAGQmmvBEQ0ngwta5Uy+TDWSuRXPkRJzMDW
 0sb6Ahp4YnxE+0V+pvFTdY4ALHM0MEc6/GGYR68fN5Hq8WJvE7SWL3Owr8UJIGfD7aA/ Kw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dqhyq14dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 11:24:54 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 17:24:52 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 17:24:52 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4C0DA11D7;
        Fri, 21 Jan 2022 17:24:52 +0000 (UTC)
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
Subject: [PATCH v6 7/9] platform/x86: serial-multi-instantiate: Add SPI support
Date:   Fri, 21 Jan 2022 17:24:29 +0000
Message-ID: <20220121172431.6876-8-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: iYL4rgJYmNKFy9OZxI74ou0X4Ps5Uk3U
X-Proofpoint-ORIG-GUID: iYL4rgJYmNKFy9OZxI74ou0X4Ps5Uk3U
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
 drivers/platform/x86/Kconfig                  |   2 +-
 .../platform/x86/serial-multi-instantiate.c   | 174 +++++++++++++++---
 2 files changed, 151 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2e656909a866..8d1eec208854 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -992,7 +992,7 @@ config TOPSTAR_LAPTOP
 
 config SERIAL_MULTI_INSTANTIATE
 	tristate "Serial bus multi instantiate pseudo device driver"
-	depends on I2C && ACPI
+	depends on I2C && SPI && ACPI
 	help
 	  Some ACPI-based systems list multiple devices in a single ACPI
 	  firmware-node. This driver will instantiate separate clients
diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 4cd6d72a0741..3f05385ca2cf 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
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
@@ -59,6 +73,95 @@ static void smi_devs_unregister(struct smi *smi)
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
+ * @inst_array:	Array of instances to probe
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
+	if (ret < 0)
+		return ret;
+	else if (!ret)
+		return -ENODEV;
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
+		dev_dbg(dev, "Error finding driver, idx %d\n", i);
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
@@ -126,8 +229,8 @@ static int smi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev,
 
 static int smi_probe(struct platform_device *pdev)
 {
-	const struct smi_instance *inst_array;
 	struct device *dev = &pdev->dev;
+	const struct smi_node *node;
 	struct acpi_device *adev;
 	struct smi *smi;
 
@@ -135,8 +238,8 @@ static int smi_probe(struct platform_device *pdev)
 	if (!adev)
 		return -ENODEV;
 
-	inst_array = device_get_match_data(dev);
-	if (!inst_array) {
+	node = device_get_match_data(dev);
+	if (!node) {
 		dev_dbg(dev, "Error ACPI match data is missing\n");
 		return -ENODEV;
 	}
@@ -147,7 +250,21 @@ static int smi_probe(struct platform_device *pdev)
 
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
@@ -159,27 +276,36 @@ static int smi_remove(struct platform_device *pdev)
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
@@ -187,9 +313,9 @@ static const struct smi_instance int3515_data[]  = {
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

