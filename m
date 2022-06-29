Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3105602DA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiF2OaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiF2OaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:30:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDEE2654D;
        Wed, 29 Jun 2022 07:30:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id s1so22744601wra.9;
        Wed, 29 Jun 2022 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ose9v+SPehQ2cszUMakceJQuvBEeYhocVG7tdlN7Ewo=;
        b=BjgBXOvzfzMmp3Dw5v/6a7iWczefnxQfIRIAERGGtzE4XzhntfYLRkVa3cGKu+RMrK
         SKWWEI4ugHAtX/KwwIFH6pH+cQRAuzNvaxYbKfOzw3Jt4fNc5ttnm4K5VHSvixmWXuky
         95lxg5YcsS7LWuUgKggKYesWYbqOFmUa2V1k9Iu16oN0kwbrYvNJY38VFaZ4oZZIL4Z2
         /jIQFaURdXXWtdRMi+Ww5xZnJxahjEgTUXllrnu3BhlJun0wJmpeELp7ae4fUbGwMB0+
         e8RBmiWfze8MVC5QWc9lCyKVpU2EUtE2f6k72K1iJeaEcubKUQPZOrsRvynKiEVQihAu
         J+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ose9v+SPehQ2cszUMakceJQuvBEeYhocVG7tdlN7Ewo=;
        b=0qP2BiLENIiWX6LcRMlhJmLmJUJnYseM6iwuLmsOxuKcVRG68dfnnRkwnckx08jDG5
         4vEmbbm7WVAuBPcRRZE6uEtofFEtvJyRfMwNLsqrzpvIRNC0mrZQy1+CyMcH0ttq4dyu
         86qSOQUfZfL7KA9vrewyKjSFxg943eVq8YFsSZFvBTbdRMfe4gPC3hNMsY5TEZU/NzV9
         +9zbSUH5nSshfRMPqfL30ccma6xRTORwtuwYLuBFaXcygca+NFeoJDq3h82kyxDzeQ9L
         qrl7VAgugECpSBtXOGFB6vR7WL46nMgWUNspwRnVG4n7MERqMFLHsScsqCzvhLdRRT/u
         xprA==
X-Gm-Message-State: AJIora/kaYuCje3zqh58OPdjtnoSF/LT0hWzel0QDiQ6ayxBVpSgqz/9
        fmksv6bok4YnkxPnViju4ag=
X-Google-Smtp-Source: AGRyM1shAOji1DRSl9r7plfVefF4ClP5OsOIoazXajkyQsDUdu2rE0xFVkC8eAo2hGZqEQQYI0LRDg==
X-Received: by 2002:a05:6000:1111:b0:21b:899f:4f4f with SMTP id z17-20020a056000111100b0021b899f4f4fmr3459438wrw.167.1656513000571;
        Wed, 29 Jun 2022 07:30:00 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b002185631adf0sm17372693wre.23.2022.06.29.07.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:30:00 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        sre@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 08/15] iio: adc: axp20x_adc: Minor code cleanups
Date:   Wed, 29 Jun 2022 15:30:39 +0100
Message-Id: <20220629143046.213584-9-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
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

The code may be clearer if parameters are not re-purposed to hold
temporary results like register values, so introduce local variables
as necessary to avoid that. Regroup macros based on chip type, and
use the FIELD_PREP() macro instead of a hand-rolled version.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/iio/adc/axp20x_adc.c | 61 +++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 53bf7d4899d2..ab25e6e1ff65 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -5,6 +5,7 @@
  *	Quentin Schulz <quentin.schulz@free-electrons.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -22,20 +23,20 @@
 #include <linux/mfd/axp20x.h>
 
 #define AXP20X_ADC_EN1_MASK			GENMASK(7, 0)
-
 #define AXP20X_ADC_EN2_MASK			(GENMASK(3, 2) | BIT(7))
+
 #define AXP22X_ADC_EN1_MASK			(GENMASK(7, 5) | BIT(0))
 
 #define AXP20X_GPIO10_IN_RANGE_GPIO0		BIT(0)
 #define AXP20X_GPIO10_IN_RANGE_GPIO1		BIT(1)
-#define AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(x)	((x) & BIT(0))
-#define AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(x)	(((x) & BIT(0)) << 1)
 
 #define AXP20X_ADC_RATE_MASK			GENMASK(7, 6)
