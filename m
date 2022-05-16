Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADAB5292DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348125AbiEPV2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiEPV2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:28:40 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C572E3ED20;
        Mon, 16 May 2022 14:28:39 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w130so20288625oig.0;
        Mon, 16 May 2022 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=32Vs/LktarNB8NEtIL9LhiUa0qUkh/sqQBbAeb81eFU=;
        b=Of9ddJJaYzrTIkpGTr6Q+p9V0T2tQeh1XbACZmQ47L5XcLCYwe0EmHd8zzLjTSYnNK
         OTFLzRIPcbsiFLWbhqVGJET6/2RacoJ0JcGshT0UrJ9TXRJWOMjdqXcKYFxlDOCdHvMC
         BvawKgB4xoUAmY2hVr57xXKNPhNymSeieC+PPdBQOVDpcTjohy1tMR+67kM7Y101MJVz
         HYfVFyD7y2Q8fUROlKCPvDZl+RXYXvEfG+gdDMTnl6i6WZl+6Gq1LrTnSsp+QN6hXW9h
         FteKimp9m7F9Bkt3Np2DckdEzdx9e33AxXrxz4jcbVU5Ew0MsHz6ZHtlP0s1SSHDdf7S
         5Dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=32Vs/LktarNB8NEtIL9LhiUa0qUkh/sqQBbAeb81eFU=;
        b=XuYpbjob+66j+f58xAi9bs2UQmZVARxa8kNBhGfyPICusgUL+TdpokJM5mS1wW5MNV
         Z4Kmot5b00KResC68VGzaWt29tN9zam0dOkUVSmYU35Fi8P+alcvjMlRNbsRyt9HJwYo
         GV3GZjjcUh3Ul19AVZR0GYUn+JRg/JtYPOGp7BCx3G88EDktCkiB0d4cIoekcu96laD2
         yUi4bWYFwBOik//aHFL7/fFkOgdrGP1qa6BP4jQHYua5s94MU+yjFRZguNVLphuYKJAf
         3Z22v4Qt9ZFkJxydEO289Q+W1X5xJIbA6iAuqOrzDnWIOjG34hcVmvSlOakChC22EB0P
         J7xg==
X-Gm-Message-State: AOAM531eccCD7r2srEUJMZIaFhG1FTpREdz/AD0Zt6/XOEZxox+3+Hhg
        mv6cVloPx3rfCfCWGcEGYhE=
X-Google-Smtp-Source: ABdhPJwz5GfUNAs8qsj6y/LqPyAEzw6N88FvrN25rjGlCvMNcjpwLl6NYhfcY/A7zSrYEBH7JUfQYA==
X-Received: by 2002:a05:6808:1202:b0:322:dc37:2c3b with SMTP id a2-20020a056808120200b00322dc372c3bmr15003269oil.298.1652736519128;
        Mon, 16 May 2022 14:28:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r25-20020a4a7019000000b0035eb4e5a6c8sm4656637ooc.30.2022.05.16.14.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 14:28:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 16 May 2022 14:28:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, joel@jms.id.au, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v8 3/8] watchdog: hpe-wdt: Introduce HPE GXP Watchdog
Message-ID: <20220516212836.GA4080706@roeck-us.net>
References: <20220516163347.44890-1-nick.hawkins@hpe.com>
 <20220516163347.44890-3-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516163347.44890-3-nick.hawkins@hpe.com>
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

