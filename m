Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617594868AF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbiAFRcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241962AbiAFRby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:31:54 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193BCC034000
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:31:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q8so6161850wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sCt1j81wCP4UN2kM5yRhlJdHRsU1cx9asSc64DRuMM=;
        b=P0VbTwMvLLENpIJt9cnBAc/FIfFhVMglEg1zWgs4Mc7xw2d35fxFS7F6Hc6XECqcQr
         VpWmFATm+EP+tRYx7OQwhLp0MPjgVQ6FoMS1vB1FEdzVOQ8qFpWCI+sIeZa/2L7GnYHM
         bpTPxNVGHs7DgBZ5e3sW1viY7gf6fM52TskQdvUuzMcQPW1tZhTzbEKjVCxOegv/tUGa
         H6BS0to2hZ+AuYnMvKgXHWKohpNODhqL+27vGWanxl2BR2oKEIRl2NG1o7ZW/quVXFwE
         EVgZs7gXFn1B4Zai9y4TA+IwWxojpq2koeA3DiIjJ2l0SGpVsNcXXfhQ8faj11pSoE3/
         asrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sCt1j81wCP4UN2kM5yRhlJdHRsU1cx9asSc64DRuMM=;
        b=J/MFt3JBEMS2k/MmP9rNIZE+Aw13XcAS6zUv3fOw4RJ+VGJuwscehWHZcA5Wnbrs0U
         49BnwZCviYoY9eVBlRJFvvZ7LrvdVsyOVTcLFNoXNudp++4RHaExr4CFTihv/EawfgPP
         uLZC6uqxMHzDecY3K7bse8q+Wm80L2roqlbq90th8sUTLGqTZlwTu9/P/fmts2ARQhxe
         Rq9fWc6jOUFkfMRwfmByza+uV7+bT9LYXfLJYIkKJXnp2jQO8S7MPWMNYMv5pzQxQhH9
         ilUyCkHldHnQeeaMZsojEwO2dDzWBTDaSL5iygfTQLeIlKwlgUQqlDgs/SnFS5Eg8RI7
         dpJA==
X-Gm-Message-State: AOAM530335QgXxiiKkW7kIRJcDHzxJ3j52dUcT/Rt9D2HrFV160GakJq
        vv2rewhShBkt0HzxEmsQdYwnkA==
X-Google-Smtp-Source: ABdhPJyhCAr9o27Bjwlo3S67cg7MIsFNj6YkSHyNEUAET8KVcpgKp18907IpNXmubSGwk8q2+yzTig==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr2232639wrv.225.1641490310610;
        Thu, 06 Jan 2022 09:31:50 -0800 (PST)
Received: from localhost.localdomain ([81.178.195.252])
        by smtp.gmail.com with ESMTPSA id b16sm2575594wmq.41.2022.01.06.09.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:31:50 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: [PATCH v3 1/7] mfd: qcom-spmi-pmic: expose the PMIC revid information to clients
Date:   Thu,  6 Jan 2022 17:31:25 +0000
Message-Id: <20220106173131.3279580-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106173131.3279580-1-caleb.connolly@linaro.org>
References: <20220106173131.3279580-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PMIC functions such as the RRADC need to be aware of the PMIC
chip revision information to implement errata or otherwise adjust
behaviour, export the PMIC information to enable this.

This is specifically required to enable the RRADC to adjust
coefficients based on which chip fab the PMIC was produced in,
this can vary per unique device and therefore has to be read at
runtime.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mfd/qcom-spmi-pmic.c | 108 +++++++++++++++++------------------
 include/soc/qcom/qcom-pmic.h |  63 ++++++++++++++++++++
 2 files changed, 114 insertions(+), 57 deletions(-)
 create mode 100644 include/soc/qcom/qcom-pmic.h

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index 1cacc00aa6c9..6b75c2f52b74 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -3,51 +3,24 @@
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/device.h>
+#include <linux/gfp.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/spmi.h>
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
@@ -81,42 +54,47 @@ static const struct of_device_id pmic_spmi_id_table[] = {
 	{ }
 };
 
