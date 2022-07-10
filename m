Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8223A56D173
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiGJVZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiGJVZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:25:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DA716581
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q9so4752605wrd.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdZqryGNMWnNyZeLlzRFuZV+IRU5vvwot+uqXNMaBz0=;
        b=8VaLIjdOhEoVsAbT2Fb30QXZPvqhkTqOiH/7Yw89gQXa2vBo5MldCLFNshwnSo/oyU
         ElVRrJCOiOA8pw28W5jtxJPAR29EWzXKxNQtta3+jmBRKGLZraM+g9mIRwg+Rda/1k53
         HGFka7VM97xC5qjLi6En3eoCAjZXd7nSejVNXUh3feC50vjzTQk4xFSS7RZRXdPLpjhO
         wd3+9gGlUti5JQoICH1s9DMwwh+BLJ9TgUqgcst1TKU1tPcF4dTSwZ0dHjwcWvKsVnpN
         s7DqFvik7QtpGwJiKEUFoNyM56pad1UbIHZx9XUjz3UiuPlQUSvAHeXNPPvgEA6Ylvnv
         BlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdZqryGNMWnNyZeLlzRFuZV+IRU5vvwot+uqXNMaBz0=;
        b=KLMf0sRfv3dCMwtu7N1YODliOJD0dRRc738UiFgDDryrGKQ9+cIl9CZCSVPnI3jr2R
         VuVMiNeebqm8kXENHb/U64csqAq1PdLLk8QU7s2V9Q/cI9ua2fipPOp7j1pM335qfBoR
         wvD7rf5X5B6gpua6JQ0KJUP3k0TQFw56PgqMT7EE8hv/ZzaUrvdekqM90W+7a4T/McY4
         JWFWuw9mUcszFVFl+z2Ijtn1hDxvOK0n9DdUe3y1MmgXqZOUaEuW31OiVsTo0ukEkseh
         aKyz4Ka4wFBMYlC+quibR1Xiv7h5ydGG+BrYUGKIhSZasNEhbmY31a2vtCkOsYnvirrZ
         ztiQ==
X-Gm-Message-State: AJIora/BUnsKqCNhLJ+Rdl8bm35CKWXz4ZWz/UoGGk6TaPOI/MuxmiYg
        vacZsoIn2WwGlS8drLBtRWMBJQ==
X-Google-Smtp-Source: AGRyM1trqFFqRWuC5BLpUAz8LI9O0XAgo8gykf7SBfBfpcZpdqcmj8kby/aaNgwsArwywzm9oD/vrA==
X-Received: by 2002:a5d:5903:0:b0:21d:6dd5:d9c3 with SMTP id v3-20020a5d5903000000b0021d6dd5d9c3mr13835071wrd.85.1657488297073;
        Sun, 10 Jul 2022 14:24:57 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v1 10/33] thermal/drivers/broadcom: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:00 +0200
Message-Id: <20220710212423.681301-11-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/broadcom/bcm2711_thermal.c | 14 +++---
 drivers/thermal/broadcom/brcmstb_thermal.c | 20 ++++-----
 drivers/thermal/broadcom/ns-thermal.c      | 50 +++++++++-------------
 drivers/thermal/broadcom/sr-thermal.c      | 16 +++----
 4 files changed, 46 insertions(+), 54 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index e9bef5c3414b..64d75593e760 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -31,11 +31,11 @@ struct bcm2711_thermal_priv {
 	struct thermal_zone_device *thermal;
 };
 
-static int bcm2711_get_temp(void *data, int *temp)
+static int bcm2711_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct bcm2711_thermal_priv *priv = data;
-	int slope = thermal_zone_get_slope(priv->thermal);
-	int offset = thermal_zone_get_offset(priv->thermal);
+	struct bcm2711_thermal_priv *priv = tz->devdata;
+	int slope = thermal_zone_get_slope(tz);
+	int offset = thermal_zone_get_offset(tz);
 	u32 val;
 	int ret;
 
@@ -54,7 +54,7 @@ static int bcm2711_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops bcm2711_thermal_of_ops = {
+static struct thermal_zone_device_ops bcm2711_thermal_of_ops = {
 	.get_temp	= bcm2711_get_temp,
 };
 
@@ -88,8 +88,8 @@ static int bcm2711_thermal_probe(struct platform_device *pdev)
 	}
 	priv->regmap = regmap;
 
