Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29A849848C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243653AbiAXQVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiAXQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:21:10 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072C1C06173B;
        Mon, 24 Jan 2022 08:21:10 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso7026652ott.7;
        Mon, 24 Jan 2022 08:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=VkaWEgeBr7PBlFMoeYQACPVtS0amdxCrpBfpWTSJvtc=;
        b=CEvQfWTv7zilJY0HEYVDjFnq9cQM3Z63aaJp+AyQRsFUwx5hgRlDGF5/DCsIakuD39
         HJzd2mBfY3VDM3MUhWXVCKifGlBRavPlOXlnZbCH61ghV3ygwbndLiss4CKsz5oY/y3G
         PIo9ZtLiCsbKPE/MAWw1Mm7UlYm39AkOOK7kARofBninUwc1lBayi6gOrr4NvuPb8Dme
         KfU623fs0Xmcjt2IZc49Bg0UPuXctpu3n2HEo88j0M8kLZ0KfXaT2124OpvJwOTQI4ya
         9pMSLUdp2xdSBSBpu/vwccBhHI5Ik1sND/+jRzC8gj0RD0WHX4tDMlozmvr5LlUzukp0
         IUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=VkaWEgeBr7PBlFMoeYQACPVtS0amdxCrpBfpWTSJvtc=;
        b=luiy0/sGUkAT2awNWbZj7zPY4Pt0WhQxKtjKxKjrjFbk9S5eS4CQqC8tFygAQZRrde
         dGpWb5IEOkNjBsJ/vF6q6VdGmF+/swYmXtPLj4XzlnPhKPAwa8mf1JkYFj4gddVZtm2R
         Hpe4+mgXA4U2cIkMMGeLXGRMVOhP9S5/8YKh3EbpQbG1GmRnOmsQep0GpX6FMCkmWS0V
         QuYpHl0ZEQlOmGoPoa6WJAqEWGqdz7TkPMoB2XKPx9d06xr/z13VqTcM2sbmOwCyZPFg
         BbyM1ZJtGPU/3NtASsVk9swiLbYXATSIzXfpDhYPFMv4NZ/gnv+avXwrgm3r28OC/x/+
         DVEg==
X-Gm-Message-State: AOAM533qWhmOiGg3KROQluzusBnKqYTWSgu7Qfwi+2dsfymZ3Mrreoqs
        PfoHdC1Q68IFeQYI2MN7xIQ=
X-Google-Smtp-Source: ABdhPJxRxIAV2UZM9a0c895tvcREiygYhLKMHF21vycNg1YwssSleOL83EVJHu3Ynpy0QsZ03N3qVw==
X-Received: by 2002:a05:6830:1db7:: with SMTP id z23mr12207612oti.348.1643041269346;
        Mon, 24 Jan 2022 08:21:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o7sm5360996otj.5.2022.01.24.08.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 08:21:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1a8ee480-b066-8da9-cd63-079e07b7d88a@roeck-us.net>
Date:   Mon, 24 Jan 2022 08:21:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Alistair Francis <alistair@alistair23.me>,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org
Cc:     devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        robh+dt@kernel.org, kernel@pengutronix.de
References: <20220124120027.106754-1-alistair@alistair23.me>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] watchdog: imx2_wdg: Alow ping on suspend
In-Reply-To: <20220124120027.106754-1-alistair@alistair23.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 04:00, Alistair Francis wrote:
> The i.MX watchdog cannot be disabled by softwrae once it has been

s/softwrae/software/

> enabled. This means that it can't be stopped before suspend.
> 
> For systems that enter low power mode this is fine, as the watchdog will
> be automatically stopped by hardwrae in low power mode. Not all i.MX

s/hardwrae/hardware/

> platforms support low power mode in the mainline kernel. For example the
> i.MX7D does not enter low power mode and so will be rebooted 2 minutes
> after entering freeze or mem sleep states.

I don't think "mem" adds any value here. Just make it sleep states.

> 
> This patch introduces a device tree property "fsl,ping-during-suspend"
> that can be used to enable ping on suspend support for these systems.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---

Change log goes here.

>   drivers/watchdog/imx2_wdt.c | 27 ++++++++++++++++++++-------
>   1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 51bfb796898b..d0c5d47ddede 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -66,6 +66,7 @@ struct imx2_wdt_device {
>   	struct watchdog_device wdog;   
>   	bool ext_reset;
>   	bool clk_is_on;

I don't see the purpose of this variable. Unless I am missing something is is set
but never used.

> +	bool no_ping;
>   };
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -312,12 +313,18 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   
>   	wdev->ext_reset = of_property_read_bool(dev->of_node,
>   						"fsl,ext-reset-output");
> +	/*
> +	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
> +	 * during suspend.
> +	 */
> +	wdev->no_ping = !of_device_is_compatible(dev->of_node, "fsl,imx7d-wdt");

This is ok as long as there is only a single chip requiring this change.
If there are more, the 'data' field in struct of_device_id should be used
instead.

>   	platform_set_drvdata(pdev, wdog);
>   	watchdog_set_drvdata(wdog, wdev);
>   	watchdog_set_nowayout(wdog, nowayout);
>   	watchdog_set_restart_priority(wdog, 128);
>   	watchdog_init_timeout(wdog, timeout, dev);
> -	watchdog_stop_ping_on_suspend(wdog);
> +	if (wdev->no_ping)
> +		watchdog_stop_ping_on_suspend(wdog);
>   
>   	if (imx2_wdt_is_running(wdev)) {
>   		imx2_wdt_set_timeout(wdog, wdog->timeout);
> @@ -366,9 +373,11 @@ static int __maybe_unused imx2_wdt_suspend(struct device *dev)
>   		imx2_wdt_ping(wdog);
>   	}
>   
> -	clk_disable_unprepare(wdev->clk);
> +	if (wdev->no_ping) {
> +		clk_disable_unprepare(wdev->clk);
>   
> -	wdev->clk_is_on = false;
> +		wdev->clk_is_on = false;
> +	}
>   
>   	return 0;
>   }
> @@ -380,11 +389,14 @@ static int __maybe_unused imx2_wdt_resume(struct device *dev)
>   	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
>   	int ret;
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
>   	if (watchdog_active(wdog) && !imx2_wdt_is_running(wdev)) {
>   		/*
> @@ -407,6 +419,7 @@ static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
>   
>   static const struct of_device_id imx2_wdt_dt_ids[] = {
>   	{ .compatible = "fsl,imx21-wdt", },
> +	{ .compatible = "fsl,imx7d-wdt", },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);