On Mon, May 16, 2022 at 11:33:41AM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add support for the HPE GXP Watchdog. The GXP asic contains a full
> complement of timers one of which is the watchdog timer. The watchdog
> timer is 16 bit and has 10ms resolution. The watchdog is created as a
> child device of timer since the same register range is used.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> v8:
> * Fix comment format
> v7:
> * Change commit description to replace Adding with Add and compliment
>   with complement
> * Removed unused include files of_address.h and of_platform.h
> * Fixed the max timeout on watchdog to be 655350
> * Changed time variable computations in gxp_wdt_set_timeout to be clear
> * Decreased reboot delay to 10ms from 100ms
> * Added comment to explain why it is necessary to pass the base address
>   over a private interface from the timer driver.
> v6:
> * No code change.
> * Fixed commit subject line to match the ones in log.
> * Adjusted commit message to be closer to 75 chars per line.
> v5:
> * Fixed version log
> * Added details to Kconfig for module support.
> * Adjusted commit messaged
> v4:
> * Made watchdog a child of timer as they share the same register region
>   per change request on dtsi.
> * Removed extra parenthesis
> * Fixed u8 u32 u64 usage
> * Fixed alignment issue
> * Reconfigured conditional statement for interrupt setup
> * Removed unused gxp_wdt_remove function
> v3:
> * Put into proper patchset format
> v2:
> * No change
> ---
>  drivers/watchdog/Kconfig   |  11 +++
>  drivers/watchdog/Makefile  |   1 +
>  drivers/watchdog/gxp-wdt.c | 174 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+)
>  create mode 100644 drivers/watchdog/gxp-wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c4e82a8d863f..a591cc6aa152 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1820,6 +1820,17 @@ config RALINK_WDT
>  	help
>  	  Hardware driver for the Ralink SoC Watchdog Timer.
>  
> +config GXP_WATCHDOG
> +	tristate "HPE GXP watchdog support"
> +	depends on ARCH_HPE_GXP
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer
> +	  in HPE GXP SoCs.
> +
> +	  To compile this driver as a module, choose M here.
> +	  The module will be called gxp-wdt.
> +
>  config MT7621_WDT
>  	tristate "Mediatek SoC watchdog"
>  	select WATCHDOG_CORE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f7da867e8782..e2acf3a0d0fc 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_RTD119X_WATCHDOG) += rtd119x_wdt.o
>  obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
>  obj-$(CONFIG_PM8916_WATCHDOG) += pm8916_wdt.o
>  obj-$(CONFIG_ARM_SMC_WATCHDOG) += arm_smc_wdt.o
> +obj-$(CONFIG_GXP_WATCHDOG) += gxp-wdt.o
>  obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
>  obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
>  obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o
> diff --git a/drivers/watchdog/gxp-wdt.c b/drivers/watchdog/gxp-wdt.c
> new file mode 100644
> index 000000000000..b0b2d7a6fdde
> --- /dev/null
> +++ b/drivers/watchdog/gxp-wdt.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +
> +#define MASK_WDGCS_ENABLE	0x01
> +#define MASK_WDGCS_RELOAD	0x04
> +#define MASK_WDGCS_NMIEN	0x08
> +#define MASK_WDGCS_WARN		0x80
> +
> +#define WDT_MAX_TIMEOUT_MS	655350
> +#define WDT_DEFAULT_TIMEOUT	30
> +#define SECS_TO_WDOG_TICKS(x) ((x) * 100)
> +#define WDOG_TICKS_TO_SECS(x) ((x) / 100)
> +
> +#define GXP_WDT_CNT_OFS		0x10
> +#define GXP_WDT_CTRL_OFS	0x16
> +
> +struct gxp_wdt {
> +	void __iomem *base;
> +	struct watchdog_device wdd;
> +};
> +
> +static void gxp_wdt_enable_reload(struct gxp_wdt *drvdata)
> +{
> +	u8 val;
> +
> +	val = readb(drvdata->base + GXP_WDT_CTRL_OFS);
> +	val |= (MASK_WDGCS_ENABLE | MASK_WDGCS_RELOAD);
> +	writeb(val, drvdata->base + GXP_WDT_CTRL_OFS);
> +}
> +
> +static int gxp_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +
> +	writew(SECS_TO_WDOG_TICKS(wdd->timeout), drvdata->base + GXP_WDT_CNT_OFS);
> +	gxp_wdt_enable_reload(drvdata);
> +	return 0;
> +}
> +
> +static int gxp_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +	u8 val;
> +
> +	val = readb_relaxed(drvdata->base + GXP_WDT_CTRL_OFS);
> +	val &= ~MASK_WDGCS_ENABLE;
> +	writeb(val, drvdata->base + GXP_WDT_CTRL_OFS);
> +	return 0;
> +}
> +
> +static int gxp_wdt_set_timeout(struct watchdog_device *wdd,
> +			       unsigned int timeout)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +	u32 actual;
> +
> +	wdd->timeout = timeout;
> +	actual = min(timeout * 100, wdd->max_hw_heartbeat_ms / 10);
> +	writew(actual, drvdata->base + GXP_WDT_CNT_OFS);
> +
> +	return 0;
> +}
> +
> +static unsigned int gxp_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +	u32 val = readw(drvdata->base + GXP_WDT_CNT_OFS);
> +
> +	return WDOG_TICKS_TO_SECS(val);
> +}
> +
> +static int gxp_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +
> +	gxp_wdt_enable_reload(drvdata);
> +	return 0;
> +}
> +
> +static int gxp_restart(struct watchdog_device *wdd, unsigned long action,
> +		       void *data)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +
> +	writew(1, drvdata->base + GXP_WDT_CNT_OFS);
> +	gxp_wdt_enable_reload(drvdata);
> +	mdelay(100);
> +	return 0;
> +}
> +
> +static const struct watchdog_ops gxp_wdt_ops = {
> +	.owner =	THIS_MODULE,
> +	.start =	gxp_wdt_start,
> +	.stop =		gxp_wdt_stop,
> +	.ping =		gxp_wdt_ping,
> +	.set_timeout =	gxp_wdt_set_timeout,
> +	.get_timeleft =	gxp_wdt_get_timeleft,
> +	.restart =	gxp_restart,
> +};
> +
> +static const struct watchdog_info gxp_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
> +	.identity = "HPE GXP Watchdog timer",
> +};
> +
> +static int gxp_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct gxp_wdt *drvdata;
> +	int err;
> +	u8 val;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(struct gxp_wdt), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	/*
> +	 * The register area where the timer and watchdog reside is disarranged.
> +	 * Hence mapping individual register blocks for the timer and watchdog
> +	 * is not recommended as they would have access to each others
> +	 * registers. Based on feedback the watchdog is no longer part of the
> +	 * device tree file and the timer driver now creates the watchdog as a
> +	 * child device. During the watchdogs creation, the timer driver passes
> +	 * the base address to the watchdog over the private interface.
> +	 */
> +
> +	drvdata->base = (void __iomem *)dev->platform_data;
> +
> +	drvdata->wdd.info = &gxp_wdt_info;
> +	drvdata->wdd.ops = &gxp_wdt_ops;
> +	drvdata->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
> +	drvdata->wdd.parent = dev;
> +	drvdata->wdd.timeout = WDT_DEFAULT_TIMEOUT;
> +
> +	watchdog_set_drvdata(&drvdata->wdd, drvdata);
> +	watchdog_set_nowayout(&drvdata->wdd, WATCHDOG_NOWAYOUT);
> +
> +	val = readb(drvdata->base + GXP_WDT_CTRL_OFS);
> +
> +	if (val & MASK_WDGCS_ENABLE)
> +		set_bit(WDOG_HW_RUNNING, &drvdata->wdd.status);
> +
> +	watchdog_set_restart_priority(&drvdata->wdd, 128);
> +
> +	watchdog_stop_on_reboot(&drvdata->wdd);
> +	err = devm_watchdog_register_device(dev, &drvdata->wdd);
> +	if (err) {
> +		dev_err(dev, "Failed to register watchdog device");
> +		return err;
> +	}
> +
> +	dev_info(dev, "HPE GXP watchdog timer");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver gxp_wdt_driver = {
> +	.probe = gxp_wdt_probe,
> +	.driver = {
> +		.name =	"gxp-wdt",
> +	},
> +};
> +module_platform_driver(gxp_wdt_driver);
> +
> +MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
> +MODULE_AUTHOR("Jean-Marie Verdun <verdun@hpe.com>");
> +MODULE_DESCRIPTION("Driver for GXP watchdog timer");
> -- 
> 2.17.1
> 
