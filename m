Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489FC4963DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351628AbiAURZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:25:45 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:2506 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1351592AbiAURZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:25:40 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LH9VJJ024708;
        Fri, 21 Jan 2022 11:24:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=YQUCoSxP+9+eIv2ZAagiW/8KjNXA5jCZTnaLW1fzb9I=;
 b=JZqx2E8Yb9ujcCtG4N7fm5rIlFifKQjT2HEw8INQ2XwzH6DC1jWtHm/cPgmf1MBgbOGk
 VTus2ZPA0BQyuAJGO09983cELQP46BrbTd/ZSi2Y3UvGCFOrxI8XXVDOK7fFtKOdmTf5
 vdmziJnHbjhpgaRE3wVqUCgRNyFQMBUXaytxkhGGIymkA0novMXbzzHLO/kQKJUMH/FQ
 NCeszn7vBdDFM82CavSgAHFjmmgXAJ3LhKvo3ch0b2FNuG4lvpXu+bCRN7cJN3QGIEMQ
 NwGjAUdqWPdhEG++XppGGk8gkO3UfVi9nz/GgRc2WhYW87Xr2u3CQAMYnoi2gqFyYwIY GA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dqhyq14dj-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 11:24:54 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 17:24:52 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 17:24:52 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B8861B0E;
        Fri, 21 Jan 2022 17:24:51 +0000 (UTC)
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
Subject: [PATCH v6 6/9] platform/x86: serial-multi-instantiate: Reorganize I2C functions
Date:   Fri, 21 Jan 2022 17:24:28 +0000
Message-ID: <20220121172431.6876-7-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 91kiSRFsUrn1Ck8OkbH_3z_pV8Z3NCA3
X-Proofpoint-ORIG-GUID: 91kiSRFsUrn1Ck8OkbH_3z_pV8Z3NCA3
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Reorganize I2C functions to accommodate SPI support
Split the probe and factor out parts of the code
that will be used in the SPI support
Also switched from strlcpy() to strscpy()

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 .../platform/x86/serial-multi-instantiate.c   | 144 +++++++++++-------
 1 file changed, 90 insertions(+), 54 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 33cbb0caed33..4cd6d72a0741 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -29,96 +29,132 @@ struct smi_instance {
 
 struct smi {
 	int i2c_num;
-	struct i2c_client *i2c_devs[];
+	struct i2c_client **i2c_devs;
 };
 
-static int smi_probe(struct platform_device *pdev)
+static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
+		       const struct smi_instance *inst)
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
+		return 0;
+	}
+
+	if (ret < 0)
+		dev_err_probe(&pdev->dev, ret, "Error requesting irq at index %d: %d\n",
+			      inst->irq_idx, ret);
+
+	return ret;
+}
+
+static void smi_devs_unregister(struct smi *smi)
+{
+	while (smi->i2c_num > 0)
+		i2c_unregister_device(smi->i2c_devs[--smi->i2c_num]);
+}
+
+/**
+ * smi_i2c_probe - Instantiate multiple I2C devices from inst array
+ * @pdev:	Platform device
+ * @adev:	ACPI device
+ * @smi:	Internal struct for Serial multi instantiate driver
+ * @inst_array:	Array of instances to probe
+ *
+ * Returns the number of I2C devices instantiate, Zero if none is found or a negative error code.
+ */
+static int smi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev, struct smi *smi,
+			 const struct smi_instance *inst_array)
 {
 	struct i2c_board_info board_info = {};
-	const struct smi_instance *inst;
 	struct device *dev = &pdev->dev;
-	struct acpi_device *adev;
-	struct smi *smi;
 	char name[32];
-	int i, ret;
+	int i, ret, count;
 
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
 	if (ret < 0)
 		return ret;
+	else if (!ret)
+		return -ENODEV;
 
-	smi = devm_kmalloc(dev, struct_size(smi, i2c_devs, ret), GFP_KERNEL);
-	if (!smi)
-		return -ENOMEM;
+	count = ret;
 
-	smi->i2c_num = ret;
+	smi->i2c_devs = devm_kcalloc(dev, count, sizeof(*smi->i2c_devs), GFP_KERNEL);
+	if (!smi->i2c_devs)
+		return -ENOMEM;
 
-	for (i = 0; i < smi->i2c_num && inst[i].type; i++) {
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
+		ret = smi_get_irq(pdev, adev, &inst_array[i]);
+		if (ret < 0)
+			goto error;
+		board_info.irq = ret;
+
 		smi->i2c_devs[i] = i2c_acpi_new_device(dev, i, &board_info);
 		if (IS_ERR(smi->i2c_devs[i])) {
 			ret = dev_err_probe(dev, PTR_ERR(smi->i2c_devs[i]),
 					    "Error creating i2c-client, idx %d\n", i);
 			goto error;
 		}
+		smi->i2c_num++;
 	}
-	if (i < smi->i2c_num) {
-		dev_err(dev, "Error finding driver, idx %d\n", i);
+	if (smi->i2c_num < count) {
+		dev_dbg(dev, "Error finding driver, idx %d\n", i);
 		ret = -ENODEV;
 		goto error;
 	}
 
-	platform_set_drvdata(pdev, smi);
-	return 0;
+	dev_info(dev, "Instantiated %d I2C devices.\n", smi->i2c_num);
 
+	return 0;
 error:
-	while (--i >= 0)
-		i2c_unregister_device(smi->i2c_devs[i]);
+	smi_devs_unregister(smi);
 
 	return ret;
 }
 
+static int smi_probe(struct platform_device *pdev)
+{
+	const struct smi_instance *inst_array;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev;
+	struct smi *smi;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENODEV;
+
+	inst_array = device_get_match_data(dev);
+	if (!inst_array) {
+		dev_dbg(dev, "Error ACPI match data is missing\n");
+		return -ENODEV;
+	}
+
+	smi = devm_kzalloc(dev, sizeof(*smi), GFP_KERNEL);
+	if (!smi)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, smi);
+
+	return smi_i2c_probe(pdev, adev, smi, inst_array);
+}
+
 static int smi_remove(struct platform_device *pdev)
 {
 	struct smi *smi = platform_get_drvdata(pdev);
-	int i;
 
-	for (i = 0; i < smi->i2c_num; i++)
-		i2c_unregister_device(smi->i2c_devs[i]);
+	smi_devs_unregister(smi);
 
 	return 0;
 }
-- 
2.25.1

