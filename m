Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7015160CA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiD3Wjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiD3Wjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:39:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A737DABF;
        Sat, 30 Apr 2022 15:36:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n8so9916758plh.1;
        Sat, 30 Apr 2022 15:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vSsjcxY4/J413q1CK/LHbfCgeiHmsuLpMe8RS2dCiuo=;
        b=UekdpH4YTibTYVTUFPohxZrCX1QH3oxp9t9/P4i3SUH+HbSgFgllhuV+gKN/6f+UaJ
         tu0h11yOrnxAxDjPqN0pYMV6I9aFVFt6Z8W5IGuql0VainfP+fbsi+4mjO4x7znSaSLw
         gVB6yk2pfGMRZ/SVYhRyypDFJvZFgZShgvrHPo7xU8sg1/3vr2hE0gm8EkZCAFpXpyL+
         WNUI05oxr9Wf3rJhwpLaOnMkeXMRRQF4mpC84bb0t5Jc6LyNEGUcU7spLb0hmQfiDfWP
         +gnGS6mCBpvKPNklO8hFL9ZGXlT2+OJcS2ajWLYTjRKGvtFBvW9oZY2VZLEVbTfkMMr5
         +VcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vSsjcxY4/J413q1CK/LHbfCgeiHmsuLpMe8RS2dCiuo=;
        b=geecwYyLqb9Od5bRcD+LDvyjCPfJYZmUpTQzrLojgauEzDdDUJIPhXGmlcwvBfO0aC
         MCny4X7AlIV/jE8UeUp2GTyEkogLbRrVq3JGNUnX0kgzuPuu8y1WyMn80qcsazEa9+DD
         30984VloemqPlDoOXDZC63orFVFkYJYDYix+GhoFegRsudsj/Xj+9SNRY8uTUc0NYy29
         Yws7nt11Z/eFFr3Qwgp4LQ2GO5e9ARq0gi85Qy5Bam4rY2N2VRfi39dBGkqrCWZYgTXE
         nDsKEcdJfDYGMWbxYogmu3sCR13ejgclIMdZOd+JcXeZuXEeo9VsOwf8cOivGR4YIuzz
         G5xw==
X-Gm-Message-State: AOAM532Wxvfj6U4rJlnBdfbvV5tG0L/b2g13W02zYhqgYvfMGAxGJKDL
        jTFvQjnnKFEsGiQGf0gBBjI=
X-Google-Smtp-Source: ABdhPJztogzbcZq5iRfuZtqvrc4NSpl2Xeg+NAS8yrSWtsooguSLnMBX8ilzE2be0jWAmzN/fhFlDw==
X-Received: by 2002:a17:902:f690:b0:15e:9825:291 with SMTP id l16-20020a170902f69000b0015e98250291mr1712407plg.89.1651358189490;
        Sat, 30 Apr 2022 15:36:29 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id r13-20020a62e40d000000b0050dc76281bcsm1998777pfh.150.2022.04.30.15.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 15:36:28 -0700 (PDT)
Date:   Sun, 1 May 2022 07:36:27 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v8 06/19] openrisc: start CPU timer early in boot
Message-ID: <Ym2567zStHwlND35@antec>
References: <20220430122355.2718797-1-Jason@zx2c4.com>
 <20220430122433.2719029-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430122433.2719029-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 02:24:33PM +0200, Jason A. Donenfeld wrote:
> In order to measure the boot process, the timer should be switched on as
> early in boot as possible. This is necessary so that by the time the
> setup code reaches random_init(), get_cycles() (by way of
> random_get_entropy()) returns non-zero, indicating that it is actually
> capable of counting. So this commit enables the timer immediately upon
> booting up. As well, the commit define the get_cycles macro, like the
> previous patches in this series, so that generic code is aware that it's
> implemented by the platform, as is done on other archs.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v7->v8:
> - Rather than doing get_cycles()+1 to handle the early boot case,
>   actually start the timer early in boot. This has the huge advantage of
>   properly measuring the boot sequence timing, which could be a valuable
>   source of entropy.
> 
>  arch/openrisc/include/asm/timex.h | 1 +
>  arch/openrisc/kernel/setup.c      | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/openrisc/include/asm/timex.h b/arch/openrisc/include/asm/timex.h
> index d52b4e536e3f..5487fa93dd9b 100644
> --- a/arch/openrisc/include/asm/timex.h
> +++ b/arch/openrisc/include/asm/timex.h
> @@ -23,6 +23,7 @@ static inline cycles_t get_cycles(void)
>  {
>  	return mfspr(SPR_TTCR);
>  }
> +#define get_cycles get_cycles
>  
>  /* This isn't really used any more */
>  #define CLOCK_TICK_RATE 1000
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index 0cd04d936a7a..1cb7c1770a17 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -220,6 +220,13 @@ void __init setup_cpuinfo(void)
>  
>  void __init or1k_early_setup(void *fdt)
>  {
> +	/* Start the TTCR as early as possible, so that the RNG can make use of
> +	 * measurements of boot time from the earliest opportunity. Especially
> +	 * important is that the TTCR does not return zero by the time we reach
> +	 * rand_initialize().
> +	 */
> +	mtspr(SPR_TTMR, SPR_TTMR_CR);
> +
>  	if (fdt)
>  		pr_info("FDT at %p\n", fdt);
>  	else {

It looks like we cross paths on this one.

I can't think of anything better.  Also, I tested this on SMP systems and it
works fine.

Acked-by: Stafford Horne <shorne@gmail.com>
