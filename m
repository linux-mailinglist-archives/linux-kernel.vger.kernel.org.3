Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABA6540320
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344539AbiFGPyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344505AbiFGPxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:53:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F63111822;
        Tue,  7 Jun 2022 08:52:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n10so36112564ejk.5;
        Tue, 07 Jun 2022 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TPeG7DSa9CCcwwWG/igJ62qX12dr9uWXtmriiDVMY1Q=;
        b=gvcr9Ulnikx/HbmXRuLQGtT5IeC/FtuR7uY/+sfRRdTopbweK/UrGkmE/2A2C+7YPa
         3Obf+Aq4auotLky0kzGhFKuY8R+HRKCZaX9IWKQwtsTuWXR3zl0aUStw5GU2xy7qYf1z
         kvOivSgG7f/8e95CWQvOe8HtLnxJSAUppQ9dy61VfbnPhvZOna/f18VfTKH8FqcVt3DB
         o7wnl5HnaQUUQ6vFzHTN9Lb50sb/KP8VkwjLMcn5Qmn82eIAsgdGDwZ57PlJ1YDB1Utw
         XiCU7z/KWTmu+AKvKdZx1Ui9UlTkVP7c5QMQDAWvla1Esfx2e1IVsWkDVD3pjM4qgjCb
         DZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TPeG7DSa9CCcwwWG/igJ62qX12dr9uWXtmriiDVMY1Q=;
        b=Nyg+d6vRuP8Ztpr/qXqcoBlDZ+B8l85bpWOuhkTpOoki2tY7peM1FAdkaCg4PfERMI
         AB/SynIrn3/11KEoj0vTmLsQWmfmY4Mfpkp+sl9nESC70bYKPSOwV7twkrurT0LbtGQ1
         hCqVFslEirl4WvZ5BpUovU+38kQVBJJut7mUZrejGeCJRkwxa0tzB0AS+Igr8jAohJ9d
         ZWiR6qvetMFGYkFOFFlFpA0vbQk1IQiWH+nMgEcNHCsysMdZ9TlT5N+9imqIOQvOWOwC
         r6lKwtephI05lgi3wACe29foEkO5OPnvbrth7G+zNpyGqSXE34Dkx6PwUQTkaYhyqtl9
         54yg==
X-Gm-Message-State: AOAM532/WrgV4X+XZRdtJNb5akBnTA9wz8+Eo0aBUjJLoUxdy2tPpb//
        IUf3MLfuGf3xCzjxrTpkWdAlEUsCQ4w=
X-Google-Smtp-Source: ABdhPJwApnzmbD0ni+UBl9VYCeisV7k7HWR+gaN2oP4izwMqlGa7fMpKZGAd7HK1sj9Q9hi9TXFsBw==
X-Received: by 2002:a17:907:9715:b0:711:ca06:ca50 with SMTP id jg21-20020a170907971500b00711ca06ca50mr12115347ejc.192.1654617165193;
        Tue, 07 Jun 2022 08:52:45 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id q12-20020a056402248c00b0042def6cd141sm5171620eda.30.2022.06.07.08.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:44 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 12/17] iio: adc: axp20x_adc: Add support for AXP192
Date:   Tue,  7 Jun 2022 16:53:19 +0100
Message-Id: <20220607155324.118102-13-aidanmacdonald.0x0@gmail.com>
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

The AXP192 is identical to the AXP20x, except for the addition of
two more GPIO ADC channels.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/iio/adc/axp20x_adc.c | 285 ++++++++++++++++++++++++++++++++++-
 1 file changed, 277 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 0260433782d8..fcd37d39884d 100644
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
 
