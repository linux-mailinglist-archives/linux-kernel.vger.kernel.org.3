Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A08854535D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344587AbiFIRuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245571AbiFIRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:50:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339AF21D;
        Thu,  9 Jun 2022 10:50:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d14so6638582eda.12;
        Thu, 09 Jun 2022 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=0XskcUVqnA6r5CptCBzAguc49yR2w4k2s0FdtujbgmE=;
        b=p/6bnwy66jbaWhRXzvyDqpRiX5oIcKqrBvgM/S2yeKcMGnzVmXHwuXJzIokTl0IWts
         IQXn3lX/U4JphYcrS/yiI0ZHQ2LlXCtELshvjjumQRaxS64nWJK77mGp2pBchMxYXtPJ
         BYnJCKpwiTC0YehP0IBimzvL2wyyd2KjJDYPc/kA1Ws5DqTUlSumEsWgdD7qgZ+VcNhK
         7DzqnUGv9IqG90N3KbbGelkbNi4fuyd6xrtMIEzJwnig2aXxR7tkCPcgKaUXl8EqkWLg
         cNf+46+VBGfan80CFSA6PsmuvnyY+sN6dTEv2ymgoehXug0VVHaKVSE814UfalbWzgDu
         6Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=0XskcUVqnA6r5CptCBzAguc49yR2w4k2s0FdtujbgmE=;
        b=UIal195fDRVabDbfMkrKauixMBx3BE59QkDOQhutiWOmNVObWcUeYabGDjCPKpA7Ap
         SqklgZRRMJWbMVEgZIXHj8h0jDTQro157X2mOVTVjHmpaR/F6C+8pNBKlY+VKkk+3CR/
         qZ/nUporPNWU5vspLLnHNBSX9AzQKSQG3h95nnwW4OIQujjfA6rpwcHlkUjPT15f1CVM
         P1DC7j8JNmyL4L1+lClTnKW9SuiIZ5JP/eXgcq8UcHgSqtvVSGYumETVaf0yVpaIXAFt
         Ueq3xdGBJsG+XWppAE99sB+31zCd6rnEGJTNC5jAhUyYGtzKN3jOdLHJjE/WVSX8BeXG
         Luwg==
X-Gm-Message-State: AOAM533ZhX/qcYsXTrF9R5Bukjy/s//bhTGoo789P+BWhXfrwwHayKM+
        7LTJ/aXrVlD+mR2Kea5W4tU=
X-Google-Smtp-Source: ABdhPJyQa4iYZLR6rVSvV1VGlaMr/rYrX4ug7kLrbCZORRq0xFSZhkrOafsh1Du6OOMz5xoiMdk7+g==
X-Received: by 2002:aa7:d441:0:b0:431:486b:2573 with SMTP id q1-20020aa7d441000000b00431486b2573mr28896923edr.60.1654797005687;
        Thu, 09 Jun 2022 10:50:05 -0700 (PDT)
Received: from localhost (92.40.202.100.threembb.co.uk. [92.40.202.100])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709064a8900b006f3ef214e2csm11228438eju.146.2022.06.09.10.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 10:50:04 -0700 (PDT)
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-12-aidanmacdonald.0x0@gmail.com>
 <20220608142808.00000650@Huawei.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 11/17] iio: adc: axp20x_adc: Consolidate ADC raw read
 functions
Date:   Thu, 09 Jun 2022 00:13:47 +0100
In-reply-to: <20220608142808.00000650@Huawei.com>
Message-ID: <6DEqBtaiVPj93S9KpELsBGaDLDnbWsEX@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Tue,  7 Jun 2022 16:53:18 +0100
> Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:
>
>> Add an axp20x_id variant field to the axp_data struct and use it
>> to consolidate the adc_raw functions, reducing code duplication.
>> Variant IDs are chosen to match the OF compatible strings.
>> 
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>
> Hi Aidan,
>
> I'm not a big fan of using variant IDs, rather than a description
> of what is actually different between devices.  Long term, variant
> IDs tend to scale (as we add more supported devices) much worse
> than a flag describing the actual difference.
>
> Here I would have a field in struct axp_data called something like
> discharge_curr_res and set it to 12 or 13 as appropriate.
>

I agree with your point in general, but here it seems impossible to get
away from variant IDs because the channel numbering depends on it and we
use the channel number to decide what number of bits to use. The code
I'm replacing is just disguising the variant IDs by giving every variant
its own set of functions.

To me it seemed clearer to describe the channel properties and then use
one read_raw function for all variants, but when I did that it turned
out not to make any difference in size for x86. Probably because tables
encode a lot of redundant information compared to switches. It also
relied on a hack to associate extra info with an iio_chan_spec so it
wasn't much of an improvement, in the end.

So it's a question of using a variant ID explicitly or having separate
functions for each device. Combining the functions with an explicit ID
saves 752 bytes on x86, once the axp192 is added, and I don't think it
is any harder to understand than the separate functions. And it's still
possible to use a separate function when needed.

Nonetheless, if you'd prefer to stick with separate functions I'm fine
with that.

Regards,
Aidan

