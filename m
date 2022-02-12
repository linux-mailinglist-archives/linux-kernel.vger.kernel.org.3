Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2BB4B32F0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 05:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiBLECL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 23:02:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiBLECK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 23:02:10 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B679B27CE1;
        Fri, 11 Feb 2022 20:02:07 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q8so11739890oiw.7;
        Fri, 11 Feb 2022 20:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X3DWkDY6ESlWW05nvdEyd2HzU/P3SWIS/jrRQOMR1l4=;
        b=WKT0f+xCcOarZO8/foFf5IbjLo15xrueshlHrfTUo0hmkvtosR47Ck4vrH2xnL0nnz
         JsCIM+UhYKNsjdIaaeWO5FVMOLliQ2RzLc5F4t5l/eNVFKoFOjKqM3KyBW8vmCYCEiPo
         wqfXAzzUo4KUzSmjYqkIgiPDOTRKRq5Vz5QP3e6TjxssdwJK0BX4u2gmc/lj781x0piM
         d6j2LKbYJ1m+z6rI2fABp9HC8paZxDG6l0gO0w+5KZGK+ctLrIBIP0orTWk+1IQxDsM5
         iG6aSnBMdzCFi5YyKjGKwEV9A3xM4uKP84VjMC1X8YcakXmuv2xReADdueUQ5VOd/3EN
         d7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X3DWkDY6ESlWW05nvdEyd2HzU/P3SWIS/jrRQOMR1l4=;
        b=maecwF84WiriHDVVCxIjc4kNvJ8YW64eSuflchKyy1kFYpHRmEgjq0OzdYgTYuQ4vI
         gIHIUK2GkaZ6l9I7XgJ9okcrRn9DFa5blz3mwT6iO5M3Mim5iRN8wB6CL/4c75DoGnxx
         RZ06GUPs56pf6fU0kLUO+DYkQKsXXyUt9WVP5lDpIHOf0XCltZUgFLwdbu54EZ54XqeD
         ndZVDf6e9+emw0I+8I8cNHL+dC9giLXm2vK56Gh7Ei473dPirIAbhyvji8W8tTzQ9cl9
         w9sme77tyiUtfdu3DSV65BoqDbw1TY1OmLDsMIHasnn2OcBo43Udgp2ixPSbvZZps065
         i3Kg==
X-Gm-Message-State: AOAM533393oF5g7tV+lMMQkG//wpfon/GGw4H35kVGf2xitutNbr0PQu
        NUY4yIn1Yf1nno+cY5j2l0c=
X-Google-Smtp-Source: ABdhPJzNOYdgS4SXIN65376CQZW54WyRewQE8KvwxCdexhi/zH0UUxsVMFGMsWoTmeq52WFJKYPHaw==
X-Received: by 2002:a05:6808:138c:: with SMTP id c12mr1606395oiw.278.1644638527028;
        Fri, 11 Feb 2022 20:02:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 9sm7134624oas.27.2022.02.11.20.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 20:02:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <af800c8b-8ad8-a335-0f72-ee636c02e9ef@roeck-us.net>
Date:   Fri, 11 Feb 2022 20:02:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] watchdog: aspeed: add nowayout support
Content-Language: en-US
To:     Eduardo Valentin <eduval@amazon.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Eduardo Valentin <evalenti@kernel.org>
References: <20220212021033.2344-1-eduval@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220212021033.2344-1-eduval@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 18:10, Eduardo Valentin wrote:
> Add support for not stopping the watchdog
> when the userspace application quits. At
> closing of the device, the driver cannot
> determine if this was a graceful closure
> or if the app crashed. If the support
> of nowayout on this driver, the system integrator
> can select the behaviour by setting the kernel
> config and enabling it.
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org> (maintainer:WATCHDOG DEVICE DRIVERS)
> Cc: Guenter Roeck <linux@roeck-us.net> (maintainer:WATCHDOG DEVICE DRIVERS)
> Cc: Joel Stanley <joel@jms.id.au> (supporter:ARM/ASPEED MACHINE SUPPORT)
> Cc: Andrew Jeffery <andrew@aj.id.au> (reviewer:ARM/ASPEED MACHINE SUPPORT)
> Cc: linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS)
> Cc: linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
> Cc: linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
> Cc: linux-kernel@vger.kernel.org (open list)
> Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Eduardo Valentin <evalenti@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/aspeed_wdt.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 436571b6fc79..bd06622813eb 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -13,6 +13,11 @@
>   #include <linux/platform_device.h>
>   #include <linux/watchdog.h>
>   
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
>   struct aspeed_wdt {
>   	struct watchdog_device	wdd;
>   	void __iomem		*base;
> @@ -266,6 +271,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	wdt->wdd.timeout = WDT_DEFAULT_TIMEOUT;
>   	watchdog_init_timeout(&wdt->wdd, 0, dev);
>   
> +	watchdog_set_nowayout(&wdt->wdd, nowayout);
> +
>   	np = dev->of_node;
>   
>   	ofdid = of_match_node(aspeed_wdt_of_table, np);

