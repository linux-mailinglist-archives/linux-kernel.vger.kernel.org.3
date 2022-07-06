Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF1956853B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiGFKTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiGFKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:18:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5697B25EB9;
        Wed,  6 Jul 2022 03:18:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q9so21355449wrd.8;
        Wed, 06 Jul 2022 03:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qftAKV2cvbL9HD/MJnUS+h9n1s9MA9ZYKpdre9sj+TQ=;
        b=m8gdODbWR5GTKSDZ77k1jLImaKqOSGbkgamYbVT0e1Kv+EP6L57pyguXkyYwFIltVE
         ZBUWyledgdGo+lLYKyXcD4hEbWYXbDaCGC3u0xmOLCntm9MF63TGMPuqSyil/w28xBdC
         +S7inFP9Q64JymiPJLzl6PTT1kcEfPXgmD+hztDTl1HOq5yY8UH9L4kc1YbNhjsUeCza
         S2HZJ+K5UEP7s1LiwXj70gtR4JYEV//kmrZCrzTixZjJEkn/4kAWOh3NbylmsGyDQ3AR
         k+yxZVwR1UxPmG2Ouh5Ea0uskpeyR4EjY2BSaxSXFoogOqIWp7D2SZbj6a3HHlHAPes+
         7C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qftAKV2cvbL9HD/MJnUS+h9n1s9MA9ZYKpdre9sj+TQ=;
        b=fBP2Y5n0XRq/FMV5CeJr1lOrf3i0Y8P/n0sb2usokHBBe9GZESFF112vS9+fWEdpey
         G3SuoVg/QFud2T220VjYp2OJhy+T+SykWF9+p0U7aL1RBJLLlNn8/Rg05qeaC7elnTp1
         Rm2xaJhkgid9lcjuqybIabxN+qSuRU/jurFY++mQ+3PkhwIxbp8vXczPWi5lJepw4k++
         oUTPYQN0Z8xrab0fbRp+b/LJl0zz/JlC9cAdqkKslIaxHUvJkgqte8kiGJxO0yhCIjBK
         W20cMYwkJsuHI+bOgWypMbEdTria+ZenuZ44KEhs6b6t+ofr9HzRnkfDpeArfoVZRPbO
         WfnQ==
X-Gm-Message-State: AJIora/upeBGzh2+HUtnG9i6prg9C7FJXZxt10il4fUSHJ/P/mLOlsVa
        bhYxqPsuQ9SACyc/ZHrvlVA=
X-Google-Smtp-Source: AGRyM1u89lLbFMfkl4n+NlGEH0UPWa6o269Q8+ZcfFw1r5zCHwFj2qN3z/VsVZ1CALGZPWWF//xhxA==
X-Received: by 2002:a05:6000:1acc:b0:21c:439c:7074 with SMTP id i12-20020a0560001acc00b0021c439c7074mr34716540wry.686.1657102721822;
        Wed, 06 Jul 2022 03:18:41 -0700 (PDT)
Received: from localhost (92.40.202.167.threembb.co.uk. [92.40.202.167])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b003a04d19dab3sm24372536wms.3.2022.07.06.03.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:18:41 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 07/13] iio: adc: axp20x_adc: Minor code cleanups
Date:   Wed,  6 Jul 2022 11:18:56 +0100
Message-Id: <20220706101902.4984-8-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
References: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

