Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B5155EEEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiF1UMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiF1ULv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:11:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9089C3BF99;
        Tue, 28 Jun 2022 13:02:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d5so12000966plo.12;
        Tue, 28 Jun 2022 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NljXJBG26GXRLDndTufV1GToRQB1S/ETixSRLhxAay4=;
        b=mLahzZ0tfB6yvJ5gfZGcaeYiBXGSuNn7/SeIB9qTM5t15c2xxHWzIqvWEyyGU5vgXj
         TzwgmeJHhTeftbYfWRF9DfK6PEHYkcf+/mOkOEO0Ax5eSJwmqTawUbyZ83ZGalLJZq78
         G8gCfxD0zjap7MNU/2GB9NbOxLN8A9VdaKuHuVGHGv0F+BGz8mzFOKwuJSQDlydqW0Og
         /Rqf3ID75S1hRF1Tbyz3wCVab6vw+hKSUqvkoFUmQwLDQQbbN4Mt1dX1Qe+45PkbgIWl
         pLv6Suiafs7WSFJz8CoL1jGACNwvOd71r3gGkmpHhgluQnCydc7c3VS6z543EeQJVddz
         az4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NljXJBG26GXRLDndTufV1GToRQB1S/ETixSRLhxAay4=;
        b=kk4/sYIVEuQfeNC/AEk1MdRJVMNAyHboZFSc34HeGS23zLXhxy69h6yqBRDj8ntzJy
         ReuWbziiqgcPpSbLAgBGP4CpmzpGIqRB282buj36zUsi8mNzywHldUuRKz58GN7wlPEK
         37hoKxl8HnphMWmc9mf+k5SRF6AGp+OjSXqGjTp0IAbUTxU+2JWP/3m8FH65OUEYwdQo
         V6gZxmO4TRMjoGCQ3V0qlvjN365QT88AMinlYS3HBeQWFLAm64sGEcJL85qqmqOiCa7t
         jOmQ31XCtWw3RK5htAhMddn+uuQPlI1T1WRAOoOfonHVlDzEJPWsCWjZCDkwJrywnfMY
         jepg==
X-Gm-Message-State: AJIora/ECaXUcxt77dLBjiwBCPjXNEFvgHKsSbubw0pBCCvMQX7DTahn
        v5l46D0CrqdRbfPdj21vrNQPl2LNeE8=
X-Google-Smtp-Source: AGRyM1vy9GaMJj4UifpZjob7CTqioImFgFJCCHUBsv9GCdMcBoRHUeksYmcw4pDuR6nGryQElVy5QQ==
X-Received: by 2002:a17:90b:1b0e:b0:1ec:e2f6:349e with SMTP id nu14-20020a17090b1b0e00b001ece2f6349emr1470333pjb.14.1656446561017;
        Tue, 28 Jun 2022 13:02:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b001640beeebf1sm9620594pls.268.2022.06.28.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:02:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Jun 2022 13:02:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] watchdog: dw_wdt: Remove #ifdef guards for PM
 related functions
Message-ID: <20220628200239.GB3633970@roeck-us.net>
References: <20220628193449.160585-1-paul@crapouillou.net>
 <20220628193449.160585-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628193449.160585-3-paul@crapouillou.net>
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

On Tue, Jun 28, 2022 at 08:34:43PM +0100, Paul Cercueil wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/dw_wdt.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index cd578843277e..060dae67d852 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -375,7 +375,6 @@ static irqreturn_t dw_wdt_irq(int irq, void *devid)
>  	return IRQ_HANDLED;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int dw_wdt_suspend(struct device *dev)
>  {
>  	struct dw_wdt *dw_wdt = dev_get_drvdata(dev);
> @@ -410,9 +409,8 @@ static int dw_wdt_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_PM_SLEEP */
>  
> -static SIMPLE_DEV_PM_OPS(dw_wdt_pm_ops, dw_wdt_suspend, dw_wdt_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(dw_wdt_pm_ops, dw_wdt_suspend, dw_wdt_resume);
>  
>  /*
>   * In case if DW WDT IP core is synthesized with fixed TOP feature disabled the
> @@ -710,7 +708,7 @@ static struct platform_driver dw_wdt_driver = {
>  	.driver		= {
>  		.name	= "dw_wdt",
>  		.of_match_table = of_match_ptr(dw_wdt_of_match),
> -		.pm	= &dw_wdt_pm_ops,
> +		.pm	= pm_sleep_ptr(&dw_wdt_pm_ops),
>  	},
>  };
>  
> -- 
> 2.35.1
> 
