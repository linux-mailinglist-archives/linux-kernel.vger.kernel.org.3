Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1C455EEDB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiF1UMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiF1ULu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:11:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A393A71C;
        Tue, 28 Jun 2022 13:02:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so7762289pjj.3;
        Tue, 28 Jun 2022 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fg9XC32zNr922JpapA5Tx81mxJOauJJDfDFPBA46eRE=;
        b=NRdwhFN2GFCNRz8x28uK2c8twhkLWX9cC10t5eeEq4R3lec5oVejmR3kQQpIe0d9bZ
         grQ8QnzWgFrsIJqnS4KB4biwMjzGHmbVDTdM+ibzKeO6l7bRs0Mz6ySrBhP/jp4q/s86
         Dov37HMODTGcus+PksRQHpMPJc2cKWBbd/bMDk34YhOLuee/B+loYg9pqPJ/DYKUrQLv
         90VDxKh0V6RnCVMu+Fn0M88wiEEd530Rq+L7sUsD4pOqsIkmbJoLsSjPrYolu3PFMUWk
         G4qplV5D3JWVu7LLpneKbf3hFH/UCcqIEaId0oTx0krqrPe2kTD/gtOhL6+R21oehybj
         3s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fg9XC32zNr922JpapA5Tx81mxJOauJJDfDFPBA46eRE=;
        b=hB65Q3lgYU3OZ2ZtJy5fK8AR8uhu8VsOW3Bq+Xr9UViNV8U5s4KUJlc1bHdDByAT5j
         GQI9zHZhfJnzNtknpYGb6dL7xE7kg4fWMgNMAn4DKQQF+MilJyKlZGdmXWrcXLGXus9e
         /7jlk4GCPUxwQRMdcbGrGRYkrqpZ/lULmDqZjtyEkBOKc5ovMVs6dYa23Y6qnReF1d8b
         hxBTGiIvvi0NPLKL3pqL9a4RYgrlJN4prf/+KFfm+PBQn5/7bDxMxVY8POUJ9/Ls3i9b
         TeLn01+PBGlzYjWvk6bqAIMmqp56M45GE/J+hPJJPBUKHp2caGjKktsFNPchzJcSj29O
         ydGw==
X-Gm-Message-State: AJIora8GVMTLQ3p0JQX88jDRRiyuj6PISyimwXh5+YejJGfsmiGAkRKp
        A/+UaGMPjI1t2m7dg/7wQcU=
X-Google-Smtp-Source: AGRyM1vnfRzQBbbyZhHa/DPO1Dl4Zol8HS9B0SlB12blK3cuna6idhce8i5GguFTvyweZi+QIpUk+w==
X-Received: by 2002:a17:90b:214:b0:1ec:81e6:a2a6 with SMTP id fy20-20020a17090b021400b001ec81e6a2a6mr1438437pjb.53.1656446551168;
        Tue, 28 Jun 2022 13:02:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r7-20020a17090a690700b001ec9f9fe028sm241044pjj.46.2022.06.28.13.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:02:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Jun 2022 13:02:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 1/8] watchdog: bcm7038_wdt: Remove #ifdef guards for PM
 related functions
Message-ID: <20220628200228.GA3633970@roeck-us.net>
References: <20220628193449.160585-1-paul@crapouillou.net>
 <20220628193449.160585-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628193449.160585-2-paul@crapouillou.net>
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

On Tue, Jun 28, 2022 at 08:34:42PM +0100, Paul Cercueil wrote:
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
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/bcm7038_wdt.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
> index 1ffcf6aca6ae..9388838899ac 100644
> --- a/drivers/watchdog/bcm7038_wdt.c
> +++ b/drivers/watchdog/bcm7038_wdt.c
> @@ -192,7 +192,6 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int bcm7038_wdt_suspend(struct device *dev)
>  {
>  	struct bcm7038_watchdog *wdt = dev_get_drvdata(dev);
> @@ -212,10 +211,9 @@ static int bcm7038_wdt_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
> -static SIMPLE_DEV_PM_OPS(bcm7038_wdt_pm_ops, bcm7038_wdt_suspend,
> -			 bcm7038_wdt_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(bcm7038_wdt_pm_ops,
> +				bcm7038_wdt_suspend, bcm7038_wdt_resume);
>  
>  static const struct of_device_id bcm7038_wdt_match[] = {
>  	{ .compatible = "brcm,bcm6345-wdt" },
> @@ -236,7 +234,7 @@ static struct platform_driver bcm7038_wdt_driver = {
>  	.driver		= {
>  		.name		= "bcm7038-wdt",
>  		.of_match_table	= bcm7038_wdt_match,
> -		.pm		= &bcm7038_wdt_pm_ops,
> +		.pm		= pm_sleep_ptr(&bcm7038_wdt_pm_ops),
>  	}
>  };
>  module_platform_driver(bcm7038_wdt_driver);
> -- 
> 2.35.1
> 
