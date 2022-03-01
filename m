Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CC84C8D7D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiCAOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiCAOQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:16:41 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877B78A6CC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:16:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v21so20741319wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 06:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4NR+K0swoA9TbSDR8qZztVxkcC0lWhhUEi93lGpMrM0=;
        b=df/NuTdNgA5iIo9dKWTtqdxVVTlGslW/D3NVGwYa+u0N7Wocud/SOzKxvUw/5k9/J6
         9u7XI+fvXEazxvAaKgrJ0DKDmC58L56kwK5dFe6Z/p2+AGLIneSLftjYOIPOw5b2eVM5
         iiMu5QnOe8LHjJIxb+sF++LBZ2X4NQAY+42GVp+IS+tnw1Yw83iOMmAwPFeyS2P+UDVk
         EZ2A8UnVsTdqVqVTJydLi10BDJ6BN6Wa2RCf9yxOqwxYWeMhqBf4RK/RvQUdTdzKQCFH
         xEmp0MMA4lI0rKKo1pFGU08Al1eAEgdfFbnGY5L+9XhbjRR1UwHd3zrhOT/TjYEk+2U4
         OjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4NR+K0swoA9TbSDR8qZztVxkcC0lWhhUEi93lGpMrM0=;
        b=MKaTHDDndqvZvuIK/LU/HFAYCiETKWsaFq4L0qYu/uYmPPOu1Ju9e5HFkBPkHDOZ78
         xs/3MOKbRaKs1NVzJOxq3wcLoKVBUhnUnuLkj7rFuykRhawtpwyhtAzjIA2CB59XgRkO
         YDsm/fd6Sezcqusk+wwzBIWK0C/aRC+znjLg6AEDrCSCM5t5iia0zCxqf7cp2eNby+Wu
         tqAYocVmpjacPChL/yEAr9mF0/PSyiIgqGB87XvdDWcH9lpWqS4UH2FcOLl2hj8QPScz
         ZaBRcwisx2/E7dYc+R0Eqj6Bvpmz541rNjX5iX7ZDlcTci13BNPd/NgGuftJc1V4Fl/p
         mcxA==
X-Gm-Message-State: AOAM533PgUDG3Ygr02l4QBJW2BFzCVwWy/1yES9u2343xQoH409O0yu1
        UaFNmqa9R4p86+1EugZO9yUIys9QFE+EzA==
X-Google-Smtp-Source: ABdhPJyBdPoYSl8NXl+E/44DADnbMOyT9d8TqnoYnzrE7F8VWMpdilgKV2joCCqrBQxMipajJoteyQ==
X-Received: by 2002:a5d:5512:0:b0:1ef:5f08:29fb with SMTP id b18-20020a5d5512000000b001ef5f0829fbmr16513758wrv.653.1646144159036;
        Tue, 01 Mar 2022 06:15:59 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:29f7:2de4:80d1:2c1e])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003811f9102c0sm3874267wmi.32.2022.03.01.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 06:15:58 -0800 (PST)
Date:   Tue, 1 Mar 2022 15:15:51 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] clocksource/drivers/timer-microchip-pit64b: fix
 compilation warnings
Message-ID: <20220301141551.GA652055@linaro.org>
References: <20220301123449.2816625-1-claudiu.beznea@microchip.com>
 <20220301123449.2816625-8-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220301123449.2816625-8-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 02:34:49PM +0200, Claudiu Beznea wrote:
> Fix the following compilation warnings:
> timer-microchip-pit64b.c:68: warning: cannot understand function prototype: 'struct mchp_pit64b_clkevt '
> timer-microchip-pit64b.c:82: warning: cannot understand function prototype: 'struct mchp_pit64b_clksrc '
> timer-microchip-pit64b.c:283: warning: Function parameter or member 'timer' not described in 'mchp_pit64b_init_mode'
> timer-microchip-pit64b.c:283: warning: Function parameter or member 'max_rate' not described in 'mchp_pit64b_init_mode'
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/clocksource/timer-microchip-pit64b.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
> index f50705698283..5ce206723700 100644
> --- a/drivers/clocksource/timer-microchip-pit64b.c
> +++ b/drivers/clocksource/timer-microchip-pit64b.c
> @@ -46,7 +46,7 @@
>  
>  #define MCHP_PIT64B_NAME		"pit64b"
>  
> -/**

Those are specific for kernel-doc format:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/doc-guide/kernel-doc.rst#n33

You should fix the description format.

> +/*
>   * struct mchp_pit64b_timer - PIT64B timer data structure
>   * @base: base address of PIT64B hardware block
>   * @pclk: PIT64B's peripheral clock
> @@ -60,7 +60,7 @@ struct mchp_pit64b_timer {
>  	u32		mode;
>  };
>  
> -/**
> +/*
>   * mchp_pit64b_clkevt - PIT64B clockevent data structure
>   * @timer: PIT64B timer
>   * @clkevt: clockevent
> @@ -74,7 +74,7 @@ struct mchp_pit64b_clkevt {
>  	((struct mchp_pit64b_timer *)container_of(x,\
>  		struct mchp_pit64b_clkevt, clkevt))
>  
> -/**
> +/*
>   * mchp_pit64b_clksrc - PIT64B clocksource data structure
>   * @timer: PIT64B timer
>   * @clksrc: clocksource
> @@ -244,7 +244,7 @@ static void __init mchp_pit64b_pres_compute(u32 *pres, u32 clk_rate,
>  		*pres = MCHP_PIT64B_PRES_MAX - 1;
>  }
>  
> -/**
> +/*
>   * mchp_pit64b_init_mode - prepare PIT64B mode register value to be used at
>   *			   runtime; this includes prescaler and SGCLK bit
>   *
> -- 
> 2.32.0
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
