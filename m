Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59664C5A94
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiB0LDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiB0LDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:03:14 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A82BF47
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 03:02:36 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 36C983FCAC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645959755;
        bh=RXUmSRm1O1VoA9wS7MAMGWoCbD7WOkk+zqEQ16+dydg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=l6WSRCryKsOmT77rOjXQSiMoDDR8OTmBNyXErp93OEsHZHMdqHAqTF/CI8vG1Wh7h
         f4HH5OsH1lltbbvWPZOdmnsMa2WQVgtbyVWEgQfSJOqc21SJmqYCsGZUffMmmmwdQh
         umnPckaaMDsvCBL6Eh5NZVVlbQ4QJAfSed8zqNj92umzprSKAg36VaZKs01cVqXXd9
         fSbDEEEqqM+cgqupXN1MItg/VH15ihaAVSmVtmKrQXQtqUB645EgIG3b4KggT+Ogqc
         m13hTlk1KFSpEuWH6CAv+f7U+J/IclVVRT3avc7DH8AgPMK0nta3Fk7jkd54yWGUTf
         bdOSSPd1kp7nA==
Received: by mail-ej1-f70.google.com with SMTP id kw5-20020a170907770500b006ba314a753eso4334566ejc.21
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 03:02:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RXUmSRm1O1VoA9wS7MAMGWoCbD7WOkk+zqEQ16+dydg=;
        b=ZGAA96pYmzz33fA1HwbAopXTmjKZmo/zJ+Zw6JcWIjj7aAZ3XngQ33uCdzDGvIdRV3
         M0DRtpkufhn4p2u8E51G9ZaY3MfMxObzCdp70KpSw01nQsWLbY2rsT34CkMYfvEUNfXV
         KnQBtcPt3VWgjYKgGCvqsG3QmI6/wSAt/CL8C7AP87hALop+noLKsSvat8TLUGOhhWGT
         CFDEjLjt+ZmdFvsWkIs0TeFFjKjgY+HUkk4tVkpoAQfcIjZMe4hV3YsSlRIJWqKHUO80
         q0Ia0qtUPKZ48JQdMDiG0HhdzW8VwzeUsZyWmsWicHP/odjDanOqyFqSW9SdBeiLgwyS
         DVIw==
X-Gm-Message-State: AOAM5337bkRyk9FQDVGOC2YvdjKq9bl3Uz5HvSOgVm4Iu8zgeCXk8AjZ
        v2ajntG2hN4CVBBKhiTBPC1rW1aw+uT8jcBbyRlp5ZwTHPQkckzG2a3cRoUhGLBxVSWoGNe8rRh
        HxMuA4kLrAYqRdMVo4M+KUvjFc+ElXdBmUbic0rcOig==
X-Received: by 2002:a05:6402:2790:b0:412:8379:f248 with SMTP id b16-20020a056402279000b004128379f248mr14812878ede.285.1645959754636;
        Sun, 27 Feb 2022 03:02:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOM38cLX4uJ8ipUpfRHTzICOBLEWeXU+W9FDRpLDjRd8H4IszimlckdjrXsnhAtzX8cIRIrQ==
X-Received: by 2002:a05:6402:2790:b0:412:8379:f248 with SMTP id b16-20020a056402279000b004128379f248mr14812867ede.285.1645959754460;
        Sun, 27 Feb 2022 03:02:34 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id lx9-20020a170906af0900b006d0d3179e11sm3245068ejb.105.2022.02.27.03.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 03:02:33 -0800 (PST)
Message-ID: <1924a900-20db-93b5-4f9b-37a56467f7e8@canonical.com>
Date:   Sun, 27 Feb 2022 12:02:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 2/3] dt-bindings: edac: npcm-edac.yaml
Content-Language: en-US
To:     Medad CChien <medadyoung@gmail.com>, rric@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, mchehab@kernel.org,
        bp@alien8.de, robh+dt@kernel.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        Medad CChien <ctcchien@nuvoton.com>
References: <20220224074729.5206-1-ctcchien@nuvoton.com>
 <20220224074729.5206-3-ctcchien@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220224074729.5206-3-ctcchien@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2022 08:47, Medad CChien wrote:
> Add the device tree bindings for the EDAC driver npcm-edac.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  .../devicetree/bindings/edac/npcm-edac.yaml   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/npcm-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/npcm-edac.yaml b/Documentation/devicetree/bindings/edac/npcm-edac.yaml
> new file mode 100644
> index 000000000000..228ace1025dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/npcm-edac.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/npcm-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM Memory Controller EDAC
> +
> +maintainers:
> +  - Medad CChien <ctcchien@nuvoton.com>
> +
> +description: |
> +  EDAC node is defined to describe on-chip error detection and correction for
> +  Nuvoton NPCM Memory Controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm8xx-edac
> +      - nuvoton,npcm7xx-edac
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2

Why do you need it? There are no children nodes allowed.

> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: uncorrectable error interrupt
> +      - description: correctable error interrupt
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: ue
> +      - const: ce
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    ahb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        mc: memory-controller@f0824000 {
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            reg = <0x0 0xf0824000 0x0 0x1000>;
> +            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +            compatible = "nuvoton,npcm7xx-edac";

First compatible, then reg, then the rest, please.

> +        };
> +    };
> +


Best regards,
Krzysztof
