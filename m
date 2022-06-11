Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B825476F6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiFKRpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiFKRo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:44:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2006357B3C;
        Sat, 11 Jun 2022 10:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8D724CE09D2;
        Sat, 11 Jun 2022 17:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDAAC34116;
        Sat, 11 Jun 2022 17:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654969494;
        bh=+CoBBCoe/KpGTA7h3kGWZ8vhCj+1Oix6HOVG6MCCe3s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NkZLVpVZKBdcTD/IhQsPtQ7tk3qoS2mrNkYgq9z7MgwS1IlKbr/gR4pzcHRkwUAjB
         Yn9oS71FEpV+miBQr0VaKqZKXNosA/YyP/TqMoNlNsEkF4X0CKTzONpaFFlQxoLvPl
         rKCYUGx0afdJjOTJLHVI+5kOXSbEdlVjLgN9iYTTNsBOGDkHkTed90EDo4iuPi50o7
         emNJ0BBVwkcZFmLg3k3N0ng9EOSV3ZrF5114szKPkPhHQ3Ym4NHSIGpNWIn2HgoI4k
         NPq74A0TUKnJzFcbnF4mSoHY46+1lmq1Kc7TKY714U+6TO5HosHa/JmYd/PESCCHDe
         G8KqgMYlb8Q4w==
Date:   Sat, 11 Jun 2022 18:54:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/16] iio: adc: at91-sama5d2_adc: simplify the code in
 at91_adc_read_info_raw()
Message-ID: <20220611185403.3eaf9b65@jic23-huawei>
In-Reply-To: <20220609083213.1795019-8-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
        <20220609083213.1795019-8-claudiu.beznea@microchip.com>
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

On Thu, 9 Jun 2022 11:32:04 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Simplify a bit the code in at91_adc_read_info_raw() by reducing the
> number of lines of code.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

I'm not convinced this is worth while, but there are some lesser
steps visible in this patch that probably are.

Given your earlier reorg to move at01_adc_adjust_val_osr() under the locks,
you can now move the locks to the caller, thus not needing to handle them
separately in all the exit paths.

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 35 +++++++++---------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index b52f1020feaf..fbb98e216e70 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1576,6 +1576,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  				  struct iio_chan_spec const *chan, int *val)
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
> +	int (*fn)(struct at91_adc_state *, int, u16 *) = NULL;
>  	u16 tmp_val;
>  	int ret;
>  
> @@ -1583,29 +1584,18 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  	 * Keep in mind that we cannot use software trigger or touchscreen
>  	 * if external trigger is enabled
>  	 */
> -	if (chan->type == IIO_POSITIONRELATIVE) {
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;

You can drop this out of the if statements as it happens in all paths.
Or even better, move it to the caller..

> -		mutex_lock(&st->lock);
> -
> -		ret = at91_adc_read_position(st, chan->channel,
> -					     &tmp_val);

huh? ret not checked? 

> -		*val = tmp_val;
> -		ret = at91_adc_adjust_val_osr(st, val);
Sure this is duplicated, but meh it's only a few lines.


> -		mutex_unlock(&st->lock);
> -		iio_device_release_direct_mode(indio_dev);

this early release (compared to the long path) is the only bit really
gets duplicated in all paths..

> +	if (chan->type == IIO_POSITIONRELATIVE)
> +		fn = at91_adc_read_position;
> +	if (chan->type == IIO_PRESSURE)
> +		fn = at91_adc_read_pressure;
>  
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
>  		return ret;
> -	}
> -	if (chan->type == IIO_PRESSURE) {
this should always have been an else if () as the chan->type couldn't be both.

> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> -		mutex_lock(&st->lock);
hence this lot can be shared with the above.

> +	mutex_lock(&st->lock);
>  
> -		ret = at91_adc_read_pressure(st, chan->channel,
> -					     &tmp_val);
> +	if (fn) {
> +		ret = fn(st, chan->channel, &tmp_val);
>  		*val = tmp_val;
>  		ret = at91_adc_adjust_val_osr(st, val);
>  		mutex_unlock(&st->lock);
> @@ -1616,11 +1606,6 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  
>  	/* in this case we have a voltage channel */
>  
> -	ret = iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> -	mutex_lock(&st->lock);
> -
>  	st->chan = chan;
>  
>  	at91_adc_cor(st, chan);

