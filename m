Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7B64AD660
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357993AbiBHLYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355836AbiBHJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:55:40 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DD0C03FEC3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:55:39 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2E6044003D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644314138;
        bh=Szjo/xn7L6v0v/D7OiLOigwEC075JGBmQohH09dmhBU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=rIhIhYYP5Ia2Lftk+OtmnNwLCoQIHJK3aVhbxW9Y5tepleufIvhiT2o4oZr0NYFTn
         UVCqMWy7F/J08LJzPAxJOcT5SeU6mc9bl120A0i5mgsEEmj9P58deqWmzr4kcAyd4D
         AVzHAhRkyZEb64SuKj16l8zp7grQVfdG4Cy8UZfqJUJ9mLxARZk+Zbvkgv/L78UEXc
         DGJDZHc4P4QJUzBo4BjqjqRalcVPSbLGnGppLnSObLfh0VFdFwUP0j6WWS5r/eujEF
         nfiE3bB1oh6p2HxehKJqiGJozzDo8otsqR8bwMw0RRbxKDofq9pr/uB3txBNRI5w16
         v6BxgJ4LpYNlA==
Received: by mail-ej1-f70.google.com with SMTP id ky6-20020a170907778600b0068e4bd99fd1so5505028ejc.15
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Szjo/xn7L6v0v/D7OiLOigwEC075JGBmQohH09dmhBU=;
        b=m54sV+f9Bb8JSGDR3oFezvJ33VAUs9A7iy2eFoKFp4PsZzs+POdjGtCS2Yaqy2sdAA
         D8l7OZBdx7/4S8MKQQ0LbpUlsKBkb+q8Z6FE5QMtfyAREMZy2YWfQUZ2C7TD5hWGVFaS
         qNSiJxr9AFPC1OP3lADxUBcaLIHP29dkvPGH9WQ6czr4w0aLYwIqAg+h4xYmtnvncxzl
         yxYUJRZINDlDFRBvpMD3oJH8z+9JC7fXQgHrDry2uBsF8RxpBiU9NYrXCN9ZuuniY66R
         QWmm/SBF7QSayfhCVQC1/dA/pcHYYtF1rppTWx6nLQWX/72bJjwALA2X3sSs1diPWwvB
         OASA==
X-Gm-Message-State: AOAM531ReFAJZF7kX9QL/KfHReka4XkSk8hXsQiuHlJ9ijxLn7nmMcno
        g3jWGmtsRK26ahSOShIXT1WJgA7nBoKb8j0yiO5vyWBirid9uWaSvFEV9x5LCm8s057hawpLu2b
        hpGkS7uYKcHo75bzea+Yj4AfTlA02OdaBztO0AD3+OQ==
X-Received: by 2002:a17:906:4999:: with SMTP id p25mr2962923eju.605.1644314136760;
        Tue, 08 Feb 2022 01:55:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6Iu0J7lv26V4wjpXecuQJTMEHXlN1Y9pJES2wkCc04GRpLkPji9H4FKt//tjuDuor1d/XWA==
X-Received: by 2002:a17:906:4999:: with SMTP id p25mr2962902eju.605.1644314136538;
        Tue, 08 Feb 2022 01:55:36 -0800 (PST)
Received: from [192.168.0.93] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r22sm4593859ejo.48.2022.02.08.01.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 01:55:36 -0800 (PST)
Message-ID: <82f120fc-1bc5-29ee-2a02-ca1fba308de3@canonical.com>
Date:   Tue, 8 Feb 2022 10:55:35 +0100
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
 <7b787aee-ceea-d035-38b1-02ba0bcd3f21@canonical.com>
 <eba691b4-e75f-f3ca-5359-9dc8b3bd3558@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <eba691b4-e75f-f3ca-5359-9dc8b3bd3558@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2022 10:49, Tudor.Ambarus@microchip.com wrote:
> On 2/8/22 10:59, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 08/02/2022 05:10, Tudor.Ambarus@microchip.com wrote:
>>> Hi, Krzysztof,
>>>
>>> On 2/7/22 17:56, Krzysztof Kozlowski wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> On 07/02/2022 04:24, Tudor Ambarus wrote:
>>>>> Convert Atmel AES documentation to yaml format. With the conversion the
>>>>> clock and clock-names properties are made mandatory. The driver returns
>>>>> -EINVAL if "aes_clk" is not found, reflect that in the bindings and make
>>>>> the clock and clock-names properties mandatory. Update the example to
>>>>> better describe how one should define the dt node.
>>>>>
>>>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>>>> ---
>>>>>  .../devicetree/bindings/crypto/atmel,aes.yaml | 65 +++++++++++++++++++
>>>>>  .../bindings/crypto/atmel-crypto.txt          | 20 ------
>>>>>  2 files changed, 65 insertions(+), 20 deletions(-)
>>>>>  create mode 100644 Documentation/devicetree/bindings/crypto/atmel,aes.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/crypto/atmel,aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,aes.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..f77ec04dbabe
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/crypto/atmel,aes.yaml
>>>>> @@ -0,0 +1,65 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/crypto/atmel,aes.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Atmel Advanced Encryption Standard (AES) HW cryptographic accelerator
>>>>> +
>>>>> +maintainers:
>>>>> +  - Tudor Ambarus <tudor.ambarus@microchip.com>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: atmel,at91sam9g46-aes
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clocks:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clock-names:
>>>>> +    const: aes_clk
>>>>> +
>>>>> +  dmas:
>>>>> +    items:
>>>>> +      - description: TX DMA Channel
>>>>> +      - description: RX DMA Channel
>>>>> +
>>>>> +  dma-names:
>>>>> +    items:
>>>>> +      - const: tx
>>>>> +      - const: rx
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - interrupts
>>>>> +  - clocks
>>>>> +  - clock-names
>>>>> +  - dmas
>>>>> +  - dma-names
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>> +    #include <dt-bindings/clock/at91.h>
>>>>> +    #include <dt-bindings/dma/at91.h>
>>>>
>>>> One empty line for readability.
>>>
>>> Ok.
>>>
>>>>
>>>>> +    aes: aes@f8038000 {
>>>>
>>>> Generic node name, so "crypto".
>>>
>>> Hm, I'm not convinced why, would you please give more details about this
>>> requirement? This IP is capable of doing just AES operations, I find it
>>> generic enough. We use the "aes" name on all our SoCs that have a version
>>> of this IP, that would be quite a change. So I would prefer to keep the
>>> "aes" name if possible.
>>>
>>
>> The requirement comes from DT specification.
>> "The name of a node should be somewhat generic, reflecting the function
>> of the device and not its precise programming
>>  model. If appropriate, the name should be one of the following choice"
>> AES is not generic. AES is specific crypto operation. The spec gives
>> example - "crypto", so use this one just like others are using. Atmel is
>> not special in that matter.
>>
> I see, thanks for the explanation. I will put the node name as "crypto", and add
> a label to it as "aes":
> aes: crypto@f8038000 {
> 

That's fine (label naming doesn't matter). You don't have to change all
your DTS files with the new node name, although at some point it could
be required.

For some other bindings in different subsystems, the node name pattern
is now enforced by dtschema (git grep -C 1 -E
'(nodename|patternProperties)' -- Documentation/devicetree/bindings/).

Best regards,
Krzysztof
