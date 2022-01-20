Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E02494F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244019AbiATNoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:44:19 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:29056 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241423AbiATNoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:44:05 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K6iPZF000624;
        Thu, 20 Jan 2022 07:43:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=2uKaUsmBK/JS5c3fzdfTaeitNhcGMoHueBDg02mENRE=;
 b=HcL+nf4k4bMel0k1JhAeZOiDGZi/8VRYr3+5DjFAkHCwJKUs67cqPNBJFO+4kkx4Glfg
 IVc31d1lPtUBAsnCA+d7Rt77l7F8ay2T3Ysp+aVf4RpvlYUv29ied7p86F+rTziYludi
 45XzV1dFNQfWe5tWjNlnSnMNDCrwhOlhwuFMS2VICkhXLIGHAz0uYepSuvuP2fJHWjoC
 Z3bE3iKhUj01Xf1eINDqbE6HtjIfwNUdGOpAgSy49GGyRBXq8TmSfKDUFNnhnar+98gM
 N3rORXQEynwhQpJR8YUzgaGBg3uSI/8XT7eos6VMhG8O9o98iuR1z3QIgpkNOv7cunMl +A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dpms0h5y2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Jan 2022 07:43:45 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 13:43:42 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 20 Jan 2022 13:43:42 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E87AAB13;
        Thu, 20 Jan 2022 13:43:41 +0000 (UTC)
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
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 6/9] platform/x86: bus-multi-instantiate: Reorganize I2C functions
Date:   Thu, 20 Jan 2022 13:43:23 +0000
Message-ID: <20220120134326.5295-7-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
References: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sHmM3X3rXK1t09A_yfDPMDODFlg9TwrM
X-Proofpoint-GUID: sHmM3X3rXK1t09A_yfDPMDODFlg9TwrM
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Reorganize I2C functions to accommodate SPI support
Split the probe and factor out parts of the code
that will be used in the SPI support

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/platform/x86/bus-multi-instantiate.c | 150 ++++++++++++-------
 1 file changed, 96 insertions(+), 54 deletions(-)

diff --git a/drivers/platform/x86/bus-multi-instantiate.c b/drivers/platform/x86/bus-multi-instantiate.c
index 982dfecfd27c..50f1540762e9 100644
--- a/drivers/platform/x86/bus-multi-instantiate.c
+++ b/drivers/platform/x86/bus-multi-instantiate.c
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

