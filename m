Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB83446585B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 22:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344157AbhLAVaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhLAVaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:30:00 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65654C061574;
        Wed,  1 Dec 2021 13:26:38 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso37101557ots.6;
        Wed, 01 Dec 2021 13:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k4/I5ZxtyxyEgfQA+ESGmCgKBQsFs6qJF72l96RKoA4=;
        b=kLCG6otqEVhaUDNA3amJb2CMgftRPwdi4LZjQ/OayeZcxbk24t9MFM7u/W8F1bw76a
         MO2GB2TFG+TpkokO/JkmzyKf/RRgIYwSOOpURQLpctnmK7++F4jubVUgVCf5PWu5mTYE
         uDJqGaKLyZua86fR5UutdKUcs/VYcPxZlLflKD//OZHWokuWqCPCJWkyY6br6Kf7O2ZO
         g2pr1BkeUbU8tv/xrcVXQDtIE6A2gU/idADJZQEotbmzG82TeyWB5NKGSFheuCzxK5kZ
         M+cBjQe7rDv9yhYsE79qYgo1lrqYZ+O3Zne+FmcebsGBsqzmIQIStVjsO+/s8zakHYqB
         Xurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k4/I5ZxtyxyEgfQA+ESGmCgKBQsFs6qJF72l96RKoA4=;
        b=MViA0wUoz+iZHWzt7P+jX39a6LInxDop8kkqzQS3BIrTy6mEI8wWD09YsuXnEqTggs
         yAnsdfOasoDHx8IcRT52agUd7Rl9a9/RjhJgj8y0Var2tmEjHFrbchf0D5dF5PK+/8up
         csYdQRkGjTgmvV+GF2kBmjHDZRYDEOurf5ssQz4Muh2XT+ZNm3ykTjiPOtXMxRYMWVeW
         y8hHf6KO45bzS6Loy8T4usnDMtlBArKje/VN+H3WESKS+fqbaVl1XnBRfMqnrg3qT0v9
         2NnpYUbftaUyQJ8dVoFawWm0nD1CpQxDpwxJNpE6V6BV0edVYQvrl1WOPBa7VML8ACJX
         JOlA==
X-Gm-Message-State: AOAM532ZuR9UI75EChxq0y5pwcekkMtYl7bJ6kYBaDqGTayIWtSchSA0
        zqqv7TgvEeJdHDE7wJ1s8GJJdBnHk5Q=
X-Google-Smtp-Source: ABdhPJyYRvrtRBtmrxzsseeP+6fU5/sYP0zqPGa07azFC5J/pEfSc7m0nlZ2sR9zmEB88pyfWUn5Cw==
X-Received: by 2002:a9d:20a1:: with SMTP id x30mr7945277ota.44.1638393997791;
        Wed, 01 Dec 2021 13:26:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n23sm394235oic.26.2021.12.01.13.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:26:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 2/4] watchdog: da9062: reset board on watchdog timeout
To:     Andrej Picej <andrej.picej@norik.com>,
        support.opensource@diasemi.com, linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
References: <20211201081512.3580837-1-andrej.picej@norik.com>
 <20211201081512.3580837-2-andrej.picej@norik.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fa9eb129-a152-4f22-9bf4-07bf27ec441f@roeck-us.net>
Date:   Wed, 1 Dec 2021 13:26:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201081512.3580837-2-andrej.picej@norik.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 12:15 AM, Andrej Picej wrote:
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
> Changes in v3:
>   - no changes
> 
> Changes in v2:
>   - don't force the "reset" for all da9062-watchdog users, instead add DT
>     binding where the behavior can be selected
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

Please use standard multi-line comments. This is not the networking
subsystem.

Also, if you think this code should be here and not in the probe function,
as suggested by Adam, please provide a rationale.

Thanks,
Guenter

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

