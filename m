Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0630647042F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbhLJPp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:45:56 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:14550 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243024AbhLJPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:45:46 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BACurAU000494;
        Fri, 10 Dec 2021 09:42:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=FAuO5CZBOczv5RqUZtQr/W5GrYjfZN+iXeYTP1rRIUQ=;
 b=WcZG/VK0y16CkGxhDv7Eji5bnQxHejLLECIJeMI3YejF/JVm4U/RA4nC3rHQX8z6XMkD
 QXulPcOp9JR8pGAyXv5Kf8udYQ+MSF8DRw4ytim4hQfpqcY6LcyMWExV/2gnxZYWBzb2
 IhFOoo/m3ME9J7yhIoqg5qsvHD+d+1ZUrpKhfI9E0j3ofko1h7KtKSHKar+/FCn66oDZ
 C0iZ7mnQyk6j6AqEwS+x/p5RAkMCjEskI4axk/e4uMS/K+5F774Cf8lATgZkIGG3zS6k
 nyUnWP0S+GXxBJhvL5q6toW8B7mnmygYnIEzCdMTp84dAdqn4yLreN+zGalatI7Gamns ZA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cuds09y4q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Dec 2021 09:42:01 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 15:41:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Dec 2021 15:41:58 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ABCAFB10;
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
Subject: [PATCH v2 5/6] ACPI: bus-multi-instantiate: Reorganize I2C functions
Date:   Fri, 10 Dec 2021 15:40:49 +0000
Message-ID: <20211210154050.3713-6-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: H9MR6W6Y0G9arjluncJm8D5o_EzWnd-X
X-Proofpoint-ORIG-GUID: H9MR6W6Y0G9arjluncJm8D5o_EzWnd-X
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Reorganize I2C functions to accommodate SPI support
Split the probe and factor out parts of the code
that will be used in the SPI support

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/acpi/bus-multi-instantiate.c | 150 +++++++++++++++++----------
 1 file changed, 96 insertions(+), 54 deletions(-)

