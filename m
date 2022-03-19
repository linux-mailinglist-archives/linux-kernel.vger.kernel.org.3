Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DD64DE92F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 17:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbiCSQDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 12:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbiCSQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 12:03:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95902A33BA;
        Sat, 19 Mar 2022 09:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D98BB80D77;
        Sat, 19 Mar 2022 16:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017BEC340EC;
        Sat, 19 Mar 2022 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647705698;
        bh=5lM2GQN21/6eZ4pzyteYnuHBID1NME4gq7qznrZWAYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CZupouA5i5yfaOxV3sIKVcSXuYopvOJNM1nv2kQfUA68GhWKpu+jPTDuGmHiT4wox
         nDxQozQB65YBldzh1cwKGYbWQUbcS9lsC2Ed7n4ORE9H481YvjM7fTvltNg1F1l5PL
         NweJXUmfleiiby8s3MeWinZsvveAGeyxpyHdKLgSBTVIq0ZWg6w42EPjNCATg908qb
         ebaK9nowN2CHL/85IrB5q8cU2Z+/TtR3b22jxaZgAJnu3Rvaf7ov4T3Z1bU8LxWQSv
         uaOuSap13dLlPAeJNDPSX42s+HNMy6o7LFZd3aaUUQgd+2+9t734wujPq9JMRRTl1L
         SvUXtL6JgTBoQ==
Date:   Sat, 19 Mar 2022 16:09:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/8] iio: adc: ad7124: add sequencer support
Message-ID: <20220319160901.61b13399@jic23-huawei>
In-Reply-To: <20220318162722.51215-6-alexandru.tachici@analog.com>
References: <20220318162722.51215-1-alexandru.tachici@analog.com>
        <20220318162722.51215-6-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 18:27:19 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add sequencer support for AD7124.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
Hi Alexandru,

A few comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 428ec3e257d7..782b7cdd8ebe 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -43,6 +43,8 @@
>  #define AD7124_STATUS_POR_FLAG_MSK	BIT(4)
>  
>  /* AD7124_ADC_CONTROL */
> +#define AD7124_ADC_STATUS_EN_MSK	BIT(10)
> +#define AD7124_ADC_STATUS_EN(x)		FIELD_PREP(AD7124_ADC_STATUS_EN_MSK, x)
>  #define AD7124_ADC_CTRL_REF_EN_MSK	BIT(8)
>  #define AD7124_ADC_CTRL_REF_EN(x)	FIELD_PREP(AD7124_ADC_CTRL_REF_EN_MSK, x)
>  #define AD7124_ADC_CTRL_PWR_MSK	GENMASK(7, 6)
> @@ -512,14 +514,27 @@ static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
>  	return ret;
>  }
>  
> +static int ad7124_append_status(struct ad_sigma_delta *sd, bool append)
> +{
> +	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
> +
> +	st->adc_control &= ~AD7124_ADC_STATUS_EN_MSK;
> +	st->adc_control |= AD7124_ADC_STATUS_EN(append);

Generally avoid updating cached state until you know the write succeeded.
So I would operate on a local variable and if ad_sd_write_reg() succeeds
copy that back into st->adc_control.

Obviously on error it 'might' have been updated successfully and something failed
after the write, but it is probably more likely the write failed.

> +
> +	return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
> +}
> +
>  static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
>  	.set_channel = ad7124_set_channel,
> +	.append_status = ad7124_append_status,
>  	.set_mode = ad7124_set_mode,
>  	.has_registers = true,
>  	.addr_shift = 0,
>  	.read_mask = BIT(6),
> +	.status_ch_mask = GENMASK(3, 0),
>  	.data_reg = AD7124_DATA,
> -	.irq_flags = IRQF_TRIGGER_FALLING
> +	.num_slots = 8,
> +	.irq_flags = IRQF_TRIGGER_FALLING,
>  };
>  
>  static int ad7124_read_raw(struct iio_dev *indio_dev,
> @@ -679,10 +694,11 @@ static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
>  
>  	for (i = 0; i < st->num_channels; i++) {
>  		bit_set = test_bit(i, scan_mask);
> -		ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i),
> -					    AD7124_CHANNEL_EN_MSK,
> -					    AD7124_CHANNEL_EN(bit_set),
> -					    2);
> +		if (bit_set)
> +			ret = ad7124_set_channel(&st->sd, i);

This is going to repeatedly take an release the cfg mutex. Perhaps it's worth
introducing a __ad7124_set_channel() that doesn't take the lock then take it around
this loop instead?

> +		else
> +			ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i), AD7124_CHANNEL_EN_MSK,
> +						    0, 2);
>  		if (ret < 0)
>  			return ret;
>  	}
> @@ -906,12 +922,14 @@ static int ad7124_probe(struct spi_device *spi)
>  
>  	st->chip_info = info;
>  
> -	ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
> -
>  	indio_dev->name = st->chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &ad7124_info;
>  
> +	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = ad7124_of_parse_channel_config(indio_dev, spi->dev.of_node);
>  	if (ret < 0)
>  		return ret;

