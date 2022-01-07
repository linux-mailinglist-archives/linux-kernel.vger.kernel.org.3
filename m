Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D178B4873E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345517AbiAGIGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:06:02 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38014
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235551AbiAGIF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:05:59 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AFFA9406EA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 08:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641542758;
        bh=zGOp6WmlrpEr64FvotHvBG2RkgYGeePAZ958XvM930s=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pbYXd1bXJ6PE0uJJvfyilfWalhnrlGuhYlGDp65tXP44Xn9OO6U4NG/5XsGJBQTl3
         gS5gt1La5XvZYiaV/eRmbzi1nDSXyIVQNqRhDQ/q8pBlroXQPEVkycvjUN61Yb32pN
         fxUiAxG+HHBpimS1Hx7ZAnoFuSSthJL+9StR+OwSAAsrY6OOQBzxGEMaaLJyQ0ajCD
         Vy834sxNdS2Adq7SqVfHazzdTxZTMXoBp6o6QOnEGVllXoR3mGXCyDcn97/j+MX6zH
         hU20XW865FQCuXfD8JIljVX5i+0iJ2476ICYKa9mndEK0BM/2z6rFru1JI9+UEhW8V
         YPU8fF8WN3afg==
Received: by mail-ed1-f69.google.com with SMTP id z10-20020a05640235ca00b003f8efab3342so4039824edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 00:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zGOp6WmlrpEr64FvotHvBG2RkgYGeePAZ958XvM930s=;
        b=2sWjPqqiGYQHicrecfYDz9jwkxkecQESoMYXnfAMvQFjATB2+/jtGyWbg0goNxHmXx
         4rVqmyiK3fG6UewdhcOB/ykBWyiV8DoARwZU572t+f8oKEMBhWTHpDXyUwLsvFR7HQKA
         2M6JUBreJru7yCNRZPWtTNA0pae2LUy6qAatgtHfXsOvDCy9vLIeuJGh0iihb2rXqWQ6
         bQ4al+l7vCymx4UJXUWVDxJrkMB59+u4ymHoLbO1sPnAI4LRBBjeOTRF25ADbrDHlSDM
         rbK2Q2XiCfyfQ6Rigq6WB4/Dsd8jLJFaKVNFhJkX9XE0aegS16xAoeiP+Ogj5hOseAaS
         PMoA==
X-Gm-Message-State: AOAM531IhD2lFinM7HfHmUor/2OT+ZT0HbU8bfUbSXPU+v5qyBt1EeG7
        qsjhnYrON99r3ovs5j1gTx1zXwdystp+ExGE/ul9LmYExdJ1LLc+k8PI+Y1zosicoFVe/eeET0L
        3R3QXSCR45KbP6UdKEMfhMBcPzzTrGRuLN1vA5ouR1A==
X-Received: by 2002:a17:906:2a41:: with SMTP id k1mr47222569eje.512.1641542758379;
        Fri, 07 Jan 2022 00:05:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNsuAsV/2E7XwAZfUqi0RQvqIFw/qSqhNDfyVmGDc8/zcZUu7ZNzCHaqAUKZ4J+sqQvYVsOw==
X-Received: by 2002:a17:906:2a41:: with SMTP id k1mr47222563eje.512.1641542758223;
        Fri, 07 Jan 2022 00:05:58 -0800 (PST)
Received: from [192.168.1.126] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id sd39sm1197043ejc.14.2022.01.07.00.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 00:05:57 -0800 (PST)
Message-ID: <b40fedf8-73d7-6f4e-d26e-2f274b15228a@canonical.com>
Date:   Fri, 7 Jan 2022 09:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] arm64: dts: exynos: Add missing gpm6 and gpm7 nodes to
 Exynos850
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220103181826.2136-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220103181826.2136-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2022 19:18, Sam Protsenko wrote:
> gpm6 and gpm7 nodes are missing in Exynos850 device tree. Next errors
> are reported because of that:
> 
>     Missing node for bank gpm6 - invalid DTB
>     Missing node for bank gpm7 - invalid DTB
> 
> Add missing nodes to make those available to use, and to fix boot
> errors.
> 
> Fixes: e3493220fd3e ("arm64: dts: exynos: Add initial Exynos850 SoC support")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> NOTES:
>   - Recommend to apply this patch after "arm64: dts: exynos: align
>     pinctrl with dtschema in Exynos850"
>   - This patch also brings back two interrupts removed in "arm64:
>     dts: exynos: drop incorrectly placed wakeup interrupts in Exynos850"

I'll take it after the merge window and apply it before my series (so
without -gpio-bank suffix).

> 
>  .../boot/dts/exynos/exynos850-pinctrl.dtsi    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> index a71acf358d2d..f43e4a206282 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> @@ -194,6 +194,26 @@ gpm5: gpm5-gpio-bank {
>  		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> +	gpm6: gpm6-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpm7: gpm7-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
>  	/* USI_CMGP0: HSI2C function */
>  	hsi2c3_pins: hsi2c3-pins {
>  		samsung,pins = "gpm0-0", "gpm1-0";
> 


Best regards,
Krzysztof