-#define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
-#define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
 #define AXP20X_ADC_RATE_HZ(x)			((ilog2((x) / 25) << 6) & AXP20X_ADC_RATE_MASK)
+
 #define AXP22X_ADC_RATE_HZ(x)			((ilog2((x) / 100) << 6) & AXP20X_ADC_RATE_MASK)
+
+#define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
+#define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
 #define AXP813_TS_GPIO0_ADC_RATE_HZ(x)		AXP20X_ADC_RATE_HZ(x)
 #define AXP813_V_I_ADC_RATE_HZ(x)		((ilog2((x) / 100) << 4) & AXP813_V_I_ADC_RATE_MASK)
 #define AXP813_ADC_RATE_HZ(x)			(AXP20X_ADC_RATE_HZ(x) | AXP813_V_I_ADC_RATE_HZ(x))
@@ -234,7 +235,7 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan, int *val)
 {
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
-	int size = 12;
+	int ret, size;
 
 	/*
 	 * N.B.:  Unlike the Chinese datasheets tell, the charging current is
@@ -246,10 +247,11 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
 	else
 		size = 12;
 
-	*val = axp20x_read_variable_width(info->regmap, chan->address, size);
-	if (*val < 0)
-		return *val;
+	ret = axp20x_read_variable_width(info->regmap, chan->address, size);
+	if (ret < 0)
+		return ret;
 
+	*val = ret;
 	return IIO_VAL_INT;
 }
 
@@ -257,11 +259,13 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan, int *val)
 {
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	int ret;
 
-	*val = axp20x_read_variable_width(info->regmap, chan->address, 12);
-	if (*val < 0)
-		return *val;
+	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
+	if (ret < 0)
+		return ret;
 
+	*val = ret;
 	return IIO_VAL_INT;
 }
 
@@ -269,11 +273,13 @@ static int axp813_adc_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan, int *val)
 {
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	int ret;
 
-	*val = axp20x_read_variable_width(info->regmap, chan->address, 12);
-	if (*val < 0)
-		return *val;
+	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
+	if (ret < 0)
+		return ret;
 
+	*val = ret;
 	return IIO_VAL_INT;
 }
 
@@ -443,27 +449,27 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
 				     int *val)
 {
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	unsigned int regval;
 	int ret;
 
-	ret = regmap_read(info->regmap, AXP20X_GPIO10_IN_RANGE, val);
+	ret = regmap_read(info->regmap, AXP20X_GPIO10_IN_RANGE, &regval);
 	if (ret < 0)
 		return ret;
 
 	switch (channel) {
 	case AXP20X_GPIO0_V:
-		*val &= AXP20X_GPIO10_IN_RANGE_GPIO0;
+		regval = FIELD_GET(AXP20X_GPIO10_IN_RANGE_GPIO0, regval);
 		break;
 
 	case AXP20X_GPIO1_V:
-		*val &= AXP20X_GPIO10_IN_RANGE_GPIO1;
+		regval = FIELD_GET(AXP20X_GPIO10_IN_RANGE_GPIO1, regval);
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	*val = *val ? 700000 : 0;
-
+	*val = regval ? 700000 : 0;
 	return IIO_VAL_INT;
 }
 
@@ -548,7 +554,7 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
-	unsigned int reg, regval;
+	unsigned int regmask, regval;
 
 	/*
 	 * The AXP20X PMIC allows the user to choose between 0V and 0.7V offsets
@@ -560,25 +566,22 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
 	if (val != 0 && val != 700000)
 		return -EINVAL;
 
-	val = val ? 1 : 0;
-
 	switch (chan->channel) {
 	case AXP20X_GPIO0_V:
-		reg = AXP20X_GPIO10_IN_RANGE_GPIO0;
-		regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(val);
+		regmask = AXP20X_GPIO10_IN_RANGE_GPIO0;
+		regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO0, !!val);
 		break;
 
 	case AXP20X_GPIO1_V:
-		reg = AXP20X_GPIO10_IN_RANGE_GPIO1;
-		regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(val);
+		regmask = AXP20X_GPIO10_IN_RANGE_GPIO1;
+		regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO1, !!val);
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, reg,
-				  regval);
+	return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, regmask, regval);
 }
 
 static const struct iio_info axp20x_adc_iio_info = {
-- 
2.35.1

