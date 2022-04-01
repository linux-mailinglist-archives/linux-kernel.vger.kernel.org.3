Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43A04EEEA2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346583AbiDAN7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiDAN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:59:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7022C280EF1;
        Fri,  1 Apr 2022 06:57:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso2601311pjh.3;
        Fri, 01 Apr 2022 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zhI8HSmXQhpupMl4PPKuINoqdj8SShsVbASO+4FyDJA=;
        b=acHYoRd9fl+1Sd/3JOEzziqyFg3qrd4e4NkDwGpAwylr2oaZ8JR1ySztaOCn/zAuBM
         Hc3bu4kJ1K6DbFaYcvUhUe1qBM5UREr0vjdh+DKnfiNqArhQlWGn9hNvrIyhWLK7Q0jR
         qlltuIsxf5HENKVBXcNYpHTpHSKwSLYrbz7TNxV7zpyGzJVR9N08DeO2fT/kObUa6702
         L5BTmXbu0W/7yXz8rWslEr0kY6nt9GYvVHGE8TritmhGnG+3OdBVj5rhUgXrE8YJqYS8
         v3uBZErqCARwyzBlmjeinOzhPom5J2WkuFeNfGto5O7AI0I7h3d0QrAV44kAer9ucClZ
         axVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zhI8HSmXQhpupMl4PPKuINoqdj8SShsVbASO+4FyDJA=;
        b=UXlFtr/kfD50ahgraHPb7oohbnUtYRnIr5HqiivU/NvrqMesUiLo4GMbqJ6EoOX2VX
         P2BQ8X+E9DEDaG26315ZnAoYGRlGvs34ylBiKXAOnQkyh0P4mQuXyTwbR4ksv4+1H85m
         Bko7gLSp8hrMwqpL5R/UwsyFFr/S61QCpWKUIdYK1zt3/W/wfGb2X9EiQg7UcoHW25SP
         lz+ohLyR2qmD7t1h1ScB9De9/LUSAmYGwwqmFd/kd0TJtBktnEKTGm+8TsWlBeu5/NRt
         jnZkw1+2WYq39HMgdmiutKcZj+g6uUeHfcu+jKol7R0b4qpMCgC96l2YF88SXmtOfAZc
         ceTQ==
X-Gm-Message-State: AOAM530r+6y9TLZtzB0/8EbLp5MrFIY5CdiIKMfB/KqSwBAZyaUmSaOt
        F4VAy/btSpPk4tHMiYojjCwvwtPUSyU=
X-Google-Smtp-Source: ABdhPJxgbGSIiinLxRILEw+RqQWVcTIjP0Am+7lU6DaHiJzBfKzL46/yrtmT0Fx2COMzodmLjGUM4w==
X-Received: by 2002:a17:90b:4a41:b0:1c7:a0d7:718c with SMTP id lb1-20020a17090b4a4100b001c7a0d7718cmr11849128pjb.57.1648821451721;
        Fri, 01 Apr 2022 06:57:31 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id q15-20020a056a00150f00b004fb28ea8d9fsm3407312pfu.171.2022.04.01.06.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 06:57:31 -0700 (PDT)
Date:   Fri, 1 Apr 2022 19:27:25 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: qcom: qcom,geni-se: refer to
 dtschema for SPI
Message-ID: <20220401135725.GA40356@9a2d8922b8f1>
References: <20220331160248.716234-1-krzysztof.kozlowski@linaro.org>
 <20220331160248.716234-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331160248.716234-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 06:02:48PM +0200, Krzysztof Kozlowski wrote:
> After adding DT schema for the SPI controller, the Qualcomm GENI Serial
> Engine QUP Wrapper Controller bindings can reference it directly for
> full schema validation.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>

> 
> ---
> 
> Changes since v1:
> 1. None
> 
> Patch depends on previous patch (DT schema conversion).
> ---
>  .../bindings/soc/qcom/qcom,geni-se.yaml       | 22 +------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> index 690ce6a355de..1bc12b6a7e01 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> @@ -103,27 +103,7 @@ patternProperties:
>                   supports up to 50MHz, up to four chip selects, programmable
>                   data path from 4 bits to 32 bits and numerous protocol
>                   variants.
> -    $ref: /spi/spi-controller.yaml#
> -
> -    properties:
> -      compatible:
> -        enum:
> -          - qcom,geni-spi
> -
> -      interrupts:
> -        maxItems: 1
> -
> -      "#address-cells":
> -        const: 1
> -
> -      "#size-cells":
> -        const: 0
> -
> -    required:
> -      - compatible
> -      - interrupts
> -      - "#address-cells"
> -      - "#size-cells"
> +    $ref: /schemas/spi/qcom,spi-geni-qcom.yaml#
>  
>    "i2c@[0-9a-f]+$":
>      type: object
> -- 
> 2.32.0
> 