-static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
+static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,
+				 struct qcom_spmi_pmic *pmic)
 {
-	unsigned int rev2, minor, major, type, subtype;
-	const char *name = "unknown";
 	int ret, i;
 
-	ret = regmap_read(map, PMIC_TYPE, &type);
+	ret = regmap_read(map, PMIC_TYPE, &pmic->type);
 	if (ret < 0)
-		return;
+		return ret;
 
-	if (type != PMIC_TYPE_VALUE)
-		return;
+	if (pmic->type != PMIC_TYPE_VALUE)
+		return ret;
 
-	ret = regmap_read(map, PMIC_SUBTYPE, &subtype);
+	ret = regmap_read(map, PMIC_SUBTYPE, &pmic->subtype);
 	if (ret < 0)
-		return;
+		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(pmic_spmi_id_table); i++) {
-		if (subtype == (unsigned long)pmic_spmi_id_table[i].data)
+		if (pmic->subtype == (unsigned long)pmic_spmi_id_table[i].data)
 			break;
 	}
 
 	if (i != ARRAY_SIZE(pmic_spmi_id_table))
-		name = pmic_spmi_id_table[i].compatible;
+		pmic->name = devm_kstrdup_const(dev, pmic_spmi_id_table[i].compatible, GFP_KERNEL);
 
-	ret = regmap_read(map, PMIC_REV2, &rev2);
+	ret = regmap_read(map, PMIC_REV2, &pmic->rev2);
 	if (ret < 0)
-		return;
+		return ret;
 
-	ret = regmap_read(map, PMIC_REV3, &minor);
+	ret = regmap_read(map, PMIC_REV3, &pmic->minor);
 	if (ret < 0)
-		return;
+		return ret;
 
-	ret = regmap_read(map, PMIC_REV4, &major);
+	ret = regmap_read(map, PMIC_REV4, &pmic->major);
 	if (ret < 0)
-		return;
+		return ret;
+
+	if (pmic->subtype == PMI8998_SUBTYPE || pmic->subtype == PM660_SUBTYPE) {
+		ret = regmap_read(map, PMIC_FAB_ID, &pmic->fab_id);
+		if (ret < 0)
+			return ret;
+	}
 
 	/*
 	 * In early versions of PM8941 and PM8226, the major revision number
@@ -124,14 +102,14 @@ static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
 	 * Increment the major revision number here if the chip is an early
 	 * version of PM8941 or PM8226.
 	 */
-	if ((subtype == PM8941_SUBTYPE || subtype == PM8226_SUBTYPE) &&
-	    major < 0x02)
-		major++;
+	if ((pmic->subtype == PM8941_SUBTYPE || pmic->subtype == PM8226_SUBTYPE) &&
+	    pmic->major < 0x02)
+		pmic->major++;
 
-	if (subtype == PM8110_SUBTYPE)
-		minor = rev2;
+	if (pmic->subtype == PM8110_SUBTYPE)
+		pmic->minor = pmic->rev2;
 
-	dev_dbg(dev, "%x: %s v%d.%d\n", subtype, name, major, minor);
+	return 0;
 }
 
 static const struct regmap_config spmi_regmap_config = {
@@ -144,22 +122,38 @@ static const struct regmap_config spmi_regmap_config = {
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
index 000000000000..59114988582d
--- /dev/null
+++ b/include/soc/qcom/qcom-pmic.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2021 Linaro. All rights reserved.
+ * Copyright (c) 2021 Caleb Connolly <caleb.connolly@linaro.org>
+ */
+
+#ifndef __QCOM_PMIC_H__
+#define __QCOM_PMIC_H__
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
+	const char *name;
+};
+
+static inline void qcom_pmic_print_info(struct device *dev, struct qcom_spmi_pmic *pmic)
+{
+	dev_info(dev, "%x: %s v%d.%d\n",
+		pmic->subtype, pmic->name, pmic->major, pmic->minor);
+}
+
+#endif /* __QCOM_PMIC_H__ */
-- 
2.34.1

