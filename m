Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848BF580696
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiGYV2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbiGYV1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:27:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAB024BDD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d13so10055350wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ApxyJvlL0EgkjxePD3esAQ9IvkzW++CVryyDi4r5gNo=;
        b=QTM80UlZEVlIMqYOokDPF8R5L8oC/ws6qivuyrx2062u+Gxq95COLZf9QDnTmjohHv
         jdhWaTRfG/YNwAnWDNNA+cqrrtQDjA1jeRS9vAbQzq0/4LfujFvGQW1mdrhtLBuQOCHy
         Uy7OvIwwFvJlBhPaeDZjXEhpvskdvqeuotFETckZwvDSvatHOtrsePO9A0DY+6CwBbmk
         W3oOjYl5z3jBFyvod9JITvNbaEvWkqBSgBWy18PebTsoOg+gYH1+HpKCSDjH7MhNr7sp
         C5Dn2NsKVuPQPJLdsr3xOXJ0axprIlHv2uBTqAq3XSUBYfRs2FDXXDGl7JHMzebhviEK
         WKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ApxyJvlL0EgkjxePD3esAQ9IvkzW++CVryyDi4r5gNo=;
        b=2ffAJOZ0yzDOF9XaVmpAqXR1Ehp+OHLZx5Zb2LCCYplPWrcuOIV5qr0GmGpc6Q0KQn
         B7K/akT4FBmicXLLACyijddOyC1MaJ1MCTstBfQJ+2XiQeOt5D/PnONrMzxLAx/9OE8Y
         Xsxee1J9KgvqXfulm7EFwvseDe1vMKUWMHReC2W2YsnlkDrX+kGwieMYt/iUYpmKWYLh
         eFs3NhqSILSW70pcl1YHoQd4cW71aE6ko8RlTh0KtTPhLCShO/al+qsrfWVIXwCVxEK6
         chc0Bv2uxP65rgN/m23zN5/T7t/XwRl+qsD+P/Z2/w9zc+09iN250eknVJ6HBNTy6SXd
         qvWQ==
X-Gm-Message-State: AJIora+U1534h7iFAh1YElvbzhBSQg14hSkQ2r3FpwooZrJ9K3ih5l/7
        XjbZ0zaa27dYRoWTsMKwDB1+CQ==
X-Google-Smtp-Source: AGRyM1s3uYRhWPrUNnaJcvNKcMLy+yADF1JsPBXeRAR6KnjDOQjTyzAAOTYTxhJmAC/i12+29ohkog==
X-Received: by 2002:a5d:4583:0:b0:21e:3b0e:2bc9 with SMTP id p3-20020a5d4583000000b0021e3b0e2bc9mr8736620wrq.649.1658784441846;
        Mon, 25 Jul 2022 14:27:21 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:21 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Amit Kucheria <amitk@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v2 10/32] thermal/drivers/broadcom: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:15 +0200
Message-Id: <20220725212637.2818207-11-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/thermal/broadcom/bcm2711_thermal.c | 14 +++---
 drivers/thermal/broadcom/bcm2835_thermal.c | 14 +++---
 drivers/thermal/broadcom/brcmstb_thermal.c | 20 ++++-----
 drivers/thermal/broadcom/ns-thermal.c      | 50 +++++++++-------------
 drivers/thermal/broadcom/sr-thermal.c      | 16 +++----
 5 files changed, 53 insertions(+), 61 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index e9bef5c3414b..1f8651d15160 100644
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
+static const struct thermal_zone_device_ops bcm2711_thermal_of_ops = {
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
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index c8e4344d5a3d..2c67841a1115 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -88,9 +88,9 @@ static int bcm2835_thermal_temp2adc(int temp, int offset, int slope)
 	return temp;
 }
 
-static int bcm2835_thermal_get_temp(void *d, int *temp)
+static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct bcm2835_thermal_data *data = d;
+	struct bcm2835_thermal_data *data = tz->devdata;
 	u32 val = readl(data->regs + BCM2835_TS_TSENSSTAT);
 
 	if (!(val & BCM2835_TS_TSENSSTAT_VALID))
@@ -135,7 +135,7 @@ static void bcm2835_thermal_debugfs(struct platform_device *pdev)
 	debugfs_create_regset32("regset", 0444, data->debugfsdir, regset);
 }
 
-static const struct thermal_zone_of_device_ops bcm2835_thermal_ops = {
+static const struct thermal_zone_device_ops bcm2835_thermal_ops = {
 	.get_temp = bcm2835_thermal_get_temp,
 };
 
@@ -206,8 +206,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 			 data->clk, rate);
 
 	/* register of thermal sensor and get info from DT */
-	tz = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
-					     &bcm2835_thermal_ops);
+	tz = devm_thermal_of_zone_register(&pdev->dev, 0, data,
+					   &bcm2835_thermal_ops);
 	if (IS_ERR(tz)) {
 		err = PTR_ERR(tz);
 		dev_err(&pdev->dev,
@@ -277,7 +277,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	return 0;
 err_tz:
-	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
+	thermal_of_zone_unregister(tz);
 err_clk:
 	clk_disable_unprepare(data->clk);
 
@@ -290,7 +290,7 @@ static int bcm2835_thermal_remove(struct platform_device *pdev)
 	struct thermal_zone_device *tz = data->tz;
 
 	debugfs_remove_recursive(data->debugfsdir);
-	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
+	thermal_of_zone_unregister(tz);
 	clk_disable_unprepare(data->clk);
 
 	return 0;
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 0cedb8b4f00a..c79c6cfdd74d 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -105,7 +105,7 @@ static struct avs_tmon_trip avs_tmon_trips[] = {
 struct brcmstb_thermal_params {
 	unsigned int offset;
 	unsigned int mult;
-	const struct thermal_zone_of_device_ops *of_ops;
+	const struct thermal_zone_device_ops *of_ops;
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
+static const struct thermal_zone_device_ops brcmstb_16nm_of_ops = {
 	.get_temp	= brcmstb_get_temp,
 };
 
@@ -298,7 +298,7 @@ static const struct brcmstb_thermal_params brcmstb_16nm_params = {
 	.of_ops	= &brcmstb_16nm_of_ops,
 };
 
-static const struct thermal_zone_of_device_ops brcmstb_28nm_of_ops = {
+static const struct thermal_zone_device_ops brcmstb_28nm_of_ops = {
 	.get_temp	= brcmstb_get_temp,
 	.set_trips	= brcmstb_set_trips,
 };
@@ -318,7 +318,7 @@ MODULE_DEVICE_TABLE(of, brcmstb_thermal_id_table);
 
 static int brcmstb_thermal_probe(struct platform_device *pdev)
 {
-	const struct thermal_zone_of_device_ops *of_ops;
+	const struct thermal_zone_device_ops *of_ops;
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
index c9468ba9d449..07a8a3f49bd0 100644
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
+static const struct thermal_zone_device_ops ns_thermal_ops = {
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
index 85ab9edd580c..2b93502543ff 100644
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
+static const struct thermal_zone_device_ops sr_tz_ops = {
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

