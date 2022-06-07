Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4874B54030F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344500AbiFGPxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344423AbiFGPwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:52:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F81A2AED;
        Tue,  7 Jun 2022 08:52:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u12so36098033eja.8;
        Tue, 07 Jun 2022 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=inWPNPjxnNomGMq+92gUJjnM7XkTlrAYR32sAnZRtIM=;
        b=QxgKVN2ZLv+22WI+RGZG3UFl8ToI3+fkEcrA1R9INFl2M+Boay0NLnUJcw2GLyXY/z
         6cePNnpo+Ea2YuDBK/Yr5+JJLiMsbnKUIC1pcPk7hovoixT6ej8NmnP7iakKX2yVIwkU
         J4493gC5FdNKsakYjKZVgtupQLWPkkNbnBvvuqnn7irtgbb+R7Icj02r8qUF4rxYuItC
         iwy7IX9VkTs/vaNQNT1Gr30DTEbkglyKsY6OwB1I72hNyv+OJNi0fOCc6ZEyJ4vtWCGN
         CQxRtjOveLt9ITnDZx6XPFvCJrcCdH9AR4ecDJm2/QCFicXaSlAa3Sh1bGhzoBFFfJjS
         MPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=inWPNPjxnNomGMq+92gUJjnM7XkTlrAYR32sAnZRtIM=;
        b=65Jx4qBA1P1IKaE1fsQoKyMnMTHs1Ywunckem5Q6/FCaTPFyWZs+OA/hFGZJlaMK0V
         7fi8R9m3EzLR/YAcawabvXYuXPAM9AjJ84xiCWMqQnVWOEa3fhbkfBbvA1Fgk4NMF6dS
         z+77qGsu1QlgnknJrnChxjXBMT0INXXt1eVo+mDWr9dIavfoOULnvw0fX+epuGzO6IqR
         GNcXIsRgmyzdavWiQo/9YIs3TBZmMi3YLks1hOAo0yYuKTwQn2lfLxX7pGX3q0DiKjYX
         42z/FMsD0PYjQq5f2w/INfpsKq142/fKn9jBhmyqdKFUg4ZhLfOlXiFg2DsxHBGC0KHP
         RArQ==
X-Gm-Message-State: AOAM5335GVTwjRem+CH0MqK4jbR6vfcyqIxIzTwhdVKnD3zool+BZH5L
        SEvlJg5ibORyZ7o4dE4uJP4=
X-Google-Smtp-Source: ABdhPJwxwMJF/6b/OtbWBAauqVRRFmERln3xSrPq4Nou+dPlQ2rQPVvX1cZonEI0CPIYioOIluWAnw==
X-Received: by 2002:a17:907:c23:b0:711:ea32:afce with SMTP id ga35-20020a1709070c2300b00711ea32afcemr1863050ejc.174.1654617160079;
        Tue, 07 Jun 2022 08:52:40 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id u1-20020a170906124100b006feb875503fsm7887041eja.78.2022.06.07.08.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:39 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 09/17] regulator: axp20x: Add support for AXP192
Date:   Tue,  7 Jun 2022 16:53:16 +0100
Message-Id: <20220607155324.118102-10-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the AXP192 PMIC.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/regulator/axp20x-regulator.c | 101 ++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index d260c442b788..1edf2bbf1c16 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -27,6 +27,29 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 
+#define AXP192_GPIO0_FUNC_MASK		GENMASK(2, 0)
+
+#define AXP192_IO_ENABLED		0x02
+#define AXP192_IO_DISABLED		0x06
+
+#define AXP192_WORKMODE_DCDC1_MASK	BIT_MASK(3)
+#define AXP192_WORKMODE_DCDC2_MASK	BIT_MASK(2)
+#define AXP192_WORKMODE_DCDC3_MASK	BIT_MASK(1)
+
+#define AXP192_DCDC1_V_OUT_MASK		GENMASK(6, 0)
+#define AXP192_DCDC2_V_OUT_MASK		GENMASK(5, 0)
+#define AXP192_DCDC3_V_OUT_MASK		GENMASK(6, 0)
+#define AXP192_LDO2_V_OUT_MASK		GENMASK(7, 4)
+#define AXP192_LDO3_V_OUT_MASK		GENMASK(3, 0)
+#define AXP192_LDO_IO0_V_OUT_MASK	GENMASK(7, 4)
+
+#define AXP192_PWR_OUT_EXTEN_MASK	BIT_MASK(6)
+#define AXP192_PWR_OUT_DCDC2_MASK	BIT_MASK(4)
+#define AXP192_PWR_OUT_LDO3_MASK	BIT_MASK(3)
+#define AXP192_PWR_OUT_LDO2_MASK	BIT_MASK(2)
+#define AXP192_PWR_OUT_DCDC3_MASK	BIT_MASK(1)
+#define AXP192_PWR_OUT_DCDC1_MASK	BIT_MASK(0)
+
 #define AXP20X_GPIO0_FUNC_MASK		GENMASK(3, 0)
 #define AXP20X_GPIO1_FUNC_MASK		GENMASK(3, 0)
 
