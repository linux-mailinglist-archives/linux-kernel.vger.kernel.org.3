Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86994CC483
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiCCSBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiCCSBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:01:47 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D50188857
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 10:01:01 -0800 (PST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA1EF3F5FB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646330457;
        bh=IdYKuRpoQlWJKJqHmP4kdLinl0/TpAzOJ3W1H49SOHA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pdbZ0zOGUGlMLA8be+YMsxPg6ccEECNCFoAFxzE12nIWYJxanjq8WWO/bT5OSG+eR
         rNkSwMqG8XvlTIglauC6QNYUAxsZ6aR8w8jvjvj8rD23kXUAE7NTVTnAuOoyFvuV60
         Te+6615TvxyMiVYUMomhN2mpdi852k9soSLkcslJ0L9yNSEDYytTX06GgJoDpeZbP5
         r4c1i+MQ2/aOM5ezTENsLV3isXhx840vv8dPxoe1sDszyEA3oxVngDr/BVe4lN4eoe
         cCY6ff60ZSNSg6lKpD0ZOIMv6NBNNl1uTQ1BjV8S/gzJ/On7/+ek84aoR0tGa8264Y
         ezB8OZlRtzBvg==
Received: by mail-wr1-f70.google.com with SMTP id x15-20020a5d6b4f000000b001ee6c0aa287so2328324wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 10:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IdYKuRpoQlWJKJqHmP4kdLinl0/TpAzOJ3W1H49SOHA=;
        b=0sV6CyiXzAQBVyN5CULbsD6yvvbU8Hwqq7h7daea9nKSA1Ik8zCwlyQvhj9TjsU+AX
         Dm0iE5jXCYA+vH2aihim6rjXEKOYHOUWeWvQwQFAeFInijcPnGdLnbLeUQ/fx6QyBpmD
         aCDfMqywVBCfy8rmVpU2zcts14uaB/h1DVYgWE1WopBkuEiiEg4ia9i75V5BZDeEj8F6
         ryczwIwb4XuiYBHzmUFmoXGLLo8lgEJDfsfp2GMI2Hb1vaNsyvCkKIGZ0twj58qSqezB
         aafu2h8/CNomZio5ycVtpauvoTZ+m0BaAEEKrOy3MXRlJpUHrzhwq6yTsTVhHJ4sLcFW
         PnBg==
X-Gm-Message-State: AOAM530Z0CvbJn37NEtDwj1BjIecIwq5HXOUj5AQh5iGHs5dcVb9Jygk
        GRIVs2h48DiYu0NUi5NyS0OFlvth55UreDlSaPCAhmjVw29XFlAp3sAEMATpJ6a74wY6bmbzVp2
        lWhIF8e5o/9vtsZfAEprYU1oYeaV5AoJRE/k6dw0o3g==
X-Received: by 2002:a05:6000:1787:b0:1e7:aeac:eb00 with SMTP id e7-20020a056000178700b001e7aeaceb00mr28314779wrg.141.1646330457455;
        Thu, 03 Mar 2022 10:00:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcUUp/VkxET1O/z2n1UvXKsWsZKCgRWxpJ2ac80sDA6uo4FyeX3pHAb3asJ2/klasvI3ebWA==
X-Received: by 2002:a05:6000:1787:b0:1e7:aeac:eb00 with SMTP id e7-20020a056000178700b001e7aeaceb00mr28314754wrg.141.1646330457158;
        Thu, 03 Mar 2022 10:00:57 -0800 (PST)
Received: from [192.168.0.138] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id f16-20020adff590000000b001f0122f63e1sm2592891wro.85.2022.03.03.10.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 10:00:56 -0800 (PST)
Message-ID: <0d7b9a17-f5fc-69e5-173f-1c897522d3f3@canonical.com>
Date:   Thu, 3 Mar 2022 19:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Add apple,efuses
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220227115743.69059-1-sven@svenpeter.dev>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227115743.69059-1-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2022 12:57, Sven Peter wrote:
> Apple SoCs come with eFuses used to store factory-programmed data
> such as calibration settings for the PCIe and Type-C PHY.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/nvmem/apple,efuses.yaml          | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
> new file mode 100644
> index 000000000000..a735d54856ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/apple,efuses.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoC eFuse-based NVMEM
> +
> +description: |
> +  Apple SoCs such as the M1 contain factory-programmed eFuses used to e.g. store
> +  calibration data for the PCIe and the Type-C PHY or unique chip identifiers such
> +  as the ECID.
> +
> +maintainers:
> +  - Sven Peter <sven@svenpeter.dev>
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-efuses
> +          - apple,t6000-efuses
> +      - const: apple,efuses
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    efuse@3d2bc000 {
> +        compatible = "apple,t8103-efuses", "apple,efuses";
> +        reg = <0x3d2bc000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        ecid: efuse@500 {
> +              reg = <0x500 0x8>;

Mismatched indentation. Rest looks good.

Best regards,
Krzysztof
