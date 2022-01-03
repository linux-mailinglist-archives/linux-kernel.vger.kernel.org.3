Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345C4482FBA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiACKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiACKAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:00:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD3BC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 02:00:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z29so133821427edl.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 02:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rzyDUUFUuzJu7fjqsCBQnCkElzR31cmF3qAtFZ/CTkQ=;
        b=G/dSeks6bFBU00bcMvgZyae7B/zka+YysAJfC8gjAOGlG1Rdjf6GtH2LSHhvHk2e/2
         pjEpUD2WjGHACLiFPXxLsSrdTqZHJ+BHUmQdveibyKgKOM69uAdGvxReZkPfcZE2eFck
         CZISPMnG5PjkoF6n8LwNzHY1BAWQtilh7PmhiqBAm5ZSP0+OhNSI7w5T4AMMb8+2R1zL
         lkV0z3gkPWm21RXmNWDYv/PeN/TorTVjunb2XliIcI4IIBcOaKVr6EbVwBUNQs+/zU3h
         4QGQ5AqUlCUgF3ui0ET8zd9HVmRapP4JUbqyDKMLdNKhau/UeA57lZTmvj7Ur5H6aL1s
         0G9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rzyDUUFUuzJu7fjqsCBQnCkElzR31cmF3qAtFZ/CTkQ=;
        b=TIn033MtjnSQ9MbOutE+D0xlnDyEyw9ExTaIXlk+ckCGpgc0LKgZQxLKXviwOhEq7S
         e7cAE7QPrYCS5TEWizDDYGOml7SV617K+/uaj0xES0jMCdcmHy/IuBA8p//h9jMqAZz+
         nJKc7H3UiyLdNBjLKcogHdSP0Vo0XB2mt+DpwCO0zwqLm0sMQ7uutZe7Yfftr2TkCqUi
         OVH+1cJSpYzEVRnvDQOyo73nkLe0a9Pxy834YiwkvBWOhaqEUcprICJQpZCotnrj4anN
         bDHvI0XHI25OBi6+/CCCRYg4dm8k8Y8uxNycsKhfHueIFoATV1ipccAbV3uXbg1QkdfZ
         cs1g==
X-Gm-Message-State: AOAM530kR8JE7RtHZ2DXNE+GUkx6rejqziOsHKfGaR7604PnbcTAK0wb
        Os3KAilayYjdAniDZNoplwKTE5mvdbk=
X-Google-Smtp-Source: ABdhPJzwtpEgepJ7j6hYnw16nurFJlAFm1fTf0svjiqu6E+0GL7Nai1dy2DBEZk9kKYicAZqyoFDng==
X-Received: by 2002:a17:906:ff14:: with SMTP id zn20mr36536626ejb.649.1641204006906;
        Mon, 03 Jan 2022 02:00:06 -0800 (PST)
Received: from agape.jhs (77-32-51-202.dyn.eolo.it. [77.32.51.202])
        by smtp.gmail.com with ESMTPSA id t20sm13326329edv.81.2022.01.03.02.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 02:00:06 -0800 (PST)
Date:   Mon, 3 Jan 2022 11:00:04 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix frequency deviation check
Message-ID: <YdLJJIrVizjnqzsd@agape.jhs>
References: <20220103081135.GA11642@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103081135.GA11642@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paulo,

thanks for your patch.

On Mon, Jan 03, 2022 at 09:11:35PM +1300, Paulo Miguel Almeida wrote:
> rf69 datasheet states that frequency deviation must exceed 600 Hz but
> also that frequency deviation + (bitrate / 2) should be less than equal
> to 500 kHz to ensure proper modulation.
> 
> This patch validates that both conditions are met so RF intersymbol
> interference is "avoided" where possible.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
>  drivers/staging/pi433/rf69.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
> index e62e61ef4d27..cc22915fd489 100644
> --- a/drivers/staging/pi433/rf69.c
> +++ b/drivers/staging/pi433/rf69.c
> @@ -255,17 +255,29 @@ int rf69_set_deviation(struct spi_device *spi, u32 deviation)
>  	int retval;
>  	u64 f_reg;
>  	u64 f_step;
> +	u32 bit_rate_reg;
> +	u32 bit_rate;
>  	u8 msb;
>  	u8 lsb;
>  	u64 factor = 1000000; // to improve precision of calculation
>  
> -	// TODO: Dependency to bitrate
> -	if (deviation < 600 || deviation > 500000) {
> -		dev_dbg(&spi->dev, "set_deviation: illegal input param");
> +	// calculate bit rate
> +	bit_rate_reg = rf69_read_reg(spi, REG_BITRATE_MSB) << 8;
> +	bit_rate_reg |= rf69_read_reg(spi, REG_BITRATE_LSB);
> +	bit_rate = F_OSC / bit_rate_reg;
> +
> +	/*
> +	 * frequency deviation must exceed 600 Hz and but not exceed
> +	 * 500kHz when taking bitrate dependency into consideration
> +	 * to ensure proper modulation
> +	 */
> +	if (deviation < 600 || (deviation + (bit_rate / 2)) > 500000) {
> +		dev_dbg(&spi->dev,
> +			"set_deviation: illegal input param: %u", deviation);
>  		return -EINVAL;
>  	}

this should go in a separate patch IMO

>  
> -	// calculat f step
> +	// calculate f step
>  	f_step = F_OSC * factor;
>  	do_div(f_step, 524288); //  524288 = 2^19
>  
> -- 
> 2.25.4
> 
> 

thank you,

fabio
