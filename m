Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD664A3316
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 02:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353697AbiA3Bmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 20:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiA3Bma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 20:42:30 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B21C061714;
        Sat, 29 Jan 2022 17:42:30 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id b186so13708604oif.1;
        Sat, 29 Jan 2022 17:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zr0+itf3l3WQkRTR+PpQ8hwMMp3+UJoNxwrHlZB+5AM=;
        b=MVhytGO/Z/+1GV3CN8v7GzGwjOcJy0EHTFkRMoPBc9rdwJHVde2xpJCFjKq6xCIpxF
         3a4sRklP5Ej7D6DFcun0uh8eahS8KMAiCjVnYTugbliyXLbxhL7AzP1TAFFudjH342Og
         HaVVkHq0kdwg2dTjQ3O7cwQwLn22lKlvL33JA3hSs3EUfd3vxH5eYUSEPPIO4snJG373
         2amhXg4WT17LtbQusIYEvxzGZbbwgo81jIR474ro3mxWRIAPiI0kK0y/O/F2AfPLYXvv
         n2UMi8cPuSUualnfu8n+ISow+QdBlXoaMC6FAVHQ1ipjOhp38pf6Fz4zR8VyvqEoJqNR
         Cl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Zr0+itf3l3WQkRTR+PpQ8hwMMp3+UJoNxwrHlZB+5AM=;
        b=uxmmun7ZEvKqoGBuPMxiuvL6B/w8FwpERiRJU6PfUu4YpH5x6UkeaAvvsRqLj5NuuB
         b34YvDwjRgsgLZ1SymmNCZKLkivXOH4F1uE0B2i8Ear9qXHKtKUhxMFFbciV6jv470WV
         JBzG/CnAVY8nR9yldFFdPWO+NE5MkvOtK7YJRL0TPbjiSsX4npJWZ/QkHOyVNrxLE6RH
         +oCNIN2ETH2XE86xtlo8WCoVkE60kentxI7ASh3Zzn2i3lrTdDKtPFVwVWR+d9xYiyFP
         eWpGNzxFF1MuYUMuVE+ZdKjlY4zz4f6t80ppOnrwPKHPk83n+JnHzS6O6pkwRG86ijfI
         K4yg==
X-Gm-Message-State: AOAM530SdLBO06PkNybJdP9qWUtX5eoUbnKaVEzjhBOqavAxh63DXIHx
        tX+I8cPtkKwKrK4Q58QxFJY=
X-Google-Smtp-Source: ABdhPJyqCaxHevYNt962g3u/kf4yguim55rtn7KFHSVEx3B8AmpEw4NN8zuWTreigrAFMlpRdauYAA==
X-Received: by 2002:aca:34c4:: with SMTP id b187mr5223999oia.137.1643506949278;
        Sat, 29 Jan 2022 17:42:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u25sm14151371oth.56.2022.01.29.17.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 17:42:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 29 Jan 2022 17:42:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, wim@linux-watchdog.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        festevam@gmail.com
Subject: Re: [PATCH v3] watchdog: imx2_wdg: Alow ping on suspend
Message-ID: <20220130014226.GA1805103@roeck-us.net>
References: <20220127104739.312592-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127104739.312592-1-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:47:39PM +1000, Alistair Francis wrote:
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
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v3:
>  - Fixup typos in commit message
> v2:
>  - Remove custom property
> 
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
