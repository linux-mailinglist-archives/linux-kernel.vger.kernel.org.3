Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2C9543140
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbiFHNWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbiFHNWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:22:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756E95641D;
        Wed,  8 Jun 2022 06:22:45 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJ7Cr1SYjz6H6pl;
        Wed,  8 Jun 2022 21:21:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 15:22:42 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 14:22:41 +0100
Date:   Wed, 8 Jun 2022 14:22:40 +0100
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
Subject: Re: [PATCH v2 10/17] iio: adc: axp20x_adc: Minor code cleanups
Message-ID: <20220608142240.00001161@Huawei.com>
In-Reply-To: <20220607155324.118102-11-aidanmacdonald.0x0@gmail.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
        <20220607155324.118102-11-aidanmacdonald.0x0@gmail.com>
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

On Tue,  7 Jun 2022 16:53:17 +0100
Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:

> The code may be clearer if parameters are not re-purposed to hold
> temporary results like register values, so introduce local variables
> as necessary to avoid that. Also, use the common FIELD_PREP macro
> instead of a hand-rolled version.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Hi Aidan,

Looks good.  One trivial further suggestion inline.

Also, am I fine picking up the IIO patches, or does the whole
set need to go in via mfd?

Thanks,

Jonathan

> ---
>  drivers/iio/adc/axp20x_adc.c | 61 +++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 53bf7d4899d2..9d5b1de24908 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -15,6 +15,7 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
> +#include <linux/bitfield.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
> @@ -22,20 +23,20 @@
>  #include <linux/mfd/axp20x.h>
>  
>  #define AXP20X_ADC_EN1_MASK			GENMASK(7, 0)
> -
>  #define AXP20X_ADC_EN2_MASK			(GENMASK(3, 2) | BIT(7))
> +
>  #define AXP22X_ADC_EN1_MASK			(GENMASK(7, 5) | BIT(0))
>  
>  #define AXP20X_GPIO10_IN_RANGE_GPIO0		BIT(0)
>  #define AXP20X_GPIO10_IN_RANGE_GPIO1		BIT(1)
> -#define AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(x)	((x) & BIT(0))
> -#define AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(x)	(((x) & BIT(0)) << 1)
>  
>  #define AXP20X_ADC_RATE_MASK			GENMASK(7, 6)
> -#define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
> -#define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
>  #define AXP20X_ADC_RATE_HZ(x)			((ilog2((x) / 25) << 6) & AXP20X_ADC_RATE_MASK)
> +
>  #define AXP22X_ADC_RATE_HZ(x)			((ilog2((x) / 100) << 6) & AXP20X_ADC_RATE_MASK)
> +
> +#define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
> +#define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
>  #define AXP813_TS_GPIO0_ADC_RATE_HZ(x)		AXP20X_ADC_RATE_HZ(x)
>  #define AXP813_V_I_ADC_RATE_HZ(x)		((ilog2((x) / 100) << 4) & AXP813_V_I_ADC_RATE_MASK)
>  #define AXP813_ADC_RATE_HZ(x)			(AXP20X_ADC_RATE_HZ(x) | AXP813_V_I_ADC_RATE_HZ(x))
> @@ -234,7 +235,7 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
>  			  struct iio_chan_spec const *chan, int *val)
>  {
>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> -	int size = 12;
> +	int ret, size;
>  
>  	/*
>  	 * N.B.:  Unlike the Chinese datasheets tell, the charging current is
> @@ -246,10 +247,11 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
>  	else
>  		size = 12;
>  
> -	*val = axp20x_read_variable_width(info->regmap, chan->address, size);
> -	if (*val < 0)
> -		return *val;
> +	ret = axp20x_read_variable_width(info->regmap, chan->address, size);
> +	if (ret < 0)
> +		return ret;
>  
> +	*val = ret;
>  	return IIO_VAL_INT;
>  }
>  
> @@ -257,11 +259,13 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
>  			  struct iio_chan_spec const *chan, int *val)
>  {
>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +	int ret;
>  
> -	*val = axp20x_read_variable_width(info->regmap, chan->address, 12);
> -	if (*val < 0)
> -		return *val;
> +	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
> +	if (ret < 0)
> +		return ret;
>  
> +	*val = ret;
>  	return IIO_VAL_INT;
>  }
>  
> @@ -269,11 +273,13 @@ static int axp813_adc_raw(struct iio_dev *indio_dev,
>  			  struct iio_chan_spec const *chan, int *val)
>  {
>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +	int ret;
>  
> -	*val = axp20x_read_variable_width(info->regmap, chan->address, 12);
> -	if (*val < 0)
> -		return *val;
> +	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
> +	if (ret < 0)
> +		return ret;
>  
> +	*val = ret;
>  	return IIO_VAL_INT;
>  }
>  
> @@ -443,27 +449,27 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
>  				     int *val)
>  {
>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +	unsigned int regval;
>  	int ret;
>  
> -	ret = regmap_read(info->regmap, AXP20X_GPIO10_IN_RANGE, val);
> +	ret = regmap_read(info->regmap, AXP20X_GPIO10_IN_RANGE, &regval);
>  	if (ret < 0)
>  		return ret;
>  
>  	switch (channel) {
>  	case AXP20X_GPIO0_V:
> -		*val &= AXP20X_GPIO10_IN_RANGE_GPIO0;
> +		regval &= AXP20X_GPIO10_IN_RANGE_GPIO0;

Maybe use FIELD_GET() here to be clear you are extracting that
field (even though we don't care about the shift).

Hopefully the compiler will be clever enough to remove the shift
anyway and using FIELD_GET() would act as slightly more 'documentation
in code'.



>  		break;
>  
>  	case AXP20X_GPIO1_V:
> -		*val &= AXP20X_GPIO10_IN_RANGE_GPIO1;
> +		regval &= AXP20X_GPIO10_IN_RANGE_GPIO1;
>  		break;
>  
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	*val = *val ? 700000 : 0;
> -
> +	*val = regval ? 700000 : 0;
>  	return IIO_VAL_INT;
>  }
>  
> @@ -548,7 +554,7 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> -	unsigned int reg, regval;
> +	unsigned int regmask, regval;
>  
>  	/*
>  	 * The AXP20X PMIC allows the user to choose between 0V and 0.7V offsets
> @@ -560,25 +566,24 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
>  	if (val != 0 && val != 700000)
>  		return -EINVAL;
>  
> -	val = val ? 1 : 0;
> +	regval = val ? 1 : 0;
>  
>  	switch (chan->channel) {
>  	case AXP20X_GPIO0_V:
> -		reg = AXP20X_GPIO10_IN_RANGE_GPIO0;
> -		regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(val);
> +		regmask = AXP20X_GPIO10_IN_RANGE_GPIO0;
> +		regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO0, regval);
>  		break;
>  
>  	case AXP20X_GPIO1_V:
> -		reg = AXP20X_GPIO10_IN_RANGE_GPIO1;
> -		regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(val);
> +		regmask = AXP20X_GPIO10_IN_RANGE_GPIO1;
> +		regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO1, regval);
>  		break;
>  
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, reg,
> -				  regval);
> +	return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, regmask, regval);
>  }
>  
>  static const struct iio_info axp20x_adc_iio_info = {

