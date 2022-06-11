Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C725476DB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbiFKRYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiFKRYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:24:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F403EAA9;
        Sat, 11 Jun 2022 10:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9539BB80AE9;
        Sat, 11 Jun 2022 17:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFB1C34116;
        Sat, 11 Jun 2022 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654968286;
        bh=SDCYDjY3WJbmTI27Ho0/7Zfqxt3PHJ7jDyD8765WJCE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZtYi3BQBV3GRP8nI3TqjRnZmjlpZ2AtIMxOG/5riaE5t2Z5IZJYIBH/LwlaWYB+Bt
         5EvFEBD2GUAMSS1++XM61sP0qhnz+573f3ECcuFOhiwikH5eiIkssBaiN7c8MACpqX
         R4eRaJa/uwn9IBSOo+DbgTZ/i0ZcUYZ+cUwNib56pzWe+BDc7kVpscCyMzbsy3FrTu
         /K1ehnbwBPstJ3fnwzUl3tHm8hQuxQyMdKIYTM8qcw3y49WBQ/L69UpIdfHcae31NN
         29R1K/GuotB3t5WIWhf3KVC3pTXB7DyYjKpXL/g5ErM8avsTGEURUjO4Z4FBrpFzPq
         WHv8kycFjH4HQ==
Date:   Sat, 11 Jun 2022 18:33:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/16] iio: adc: at91-sama5d2_adc: exit from write_raw()
 when buffers are enabled
Message-ID: <20220611183354.08788921@jic23-huawei>
In-Reply-To: <20220609083213.1795019-4-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
        <20220609083213.1795019-4-claudiu.beznea@microchip.com>
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

On Thu, 9 Jun 2022 11:32:00 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> When buffers are enabled conversion may start asynchronously thus
> allowing changes on actual hardware could lead to bad behavior. Thus
> do not allow changing oversampling ratio and sample frequency when
> buffers are enabled.

Less than desirable behavior perhaps, but broken?  I don't see this
as a fix from what you have mentioned - though I'm not against it.
(just drop the fixes tag)
It is an ABI change, but unlikely to be one any sane code hits.

> 
> Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index a672a520cdc0..b76328da0cb2 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1644,6 +1644,9 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
> +	if (iio_buffer_enabled(indio_dev))
> +		return -EBUSY;

This is racy as nothing stops buffers being enabled after this point.
Use the iio_device_claim_direct_mode() and release for this as they
protect against the race.


> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		if ((val != AT91_OSR_1SAMPLES) && (val != AT91_OSR_4SAMPLES) &&

