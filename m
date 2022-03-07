Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037F84D0128
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243165AbiCGO12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243161AbiCGO10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:27:26 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDCE8AE5B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:26:30 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 934353F5F7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646663188;
        bh=M9lN9abSajnPfvpxA50g+JnVREolCqYYcdlBq1xd/oY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=gVy4xOaDr3z5ZO8L2zvvZUOY0Bc9svn/a/E3KvtgL6SimBsqwuC+VW+4dJ8A2e3fZ
         /XP06S9nre8BvPhOh6SaJVnG0ahK/K1BBxV7QPRZKK4QzIrPuTUdDxD6Q0KnVLaMhN
         ggnGQXuovMcC6yHUjZOPW9M1k3r8jfW8uGE77KVWsRXuaENCqI8ly9s2Rz3KyqZwMq
         6OXjsG74ZWKjLmRiHBef+a7UdoCdb2MZH8T+c3MjWl/PX6AwDcf+iiEnlPfIa2/Se9
         ohp4N4iCpw7MRHfG1+VAnvjOcYxqUhJYQFtKThHh6TuZJBmd704eei4saB958YW9HH
         EdCEr5rgC7BnA==
Received: by mail-ed1-f69.google.com with SMTP id r8-20020aa7d588000000b00416438ed9a2so2249386edq.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M9lN9abSajnPfvpxA50g+JnVREolCqYYcdlBq1xd/oY=;
        b=76StYH3PmglNs4arhufF9P5rvClADvE6Yi1pZnU8BTofIidtmXoSYnU62UVFeUXzFf
         BjhracvtRNTKZXPxEfAgq4E1yJ2FnJIkPb2+OyC3+kUOKOS03wblSfh+vVpvyf+1LIla
         nflmR7rVL5uJI76C0rp/ISD+BTpwO4RnmO4d5ULA4GnhuLptO0dJdWd7jEaJUjgwFShv
         G86Vd4OcSLuk6hOEUT9KsRfY2mD8nZvf+JUdA1atXjEYZvz/QCmrYWce1b5PtDrFlEtw
         V1KQPniNLTi3mMprlSpqYGvTqHD1qObm/drS105pXx3pZ4rzkVfxTCgSfKDLOqQhwaKX
         1t5A==
X-Gm-Message-State: AOAM533alRY6+xZye7FE6GCrCGF5aXgwr1oiQgv8fzTFNNsKBb80gVSx
        E8SAUi6GA7Pm4WCIwdOhkHQV/JHYlr0XahI1bm2d4BCJvxo/HOkSZu3Vfj9miPakOxTgyJyRzph
        g52Ed7S5cb0nEvkA2j07aYiV1jEeCtvBpIAMyy2tiOA==
X-Received: by 2002:a17:907:6d82:b0:6d6:da31:e542 with SMTP id sb2-20020a1709076d8200b006d6da31e542mr9483005ejc.135.1646663186616;
        Mon, 07 Mar 2022 06:26:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjAB0RRBgu63JUgduj62zsOt237h8uUfdzN+dT68/lvHg7wZJfa1nlz7oKU5d6CvB2HK0udQ==
X-Received: by 2002:a17:907:6d82:b0:6d6:da31:e542 with SMTP id sb2-20020a1709076d8200b006d6da31e542mr9482991ejc.135.1646663186415;
        Mon, 07 Mar 2022 06:26:26 -0800 (PST)
Received: from [192.168.0.142] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id i21-20020a1709061cd500b006da62ab503csm4777989ejh.157.2022.03.07.06.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:26:25 -0800 (PST)
Message-ID: <293d27b4-004f-f816-23c9-3409d96ea20e@canonical.com>
Date:   Mon, 7 Mar 2022 15:26:25 +0100
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
 <060968dc-9460-1b75-12a7-cb0bbe9563cc@canonical.com>
 <CADiBU387CFZNGoxu1G_8P8a6oFE-QLMTiDDXKTc0rkOsgbi4bw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CADiBU387CFZNGoxu1G_8P8a6oFE-QLMTiDDXKTc0rkOsgbi4bw@mail.gmail.com>
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

On 07/03/2022 15:21, ChiYuan Huang wrote:
> HI, Krzysztof:
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> 於 2022年3月7日 週一 下午9:27寫道：
>>
>> On 07/03/2022 14:21, ChiYuan Huang wrote:
>>> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> 於 2022年3月7日 週一 下午7:14寫道：
>>>>
>>>> On 07/03/2022 11:08, cy_huang wrote:
>>>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>>>
>>>>> Add bindings for Richtek RT5190A PMIC.
>>>>>
>>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>>>> ---
>>>>>  .../regulator/richtek,rt5190a-regulator.yaml       | 138 +++++++++++++++++++++
>>>>>  1 file changed, 138 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
>>>>> new file mode 100644
>>>>> index 00000000..b9f5836
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
>>>>> @@ -0,0 +1,138 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/regulator/richtek,rt5190a-regulator.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Richtek RT5190A PMIC Regulator
>>>>> +
>>>>> +maintainers:
>>>>> +  - ChiYuan Huang <cy_huang@richtek.com>
>>>>> +
>>>>> +description: |
>>>>> +  The RT5190A integrates 1 channel buck controller, 3 channels high efficiency
>>>>> +  synchronous buck converters, 1 LDO, I2C control interface and peripherial
>>>>> +  logical control.
>>>>> +
>>>>> +  It also supports mute AC OFF depop sound and quick setting storage while
>>>>> +  input power is removed.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - richtek,rt5190a
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  vin2-supply:
>>>>> +    description: phandle to buck2 input voltage.
>>>>> +
>>>>> +  vin3-supply:
>>>>> +    description: phandle to buck3 input voltage.
>>>>> +
>>>>> +  vin4-supply:
>>>>> +    description: phandle to buck4 input voltage.
>>>>> +
>>>>> +  vinldo-supply:
>>>>> +    description: phandle to ldo input voltage
>>>>> +
>>>>> +  richtek,buck1-fixed-microvolt:
>>>>> +    description: buck1 fixed voltage that depends on the external resistor.
>>>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>>>
>>>> You should use standard bindings for it.
>>>>
>>> Sorry, I didn't get the point for the meaning 'standard binding'.
>>> Do you mean to change 'richtek,buck1-fixed-microvolt' or 'uint32' definition?
>>> This voltage depends on the external resistor selection. It's 'fixed'
>>> by the application.
>>
>> I meant that you should not have dedicated binding to set regulator
>> voltage, but use regulator-min/max-microvolt instead, within one
>> regulator node. Just set min/max to same level and handle it in the
>> driver. See for example:
>> drivers/regulator/scmi-regulator.c
>>
> As I know, regulator-min/max-microvolt is used as the usage constraint.

True, bindings mention the consumers, but I don't think this is treated
literally.

> 
> But out buck1/buck4/ldo vout is defined by
> Vout = VFb * (1 + R1/R2) where R1/R2 is chosen by the circuit design.
> 
> It seems not similar with the scmi-regulator.
> 
> Do you really suggest to use regulator-min/max-microvolt????

The same as existing fixed-regulator. Why this regulator should be
different than fixed-regulator?

Best regards,
Krzysztof
