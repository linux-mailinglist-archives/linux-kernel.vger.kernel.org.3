Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27FC53D6AA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiFDMFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 08:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiFDMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 08:05:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048121AD8E;
        Sat,  4 Jun 2022 05:05:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q15so5446633wrc.11;
        Sat, 04 Jun 2022 05:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=tUvFLItJonud9nePUtkS7hOr5e0KPMfyxh+0rmP4zo0=;
        b=m6EImzJZvJttx1TECqZc1zpIbnL5w1mgTLrwlYRdKFEOiLSLbMsjDd1ge/K8z1Kw2Z
         5YX9JSjTGjuGhSC+2NcxRsKMMGuHOGvI2HPFBOASRvMze8+KlIl/u4gNP2nSR1kwFY1l
         uN/inSuHwNlillQaF1ZW22SePkPDQeT0r+7DxMYa83Mzchegku+ipAb3yh6g40zHjftb
         WykjhqfRxqZ5xV6Cj28roxUMkd0Z4DDWVWdlIASGfOTg3zcH05AFZAAKAd73wGgzWmmo
         Obp3L5oJUKxPSO7e8wnwtdvl31MgBRTucWHtdv2WJTeyRrhOyOK+SyNZlWggLzMKXIeW
         1pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=tUvFLItJonud9nePUtkS7hOr5e0KPMfyxh+0rmP4zo0=;
        b=lstG8Js6z7UUdm+WyQxdyLg0fsunMLO9OT8TOdXXsrPvYnvMppCA7oBajIkWPZZDJg
         duSdYV7zMsdTMxey5UHcvOTb8Evvo133lec/2RdQMGIT7j7QAk+r7H4H2oNRleWndEx1
         YIEYgl6PbF7WxDnA4L7FSvkPbIC1SzT/g/rfWJ6NBkI4ecQt+U4ZrKfvfqXp5kEjicF1
         owhynW5OpqV5VE/Po0/oXQ1lBQJNz3cHhWj4E3mKj96nTjNTy2QcFDK1toMqa3r5WwQd
         2qnSBFtmzA1toHaKZiNyG+05h7Yo/FEa5+Zn13nncrNVR3iJV8DIi9vbrg9o3eSqzKUo
         mNDg==
X-Gm-Message-State: AOAM530iU+KsLH4VgIWdIEapsnZNngRjFSLum7U6aMTcc+8GzvGDPAcs
        A52QGu9h6gdIj7A/3FMvX7U=
X-Google-Smtp-Source: ABdhPJxjHg3hN+24Y5SqDDLsyROQ9XG3vd17Hl09IgdgucawgAQUiOSlC0KabP7UmAxKKyRsKAKctw==
X-Received: by 2002:adf:e4cd:0:b0:213:b580:6e9f with SMTP id v13-20020adfe4cd000000b00213b5806e9fmr9283301wrm.285.1654344322429;
        Sat, 04 Jun 2022 05:05:22 -0700 (PDT)
Received: from localhost (92.40.202.93.threembb.co.uk. [92.40.202.93])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b0039c3e6edb0asm6362089wml.2.2022.06.04.05.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 05:05:21 -0700 (PDT)
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-9-aidanmacdonald.0x0@gmail.com>
 <20220603174744.642157d8@jic23-huawei>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] iio: adc: axp20x_adc: Add support for AXP192
Date:   Sat, 04 Jun 2022 12:47:38 +0100
In-reply-to: <20220603174744.642157d8@jic23-huawei>
Message-ID: <e9ABtmBNzztlyRcJD5f36OmAYZW4i7KH@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Cameron <jic23@kernel.org> writes:

