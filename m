Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D625E54AF1F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356191AbiFNLOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356294AbiFNLNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:13:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB9720BDA;
        Tue, 14 Jun 2022 04:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA1D8B817DD;
        Tue, 14 Jun 2022 11:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FAEC3411B;
        Tue, 14 Jun 2022 11:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655205218;
        bh=ENxCaP9Rk2nwCR/0WD0QuKmb7cfrw4GmQwwV0iSrjDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hh/l9xxP/UpxZHcucnAZAY/2RPjW7ZhykKXFR6o3nwKC/acvwOOH4YnGjj4s73SNd
         wUSW17MZVdj57vBp2pyVAGWMxf+qqdnBXm9a0WRI8wvxclb8y5xTasUfiNLsgoe1LL
         7W58vY00SoFalY3Jut9SMdvcEkwp8zTLXgohjLIuHTH9UNwoUs0E4z4z9jMc6lvZXl
         ZZSXFa8KUxzcY5AEN4764+vN/Nt/L784GhIgknu/WlMqKpNSxYPdZEIxgQnpL/aqxK
         rF5lb+Vql3JtQTeQBGrALUAHnn2im5cZfX8Ge/1t6HpSaGRzmWt2hZX202OXaDsR/J
         uCh1vslFlNAiw==
Date:   Tue, 14 Jun 2022 12:22:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: stx104: Implement and utilize register
 structures
Message-ID: <20220614122248.7f257556@jic23-huawei>
In-Reply-To: <a2dca9435f7f1f727c696a1faa0ab9e27927f9f3.1654118389.git.william.gray@linaro.org>
References: <cover.1654118389.git.william.gray@linaro.org>
        <a2dca9435f7f1f727c696a1faa0ab9e27927f9f3.1654118389.git.william.gray@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jun 2022 10:15:17 -0400
William Breathitt Gray <william.gray@linaro.org> wrote:

> Reduce magic numbers and improve code readability by implementing and
> utilizing named register data structures.
> 
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

A few comments inline, but looks fine to me otherwise.

Jonathan

> ---
>  drivers/iio/adc/stx104.c | 70 +++++++++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
> index 7552351bfed9..7656b363e281 100644
> --- a/drivers/iio/adc/stx104.c
> +++ b/drivers/iio/adc/stx104.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/spinlock.h>
> +#include <linux/types.h>
>  
>  #define STX104_OUT_CHAN(chan) {				\
>  	.type = IIO_VOLTAGE,				\
> @@ -44,14 +45,36 @@ static unsigned int num_stx104;
>  module_param_hw_array(base, uint, ioport, &num_stx104, 0);
>  MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
>  
> +/**
> + * struct stx104_reg - device register structure
> + * @ad:		ADC Data
> + * @achan:	ADC Channel
> + * @dio:	Digital I/O
> + * @dac:	DAC Channels
> + * @cir_asr:	Clear Interrupts and ADC Status
> + * @acr:	ADC Control
> + * @pccr_fsh:	Pacer Clock Control and FIFO Status MSB
> + * @acfg:	ADC Configuration
> + */
> +struct stx104_reg {
> +	u16 ad;
> +	u8 achan;
> +	u8 dio;
> +	u16 dac[2];
> +	u8 cir_asr;
> +	u8 acr;
> +	u8 pccr_fsh;
> +	u8 acfg;
> +};
> +
>  /**
>   * struct stx104_iio - IIO device private data structure
>   * @chan_out_states:	channels' output states
> - * @base:		base port address of the IIO device
> + * @reg:		I/O address offset for the device registers
>   */
>  struct stx104_iio {
>  	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
> -	void __iomem *base;
> +	struct stx104_reg __iomem *reg;
>  };
>  
>  /**
> @@ -64,7 +87,7 @@ struct stx104_iio {
>  struct stx104_gpio {
>  	struct gpio_chip chip;
>  	spinlock_t lock;
> -	void __iomem *base;
> +	u8 __iomem *base;
>  	unsigned int out_state;
>  };
>  
> @@ -72,6 +95,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>  {
>  	struct stx104_iio *const priv = iio_priv(indio_dev);
> +	struct stx104_reg __iomem *const reg = priv->reg;
>  	unsigned int adc_config;
>  	int adbu;
>  	int gain;
> @@ -79,7 +103,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
>  		/* get gain configuration */
> -		adc_config = ioread8(priv->base + 11);
> +		adc_config = ioread8(&reg->acfg);
>  		gain = adc_config & 0x3;
>  
>  		*val = 1 << gain;
> @@ -91,24 +115,24 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
>  		}
>  
>  		/* select ADC channel */
> -		iowrite8(chan->channel | (chan->channel << 4), priv->base + 2);
> +		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
>  
>  		/* trigger ADC sample capture and wait for completion */
> -		iowrite8(0, priv->base);
> -		while (ioread8(priv->base + 8) & BIT(7));
> +		iowrite8(0, &reg->ad);

