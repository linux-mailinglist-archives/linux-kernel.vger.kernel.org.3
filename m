Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38D0477C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbhLPTBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbhLPTBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:01:15 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D3C061574;
        Thu, 16 Dec 2021 11:01:15 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id bf8so254370oib.6;
        Thu, 16 Dec 2021 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f8uB7MtG+KDgDa6Wr5ltw3qeYiEcgkVht8xazgx+cHc=;
        b=pU/ifuB/uNslTeKXXqF5MJ51xkorTIku9QXXcgu/v1DLWip+tDBhIqifKy9nCj9u+U
         1ZbTWbf4VuWi2V56ObQs8p+5+4hp5Fo5oZbpXR5nYXJcp3kat8a2zY2L1iZWvGguH11b
         Stvwn1xfRWcVJof9gr5L2t6zSc2HnPeJmPTkOrwr7z2Arb/Kh40asMvID3SWPEVAIJCT
         MHcTRVj+QYxDV3ZXQ7iu0iWd5GGcPw0ISt0gbXOUZkotjxYumo7p1YrK/9oEBH7sTe/a
         rIk5rNxc4w5Y6oYT1GaEgd+B4hyfEJ7V4mlI/NooEiczJLQSxOYb0u1HHAcPVeHddusP
         IIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f8uB7MtG+KDgDa6Wr5ltw3qeYiEcgkVht8xazgx+cHc=;
        b=u2ZYm3Tu7tuFf/3tTIGrjEfShM7I+vEf6g82X1rMlazsZkPsQ4JrLRsERtpNxLeejv
         xGmGa1VZKBqzipCjSsSnjlznnbDqnAxK8vyn8RVvQEJVEFoNiozYXx+dfoZg+Pt5Bd8e
         iCPtlH48Woy4IwerQIeg56lo3mW7Kg7+GhsRwuU4OkAHMxlkk5O/EHWw/rvcAYfmA1BF
         LIWRVEInshFubFMgcbXjIgys6cDH4NGXusPCPXvsR58YcFwkKjcKyqwArGBpyEctxQDo
         APdKBddkTXovyLQTsPKUrg9GnvbcwUTNLrDrobY6cj9nGfQ4ZldaAFHCXKAxDEsZsZnq
         fmBQ==
X-Gm-Message-State: AOAM532i/oC2M62jHrimn7L6AfN2SfoTxXqr6qyHCaPocOJDKFVvf/r6
        Ck8Nb0fVSIel6rMQ0WXS+tw=
X-Google-Smtp-Source: ABdhPJzw2xSDkOsLfEmfWEIY88zsb1g8JjSz4vhf4Yqc+xWh8JzZLnzq+pzHaoar0Y1cbe8Wx4sRNg==
X-Received: by 2002:a05:6808:14:: with SMTP id u20mr5177212oic.69.1639681272906;
        Thu, 16 Dec 2021 11:01:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w25sm1194075otq.28.2021.12.16.11.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 11:01:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] watchdog: s3c2410: Use platform_get_irq() to get the
 interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20211216183639.7710-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3733aa67-8606-58de-69cb-f7a167713da4@roeck-us.net>
Date:   Thu, 16 Dec 2021 11:01:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211216183639.7710-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 10:36 AM, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   drivers/watchdog/s3c2410_wdt.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 2395f353e52d..f5aced344b7b 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -513,9 +513,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct s3c2410_wdt *wdt;
> -	struct resource *wdt_irq;
>   	unsigned int wtcon;
>   	int started = 0;
> +	int wdt_irq;
>   	int ret;
>   
>   	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> @@ -536,10 +536,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (wdt_irq == NULL) {
> -		dev_err(dev, "no irq resource specified\n");
> -		ret = -ENOENT;
> +	wdt_irq = platform_get_irq(pdev, 0);
> +	if (wdt_irq < 0) {
> +		ret = wdt_irq;
>   		goto err;

All those "goto err;" statements in this function are pointless since they
just return ret. Since this is the first of those goto statements, please
replace it with "return wdt_irq;".

Thanks,
Guenter

>   	}
>   
> @@ -592,8 +591,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   			dev_info(dev, "default timer value is out of range, cannot start\n");
>   	}
>   
> -	ret = devm_request_irq(dev, wdt_irq->start, s3c2410wdt_irq, 0,
> -				pdev->name, pdev);
> +	ret = devm_request_irq(dev, wdt_irq, s3c2410wdt_irq, 0,
> +			       pdev->name, pdev);
>   	if (ret != 0) {
>   		dev_err(dev, "failed to install irq (%d)\n", ret);
>   		goto err_cpufreq;
> 