> On Fri,  3 Jun 2022 14:57:12 +0100
> Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:
>
>> The AXP192 is identical to the AXP20x, except for the addition of
>> two more GPIO ADC channels.
>> 
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> Hi Aidan,
>
> A few minor questions and comments inline.
>
> Thanks,
>
> Jonathan
>
>> ---
>>  drivers/iio/adc/axp20x_adc.c | 289 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 280 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
>> index 53bf7d4899d2..7d2bf9529420 100644
>> --- a/drivers/iio/adc/axp20x_adc.c
>> +++ b/drivers/iio/adc/axp20x_adc.c
>> @@ -21,6 +21,9 @@
>>  #include <linux/iio/machine.h>
>>  #include <linux/mfd/axp20x.h>
>>  
>> +#define AXP192_ADC_EN1_MASK			GENMASK(7, 0)
>> +#define AXP192_ADC_EN2_MASK			(BIT(7) | GENMASK(3, 0))
>
> Obviously doesn't really mater, but for consistency, maybe match the
> ordering in AXP20X_ADC_EN2_MASK below?
>

Ack, will do

>> +
>>  #define AXP20X_ADC_EN1_MASK			GENMASK(7, 0)
>>  
>>  #define AXP20X_ADC_EN2_MASK			(GENMASK(3, 2) | BIT(7))
>> @@ -31,6 +34,15 @@
>>  #define AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(x)	((x) & BIT(0))
>>  #define AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(x)	(((x) & BIT(0)) << 1)
>>  
>> +#define AXP192_GPIO30_IN_RANGE_GPIO0		BIT(0)
>> +#define AXP192_GPIO30_IN_RANGE_GPIO1		BIT(1)
>> +#define AXP192_GPIO30_IN_RANGE_GPIO2		BIT(2)
>> +#define AXP192_GPIO30_IN_RANGE_GPIO3		BIT(3)
>> +#define AXP192_GPIO30_IN_RANGE_GPIO0_VAL(x)	((x) & BIT(0))
>> +#define AXP192_GPIO30_IN_RANGE_GPIO1_VAL(x)	(((x) & BIT(0)) << 1)
>> +#define AXP192_GPIO30_IN_RANGE_GPIO2_VAL(x)	(((x) & BIT(0)) << 2)
>> +#define AXP192_GPIO30_IN_RANGE_GPIO3_VAL(x)	(((x) & BIT(0)) << 3)
>
> FIELD_PREP() using the masks is cleaner than hand rolling it.
> If you fancy updating the driver in general whilst here that would be great,
> but I don't mind if not.
>

Yeah, I don't mind, I'll include a cleanup patch in my v2.

