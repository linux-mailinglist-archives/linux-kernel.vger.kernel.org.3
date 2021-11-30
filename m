Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A74635DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbhK3N5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:57:25 -0500
Received: from cpanel.siel.si ([46.19.9.99]:41142 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhK3N5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:Subject:Sender:Reply-To:To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DAeiq0+hu9vqz4X68FmD/LBiUhTE77vNZ1s2PDY28oo=; b=oitpx8F9Ic9th9buZC/OMkLWHS
        GIPK4AXZrhfTDMsg02iXKSaKz7iY3aG7wlSrnye4Ba75DAbbcppFLbU0XAMSrepR+b2wGfvs9MAsW
        yy+tiKG+Zbet3ubZhB/odUsQXyTkNx4myIUm930RbJxQYlNEy9FrmOmZWTxPRDrZnGgc0Vp9RTVq0
        AQHoLur/WWha71XdZgniiL5qfMaH+JAfDNqDK/5LIWJyQw5cQ6U2ukElqoBHUikjuSEyjJZvxLoE/
        5XN25wJZaFHLGQAXR7LmkCMZUh6vP0SsiLPc4pZB9oWIXngUnh0qqUwc9jAkXjFPBPcymk3cWiZHj
        i4XMc45A==;
Received: from [89.212.21.243] (port=49964 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1ms3a2-003And-Bh; Tue, 30 Nov 2021 14:53:58 +0100
Subject: Re: [PATCH v2 2/4] watchdog: da9062: reset board on watchdog timeout
Cc:     support.opensource@diasemi.com, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
References: <20211130134242.3516619-1-andrej.picej@norik.com>
 <20211130134242.3516619-2-andrej.picej@norik.com>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <64c5fb81-8cfd-e5a6-7d13-e17e88e4964d@norik.com>
Date:   Tue, 30 Nov 2021 14:54:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211130134242.3516619-2-andrej.picej@norik.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30. 11. 21 14:42, Andrej Picej wrote:
> Implement a method to change watchdog timeout configuration based on DT
> binding ("dlg,wdt-sd"). There is a possibility to change the bahaviour
> of watchdog reset. Setting WATCHDOG_SD bit enables SHUTDOWN mode, and
> clearing it enables POWERDOWN mode on watchdog timeout.
> 
> If no DT binding is specified the WATCHDOG_SD bit stays in default
> configuration, not breaking behaviour of devices which might depend on
> default fuse configuration.
> 
> Note: This patch requires that the config register CONFIG_I is
> configured as writable in the da9062 multi function device.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>   drivers/watchdog/da9062_wdt.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index f02cbd530538..e342e9e50cb1 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -85,8 +85,33 @@ static int da9062_wdt_start(struct watchdog_device *wdd)
>   {
>   	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
>   	unsigned int selector;
> +	unsigned int mask;
> +	u32 val;
>   	int ret;
>   
> +	/* Configure what happens on watchdog timeout. Can be specified with
> +	 * "dlg,wdt-sd" dt-binding (0 -> POWERDOWN, 1 -> SHUTDOWN).
> +	 * If "dlg,wdt-sd" dt-binding is NOT set use the default.
> +	 */
> +	ret = device_property_read_u32(wdd->parent, "dlg,wdt-sd", &val);
> +	if (!ret) {
> +		if (val)
> +			/* Use da9062's SHUTDOWN mode */
> +			mask = DA9062AA_WATCHDOG_SD_MASK;
> +		else
> +			/* Use da9062's POWERDOWN mode. */
> +			mask = 0x0;
> +
> +		ret = regmap_update_bits(wdt->hw->regmap,
> +						DA9062AA_CONFIG_I,
> +						DA9062AA_WATCHDOG_SD_MASK,
> +						mask);
> +
> +		if (ret)
> +			dev_err(wdt->hw->dev, "failed to set wdt reset mode: %d\n",
> +				ret);
> +	}
> +
>   	selector = da9062_wdt_timeout_to_sel(wdt->wdtdev.timeout);
>   	ret = da9062_wdt_update_timeout_register(wdt, selector);
>   	if (ret)
> 

Changes in v2:
- don't force the "reset" for all da9062-watchdog users, instead add DT 
binding where the behavior can be selected
