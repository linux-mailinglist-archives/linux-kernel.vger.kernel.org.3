Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C739596918
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiHQF6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiHQF6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:58:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C31CE32
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:58:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l21so12600073ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=aUqumd66SBJ39SQ3AQf1bxB+pDEZwaoNVNdZ68RDANQ=;
        b=KugdImXnAzARq3XArw/RJ1XvgROZaBH7VwG7f/JODTd34gv3CP7Q6S/kLHs/IXgjEI
         ApyJJhBMk/DnCp9GlK43L6vlNDIwBy1sPqMDHrqiPpkcEsXl3THPf4Tx6nkAWfK4fUuT
         5r1x6Ra9qMPhJkdCIMcsYYwAJqaflI7XlTBOSmVCs3ljdj2TBJlshROFdrGYXmM9vChi
         z+IxD4ChR6X0ARD2yhHnt2lrGDXjx4JsEfa38pcUUMfObcbXvbW3mvnZoqIxV3n9hxqr
         qoycpbNFXKbwDiAJ+Q03t+knl3bVkb7s9PA66juKu7ZyVonP4z+NMYy9KVn9sC19sr2I
         mdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=aUqumd66SBJ39SQ3AQf1bxB+pDEZwaoNVNdZ68RDANQ=;
        b=yJOEsVGAGsw4/RDPwV0iXLFREcrLxB30flFBiKJ1e9POT+0gJXBrc9hYag0Dv5lwQx
         rr2RN7e98uSsEmUndLbEZfptYDT5HzVEycGG9NhcLPs7sQcwHLQMskXYdYXtFmHtZXFY
         wasnM/tlFNReU0uppqKDLOLYo4FQ7IfcThV+ww5Dv9AFscp6OzCJFZf9iODKUiSLO8EB
         IO5kL3zBi8KOahtYZsQc4Xbmuygq7d45EpOVcTpU1Vx2lfPKLexldHs4tJJAjguT3lOp
         NLOR9YLfxRTLFwNeygWvfO3/VI6/QuPjEQqr17rD/g6611yOuT+neG1KMQ7Kn2kNzJQ9
         tj6Q==
X-Gm-Message-State: ACgBeo1O7ygyM/BACR5L46qXaBAOWe5QXmaBUIgQ+Un9Mvu4dVXpPK7J
        yBgEU6qHd8F2hv8imE1MnWFQSQ==
X-Google-Smtp-Source: AA6agR43LFwAtzNImS4Lf1YJ09vjOKuLkdHqLccVESB33RuJQHJw1t9kIoZyBH9wImctlf0H6BEYnQ==
X-Received: by 2002:a2e:b892:0:b0:25f:db66:3b86 with SMTP id r18-20020a2eb892000000b0025fdb663b86mr7820287ljp.79.1660715886520;
        Tue, 16 Aug 2022 22:58:06 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1b1c:14b7:109b:ed76? (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id v13-20020a056512348d00b0048a835a60f6sm1571181lfr.251.2022.08.16.22.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 22:58:06 -0700 (PDT)
Message-ID: <f07d2072-4056-bf2e-82d5-271d8b8792e6@linaro.org>
Date:   Wed, 17 Aug 2022 08:58:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC v4 01/10] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm-dw-apb-timers-pwm2
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-2-ben.dooks@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220816211454.237751-2-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 00:14, Ben Dooks wrote:
> Add documentation for the bindings for Synopsys' DesignWare PWM block
> as we will be adding DT/platform support to the Linux driver soon.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v4:
>  - fixed typos, added reg
> v3:
>  - add description and example
>  - merge the snps,pwm-number into this patch
>  - rename snps,pwm to snps,dw-apb-timers-pwm2
> v2:
>  - fix #pwm-cells to be 3
>  - fix indentation and ordering issues
> ---
>  .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> new file mode 100644
> index 000000000000..e7feae6d4404
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 SiFive, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/snps,dw-apb-timers-pwm2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DW-APB timers PWM controller
> +
> +maintainers:
> +  - Ben Dooks <ben.dooks@sifive.com>
> +
> +description:
> +  This describes the DesignWare APB timers module when used in the PWM
> +  mode. The IP core can be generated with various options which can
> +  control the functionality, the number of PWMs available and other
> +  internal controls the designer requires.
> +
> +  The IP block has a version register so this can be used for detection
> +  instead of having to encode the IP version number in the device tree
> +  comaptible.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: snps,dw-apb-timers-pwm2
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  clocks:
> +    items:
> +      - description: Interface bus clock
> +      - description: PWM reference clock
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: timer
> +
> +  snps,pwm-number:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The number of PWM channels configured for this instance
> +    enum: [1, 2, 3, 4, 5, 6, 7, 8]
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - "#pwm-cells"
> +  - compatible
> +  - reg

Keep the same order as list of properties.

> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +

Just one blank line.

> +examples:
> +  - |
> +    pwm: pwm@180000 {
> +      #pwm-cells = <3>;
> +      compatible = "snps,dw-apb-timers-pwm2";
> +      reg = <0x180000 0x200>;

The convention of DTS is: compatible, then reg, then rest of properties.

> +      clocks = <&bus &timer>;

You put here one item, not two. This has to be <&bus>, <&timer>

> +      clock-names = "bus", "timer";
> +    };


Best regards,
Krzysztof
