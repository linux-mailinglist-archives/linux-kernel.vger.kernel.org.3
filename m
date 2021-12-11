Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205314710D6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 03:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244430AbhLKC0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 21:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244286AbhLKC0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 21:26:12 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCFCC061714
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:22:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g14so34521663edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f1x0MbbgLdCM6zVNKS7k9IWs8Jj79v34SDtWcRNU2QM=;
        b=Uk0/slH5gDlxtJyWtvLCaRK7z+lTZCSIKQx94LFnG7kqtdyIiBHyFZT+a2LD1k64p+
         +pK+PnQR1uGQnVH3+Ost6iMDCSpmfO7pG0100NE++esjR3Yu2lPDwkSOi5+xWP8V/q/K
         AP+FbYlODddLGKdqns3jLE034aXT1qst8gFgE68/o5OfdAiPBO15qwgkczoLMO2DUi6A
         6tOzRloRLEGGu6UAsB0j1mEObMlpZoUwMN5l0sL+fieyOsQl0wIO9op988Pi+jaRbGJI
         rNFpJ0j3kov9FEUvK01e4QrwpXHWjlIIpgMxsW0KdrHDxhIM6ICqAoqbfybCFHU0VofH
         lrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f1x0MbbgLdCM6zVNKS7k9IWs8Jj79v34SDtWcRNU2QM=;
        b=WIG3JJcW28WWptj+Jf6dA9IuiLwAVJbd4eVHC4y24/P7ljKuGUBGDh0ahR/yCLK8Hz
         7UqQkdpW3u5BI1yicvzWZ2cj5GToVEL34APnHM9Gs1sPiv4ar7r4lg5RjufJVV9bFvR/
         GrWpYMyx5LQnb3MQDT8is/HkKRxKOzdayTLopR/PKSqJnP6yquWc7fr6gjMfbxSstkeQ
         UotwbEmq+NSxGghhswOPOGbhEbTWVAjht8sDC3TyZgAaU5fqT6ZkYEaYIQqvjMjESw05
         bxOfS1z95u0OUg6Ku996AiU8jeISrPV8QDfgHMF7lvsU6f6w+Jtwyq2gH6J5Q9FzyIoE
         P8aA==
X-Gm-Message-State: AOAM5338PxIk3MQR/xTiy8snOTP2423hm+9VHzAf5eTJVSlNeBrHPSic
        P1buBeEQcw/MMNFrN9h3eKK9Ww==
X-Google-Smtp-Source: ABdhPJzw9c46mfaEVH3U66ry5LxpbGmsr36tO2Ven7s10p8RAzNZii19O3EReSExLtzG+10SZ9OKLw==
X-Received: by 2002:a17:906:2c16:: with SMTP id e22mr28628603ejh.501.1639189354779;
        Fri, 10 Dec 2021 18:22:34 -0800 (PST)
Received: from lion.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id s2sm2449424ejn.96.2021.12.10.18.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:22:34 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
X-Google-Original-From: Caleb Connolly <caleb@connolly.tech>
To:     caleb.connolly@linaro.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/7] mfd: qcom-spmi-pmic: expose the PMIC revid information to clients
Date:   Sat, 11 Dec 2021 02:22:18 +0000
Message-Id: <20211211022224.3488860-2-caleb@connolly.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211211022224.3488860-1-caleb@connolly.tech>
References: <20211211022224.3488860-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Caleb Connolly <caleb.connolly@linaro.org>

Some PMIC functions such as the RRADC need to be aware of the PMIC
chip revision information to implement errata or otherwise adjust
behaviour, export the PMIC information to enable this.

This is specifically required to enable the RRADC to adjust
coefficients based on which chip fab the PMIC was produced in,
this can vary per unique device and therefore has to be read at
runtime.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mfd/qcom-spmi-pmic.c | 103 +++++++++++++++++------------------
 include/soc/qcom/qcom-pmic.h |  58 ++++++++++++++++++++
 2 files changed, 108 insertions(+), 53 deletions(-)
 create mode 100644 include/soc/qcom/qcom-pmic.h

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index 1cacc00aa6c9..78530c1aca4b 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -3,51 +3,25 @@
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/device.h>
+#include <linux/gfp.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/spmi.h>
+#include <linux/string.h>
 #include <linux/regmap.h>
 #include <linux/of_platform.h>
+#include <soc/qcom/qcom-pmic.h>
 
 #define PMIC_REV2		0x101
 #define PMIC_REV3		0x102
 #define PMIC_REV4		0x103
 #define PMIC_TYPE		0x104
 #define PMIC_SUBTYPE		0x105
-
+#define PMIC_FAB_ID		0x1f2
 #define PMIC_TYPE_VALUE		0x51
 
