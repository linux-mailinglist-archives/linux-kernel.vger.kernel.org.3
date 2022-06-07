Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FFF54031A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbiFGPxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344458AbiFGPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:52:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CBA6252;
        Tue,  7 Jun 2022 08:52:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c2so23559426edf.5;
        Tue, 07 Jun 2022 08:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0cDYQagaAb7G+QbVUnVmim0bMfXRIzjSls1z0Bc9ZI=;
        b=JdYE4eA7PDHGlNbs+RnzJAsTpmoEIcwpzt5f11Kqa2TUlYg1mAC3PqHK+PBdnoxW91
         khOq7T/ebCyfgyBuIKm9relsAU+rj4HaurNQ+1GstEPL2ufbSN5bj5fcLkrOW/tgvQ+8
         lyPN96qEQG+7q/I3rslyXMM1flqxSjBCq5Y4MtL2HwxZcAiq2MWrGdl3Up7ZmQv89vId
         ot4ver4RP9WR980surPyncU5pkUDWYt9TukJDeJgH+zqqSepJiw5W8R9GfI0aKZPs58v
         frX9sdjG4X0jak+XeoGxYBYCSM/Fye4EVfkQx72oAfcbqF3hPtvLt844nN2G274kSiao
         8NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0cDYQagaAb7G+QbVUnVmim0bMfXRIzjSls1z0Bc9ZI=;
        b=ftQ4V941gacSQO9IEovYJ1QEsGcOrc6xajTS8krGxgiC2thf8QxmBGAn3HRIus4b0E
         2wgBwMVHkDzJzGSgvmcZJHUwvk5qHCb8iajClupQydJ0oQ6mwTCfQ6h1tUcqN+4S4/2Q
         F87mndpOP6d7yQpPS6BetBMoHRF5bgW9+E8rsek3GzW8Kek+rgllqmOOGR572+hHigDH
         s94k3BCmBYo0k8eRODknEyhoZMiAMdUolus0R8J+vecHanDrwg+nLxLdmB5xvY2iEB7X
         XrBc8MmwymjOiLNdkIPZ+XjzbSkJUhCBkeN6t/roJksJk3F+BBFQBWzuiII5Q6GlisDe
         NYOQ==
X-Gm-Message-State: AOAM530CflDGcYiEDB0RZo7H2Z3RfEnoHCLeaGjXBl8xuWQQFeDqf6x3
        +BXQ/mbUy+agWjhbTuijhIZUvtOAyF0=
X-Google-Smtp-Source: ABdhPJyIuJ1toTOll9C89o1qTzatkToXziidoO5cMcwFaBc1n6zzyhgpexs7wpnQcZcH2kRoPGfCLA==
X-Received: by 2002:a05:6402:378b:b0:42a:ad8c:628f with SMTP id et11-20020a056402378b00b0042aad8c628fmr34211460edb.90.1654617161847;
        Tue, 07 Jun 2022 08:52:41 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7c698000000b0042bb229e81esm10544018edq.15.2022.06.07.08.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:41 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 10/17] iio: adc: axp20x_adc: Minor code cleanups
Date:   Tue,  7 Jun 2022 16:53:17 +0100
Message-Id: <20220607155324.118102-11-aidanmacdonald.0x0@gmail.com>
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

The code may be clearer if parameters are not re-purposed to hold
temporary results like register values, so introduce local variables
as necessary to avoid that. Also, use the common FIELD_PREP macro
instead of a hand-rolled version.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/iio/adc/axp20x_adc.c | 61 +++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 53bf7d4899d2..9d5b1de24908 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -15,6 +15,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/thermal.h>
+#include <linux/bitfield.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
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
+		regval &= AXP20X_GPIO10_IN_RANGE_GPIO0;
 		break;
 
 	case AXP20X_GPIO1_V:
-		*val &= AXP20X_GPIO10_IN_RANGE_GPIO1;
+		regval &= AXP20X_GPIO10_IN_RANGE_GPIO1;
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
@@ -560,25 +566,24 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
 	if (val != 0 && val != 700000)
 		return -EINVAL;
 
-	val = val ? 1 : 0;
+	regval = val ? 1 : 0;
 
 	switch (chan->channel) {
 	case AXP20X_GPIO0_V:
-		reg = AXP20X_GPIO10_IN_RANGE_GPIO0;
-		regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(val);
+		regmask = AXP20X_GPIO10_IN_RANGE_GPIO0;
+		regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO0, regval);
 		break;
 
 	case AXP20X_GPIO1_V:
-		reg = AXP20X_GPIO10_IN_RANGE_GPIO1;
-		regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(val);
+		regmask = AXP20X_GPIO10_IN_RANGE_GPIO1;
+		regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO1, regval);
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

