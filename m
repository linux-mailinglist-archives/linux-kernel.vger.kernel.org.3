Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3654D6379
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349190AbiCKOeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbiCKOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:34:15 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C521414FBF8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:33:10 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 31A7C3F30F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647009189;
        bh=OnW6EN46n7vaYBFSgg2vgSftb7Rx3mwGGTomxWm4iNQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=H58iF8vpgjYOwIrIh2zAdBqFSmYVYnf7Z1rFTJD93+bJ2V5auzDC8s+Zgi5ZdM4bP
         Dkd11n5C5gcnrYy6Rjl+PDo+oU3593fKnb9l91aSiNJ5kB9cTzfdK5R5rGNiej8bAh
         7joxwIJr6h0EzWk9DxP5PctybDyEdTIgO+qkZWhv9y4HGwvWQuTRVqMkHxjb2KQdq3
         z06HULQUgEbmcF5oChr/m+i05UEAM+MmEXBcr2ziBuByjeXAbHdzthR21daQfOQwDc
         Ywde3meaIYkXnMOVIwh9OfMfAAbBhp/0BpijRD5/J8kwRlJ1F/glBjbMCwo6EcgOfo
         nfU6T9/GWNktQ==
Received: by mail-wm1-f72.google.com with SMTP id v125-20020a1cac83000000b0037e3d70e7e1so5587558wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OnW6EN46n7vaYBFSgg2vgSftb7Rx3mwGGTomxWm4iNQ=;
        b=1T9CzYrBE3H8lIl/k1t7YROcdta5yvbvi/E988sxdOj8/GeMnVFWwL3ZdfHCd3Bzey
         wKDynLd80T0ei0Iz1cP8/l9k+8+oty5TkuZKnQWePHVTnxxxNGe0FlUuVPE48EH88ZyE
         61xSGzsIljwsqv5dkkNKJ9EUV/D7vhcKdOnPNByF6f4UtMAjuy276TENHmgSPMBthYfO
         f9fjxoycsMmv3MAnbGhES1dOVUiUxDkWQLAxrgVZFyVGxvq9/gwxd92M0+MIwAXqMfnh
         bIMGdQzc5dAcJEfaqkK/ot/4DSM8ixmoQYXeZQM2C3PsqxMaDkR15mx7yS/ouQ0vNxoM
         cwTg==
X-Gm-Message-State: AOAM531cFbmXQRhppIkF4AqThlYCTtvUBM+rcUR/sEFsZskaafC5gvW4
        x0sV4KvvPt+8ksRDuBt3brUbPLD/WzNCSdCeDOMBSOok9fjwwFsVKCcaPGjW3Zxa2odPswgnYJp
        1Hws840qbNPijF61EKhZ6GKBBTsgksvUGuWZcrAVbfw==
X-Received: by 2002:a05:600c:34c4:b0:389:a4c3:c4b1 with SMTP id d4-20020a05600c34c400b00389a4c3c4b1mr7607587wmq.65.1647009188079;
        Fri, 11 Mar 2022 06:33:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFzx1SPSweAq4eva3FzBdIfwL59AEbdj699V43mjce3zliJKeU+w5FN7C7Zd5dBSf5kORNAg==
X-Received: by 2002:a05:600c:34c4:b0:389:a4c3:c4b1 with SMTP id d4-20020a05600c34c400b00389a4c3c4b1mr7607573wmq.65.1647009187861;
        Fri, 11 Mar 2022 06:33:07 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id 10-20020adf808a000000b001edd413a952sm6726713wrl.95.2022.03.11.06.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 06:33:07 -0800 (PST)
Message-ID: <2f53f17a-427c-62d6-a0c6-4a3962ab01f0@canonical.com>
Date:   Fri, 11 Mar 2022 15:33:06 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <4f39f086-1932-1729-8761-d5c533356812@mleia.com>
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

