Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506F3465F4A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356072AbhLBI2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:28:35 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46742
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241248AbhLBI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:28:33 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EAA1E3F1B0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638433510;
        bh=rq4kQo+vXc9W5cZ125vb40WvISYosmc4HFLz8BRJoVE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=OdD0k+plIco9hLRQrUNiIqUJPlYosqtU89tOPbJPRy7gdZQcW9d2tN5JuAJvKAPXF
         tbOZ1MOFZHGHJh8XllAjljr6eQ+XgVym/ka9lDfko+ZfvwMjNBudYNHZjUUOnhQMiO
         LOvmviyFLHV4KIDgqtCUkI9ECgoMEFx56giwFXn3RtaYf0TRCYE2B4e5oi/NAKdCuh
         /9LDJ28cgJzRKKrsyghpfDIKWW1ctR20ZVEQSO5vUUztHrsk2DZZ3hlvCGJPWZHyJf
         B2rTy7LMLdm9T78Z2r+0D4jFoDk1dYSoK/0eBC0Y475HEU+gRWTbOdU58cCH+SBgjl
         +n3Ul4jWIL3Vg==
Received: by mail-lj1-f197.google.com with SMTP id y23-20020a2e3217000000b00218c6ede162so9307092ljy.23
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 00:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rq4kQo+vXc9W5cZ125vb40WvISYosmc4HFLz8BRJoVE=;
        b=r4PHAZxqhEJf5dD3IIc5P+x8YGGIsi/If2FagiyHJalXmahYZnXc20scE+4MvnBATp
         MNc42Igmq8FDA6CY8ulunoCqxMRLn7laxK7SZMis+EMmFDlqOy5Y5g7jW5zNIYW3hBPQ
         gCCUydqCqUjZR/7h8XkvX0fQvBUPUrRJoYeqTIRUcbsaIHv172bB+ZeI4427H9q6GLq9
         J2T9P4Bjl62/8nnYk/FtvCYeHInCuBPei17D/ffkxZoqij+w0wY61WsI3ZKasLGTeryN
         8/ghU+9XJSv9eBY+FD1TgIpKUBpCVfHVwbCW2KKL/61bNfoscfBkwMW5vwEAS7wxFbnN
         CeXA==
X-Gm-Message-State: AOAM533+KGczx9ccp/0MaU06yB7j9In5xpekZPnlZBZe+GfFgPVIxVH+
        vJxhXG51j4JfU8JGbLRaWJ1NfxLg/FYt4ylysEE7Ln+EoRn0GUupsxZx1bWish1q+CAElICUrf+
        B5JtBg3isk2rJyfROOCaOHFK1gOI3iGVYrtKrYfnSQQ==
X-Received: by 2002:ac2:442c:: with SMTP id w12mr10991026lfl.554.1638433510413;
        Thu, 02 Dec 2021 00:25:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeOf+QpxgrYFm1d6a5sk8CXUHe/Co/Txbe1+rCii5yOp8kswnRPQJ/L/ELgmX1saEmNDb38w==
X-Received: by 2002:ac2:442c:: with SMTP id w12mr10991013lfl.554.1638433510232;
        Thu, 02 Dec 2021 00:25:10 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id w8sm256217lfe.183.2021.12.02.00.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 00:25:09 -0800 (PST)
Message-ID: <d12545a3-6fae-99aa-3851-97f3ea352bf1@canonical.com>
Date:   Thu, 2 Dec 2021 09:25:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/6] dt-bindings: i2c: exynos5: Add bus clock
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20211201190455.31646-1-semen.protsenko@linaro.org>
 <20211201190455.31646-4-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211201190455.31646-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 20:04, Sam Protsenko wrote:
> In new Exynos SoCs (like Exynos850) where HSI2C is implemented as a
> part of USIv2 block, there are two clocks provided to HSI2C controller:
>   - PCLK: bus clock (APB), provides access to register interface
>   - IPCLK: operating IP-core clock; SCL is derived from this one
> 
> Both clocks have to be asserted for HSI2C to be functional in that case.
> 
> Modify bindings doc to allow specifying bus clock in addition to
> already described operating clock. Make it optional though, as older
> Exynos SoC variants only have one HSI2C clock.

I understand that it is required on newer SoCs, so you need "if:" adding
it to required properties on Autov8 or 850.

> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../devicetree/bindings/i2c/i2c-exynos5.yaml          | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
> index db20e703dea0..a212c1d5e7d9 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
> +++ b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
> @@ -49,11 +49,16 @@ properties:
>        clock-frequency is >= 1MHz.
>  
>    clocks:
> -    maxItems: 1
> -    description: I2C operating clock
> +    minItems: 1
> +    items:
> +      - description: I2C operating clock
> +      - description: Bus clock (APB)
>  
>    clock-names:
> -    const: hsi2c
> +    minItems: 1
> +    items:
> +      - const: hsi2c
> +      - const: hsi2c_pclk
>  
>  required:
>    - compatible
> 


Best regards,
Krzysztof
