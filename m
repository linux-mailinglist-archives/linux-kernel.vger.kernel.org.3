Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1176475D24
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244685AbhLOQOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:14:48 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49884
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244657AbhLOQOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:14:46 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5CECA40265
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639584885;
        bh=BgY63FchJkPJ4eMrqqHCh/pTnUvExCwHzjMOF853cBI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=kQvjuLgjuSuJon90wlPPUsHIXOlGkKAB8BR83+nT059COoph95huY859tFyNFcYwK
         RYltee/2FhbwdesHMgfqR5VucaaXqoVmrBaHUg3gNPK9pNGbTZ9rZoLxExWgt7EZo3
         1uPeump0c+bxHrd6GwxABC7A9kBDQFIcCF99I/rPV8SRakh2gLtj1MlrVOKIwi6Xab
         GdyBwHHCPQjSq3YyZMcACVP/Aui4KR5FT1FVNLaINuWcHoKQzA9rbvqZhBi9Nr/5Jz
         YKuZ8yEiZQglmNlp2BTU2H6KevqnhwZrRa9eSi73WOBmiNKxhopDR4A238yxzvvaX5
         jFobhcc65AB8w==
Received: by mail-lj1-f197.google.com with SMTP id b3-20020a2ebc03000000b0021ffe75b14cso7193163ljf.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BgY63FchJkPJ4eMrqqHCh/pTnUvExCwHzjMOF853cBI=;
        b=CUpJ+f5jcVQdRNKsaKBcyh/MuRKNs9zA707SMly7N0/c1nmAaitXqYkykhlMg3obn9
         9+GSGCHbYIwRYpGx6VdxrVUcqbJ3P45SUbiYQVvq3OfgXkYf8sYHSOazJusHh2REfXh3
         y5iylK8e4UzGz3lyOZnGUJ1+fLjyrCBMO0hfASIuqPdWNeLWQ5a/l9WHJxwH2DV6vb0I
         rv1+PaxLoULWzIQkT0KXMGTI1DGznWMLzJKI+SxRE4TZGJohCw3WfwJ7EZLfciqTg2/S
         lzKMf0TzowtDgAz8bGWVXL7rxatwQ6376b465c7AaT8NDtSoG6gj03oF+1rs5M8oFUwK
         Xpnw==
X-Gm-Message-State: AOAM533v7YlnCXxYVQBL4BTfiZnAg/JCyrUgP0arp2t+1NADe4Lb2vxM
        kGwfUAX0vnOpqEJyp+4o/reKE3D/2yBngnoEnwaZGGQ8bVXGztVnrIVXuUslp6O5IIHq0XHzq6j
        1HiTeeLEnuf8cUNtiWszmWgsUt0u5vSjnYP1P19Dctw==
X-Received: by 2002:a2e:9a8c:: with SMTP id p12mr10675500lji.526.1639584884732;
        Wed, 15 Dec 2021 08:14:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoFe2zOV0XCkDN3GJvTojPbSxqWGhI9oo5Cf2acMBIzbtAkJY5xqgX9FvmY/8rG8I8ROe7SQ==
X-Received: by 2002:a2e:9a8c:: with SMTP id p12mr10675478lji.526.1639584884570;
        Wed, 15 Dec 2021 08:14:44 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l18sm385334lfc.97.2021.12.15.08.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 08:14:44 -0800 (PST)
Message-ID: <55294fa1-9988-5c10-1fc1-c33f3ec9b231@canonical.com>
Date:   Wed, 15 Dec 2021 17:14:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 4/7] dt-bindings: arm: samsung: Document E850-96 board
 binding
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
 <20211215160906.17451-5-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211215160906.17451-5-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2021 17:09, Sam Protsenko wrote:
> Add binding for the WinLink E850-96 board, which is based on Samsung
> Exynos850 SoC.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
> index ef6dc14be4b5..00f122197476 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
> @@ -205,6 +205,12 @@ properties:
>                - samsung,exynosautov9-sadk   # Samsung Exynos Auto v9 SADK
>            - const: samsung,exynosautov9
>  
> +      - description: Exynos850 based boards
> +        items:
> +          - enum:
> +              - winlink,e850-96                 # WinLink E850-96
> +          - const: samsung,exynos850
> +

Add it before Exynos Auto v9 entry, please.

Best regards,
Krzysztof
