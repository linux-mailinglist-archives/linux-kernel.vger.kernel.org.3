Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299E65476EF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiFKRjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiFKRi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:38:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCF94339E;
        Sat, 11 Jun 2022 10:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12CAEB80ADE;
        Sat, 11 Jun 2022 17:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBADC3411C;
        Sat, 11 Jun 2022 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654969102;
        bh=2nO9YYrpb7HdXkesn/oDuP7eCP+sVOf/Q2uUIIPkQRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b3Ntjx/NxB8hmCkkd5ZaM1YnLRX5te7+JM3KNvP7zyAy6TXaEOYS8rnH2qdGZmL38
         uL2RUbKeBe6D8byjYNnVqIjWNnmz5Db+dbvfBXViJmTqvFC4LeA/IFfN/0Ae5/xD91
         kMrBV0BAVIAaOPS586Y09/jrqG8qLzRx3z7R7Dtfxxs7zykUlO3s/9lkpT2M/eJmi6
         q7bvFRrrTVaYg6f+UcfuEHmUwTgFsjyhMT1tjT+7BW0H7VKrOVnEbWUUxpdUmhq7ZA
         7rgF6djw/xmmCKTddxMh+7y/NOd6m7hq5vrTinj4GWkbuSpvy1g3RZyeatbQhgf2Hh
         gkTdZni0wNXFg==
Date:   Sat, 11 Jun 2022 18:47:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/16] iio: adc: at91-sama5d2_adc: add 64 and 256
 oversampling ratio
Message-ID: <20220611184731.7c100a08@jic23-huawei>
In-Reply-To: <20220609083213.1795019-7-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
        <20220609083213.1795019-7-claudiu.beznea@microchip.com>
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

On Thu, 9 Jun 2022 11:32:03 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Add 64 and 256 oversampling ratio support. It is necessary for temperature
> sensor.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 31 +++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 7321a4b519af..b52f1020feaf 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -142,6 +142,8 @@ struct at91_adc_reg_layout {
>  #define AT91_SAMA5D2_EMR_OSR_1SAMPLES		0
>  #define AT91_SAMA5D2_EMR_OSR_4SAMPLES		1
>  #define AT91_SAMA5D2_EMR_OSR_16SAMPLES		2
> +#define AT91_SAMA5D2_EMR_OSR_64SAMPLES		3
> +#define AT91_SAMA5D2_EMR_OSR_256SAMPLES		4
>  
>  /* Extended Mode Register - Averaging on single trigger event */
>  #define AT91_SAMA5D2_EMR_ASTE(V)		((V) << 20)
> @@ -308,6 +310,8 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>  #define AT91_OSR_1SAMPLES		1
>  #define AT91_OSR_4SAMPLES		4
>  #define AT91_OSR_16SAMPLES		16
> +#define AT91_OSR_64SAMPLES		64
> +#define AT91_OSR_256SAMPLES		256

These defines seems a bit silly.  Better to use the values inline than
to have these.

>  
>  #define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
>  	{								\
> @@ -640,7 +644,9 @@ static const struct at91_adc_platform sama7g5_platform = {
>  	.osr_mask = GENMASK(18, 16),
>  	.osr_vals = BIT(AT91_SAMA5D2_EMR_OSR_1SAMPLES) |
>  		    BIT(AT91_SAMA5D2_EMR_OSR_4SAMPLES) |
> -		    BIT(AT91_SAMA5D2_EMR_OSR_16SAMPLES),
> +		    BIT(AT91_SAMA5D2_EMR_OSR_16SAMPLES) |
> +		    BIT(AT91_SAMA5D2_EMR_OSR_64SAMPLES) |
> +		    BIT(AT91_SAMA5D2_EMR_OSR_256SAMPLES),
>  	.chan_realbits = 16,
>  };
>  
> @@ -774,6 +780,18 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
>  		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES,
>  					    osr_mask);
>  		break;
> +	case AT91_OSR_64SAMPLES:
> +		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_64SAMPLES)))
> +			return -EINVAL;
> +		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_64SAMPLES,
> +					    osr_mask);
> +		break;
> +	case AT91_OSR_256SAMPLES:
> +		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_256SAMPLES)))
> +			return -EINVAL;
> +		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_256SAMPLES,
> +					    osr_mask);
> +		break;
>  	}
>  
>  	at91_adc_writel(st, EMR, emr);
> @@ -791,6 +809,10 @@ static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
>  		nbits = 13;
>  	else if (st->oversampling_ratio == AT91_OSR_16SAMPLES)
>  		nbits = 14;
> +	else if (st->oversampling_ratio == AT91_OSR_64SAMPLES)
> +		nbits = 15;
> +	else if (st->oversampling_ratio == AT91_OSR_256SAMPLES)
> +		nbits = 16;
>  
>  	/*
>  	 * We have nbits of real data and channel is registered as
> @@ -1679,7 +1701,8 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		if ((val != AT91_OSR_1SAMPLES) && (val != AT91_OSR_4SAMPLES) &&
> -		    (val != AT91_OSR_16SAMPLES))
> +		    (val != AT91_OSR_16SAMPLES) && (val != AT91_OSR_64SAMPLES) &&
> +		    (val != AT91_OSR_256SAMPLES))
Dropping this partial validity check and moving into a default in the switch statement
in config_emr() would be nice cleanup (I also replied to earlier patch based on what
is visible here).

>  			return -EINVAL;
>  		/* if no change, optimize out */
>  		mutex_lock(&st->lock);
> @@ -1897,7 +1920,9 @@ static IIO_CONST_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_STR);
>  static IIO_CONST_ATTR(oversampling_ratio_available,
>  		      __stringify(AT91_OSR_1SAMPLES) " "
>  		      __stringify(AT91_OSR_4SAMPLES) " "
> -		      __stringify(AT91_OSR_16SAMPLES));
> +		      __stringify(AT91_OSR_16SAMPLES) " "
> +		      __stringify(AT91_OSR_64SAMPLES) " "
> +		      __stringify(AT91_OSR_256SAMPLES));

At somepoint it would be good to move this over to the read_avail() callback rather than
hand rolling it.  We are slowly working through doing this for all the IIO drivers
but it will take a long time yet!

>  
>  static struct attribute *at91_adc_attributes[] = {
>  	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,