-	thermal = devm_thermal_zone_of_sensor_register(dev, 0, priv,
-						       &bcm2711_thermal_of_ops);
+	thermal = devm_thermal_of_zone_register(dev, 0, priv,
+						&bcm2711_thermal_of_ops);
 	if (IS_ERR(thermal)) {
 		ret = PTR_ERR(thermal);
 		dev_err(dev, "could not register sensor: %d\n", ret);
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 0cedb8b4f00a..c459d14df3b5 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -105,7 +105,7 @@ static struct avs_tmon_trip avs_tmon_trips[] = {
 struct brcmstb_thermal_params {
 	unsigned int offset;
 	unsigned int mult;
-	const struct thermal_zone_of_device_ops *of_ops;
+	struct thermal_zone_device_ops *of_ops;
 };
 
 struct brcmstb_thermal_priv {
@@ -150,9 +150,9 @@ static inline u32 avs_tmon_temp_to_code(struct brcmstb_thermal_priv *priv,
 		return (u32)((offset - temp) / mult);
 }
 
-static int brcmstb_get_temp(void *data, int *temp)
+static int brcmstb_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct brcmstb_thermal_priv *priv = data;
+	struct brcmstb_thermal_priv *priv = tz->devdata;
 	u32 val;
 	long t;
 
@@ -260,9 +260,9 @@ static irqreturn_t brcmstb_tmon_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int brcmstb_set_trips(void *data, int low, int high)
+static int brcmstb_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct brcmstb_thermal_priv *priv = data;
+	struct brcmstb_thermal_priv *priv = tz->devdata;
 
 	dev_dbg(priv->dev, "set trips %d <--> %d\n", low, high);
 
@@ -288,7 +288,7 @@ static int brcmstb_set_trips(void *data, int low, int high)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops brcmstb_16nm_of_ops = {
+static struct thermal_zone_device_ops brcmstb_16nm_of_ops = {
 	.get_temp	= brcmstb_get_temp,
 };
 
@@ -298,7 +298,7 @@ static const struct brcmstb_thermal_params brcmstb_16nm_params = {
 	.of_ops	= &brcmstb_16nm_of_ops,
 };
 
-static const struct thermal_zone_of_device_ops brcmstb_28nm_of_ops = {
+static struct thermal_zone_device_ops brcmstb_28nm_of_ops = {
 	.get_temp	= brcmstb_get_temp,
 	.set_trips	= brcmstb_set_trips,
 };
@@ -318,7 +318,7 @@ MODULE_DEVICE_TABLE(of, brcmstb_thermal_id_table);
 
 static int brcmstb_thermal_probe(struct platform_device *pdev)
 {
-	const struct thermal_zone_of_device_ops *of_ops;
+	struct thermal_zone_device_ops *of_ops;
 	struct thermal_zone_device *thermal;
 	struct brcmstb_thermal_priv *priv;
 	struct resource *res;
@@ -341,8 +341,8 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 	of_ops = priv->temp_params->of_ops;
 
-	thermal = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv,
-						       of_ops);
+	thermal = devm_thermal_of_zone_register(&pdev->dev, 0, priv,
+						of_ops);
 	if (IS_ERR(thermal)) {
 		ret = PTR_ERR(thermal);
 		dev_err(&pdev->dev, "could not register sensor: %d\n", ret);
diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
index c9468ba9d449..b9c3f2306bf5 100644
--- a/drivers/thermal/broadcom/ns-thermal.c
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -14,19 +14,14 @@
 #define PVTMON_CONTROL0_SEL_TEST_MODE			0x0000000e
 #define PVTMON_STATUS					0x08
 
-struct ns_thermal {
-	struct thermal_zone_device *tz;
-	void __iomem *pvtmon;
-};
-
-static int ns_thermal_get_temp(void *data, int *temp)
+static int ns_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct ns_thermal *ns_thermal = data;
-	int offset = thermal_zone_get_offset(ns_thermal->tz);
-	int slope = thermal_zone_get_slope(ns_thermal->tz);
+	void __iomem *pvtmon = tz->devdata;
+	int offset = thermal_zone_get_offset(tz);
+	int slope = thermal_zone_get_slope(tz);
 	u32 val;
 
-	val = readl(ns_thermal->pvtmon + PVTMON_CONTROL0);
+	val = readl(pvtmon + PVTMON_CONTROL0);
 	if ((val & PVTMON_CONTROL0_SEL_MASK) != PVTMON_CONTROL0_SEL_TEMP_MONITOR) {
 		/* Clear current mode selection */
 		val &= ~PVTMON_CONTROL0_SEL_MASK;
@@ -34,50 +29,47 @@ static int ns_thermal_get_temp(void *data, int *temp)
 		/* Set temp monitor mode (it's the default actually) */
 		val |= PVTMON_CONTROL0_SEL_TEMP_MONITOR;
 
-		writel(val, ns_thermal->pvtmon + PVTMON_CONTROL0);
+		writel(val, pvtmon + PVTMON_CONTROL0);
 	}
 
-	val = readl(ns_thermal->pvtmon + PVTMON_STATUS);
+	val = readl(pvtmon + PVTMON_STATUS);
 	*temp = slope * val + offset;
 
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops ns_thermal_ops = {
+static struct thermal_zone_device_ops ns_thermal_ops = {
 	.get_temp = ns_thermal_get_temp,
 };
 
 static int ns_thermal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct ns_thermal *ns_thermal;
-
-	ns_thermal = devm_kzalloc(dev, sizeof(*ns_thermal), GFP_KERNEL);
-	if (!ns_thermal)
-		return -ENOMEM;
+	struct thermal_zone_device *tz;
+	void __iomem *pvtmon;
 
-	ns_thermal->pvtmon = of_iomap(dev_of_node(dev), 0);
-	if (WARN_ON(!ns_thermal->pvtmon))
+	pvtmon = of_iomap(dev_of_node(dev), 0);
+	if (WARN_ON(!pvtmon))
 		return -ENOENT;
 
-	ns_thermal->tz = devm_thermal_zone_of_sensor_register(dev, 0,
-							      ns_thermal,
-							      &ns_thermal_ops);
-	if (IS_ERR(ns_thermal->tz)) {
-		iounmap(ns_thermal->pvtmon);
-		return PTR_ERR(ns_thermal->tz);
+	tz = devm_thermal_of_zone_register(dev, 0,
+					   pvtmon,
+					   &ns_thermal_ops);
+	if (IS_ERR(tz)) {
+		iounmap(pvtmon);
+		return PTR_ERR(tz);
 	}
 
-	platform_set_drvdata(pdev, ns_thermal);
+	platform_set_drvdata(pdev, pvtmon);
 
 	return 0;
 }
 
 static int ns_thermal_remove(struct platform_device *pdev)
 {
-	struct ns_thermal *ns_thermal = platform_get_drvdata(pdev);
+	void __iomem *pvtmon = platform_get_drvdata(pdev);
 
-	iounmap(ns_thermal->pvtmon);
+	iounmap(pvtmon);
 
 	return 0;
 }
diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
index 85ab9edd580c..7c58eff407b3 100644
--- a/drivers/thermal/broadcom/sr-thermal.c
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -19,7 +19,6 @@
 #define SR_TMON_MAX_LIST        6
 
 struct sr_tmon {
-	struct thermal_zone_device *tz;
 	unsigned int crit_temp;
 	unsigned int tmon_id;
 	struct sr_thermal *priv;
@@ -31,9 +30,9 @@ struct sr_thermal {
 	struct sr_tmon tmon[SR_TMON_MAX_LIST];
 };
 
-static int sr_get_temp(void *data, int *temp)
+static int sr_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sr_tmon *tmon = data;
+	struct sr_tmon *tmon = tz->devdata;
 	struct sr_thermal *sr_thermal = tmon->priv;
 
 	*temp = readl(sr_thermal->regs + SR_TMON_TEMP_BASE(tmon->tmon_id));
@@ -41,13 +40,14 @@ static int sr_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops sr_tz_ops = {
+static struct thermal_zone_device_ops sr_tz_ops = {
 	.get_temp = sr_get_temp,
 };
 
 static int sr_thermal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct thermal_zone_device *tz;
 	struct sr_thermal *sr_thermal;
 	struct sr_tmon *tmon;
 	struct resource *res;
@@ -84,10 +84,10 @@ static int sr_thermal_probe(struct platform_device *pdev)
 		writel(0, sr_thermal->regs + SR_TMON_TEMP_BASE(i));
 		tmon->tmon_id = i;
 		tmon->priv = sr_thermal;
-		tmon->tz = devm_thermal_zone_of_sensor_register(dev, i, tmon,
-								&sr_tz_ops);
-		if (IS_ERR(tmon->tz))
-			return PTR_ERR(tmon->tz);
+		tz = devm_thermal_of_zone_register(dev, i, tmon,
+						   &sr_tz_ops);
+		if (IS_ERR(tz))
+			return PTR_ERR(tz);
 
 		dev_dbg(dev, "thermal sensor %d registered\n", i);
 	}
-- 
2.25.1

