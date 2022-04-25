Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5931A50DA08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiDYH2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiDYH2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:28:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFB065E8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:25:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m20so7120077ejj.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qcayQ5d+q+z0ZKjKvnlBCT5f3rdCkuSENpIujOsc0c=;
        b=j28TisVZ2eT3sOJZncj07IR4bq8jZH1b1KVQSn7oSDMBujfba1freM1yBmN7k9x022
         MfW8wvNQMjRwjRWudZRG5Aq0yKg2Co18HGFDzkB4UR4j+DVpGyxyB2EMTFK/jPcoxlRV
         KLbsw4R0AvTbQKhuKiOMb9ZDIG1tv4Zp89R0SKR7Grjiow3jQAVZsCUh8EjepGXLX2Bl
         Qp2tteh8r4J1IpNCSm9iTyrpbLmlF74fSv26kmcDSuChX/JkQoU0XfjA9STDC393R/JZ
         oW+04/T8M7gxo6HAjlivUpncEBeZSGPy9PVtThATQNvy2fZaDTffylgmn+WXAmoWYoS2
         Ji0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qcayQ5d+q+z0ZKjKvnlBCT5f3rdCkuSENpIujOsc0c=;
        b=A4AD60CBOzYan2G7jTARo11d/y10CyiSz82GNbKCL978yi93ApEC7D0rCe9d7+Kg4z
         R6eOkpZDDHF/xBEVLz85qYpJVJC1sEeEMuaYgTFWReK2MeM2rWI4Vqqsi0KM6XcIsIvm
         zy+xMzfGX0tw4ISmogQ+P67vCBRuBcGDDuobN93WlhrTNeqJRtEilQrQbvlD5mBSoCwt
         VRXQ63ry0W/nCVWESSOMs0mVhPh17SuSIcLfdPFf2EWv2pJuyxqO52GIB/X0YQhXsuCP
         JircpUVzei/GiMEB7VqJxKGi65PwoVuYYHXVlQsGYoJtYkv0DNpxiGWKWY6hJ6yIWmyt
         OwBA==
X-Gm-Message-State: AOAM530U2s56Qy6rKHd3q1Bv9Q3rtjNnCfoSwBbiWTt/wj2oU76rJUow
        NQfd7dkEBjZd06gc0Rc3S2TOwA==
X-Google-Smtp-Source: ABdhPJxpB/sCZmdWbBjVSuQvAoFh6WcfY3j2pf5h5M0oR5V4ZOYHULDGhysVA5ec+hzKW8dQRqzc7w==
X-Received: by 2002:a17:907:9005:b0:6da:81ae:a798 with SMTP id ay5-20020a170907900500b006da81aea798mr15152563ejc.699.1650871503792;
        Mon, 25 Apr 2022 00:25:03 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ew15-20020a170907950f00b006f3a3d60b9csm44328ejc.63.2022.04.25.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 00:25:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/2] regulator: richtek,rt4801: parse GPIOs per regulator
Date:   Mon, 25 Apr 2022 09:24:55 +0200
Message-Id: <20220425072455.27356-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220425072455.27356-1-krzysztof.kozlowski@linaro.org>
References: <20220425072455.27356-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having one enable-gpios property for all regulators is discouraged and
instead, similarly to regulator core ena_gpiod feature, each GPIO should
be present in each regulator node.  Add support for parsing such GPIOs,
keeping backwards compatibility.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/rt4801-regulator.c | 49 +++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/rt4801-regulator.c b/drivers/regulator/rt4801-regulator.c
index 7a87788d3f09..563d79196fdd 100644
--- a/drivers/regulator/rt4801-regulator.c
+++ b/drivers/regulator/rt4801-regulator.c
@@ -29,11 +29,33 @@
 
 struct rt4801_priv {
 	struct device *dev;
-	struct gpio_descs *enable_gpios;
+	struct gpio_desc *enable_gpios[DSV_OUT_MAX];
 	unsigned int enable_flag;
 	unsigned int volt_sel[DSV_OUT_MAX];
 };
 