On 11/03/2022 15:07, Vladimir Zapolskiy wrote:
> On 3/11/22 3:38 PM, Arnd Bergmann wrote:
>> On Fri, Mar 11, 2022 at 2:20 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
>>>
>>> On 3/11/22 11:38 AM, Kuldeep Singh wrote:
>>>> PL022 binding require two clocks to be defined but lpc platform doesn't
>>>> comply with bindings and define only one clock i.e apb_pclk.
>>>>
>>>> Update spi clocks and clocks-names property by adding appropriate clock
>>>> reference to make it compliant with bindings.
>>>>
>>>> CC: Vladimir Zapolskiy <vz@mleia.com>
>>>> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
>>>> ---
>>>> v2:
>>>> - New patch with similar changeset
>>>> - Send to soc ML
>>>>
>>>>    arch/arm/boot/dts/lpc32xx.dtsi | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
>>>> index c87066d6c995..30958e02d5e2 100644
>>>> --- a/arch/arm/boot/dts/lpc32xx.dtsi
>>>> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
>>>> @@ -178,8 +178,8 @@ ssp0: spi@20084000 {
>>>>                                compatible = "arm,pl022", "arm,primecell";
>>>>                                reg = <0x20084000 0x1000>;
>>>>                                interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
>>>> -                             clocks = <&clk LPC32XX_CLK_SSP0>;
>>>> -                             clock-names = "apb_pclk";
>>>> +                             clocks = <&clk LPC32XX_CLK_SSP0>, <&clk LPC32XX_CLK_SSP0>;
>>>> +                             clock-names = "sspclk", "apb_pclk";
>>>
>>> In fact I'm uncertain if it is the right change, could it happen that the commit
>>> cc0f6e96c4fd ("spi: dt-bindings: Convert Arm pl022 to json-schema") sets a wrong
>>> schema pattern?
>>
>> Good pointm this doesn't quite seem right: it is unlikely that the same clock
>> is used for both the SPI bus and the APB bus.
>>
>>> Apparently just one clock is wanted on all observed platforms and cases, this
>>> is implicitly confirmed by clock handling in the drivers/spi/spi-pl022.c :
>>>
>>>          pl022->clk = devm_clk_get(&adev->dev, NULL);
>>>
>>> So, I would vote to fix the device tree bindings schema.

Drivers do not describe the hardware. Bindings should not be modeled on
drivers, but on actual hardware, so the example is not convincing.

>>
>> Isn't this just using the wrong name? The name of the macro
>> LPC32XX_CLK_SSP0 might indicate that this is indeed the SPI clock
>> rather than the APB clock, so we only need to change clock-names
>> property here and leave it unchanged otherwise.
> 
> Yes, the name is wrong, here I'm ready to take the blame:
> 
> Fixes: 93898eb775e5 ("arm: dts: lpc32xx: add clock properties to device nodes")
> 
> Noteworthy the commit above presets the same clock name to other PrimeCell
> controllers, namely pl110 (LCD), pl080 (DMA), pl175 (EMC) and pl18x (SD),
> plus this one pl022 (SSP), and all but SSP and SD are AHB slaves in fact.
> 
> On LPC32xx the bus clock source and function clock source for SSP is HCLK.
> 
> My guess is that the misnamed "apb_pclk" migrated into the schema from
> the lpc32xx.dtsi, so I'd suggest, unless some platform really needs it,
> firstly fix the schema by removing "apb_pclk" clock. It will leave just one
> clock, so "clock-names" property can be set as optional, and the drop
> the property from the lpc32xx.dtsi.
> 
>> Looking at the driver, I also see that this refers to the clock as
>> "SSP/SPI bus clock", and it reads the rate from that.
> 
> Yes, that's correct, it's a SPI bus clock with an option to set a rate.

It seems versioning of this patchset lacks proper references to previous
discussions:
https://lore.kernel.org/linux-devicetree/Yip2MZdQNjMz%2FCos@robh.at.kernel.org/


Best regards,
Krzysztof
