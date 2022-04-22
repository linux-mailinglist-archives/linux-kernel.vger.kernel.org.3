Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE99850BFE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiDVSq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiDVSqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:46:24 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D02E12758B;
        Fri, 22 Apr 2022 11:42:27 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id a10so9955294oif.9;
        Fri, 22 Apr 2022 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hUAGJI7MZIzFGBlWW57hloz6jpEOZG9rptUBKkWEgMk=;
        b=TVybQ9BGLyIfiMbQ8yLpEWT3buhFfnziUIlE3M+S7kswwHnSHyCXOYVWdTYkMoa2Hp
         TjLBIFbXJ1L3liznezkxkj4G/lXpyCLk0M1OtcYMhd5FnA/1d4yn2/fBOpfrKsy5GGso
         pjsxDdCIweB59jQDBnAJRPDmEfjt83ZQ72c182ocNXUK9jFOukuzxg1evZl5xBqcIBGJ
         b2D9npXg69VFXjCXW1xQTsiAxIFqoH7PgLqGKIkWqv9whdskSrioK/1hgKwu8Ep36xZl
         p5rUU6Zy44txzPKM2APsYISxbKYIwC8DmJtnav/QxRUAvlW/vmScJRtBYiESVTgBal0z
         +/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=hUAGJI7MZIzFGBlWW57hloz6jpEOZG9rptUBKkWEgMk=;
        b=0pa+WEyotZo02iCoQ5449qaljtmMwLntshQ6GzSg0FwTCSXhYjEOr0MdzU8++qeEPQ
         aCGMpubYaLOG1qQJ5MKCXIfya+Qr16qfRXmKXNJWo5slqAIbF0cM0TvhLvbocIeDwcAL
         UixHjCYliJfPott9F8V94OIxLQXykD4y1oM7I1itbMJEl/6eVWWBL++eiTY+DfqEiYeY
         RmwK6obeBPUSkP1tsyHvby/ziFWmkaf0aLVM+zTuWbPZYtAZl343we6sfvrnjOnvbpHR
         3nSeekWVmS8nT3u49EmIwUC50t7b8+jOZLKzcId+Y4+71z0nIACFZJqZ14VY5MrT7sow
         kzBA==
X-Gm-Message-State: AOAM531HodrqvWRNUpKK7/bMhP1L4/3RdWD8pdkKyVzw5yi7MX5tRNrj
        FdrX8K7L4sDKK8XthpE3fIs=
X-Google-Smtp-Source: ABdhPJxXTOlR3CyOaSls0W1PFuow9H3jq2A9kiQEbWk0nPfmXNkGykl0l6n5RNsWtUtRazUUrdDGNA==
X-Received: by 2002:aca:5c44:0:b0:322:ed86:2c08 with SMTP id q65-20020aca5c44000000b00322ed862c08mr2831409oib.17.1650652459466;
        Fri, 22 Apr 2022 11:34:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i16-20020a056870d41000b000e1a3a897basm953335oag.26.2022.04.22.11.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:34:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 22 Apr 2022 11:34:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH 3/7] watchdog: npcm: Enable clock if provided
Message-ID: <20220422183417.GB2637654@roeck-us.net>
References: <20220422183012.444674-1-j.neuschaefer@gmx.net>
 <20220422183012.444674-4-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220422183012.444674-4-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 08:30:08PM +0200, Jonathan Neuschäfer wrote:
> On the Nuvoton WPCM450 SoC, with its upcoming clock driver, peripheral
> clocks are individually gated and ungated. Therefore, the watchdog
> driver must be able to ungate the watchdog clock.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  drivers/watchdog/npcm_wdt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index 28a24caa2627c..6d27f0e16188e 100644
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c
> @@ -3,6 +3,7 @@
>  // Copyright (c) 2018 IBM Corp.
> 
>  #include <linux/bitops.h>
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -180,6 +181,7 @@ static int npcm_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct npcm_wdt *wdt;
> +	struct clk *clk;
>  	int irq;
>  	int ret;
> 
> @@ -191,6 +193,13 @@ static int npcm_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(wdt->reg))
>  		return PTR_ERR(wdt->reg);
> 
> +	clk = devm_clk_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	if (clk)
> +		clk_prepare_enable(clk);
> +

This needs a matching clk_disable_unprepare().

Guenter
