Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8CB5602D3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiF2Oaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiF2OaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:30:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF7E201AF;
        Wed, 29 Jun 2022 07:30:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d17so17117580wrc.10;
        Wed, 29 Jun 2022 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KrRHVEzU3t4KKuHec6bwaKs1i0SdHNjIMAZ3xu8PWpw=;
        b=lXSqfhJ3cEDKdS/PqtZXPMrbcAYNUVL75x/gh9jXp8pJ75hZJq51lWwKJHI1owVPfy
         ZT/iZ040RZ+fxpK+5eFAINpJioYl7fx2TKcmOUpX+yaAKLSABaVR66gmd/DNMoyS8Hs/
         WA7Fdx1MfPyIginVk0MDQV98R6g6ljHaLYGodpI0e5uKsl70Zqg6hXmx+FcYKbaDsWt2
         /I3J/HwtywyweAxNKbpx7OfDN5teIB4W8NbfZ+zbQw6aCkyU4gMeUlNg3B7nWNa5herM
         kK5xipl5mP+k5Uq3Sj1MFRPN/fg903Ci0NfVhdbWK9Rkd1yDEHsk0xyrOm5tNIOFBMzs
         NEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KrRHVEzU3t4KKuHec6bwaKs1i0SdHNjIMAZ3xu8PWpw=;
        b=LiW2VDyYFTNU70Jv7WZ1t3nW+/VOxz96zwVA7rk7H+SOmgcKAEUCjyz6s3FBqA+elc
         vAu4foPYOCciFvbsnvMzEgSFBoMsd56b4kUSLH2nS3PGb2JPd42Z7XpL5s7NCvyOpLPg
         aVNoBqCVwf8NIq7K4ixDjXqG5TpxLztQlhtZkeTmui9k97KwbHofUs6+Dcg9u/fY0k26
         tqxOprjlPvveHkgysjhQknuN8DCbFff1+SeHQfMNbliZuBph8LT1Smd0ErdHOtNusPub
         Z8+BS/DJkV7Iy7JbtkzqMrcS7pFVcwdzFDfoB+DChVzb+l7v+S7Zj+ru321S1mRP43UO
         MmSw==
X-Gm-Message-State: AJIora9Wyc6w0tBVVzTRaHlSQYW+/pFVhC9uynXMikbUaEvTy3yenB0E
        xRnQfMXbPupUEzUK4qsPTFE=
X-Google-Smtp-Source: AGRyM1vn98ynk6P7nfWjxoexOIcfCLjpCt0uZGzv5tMYrYvgv6rZ/LnvWCyvBkkzwXpkvCowgjBazg==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id b9-20020adfd1c9000000b0020fc3dce980mr3387624wrd.552.1656513004326;
        Wed, 29 Jun 2022 07:30:04 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3209769wmj.35.2022.06.29.07.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:30:03 -0700 (PDT)
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
Subject: [PATCH v4 10/15] iio: adc: axp20x_adc: Add support for AXP192
Date:   Wed, 29 Jun 2022 15:30:41 +0100
Message-Id: <20220629143046.213584-11-aidanmacdonald.0x0@gmail.com>
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

The AXP192 is identical to the AXP20x, except for the addition of
two more GPIO ADC channels.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/iio/adc/axp20x_adc.c | 279 +++++++++++++++++++++++++++++++++++
 1 file changed, 279 insertions(+)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 75bda94dbce1..8d748b814f20 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -22,11 +22,19 @@
 #include <linux/iio/machine.h>
 #include <linux/mfd/axp20x.h>
 
+#define AXP192_ADC_EN1_MASK			GENMASK(7, 0)
+#define AXP192_ADC_EN2_MASK			(GENMASK(3, 0) | BIT(7))
+
 #define AXP20X_ADC_EN1_MASK			GENMASK(7, 0)
 #define AXP20X_ADC_EN2_MASK			(GENMASK(3, 2) | BIT(7))
 
 #define AXP22X_ADC_EN1_MASK			(GENMASK(7, 5) | BIT(0))
 
