Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A804DC01C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiCQH2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiCQH16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:27:58 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EBC1C16DC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:26:40 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E3D8A3F366
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647501997;
        bh=ghNz7R4BGfeSRpf4QcIYnWTSvV5jI5ENR9wPPc5DGEw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=D6hMMPtho+Q1KIKx7adXE4EIZassueyz+XFtkeV6tc6Qnw0rJKR9iRWjGJdl8iWHg
         N766DWkJYEFMbvAvnwokTW7pIH4dC5ffv3/YIqzOvgIDHMvXHRZSeUBL3Xdzgj0VKX
         jzi/0elzfyVESukJOn0QQTA3mn6/d9mqHQL5rqSfYNNkNXBAfMBA52kqUCjDGkzgOv
         GPU5qwQH47BATIai5PFJ3yL85POOWiavxeTQEQ/d6/MIxYtbvrJmxhdtHG4hzqPkaK
         MiO3Kxp5hdn9o5TSJ7gHYQFGq9fq6k95EPC/0cDKFJCZhERu4zdVgSxuvnK2fkL2xr
         jGMLE9jZgUwNg==
Received: by mail-wm1-f70.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so1803563wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ghNz7R4BGfeSRpf4QcIYnWTSvV5jI5ENR9wPPc5DGEw=;
        b=VL5eMhHsoFWxF2u1FqWKpxJhqyGkNGfwPyKNYeZanQDnObANPWvWLTh4ONjlS+bvcR
         GHkGDo5mE+NQh9MAU2PnCe+UuBZn+4gb196wPQotSFKThQMi1iDPOd5yR1xWaXU7afFG
         khrYGBbxdFNVmO2AWhXmvSknb9evkvsmvQwCgMO1CmRyHouoejjYRZis+zgR4KdTNBvL
         S+wT8MmJfHamL1Fe302ewRpruyUMB0DZLJkM8wZLzInFghIzI274gOl61JpUCHbztMds
         SBQ1vVSuG7G8xJB5Tgw5d9VBeCZaY1SwILffFlnXtGna7sJJGrXz6r/H8Kx5kMrTF24P
         8w1A==
X-Gm-Message-State: AOAM532vgeD1Bg7wOZrW2Z9aQPZ4M5Sl0yQZVdpoTLwHmevI5u5LXU4M
        kkb9Ui3+j+HBnq8h4qnAZ3JMFNAG95R8rQGfyX0lMOzKlPjbh8QJQKoMDhmfUy5ezZVkA5HAi1e
        teh4ihbEUxoq7NeX2KN5OKgUqhC9sGoCYQ1anZgHorg==
X-Received: by 2002:a5d:6182:0:b0:203:ecfb:6d5e with SMTP id j2-20020a5d6182000000b00203ecfb6d5emr826498wru.555.1647501997313;
        Thu, 17 Mar 2022 00:26:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXUvFXzXTNB1+s0MST5P6b3GxTO5cqxsPLl8NjBFb0wBvzAZuUPRWZ20My4isFC+iYaqWujw==
X-Received: by 2002:a5d:6182:0:b0:203:ecfb:6d5e with SMTP id j2-20020a5d6182000000b00203ecfb6d5emr826481wru.555.1647501997039;
        Thu, 17 Mar 2022 00:26:37 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id k17-20020a05600c1c9100b00386bb6e9c50sm10966353wms.45.2022.03.17.00.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 00:26:36 -0700 (PDT)
Message-ID: <4b1f4772-35f9-3e21-6429-b64c7427144a@canonical.com>
Date:   Thu, 17 Mar 2022 08:26:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/8] dt-bindings: pinctrl: mvebu: Document bindings for
 AC5
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220314213143.2404162-1-chris.packham@alliedtelesis.co.nz>
 <20220314213143.2404162-2-chris.packham@alliedtelesis.co.nz>
 <4e6df448-5562-8f50-6f46-91acb279bc1a@canonical.com>
 <7e73bba0-8b54-772c-2e94-8fca4e4e3294@alliedtelesis.co.nz>
 <cb0af80e-3e5a-fbd9-cd8b-7b252ebe33fe@canonical.com>
 <6d902e7d-b71f-9dcd-9175-cc706e3d60cc@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <6d902e7d-b71f-9dcd-9175-cc706e3d60cc@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 21:21, Chris Packham wrote:
