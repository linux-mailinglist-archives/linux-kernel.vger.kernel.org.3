Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19A155EF0B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiF1UOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiF1UL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:11:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFE613DC8;
        Tue, 28 Jun 2022 13:03:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a15so12932379pfv.13;
        Tue, 28 Jun 2022 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O18BNoD4QYCw1F/lcnmrBO02etfQ8RJzYCuHpe3r1UU=;
        b=WfoNeWhEisMXHw5gKjvS2MXabo67b3Z/nvM+Hu6P5rFQcz5RiovYr+SgXKFZCPAnu+
         8SkXvBTBEMKOvbe7WIfHh9yQ9/kZ6t/pSmdnph97VMUZtsqCL4GqgZcoTMr6K0uhN8yX
         XdNdBMYnw8MJ5S26JSmBevqE0LKT1uNeLPPektGhz41QbxTRPF5g/fuvVOLNwzfkTo1Z
         J3zHD6GVk39F1Q+r72HGLxot8k8bkQ0eRpmtWimLlRVHTap4+2KfMYBzKU/57kLv1Gd1
         ZORdMMbgko7I+rhIEiYd0zpEJ/laM5qNrBKxCvCS/oh/+7P/9doUelEEcnwZL02oxrGv
         PS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=O18BNoD4QYCw1F/lcnmrBO02etfQ8RJzYCuHpe3r1UU=;
        b=vvwHwx1yB69hOGuG/p21ohjle6FYpruc4gYbL/Mp7x9br+IGFPcizuSzJ9mXSf6wXH
         5ZCQ925r6cV1uHBQCCsbM/4CjvJFTPDQqJ7zU64tkqhUKWHHonFBQUl9HNecUzXAd/Id
         9G5yWF5fJurAKNhO/oWqgH5nBLpS4JtkVJp5IgWvc5Nuw+1CFEUQuGfaI7UeJnIOQTGx
         2sT0vdF4czZhR1hAm8a212RqcwQHclfUFiRHjzenspKeDhD1/WQLHss/Sgg3zV/B3V/c
         MH5+2GSjGccOVQUW9IdJmXhAejTn9xC4LWYA+SrxGmY24Rh6hD76HJQR+7EUim91hgTj
         qx+w==
X-Gm-Message-State: AJIora8q0P5cqd05scN3yrSGowcrherTeOA14J7Ibjsi3WBsi6fStfJq
        8x6G8fc9V3oMzNRZWMP3cm/hkX3JDx0=
X-Google-Smtp-Source: AGRyM1tOSUOdH1tsZ10Yv3CJ6SOKVD9V7qWVI5vrnJJSlqRo4SbPIpMFUDTGM28+dy/vfss5mPwWnQ==
X-Received: by 2002:a63:91c1:0:b0:40d:33cb:3d57 with SMTP id l184-20020a6391c1000000b0040d33cb3d57mr19527523pge.10.1656446615765;
        Tue, 28 Jun 2022 13:03:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902b58b00b0015e8d4eb26esm9687241pls.184.2022.06.28.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:03:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Jun 2022 13:03:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/8] watchdog: st_lpc_wdt: Remove #ifdef guards for PM
 related functions
Message-ID: <20220628200334.GF3633970@roeck-us.net>
References: <20220628193449.160585-1-paul@crapouillou.net>
 <20220628193449.160585-7-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628193449.160585-7-paul@crapouillou.net>
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

On Tue, Jun 28, 2022 at 08:34:47PM +0100, Paul Cercueil wrote:
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
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: linux-arm-kernel@lists.infradead.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/st_lpc_wdt.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
> index 14ab6559c748..39abecdb9dd1 100644
> --- a/drivers/watchdog/st_lpc_wdt.c
> +++ b/drivers/watchdog/st_lpc_wdt.c
> @@ -248,7 +248,6 @@ static int st_wdog_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int st_wdog_suspend(struct device *dev)
>  {
>  	struct st_wdog *st_wdog = watchdog_get_drvdata(&st_wdog_dev);
> @@ -285,16 +284,14 @@ static int st_wdog_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
> -static SIMPLE_DEV_PM_OPS(st_wdog_pm_ops,
> -			 st_wdog_suspend,
> -			 st_wdog_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(st_wdog_pm_ops,
> +				st_wdog_suspend, st_wdog_resume);
>  
>  static struct platform_driver st_wdog_driver = {
>  	.driver	= {
>  		.name = "st-lpc-wdt",
> -		.pm = &st_wdog_pm_ops,
> +		.pm = pm_sleep_ptr(&st_wdog_pm_ops),
>  		.of_match_table = st_wdog_match,
>  	},
>  	.probe = st_wdog_probe,
> -- 
> 2.35.1
> 