+static int rt4801_of_parse_cb(struct device_node *np,
+			      const struct regulator_desc *desc,
+			      struct regulator_config *config)
+{
+	struct rt4801_priv *priv = config->driver_data;
+	int id = desc->id;
+
+	if (priv->enable_gpios[id]) {
+		dev_warn(priv->dev, "duplicated enable-gpios property\n");
+		return 0;
+	}
+	priv->enable_gpios[id] = devm_fwnode_gpiod_get_index(priv->dev,
+							     of_fwnode_handle(np),
+							     "enable", 0,
+							     GPIOD_OUT_HIGH,
+							     "rt4801");
+	if (IS_ERR(priv->enable_gpios[id]))
+		priv->enable_gpios[id] = NULL;
+
+	return 0;
+}
+
 static int rt4801_set_voltage_sel(struct regulator_dev *rdev, unsigned int selector)
 {
 	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
@@ -63,15 +85,14 @@ static int rt4801_get_voltage_sel(struct regulator_dev *rdev)
 static int rt4801_enable(struct regulator_dev *rdev)
 {
 	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
-	struct gpio_descs *gpios = priv->enable_gpios;
 	int id = rdev_get_id(rdev), ret;
 
-	if (!gpios || gpios->ndescs <= id) {
+	if (!priv->enable_gpios[id]) {
 		dev_warn(&rdev->dev, "no dedicated gpio can control\n");
 		goto bypass_gpio;
 	}
 
-	gpiod_set_value(gpios->desc[id], 1);
+	gpiod_set_value(priv->enable_gpios[id], 1);
 
 bypass_gpio:
 	ret = regmap_write(rdev->regmap, rdev->desc->vsel_reg, priv->volt_sel[id]);
@@ -85,15 +106,14 @@ static int rt4801_enable(struct regulator_dev *rdev)
 static int rt4801_disable(struct regulator_dev *rdev)
 {
 	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
-	struct gpio_descs *gpios = priv->enable_gpios;
 	int id = rdev_get_id(rdev);
 
-	if (!gpios || gpios->ndescs <= id) {
+	if (!priv->enable_gpios[id]) {
 		dev_warn(&rdev->dev, "no dedicated gpio can control\n");
 		goto bypass_gpio;
 	}
 
-	gpiod_set_value(gpios->desc[id], 0);
+	gpiod_set_value(priv->enable_gpios[id], 0);
 
 bypass_gpio:
 	priv->enable_flag &= ~BIT(id);
@@ -122,6 +142,7 @@ static const struct regulator_desc rt4801_regulator_descs[] = {
 		.name = "DSVP",
 		.ops = &rt4801_regulator_ops,
 		.of_match = of_match_ptr("DSVP"),
+		.of_parse_cb = rt4801_of_parse_cb,
 		.type = REGULATOR_VOLTAGE,
 		.id = DSV_OUT_POS,
 		.min_uV = MIN_UV,
@@ -135,6 +156,7 @@ static const struct regulator_desc rt4801_regulator_descs[] = {
 		.name = "DSVN",
 		.ops = &rt4801_regulator_ops,
 		.of_match = of_match_ptr("DSVN"),
+		.of_parse_cb = rt4801_of_parse_cb,
 		.type = REGULATOR_VOLTAGE,
 		.id = DSV_OUT_NEG,
 		.min_uV = MIN_UV,
@@ -172,10 +194,15 @@ static int rt4801_probe(struct i2c_client *i2c)
 		return PTR_ERR(regmap);
 	}
 
-	priv->enable_gpios = devm_gpiod_get_array_optional(&i2c->dev, "enable", GPIOD_OUT_HIGH);
-	if (IS_ERR(priv->enable_gpios)) {
-		dev_err(&i2c->dev, "Failed to get gpios\n");
-		return PTR_ERR(priv->enable_gpios);
+	for (i = 0; i < DSV_OUT_MAX; i++) {
+		priv->enable_gpios[i] = devm_gpiod_get_index_optional(&i2c->dev,
+								      "enable",
+								      i,
+								      GPIOD_OUT_HIGH);
+		if (IS_ERR(priv->enable_gpios[i])) {
+			dev_err(&i2c->dev, "Failed to get gpios\n");
+			return PTR_ERR(priv->enable_gpios[i]);
+		}
 	}
 
 	for (i = 0; i < DSV_OUT_MAX; i++) {
-- 
2.32.0

