Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2547813D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhLQA0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhLQA0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:09 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40022C061574;
        Thu, 16 Dec 2021 16:26:09 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so903111otg.4;
        Thu, 16 Dec 2021 16:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=szQ/moN02WuRNLfAL/8IXgFN405QV6qArzBmNh29t3k=;
        b=p8yJeKrwYAv4Ch7cL196/1+rgq2YLYmcJ/DTuQh0eac9zbo7IehX9o7lYBXHv07RKW
         Sh1v8ivllJbh41SAjTY8cvegBvZGujwh8LsCnM5q5SrfqfaQQVXxHvWupiKOFX3ZLgPE
         KOD7la7YuAOUPWAZgDS414g8lrRb5ZTPkgqWLFKHBI8m+lGCWtdIZIlII+slA6ckeDlc
         BQiEmyuGAjPdzfpunRTH3gLhgdcByXkzofeXEMA7xF5rKBpgVXxoTnumBLgBYdHJtf2I
         OuHkGWuIE+POVeDBtqZyxhAIKuDcN5eLCwJ0JTfxZzMpTnNWCBOF17F4KbVnyt67Ujml
         Kxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=szQ/moN02WuRNLfAL/8IXgFN405QV6qArzBmNh29t3k=;
        b=RHIJyf8lokuF8HYvWHACLQL1jgzuEllLpa2m1vP21nwfM3nIChwN3EmAFk3Uk7ifHb
         UC9Hvr+gHsAymhdG/PMeqpIoNfUOr0s61hUiwjbJLL47kH9n0NPsaG6sd3dSJfDr3Yne
         TbUj6Ms83BZ4NhZ1Oh1Buz2LY0mAZsluMvAE4VID8PRwFow3lD6zGt9L7O8HFAYkspjL
         eoIgJ48cwDrSgqbu6cdXFGplcIwFCTIlDo9s7bczsqm9nzdp/xwOoBn0WNlRAaTM7NHz
         LM1t9qQ71/CUT6c14/vJN41tng3gYnXrT3ar/v03cmkgaB1vADnzkCZ/tqyZiCxutLFi
         QUjQ==
X-Gm-Message-State: AOAM530KxDpvr43D0nwiUiB4DALplx/8AVpeiS3lwVDUlv4tHPDxatNZ
        rUjJ17SBHQJ6N+Eiw937+NM=
X-Google-Smtp-Source: ABdhPJwBvjo1QtmlV+IPIJ50JON1ZvMn9JrwMFpfNIH8l8pdjqcLki5jePGO2iQ/6lSROp+bKb5giw==
X-Received: by 2002:a05:6830:22f0:: with SMTP id t16mr426774otc.349.1639700768596;
        Thu, 16 Dec 2021 16:26:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d6sm1293040otb.4.2021.12.16.16.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 16:26:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] watchdog: s3c2410: Use platform_get_irq() to get the
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
References: <20211216214747.10454-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fc705702-8a8b-d2aa-7de6-7c409c091365@roeck-us.net>
Date:   Thu, 16 Dec 2021 16:26:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211216214747.10454-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 1:47 PM, Lad Prabhakar wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v1->v2
> * Dropped goto and directly returned on error
> ---
>   drivers/watchdog/s3c2410_wdt.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 2395f353e52d..d92bc1c24182 100644
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
> @@ -536,12 +536,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (wdt_irq == NULL) {
> -		dev_err(dev, "no irq resource specified\n");
> -		ret = -ENOENT;
> -		goto err;
> -	}
> +	wdt_irq = platform_get_irq(pdev, 0);
> +	if (wdt_irq < 0)
> +		return wdt_irq;
>   
>   	/* get the memory region for the watchdog timer */
>   	wdt->reg_base = devm_platform_ioremap_resource(pdev, 0);
> @@ -592,8 +589,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
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

