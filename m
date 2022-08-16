Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872625959CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbiHPLVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiHPLVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:21:04 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D1DE42C7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:45:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f20so14167158lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=egVgk37jsb5bP/NihMXfkkjt0RcB5vm1gJqee+Euv4k=;
        b=AEhcllsKHaBLOkNxBC/mnTGx3zk3qk8yoRqnZ7WCmJGbS7PCIItMYVqBHBJ8RrPJ2J
         9poBL5mFBFE9bM4jkeKfNs0lFv6IeTx8vbs+pavY+LOMNn0tEGZxNBpExOkzgnbnXHqO
         9tki8SV5kx3i+cmFC5iRLmMoMvYeQfd5OS9jl6yC6bEUEuhTyrhdxj82pDsEw2YaoyZE
         LVsqkTC3lSiqf2tjX9H4eUCQwZzgkqU5Po580Z+VU6WMhaGM2990D1wugUqmEdqMd+CL
         3f9yNBJKdX9SmfXAUCiKWnA/FSINXAw5//bZQjFuWfLOpWfc0UOnAE7VMhsu1E2/H+qY
         MIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=egVgk37jsb5bP/NihMXfkkjt0RcB5vm1gJqee+Euv4k=;
        b=Z489+0DK1S8UkONITdy6SutGw4DYPn+zHcKI7/1cNk11wuN5pdbYxRBhw0vkrc5uuV
         hQmta2UGC+F6UiP0YfbGpvshL2HImv7JyjbKY36SSRq5Tmrm8tKTpTF6QzkLLIODE9ep
         qqR5RwFeHo2YLbfqxGEyEqG4STVe2hcrTf3wrip+OGT5TEaU5Q+DUAY4llVSLcEGE40z
         eKuEc5Eu38Um1NCaiFe+uZzPz2L6hGAvxivv8bP6+4gJ3XvDWTtkZhaxenhFOZ4r+6zX
         usJJBkaAFimlqniBBYBZ5b+GtqkG4CwoAqt5aLLgYlEj9Vz7YyD2d3UhPy8BPSraLmU2
         sb+Q==
X-Gm-Message-State: ACgBeo3JIUSqdk6/YLqxI+zx0pPoe4Aqh78WIzd5cjAY6MQrCq/upjZQ
        gdCyX6Bl1jbTflaP6PxMgQGDDg==
X-Google-Smtp-Source: AA6agR4GisQVfukKTkz/1D4XZ5iXpQMDvR/AIMZ05fuXqOeyj04c7DOKOOivIHMqeVge+x1lJphtng==
X-Received: by 2002:a05:6512:a82:b0:48b:1241:f4cc with SMTP id m2-20020a0565120a8200b0048b1241f4ccmr6589955lfu.141.1660643130890;
        Tue, 16 Aug 2022 02:45:30 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id s1-20020a056512214100b0048b3581eb7dsm1332957lfr.260.2022.08.16.02.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 02:45:30 -0700 (PDT)
Message-ID: <cae2f59a-aeeb-e573-029f-7151ae29dd28@linaro.org>
Date:   Tue, 16 Aug 2022 12:45:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: spi: renesas,sh-msiof: Fix
 'unevaluatedProperties' warnings
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220816083842.25925-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220816083842.25925-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 11:38, Lad Prabhakar wrote:
> With 'unevaluatedProperties' support implemented, there's a number of
> warnings when running dtbs_check:
> 
> arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb: spi@e6e90000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
> 	From schema: Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> 
> The main problem is that SoC DTSI's include power-domains and resets
> property, whereas the renesas,sh-msiof.yaml has 'unevaluatedProperties:
> false'. So just add optional power-domains and resets properties.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> index 5de710adfa63..7bd86cf876f1 100644
> --- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> @@ -69,6 +69,10 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  power-domains: true
> +
> +  resets: true

No. For both you need maxItems (or describe the items).

Best regards,
Krzysztof
