Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD15A526284
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380529AbiEMNCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380507AbiEMNB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:01:59 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3A52ED6E;
        Fri, 13 May 2022 06:01:58 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-ee1e7362caso10396743fac.10;
        Fri, 13 May 2022 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4DgXjQ7qLUtCouOMfdCd3nk+S/RpYIcEVykY3tosRVU=;
        b=TJyCH7X42kBB88wYoNpckQxo1LMv7TZpH9zvb3vqBFkQcGo/OeYsVqTCRoaCPRvqcM
         8QdnY+S0bz8aPapnwttv+dqjooeF96VT6Mxu5907CClRSfCSozRV7/MeezKq/Wfpw76u
         N5WHq7eNAy+9jIpiFADRc1jpfFHGLPV34TSK2ZYKxLYmjLvnT9FyzQ+ylZgcVVNX67Vy
         ioZloyizHZ3IzZzccmHFAT1iybUDbAy6QRRPgb1Gw1VE4U2YMdszNhcCIHV0oENpCmVt
         /LhWKMSJN/sZlu2XY4SEapsYr4cTyeS07vQPTpBsgOkphTT8P74PHmjgUTlvmBv/gb+9
         r1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4DgXjQ7qLUtCouOMfdCd3nk+S/RpYIcEVykY3tosRVU=;
        b=Dq60huNuK7WDkaxxZ06KMkAaKojJ0N4asi2WVM70tgrxzqBtOSviXGeVaJSSrQvv2Z
         IZWQ6rfrtSAQa9KRWMwu6HLQWBfD5JeuyZ8qJ4hy1SZYh1GqAossMz64DPI+faXzy/Dc
         JSY5EBtMmk+xTAjnxJYeQIYOf4D/xLeqdWm1t2xcNu7s6Ex66y4xwQlsVrpk2LlFZjzy
         Vo0Gv5db1gZwBWUgYvJ3Izft8h0ojCviD1jXBIFGEuYGT6wvnE4RikvaN/rmwQdV3DSO
         JTnggPx+lU90qbvTo60c2TojGdhQVOUu0uuZWviadwqY+6ksQVfncN1Lp3Vbrra0Q/vR
         qdIg==
X-Gm-Message-State: AOAM531RijfP4EOHUh0RbYNWvQDwkYSK063oo3/X8ti5RqBpvFvqbxZC
        IyNVEKEFB6+IDrF+Vxuz6mDt2t33JVhRVQ==
X-Google-Smtp-Source: ABdhPJytU9SOdHuJqlGx52BoY/s/xcJDQNb2FlWAvJUqozU3v5sFftCl7lMtmx9nD10ovn823kJ++Q==
X-Received: by 2002:a05:6870:2047:b0:e9:1b34:fbe with SMTP id l7-20020a056870204700b000e91b340fbemr8228003oad.64.1652446917217;
        Fri, 13 May 2022 06:01:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a1-20020a9d5c81000000b0060603221240sm967368oti.16.2022.05.13.06.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 06:01:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0d5d8502-fec7-fc91-0932-647f3e74e7e1@roeck-us.net>
Date:   Fri, 13 May 2022 06:01:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/4] watchdog: simatic-ipc-wdt: convert to use P2SB
 accessor
Content-Language: en-US
To:     Henning Schild <henning.schild@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
References: <20220513083652.974-1-henning.schild@siemens.com>
 <20220513083652.974-3-henning.schild@siemens.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220513083652.974-3-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 01:36, Henning Schild wrote:
> Since we have a common P2SB accessor in tree we may use it instead of
> open coded variants.
> 
> Replace custom code by p2sb_bar() call.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig           |  1 +
>   drivers/watchdog/simatic-ipc-wdt.c | 15 ++++++++-------
>   2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index a7cd3ef5b3d8..0097fbb455ab 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1639,6 +1639,7 @@ config SIEMENS_SIMATIC_IPC_WDT
>   	tristate "Siemens Simatic IPC Watchdog"
>   	depends on SIEMENS_SIMATIC_IPC
>   	select WATCHDOG_CORE
> +	select P2SB
>   	help
>   	  This driver adds support for several watchdogs found in Industrial
>   	  PCs from Siemens.
> diff --git a/drivers/watchdog/simatic-ipc-wdt.c b/drivers/watchdog/simatic-ipc-wdt.c
> index 8bac793c63fb..6599695dc672 100644
> --- a/drivers/watchdog/simatic-ipc-wdt.c
> +++ b/drivers/watchdog/simatic-ipc-wdt.c
> @@ -16,6 +16,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
> +#include <linux/platform_data/x86/p2sb.h>
>   #include <linux/platform_data/x86/simatic-ipc-base.h>
>   #include <linux/platform_device.h>
>   #include <linux/sizes.h>
> @@ -54,9 +55,9 @@ static struct resource io_resource_trigger =
>   	DEFINE_RES_IO_NAMED(WD_TRIGGER_IOADR, SZ_1,
>   			    KBUILD_MODNAME " WD_TRIGGER_IOADR");
>   
> -/* the actual start will be discovered with pci, 0 is a placeholder */
> +/* the actual start will be discovered with p2sb, 0 is a placeholder */
>   static struct resource mem_resource =
> -	DEFINE_RES_MEM_NAMED(0, SZ_4, "WD_RESET_BASE_ADR");
> +	DEFINE_RES_MEM_NAMED(0, 0, "WD_RESET_BASE_ADR");
>   
>   static u32 wd_timeout_table[] = {2, 4, 6, 8, 16, 32, 48, 64 };
>   static void __iomem *wd_reset_base_addr;
> @@ -150,6 +151,7 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
>   	struct simatic_ipc_platform *plat = pdev->dev.platform_data;
>   	struct device *dev = &pdev->dev;
>   	struct resource *res;
> +	int ret;
>   
>   	switch (plat->devmode) {
>   	case SIMATIC_IPC_DEVICE_227E:
> @@ -190,15 +192,14 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
>   	if (plat->devmode == SIMATIC_IPC_DEVICE_427E) {
>   		res = &mem_resource;
>   
> -		/* get GPIO base from PCI */
> -		res->start = simatic_ipc_get_membase0(PCI_DEVFN(0x1f, 1));
> -		if (res->start == 0)
> -			return -ENODEV;
> +		ret = p2sb_bar(NULL, 0, res);
> +		if (ret)
> +			return ret;
>   
>   		/* do the final address calculation */
>   		res->start = res->start + (GPIO_COMMUNITY0_PORT_ID << 16) +
>   			     PAD_CFG_DW0_GPP_A_23;
> -		res->end += res->start;
> +		res->end = res->start + SZ_4 - 1;
>   
>   		wd_reset_base_addr = devm_ioremap_resource(dev, res);
>   		if (IS_ERR(wd_reset_base_addr))