+#define AXP192_GPIO30_IN_RANGE_GPIO0		BIT(0)
+#define AXP192_GPIO30_IN_RANGE_GPIO1		BIT(1)
+#define AXP192_GPIO30_IN_RANGE_GPIO2		BIT(2)
+#define AXP192_GPIO30_IN_RANGE_GPIO3		BIT(3)
+
 #define AXP20X_GPIO10_IN_RANGE_GPIO0		BIT(0)
 #define AXP20X_GPIO10_IN_RANGE_GPIO1		BIT(1)
 
@@ -71,6 +79,25 @@ struct axp20x_adc_iio {
 	const struct axp_data	*data;
 };
 
+enum axp192_adc_channel_v {
+	AXP192_ACIN_V = 0,
+	AXP192_VBUS_V,
+	AXP192_TS_IN,
+	AXP192_GPIO0_V,
+	AXP192_GPIO1_V,
+	AXP192_GPIO2_V,
+	AXP192_GPIO3_V,
+	AXP192_IPSOUT_V,
+	AXP192_BATT_V,
+};
+
+enum axp192_adc_channel_i {
+	AXP192_ACIN_I = 0,
+	AXP192_VBUS_I,
+	AXP192_BATT_CHRG_I,
+	AXP192_BATT_DISCHRG_I,
+};
+
 enum axp20x_adc_channel_v {
 	AXP20X_ACIN_V = 0,
 	AXP20X_VBUS_V,
@@ -158,6 +185,43 @@ static struct iio_map axp22x_maps[] = {
  * The only exception is for the battery. batt_v will be in_voltage6_raw and
  * charge current in_current6_raw and discharge current will be in_current7_raw.
  */
+static const struct iio_chan_spec axp192_adc_channels[] = {
+	AXP20X_ADC_CHANNEL(AXP192_ACIN_V, "acin_v", IIO_VOLTAGE,
+			   AXP20X_ACIN_V_ADC_H),
+	AXP20X_ADC_CHANNEL(AXP192_ACIN_I, "acin_i", IIO_CURRENT,
+			   AXP20X_ACIN_I_ADC_H),
+	AXP20X_ADC_CHANNEL(AXP192_VBUS_V, "vbus_v", IIO_VOLTAGE,
+			   AXP20X_VBUS_V_ADC_H),
+	AXP20X_ADC_CHANNEL(AXP192_VBUS_I, "vbus_i", IIO_CURRENT,
+			   AXP20X_VBUS_I_ADC_H),
+	{
+		.type = IIO_TEMP,
+		.address = AXP20X_TEMP_ADC_H,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.datasheet_name = "pmic_temp",
+	},
+	AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO0_V, "gpio0_v", IIO_VOLTAGE,
+				  AXP20X_GPIO0_V_ADC_H),
+	AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO1_V, "gpio1_v", IIO_VOLTAGE,
+				  AXP20X_GPIO1_V_ADC_H),
+	AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO2_V, "gpio2_v", IIO_VOLTAGE,
+				  AXP192_GPIO2_V_ADC_H),
+	AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO3_V, "gpio3_v", IIO_VOLTAGE,
+				  AXP192_GPIO3_V_ADC_H),
+	AXP20X_ADC_CHANNEL(AXP192_IPSOUT_V, "ipsout_v", IIO_VOLTAGE,
+			   AXP20X_IPSOUT_V_HIGH_H),
+	AXP20X_ADC_CHANNEL(AXP192_BATT_V, "batt_v", IIO_VOLTAGE,
+			   AXP20X_BATT_V_H),
+	AXP20X_ADC_CHANNEL(AXP192_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
+			   AXP20X_BATT_CHRG_I_H),
+	AXP20X_ADC_CHANNEL(AXP192_BATT_DISCHRG_I, "batt_dischrg_i", IIO_CURRENT,
+			   AXP20X_BATT_DISCHRG_I_H),
+	AXP20X_ADC_CHANNEL(AXP192_TS_IN, "ts_v", IIO_VOLTAGE,
+			   AXP20X_TS_IN_H),
+};
+
 static const struct iio_chan_spec axp20x_adc_channels[] = {
 	AXP20X_ADC_CHANNEL(AXP20X_ACIN_V, "acin_v", IIO_VOLTAGE,
 			   AXP20X_ACIN_V_ADC_H),
@@ -231,6 +295,27 @@ static const struct iio_chan_spec axp813_adc_channels[] = {
 			   AXP288_TS_ADC_H),
 };
 
