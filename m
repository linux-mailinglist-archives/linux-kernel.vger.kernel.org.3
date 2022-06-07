Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1205E53FF14
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiFGMlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244027AbiFGMlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:41:37 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C385DFF47;
        Tue,  7 Jun 2022 05:41:36 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t22-20020a0568301e3600b0060b333f7a1eso12843981otr.0;
        Tue, 07 Jun 2022 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jqn5ENcnbUU/0+opNYmJQjgSQeuwZaQtQYaCaEQBiPI=;
        b=EfBNNu/iYNWZEw+b59EZt7f23G4b1uF2NCtoCOBprSRTS+oZIgAnvJq1pd3C5/P8QQ
         gcwmFmsvjMHKgGozGa6PghxD9u2bzm8Ub8MtJjwr2/8qkvB9CYbua5fXn0cPexgVavHr
         o2x6TgDk3XSqnbaQJpVADuvDimRSwG0ReMgtOUO6OwGK+VrDovhXWxvZXTLfz8+UoETf
         LWq074HO4nPPq0poPtAtyYBxfMGycUbS0rHEyfIOsqmzWJ50Tia99pZ4i/yxAfdqJ/8q
         8mNUQK6mxgxLirn1LpTyDd70tmW/wiz0VMrGVT0CZTl4RS/pmWz1Zc9YblQwPeQddvDp
         v3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jqn5ENcnbUU/0+opNYmJQjgSQeuwZaQtQYaCaEQBiPI=;
        b=5zIll6EbU3gyg2hUDDeuaxUr037N3E5XelrW/uvv/aYwCioJlicsDYzU54wCk7T0Mu
         gjcKlR+8x10F7GD1A/GyxHe4TqWJmPrTnfyBv53gUHsnI4wGgVEM8BvGppNDoQoRl2B/
         sClbydE7KxG3oXohkIPdv1Y9t/fUURh6EKwUrmTJ3L0VCdTAwyNp/tQfwNMdcBMZpTZh
         QM5NSM2qnfElI5/QbbhPjqsJ9rlHH5f0vaJ9pSV1yLvK8Q4Hd60+7XnD/8fRW8cIDZuM
         ECt/gOGEwmec8HdcETrkm98Uz59MmIx+p2DSsof4hDRrEjL6UQf1R73phB42EZROemtq
         Yr9g==
X-Gm-Message-State: AOAM530PV/vYfqXao1YVbVxRJY/JOVjAvzq4v3JkGASP4pK8cu5LEvOc
        KZsxHSi9Fc6WTy3fnMBzsigmdfJzovM=
X-Google-Smtp-Source: ABdhPJyytTlsX8ZhKcQU08iE3UDQqgHYhIS1DZZphg+BE++3QrOjnl/yK7mT1LqXhi8fXU6f9NDzFw==
X-Received: by 2002:a9d:6081:0:b0:60b:c8f7:272e with SMTP id m1-20020a9d6081000000b0060bc8f7272emr10907645otj.11.1654605695311;
        Tue, 07 Jun 2022 05:41:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t11-20020a9d728b000000b0060b66b6641fsm8980343otj.5.2022.06.07.05.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:41:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <216b6e68-df86-4117-8519-01b7f1bf199b@roeck-us.net>
Date:   Tue, 7 Jun 2022 05:41:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: Drop more redundant 'maxItems/minItems' in
 if/then schemas
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220606225137.1536010-1-robh@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220606225137.1536010-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 15:51, Rob Herring wrote:
> Another round from new cases in 5.19-rc of removing redundant
> minItems/maxItems when 'items' list is specified. This time it is in
> if/then schemas as the meta-schema was failing to check this case.
> 
> If a property has an 'items' list, then a 'minItems' or 'maxItems' with the
> same size as the list is redundant and can be dropped. Note that is DT
> schema specific behavior and not standard json-schema behavior. The tooling
> will fixup the final schema adding any unspecified minItems/maxItems.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../bindings/memory-controllers/nvidia,tegra186-mc.yaml        | 3 ---
>   Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 1 -
>   .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml  | 1 -

Acked-by: Guenter Roeck <linux@roeck-us.net>

>   3 files changed, 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> index c7cfa6c2cd81..935d63d181d9 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> @@ -150,7 +150,6 @@ allOf:
>             description: 5 memory controller channels and 1 for stream-id registers
>   
>           reg-names:
> -          maxItems: 6
>             items:
>               - const: sid
>               - const: broadcast
> @@ -170,7 +169,6 @@ allOf:
>             description: 17 memory controller channels and 1 for stream-id registers
>   
>           reg-names:
> -          minItems: 18
>             items:
>               - const: sid
>               - const: broadcast
> @@ -202,7 +200,6 @@ allOf:
>             description: 17 memory controller channels and 1 for stream-id registers
>   
>           reg-names:
> -          minItems: 18
>             items:
>               - const: sid
>               - const: broadcast
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> index c79639e9027e..7a2b22dd6d05 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -145,7 +145,6 @@ allOf:
>             items:
>               - description: Xenon IP registers
>               - description: Armada 3700 SoC PHY PAD Voltage Control register
> -          minItems: 2
>   
>           marvell,pad-type:
>             $ref: /schemas/types.yaml#/definitions/string
> diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> index cbcf19f51411..ed6c1ca80dcc 100644
> --- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> @@ -64,7 +64,6 @@ if:
>   then:
>     properties:
>       clocks:
> -      minItems: 2
>         items:
>           - description: High-frequency oscillator input, divided internally
>           - description: Low-frequency oscillator input

