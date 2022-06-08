Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53177543157
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbiFHNa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbiFHNaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:30:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F12CE5C1;
        Wed,  8 Jun 2022 06:30:23 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJ7L04GtLz67J0f;
        Wed,  8 Jun 2022 21:26:48 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 15:30:21 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 14:30:20 +0100
Date:   Wed, 8 Jun 2022 14:30:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
CC:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <wens@csie.org>,
        <jic23@kernel.org>, <lee.jones@linaro.org>, <sre@kernel.org>,
        <broonie@kernel.org>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <lars@metafoo.de>, <rafael@kernel.org>,
        <quic_gurus@quicinc.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 11/17] iio: adc: axp20x_adc: Consolidate ADC raw read
 functions
Message-ID: <20220608143018.00005aa6@Huawei.com>
In-Reply-To: <20220607155324.118102-12-aidanmacdonald.0x0@gmail.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
        <20220607155324.118102-12-aidanmacdonald.0x0@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jun 2022 16:53:18 +0100
Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:

> Add an axp20x_id variant field to the axp_data struct and use it
> to consolidate the adc_raw functions, reducing code duplication.
> Variant IDs are chosen to match the OF compatible strings.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Also, try building after this patch....

> ---
>  drivers/iio/adc/axp20x_adc.c | 83 +++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 9d5b1de24908..0260433782d8 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -71,6 +71,18 @@ struct axp20x_adc_iio {
>  	const struct axp_data	*data;
>  };
>  
> +struct axp_data {
> +	const struct iio_info		*iio_info;
> +	int				num_channels;
> +	struct iio_chan_spec const	*channels;
> +	unsigned long			adc_en1_mask;
> +	unsigned long			adc_en2_mask;

This new field should be in the next patch.

> +	int				(*adc_rate)(struct axp20x_adc_iio *info,
> +						    int rate);
> +	struct iio_map			*maps;
> +	enum axp20x_variants		axp20x_id;
> +};
> +
>  enum axp20x_adc_channel_v {
>  	AXP20X_ACIN_V = 0,
>  	AXP20X_VBUS_V,
> @@ -237,15 +249,24 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>  	int ret, size;
>  
> -	/*
> -	 * N.B.:  Unlike the Chinese datasheets tell, the charging current is
> -	 * stored on 12 bits, not 13 bits. Only discharging current is on 13
> -	 * bits.
> -	 */
> -	if (chan->type == IIO_CURRENT && chan->channel == AXP20X_BATT_DISCHRG_I)
> -		size = 13;
> -	else
> +	switch (info->data->axp20x_id) {
> +	case AXP202_ID:
> +	case AXP209_ID:
> +		/*
> +		 * N.B.:  Unlike the Chinese datasheets tell, the charging current is
> +		 * stored on 12 bits, not 13 bits. Only discharging current is on 13
> +		 * bits.
> +		 */
> +		if (chan->type == IIO_CURRENT && chan->channel == AXP20X_BATT_DISCHRG_I)
> +			size = 13;
> +		else
> +			size = 12;
> +		break;
> +
> +	default:
>  		size = 12;
> +		break;
> +	}
>  
>  	ret = axp20x_read_variable_width(info->regmap, chan->address, size);
>  	if (ret < 0)
> @@ -255,34 +276,6 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
>  	return IIO_VAL_INT;
>  }
>  
> -static int axp22x_adc_raw(struct iio_dev *indio_dev,
> -			  struct iio_chan_spec const *chan, int *val)
> -{
> -	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
> -	if (ret < 0)
> -		return ret;
> -
> -	*val = ret;
> -	return IIO_VAL_INT;
> -}
> -
> -static int axp813_adc_raw(struct iio_dev *indio_dev,
> -			  struct iio_chan_spec const *chan, int *val)
> -{
> -	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
> -	if (ret < 0)
> -		return ret;
> -
> -	*val = ret;
> -	return IIO_VAL_INT;
> -}
> -
>  static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
>  {
>  	switch (channel) {
> @@ -522,7 +515,7 @@ static int axp22x_read_raw(struct iio_dev *indio_dev,
>  		return axp22x_adc_scale(chan, val, val2);
>  
>  	case IIO_CHAN_INFO_RAW:
> -		return axp22x_adc_raw(indio_dev, chan, val);
> +		return axp20x_adc_raw(indio_dev, chan, val);
>  
>  	default:
>  		return -EINVAL;
> @@ -542,7 +535,7 @@ static int axp813_read_raw(struct iio_dev *indio_dev,
>  		return axp813_adc_scale(chan, val, val2);
>  
>  	case IIO_CHAN_INFO_RAW:
> -		return axp813_adc_raw(indio_dev, chan, val);
> +		return axp20x_adc_raw(indio_dev, chan, val);
>  
>  	default:
>  		return -EINVAL;
> @@ -620,17 +613,6 @@ static int axp813_adc_rate(struct axp20x_adc_iio *info, int rate)
>  				 AXP813_ADC_RATE_HZ(rate));
>  }
>  
> -struct axp_data {
> -	const struct iio_info		*iio_info;
> -	int				num_channels;
> -	struct iio_chan_spec const	*channels;
> -	unsigned long			adc_en1_mask;
> -	int				(*adc_rate)(struct axp20x_adc_iio *info,
> -						    int rate);
> -	bool				adc_en2;
> -	struct iio_map			*maps;
> -};
> -
>  static const struct axp_data axp20x_data = {
>  	.iio_info = &axp20x_adc_iio_info,
>  	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
> @@ -639,6 +621,7 @@ static const struct axp_data axp20x_data = {
>  	.adc_rate = axp20x_adc_rate,
>  	.adc_en2 = true,
>  	.maps = axp20x_maps,
> +	.axp20x_id = AXP209_ID,
>  };
>  
>  static const struct axp_data axp22x_data = {
> @@ -649,6 +632,7 @@ static const struct axp_data axp22x_data = {
>  	.adc_rate = axp22x_adc_rate,
>  	.adc_en2 = false,
>  	.maps = axp22x_maps,
> +	.axp20x_id = AXP221_ID,
>  };
>  
>  static const struct axp_data axp813_data = {
> @@ -659,6 +643,7 @@ static const struct axp_data axp813_data = {
>  	.adc_rate = axp813_adc_rate,
>  	.adc_en2 = false,
>  	.maps = axp22x_maps,
> +	.axp20x_id = AXP813_ID,
>  };
>  
>  static const struct of_device_id axp20x_adc_of_match[] = {

