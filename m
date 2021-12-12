Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE7471BEA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 18:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhLLRhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 12:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhLLRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 12:37:34 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281CAC061714;
        Sun, 12 Dec 2021 09:37:34 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id e17-20020a4a8291000000b002c5ee0645e7so3683186oog.2;
        Sun, 12 Dec 2021 09:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x3STyh9wrfy9GMEn+OwlQkK5L6ldjXxwL1dbZKdBiTs=;
        b=n/k4zrf/bm4298JkI9uzGG3tx3vzZ8oNmRp/NTR+bImJ7r02BoRfyq4TZHmJX1qAyt
         c6dIc3FZ8jQgTAZX8lKG36pFOQO5F2ddKX2M1zWzRdUMOHKtdlQI7Fp5EGLGlHA6Ly1F
         jBcoWY8WDYexGGEnLfS+KDZSu/LMl1+DN4fOQFveCZBLnihYTU8BEU0J475m7FpBH5Mi
         HEMad1fZv9Z0nMg4vFFtdFsELnxEfXvrSr5RhkcjHK0zX9g5ao2GOzppObTUOzw/7JLt
         uPgOznAo/+cvGsxyGwCuVfRLKUCN+3YF/ozRvBXXF0g+Fy/tucXVwhbX4T7FjtDiV/iC
         ZDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x3STyh9wrfy9GMEn+OwlQkK5L6ldjXxwL1dbZKdBiTs=;
        b=bbUGlSjg3QnULyl0N/AHuW7oRqcGyrsPGUVeMCkREd5x6Ujh5ugRW/gYCrq1cGA6LU
         WzYy84gOHcFelOMZXG4XaiEblIQLibRM631s9WaR73JgKASyKNGgdqQf94tYhiD6UlYM
         4qNO3/DMYljpSFIWFasdc2gSom6+aLkUrsOnj1aEDn5M1zPxQe9IG1esBW5yWGIXPsqQ
         x9OZGNRcznmcZjkxBtn4BqL+qL0LJ58VM/i9Rj/c85ggylVpw7n4q/OdCdohG2+pO1WB
         Liy+lH2EmEZZKlP8uOWoliOxM5z6oiqYJa61hpYFXysfUT05IaZMVvTdgeycZlM/hRh7
         ZKAA==
X-Gm-Message-State: AOAM533AhtnAoDwZNWWM3dB6NYEUdm4ZTdQtfzKE3ZUiwxKflENWd9Zh
        r3XI7r9NgqOUFXFq3ih2GuQq0QPa438=
X-Google-Smtp-Source: ABdhPJzFb5azKRc0nIdKAFEU45euIqe4ojeF9bogkOHliSPflkks09JdlRGdcczSCs038kXv6mKnPQ==
X-Received: by 2002:a4a:ea84:: with SMTP id r4mr16463021ooh.13.1639330653096;
        Sun, 12 Dec 2021 09:37:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n23sm2142912oig.4.2021.12.12.09.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 09:37:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] watchdog: s3c2410: Fix getting the optional clock
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211212170247.30646-1-semen.protsenko@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5d21438c-b122-41ce-c6be-771c63b0258a@roeck-us.net>
Date:   Sun, 12 Dec 2021 09:37:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211212170247.30646-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/21 9:02 AM, Sam Protsenko wrote:
> "watchdog_src" clock is optional and may not be present for some SoCs
> supported by this driver. Nevertheless, in case the clock is provided
> but some error happens during its getting, that error should be handled
> properly. Use devm_clk_get_optional() API for that. Also report possible
> errors using dev_err_probe() to handle properly -EPROBE_DEFER error (if
> clock provider is not ready by the time WDT probe function is executed).
> 
> Fixes: a4f3dc8d5fbc ("watchdog: s3c2410: Support separate source clock")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/s3c2410_wdt.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index bb374b9fc163..71c280d3e1a2 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -713,16 +713,18 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   	 * "watchdog_src" clock is optional; if it's not present -- just skip it
>   	 * and use "watchdog" clock as both bus and source clock.
>   	 */
> -	wdt->src_clk = devm_clk_get(dev, "watchdog_src");
> -	if (!IS_ERR(wdt->src_clk)) {
> -		ret = clk_prepare_enable(wdt->src_clk);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to enable source clock\n");
> -			ret = PTR_ERR(wdt->src_clk);
> -			goto err_bus_clk;
> -		}
> -	} else {
> -		wdt->src_clk = NULL;
> +	wdt->src_clk = devm_clk_get_optional(dev, "watchdog_src");
> +	if (IS_ERR(wdt->src_clk)) {
> +		dev_err_probe(dev, PTR_ERR(wdt->src_clk),
> +			      "failed to get source clock\n");
> +		ret = PTR_ERR(wdt->src_clk);
> +		goto err_bus_clk;
> +	}
> +
> +	ret = clk_prepare_enable(wdt->src_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable source clock\n");
> +		goto err_bus_clk;
>   	}
>   
>   	wdt->wdt_device.min_timeout = 1;
> 

