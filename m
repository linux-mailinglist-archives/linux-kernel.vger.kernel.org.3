Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5355EEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiF1UNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiF1UMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:12:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14242F1F;
        Tue, 28 Jun 2022 13:03:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k14so12047126plh.4;
        Tue, 28 Jun 2022 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9xiXVBUTdDVI8lRFYwUuLEFozRiUfkYmSBpqeP5Pj/g=;
        b=PO5WlPn4qyG4yNi2+rfOJbSHxIALmYuUWrA4TZGVKhRjHZpxR6pbZ7hBxxRbA/sDSL
         3DIop8siw1tIJcZZUyINlra+VotftTItQo+UEEk4C/GBBbTp9iUpuwArkASybwBUmvQ6
         ZQP7QL3nRp+3wrYyNfKoclZ4au6MmWiBNY2Br25HFduPBdm90fbyayjYHeGtc3o5/rHs
         6eCYPJ1fe41zPw8yNflAEx898BD0jc2eGvGa+lVrwjMZD6U2sv5XU6J2QxRh14thpujn
         sIbNlQxH6qROqEGbwd15TppO5R5Sl04g7DDUNQqVMWgTGQP8tkhf0emNLRIxkqyNvU/4
         CV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9xiXVBUTdDVI8lRFYwUuLEFozRiUfkYmSBpqeP5Pj/g=;
        b=OlC81HLlG8+pIxcIPj1W3fTJeDE26QTqZD+QesH7Yui8nm2f6PxGsBlciUlOmrf+qy
         A91dypjTr3occXh4ufhmDiWRG1ZHP55WA9FRbuQ9/G6L4VQ6Kr7mzlDHY62w2/fNEnGd
         c67HumGXGkGYdPYV+L9s7dglhq/ugArPrUabPKSOj0KfTj3ZoRZmTmYwLTROxAzMZ70f
         eNyLjSJzcLuzFYcp0gtqhnR4Ilt7njuVXSJdkNuUFvEQqgFlgWc7erZlk5L7FYzgLSAG
         Qxka/vBFIFPr1TYSu+kLGD4L4pxqPz9dZHq5JT2ZW6Y8X0p4YkB+jbED71WcWd/Ym6qQ
         fWYg==
X-Gm-Message-State: AJIora+71cR6ulVT6n66xrVCCKemrzdIj/L0vKMzXkHW6RvZ4M56Q/wH
        0IyBoe4QseuAzu6sVhonmxc=
X-Google-Smtp-Source: AGRyM1uBeSIjhAvi/nwBQTbee0LM7InUMfH8GHZBCqCHIukRmzKJIegbahKfSxwL6pqkTHIBh086dA==
X-Received: by 2002:a17:902:e80b:b0:16a:61da:924 with SMTP id u11-20020a170902e80b00b0016a61da0924mr6655821plg.54.1656446625604;
        Tue, 28 Jun 2022 13:03:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090320d100b0016a38f8ba7fsm9722949plb.162.2022.06.28.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:03:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Jun 2022 13:03:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 7/8] watchdog: tegra_wdt: Remove #ifdef guards for PM
 related functions
Message-ID: <20220628200343.GG3633970@roeck-us.net>
References: <20220628193449.160585-1-paul@crapouillou.net>
 <20220628193449.160585-8-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628193449.160585-8-paul@crapouillou.net>
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

On Tue, Jun 28, 2022 at 08:34:48PM +0100, Paul Cercueil wrote:
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to
> handle the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards. Not using #ifdef guards means that the code is
> always compiled independently of any Kconfig option, and thanks to that
> bugs and regressions are easier to catch.
> 
> While at it, the functions tegra_wdt_runtime_{suspend,resume} were
> renamed to tegra_wdt_{suspend,resume}, as they are *not* runtime-PM
> callbacks, but standard system suspend/resume callbacks.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-tegra@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/tegra_wdt.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
> index dfe06e506cad..d5de6c0657a5 100644
> --- a/drivers/watchdog/tegra_wdt.c
> +++ b/drivers/watchdog/tegra_wdt.c
> @@ -230,8 +230,7 @@ static int tegra_wdt_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int tegra_wdt_runtime_suspend(struct device *dev)
> +static int tegra_wdt_suspend(struct device *dev)
>  {
>  	struct tegra_wdt *wdt = dev_get_drvdata(dev);
>  
> @@ -241,7 +240,7 @@ static int tegra_wdt_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int tegra_wdt_runtime_resume(struct device *dev)
> +static int tegra_wdt_resume(struct device *dev)
>  {
>  	struct tegra_wdt *wdt = dev_get_drvdata(dev);
>  
> @@ -250,7 +249,6 @@ static int tegra_wdt_runtime_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct of_device_id tegra_wdt_of_match[] = {
>  	{ .compatible = "nvidia,tegra30-timer", },
> @@ -258,16 +256,14 @@ static const struct of_device_id tegra_wdt_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, tegra_wdt_of_match);
>  
> -static const struct dev_pm_ops tegra_wdt_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(tegra_wdt_runtime_suspend,
> -				tegra_wdt_runtime_resume)
> -};
> +static DEFINE_SIMPLE_DEV_PM_OPS(tegra_wdt_pm_ops,
> +				tegra_wdt_suspend, tegra_wdt_resume);
>  
>  static struct platform_driver tegra_wdt_driver = {
>  	.probe		= tegra_wdt_probe,
>  	.driver		= {
>  		.name	= "tegra-wdt",
> -		.pm	= &tegra_wdt_pm_ops,
> +		.pm	= pm_sleep_ptr(&tegra_wdt_pm_ops),
>  		.of_match_table = tegra_wdt_of_match,
>  	},
>  };
> -- 
> 2.35.1
> 