diff --git a/drivers/acpi/bus-multi-instantiate.c b/drivers/acpi/bus-multi-instantiate.c
index 982dfecfd27c..50f1540762e9 100644
--- a/drivers/acpi/bus-multi-instantiate.c
+++ b/drivers/acpi/bus-multi-instantiate.c
@@ -29,85 +29,129 @@ struct bmi_instance {
 
 struct bmi {
 	int i2c_num;
-	struct i2c_client *i2c_devs[];
+	struct i2c_client **i2c_devs;
 };
 
-static int bmi_probe(struct platform_device *pdev)
+static int bmi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
+		       const struct bmi_instance *inst)
+{
+	int ret;
+
+	switch (inst->flags & IRQ_RESOURCE_TYPE) {
+	case IRQ_RESOURCE_GPIO:
+		ret = acpi_dev_gpio_irq_get(adev, inst->irq_idx);
+		break;
+	case IRQ_RESOURCE_APIC:
+		ret = platform_get_irq(pdev, inst->irq_idx);
+		break;
+	default:
+		ret = 0;
+		break;
+	}
+
+	if (ret < 0)
+		dev_err_probe(&pdev->dev, ret, "Error requesting irq at index %d: %d\n",
+			      inst->irq_idx, ret);
+
+	return ret;
+}
+
+static void bmi_devs_unregister(struct bmi *bmi)
+{
+	while (bmi->i2c_num > 0)
+		i2c_unregister_device(bmi->i2c_devs[--bmi->i2c_num]);
+}
+
+/**
+ * bmi_i2c_probe - Instantiate multiple I2C devices from inst array
+ * @pdev:	Platform device
+ * @adev:	ACPI device
+ * @bmi:	Internal struct for Bus multi instantiate driver
+ * @inst:	Array of instances to probe
+ *
+ * Returns the number of I2C devices instantiate, Zero if none is found or a negative error code.
+ */
+static int bmi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev, struct bmi *bmi,
+			 const struct bmi_instance *inst_array)
 {
 	struct i2c_board_info board_info = {};
-	const struct bmi_instance *inst;
 	struct device *dev = &pdev->dev;
-	struct acpi_device *adev;
-	struct bmi *bmi;
 	char name[32];
-	int i, ret;
+	int i, ret = 0, count;
 
-	inst = device_get_match_data(dev);
-	if (!inst) {
-		dev_err(dev, "Error ACPI match data is missing\n");
-		return -ENODEV;
-	}
-
-	adev = ACPI_COMPANION(dev);
-
-	/* Count number of clients to instantiate */
 	ret = i2c_acpi_client_count(adev);
-	if (ret < 0)
+	if (ret <= 0)
 		return ret;
+	count = ret;
 
-	bmi = devm_kmalloc(dev, struct_size(bmi, i2c_devs, ret), GFP_KERNEL);
-	if (!bmi)
+	bmi->i2c_devs = devm_kcalloc(dev, count, sizeof(*bmi->i2c_devs), GFP_KERNEL);
+	if (!bmi->i2c_devs)
 		return -ENOMEM;
 
-	bmi->i2c_num = ret;
-
-	for (i = 0; i < bmi->i2c_num && inst[i].type; i++) {
+	for (i = 0; i < count && inst_array[i].type; i++) {
 		memset(&board_info, 0, sizeof(board_info));
-		strlcpy(board_info.type, inst[i].type, I2C_NAME_SIZE);
-		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst[i].type, i);
+		strscpy(board_info.type, inst_array[i].type, I2C_NAME_SIZE);
+		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst_array[i].type, i);
 		board_info.dev_name = name;
-		switch (inst[i].flags & IRQ_RESOURCE_TYPE) {
-		case IRQ_RESOURCE_GPIO:
-			ret = acpi_dev_gpio_irq_get(adev, inst[i].irq_idx);
-			if (ret < 0) {
-				dev_err(dev, "Error requesting irq at index %d: %d\n",
-						inst[i].irq_idx, ret);
-				goto error;
-			}
-			board_info.irq = ret;
-			break;
-		case IRQ_RESOURCE_APIC:
-			ret = platform_get_irq(pdev, inst[i].irq_idx);
-			if (ret < 0) {
-				dev_dbg(dev, "Error requesting irq at index %d: %d\n",
-					inst[i].irq_idx, ret);
-				goto error;
-			}
-			board_info.irq = ret;
-			break;
-		default:
-			board_info.irq = 0;
-			break;
-		}
+
+		ret = bmi_get_irq(pdev, adev, &inst_array[i]);
+		if (ret < 0)
+			goto error;
+		board_info.irq = ret;
+
 		bmi->i2c_devs[i] = i2c_acpi_new_device(dev, i, &board_info);
 		if (IS_ERR(bmi->i2c_devs[i])) {
 			ret = dev_err_probe(dev, PTR_ERR(bmi->i2c_devs[i]),
 					    "Error creating i2c-client, idx %d\n", i);
 			goto error;
 		}
+		bmi->i2c_num++;
 	}
-	if (i < bmi->i2c_num) {
+	if (bmi->i2c_num < count) {
 		dev_err(dev, "Error finding driver, idx %d\n", i);
 		ret = -ENODEV;
 		goto error;
 	}
 
-	platform_set_drvdata(pdev, bmi);
-	return 0;
+	dev_info(dev, "Instantiate %d I2C devices.\n", bmi->i2c_num);
 
+	return bmi->i2c_num;
 error:
-	while (--i >= 0)
-		i2c_unregister_device(bmi->i2c_devs[i]);
+	dev_err_probe(dev, ret, "I2C error %d\n", ret);
+	bmi_devs_unregister(bmi);
+
+	return ret;
+}
+
+static int bmi_probe(struct platform_device *pdev)
+{
+	const struct bmi_instance *inst_array;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev;
+	struct bmi *bmi;
+	int ret;
+
+	inst_array = device_get_match_data(dev);
+	if (!inst_array) {
+		dev_err(dev, "Error ACPI match data is missing\n");
+		return -ENODEV;
+	}
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENODEV;
+
+	bmi = devm_kzalloc(dev, sizeof(*bmi), GFP_KERNEL);
+	if (!bmi)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, bmi);
+
+	ret = bmi_i2c_probe(pdev, adev, bmi, inst_array);
+	if (ret > 0)
+		return 0;
+	if (ret == 0)
+		ret = -ENODEV;
 
 	return ret;
 }
@@ -115,10 +159,8 @@ static int bmi_probe(struct platform_device *pdev)
 static int bmi_remove(struct platform_device *pdev)
 {
 	struct bmi *bmi = platform_get_drvdata(pdev);
-	int i;
 
-	for (i = 0; i < bmi->i2c_num; i++)
-		i2c_unregister_device(bmi->i2c_devs[i]);
+	bmi_devs_unregister(bmi);
 
 	return 0;
 }
-- 
2.25.1

