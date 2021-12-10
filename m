Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CE747042B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243095AbhLJPpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:45:54 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:41548 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236812AbhLJPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:45:46 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BACurAS000494;
        Fri, 10 Dec 2021 09:42:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=kvJMvbHtg2to5to/eNSxSoMs65hReV5fsSJ55FJj/2w=;
 b=OTB2H0/9F8dosb1Ep9fSr67+tPR9ycMnIR2mOJrLoU4Y9oAybUZebQA8lxdzaJNcOOus
 //egE0T20QBvkZ0mFXJx2rWeAHz76gvOYyAf8ubBEzl1KvfYQTLVL8do6iba/ILH0wr3
 Xu2yyUeyvKxgMf9qgtK2d88Kpaboo/cieEFtT8hjnhc8PJif2G/w8LvOuG+gFTS30dMK
 SOcFmsOWv+w170nMKR74L+N6LT+xxsS3XUgL4ral24zJtoW61OfX2BgJKMZj0BJAaQIK
 BPkAmBUVumgQz6nCmHHy7KmBW8Q/EWDS/27JSJcPAXrmxilxu0ugKUem6vSiWaymbqWP Mw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cuds09y4q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Dec 2021 09:42:00 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 15:41:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Dec 2021 15:41:58 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 65D072AA;
        Fri, 10 Dec 2021 15:41:58 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 4/6] ACPI: i2c-multi-instantiate: Rename it for a generic bus driver name
