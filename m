Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720A855EEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiF1UNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiF1ULz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:11:55 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EB43A73F;
        Tue, 28 Jun 2022 13:03:07 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e63so13212339pgc.5;
        Tue, 28 Jun 2022 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rEFNBAp2rK8tG0znpxJYCMRlWPc6NvbqoMLW4LzSJfk=;
        b=MIGeY0RhS9CN40/vGDp7FQeaUW55mq9Qr4KpwEyoE3Q77hTZfXkuDJ/d6Wk0MHz8Uf
         ivnaaF1YKNJVw5ssrdAsQAhuNpvvzA/l4t92b5OzTe2qBq+o+JyQqiAIFXPIXuOoV6pO
         UbwVoDi6XKK7wH4GtCzsoDxqDUmbB5fFVfQs1+UzLMgf9oY7+tzMV9z8F4WV4lGoxsnt
         fnmRaIRpgR8MLN2Q8KXFutIS0K/RI4DoFub81Hy+Ib7b3uZ+KL+I+3P5fyDFRWFk4ubc
         GdeUPoT+S50BaRUJCUBu0MzmGZpvicdgXql0+hwY20sdsSqspWf0a8/Nm02Y1d0Gxbqk
         LX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rEFNBAp2rK8tG0znpxJYCMRlWPc6NvbqoMLW4LzSJfk=;
        b=P9mkQRIUTLCF1YvC6xf1JivbDmj1swKsUTHoYghmGdVXXThi8RzkCaANNf4iRhfoOv
         XM0SRecP3DadqPmlmRrMqMG5NxI1mO/8h9x375F68TEY5PdeiN5NuRjEPhD1fYx23Wib
         ck9NLmXWNM2746L1pdBt1XPyYn4py6n1W/cBlfGXIQ2HKFtOoMB3IVIoNDK0mPfYXAtn
         zUp37iCAA+ZoW3464yvcWi+47zBWkX/39gb0kEcR+KI0vRBUcpYmY3o1s+1ma753b/rx
         2iHCKzC12Hc8SbGUlAiiOAZQDeUaTBBGOH+SS4Dg+8ihtg5qq9rMU5gwulObfygcHfl5
         pSjQ==
X-Gm-Message-State: AJIora9QaxN7OcZFByy9tfNgu88gXhJLi8dmHaa4aVEPw8P3iJpUSYVt
        suTHtceRIg35FlRmMyK535I=
X-Google-Smtp-Source: AGRyM1ubUd6iMiZ5FInUp79X9UHmw0Zc+5SomdCP0cuuxV5u0WVcVO0qFx8FQl68HaZHGEPi7qRnUg==
X-Received: by 2002:a63:b444:0:b0:40c:f936:a21a with SMTP id n4-20020a63b444000000b0040cf936a21amr19713224pgu.37.1656446587334;
        Tue, 28 Jun 2022 13:03:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090340c400b001616723b8ddsm9651148pld.45.2022.06.28.13.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:03:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Jun 2022 13:03:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 4/8] watchdog: s3c2410_wdt: Remove #ifdef guards for PM
 related functions
Message-ID: <20220628200305.GD3633970@roeck-us.net>
References: <20220628193449.160585-1-paul@crapouillou.net>
 <20220628193449.160585-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628193449.160585-5-paul@crapouillou.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 08:34:45PM +0100, Paul Cercueil wrote:
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to
> handle the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards. Not using #ifdef guards means that the code is
> always compiled independently of any Kconfig option, and thanks to that
> bugs and regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/s3c2410_wdt.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 6db22f2e3a4f..95919392927f 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -845,8 +845,6 @@ static void s3c2410wdt_shutdown(struct platform_device *dev)
>  	s3c2410wdt_stop(&wdt->wdt_device);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -
>  static int s3c2410wdt_suspend(struct device *dev)
>  {
>  	int ret;
> @@ -885,10 +883,9 @@ static int s3c2410wdt_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
> -static SIMPLE_DEV_PM_OPS(s3c2410wdt_pm_ops, s3c2410wdt_suspend,
> -			s3c2410wdt_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(s3c2410wdt_pm_ops,
> +				s3c2410wdt_suspend, s3c2410wdt_resume);
>  
>  static struct platform_driver s3c2410wdt_driver = {
>  	.probe		= s3c2410wdt_probe,
> @@ -897,7 +894,7 @@ static struct platform_driver s3c2410wdt_driver = {
>  	.id_table	= s3c2410_wdt_ids,
>  	.driver		= {
>  		.name	= "s3c2410-wdt",
> -		.pm	= &s3c2410wdt_pm_ops,
> +		.pm	= pm_sleep_ptr(&s3c2410wdt_pm_ops),
>  		.of_match_table	= of_match_ptr(s3c2410_wdt_match),
>  	},
>  };
> -- 
> 2.35.1
> 
