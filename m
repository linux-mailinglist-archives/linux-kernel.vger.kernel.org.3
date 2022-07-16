Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C5E577010
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 18:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiGPQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 12:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 12:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC73B1C92E;
        Sat, 16 Jul 2022 09:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 688E160DFA;
        Sat, 16 Jul 2022 16:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5F8C34114;
        Sat, 16 Jul 2022 16:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657988139;
        bh=ohST+iMB3W83aZYXNrDfxksLloNkjt3mKUhrT2850fY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bq/JMz8lY+Emu5XYPEKlNVkq0hzFTdyirT5Uga+ZZBvdJY+J1njEdzgiGOnsZrwS7
         H6N0+gQ9VwVyRhgeYVkvXunpD/68vc9O7mUVyO6XqTwdsoF9JUPjWGVJha5Km9cniL
         mDFynQoFTCTG61r5VPKpsmvB/zm6apFKPAnz8pShHAsPHlIa5s/wJD7LYAujjdjOPQ
         vwv6yUxTF0AXDzeHbV8zWN4xXYcMz/sZ9+B1vQvfR4p8e73vTB1yjNxiP9TKidL6BE
         Vv9Vik+d3WvtrxpkaS8NQVPiHFLOCrfg9lusooAvTxGjGeko5d0HZCYcE3324MPNKf
         1/Ee4in1Fk6Qg==
Date:   Sat, 16 Jul 2022 17:25:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 02/19] iio: adc: at91-sama5d2_adc: check return
 status for pressure and touch
Message-ID: <20220716172531.684b2878@jic23-huawei>
In-Reply-To: <20220628151631.3116454-3-claudiu.beznea@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
        <20220628151631.3116454-3-claudiu.beznea@microchip.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 18:16:14 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Check return status of at91_adc_read_position() and
> at91_adc_read_pressure() in at91_adc_read_info_raw().
> 
> Fixes: 6794e23fa3fe ("iio: adc: at91-sama5d2_adc: add support for oversampling resolution")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 32b6f157b803..c3301c749164 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1544,8 +1544,10 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  		*val = tmp_val;
>  		mutex_unlock(&st->lock);
>  		iio_device_release_direct_mode(indio_dev);
Prefer to keep error path out of line.

		if (ret < 0)
			return ret;

		return at91_adc_adjust_val_osr();

Also ends up as a slightly less invasive change.

> +		if (ret > 0)
> +			ret = at91_adc_adjust_val_osr(st, val);
>  
> -		return at91_adc_adjust_val_osr(st, val);
> +		return ret;
>  	}
>  	if (chan->type == IIO_PRESSURE) {
>  		ret = iio_device_claim_direct_mode(indio_dev);
> @@ -1558,8 +1560,10 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  		*val = tmp_val;
>  		mutex_unlock(&st->lock);
>  		iio_device_release_direct_mode(indio_dev);
> +		if (ret > 0)
> +			ret = at91_adc_adjust_val_osr(st, val);
>  
> -		return at91_adc_adjust_val_osr(st, val);
As above.

> +		return ret;
>  	}
>  
>  	/* in this case we have a voltage channel */

