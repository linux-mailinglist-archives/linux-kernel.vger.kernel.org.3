Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D50F54317A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbiFHNfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbiFHNfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:35:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B84279812;
        Wed,  8 Jun 2022 06:35:19 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJ7Rh263Jz6875y;
        Wed,  8 Jun 2022 21:31:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 15:35:16 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 14:35:15 +0100
Date:   Wed, 8 Jun 2022 14:35:14 +0100
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
Subject: Re: [PATCH v2 12/17] iio: adc: axp20x_adc: Add support for AXP192
Message-ID: <20220608143514.00005b9b@Huawei.com>
In-Reply-To: <20220607155324.118102-13-aidanmacdonald.0x0@gmail.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
        <20220607155324.118102-13-aidanmacdonald.0x0@gmail.com>
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

On Tue,  7 Jun 2022 16:53:19 +0100
Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:

> The AXP192 is identical to the AXP20x, except for the addition of
> two more GPIO ADC channels.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Hi Aidan,

A few things follow through from review of previous 2 patches.
Otherwise looks good to me.

Thanks,

Jonathan


>  	AXP20X_ADC_CHANNEL(AXP20X_ACIN_V, "acin_v", IIO_VOLTAGE,
>  			   AXP20X_ACIN_V_ADC_H),
> @@ -250,6 +314,15 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
>  	int ret, size;
>  
>  	switch (info->data->axp20x_id) {
> +	case AXP192_ID:
> +		/* Battery current ADCs on the AXP192 are 13 bits. */
> +		if (chan->type == IIO_CURRENT &&
> +		    (chan->channel == AXP20X_BATT_CHRG_I || chan->channel == AXP20X_BATT_DISCHRG_I))

Ah, you'll be needing two _res variables as suggested in earlier patch.

> +			size = 13;
> +		else
> +			size = 12;
> +		break;
> +
>  	case AXP202_ID:
>  	case AXP209_ID:
>  		/*
> @@ -276,6 +349,44 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
>  	return IIO_VAL_INT;
>  }

...

> +static int axp192_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
> +				     int *val)
> +{
> +	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(info->regmap, AXP192_GPIO30_IN_RANGE, &regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (channel) {
> +	case AXP192_GPIO0_V:
> +		regval &= AXP192_GPIO30_IN_RANGE_GPIO0;

As per earlier patch, FIELD_GET() would act as 'documentation'
of what is going on here, even though it'll make no real difference.

> +		break;
> +
> +	case AXP192_GPIO1_V:
> +		regval &= AXP192_GPIO30_IN_RANGE_GPIO1;
> +		break;
> +
> +	case AXP192_GPIO2_V:
> +		regval &= AXP192_GPIO30_IN_RANGE_GPIO2;
> +		break;
> +
> +	case AXP192_GPIO3_V:
> +		regval &= AXP192_GPIO30_IN_RANGE_GPIO3;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	*val = regval ? 700000 : 0;
> +	return IIO_VAL_INT;
> +}
> +
