Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC80255EF11
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiF1UPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiF1UPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:15:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C83D49C;
        Tue, 28 Jun 2022 13:09:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so7777352pjj.3;
        Tue, 28 Jun 2022 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=18NkAn1GgdBz8r/hLBakt8hEcJdWNO1JjoNeRXLblSI=;
        b=nQ2a8AVxe9IysiwaafuC3bzQW02iN1FKsDQu7R6CUn2dvYkAkn/EBIu6DzLCdOd9nv
         NVV8FPJik/bRgTBWrDULepoeh7/AkOERz8MATQvX/TyOy1DQS/i4+e4t73M9huDUfOqO
         gVGdbcbvHGu6t3JSecsB4guMtJx42TBE23XIDuSvpspObUVZ0bHQUnPooMcgbLdsH1UD
         +aLqYPlJ88v9OuAAmI/tjpYoP3BLFaKmzP2Ci2jd8y+uc1E2le8mT2PcLmtICpMFyA1F
         cC54R8b4z0A4U/RHWHv56bJbF5nxa04yLJuDxKM02aI5lH0z8RBLMDWjdcgATiTVsV9a
         Dkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=18NkAn1GgdBz8r/hLBakt8hEcJdWNO1JjoNeRXLblSI=;
        b=Kmw9TOTo3fhYsnHZ/uw1rH62fKLgiwJQ1xKI/bFBafqg14sOvBS5grp4d+yGvl8IJw
         q5toe+ULNFNgDXwtY/UNP2AOoxRgoUBGmTVbS0nWK89RQPJI/ouJ5FtH17ieEBuPVd7g
         jCH+uRDXQquaOH1TcSzm38ktLhKMWNP7OpTh/0XM0BTYQBdbQR3AUE4SDKIl5iAXt47R
         sIBS9B0h2AhT2WHodKSfN/mIelLhCD0R/OthRGso9xNjToqXVmnNnaBYfuBdvzMp917x
         L1vZt6+lAe1XuAeFUIR5sRAQNU1PFIEXDRDax+TOmaJIm/DIKkSSo2vWHb06QzoyImoC
         foTQ==
X-Gm-Message-State: AJIora9xXhgz6OljkVu0Qthl2KBrZI2c6dbKF3qSNF4OVBqHXSb1+nYz
        2NseeNkdJQXKRlwbebnOm2s=
X-Google-Smtp-Source: AGRyM1tpdNulnZ1BuFCtbNdRUOeKU2L6GH+7kbydoo7RVgIk5ZG2B9fvYla9X+GhGys3eu35PsJWbA==
X-Received: by 2002:a17:902:ca83:b0:16a:3317:b5c1 with SMTP id v3-20020a170902ca8300b0016a3317b5c1mr5395117pld.34.1656446954315;
        Tue, 28 Jun 2022 13:09:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id nu4-20020a17090b1b0400b001eaec814132sm3534864pjb.3.2022.06.28.13.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:09:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Jun 2022 13:09:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] watchdog: wdat_wdt: Remove #ifdef guards for PM
 related functions
Message-ID: <20220628200912.GH3633970@roeck-us.net>
References: <20220628193449.160585-1-paul@crapouillou.net>
 <20220628193449.160585-9-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628193449.160585-9-paul@crapouillou.net>
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

On Tue, Jun 28, 2022 at 08:34:49PM +0100, Paul Cercueil wrote:
> Use the new NOIRQ_SYSTEM_SLEEP_PM_OPS() and pm_sleep_ptr() macros to
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
>  drivers/watchdog/wdat_wdt.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index e6f95e99156d..aeadaa07c891 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -467,7 +467,6 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  	return devm_watchdog_register_device(dev, &wdat->wdd);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int wdat_wdt_suspend_noirq(struct device *dev)
>  {
>  	struct wdat_wdt *wdat = dev_get_drvdata(dev);
> @@ -528,18 +527,16 @@ static int wdat_wdt_resume_noirq(struct device *dev)
>  
>  	return wdat_wdt_start(&wdat->wdd);
>  }
> -#endif
>  
>  static const struct dev_pm_ops wdat_wdt_pm_ops = {
> -	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(wdat_wdt_suspend_noirq,
> -				      wdat_wdt_resume_noirq)
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(wdat_wdt_suspend_noirq, wdat_wdt_resume_noirq)
>  };
>  
>  static struct platform_driver wdat_wdt_driver = {
>  	.probe = wdat_wdt_probe,
>  	.driver = {
>  		.name = "wdat_wdt",
> -		.pm = &wdat_wdt_pm_ops,
> +		.pm = pm_sleep_ptr(&wdat_wdt_pm_ops),
>  	},
>  };
>  
> -- 
> 2.35.1
> 