> 
> On 16/03/22 21:16, Krzysztof Kozlowski wrote:
>> On 15/03/2022 22:12, Chris Packham wrote:
>>> (trimmed cc list to the arm, pinctrl and dt people)
>>>
>>> On 15/03/22 23:46, Krzysztof Kozlowski wrote:
>>>> On 14/03/2022 22:31, Chris Packham wrote:
>>>>> Add JSON schema for marvell,ac5-pinctrl present on the Marvell 98DX2530
>>>>> SoC.
>>>>>
>>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>>> ---
>>>>>
>>>>> Notes:
>>>>>       Changes in v2:
>>>>>       - Remove syscon and simple-mfd compatibles
>>>>>
>>>>>    .../bindings/pinctrl/marvell,ac5-pinctrl.yaml | 70 +++++++++++++++++++
>>>>>    1 file changed, 70 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..65af1d5f5fe0
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
>>>>> @@ -0,0 +1,70 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://scanmail.trustwave.com/?c=20988&d=1pyx4kv4KTrTfE5fXNs54mLZmOgk87Uim6CXu-YC1w&u=http%3a%2f%2fdevicetree%2eorg%2fschemas%2fpinctrl%2fmarvell%2cac5-pinctrl%2eyaml%23
>>>>> +$schema: http://scanmail.trustwave.com/?c=20988&d=1pyx4kv4KTrTfE5fXNs54mLZmOgk87Uim6TAvbEE2Q&u=http%3a%2f%2fdevicetree%2eorg%2fmeta-schemas%2fcore%2eyaml%23
>>>>> +
>>>>> +title: Marvell AC5 pin controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>>> +
>>>>> +description:
>>>>> +  Bindings for Marvell's AC5 memory-mapped pin controller.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: marvell,ac5-pinctrl
>>>>> +
>>>>> +patternProperties:
>>>>> +  '-pins$':
>>>>> +    type: object
>>>>> +    $ref: pinmux-node.yaml#
>>>>> +
>>>>> +    properties:
>>>>> +      marvell,function:
>>>>> +        $ref: "/schemas/types.yaml#/definitions/string"
>>>>> +        description:
>>>>> +          Indicates the function to select.
>>>>> +        enum: [ gpio, i2c0, i2c1, nand, sdio, spi0, spi1, uart0, uart1, uart2, uart3 ]
>>>>> +
>>>>> +      marvell,pins:
>>>>> +        $ref: /schemas/types.yaml#/definitions/string-array
>>>>> +        description:
>>>>> +          Array of MPP pins to be used for the given function.
>>>>> +        minItems: 1
>>>>> +        items:
>>>>> +          enum: [ mpp0, mpp1, mpp2, mpp3, mpp4, mpp5, mpp6, mpp7, mpp8, mpp9,
>>>>> +                  mpp10, mpp11, mpp12, mpp13, mpp14, mpp15, mpp16, mpp17, mpp18, mpp19,
>>>>> +                  mpp20, mpp21, mpp22, mpp23, mpp24, mpp25, mpp26, mpp27, mpp28, mpp29,
>>>>> +                  mpp30, mpp31, mpp32, mpp33, mpp34, mpp35, mpp36, mpp37, mpp38, mpp39,
>>>>> +                  mpp40, mpp41, mpp42, mpp43, mpp44, mpp45 ]
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: "pinctrl.yaml#"
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    system-controller@80020100 {
>>>>> +      compatible = "syscon", "simple-mfd";
>>>>> +      reg = <0x80020000 0x20>;
>>>> This is unusual. Usually the pinctrl should be a device @80020100, not
>>>> child of syscon node. Why do you need it? In v1 you mentioned that
>>>> vendor sources do like this, but it's not correct to copy wrong DTS. :)
>>> The vendor dts has this
>>>
>>>           pinctrl0: pinctrl@80020100 {
>>>               compatible = "marvell,ac5-pinctrl",
>>>                        "syscon", "simple-mfd";
>>>               reg = <0 0x80020100 0 0x20>;
>>>               i2c_mpps: i2c-mpps {
>>>                   marvell,pins = "mpp26", "mpp27";
>>>                   marvell,function = "i2c0-opt";
>>>               };
>>>        };
>>>
>>> Rob pointed out that "syscon", "simple-mfd" don't belong. I went looking
>>> and found marvell,armada-7k-pinctrl which has the pinctrl as a child of
>>> a syscon node and what you see in v2 is the result.
>>>
>>> I probably went a bit too far off the deep end and should have just
>>> dropped the "syscon", "simple-mfd" compatibles. I even wrote that
>>> version but decided to add some gold plating before I submitted it.
>> More or less it is explained in
>> Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt why
>> armada-7k uses it that way. The pinctrl is part of system registers
>> which apparently has to be shared with others (on shared SFR range).
>>
>> It depends on your case, your SFR ranges for pinctrl and other blocks.
>>
> I can tell you that without a syscon node in the mix somewhere the 
> driver will fail to load. And when I switch to 
> mvebu_pinctrl_simple_mmio_probe() the driver loads but then kernel 
> panics when something tries to use one of the pin functions.
> 
> So I think the syscon is needed. I just need to come up with a better 
> justification than "because it's needed".

What do you mean "driver fails to load"? You control the driver, don't
you? You wrote it? If you write a driver which is not compatible with
bindings, it won't work obviously, so after changing bindings you need
to revisit the driver.

There is no need for syscon because driver "fails to load". You need to
fix your driver. Currently the driver code is definitely not a proper
platform driver.

Different question is whether something else requires here syscon
because it accesses these registers but this requires knowledge of
architecture and other components.


Best regards,
Krzysztof