+static int axp192_adc_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, int *val)
+{
+	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	int ret, size;
+
+	if (chan->type == IIO_CURRENT &&
+	    (chan->channel == AXP192_BATT_CHRG_I ||
+	     chan->channel == AXP192_BATT_DISCHRG_I))
+		size = 13;
+	else
+		size = 12;
+
+	ret = axp20x_read_variable_width(info->regmap, chan->address, size);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+	return IIO_VAL_INT;
+}
+
 static int axp20x_adc_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan, int *val)
 {
@@ -283,6 +368,44 @@ static int axp813_adc_raw(struct iio_dev *indio_dev,
 	return IIO_VAL_INT;
 }
 
+static int axp192_adc_scale_voltage(int channel, int *val, int *val2)
+{
+	switch (channel) {
+	case AXP192_ACIN_V:
+	case AXP192_VBUS_V:
+		*val = 1;
+		*val2 = 700000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP192_GPIO0_V:
+	case AXP192_GPIO1_V:
+	case AXP192_GPIO2_V:
+	case AXP192_GPIO3_V:
+		*val = 0;
+		*val2 = 500000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP192_BATT_V:
+		*val = 1;
+		*val2 = 100000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP192_IPSOUT_V:
+		*val = 1;
+		*val2 = 400000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP192_TS_IN:
+		/* 0.8 mV per LSB */
+		*val = 0;
+		*val2 = 800000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
 {
 	switch (channel) {
@@ -386,6 +509,29 @@ static int axp20x_adc_scale_current(int channel, int *val, int *val2)
 	}
 }
 
+static int axp192_adc_scale(struct iio_chan_spec const *chan, int *val,
+			    int *val2)
+{
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		return axp192_adc_scale_voltage(chan->channel, val, val2);
+
+	case IIO_CURRENT:
+		/*
+		 * AXP192 current channels are identical to the AXP20x,
+		 * therefore we can re-use the scaling function.
+		 */
+		return axp20x_adc_scale_current(chan->channel, val, val2);
+
+	case IIO_TEMP:
+		*val = 100;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp20x_adc_scale(struct iio_chan_spec const *chan, int *val,
 			    int *val2)
 {
@@ -445,6 +591,42 @@ static int axp813_adc_scale(struct iio_chan_spec const *chan, int *val,
 	}
 }
 
+static int axp192_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
+				     int *val)
+{
+	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, AXP192_GPIO30_IN_RANGE, &regval);
+	if (ret < 0)
+		return ret;
+
+	switch (channel) {
+	case AXP192_GPIO0_V:
+		regval = FIELD_GET(AXP192_GPIO30_IN_RANGE_GPIO0, regval);
+		break;
+
+	case AXP192_GPIO1_V:
+		regval = FIELD_GET(AXP192_GPIO30_IN_RANGE_GPIO1, regval);
+		break;
+
+	case AXP192_GPIO2_V:
+		regval = FIELD_GET(AXP192_GPIO30_IN_RANGE_GPIO2, regval);
+		break;
+
+	case AXP192_GPIO3_V:
+		regval = FIELD_GET(AXP192_GPIO30_IN_RANGE_GPIO3, regval);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	*val = regval ? 700000 : 0;
+	return IIO_VAL_INT;
+}
+
 static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
 				     int *val)
 {
@@ -473,6 +655,22 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
 	return IIO_VAL_INT;
 }
 
+static int axp192_adc_offset(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val)
+{
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		return axp192_adc_offset_voltage(indio_dev, chan->channel, val);
+
+	case IIO_TEMP:
+		*val = -1447;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp20x_adc_offset(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan, int *val)
 {
@@ -489,6 +687,25 @@ static int axp20x_adc_offset(struct iio_dev *indio_dev,
 	}
 }
 
+static int axp192_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_OFFSET:
+		return axp192_adc_offset(indio_dev, chan, val);
+
+	case IIO_CHAN_INFO_SCALE:
+		return axp192_adc_scale(chan, val, val2);
+
+	case IIO_CHAN_INFO_RAW:
+		return axp192_adc_raw(indio_dev, chan, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp20x_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -549,6 +766,51 @@ static int axp813_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int axp192_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	unsigned int regmask, regval;
+
+	/*
+	 * The AXP192 PMIC allows the user to choose between 0V and 0.7V offsets
+	 * for (independently) GPIO0-3 when in ADC mode.
+	 */
+	if (mask != IIO_CHAN_INFO_OFFSET)
+		return -EINVAL;
+
+	if (val != 0 && val != 700000)
+		return -EINVAL;
+
+	switch (chan->channel) {
+	case AXP192_GPIO0_V:
+		regmask = AXP192_GPIO30_IN_RANGE_GPIO0;
+		regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO0, !!val);
+		break;
+
+	case AXP192_GPIO1_V:
+		regmask = AXP192_GPIO30_IN_RANGE_GPIO1;
+		regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO1, !!val);
+		break;
+
+	case AXP192_GPIO2_V:
+		regmask = AXP192_GPIO30_IN_RANGE_GPIO2;
+		regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO2, !!val);
+		break;
+
+	case AXP192_GPIO3_V:
+		regmask = AXP192_GPIO30_IN_RANGE_GPIO3;
+		regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO3, !!val);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(info->regmap, AXP192_GPIO30_IN_RANGE, regmask, regval);
+}
+
 static int axp20x_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int val, int val2,
 			    long mask)