@@ -375,25 +398,32 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 
 	switch (axp20x->variant) {
 	case AXP209_ID:
-		if (id == AXP20X_DCDC2) {
+		if (id == AXP20X_LDO3) {
 			slew_rates = axp209_dcdc2_ldo3_slew_rates;
 			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
 			reg = AXP20X_DCDC2_LDO3_V_RAMP;
-			mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
-			       AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
+			mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
+			       AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
 			enable = (ramp > 0) ?
-				 AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN : 0;
+				 AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN : 0;
 			break;
 		}
 
-		if (id == AXP20X_LDO3) {
+		fallthrough;
+
+	case AXP192_ID:
+		/*
+		 * AXP192 and AXP209 share the same DCDC2 ramp configuration
+		 */
+		if ((axp20x->variant == AXP209_ID && id == AXP20X_DCDC2) ||
+		    (axp20x->variant == AXP192_ID && id == AXP20X_DCDC2)) {
 			slew_rates = axp209_dcdc2_ldo3_slew_rates;
 			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
 			reg = AXP20X_DCDC2_LDO3_V_RAMP;
-			mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
-			       AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
+			mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
+			       AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
 			enable = (ramp > 0) ?
-				 AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN : 0;
+				 AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN : 0;
 			break;
 		}
 
@@ -401,6 +431,7 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 			break;
 
 		fallthrough;
+
 	default:
 		/* Not supported for this regulator */
 		return -ENOTSUPP;
@@ -415,7 +446,8 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 			if (ramp > slew_rates[i])
 				break;
 
-			if (id == AXP20X_DCDC2)
+			if ((axp20x->variant == AXP209_ID && id == AXP20X_DCDC2) ||
+			    (axp20x->variant == AXP192_ID && id == AXP192_DCDC2))
 				cfg = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE(i);
 			else
 				cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
@@ -511,6 +543,29 @@ static const struct regulator_ops axp20x_ops_sw = {
 	.is_enabled		= regulator_is_enabled_regmap,
 };
 
+static const struct regulator_desc axp192_regulators[] = {
+	AXP_DESC(AXP192, DCDC1, "dcdc1", "vin1", 700, 3500, 25,
+		 AXP192_DCDC1_V_OUT, AXP192_DCDC1_V_OUT_MASK,
+		 AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_DCDC1_MASK),
+	AXP_DESC(AXP192, DCDC2, "dcdc2", "vin2", 700, 2275, 25,
+		 AXP192_DCDC2_V_OUT, AXP192_DCDC2_V_OUT_MASK,
+		 AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_DCDC2_MASK),
+	AXP_DESC(AXP192, DCDC3, "dcdc3", "vin3", 700, 3500, 25,
+		 AXP192_DCDC3_V_OUT, AXP192_DCDC3_V_OUT_MASK,
+		 AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_DCDC3_MASK),
+	AXP_DESC_FIXED(AXP192, LDO1, "ldo1", "acin", 1250),
+	AXP_DESC(AXP192, LDO2, "ldo2", "ldoin", 1800, 3300, 100,
+		 AXP192_LDO2_3_V_OUT, AXP192_LDO2_V_OUT_MASK,
+		 AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_LDO2_MASK),
+	AXP_DESC(AXP192, LDO3, "ldo3", "ldoin", 1800, 3300, 100,
+		 AXP192_LDO2_3_V_OUT, AXP192_LDO3_V_OUT_MASK,
+		 AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_LDO3_MASK),
+	AXP_DESC_IO(AXP192, LDO_IO0, "ldo_io0", "ips", 700, 3300, 100,
+		    AXP192_LDO_IO0_V_OUT, AXP192_LDO_IO0_V_OUT_MASK,
+		    AXP192_GPIO0_CTRL, AXP192_GPIO0_FUNC_MASK,
+		    AXP192_IO_ENABLED, AXP192_IO_DISABLED),
+};
+
 static const struct linear_range axp20x_ldo4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1250000,
 			       AXP20X_LDO4_V_OUT_1250mV_START,
@@ -1008,6 +1063,12 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 	u32 min, max, def, step;
 
 	switch (axp20x->variant) {
+	case AXP192_ID:
+		min = 900;
+		max = 2025;
+		def = 1500;
+		step = 75;
+		break;
 	case AXP202_ID:
 	case AXP209_ID:
 		min = 750;
@@ -1100,6 +1161,24 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 	unsigned int mask;
 
 	switch (axp20x->variant) {
+	case AXP192_ID:
+		switch (id) {
+		case AXP192_DCDC1:
+			mask = AXP192_WORKMODE_DCDC1_MASK;
+			break;
+		case AXP192_DCDC2:
+			mask = AXP192_WORKMODE_DCDC2_MASK;
+			break;
+		case AXP192_DCDC3:
+			mask = AXP192_WORKMODE_DCDC3_MASK;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		workmode <<= ffs(mask) - 1;
+		break;
+
 	case AXP202_ID:
 	case AXP209_ID:
 		if ((id != AXP20X_DCDC2) && (id != AXP20X_DCDC3))
@@ -1220,6 +1299,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	bool drivevbus = false;
 
 	switch (axp20x->variant) {
+	case AXP192_ID:
+		regulators = axp192_regulators;
+		nregulators = AXP192_REG_ID_MAX;
+		break;
 	case AXP202_ID:
 	case AXP209_ID:
 		regulators = axp20x_regulators;
-- 
2.35.1