>> ---
>>  drivers/iio/adc/axp20x_adc.c | 83 +++++++++++++++---------------------
>>  1 file changed, 34 insertions(+), 49 deletions(-)
>> 
>> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
>> index 9d5b1de24908..0260433782d8 100644
>> --- a/drivers/iio/adc/axp20x_adc.c
>> +++ b/drivers/iio/adc/axp20x_adc.c
>> @@ -71,6 +71,18 @@ struct axp20x_adc_iio {
>>  	const struct axp_data	*data;
>>  };
>>  
>> +struct axp_data {
>> +	const struct iio_info		*iio_info;
>> +	int				num_channels;
>> +	struct iio_chan_spec const	*channels;
>> +	unsigned long			adc_en1_mask;
>> +	unsigned long			adc_en2_mask;
>> +	int				(*adc_rate)(struct axp20x_adc_iio *info,
>> +						    int rate);
>> +	struct iio_map			*maps;
>> +	enum axp20x_variants		axp20x_id;
>> +};
>> +
>>  enum axp20x_adc_channel_v {
>>  	AXP20X_ACIN_V = 0,
>>  	AXP20X_VBUS_V,
>> @@ -237,15 +249,24 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
>>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>>  	int ret, size;
>>  
>> -	/*
>> -	 * N.B.:  Unlike the Chinese datasheets tell, the charging current is
>> -	 * stored on 12 bits, not 13 bits. Only discharging current is on 13
>> -	 * bits.
>> -	 */
>> -	if (chan->type == IIO_CURRENT && chan->channel == AXP20X_BATT_DISCHRG_I)
>> -		size = 13;
>> -	else
>> +	switch (info->data->axp20x_id) {
>> +	case AXP202_ID:
>> +	case AXP209_ID:
>> +		/*
>> +		 * N.B.:  Unlike the Chinese datasheets tell, the charging current is
>> +		 * stored on 12 bits, not 13 bits. Only discharging current is on 13
>> +		 * bits.
>> +		 */
>> +		if (chan->type == IIO_CURRENT && chan->channel == AXP20X_BATT_DISCHRG_I)
>
> This line is getting a bit long, break it after the &&
>
>> +			size = 13;
>> +		else
>> +			size = 12;
>> +		break;
>> +
>> +	default:
>>  		size = 12;
>> +		break;
>> +	}
>>  
>>  	ret = axp20x_read_variable_width(info->regmap, chan->address, size);
>>  	if (ret < 0)
>> @@ -255,34 +276,6 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
>>  	return IIO_VAL_INT;
>>  }
>>  
>> -static int axp22x_adc_raw(struct iio_dev *indio_dev,
>> -			  struct iio_chan_spec const *chan, int *val)
>> -{
>> -	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>> -	int ret;
>> -
>> -	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	*val = ret;
>> -	return IIO_VAL_INT;
>> -}
>> -
>> -static int axp813_adc_raw(struct iio_dev *indio_dev,
>> -			  struct iio_chan_spec const *chan, int *val)
>> -{
>> -	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>> -	int ret;
>> -
>> -	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	*val = ret;
>> -	return IIO_VAL_INT;
>> -}
>> -
>>  static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
>>  {
>>  	switch (channel) {
>> @@ -522,7 +515,7 @@ static int axp22x_read_raw(struct iio_dev *indio_dev,
>>  		return axp22x_adc_scale(chan, val, val2);
>>  
>>  	case IIO_CHAN_INFO_RAW:
>> -		return axp22x_adc_raw(indio_dev, chan, val);
>> +		return axp20x_adc_raw(indio_dev, chan, val);
>>  
>>  	default:
>>  		return -EINVAL;
>> @@ -542,7 +535,7 @@ static int axp813_read_raw(struct iio_dev *indio_dev,
>>  		return axp813_adc_scale(chan, val, val2);
>>  
>>  	case IIO_CHAN_INFO_RAW:
>> -		return axp813_adc_raw(indio_dev, chan, val);
>> +		return axp20x_adc_raw(indio_dev, chan, val);
>>  
>>  	default:
>>  		return -EINVAL;
>> @@ -620,17 +613,6 @@ static int axp813_adc_rate(struct axp20x_adc_iio *info, int rate)
>>  				 AXP813_ADC_RATE_HZ(rate));
>>  }
>>  
>> -struct axp_data {
>> -	const struct iio_info		*iio_info;
>> -	int				num_channels;
>> -	struct iio_chan_spec const	*channels;
>> -	unsigned long			adc_en1_mask;
>> -	int				(*adc_rate)(struct axp20x_adc_iio *info,
>> -						    int rate);
>> -	bool				adc_en2;
>> -	struct iio_map			*maps;
>> -};
>> -
>>  static const struct axp_data axp20x_data = {
>>  	.iio_info = &axp20x_adc_iio_info,
>>  	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
>> @@ -639,6 +621,7 @@ static const struct axp_data axp20x_data = {
>>  	.adc_rate = axp20x_adc_rate,
>>  	.adc_en2 = true,
>>  	.maps = axp20x_maps,
>> +	.axp20x_id = AXP209_ID,
>>  };
>>  
>>  static const struct axp_data axp22x_data = {
>> @@ -649,6 +632,7 @@ static const struct axp_data axp22x_data = {
>>  	.adc_rate = axp22x_adc_rate,
>>  	.adc_en2 = false,
>>  	.maps = axp22x_maps,
>> +	.axp20x_id = AXP221_ID,
>>  };
>>  
>>  static const struct axp_data axp813_data = {
>> @@ -659,6 +643,7 @@ static const struct axp_data axp813_data = {
>>  	.adc_rate = axp813_adc_rate,
>>  	.adc_en2 = false,
>>  	.maps = axp22x_maps,
>> +	.axp20x_id = AXP813_ID,
>>  };
>>  
>>  static const struct of_device_id axp20x_adc_of_match[] = {

