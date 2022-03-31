Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3204ED3BF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiCaGKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiCaGKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:10:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041F038D90;
        Wed, 30 Mar 2022 23:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93A276167F;
        Thu, 31 Mar 2022 06:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70875C340F0;
        Thu, 31 Mar 2022 06:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648706934;
        bh=pgB4jTziZhebTrn8JVBVdaOH2FmDFsYbZ9Mh1b/KUQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sG1tSuJFevehjqzpmojcnru0IbEdYN3e9pxUrAOZKBPHTsIAyL4Avm3hyb74jlAXW
         NyTp9UXFJe0tSQB57iOX34o8kBqmiy6OA6nVgD4iFCbNeBA7aUnmAJNHw7+ZVH8OdP
         FWHrWlIcoJDhjGILTWkvyP8n34MaAixTpIAXTsf8fN2QcvxoBKUA90e8pufpyTqwnY
         m98S7CyDTOyXu7GszhA1Zs6OBFl2UhBUbyMWtBFHQRMiU6P4JgK5hTl2iz+KsmDIB+
         RzUf/uVAb+4BKK0nphmRHy6v9LhW0dDaw89+Nt/Xc62c8FVc9O5HWbMPx961Msnhb3
         ZjUV27ZqX/WJg==
Date:   Thu, 31 Mar 2022 14:08:51 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        geert+renesas@glider.be, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH v4 2/2] watchdog: Add Renesas RZ/N1 Watchdog driver
Message-ID: <YkVFc6Q6/6rxSw89@google.com>
References: <20220330100829.1000679-1-jjhiblot@traphandler.com>
 <20220330100829.1000679-3-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330100829.1000679-3-jjhiblot@traphandler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 12:08:29PM +0200, Jean-Jacques Hiblot wrote:
> diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
[...]
> +/*
> + * Renesas RZ/N1 Watchdog timer.
> + * This is a 12-bit timer driver from a (62.5/16384) MHz clock. It can't even
> + * cope with 2 seconds.
> + *
> + * Copyright 2018 Renesas Electronics Europe Ltd.

s/2018/2022/ ?

> +#define RZN1_WDT_RETRIGGER			0x0
> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL		0
> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL_MASK	0xfff
> +#define RZN1_WDT_RETRIGGER_PRESCALE		BIT(12)
> +#define RZN1_WDT_RETRIGGER_ENABLE		BIT(13)
> +#define RZN1_WDT_RETRIGGER_WDSI			(0x2 << 14)

Do RZN1_WDT_RETRIGGER_RELOAD_VAL and RZN1_WDT_RETRIGGER_WDSI get 1 more tab
indent intentionally?

> +static const struct watchdog_device rzn1_wdt = {
> +	.info = &rzn1_wdt_info,
> +	.ops = &rzn1_wdt_ops,
> +	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
> +};
[...]
> +static int rzn1_wdt_probe(struct platform_device *pdev)
> +{
[...]
> +	wdt->wdt = rzn1_wdt;

Does it really need to copy the memory?  For example,

1. Use the memory in `wdt` directly and fill the `wdd`.

struct watchdog_device *wdd = &wdt->wdt;
wdd->info = &rzn1_wdt_info;
wdd->ops = &rzn1_wdt_ops;
...

2. Use drvdata instead of container_of().

Use watchdog_set_drvdata() in _probe and watchdog_get_drvdata() in the
watchdog ops to get struct rzn1_watchdog.

> +static const struct of_device_id rzn1_wdt_match[] = {
> +	{ .compatible = "renesas,rzn1-wdt" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rzn1_wdt_match);

Doesn't it need to guard by CONFIG_OF?

> +static struct platform_driver rzn1_wdt_driver = {
> +	.probe		= rzn1_wdt_probe,
> +	.driver		= {
> +		.name		= KBUILD_MODNAME,
> +		.of_match_table	= rzn1_wdt_match,

Does it makes more sense to use of_match_ptr()?

> +	},
> +};
> +
> +module_platform_driver(rzn1_wdt_driver);

To make it look like a whole thing, I prefer to remove the extra blank line
in between struct platform_driver and module_platform_driver().