Curious - 8 bit write to a 16 bit address?  Maybe worth a comment
on why.

> +		while (ioread8(&reg->cir_asr) & BIT(7));
>  
> -		*val = ioread16(priv->base);
> +		*val = ioread16(&reg->ad);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OFFSET:
>  		/* get ADC bipolar/unipolar configuration */
> -		adc_config = ioread8(priv->base + 11);
> +		adc_config = ioread8(&reg->acfg);
>  		adbu = !(adc_config & BIT(2));
>  
>  		*val = -32768 * adbu;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		/* get ADC bipolar/unipolar and gain configuration */
> -		adc_config = ioread8(priv->base + 11);
> +		adc_config = ioread8(&reg->acfg);
>  		adbu = !(adc_config & BIT(2));
>  		gain = adc_config & 0x3;
>  
> @@ -130,16 +154,16 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
>  		/* Only four gain states (x1, x2, x4, x8) */
>  		switch (val) {
>  		case 1:
> -			iowrite8(0, priv->base + 11);
> +			iowrite8(0, &priv->reg->acfg);
>  			break;
>  		case 2:
> -			iowrite8(1, priv->base + 11);
> +			iowrite8(1, &priv->reg->acfg);
>  			break;
>  		case 4:
> -			iowrite8(2, priv->base + 11);
> +			iowrite8(2, &priv->reg->acfg);
>  			break;
>  		case 8:
> -			iowrite8(3, priv->base + 11);
> +			iowrite8(3, &priv->reg->acfg);
>  			break;
>  		default:
>  			return -EINVAL;
> @@ -153,7 +177,7 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
>  				return -EINVAL;
>  
>  			priv->chan_out_states[chan->channel] = val;
> -			iowrite16(val, priv->base + 4 + 2 * chan->channel);
> +			iowrite16(val, priv->reg->dac + chan->channel);
Perhaps for consistency with below go with
&priv->reg->dac[chan->channels];

>  
>  			return 0;
>  		}
> @@ -307,15 +331,15 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  	}
>  
>  	priv = iio_priv(indio_dev);
> -	priv->base = devm_ioport_map(dev, base[id], STX104_EXTENT);
> -	if (!priv->base)
> +	priv->reg = devm_ioport_map(dev, base[id], STX104_EXTENT);
> +	if (!priv->reg)
>  		return -ENOMEM;
>  
>  	indio_dev->info = &stx104_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	/* determine if differential inputs */
> -	if (ioread8(priv->base + 8) & BIT(5)) {
> +	if (ioread8(&priv->reg->cir_asr) & BIT(5)) {
>  		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_diff);
>  		indio_dev->channels = stx104_channels_diff;
>  	} else {
> @@ -326,14 +350,14 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  	indio_dev->name = dev_name(dev);
>  
>  	/* configure device for software trigger operation */
> -	iowrite8(0, priv->base + 9);
> +	iowrite8(0, &priv->reg->acr);
>  
>  	/* initialize gain setting to x1 */
> -	iowrite8(0, priv->base + 11);
> +	iowrite8(0, &priv->reg->acfg);
>  
>  	/* initialize DAC output to 0V */
> -	iowrite16(0, priv->base + 4);
> -	iowrite16(0, priv->base + 6);
> +	iowrite16(0, &priv->reg->dac[0]);
> +	iowrite16(0, &priv->reg->dac[1]);
>  
>  	stx104gpio->chip.label = dev_name(dev);
>  	stx104gpio->chip.parent = dev;
> @@ -348,7 +372,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
>  	stx104gpio->chip.set = stx104_gpio_set;
>  	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
> -	stx104gpio->base = priv->base + 3;
> +	stx104gpio->base = &priv->reg->dio;
>  	stx104gpio->out_state = 0x0;
>  
>  	spin_lock_init(&stx104gpio->lock);