@@ -584,6 +846,11 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
 	return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, regmask, regval);
 }
 
+static const struct iio_info axp192_adc_iio_info = {
+	.read_raw = axp192_read_raw,
+	.write_raw = axp192_write_raw,
+};
+
 static const struct iio_info axp20x_adc_iio_info = {
 	.read_raw = axp20x_read_raw,
 	.write_raw = axp20x_write_raw,
@@ -629,6 +896,16 @@ struct axp_data {
 	struct iio_map			*maps;
 };
 
+static const struct axp_data axp192_data = {
+	.iio_info = &axp192_adc_iio_info,
+	.num_channels = ARRAY_SIZE(axp192_adc_channels),
+	.channels = axp192_adc_channels,
+	.adc_en1_mask = AXP192_ADC_EN1_MASK,
+	.adc_en2_mask = AXP192_ADC_EN2_MASK,
+	.adc_rate = axp20x_adc_rate,
+	.maps = axp20x_maps,
+};
+
 static const struct axp_data axp20x_data = {
 	.iio_info = &axp20x_adc_iio_info,
 	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
@@ -658,6 +935,7 @@ static const struct axp_data axp813_data = {
 };
 
 static const struct of_device_id axp20x_adc_of_match[] = {
+	{ .compatible = "x-powers,axp192-adc", .data = (void *)&axp192_data, },
 	{ .compatible = "x-powers,axp209-adc", .data = (void *)&axp20x_data, },
 	{ .compatible = "x-powers,axp221-adc", .data = (void *)&axp22x_data, },
 	{ .compatible = "x-powers,axp813-adc", .data = (void *)&axp813_data, },
@@ -666,6 +944,7 @@ static const struct of_device_id axp20x_adc_of_match[] = {
 MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
 
 static const struct platform_device_id axp20x_adc_id_match[] = {
+	{ .name = "axp192-adc", .driver_data = (kernel_ulong_t)&axp192_data, },
 	{ .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
 	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
 	{ .name = "axp813-adc", .driver_data = (kernel_ulong_t)&axp813_data, },
-- 
2.35.1