-#define COMMON_SUBTYPE		0x00
-#define PM8941_SUBTYPE		0x01
-#define PM8841_SUBTYPE		0x02
-#define PM8019_SUBTYPE		0x03
-#define PM8226_SUBTYPE		0x04
-#define PM8110_SUBTYPE		0x05
-#define PMA8084_SUBTYPE		0x06
-#define PMI8962_SUBTYPE		0x07
-#define PMD9635_SUBTYPE		0x08
-#define PM8994_SUBTYPE		0x09
-#define PMI8994_SUBTYPE		0x0a
-#define PM8916_SUBTYPE		0x0b
-#define PM8004_SUBTYPE		0x0c
-#define PM8909_SUBTYPE		0x0d
-#define PM8028_SUBTYPE		0x0e
-#define PM8901_SUBTYPE		0x0f
-#define PM8950_SUBTYPE		0x10
-#define PMI8950_SUBTYPE		0x11
-#define PM8998_SUBTYPE		0x14
-#define PMI8998_SUBTYPE		0x15
-#define PM8005_SUBTYPE		0x18
-#define PM660L_SUBTYPE		0x1A
-#define PM660_SUBTYPE		0x1B
-#define PM8150_SUBTYPE		0x1E
-#define PM8150L_SUBTYPE		0x1f
-#define PM8150B_SUBTYPE		0x20
-#define PMK8002_SUBTYPE		0x21
-#define PM8009_SUBTYPE		0x24
-#define PM8150C_SUBTYPE		0x26
-#define SMB2351_SUBTYPE		0x29
-
 static const struct of_device_id pmic_spmi_id_table[] = {
 	{ .compatible = "qcom,pm660",     .data = (void *)PM660_SUBTYPE },
 	{ .compatible = "qcom,pm660l",    .data = (void *)PM660L_SUBTYPE },
@@ -81,57 +55,64 @@ static const struct of_device_id pmic_spmi_id_table[] = {
 	{ }
 };
 
-static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
+static void pmic_spmi_load_revid(struct regmap *map, struct device *dev,
+				 struct qcom_spmi_pmic *pmic)
 {
-	unsigned int rev2, minor, major, type, subtype;
-	const char *name = "unknown";
 	int ret, i;
 
-	ret = regmap_read(map, PMIC_TYPE, &type);
+	ret = regmap_read(map, PMIC_TYPE, &pmic->type);
 	if (ret < 0)
 		return;
 
-	if (type != PMIC_TYPE_VALUE)
+	if (pmic->type != PMIC_TYPE_VALUE)
 		return;
 
-	ret = regmap_read(map, PMIC_SUBTYPE, &subtype);
+	ret = regmap_read(map, PMIC_SUBTYPE, &pmic->subtype);
 	if (ret < 0)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(pmic_spmi_id_table); i++) {
-		if (subtype == (unsigned long)pmic_spmi_id_table[i].data)
+		if (pmic->subtype == (unsigned long)pmic_spmi_id_table[i].data)
 			break;
 	}
 
-	if (i != ARRAY_SIZE(pmic_spmi_id_table))
-		name = pmic_spmi_id_table[i].compatible;
+	if (i != ARRAY_SIZE(pmic_spmi_id_table)) {
+		pmic->name = kmalloc(strlen(pmic_spmi_id_table[i].compatible),
+			GFP_KERNEL);
+		strncpy(pmic->name, pmic_spmi_id_table[i].compatible,
+			strlen(pmic_spmi_id_table[i].compatible));
+	}
 
-	ret = regmap_read(map, PMIC_REV2, &rev2);
+	ret = regmap_read(map, PMIC_REV2, &pmic->rev2);
 	if (ret < 0)
 		return;
 
-	ret = regmap_read(map, PMIC_REV3, &minor);
+	ret = regmap_read(map, PMIC_REV3, &pmic->minor);
 	if (ret < 0)
 		return;
 
-	ret = regmap_read(map, PMIC_REV4, &major);
+	ret = regmap_read(map, PMIC_REV4, &pmic->major);
 	if (ret < 0)
 		return;
 
+	if (pmic->subtype == PMI8998_SUBTYPE || pmic->subtype == PM660_SUBTYPE) {
+		ret = regmap_read(map, PMIC_FAB_ID, &pmic->fab_id);
+		if (ret < 0)
+			return;
+	}
+
 	/*
 	 * In early versions of PM8941 and PM8226, the major revision number
 	 * started incrementing from 0 (eg 0 = v1.0, 1 = v2.0).
 	 * Increment the major revision number here if the chip is an early
 	 * version of PM8941 or PM8226.
 	 */
-	if ((subtype == PM8941_SUBTYPE || subtype == PM8226_SUBTYPE) &&
-	    major < 0x02)
-		major++;
-
-	if (subtype == PM8110_SUBTYPE)
-		minor = rev2;
+	if ((pmic->subtype == PM8941_SUBTYPE || pmic->subtype == PM8226_SUBTYPE) &&
+	    pmic->major < 0x02)
+		pmic->major++;
 
-	dev_dbg(dev, "%x: %s v%d.%d\n", subtype, name, major, minor);
+	if (pmic->subtype == PM8110_SUBTYPE)
+		pmic->minor = pmic->rev2;
 }
 
 static const struct regmap_config spmi_regmap_config = {
@@ -144,22 +125,38 @@ static const struct regmap_config spmi_regmap_config = {
 static int pmic_spmi_probe(struct spmi_device *sdev)
 {
 	struct regmap *regmap;
+	struct qcom_spmi_pmic *pmic;
 
 	regmap = devm_regmap_init_spmi_ext(sdev, &spmi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	pmic = devm_kzalloc(&sdev->dev, sizeof(*pmic), GFP_KERNEL);
+	if (!pmic)
+		return -ENOMEM;
+
 	/* Only the first slave id for a PMIC contains this information */
-	if (sdev->usid % 2 == 0)
-		pmic_spmi_show_revid(regmap, &sdev->dev);
+	if (sdev->usid % 2 == 0) {
+		pmic_spmi_load_revid(regmap, &sdev->dev, pmic);
+		spmi_device_set_drvdata(sdev, pmic);
+		qcom_pmic_print_info(&sdev->dev, pmic);
+	}
 
 	return devm_of_platform_populate(&sdev->dev);
 }
 
+static void pmic_spmi_remove(struct spmi_device *sdev)
+{
+	struct qcom_spmi_pmic *pmic = spmi_device_get_drvdata(sdev);
+
+	kfree(pmic->name);
+}
+
 MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
 
 static struct spmi_driver pmic_spmi_driver = {
 	.probe = pmic_spmi_probe,
+	.remove = pmic_spmi_remove,
 	.driver = {
 		.name = "pmic-spmi",
 		.of_match_table = pmic_spmi_id_table,
diff --git a/include/soc/qcom/qcom-pmic.h b/include/soc/qcom/qcom-pmic.h
new file mode 100644
index 000000000000..bf87a4f2de6a
--- /dev/null
+++ b/include/soc/qcom/qcom-pmic.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2021 Linaro. All rights reserved.
+ * Copyright (c) 2021 Caleb Connolly <caleb.connolly@linaro.org>
+ */
+
+#define COMMON_SUBTYPE		0x00
+#define PM8941_SUBTYPE		0x01
+#define PM8841_SUBTYPE		0x02
+#define PM8019_SUBTYPE		0x03
+#define PM8226_SUBTYPE		0x04
+#define PM8110_SUBTYPE		0x05
+#define PMA8084_SUBTYPE		0x06
+#define PMI8962_SUBTYPE		0x07
+#define PMD9635_SUBTYPE		0x08
+#define PM8994_SUBTYPE		0x09
+#define PMI8994_SUBTYPE		0x0a
+#define PM8916_SUBTYPE		0x0b
+#define PM8004_SUBTYPE		0x0c
+#define PM8909_SUBTYPE		0x0d
+#define PM8028_SUBTYPE		0x0e
+#define PM8901_SUBTYPE		0x0f
+#define PM8950_SUBTYPE		0x10
+#define PMI8950_SUBTYPE		0x11
+#define PM8998_SUBTYPE		0x14
+#define PMI8998_SUBTYPE		0x15
+#define PM8005_SUBTYPE		0x18
+#define PM660L_SUBTYPE		0x1A
+#define PM660_SUBTYPE		0x1B
+#define PM8150_SUBTYPE		0x1E
+#define PM8150L_SUBTYPE		0x1f
+#define PM8150B_SUBTYPE		0x20
+#define PMK8002_SUBTYPE		0x21
+#define PM8009_SUBTYPE		0x24
+#define PM8150C_SUBTYPE		0x26
+#define SMB2351_SUBTYPE		0x29
+
+#define PMI8998_FAB_ID_SMIC	0x11
+#define PMI8998_FAB_ID_GF	0x30
+
+#define PM660_FAB_ID_GF		0x0
+#define PM660_FAB_ID_TSMC	0x2
+#define PM660_FAB_ID_MX		0x3
+
+struct qcom_spmi_pmic {
+	unsigned int type;
+	unsigned int subtype;
+	unsigned int major;
+	unsigned int minor;
+	unsigned int rev2;
+	unsigned int fab_id;
+	char *name;
+};
+
+inline void qcom_pmic_print_info(struct device *dev, struct qcom_spmi_pmic *pmic)
+{
+	dev_info(dev, "%x: %s v%d.%d\n",
+		pmic->subtype, pmic->name, pmic->major, pmic->minor);
+}
-- 
2.34.1

