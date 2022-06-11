Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763465476EB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiFKRhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiFKRhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:37:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFFB25CF;
        Sat, 11 Jun 2022 10:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E01AB80AE4;
        Sat, 11 Jun 2022 17:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A10C34116;
        Sat, 11 Jun 2022 17:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654969028;
        bh=87s5IER2Hkii2UwGwmS+MjR5p1EgqGo8RMcZqPW65e4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XriqISjLhSiM1lS74ptrk8SHbnrzVrKf0BalmgOhxlZXfO1dUwyXqS7SWE9Wkl8ji
         3ZIukpf9swW+uROIXAdpH/NvYkYTh10KbyQuThF9Xa95I44B/a4BYPbcr0fOnSmqNx
         KsYGZgPcyh5jw+N7Oc/gTBQi98msaUJgJ1mHHJQ+U6+H+7ydk2TfxlJILvLWHD52qN
         qFQpSlZFZc7bQOj5zMOQgqZFnG2SqCDRxgkVT8m9R7ts3uj3MgKWdPhNVumAQYjbsh
         cf5UjtJP5qG4zbYtq4Upn5K4c8KcMnHJ1z/SMOxtCgzsk3ha3LS0fIlQ4sQwPZ+IZ8
         PNYH1dtMxsVMA==
Date:   Sat, 11 Jun 2022 18:46:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/16] iio: adc: at91-sama5d2_adc: handle different
 EMR.OSR for different hw versions
Message-ID: <20220611184617.0aa9eb85@jic23-huawei>
In-Reply-To: <20220609083213.1795019-5-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
        <20220609083213.1795019-5-claudiu.beznea@microchip.com>
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

