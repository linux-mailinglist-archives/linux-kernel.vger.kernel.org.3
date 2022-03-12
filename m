Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D634D6DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 11:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiCLKYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 05:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiCLKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:24:48 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0D663531
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:23:22 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BACDE3F60E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647080600;
        bh=xDCJmkuolk+37CRthskXGD5BwRwajHEJ6ASCw/gpw94=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=mEWZmVT6h+ici+6Gy60hl2LX9D/dfEf/amdLJBLfwyExj/vIYR7erTk5gW0bhaiN/
         qDcBOZjq0GPl6W2RewK6fE1TPGr0Buw6z2081gF97oJ/LH2mB6UhthLtIjpuzryt3E
         PifLQEivOncia3yiET25uWcfWHntadbL1JZyLGCpglCn2nDNiNkzELYxgm9gsA0xD5
         CwNG9iHkxLeOYZphlUvSn7l8Xr2Ty5qxCGHbKB8s1djbn7pu5MDH6WuQVFVZZuRBuy
         +s6hYMNWPqQK7HbYY8A1az4gw/i8hG2Hi19vDKuu/J8m5B0eSgs1kfucep5jRg2Xw6
         GAJVtVu5p1b9w==
Received: by mail-wm1-f69.google.com with SMTP id n62-20020a1ca441000000b0038124c99ebcso3478326wme.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xDCJmkuolk+37CRthskXGD5BwRwajHEJ6ASCw/gpw94=;
        b=DUafG/9sLTJ6quDELjEwH7K/H/1glLjYzaTi7B9YYIFAz2oyaNNS0IWQEfRrSs2F1o
         maT3oPFZv1NUbioUqrxqNJD0fwnoUAVcOJePlTyBiOJH4TRoXrzWTPUKEY+Wwoi71VhN
         4Sjf5k6IVmo529PZybz2f15sTaPspd5taaZLsPejObAPZ/gorQCsTwTQibzWe1H1naR+
         M/5XuoDHFH3dpeZJTcopQbJU5Iu/bn08osA4eFVOYzAdJ3vkjLnGZXsg2cISrLxB3ap5
         ZeFzOpcP+dtCrxlXN3mmiTLNjHhITaPbDgPxVPagVcJ2QpxiLfF5VfiPHiKM8g7jEgkl
         RGXw==
X-Gm-Message-State: AOAM530D0iGP9kT8/+uw1QS6cAoDtOHsHWPC8NNQGQfDMECbgzkOhlN2
        zLWzY3e99IEsCaBzOMn9o8H4wVgb4sP8lIBdFzqAhpIpBxX2nArSfI3/YU2EbE4m0KxJ535xbln
        sklzELdLFpuTBye3oYlhwbHMqz+Jk4f35SoTe5sJYJA==
X-Received: by 2002:a5d:55c5:0:b0:1f0:7672:637d with SMTP id i5-20020a5d55c5000000b001f07672637dmr10456071wrw.170.1647080600303;
        Sat, 12 Mar 2022 02:23:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFIGW8or/HGHeWCNJyi2pEy+yZaNExUDX0cSktJR/WW3PJOCLqu9GeD9VB0AwoAH5nNBQyPA==
X-Received: by 2002:a5d:55c5:0:b0:1f0:7672:637d with SMTP id i5-20020a5d55c5000000b001f07672637dmr10456048wrw.170.1647080600043;
        Sat, 12 Mar 2022 02:23:20 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id r5-20020a5d4945000000b001f06372fa9fsm13157691wrs.54.2022.03.12.02.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 02:23:19 -0800 (PST)
Message-ID: <e0da4fbc-b72c-60a0-5a5f-99d18653c294@canonical.com>
Date:   Sat, 12 Mar 2022 11:23:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/3] ARM: dts: lpc32xx: Update spi clock properties
Content-Language: en-US
To:     Vladimir Zapolskiy <vz@mleia.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
 <20220311093800.18778-4-singh.kuldeep87k@gmail.com>
 <4aae560d-d266-d0d0-136f-32891b15bc01@mleia.com>
 <CAK8P3a3a_WXbDKN-jJUt_Wuvop0rfaUs4ytwyhogOxdtJAPx0w@mail.gmail.com>
 <4f39f086-1932-1729-8761-d5c533356812@mleia.com>
 <2f53f17a-427c-62d6-a0c6-4a3962ab01f0@canonical.com>
 <9f4e3cdc-f5e2-7102-949e-7b3032118e63@mleia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <9f4e3cdc-f5e2-7102-949e-7b3032118e63@mleia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2022 22:26, Vladimir Zapolskiy wrote:
> On 3/11/22 4:33 PM, Krzysztof Kozlowski wrote:
>> On 11/03/2022 15:07, Vladimir Zapolskiy wrote:
>>> On 3/11/22 3:38 PM, Arnd Bergmann wrote:
>>>> On Fri, Mar 11, 2022 at 2:20 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
>>>>>
>>>>> On 3/11/22 11:38 AM, Kuldeep Singh wrote:
>>>>>> PL022 binding require two clocks to be defined but lpc platform doesn't
>>>>>> comply with bindings and define only one clock i.e apb_pclk.
>>>>>>
>>>>>> Update spi clocks and clocks-names property by adding appropriate clock
>>>>>> reference to make it compliant with bindings.
>>>>>>
>>>>>> CC: Vladimir Zapolskiy <vz@mleia.com>
>>>>>> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
>>>>>> ---
>>>>>> v2:
>>>>>> - New patch with similar changeset
>>>>>> - Send to soc ML
>>>>>>
>>>>>>     arch/arm/boot/dts/lpc32xx.dtsi | 8 ++++----
>>>>>>     1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
>>>>>> index c87066d6c995..30958e02d5e2 100644
>>>>>> --- a/arch/arm/boot/dts/lpc32xx.dtsi
>>>>>> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
>>>>>> @@ -178,8 +178,8 @@ ssp0: spi@20084000 {
>>>>>>                                 compatible = "arm,pl022", "arm,primecell";
>>>>>>                                 reg = <0x20084000 0x1000>;
>>>>>>                                 interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> -                             clocks = <&clk LPC32XX_CLK_SSP0>;
>>>>>> -                             clock-names = "apb_pclk";
>>>>>> +                             clocks = <&clk LPC32XX_CLK_SSP0>, <&clk LPC32XX_CLK_SSP0>;
>>>>>> +                             clock-names = "sspclk", "apb_pclk";
>>>>>
>>>>> In fact I'm uncertain if it is the right change, could it happen that the commit
>>>>> cc0f6e96c4fd ("spi: dt-bindings: Convert Arm pl022 to json-schema") sets a wrong
>>>>> schema pattern?
>>>>
>>>> Good pointm this doesn't quite seem right: it is unlikely that the same clock
>>>> is used for both the SPI bus and the APB bus.
>>>>
>>>>> Apparently just one clock is wanted on all observed platforms and cases, this
>>>>> is implicitly confirmed by clock handling in the drivers/spi/spi-pl022.c :
>>>>>
>>>>>           pl022->clk = devm_clk_get(&adev->dev, NULL);
>>>>>
>>>>> So, I would vote to fix the device tree bindings schema.
>>
>> Drivers do not describe the hardware. Bindings should not be modeled on
>> drivers, but on actual hardware, so the example is not convincing.
> 
> My concern is that fixing the bindings can break the driver and all its users,
> is it clear enough how it can happen in assumption that the driver uses just
> one clock at the moment?

You meant fixing the DTS? We do not consider here "fixing bindings"
because they look correct. About DTS, using the same clock twice should
not cause negative effect.


Best regards,
Krzysztof
