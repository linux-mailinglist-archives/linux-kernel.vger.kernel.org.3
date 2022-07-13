Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D8D573AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiGMQLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbiGMQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:11:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5444E501AF;
        Wed, 13 Jul 2022 09:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9DE661AD5;
        Wed, 13 Jul 2022 16:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30801C34114;
        Wed, 13 Jul 2022 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657728705;
        bh=xKgCGVq47wtNXtj8TX6Re2zKYRejln4t9WqBUbpnVhE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z4h44caKqvqkIvqs6HwQUOqADIwkLjFK//iczkKgVOJrp/Eas6LK4iyLCD4Ov5k2G
         BqGD/3kXLf7rE5BaYi3JLXh9b15l1aCsvyyYQWwtQs33kMSVTTS0h9oSvqYhvZ/qVu
         aMGgz2kWO5W/9QNWb0NnctlyYTVmDKuy/GhcbdEa8V9qdJftMCwIrWDzU/XRrB6IzY
         dhN/9wTMVkywR+n7Uw5rZTYBi3ARAaMUMS3PqKhsYDGzwW+8dif2F8cbWziuzDhiVV
         cHoPYWSwX9w7M+Xi7Cw+/yZrFzmCvosbIpXPPsZ/IHXCAyKej9PpFDNCNLEvTatqaL
         Knll34e5QIt2Q==
Date:   Wed, 13 Jul 2022 17:21:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <j.neuschaefer@gmx.net>,
        <zhengbin13@huawei.com>, <openbmc@lists.ozlabs.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: npcm: Add NPCM8XX support
Message-ID: <20220713172132.0bc5002d@jic23-huawei>
In-Reply-To: <20220713132640.215916-3-tmaimon77@gmail.com>
References: <20220713132640.215916-1-tmaimon77@gmail.com>
        <20220713132640.215916-3-tmaimon77@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 16:26:40 +0300
Tomer Maimon <tmaimon77@gmail.com> wrote:

> Adding ADC NPCM8XX support to NPCM ADC driver.
> ADC NPCM8XX uses a different resolution and voltage reference.
> 
> As part of adding NPCM8XX support:
> - Add NPCM8XX specific compatible string.
> - Add data to handle architecture-specific ADC parameters.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
missing 

#include <linux/property.h> 

So in current IIO togreg tree this doesn't build.  I could fix it up
but given we are very late in cycle and I'd like to give this a little
more time on list for Andy to take another look if he wishes, chances
are this won't make it in until early next cycle.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/npcm_adc.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> index f7bc0bb7f112..4c7ebcd57b88 100644
> --- a/drivers/iio/adc/npcm_adc.c
> +++ b/drivers/iio/adc/npcm_adc.c
> @@ -16,6 +16,12 @@
>  #include <linux/uaccess.h>
>  #include <linux/reset.h>
>  
> +struct npcm_adc_info {
> +	u32 data_mask;
> +	u32 internal_vref;
> +	u32 res_bits;
> +};
> +
>  struct npcm_adc {
>  	bool int_status;
>  	u32 adc_sample_hz;
> @@ -34,6 +40,7 @@ struct npcm_adc {
>  	 * has finished.
>  	 */
>  	struct mutex lock;
> +	const struct npcm_adc_info *data;
>  };
>  
>  /* ADC registers */
> @@ -52,13 +59,21 @@ struct npcm_adc {
>  #define NPCM_ADCCON_CH(x)		((x) << 24)
>  #define NPCM_ADCCON_DIV_SHIFT		1
>  #define NPCM_ADCCON_DIV_MASK		GENMASK(8, 1)
> -#define NPCM_ADC_DATA_MASK(x)		((x) & GENMASK(9, 0))
>  
>  #define NPCM_ADC_ENABLE		(NPCM_ADCCON_ADC_EN | NPCM_ADCCON_ADC_INT_EN)
>  
>  /* ADC General Definition */
> -#define NPCM_RESOLUTION_BITS		10
> -#define NPCM_INT_VREF_MV		2000
> +static const struct npcm_adc_info npxm7xx_adc_info = {
> +	.data_mask = GENMASK(9, 0),
> +	.internal_vref = 2048,
> +	.res_bits = 10,
> +};
> +
> +static const struct npcm_adc_info npxm8xx_adc_info = {
> +	.data_mask = GENMASK(11, 0),
> +	.internal_vref = 1229,
> +	.res_bits = 12,
> +};
>  
>  #define NPCM_ADC_CHAN(ch) {					\
>  	.type = IIO_VOLTAGE,					\
> @@ -129,7 +144,8 @@ static int npcm_adc_read(struct npcm_adc *info, int *val, u8 channel)
>  	if (ret < 0)
>  		return ret;
>  
> -	*val = NPCM_ADC_DATA_MASK(ioread32(info->regs + NPCM_ADCDATA));
> +	*val = ioread32(info->regs + NPCM_ADCDATA);
> +	*val &= info->data->data_mask;
>  
>  	return 0;
>  }
> @@ -157,9 +173,9 @@ static int npcm_adc_read_raw(struct iio_dev *indio_dev,
>  			vref_uv = regulator_get_voltage(info->vref);
>  			*val = vref_uv / 1000;
>  		} else {
> -			*val = NPCM_INT_VREF_MV;
> +			*val = info->data->internal_vref;
>  		}
> -		*val2 = NPCM_RESOLUTION_BITS;
> +		*val2 = info->data->res_bits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val = info->adc_sample_hz;
> @@ -176,7 +192,8 @@ static const struct iio_info npcm_adc_iio_info = {
>  };
>  
>  static const struct of_device_id npcm_adc_match[] = {
> -	{ .compatible = "nuvoton,npcm750-adc", },
> +	{ .compatible = "nuvoton,npcm750-adc", .data = &npxm7xx_adc_info},
> +	{ .compatible = "nuvoton,npcm845-adc", .data = &npxm8xx_adc_info},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, npcm_adc_match);
> @@ -196,6 +213,10 @@ static int npcm_adc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	info = iio_priv(indio_dev);
>  
> +	info->data = device_get_match_data(dev);
> +	if (!info->data)
> +		return -EINVAL;
> +
>  	mutex_init(&info->lock);
>  
>  	info->dev = &pdev->dev;