On Thu, 9 Jun 2022 11:32:01 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> SAMA7G5 introduces 64 and 256 oversampling rates. Due to this EMR.OSR is 3
> bits long. Change the code to reflect this. Commit prepares the code
> for the addition of 64 and 256 oversampling rates.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 55 ++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index b76328da0cb2..1ceab097335c 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -138,8 +138,7 @@ struct at91_adc_reg_layout {
>  /* Extended Mode Register */
>  	u16				EMR;
>  /* Extended Mode Register - Oversampling rate */
> -#define AT91_SAMA5D2_EMR_OSR(V)			((V) << 16)
> -#define AT91_SAMA5D2_EMR_OSR_MASK		GENMASK(17, 16)
> +#define AT91_SAMA5D2_EMR_OSR(V, M)		(((V) << 16) & (M))
>  #define AT91_SAMA5D2_EMR_OSR_1SAMPLES		0
>  #define AT91_SAMA5D2_EMR_OSR_4SAMPLES		1
>  #define AT91_SAMA5D2_EMR_OSR_16SAMPLES		2
> @@ -403,6 +402,8 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>   * @max_index:		highest channel index (highest index may be higher
>   *			than the total channel number)
>   * @hw_trig_cnt:	number of possible hardware triggers
> + * @osr_mask:		oversampling ratio bitmask on EMR register
> + * @osr_vals:		available oversampling rates
>   */
>  struct at91_adc_platform {
>  	const struct at91_adc_reg_layout	*layout;
> @@ -414,6 +415,8 @@ struct at91_adc_platform {
>  	unsigned int				max_channels;
>  	unsigned int				max_index;
>  	unsigned int				hw_trig_cnt;
> +	unsigned int				osr_mask;
> +	unsigned int				osr_vals;
>  };
>  
>  /**
> @@ -612,6 +615,10 @@ static const struct at91_adc_platform sama5d2_platform = {
>  	.max_index = AT91_SAMA5D2_MAX_CHAN_IDX,
>  #define AT91_SAMA5D2_HW_TRIG_CNT	3
>  	.hw_trig_cnt = AT91_SAMA5D2_HW_TRIG_CNT,
> +	.osr_mask = GENMASK(17, 16),
> +	.osr_vals = BIT(AT91_SAMA5D2_EMR_OSR_1SAMPLES) |
> +		    BIT(AT91_SAMA5D2_EMR_OSR_4SAMPLES) |
> +		    BIT(AT91_SAMA5D2_EMR_OSR_16SAMPLES),
>  };
>  
>  static const struct at91_adc_platform sama7g5_platform = {
> @@ -627,6 +634,10 @@ static const struct at91_adc_platform sama7g5_platform = {
>  	.max_index = AT91_SAMA7G5_MAX_CHAN_IDX,
>  #define AT91_SAMA7G5_HW_TRIG_CNT	3
>  	.hw_trig_cnt = AT91_SAMA7G5_HW_TRIG_CNT,
> +	.osr_mask = GENMASK(18, 16),
> +	.osr_vals = BIT(AT91_SAMA5D2_EMR_OSR_1SAMPLES) |
> +		    BIT(AT91_SAMA5D2_EMR_OSR_4SAMPLES) |
> +		    BIT(AT91_SAMA5D2_EMR_OSR_16SAMPLES),
>  };
>  
>  static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
> @@ -725,34 +736,45 @@ static void at91_adc_eoc_ena(struct at91_adc_state *st, unsigned int channel)
>  		at91_adc_writel(st, EOC_IER, BIT(channel));
>  }
>  
> -static void at91_adc_config_emr(struct at91_adc_state *st)
> +static int at91_adc_config_emr(struct at91_adc_state *st,
> +			       u32 oversampling_ratio)
>  {
>  	/* configure the extended mode register */
>  	unsigned int emr = at91_adc_readl(st, EMR);
> +	unsigned int osr_mask = st->soc_info.platform->osr_mask;
> +	unsigned int osr_vals = st->soc_info.platform->osr_vals;
>  
>  	/* select oversampling per single trigger event */
>  	emr |= AT91_SAMA5D2_EMR_ASTE(1);
>  
>  	/* delete leftover content if it's the case */
> -	emr &= ~AT91_SAMA5D2_EMR_OSR_MASK;
> +	emr &= ~osr_mask;
>  
>  	/* select oversampling ratio from configuration */
> -	switch (st->oversampling_ratio) {
> +	switch (oversampling_ratio) {
>  	case AT91_OSR_1SAMPLES:
> -		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_1SAMPLES) &
> -		       AT91_SAMA5D2_EMR_OSR_MASK;
> +		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_1SAMPLES)))
> +			return -EINVAL;
> +		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_1SAMPLES,
> +					    osr_mask);
>  		break;
>  	case AT91_OSR_4SAMPLES:
> -		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_4SAMPLES) &
> -		       AT91_SAMA5D2_EMR_OSR_MASK;
> +		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_4SAMPLES)))
> +			return -EINVAL;
> +		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_4SAMPLES,
> +					    osr_mask);
>  		break;
>  	case AT91_OSR_16SAMPLES:
> -		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES) &
> -		       AT91_SAMA5D2_EMR_OSR_MASK;
> +		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_16SAMPLES)))
> +			return -EINVAL;
> +		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES,
> +					    osr_mask);
>  		break;
>  	}
>  
>  	at91_adc_writel(st, EMR, emr);
> +
> +	return 0;
>  }
>  
>  static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
> @@ -1643,6 +1665,7 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
>  			      int val, int val2, long mask)
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
> +	int ret = 0;
>  
>  	if (iio_buffer_enabled(indio_dev))
>  		return -EBUSY;
> @@ -1656,12 +1679,14 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
>  		mutex_lock(&st->lock);
>  		if (val == st->oversampling_ratio)
>  			goto unlock;
> -		st->oversampling_ratio = val;
>  		/* update ratio */
> -		at91_adc_config_emr(st);
> +		ret = at91_adc_config_emr(st, val);
> +		if (ret)
> +			goto unlock;
> +		st->oversampling_ratio = val;

Good. I looked at the old ordering when reviewing earlier patch and thought
that doesn't look good :)

However, now you hae the value passed to at91_adc_config_emr() perhaps
you can drop the checking that it is a possible value from above this call
and move it to the default case on the switch statement in there?
(noticed on later patch, where that context is visible).

>  unlock:
>  		mutex_unlock(&st->lock);
> -		return 0;
> +		return ret;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val < st->soc_info.min_sample_rate ||
>  		    val > st->soc_info.max_sample_rate)
> @@ -1834,7 +1859,7 @@ static void at91_adc_hw_init(struct iio_dev *indio_dev)
>  	at91_adc_setup_samp_freq(indio_dev, st->soc_info.min_sample_rate);
>  
>  	/* configure extended mode register */
> -	at91_adc_config_emr(st);
> +	at91_adc_config_emr(st, st->oversampling_ratio);
>  }
>  
>  static ssize_t at91_adc_get_fifo_state(struct device *dev,