@@ -83,6 +91,25 @@ struct axp_data {
 	enum axp20x_variants		axp20x_id;
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
@@ -170,6 +197,43 @@ static struct iio_map axp22x_maps[] = {
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
@@ -250,6 +314,15 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
 	int ret, size;
 
 	switch (info->data->axp20x_id) {
+	case AXP192_ID:
+		/* Battery current ADCs on the AXP192 are 13 bits. */
+		if (chan->type == IIO_CURRENT &&
+		    (chan->channel == AXP20X_BATT_CHRG_I || chan->channel == AXP20X_BATT_DISCHRG_I))
+			size = 13;
+		else
+			size = 12;
+		break;
+
 	case AXP202_ID:
 	case AXP209_ID:
 		/*
@@ -276,6 +349,44 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
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
@@ -379,6 +490,29 @@ static int axp20x_adc_scale_current(int channel, int *val, int *val2)
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
@@ -438,6 +572,42 @@ static int axp813_adc_scale(struct iio_chan_spec const *chan, int *val,
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
+		regval &= AXP192_GPIO30_IN_RANGE_GPIO0;
+		break;
+
+	case AXP192_GPIO1_V:
+		regval &= AXP192_GPIO30_IN_RANGE_GPIO1;
+		break;
+
+	case AXP192_GPIO2_V:
+		regval &= AXP192_GPIO30_IN_RANGE_GPIO2;
+		break;
+
+	case AXP192_GPIO3_V:
+		regval &= AXP192_GPIO30_IN_RANGE_GPIO3;
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
@@ -466,6 +636,22 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
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
@@ -482,6 +668,25 @@ static int axp20x_adc_offset(struct iio_dev *indio_dev,
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
+		return axp20x_adc_raw(indio_dev, chan, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp20x_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -542,6 +747,53 @@ static int axp813_read_raw(struct iio_dev *indio_dev,
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
+	regval = val ? 1 : 0;
+
+	switch (chan->channel) {
+	case AXP192_GPIO0_V:
+		regmask = AXP192_GPIO30_IN_RANGE_GPIO0;
+		regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO0, regval);
+		break;
+
+	case AXP192_GPIO1_V:
+		regmask = AXP192_GPIO30_IN_RANGE_GPIO1;
+		regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO1, regval);
+		break;
+
+	case AXP192_GPIO2_V:
+		regmask = AXP192_GPIO30_IN_RANGE_GPIO2;
+		regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO2, regval);
+		break;
+
+	case AXP192_GPIO3_V:
+		regmask = AXP192_GPIO30_IN_RANGE_GPIO3;
+		regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO3, regval);
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
@@ -579,6 +831,11 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
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
@@ -613,13 +870,24 @@ static int axp813_adc_rate(struct axp20x_adc_iio *info, int rate)
 				 AXP813_ADC_RATE_HZ(rate));
 }
 
+static const struct axp_data axp192_data = {
+	.iio_info = &axp192_adc_iio_info,
+	.num_channels = ARRAY_SIZE(axp192_adc_channels),
+	.channels = axp192_adc_channels,
+	.adc_en1_mask = AXP192_ADC_EN1_MASK,
+	.adc_en2_mask = AXP192_ADC_EN2_MASK,
+	.adc_rate = axp20x_adc_rate,
+	.maps = axp20x_maps,
+	.axp20x_id = AXP192_ID,
+};
+
 static const struct axp_data axp20x_data = {
 	.iio_info = &axp20x_adc_iio_info,
 	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
 	.channels = axp20x_adc_channels,
 	.adc_en1_mask = AXP20X_ADC_EN1_MASK,
+	.adc_en2_mask = AXP20X_ADC_EN2_MASK,
 	.adc_rate = axp20x_adc_rate,
-	.adc_en2 = true,
 	.maps = axp20x_maps,
 	.axp20x_id = AXP209_ID,
 };
@@ -630,7 +898,6 @@ static const struct axp_data axp22x_data = {
 	.channels = axp22x_adc_channels,
 	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
 	.adc_rate = axp22x_adc_rate,
-	.adc_en2 = false,
 	.maps = axp22x_maps,
 	.axp20x_id = AXP221_ID,
 };
@@ -641,12 +908,12 @@ static const struct axp_data axp813_data = {
 	.channels = axp813_adc_channels,
 	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
 	.adc_rate = axp813_adc_rate,
-	.adc_en2 = false,
 	.maps = axp22x_maps,
 	.axp20x_id = AXP813_ID,
 };
 
 static const struct of_device_id axp20x_adc_of_match[] = {
+	{ .compatible = "x-powers,axp192-adc", .data = (void *)&axp192_data, },
 	{ .compatible = "x-powers,axp209-adc", .data = (void *)&axp20x_data, },
 	{ .compatible = "x-powers,axp221-adc", .data = (void *)&axp22x_data, },
 	{ .compatible = "x-powers,axp813-adc", .data = (void *)&axp813_data, },
@@ -655,6 +922,7 @@ static const struct of_device_id axp20x_adc_of_match[] = {
 MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
 
 static const struct platform_device_id axp20x_adc_id_match[] = {
+	{ .name = "axp192-adc", .driver_data = (kernel_ulong_t)&axp192_data, },
 	{ .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
 	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
 	{ .name = "axp813-adc", .driver_data = (kernel_ulong_t)&axp813_data, },
@@ -700,10 +968,11 @@ static int axp20x_probe(struct platform_device *pdev)
 	/* Enable the ADCs on IP */
 	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
 
-	if (info->data->adc_en2)
-		/* Enable GPIO0/1 and internal temperature ADCs */
+	if (info->data->adc_en2_mask)
+		/* Enable GPIO and internal temperature ADCs */
 		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
-				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
+				   info->data->adc_en2_mask,
+				   info->data->adc_en2_mask);
 
 	/* Configure ADCs rate */
 	info->data->adc_rate(info, 100);
@@ -728,7 +997,7 @@ static int axp20x_probe(struct platform_device *pdev)
 fail_map:
 	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
 
-	if (info->data->adc_en2)
+	if (info->data->adc_en2_mask)
 		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
 
 	return ret;
@@ -744,7 +1013,7 @@ static int axp20x_remove(struct platform_device *pdev)
 
 	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
 
-	if (info->data->adc_en2)
+	if (info->data->adc_en2_mask)
 		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
 
 	return 0;
-- 
2.35.1

