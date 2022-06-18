Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9454B55071C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiFRVkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbiFRVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB8101CF;
        Sat, 18 Jun 2022 14:40:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n10so14605000ejk.5;
        Sat, 18 Jun 2022 14:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSjgs58bukkFCOBB4wKqtTb4eUBpPBltt4emjYOs+p4=;
        b=mxgNo84vHQcEc5359QaQoeNjiWexd+vj1a17mZtswJVYBVBcsF1GVUr2HEGKzDMsiH
         iOfZrvcSwBadrYVF3gEGcnkN/zf7CH07wsdcvvgD0JmDB4ww4XdXc7uT+k9VU6opn89B
         O5Umm2/uAn2wgoAMEraaHh+PV3XrM3+z4t88PIt5vTHEd/bTMInQ6GrbkmqQWQB3IYTH
         t6XVLjqEn+/EvzkcAyyEB29JPjO2TFA9yYyUEkaZbBi1AAWnWpJqeT7tr2uUKul/lh1+
         MMvcRfsndfsgb0icA4c1lNTlc+MWA6Igly35oEEVyhFiS3KTmQSY3StS+z1ZTr722iOT
         P21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSjgs58bukkFCOBB4wKqtTb4eUBpPBltt4emjYOs+p4=;
        b=y7cUnAn1kOdmnmlpFN0kVkcnvCJSn99SFj5PzalYYPHxu4oe0Il4cONAEDY4la/WYF
         eODlql/KNxnZvKTnoeDn2DMsjK6jIK+/LbiKqTGebJCmZkuRgLnK7hxMhyps4rKm1D+D
         IG4QfZiG8R5+sKQJ4sgaSmn16C09vTIXWUwSuRXiPEqzPoXhJC4TRna+g7AylwVGPZyN
         XNimCmm8csa+FxvB8M4KXHP2QLxh3WW17NrUJTtuDknDJ6PO6F70p5hgFbegMeeYs+Tt
         Y0QeZCxYpwsztYtsRuYebq133JjeXL/LBo9E9XOY4ZI7CrFEE4AERl/77U3oXgN8RthY
         jlMA==
X-Gm-Message-State: AJIora9H/JYQx5Adi5KwE1EVIXw0HEhc2QcvoHXq910ohDrdUzRNFFCo
        ECUTyrboA0b1gVX17ndU9JA=
X-Google-Smtp-Source: AGRyM1vvIHfoTgo7rTAaPu7Tr2Mwzrsm0AEU8Z1bp8MoY1wUHqsDhQRHlKVNlbdyPyNYLD+Pv4Z2QA==
X-Received: by 2002:a17:906:84b:b0:70c:d506:7817 with SMTP id f11-20020a170906084b00b0070cd5067817mr15071727ejd.206.1655588409988;
        Sat, 18 Jun 2022 14:40:09 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c487000000b0042bcf1e0060sm6443237edq.65.2022.06.18.14.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:40:09 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 09/16] regulator: axp20x: Add support for AXP192
Date:   Sat, 18 Jun 2022 22:40:02 +0100
Message-Id: <20220618214009.2178567-10-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
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

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/regulator/axp20x-regulator.c | 101 ++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index d260c442b788..2c59f398f6dd 100644
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
+		    (axp20x->variant == AXP192_ID && id == AXP192_DCDC2)) {
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

