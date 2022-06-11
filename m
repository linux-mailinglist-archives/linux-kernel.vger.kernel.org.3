Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06D55476F9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiFKRtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiFKRtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5469E36E2A;
        Sat, 11 Jun 2022 10:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDBF4611F5;
        Sat, 11 Jun 2022 17:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673D4C34116;
        Sat, 11 Jun 2022 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654969783;
        bh=b0KkXY4PxOnNjRT+AKIcIZ6fRIE/jSeG5cbQv02Fb9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B88NFfhnLIetHwaNo9Xnr/O4ChM9CiZlSED3IPkiPe0i0GxyS/T1lvvgUp3CZp4Gh
         jy1PWAJvi4VjEnxtOYKWY1IBZBTF3i0MWx3EI8WvfAnoXLDERt96voq6bNjhFVyWnG
         BgD7n7IufaXp8oou4EwT8ZTrGaWWVrBEoO60NBhmqdG+5lN6WId7MpkNL34hzbL278
         Fwd9aA2ZhQfXfbXkKSG9QWLKp0lTGgFv6dduFOUEbkuIGhSvK158cGxv0dK6SnpZIz
         r4fVbFPvA3+vZN8p9MP5MYD7x+MkpUDVoEqZ4YHlU3fnYCwXGnlVl40xZfpUiNBjjW
         iFNPMgVJ/5wPA==
Date:   Sat, 11 Jun 2022 18:58:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/16] iio: adc: at91-sama5d2_adc: add locking parameter
 to at91_adc_read_info_raw()
Message-ID: <20220611185851.4d266d5e@jic23-huawei>
In-Reply-To: <20220609083213.1795019-12-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
        <20220609083213.1795019-12-claudiu.beznea@microchip.com>
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

On Thu, 9 Jun 2022 11:32:08 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Add a parameter to at91_adc_read_info_raw() to specify if st->lock mutex
> need to be acquired. This prepares for the addition of temperature sensor
> code which will re-use at91_adc_read_info_raw() function to read 2 voltages
> for determining the real temperature.

This looks like a potential lock dependency issue.
iio_device_claim_direct_mode() takes an internal iio lock, and
you then take st->lock.

If you are going to invert that locking order in another path
you have a deadlock.

So rethink this. If you want to reuse the code you'll need to factor
it out to a separate function that takes none of the locks then
take all locks needed in each call path (in the same order).

Jonathan


> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 1283bcf4e682..8f8fef42de84 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1583,7 +1583,8 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
>  }
>  
>  static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
> -				  struct iio_chan_spec const *chan, int *val)
> +				  struct iio_chan_spec const *chan, int *val,
> +				  bool lock)
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  	int (*fn)(struct at91_adc_state *, int, u16 *) = NULL;
> @@ -1602,13 +1603,15 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  	ret = iio_device_claim_direct_mode(indio_dev);
>  	if (ret)
>  		return ret;
> -	mutex_lock(&st->lock);
> +	if (lock)
> +		mutex_lock(&st->lock);
>  
>  	if (fn) {
>  		ret = fn(st, chan->channel, &tmp_val);
>  		*val = tmp_val;
>  		ret = at91_adc_adjust_val_osr(st, val);
> -		mutex_unlock(&st->lock);
> +		if (lock)
> +			mutex_unlock(&st->lock);
>  		iio_device_release_direct_mode(indio_dev);
>  
>  		return ret;
> @@ -1644,7 +1647,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  	/* Needed to ACK the DRDY interruption */
>  	at91_adc_readl(st, LCDR);
>  
> -	mutex_unlock(&st->lock);
> +	if (lock)
> +		mutex_unlock(&st->lock);
>  
>  	iio_device_release_direct_mode(indio_dev);
>  	return ret;
> @@ -1658,7 +1662,8 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		return at91_adc_read_info_raw(indio_dev, chan, val);
> +		return at91_adc_read_info_raw(indio_dev, chan, val, true);
> +
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = st->vref_uv / 1000;
>  		if (chan->differential)

