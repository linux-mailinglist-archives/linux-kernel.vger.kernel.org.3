Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C0B526C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384646AbiEMVS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240772AbiEMVSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:18:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1792B522E5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:18:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x18so9107158plg.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o0kVmjdcMUKYVM5DrVqgurkhzcUKhblSSgNmYbuiRRg=;
        b=CcTeCWOYH5IP5w44cu7dNo2TnZ/9Jx/DeJm8b0kUpZgsy3l9UnRTVQ62bBl7e+LpPY
         uTdOP+qtH8CxKFdV2hEA9fdjzPRETXryPhxAhm2mbvT25s0H8e5hfRE9HbHgjjFvBC1e
         3BemwWOw7u583NKe+1Yuls4TqwcQRtR0N9ZLSR/motIt3kq9nTk4lxphNAvqQkzq43aw
         HhEA8WBEupPU7Uu95wWDZaGYEYzVGLa/9rBljxZ6OaVeYVZsD9/dsJHcR949/J/TWQTE
         eAdD0/JMKMNyAUIfnZ0iKXk3F4e/fiGixPeE9DWiMjcAxji6GevP3vM2aTiyzhHwPM9K
         bVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o0kVmjdcMUKYVM5DrVqgurkhzcUKhblSSgNmYbuiRRg=;
        b=xQHfSbBCcKHZcKHSbYjPotzLMTU2iMUDCW8L8EDURtFuqfnIv9WiIgw6op10slYsIb
         Vyx0mgmUeNEUt2CMVPPzEmZpaqzL7NMVDltYwxws/oqNxdvDhd3E1zCDutnRemaSXCQ4
         K/N2D5FxpCLJYpMH73gaFXDAq7DHU0HywiO7cQwCTuf43wZ/0Bel4qIwSi8SN0Uw+on9
         3ICcqJ2CKi4o5GUBbjdBfBl0joIE34KN7BUlWNNTxSMxBdr1k9uZCEY+FRolBnV5iU7E
         MyTUbizGBbo97o5PsuHrUUAn9Pmw78oMNpnw/18AQHnY4ANPuGwNWtQU9B4Iac1KxRtF
         85hw==
X-Gm-Message-State: AOAM531evYVrnaoldloXjZ9cspkp3MBMPsQ4vNf80gtUIsSyRTbpzfRo
        CO70BmGLV3AMGp6Ko8XzF/Lxcl0UFpA=
X-Google-Smtp-Source: ABdhPJylH80zUax/Bff44bHOHv24DhDjZB72DDduOGylPZmRgW3vOHvN+YkNJC2dl5gyEI0/w2z6vw==
X-Received: by 2002:a17:90b:1291:b0:1db:eab7:f165 with SMTP id fw17-20020a17090b129100b001dbeab7f165mr18071902pjb.74.1652476702383;
        Fri, 13 May 2022 14:18:22 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id v8-20020a1709028d8800b0015e8d4eb1f3sm2304845plo.61.2022.05.13.14.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 14:18:21 -0700 (PDT)
Date:   Sat, 14 May 2022 06:18:19 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] init: call time_init() before rand_initialize()
Message-ID: <Yn7LG3zlcKPaOXkp@antec>
References: <20220505003114.177552-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505003114.177552-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 02:31:14AM +0200, Jason A. Donenfeld wrote:
> Currently time_init() is called before rand_initialize(), but
> rand_initialize() makes use of the timer on various platforms, and
> sometimes this timer needs to be initialized by time_init() first. In
> order to not return zero, reverse the order of these two calls. The
> block doing random initialization was right before time_init() before,
> so changing the order shouldn't have any complicated effects.
> 
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

I was thinking along the same lines when I looked into the OpenRISC issue
that we fixed discussed here:

 - https://lore.kernel.org/all/Ym27sFdFZEt5QV0i@antec/

Though, I was not sure as to any dependency issues caused by changing the
order.  Having it in -next and testing for a while should be able to
bring out any bug.

As for this patch:

Reviewed-by: Stafford Horne <shorne@gmail.com>

> ---
> Andrew - this file has no formal maintainer, but you've signed the most
> commits, so I'm CC'ing you. This has some interactions with my
> random.git tree, so unless there are objections, I'll queue it up there.
> -Jason
> 
>  init/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 98182c3c2c4b..e37ec99cf56d 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1035,6 +1035,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  	softirq_init();
>  	timekeeping_init();
>  	kfence_init();
> +	time_init();
>  
>  	/*
>  	 * For best initial stack canary entropy, prepare it after:
> @@ -1049,7 +1050,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  	add_device_randomness(command_line, strlen(command_line));
>  	boot_init_stack_canary();
>  
> -	time_init();
>  	perf_event_init();
>  	profile_init();
>  	call_function_init();
> -- 
> 2.35.1
> 