>> +
>>  #define AXP20X_ADC_RATE_MASK			GENMASK(7, 6)
>>  #define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
>>  #define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
>> @@ -70,6 +82,25 @@ struct axp20x_adc_iio {
>>  	const struct axp_data	*data;
>>  };
>>  
>> +enum axp192_adc_channel_v {
>> +	AXP192_ACIN_V = 0,
>> +	AXP192_VBUS_V,
>> +	AXP192_TS_IN,
>> +	AXP192_GPIO0_V,
>> +	AXP192_GPIO1_V,
>> +	AXP192_GPIO2_V,
>> +	AXP192_GPIO3_V,
>> +	AXP192_IPSOUT_V,
>> +	AXP192_BATT_V,
>> +};
>> +
>> +enum axp192_adc_channel_i {
>> +	AXP192_ACIN_I = 0,
>> +	AXP192_VBUS_I,
>> +	AXP192_BATT_CHRG_I,
>> +	AXP192_BATT_DISCHRG_I,
>> +};
>> +
>>  enum axp20x_adc_channel_v {
>>  	AXP20X_ACIN_V = 0,
>>  	AXP20X_VBUS_V,
>> @@ -157,6 +188,43 @@ static struct iio_map axp22x_maps[] = {
>>   * The only exception is for the battery. batt_v will be in_voltage6_raw and
>>   * charge current in_current6_raw and discharge current will be in_current7_raw.
>>   */
>> +static const struct iio_chan_spec axp192_adc_channels[] = {
>> +	AXP20X_ADC_CHANNEL(AXP192_ACIN_V, "acin_v", IIO_VOLTAGE,
>> +			   AXP20X_ACIN_V_ADC_H),
>> +	AXP20X_ADC_CHANNEL(AXP192_ACIN_I, "acin_i", IIO_CURRENT,
>> +			   AXP20X_ACIN_I_ADC_H),
>> +	AXP20X_ADC_CHANNEL(AXP192_VBUS_V, "vbus_v", IIO_VOLTAGE,
>> +			   AXP20X_VBUS_V_ADC_H),
>> +	AXP20X_ADC_CHANNEL(AXP192_VBUS_I, "vbus_i", IIO_CURRENT,
>> +			   AXP20X_VBUS_I_ADC_H),
>> +	{
>> +		.type = IIO_TEMP,
>> +		.address = AXP20X_TEMP_ADC_H,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE) |
>> +				      BIT(IIO_CHAN_INFO_OFFSET),
>> +		.datasheet_name = "pmic_temp",
>> +	},
>> +	AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO0_V, "gpio0_v", IIO_VOLTAGE,
>> +				  AXP20X_GPIO0_V_ADC_H),
>> +	AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO1_V, "gpio1_v", IIO_VOLTAGE,
>> +				  AXP20X_GPIO1_V_ADC_H),
>> +	AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO2_V, "gpio2_v", IIO_VOLTAGE,
>> +				  AXP192_GPIO2_V_ADC_H),
>> +	AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO3_V, "gpio3_v", IIO_VOLTAGE,
>> +				  AXP192_GPIO3_V_ADC_H),
>> +	AXP20X_ADC_CHANNEL(AXP192_IPSOUT_V, "ipsout_v", IIO_VOLTAGE,
>> +			   AXP20X_IPSOUT_V_HIGH_H),
>> +	AXP20X_ADC_CHANNEL(AXP192_BATT_V, "batt_v", IIO_VOLTAGE,
>> +			   AXP20X_BATT_V_H),
>> +	AXP20X_ADC_CHANNEL(AXP192_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
>> +			   AXP20X_BATT_CHRG_I_H),
>> +	AXP20X_ADC_CHANNEL(AXP192_BATT_DISCHRG_I, "batt_dischrg_i", IIO_CURRENT,
>> +			   AXP20X_BATT_DISCHRG_I_H),
>> +	AXP20X_ADC_CHANNEL(AXP192_TS_IN, "ts_v", IIO_VOLTAGE,
>> +			   AXP20X_TS_IN_H),
>> +};
>> +
>>  static const struct iio_chan_spec axp20x_adc_channels[] = {
>>  	AXP20X_ADC_CHANNEL(AXP20X_ACIN_V, "acin_v", IIO_VOLTAGE,
>>  			   AXP20X_ACIN_V_ADC_H),
>> @@ -277,6 +345,44 @@ static int axp813_adc_raw(struct iio_dev *indio_dev,
>>  	return IIO_VAL_INT;
>>  }
>>  
>> +static int axp192_adc_scale_voltage(int channel, int *val, int *val2)
>> +{
>> +	switch (channel) {
>> +	case AXP192_ACIN_V:
>> +	case AXP192_VBUS_V:
>> +		*val = 1;
>> +		*val2 = 700000;
>> +		return IIO_VAL_INT_PLUS_MICRO;
>> +
>> +	case AXP192_GPIO0_V:
>> +	case AXP192_GPIO1_V:
>> +	case AXP192_GPIO2_V:
>> +	case AXP192_GPIO3_V:
>> +		*val = 0;
>> +		*val2 = 500000;
>> +		return IIO_VAL_INT_PLUS_MICRO;
>> +
>> +	case AXP192_BATT_V:
>> +		*val = 1;
>> +		*val2 = 100000;
>> +		return IIO_VAL_INT_PLUS_MICRO;
>> +
>> +	case AXP192_IPSOUT_V:
>> +		*val = 1;
>> +		*val2 = 400000;
>> +		return IIO_VAL_INT_PLUS_MICRO;
>> +
>> +	case AXP192_TS_IN:
>> +		/* 0.8 mV per LSB */
>> +		*val = 0;
>> +		*val2 = 800000;
>> +		return IIO_VAL_INT_PLUS_MICRO;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>>  static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
>>  {
>>  	switch (channel) {
>> @@ -380,6 +486,29 @@ static int axp20x_adc_scale_current(int channel, int *val, int *val2)
>>  	}
>>  }
>>  
>> +static int axp192_adc_scale(struct iio_chan_spec const *chan, int *val,
>> +			    int *val2)
>> +{
>> +	switch (chan->type) {
>> +	case IIO_VOLTAGE:
>> +		return axp192_adc_scale_voltage(chan->channel, val, val2);
>> +
>> +	case IIO_CURRENT:
>> +		/*
>> +		 * AXP192 current channels are identical to the AXP20x,
>> +		 * therefore we can re-use the scaling function.
>> +		 */
>> +		return axp20x_adc_scale_current(chan->channel, val, val2);
>> +
>> +	case IIO_TEMP:
>> +		*val = 100;
>> +		return IIO_VAL_INT;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>>  static int axp20x_adc_scale(struct iio_chan_spec const *chan, int *val,
>>  			    int *val2)
>>  {
>> @@ -439,6 +568,42 @@ static int axp813_adc_scale(struct iio_chan_spec const *chan, int *val,
>>  	}
>>  }
>>  
>> +static int axp192_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
>> +				     int *val)
>> +{
>> +	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret = regmap_read(info->regmap, AXP192_GPIO30_IN_RANGE, val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	switch (channel) {
>> +	case AXP192_GPIO0_V:
>> +		*val &= AXP192_GPIO30_IN_RANGE_GPIO0;
>
> Obviously existing case does it this way, but I'd prefer a local variable
> and FIELD_GET() for these.  Reusing *val for this is confusing.
>
> A precursor patch to tidy up earlier code would be great if you have
> time.
>

Ack

>> +		break;
>> +
>> +	case AXP192_GPIO1_V:
>> +		*val &= AXP192_GPIO30_IN_RANGE_GPIO1;
>> +		break;
>> +
>> +	case AXP192_GPIO2_V:
>> +		*val &= AXP192_GPIO30_IN_RANGE_GPIO2;
>> +		break;
>> +
>> +	case AXP192_GPIO3_V:
>> +		*val &= AXP192_GPIO30_IN_RANGE_GPIO3;
>> +		break;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	*val = *val ? 700000 : 0;
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>>  static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
>>  				     int *val)
>>  {
>> @@ -467,6 +632,22 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
>>  	return IIO_VAL_INT;
>>  }
>>  
>> +static int axp192_adc_offset(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan, int *val)
>> +{
>> +	switch (chan->type) {
>> +	case IIO_VOLTAGE:
>> +		return axp192_adc_offset_voltage(indio_dev, chan->channel, val);
>> +
>> +	case IIO_TEMP:
>> +		*val = -1447;
>> +		return IIO_VAL_INT;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>>  static int axp20x_adc_offset(struct iio_dev *indio_dev,
>>  			     struct iio_chan_spec const *chan, int *val)
>>  {
>> @@ -483,6 +664,25 @@ static int axp20x_adc_offset(struct iio_dev *indio_dev,
>>  	}
>>  }
>>  
>> +static int axp192_read_raw(struct iio_dev *indio_dev,
>> +			   struct iio_chan_spec const *chan, int *val,
>> +			   int *val2, long mask)
>> +{
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		return axp192_adc_offset(indio_dev, chan, val);
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		return axp192_adc_scale(chan, val, val2);
>> +
>> +	case IIO_CHAN_INFO_RAW:
>> +		return axp20x_adc_raw(indio_dev, chan, val);
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>>  static int axp20x_read_raw(struct iio_dev *indio_dev,
>>  			   struct iio_chan_spec const *chan, int *val,
>>  			   int *val2, long mask)
>> @@ -543,6 +743,54 @@ static int axp813_read_raw(struct iio_dev *indio_dev,
>>  	}
>>  }
>>  
>> +static int axp192_write_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan, int val, int val2,
>> +			    long mask)
>> +{
>> +	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>> +	unsigned int reg, regval;
>> +
>> +	/*
>> +	 * The AXP192 PMIC allows the user to choose between 0V and 0.7V offsets
>> +	 * for (independently) GPIO0-3 when in ADC mode.
>> +	 */
>> +	if (mask != IIO_CHAN_INFO_OFFSET)
>> +		return -EINVAL;
>> +
>> +	if (val != 0 && val != 700000)
>> +		return -EINVAL;
>> +
>> +	val = val ? 1 : 0;
>
> Use a local variable for this. It's no longer val in any way so the
> reuse is confusing.
>

Ack, I'll also clean up the existing code that I copied this from.

>> +
>> +	switch (chan->channel) {
>> +	case AXP192_GPIO0_V:
>> +		reg = AXP192_GPIO30_IN_RANGE_GPIO0;
>> +		regval = AXP192_GPIO30_IN_RANGE_GPIO0_VAL(val);
>
> FIELD_PREP()
>

Ack

>> +		break;
>> +
>> +	case AXP192_GPIO1_V:
>> +		reg = AXP192_GPIO30_IN_RANGE_GPIO1;
>> +		regval = AXP192_GPIO30_IN_RANGE_GPIO1_VAL(val);
>> +		break;
>> +
>> +	case AXP192_GPIO2_V:
>> +		reg = AXP192_GPIO30_IN_RANGE_GPIO2;
>> +		regval = AXP192_GPIO30_IN_RANGE_GPIO2_VAL(val);
>> +		break;
>> +
>> +	case AXP192_GPIO3_V:
>> +		reg = AXP192_GPIO30_IN_RANGE_GPIO3;
>> +		regval = AXP192_GPIO30_IN_RANGE_GPIO3_VAL(val);
>> +		break;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return regmap_update_bits(info->regmap, AXP192_GPIO30_IN_RANGE, reg,
>> +				  regval);
>> +}
>> +
>>  static int axp20x_write_raw(struct iio_dev *indio_dev,
>>  			    struct iio_chan_spec const *chan, int val, int val2,
>>  			    long mask)
>> @@ -581,6 +829,18 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
>>  				  regval);
>>  }
>>  
>> +static int axp192_read_label(struct iio_dev *iio_dev,
>> +			     const struct iio_chan_spec *chan, char *label)
>> +{
>> +	return snprintf(label, PAGE_SIZE, "%s\n", chan->datasheet_name);
>> +}
>
> Unless I missed a previous patch adding labels to the other devices supported,
> this is the first driver to use these.  Why do they make sense here but not
> to add to existing supported devices?
>
> I don't particularly mind this addition, just looking for an explanation.
>

That'd be because 1d4ef9b39ebecca8 ("iio: core: Add optional symbolic
label to a device channel") added read_label in 2020, while the AXP
driver was introduced in 2017. I could add read_label for the other
chips while I'm here, for consistency.

One question I have is why read_label exists when the kernel already has
unique names for IIO channels. Why not just expose the datasheet_name to
userspace from the IIO core instead of making drivers do it?

>> +
>> +static const struct iio_info axp192_adc_iio_info = {
>> +	.read_raw = axp192_read_raw,
>> +	.write_raw = axp192_write_raw,
>> +	.read_label = axp192_read_label,
>> +};
>> +
>>  static const struct iio_info axp20x_adc_iio_info = {
>>  	.read_raw = axp20x_read_raw,
>>  	.write_raw = axp20x_write_raw,
>> @@ -620,19 +880,29 @@ struct axp_data {
>>  	int				num_channels;
>>  	struct iio_chan_spec const	*channels;
>>  	unsigned long			adc_en1_mask;
>> +	unsigned long			adc_en2_mask;
>>  	int				(*adc_rate)(struct axp20x_adc_iio *info,
>>  						    int rate);
>> -	bool				adc_en2;
>>  	struct iio_map			*maps;
>>  };
>>  
>> +static const struct axp_data axp192_data = {
>> +	.iio_info = &axp192_adc_iio_info,
>> +	.num_channels = ARRAY_SIZE(axp192_adc_channels),
>> +	.channels = axp192_adc_channels,
>> +	.adc_en1_mask = AXP192_ADC_EN1_MASK,
>> +	.adc_en2_mask = AXP192_ADC_EN2_MASK,
>> +	.adc_rate = axp20x_adc_rate,
>> +	.maps = axp20x_maps,
>> +};
>> +
>>  static const struct axp_data axp20x_data = {
>>  	.iio_info = &axp20x_adc_iio_info,
>>  	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
>>  	.channels = axp20x_adc_channels,
>>  	.adc_en1_mask = AXP20X_ADC_EN1_MASK,
>> +	.adc_en2_mask = AXP20X_ADC_EN2_MASK,
>>  	.adc_rate = axp20x_adc_rate,
>> -	.adc_en2 = true,
>>  	.maps = axp20x_maps,
>>  };
>>  
>> @@ -642,7 +912,6 @@ static const struct axp_data axp22x_data = {
>>  	.channels = axp22x_adc_channels,
>>  	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
>>  	.adc_rate = axp22x_adc_rate,
>> -	.adc_en2 = false,
>>  	.maps = axp22x_maps,
>>  };
>>  
>> @@ -652,11 +921,11 @@ static const struct axp_data axp813_data = {
>>  	.channels = axp813_adc_channels,
>>  	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
>>  	.adc_rate = axp813_adc_rate,
>> -	.adc_en2 = false,
>>  	.maps = axp22x_maps,
>>  };
>>  
>>  static const struct of_device_id axp20x_adc_of_match[] = {
>> +	{ .compatible = "x-powers,axp192-adc", .data = (void *)&axp192_data, },
>>  	{ .compatible = "x-powers,axp209-adc", .data = (void *)&axp20x_data, },
>>  	{ .compatible = "x-powers,axp221-adc", .data = (void *)&axp22x_data, },
>>  	{ .compatible = "x-powers,axp813-adc", .data = (void *)&axp813_data, },
>> @@ -665,6 +934,7 @@ static const struct of_device_id axp20x_adc_of_match[] = {
>>  MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
>>  
>>  static const struct platform_device_id axp20x_adc_id_match[] = {
>> +	{ .name = "axp192-adc", .driver_data = (kernel_ulong_t)&axp192_data, },
>>  	{ .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
>>  	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
>>  	{ .name = "axp813-adc", .driver_data = (kernel_ulong_t)&axp813_data, },
>> @@ -710,10 +980,11 @@ static int axp20x_probe(struct platform_device *pdev)
>>  	/* Enable the ADCs on IP */
>>  	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
>>  
>> -	if (info->data->adc_en2)
>> -		/* Enable GPIO0/1 and internal temperature ADCs */
>> +	if (info->data->adc_en2_mask)
>> +		/* Enable GPIO and internal temperature ADCs */
>>  		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
>> -				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
>> +				   info->data->adc_en2_mask,
>> +				   info->data->adc_en2_mask);
>>  
>>  	/* Configure ADCs rate */
>>  	info->data->adc_rate(info, 100);
>> @@ -738,7 +1009,7 @@ static int axp20x_probe(struct platform_device *pdev)
>>  fail_map:
>>  	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>>  
>> -	if (info->data->adc_en2)
>> +	if (info->data->adc_en2_mask)
>>  		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
>>  
>>  	return ret;
>> @@ -754,7 +1025,7 @@ static int axp20x_remove(struct platform_device *pdev)
>>  
>>  	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>>  
>> -	if (info->data->adc_en2)
>> +	if (info->data->adc_en2_mask)
>>  		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
>>  
>>  	return 0;
