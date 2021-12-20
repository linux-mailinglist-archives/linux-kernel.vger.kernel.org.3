Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C7947A9B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhLTM3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhLTM3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:29:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78B0C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:29:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg2-20020a05600c3c8200b0034565c2be15so9491502wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+PcnGxhJFgJFq8C9/A9f7W+O7WZ4IV+4n9+SWg14/VU=;
        b=yoZ590xupjWmnjiXUltg7zRY6rWXuOa4c3FPxdaivdy8VQ/I1E6MTvCUpNwF8Yir2e
         MYeJK5Z8MA8x+01/VLZ4B3/YIV6k9a9LdQ6QruGkxrUCM3yccYa2GpngoVQFJEBJpDWw
         Iox2GXDfOgWO2ju02MjdRqduDoLdEx9HuPrcIEWixXTO0boWkM7cLK5uYLiOdBNxygoC
         UVCYe3XX2P43PxAMn1OnT3bOUhUl/lb9nC4LZ0yYi4Z/xahVjqDwKces4z1Bw3a9oJ+t
         /s2m/Jkx+z0kuuIVPjWXV7gjbcbRzTN21V/yeU7rgDa0GbES+6N1yeyEzUGTgQT/WIEu
         TZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+PcnGxhJFgJFq8C9/A9f7W+O7WZ4IV+4n9+SWg14/VU=;
        b=1BrVBDAn+4CoJrh/6DxM7+sH94u/QF1L/g3ij4/pvvBKsvvLeUCe3WuIrnLW4j259D
         wt9M7FKpwQyfpr0aiYGxNga49VK24XDf8la5+TvaHydPILkWBK9HLfh/jkWgdaVUTklB
         j5a9/69VfJL0e08pU+B0TBUPrCmLkn+jE22XOk84mxHY66OolljpTD5NJHe1dzNTY+pa
         X5kFs0A35uSiTm/p6W5x3qty3mkNxDq0OD9OrHTw+DnxHMSjXev9aZD1Yew8LfiOY7Rp
         +2VBJO74oLId9p1PDNVH1zXMzgX34TJexmc6mVnrS9ddwFLXqSaaoquIioaHWX86Ewbl
         +lww==
X-Gm-Message-State: AOAM530Z5bPV1+cJNC/BXqHirh55wMaTQuEAP2QNCwSy0XnDt9+ehosr
        oSWSsnnCmN4Yc/QcYxugG7nr6Q==
X-Google-Smtp-Source: ABdhPJwDNRbbdfnlpSzXceRp9wC+Lp3t4UEDGZej7Ki6uZQTh5Z88Z3EgNxYi7qkF2gQ0KHyDFcyLQ==
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr884520wml.26.1640003385145;
        Mon, 20 Dec 2021 04:29:45 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ac6:da31:b84c:183? ([2a01:e34:ed2f:f020:ac6:da31:b84c:183])
        by smtp.googlemail.com with ESMTPSA id p1sm6339686wma.42.2021.12.20.04.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 04:29:44 -0800 (PST)
Subject: Re: [PATCH] thermal: rcar_thermal: Use platform_get_irq_optional() to
 get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211218144136.6663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5f8e2432-1214-3435-fb62-2f407ced0472@linaro.org>
Date:   Mon, 20 Dec 2021 13:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211218144136.6663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2021 15:41, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi,
> 
> Dropping usage of platform_get_resource() was agreed based on
> the discussion [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> Cheers,
> Prabhakar
> ---
>  drivers/thermal/rcar_thermal.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index b49f04daaf47..e4c7bc1bf7ef 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -445,7 +445,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	struct rcar_thermal_common *common;
>  	struct rcar_thermal_priv *priv;
>  	struct device *dev = &pdev->dev;
> -	struct resource *res, *irq;
> +	struct resource *res;
>  	const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
>  	int mres = 0;
>  	int i;
> @@ -467,9 +467,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	pm_runtime_get_sync(dev);
>  
>  	for (i = 0; i < chip->nirqs; i++) {
> -		irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> -		if (!irq)
> +		int irq;
> +
> +		irq = platform_get_irq_optional(pdev, i);
> +		if (irq <= 0 && irq != -ENXIO) {
> +			ret = irq ? irq : -ENXIO;
> +			goto error_unregister;
> +		}
> +		if (irq == -ENXIO)
>  			continue;

Why not invert the conditions?

		if (irq == -ENXIO)
			continue;

		if (irq <= 0) {
			ret = irq ? irq : -ENXIO;
			goto out_unregister;
		}


> +
>  		if (!common->base) {
>  			/*
>  			 * platform has IRQ support.
> @@ -487,7 +494,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  			idle = 0; /* polling delay is not needed */
>  		}
>  
> -		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq,
> +		ret = devm_request_irq(dev, irq, rcar_thermal_irq,
>  				       IRQF_SHARED, dev_name(dev), common);
>  		if (ret) {
>  			dev_err(dev, "irq request failed\n ");
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
