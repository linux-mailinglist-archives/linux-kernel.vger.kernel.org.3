Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB184AD437
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352702AbiBHI7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbiBHI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:59:30 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3822EC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:59:30 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EA50F3F32B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644310768;
        bh=5BAaisfFdzHM2Ej8w1LBO0wtundXTJbEqkB562uWwIw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PPhUaRVWR5LkrD45qnRaZMftxs7fSWuJnOH5/YoWsKI+uckfHb4OJWuI6IxJZEy85
         odHf+fN5LxLjoAYAiFiSfCaL/u8Qe/1HuOEFjVXdqAY6edZHtZOMIuUd3cAHvzr6Il
         rOvHn3ao2TP3z/vdxBL/Q7ZilCkApkFNDmGv2s0La/iT7193ddjlerhxKtCKWi8LZ8
         pQHEsh/AiJvlFE9z6LFLNHflm5X36BsmuLUznAws26By5oVcsG/rnhJwLFxB/GnCmG
         e9WYX1lgFXmDuU8lsHgq2g6PcueEYykaxwmnIowpj+kNpfilMiVbxbOD1cZ5ni3y9Q
         cQJfF0pPVLx8Q==
Received: by mail-ed1-f72.google.com with SMTP id ee7-20020a056402290700b0040f680071c9so3278692edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5BAaisfFdzHM2Ej8w1LBO0wtundXTJbEqkB562uWwIw=;
        b=ss4ycnwdPeTFuhsgQclWN2pcNLsK9xYzK8rCR1WvacgEWJHV0Hojw5C0RsifAD2XWN
         F6RU76AhPG92k2N3/TyDQ54dW+oobUphldLhaDqCmGC9i2b34eJj07ZArwp+0gYQnLXH
         czc0cQ6XgpmDFwjf5exLAzZIsNv65K0+Q4cyAUZWOamiIy4NwHl01gxnaW09ChoM8wzg
         YShy32+ME+oQngH9PkcoI/WOFOPDbdQcZQA5hVsDA3im+hC5j5iyaYyru0QRgC5dODNB
         cTCaIr7Ec50xI5pf0aokcMikTXcuWaxjMfUJp0vGYURpLAEoM3EWF54sYrvSjP6XWLXn
         6Lvw==
X-Gm-Message-State: AOAM532DqKQ7OZvMzxmQL1Jd1rFQnAvKus5yD0V1jrFmVAojW1PIG/cT
        0du6t/ZidSRlvC8xQHyeb9e1/92LJVA/mNGa0vDKHH4a5+zNNqpMLzhVXw8lTEpBp9ax4v+il42
        b5/tzw71MjDjEQ9RDGm7XESr/PHlu1kYYEtZiAR9PHA==
X-Received: by 2002:a17:907:724c:: with SMTP id ds12mr2794451ejc.203.1644310768632;
        Tue, 08 Feb 2022 00:59:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8tPROloPqm9ioypm8COf+zuHFCcc0iwDjz584JUVDhpmreWZwcurlewohl71zVfFFpTKOZg==
X-Received: by 2002:a17:907:724c:: with SMTP id ds12mr2794429ejc.203.1644310768388;
        Tue, 08 Feb 2022 00:59:28 -0800 (PST)
Received: from [192.168.0.92] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id k14sm2187785ejg.78.2022.02.08.00.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 00:59:27 -0800 (PST)
Message-ID: <7b787aee-ceea-d035-38b1-02ba0bcd3f21@canonical.com>
Date:   Tue, 8 Feb 2022 09:59:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Content-Language: en-US
To:     Tudor.Ambarus@microchip.com, herbert@gondor.apana.org.au,
        robh+dt@kernel.org
Cc:     davem@davemloft.net, Nicolas.Ferre@microchip.com,
        Claudiu.Beznea@microchip.com, alexandre.belloni@bootlin.com,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220207032405.70733-1-tudor.ambarus@microchip.com>
 <20220207032405.70733-2-tudor.ambarus@microchip.com>
 <f8387f12-24f9-4a39-e9b8-3b83f1de078d@canonical.com>
 <ec358f0f-e3e2-a97b-e09a-d397edc65c72@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <ec358f0f-e3e2-a97b-e09a-d397edc65c72@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2022 05:10, Tudor.Ambarus@microchip.com wrote:
> Hi, Krzysztof,
> 
> On 2/7/22 17:56, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 07/02/2022 04:24, Tudor Ambarus wrote:
>>> Convert Atmel AES documentation to yaml format. With the conversion the
>>> clock and clock-names properties are made mandatory. The driver returns
>>> -EINVAL if "aes_clk" is not found, reflect that in the bindings and make
>>> the clock and clock-names properties mandatory. Update the example to
>>> better describe how one should define the dt node.
>>>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>> ---
>>>  .../devicetree/bindings/crypto/atmel,aes.yaml | 65 +++++++++++++++++++
>>>  .../bindings/crypto/atmel-crypto.txt          | 20 ------
>>>  2 files changed, 65 insertions(+), 20 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/crypto/atmel,aes.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/crypto/atmel,aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,aes.yaml
>>> new file mode 100644
>>> index 000000000000..f77ec04dbabe
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/crypto/atmel,aes.yaml
>>> @@ -0,0 +1,65 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/crypto/atmel,aes.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Atmel Advanced Encryption Standard (AES) HW cryptographic accelerator
>>> +
>>> +maintainers:
>>> +  - Tudor Ambarus <tudor.ambarus@microchip.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: atmel,at91sam9g46-aes
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    const: aes_clk
>>> +
>>> +  dmas:
>>> +    items:
>>> +      - description: TX DMA Channel
>>> +      - description: RX DMA Channel
>>> +
>>> +  dma-names:
>>> +    items:
>>> +      - const: tx
>>> +      - const: rx
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clocks
>>> +  - clock-names
>>> +  - dmas
>>> +  - dma-names
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/clock/at91.h>
>>> +    #include <dt-bindings/dma/at91.h>
>>
>> One empty line for readability.
> 
> Ok.
> 
>>
>>> +    aes: aes@f8038000 {
>>
>> Generic node name, so "crypto".
> 
> Hm, I'm not convinced why, would you please give more details about this
> requirement? This IP is capable of doing just AES operations, I find it
> generic enough. We use the "aes" name on all our SoCs that have a version
> of this IP, that would be quite a change. So I would prefer to keep the
> "aes" name if possible.
> 

The requirement comes from DT specification.
"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming
 model. If appropriate, the name should be one of the following choice"
AES is not generic. AES is specific crypto operation. The spec gives
example - "crypto", so use this one just like others are using. Atmel is
not special in that matter.


Best regards,
Krzysztof
