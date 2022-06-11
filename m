Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD1D5476C9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiFKRVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiFKRVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:21:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662F55FD9;
        Sat, 11 Jun 2022 10:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E898EB8068B;
        Sat, 11 Jun 2022 17:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671D2C34116;
        Sat, 11 Jun 2022 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654968098;
        bh=E0kQ1q0EhIyg+oOJ3MBPCoRamwPIBHnxUd7HHhol9uw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qg27L7Ed2K61cm6n17/z7Zy/1Tlf9rYo/vI+IlLlk1hPQXaenf2eGSTGir7nOlnEp
         X+aa1zh+E5VRXUX4SKiIvQfknTud3oQkX2cgG+/bNdW1Gv+zxW+vXLiG0TGA9MCa4h
         9a6xjWRpIn6glfNYTN0XHwoR5AXtVEofNQlLLwlB4OT6peThZDxbt8mGkshHd68+uj
         ruvTCn9PpJEMKP9kPvflRbbA3zalYas3+vmueInEQrGHtlMabMzv55OOeyj45C531R
         8mnfBO0YUB2780zWnRPzUrRp/EdRwL56uSK6bJfDdyrYJ9CERlVBWnejZd4BVbJm3K
         IBBWEQWGjFLrA==
Date:   Sat, 11 Jun 2022 18:30:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/16] iio: adc: at91-sama5d2_adc: lock around
 oversampling and sample freq
Message-ID: <20220611183046.5515c001@jic23-huawei>
In-Reply-To: <20220609083213.1795019-3-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
        <20220609083213.1795019-3-claudiu.beznea@microchip.com>
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

On Thu, 9 Jun 2022 11:31:59 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> .read_raw()/.write_raw() could be called asynchronously from user space
> or other in kernel drivers. Without locking on st->lock these could be
> called asynchronously while there is a conversion in progress. Read will
> be harmless but changing registers while conversion is in progress may
> lead to inconsistent results. Thus, to avoid this lock st->lock.

The patch makes sense, but I'm not convinced all of the changes below
involve any changes to registers. E.g. at91_adc_adjust_val_osr()
is using the cached value of something in a register, but not the
register itself, so please update the description to mention cached state.

Other comments inline.
> 
> Fixes: 27e177190891 ("iio:adc:at91_adc8xx: introduce new atmel adc driver")
> Fixes: 6794e23fa3fe ("iio: adc: at91-sama5d2_adc: add support for oversampling resolution")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 32b6f157b803..a672a520cdc0 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1542,10 +1542,11 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  		ret = at91_adc_read_position(st, chan->channel,
>  					     &tmp_val);
>  		*val = tmp_val;
> +		ret = at91_adc_adjust_val_osr(st, val);
>  		mutex_unlock(&st->lock);
>  		iio_device_release_direct_mode(indio_dev);
>  
> -		return at91_adc_adjust_val_osr(st, val);
> +		return ret;
>  	}
>  	if (chan->type == IIO_PRESSURE) {
>  		ret = iio_device_claim_direct_mode(indio_dev);
> @@ -1556,10 +1557,11 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  		ret = at91_adc_read_pressure(st, chan->channel,
>  					     &tmp_val);
>  		*val = tmp_val;
> +		ret = at91_adc_adjust_val_osr(st, val);
>  		mutex_unlock(&st->lock);
>  		iio_device_release_direct_mode(indio_dev);
>  
> -		return at91_adc_adjust_val_osr(st, val);
> +		return ret;
>  	}
>  
>  	/* in this case we have a voltage channel */
> @@ -1620,11 +1622,15 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&st->lock);
>  		*val = at91_adc_get_sample_freq(st);

So this is a straight read of a cached value.  The only thing you 'might'
arguably be protecting against is read/write tearing due to it in theory
being possible to write part of the value whilst reading.  I don't
see that being a concern for st->current_sample_rate

> +		mutex_unlock(&st->lock);
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		mutex_lock(&st->lock);
>  		*val = st->oversampling_ratio;
Likewise, what are you protecting against racing with this that can't
just occur before or after the lock?

> +		mutex_unlock(&st->lock);
>  		return IIO_VAL_INT;
>  
>  	default:
> @@ -1644,18 +1650,23 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
>  		    (val != AT91_OSR_16SAMPLES))
>  			return -EINVAL;
>  		/* if no change, optimize out */
> +		mutex_lock(&st->lock);
>  		if (val == st->oversampling_ratio)
> -			return 0;
It should be race free to check this outside the lock.

Definitely valid to lock around the cached value write and the config
write though.

> +			goto unlock;
If you did want to have locking as now then flip the logic

		if (val != st->oversampling_ratio) {
			st->oversampling_ratio = val;
			at91_adc_config_emr(st);
		}
		mutex_unlock()
..

Goto always have a cost in readability so if you can avoid them with
a simple flip of logic like this it is usually a good idea.
(exception is error code which should always be out of line as
that is more common so what we expect to see).

>  		st->oversampling_ratio = val;
>  		/* update ratio */
>  		at91_adc_config_emr(st);
> +unlock:
> +		mutex_unlock(&st->lock);
>  		return 0;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val < st->soc_info.min_sample_rate ||
>  		    val > st->soc_info.max_sample_rate)
>  			return -EINVAL;
>  
> +		mutex_lock(&st->lock);
>  		at91_adc_setup_samp_freq(indio_dev, val);
> +		mutex_unlock(&st->lock);
>  		return 0;
>  	default:
>  		return -EINVAL;

