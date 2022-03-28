Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8108B4E8F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiC1IDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239063AbiC1IDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:03:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1347452E6E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:01:26 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nYkJN-0001tN-JZ; Mon, 28 Mar 2022 10:01:13 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nYkJL-00026y-Or; Mon, 28 Mar 2022 10:01:11 +0200
Date:   Mon, 28 Mar 2022 10:01:11 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     shawnguo@kernel.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, festevam@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH v4] watchdog: imx2_wdg: Allow ping on suspend
Message-ID: <20220328080111.GD12181@pengutronix.de>
References: <20220323115752.360409-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323115752.360409-1-alistair@alistair23.me>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:59:25 up 107 days, 16:45, 84 users,  load average: 0.18, 0.66,
 0.69
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 23, 2022 at 09:57:52PM +1000, Alistair Francis wrote:
> The i.MX watchdog cannot be disabled by software once it has been
> enabled. This means that it can't be stopped before suspend.
> 
> For systems that enter low power mode this is fine, as the watchdog will
> be automatically stopped by hardware in low power mode. Not all i.MX
> platforms support low power mode in the mainline kernel. For example the
> i.MX7D does not enter low power mode and so will be rebooted 2 minutes
> after entering sleep states.
> 
> This patch introduces a device tree property "fsl,ping-during-suspend"
> that can be used to enable ping on suspend support for these systems.

This doesn't match the code anymore.

Sascha

> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/imx2_wdt.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 51bfb796898b..d0c5d47ddede 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -66,6 +66,7 @@ struct imx2_wdt_device {
>  	struct watchdog_device wdog;
>  	bool ext_reset;
>  	bool clk_is_on;
> +	bool no_ping;
>  };
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -312,12 +313,18 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>  
>  	wdev->ext_reset = of_property_read_bool(dev->of_node,
>  						"fsl,ext-reset-output");
> +	/*
> +	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
> +	 * during suspend.
> +	 */
> +	wdev->no_ping = !of_device_is_compatible(dev->of_node, "fsl,imx7d-wdt");
>  	platform_set_drvdata(pdev, wdog);
>  	watchdog_set_drvdata(wdog, wdev);
>  	watchdog_set_nowayout(wdog, nowayout);
>  	watchdog_set_restart_priority(wdog, 128);
>  	watchdog_init_timeout(wdog, timeout, dev);
> -	watchdog_stop_ping_on_suspend(wdog);
> +	if (wdev->no_ping)
> +		watchdog_stop_ping_on_suspend(wdog);
>  
>  	if (imx2_wdt_is_running(wdev)) {
>  		imx2_wdt_set_timeout(wdog, wdog->timeout);
> @@ -366,9 +373,11 @@ static int __maybe_unused imx2_wdt_suspend(struct device *dev)
>  		imx2_wdt_ping(wdog);
>  	}
>  
> -	clk_disable_unprepare(wdev->clk);
> +	if (wdev->no_ping) {
> +		clk_disable_unprepare(wdev->clk);
>  
> -	wdev->clk_is_on = false;
> +		wdev->clk_is_on = false;
> +	}
>  
>  	return 0;
>  }
> @@ -380,11 +389,14 @@ static int __maybe_unused imx2_wdt_resume(struct device *dev)
>  	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
>  	int ret;
>  
> -	ret = clk_prepare_enable(wdev->clk);
> -	if (ret)
> -		return ret;
> +	if (wdev->no_ping) {
> +		ret = clk_prepare_enable(wdev->clk);
>  
> -	wdev->clk_is_on = true;
> +		if (ret)
> +			return ret;
> +
> +		wdev->clk_is_on = true;
> +	}
>  
>  	if (watchdog_active(wdog) && !imx2_wdt_is_running(wdev)) {
>  		/*
> @@ -407,6 +419,7 @@ static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
>  
>  static const struct of_device_id imx2_wdt_dt_ids[] = {
>  	{ .compatible = "fsl,imx21-wdt", },
> +	{ .compatible = "fsl,imx7d-wdt", },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);
> -- 
> 2.35.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
