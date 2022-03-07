Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31634D000A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242876AbiCGN2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbiCGN2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:28:38 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11441EC4E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:27:43 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 528FD3F1C9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646659661;
        bh=0p+VuFDj8xL9U854Xhzlb2R5Iw4DSHVh49A3ct6TpJY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=T/6zZG5bBzY6FcHnpU7heMw7IvmqxCnWPDn0sQEruF6ZyzQGpXj2NtpGjW2FNw30A
         8cM7o3T6GRDjQSAEWfzrE9UHPzJ+SzvR16Fz2BUeX8QNNsczdVVrm6ZCQMr8q3hufc
         o2pBvOLfTfjk/XK+JvM6GW+vm1GDv0K3yMGrlLvoULDjQrEc4Fm6CK0Uv0RS1wZdMh
         zp0Q3ZNK4ylUXTIfQabdI8ArskcNv+6mMtTGeSu8+IiDXLrL8hj0E1TrQHMJPs6vjo
         kWIxaGXRZMSZzAugcvs75bo1WWSPCf/yX8/sc64x7oHaMEz8B9Usghk0ZcaPL8Nrrn
         xOivXom6iFMow==
Received: by mail-ed1-f69.google.com with SMTP id i17-20020aa7c711000000b00415ecaefd07so6241795edq.21
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0p+VuFDj8xL9U854Xhzlb2R5Iw4DSHVh49A3ct6TpJY=;
        b=UpSMW4cRj3zqq9pHDxEaiM/TcaBGAkVpaqrhoIqbe5nYWY/HfF7hqDSD61eDLYYFXG
         uPQ5f10qDvAKYCbvb4IOzMgpz64U2r/saYP5NGQbrdJ+/GIeTKUja4B6dIpJouunjTcD
         Ft1T4QElKCqoOoh/gK0dV8KR0KLMFXctqxg9fBmksqihBKB3PTV/rzynGf1uIIS3lKg7
         2oJXYkCAY9wD4qym7XSqSZ/siK4CF/J/oZ01LKydpAChh9lbIuxf0x5lXSYndxfEYBfb
         Tb5oMl/NQStD3UtE/M0NLk2xyzwWv4ilrP0FvUHlUiq9NBcOz5cGmfgs9ji9j46C24Pk
         JEpw==
X-Gm-Message-State: AOAM5310psmMEfOQW5vV5jCO5avz3vmol/fSnW2ZKSkmkOeYvspkCP6L
        5vyB62K4utbv/3Ny8zEp5em8/ruVZEaRZTDO+RZT1i8R9ITLpIwT3hPtMMKUhif+wmHBX6ySoTj
        Qv6nqMiV3aZbncpo50DPvi6sF8IvlsgTueEKA7IVEAw==
X-Received: by 2002:aa7:d708:0:b0:416:67d:5e07 with SMTP id t8-20020aa7d708000000b00416067d5e07mr11332747edq.166.1646659661048;
        Mon, 07 Mar 2022 05:27:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxROn5oRRrVhYMnIFfX1j+2EeerLJmDS9wAaPDjifZ9sXyeRLKRZqzm4A9FlkGfkFICnqDwaA==
X-Received: by 2002:aa7:d708:0:b0:416:67d:5e07 with SMTP id t8-20020aa7d708000000b00416067d5e07mr11332734edq.166.1646659660859;
        Mon, 07 Mar 2022 05:27:40 -0800 (PST)
Received: from [192.168.0.142] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906b10500b006ce6fa4f510sm4707518ejy.165.2022.03.07.05.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:27:40 -0800 (PST)
Message-ID: <060968dc-9460-1b75-12a7-cb0bbe9563cc@canonical.com>
Date:   Mon, 7 Mar 2022 14:27:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT5190A PMIC
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1646647704-2331-1-git-send-email-u0084500@gmail.com>
 <1646647704-2331-2-git-send-email-u0084500@gmail.com>
 <1e6893ca-69f4-a2ed-6ecc-23507c04002b@canonical.com>
 <CADiBU3_jC_+P4d-gjMRGpP0uBejUkCY-axNd4nh1Y_=95iav3A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CADiBU3_jC_+P4d-gjMRGpP0uBejUkCY-axNd4nh1Y_=95iav3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 14:21, ChiYuan Huang wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> 於 2022年3月7日 週一 下午7:14寫道：
>>
>> On 07/03/2022 11:08, cy_huang wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> Add bindings for Richtek RT5190A PMIC.
>>>
>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>> ---
>>>  .../regulator/richtek,rt5190a-regulator.yaml       | 138 +++++++++++++++++++++
>>>  1 file changed, 138 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
>>> new file mode 100644
>>> index 00000000..b9f5836
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
>>> @@ -0,0 +1,138 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/regulator/richtek,rt5190a-regulator.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Richtek RT5190A PMIC Regulator
>>> +
>>> +maintainers:
>>> +  - ChiYuan Huang <cy_huang@richtek.com>
>>> +
>>> +description: |
>>> +  The RT5190A integrates 1 channel buck controller, 3 channels high efficiency
>>> +  synchronous buck converters, 1 LDO, I2C control interface and peripherial
>>> +  logical control.
>>> +
>>> +  It also supports mute AC OFF depop sound and quick setting storage while
>>> +  input power is removed.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - richtek,rt5190a
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  vin2-supply:
>>> +    description: phandle to buck2 input voltage.
>>> +
>>> +  vin3-supply:
>>> +    description: phandle to buck3 input voltage.
>>> +
>>> +  vin4-supply:
>>> +    description: phandle to buck4 input voltage.
>>> +
>>> +  vinldo-supply:
>>> +    description: phandle to ldo input voltage
>>> +
>>> +  richtek,buck1-fixed-microvolt:
>>> +    description: buck1 fixed voltage that depends on the external resistor.
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>
>> You should use standard bindings for it.
>>
> Sorry, I didn't get the point for the meaning 'standard binding'.
> Do you mean to change 'richtek,buck1-fixed-microvolt' or 'uint32' definition?
> This voltage depends on the external resistor selection. It's 'fixed'
> by the application.

I meant that you should not have dedicated binding to set regulator
voltage, but use regulator-min/max-microvolt instead, within one
regulator node. Just set min/max to same level and handle it in the
driver. See for example:
drivers/regulator/scmi-regulator.c


Best regards,
Krzysztof