Date:   Fri, 10 Dec 2021 15:40:48 +0000
Message-ID: <20211210154050.3713-5-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KAJFFoJozoxV2DMnPdtWewtO_6FoPgw-
X-Proofpoint-ORIG-GUID: KAJFFoJozoxV2DMnPdtWewtO_6FoPgw-
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Rename I2C multi instantiate driver to bus-multi-instantiate for
upcoming addition of SPI support

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 MAINTAINERS                                   |  4 +-
 drivers/acpi/Kconfig                          |  4 +-
 drivers/acpi/Makefile                         |  2 +-
 ...-instantiate.c => bus-multi-instantiate.c} | 89 +++++++++----------
 drivers/acpi/scan.c                           |  8 +-
 5 files changed, 53 insertions(+), 54 deletions(-)
 rename drivers/acpi/{i2c-multi-instantiate.c => bus-multi-instantiate.c} (53%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25e056854772..256b44bb6773 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -387,11 +387,11 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/acpi/arm64
 
-ACPI I2C MULTI INSTANTIATE DRIVER
+ACPI BUS MULTI INSTANTIATE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/acpi/i2c-multi-instantiate.c
+F:	drivers/acpi/bus-multi-instantiate.c
 
 ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
 M:	Sudeep Holla <sudeep.holla@arm.com>
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 6200d13fa97b..6ba47dd39eb4 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -295,7 +295,7 @@ config ACPI_PROCESSOR
 	  To compile this driver as a module, choose M here:
 	  the module will be called processor.
 
-config ACPI_I2C_MULTI_INST
+config ACPI_BUS_MULTI_INST
 	tristate "I2C multi instantiate pseudo device driver"
 	depends on I2C
 	help
@@ -304,7 +304,7 @@ config ACPI_I2C_MULTI_INST
 	  for each device in the firmware-node.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called i2c-multi-instantiate.
+	  will be called bus-multi-instantiate.
 
 config ACPI_IPMI
 	tristate "IPMI"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 98d700d55960..38cf0ecc595a 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -102,7 +102,7 @@ obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
-obj-$(CONFIG_ACPI_I2C_MULTI_INST)	+= i2c-multi-instantiate.o
+obj-$(CONFIG_ACPI_BUS_MULTI_INST)	+= bus-multi-instantiate.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/acpi/i2c-multi-instantiate.c b/drivers/acpi/bus-multi-instantiate.c
similarity index 53%
rename from drivers/acpi/i2c-multi-instantiate.c
rename to drivers/acpi/bus-multi-instantiate.c
index 4956a1df5b90..982dfecfd27c 100644
--- a/drivers/acpi/i2c-multi-instantiate.c
+++ b/drivers/acpi/bus-multi-instantiate.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * I2C multi-instantiate driver, pseudo driver to instantiate multiple
+ * Bus multi-instantiate driver, pseudo driver to instantiate multiple
  * i2c-clients from a single fwnode.
  *
  * Copyright 2018 Hans de Goede <hdegoede@redhat.com>
@@ -21,29 +21,29 @@
 #define IRQ_RESOURCE_GPIO	1
 #define IRQ_RESOURCE_APIC	2
 
-struct i2c_inst_data {
+struct bmi_instance {
 	const char *type;
 	unsigned int flags;
 	int irq_idx;
 };
 
-struct i2c_multi_inst_data {
-	int num_clients;
-	struct i2c_client *clients[];
+struct bmi {
+	int i2c_num;
+	struct i2c_client *i2c_devs[];
 };
 
-static int i2c_multi_inst_probe(struct platform_device *pdev)
+static int bmi_probe(struct platform_device *pdev)
 {
-	struct i2c_multi_inst_data *multi;
-	const struct i2c_inst_data *inst_data;
 	struct i2c_board_info board_info = {};
+	const struct bmi_instance *inst;
 	struct device *dev = &pdev->dev;
 	struct acpi_device *adev;
+	struct bmi *bmi;
 	char name[32];
 	int i, ret;
 
-	inst_data = device_get_match_data(dev);
-	if (!inst_data) {
+	inst = device_get_match_data(dev);
+	if (!inst) {
 		dev_err(dev, "Error ACPI match data is missing\n");
 		return -ENODEV;
 	}
@@ -55,33 +55,32 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	multi = devm_kmalloc(dev, struct_size(multi, clients, ret), GFP_KERNEL);
-	if (!multi)
+	bmi = devm_kmalloc(dev, struct_size(bmi, i2c_devs, ret), GFP_KERNEL);
+	if (!bmi)
 		return -ENOMEM;
 
-	multi->num_clients = ret;
+	bmi->i2c_num = ret;
 
-	for (i = 0; i < multi->num_clients && inst_data[i].type; i++) {
+	for (i = 0; i < bmi->i2c_num && inst[i].type; i++) {
 		memset(&board_info, 0, sizeof(board_info));
-		strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
-		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev),
-			 inst_data[i].type, i);
+		strlcpy(board_info.type, inst[i].type, I2C_NAME_SIZE);
+		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst[i].type, i);
 		board_info.dev_name = name;
-		switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
+		switch (inst[i].flags & IRQ_RESOURCE_TYPE) {
 		case IRQ_RESOURCE_GPIO:
-			ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
+			ret = acpi_dev_gpio_irq_get(adev, inst[i].irq_idx);
 			if (ret < 0) {
 				dev_err(dev, "Error requesting irq at index %d: %d\n",
-					inst_data[i].irq_idx, ret);
+						inst[i].irq_idx, ret);
 				goto error;
 			}
 			board_info.irq = ret;
 			break;
 		case IRQ_RESOURCE_APIC:
-			ret = platform_get_irq(pdev, inst_data[i].irq_idx);
+			ret = platform_get_irq(pdev, inst[i].irq_idx);
 			if (ret < 0) {
 				dev_dbg(dev, "Error requesting irq at index %d: %d\n",
-					inst_data[i].irq_idx, ret);
+					inst[i].irq_idx, ret);
 				goto error;
 			}
 			board_info.irq = ret;
@@ -90,48 +89,48 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 			board_info.irq = 0;
 			break;
 		}
-		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
-		if (IS_ERR(multi->clients[i])) {
-			ret = dev_err_probe(dev, PTR_ERR(multi->clients[i]),
+		bmi->i2c_devs[i] = i2c_acpi_new_device(dev, i, &board_info);
+		if (IS_ERR(bmi->i2c_devs[i])) {
+			ret = dev_err_probe(dev, PTR_ERR(bmi->i2c_devs[i]),
 					    "Error creating i2c-client, idx %d\n", i);
 			goto error;
 		}
 	}
-	if (i < multi->num_clients) {
+	if (i < bmi->i2c_num) {
 		dev_err(dev, "Error finding driver, idx %d\n", i);
 		ret = -ENODEV;
 		goto error;
 	}
 
-	platform_set_drvdata(pdev, multi);
+	platform_set_drvdata(pdev, bmi);
 	return 0;
 
 error:
 	while (--i >= 0)
-		i2c_unregister_device(multi->clients[i]);
+		i2c_unregister_device(bmi->i2c_devs[i]);
 
 	return ret;
 }
 
-static int i2c_multi_inst_remove(struct platform_device *pdev)
+static int bmi_remove(struct platform_device *pdev)
 {
-	struct i2c_multi_inst_data *multi = platform_get_drvdata(pdev);
+	struct bmi *bmi = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < multi->num_clients; i++)
-		i2c_unregister_device(multi->clients[i]);
+	for (i = 0; i < bmi->i2c_num; i++)
+		i2c_unregister_device(bmi->i2c_devs[i]);
 
 	return 0;
 }
 
-static const struct i2c_inst_data bsg1160_data[]  = {
+static const struct bmi_instance bsg1160_data[]  = {
 	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
 	{ "bmc150_magn" },
 	{ "bmg160" },
 	{}
 };
 
-static const struct i2c_inst_data bsg2150_data[]  = {
+static const struct bmi_instance bsg2150_data[]  = {
 	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
 	{ "bmc150_magn" },
 	/* The resources describe a 3th client, but it is not really there. */
@@ -139,7 +138,7 @@ static const struct i2c_inst_data bsg2150_data[]  = {
 	{}
 };
 
-static const struct i2c_inst_data int3515_data[]  = {
+static const struct bmi_instance int3515_data[]  = {
 	{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
 	{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
 	{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
@@ -148,27 +147,27 @@ static const struct i2c_inst_data int3515_data[]  = {
 };
 
 /*
- * Note new device-ids must also be added to i2c_multi_instantiate_ids in
+ * Note new device-ids must also be added to bus_multi_instantiate_ids in
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
  */
-static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
+static const struct acpi_device_id bmi_acpi_ids[] = {
 	{ "BSG1160", (unsigned long)bsg1160_data },
 	{ "BSG2150", (unsigned long)bsg2150_data },
 	{ "INT3515", (unsigned long)int3515_data },
 	{ }
 };
-MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
+MODULE_DEVICE_TABLE(acpi, bmi_acpi_ids);
 
-static struct platform_driver i2c_multi_inst_driver = {
+static struct platform_driver bmi_driver = {
 	.driver	= {
-		.name = "I2C multi instantiate pseudo device driver",
-		.acpi_match_table = i2c_multi_inst_acpi_ids,
+		.name = "Bus multi instantiate pseudo device driver",
+		.acpi_match_table = bmi_acpi_ids,
 	},
-	.probe = i2c_multi_inst_probe,
-	.remove = i2c_multi_inst_remove,
+	.probe = bmi_probe,
+	.remove = bmi_remove,
 };
-module_platform_driver(i2c_multi_inst_driver);
+module_platform_driver(bmi_driver);
 
-MODULE_DESCRIPTION("I2C multi instantiate pseudo device driver");
+MODULE_DESCRIPTION("Bus multi instantiate pseudo device driver");
 MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e5c81b3df09c..969d8138d019 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1700,10 +1700,10 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * must be instantiated for each, each with its own i2c_device_id.
 	 * Normally we only instantiate an i2c-client for the first resource,
 	 * using the ACPI HID as id. These special cases are handled by the
-	 * drivers/acpi/i2c-multi-instantiate.c driver, which knows
+	 * drivers/acpi/bus-multi-instantiate.c driver, which knows
 	 * which i2c_device_id to use for each resource.
 	 */
-	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
+	static const struct acpi_device_id bus_multi_instantiate_ids[] = {
 		{"BSG1160", },
 		{"BSG2150", },
 		{"INT33FE", },
@@ -1721,8 +1721,8 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	     fwnode_property_present(&device->fwnode, "baud")))
 		return true;
 
-	/* Instantiate a pdev for the i2c-multi-instantiate drv to bind to */
-	if (!acpi_match_device_ids(device, i2c_multi_instantiate_ids))
+	/* Instantiate a pdev for the bus-multi-instantiate drv to bind to */
+	if (!acpi_match_device_ids(device, bus_multi_instantiate_ids))
 		return false;
 
 	INIT_LIST_HEAD(&resource_list);
-- 
2.25.1

