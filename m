Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E064D818D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbiCNLpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240706AbiCNLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:44:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D72617670;
        Mon, 14 Mar 2022 04:43:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90714106F;
        Mon, 14 Mar 2022 04:43:31 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34EC43F99C;
        Mon, 14 Mar 2022 04:43:30 -0700 (PDT)
Message-ID: <dc599cae-7245-73dc-8050-14ec6c1336b8@arm.com>
Date:   Mon, 14 Mar 2022 11:43:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 3/3] ARM: dts: lpc32xx: Update spi clock properties
Content-Language: en-GB
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4f39f086-1932-1729-8761-d5c533356812@mleia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-11 14:07, Vladimir Zapolskiy wrote:
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
>>>>    arch/arm/boot/dts/lpc32xx.dtsi | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi 
>>>> b/arch/arm/boot/dts/lpc32xx.dtsi
>>>> index c87066d6c995..30958e02d5e2 100644
>>>> --- a/arch/arm/boot/dts/lpc32xx.dtsi
>>>> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
>>>> @@ -178,8 +178,8 @@ ssp0: spi@20084000 {
>>>>                                compatible = "arm,pl022", 
>>>> "arm,primecell";
>>>>                                reg = <0x20084000 0x1000>;
>>>>                                interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
>>>> -                             clocks = <&clk LPC32XX_CLK_SSP0>;
>>>> -                             clock-names = "apb_pclk";
>>>> +                             clocks = <&clk LPC32XX_CLK_SSP0>, 
>>>> <&clk LPC32XX_CLK_SSP0>;
>>>> +                             clock-names = "sspclk", "apb_pclk";
>>>
>>> In fact I'm uncertain if it is the right change, could it happen that 
>>> the commit
>>> cc0f6e96c4fd ("spi: dt-bindings: Convert Arm pl022 to json-schema") 
>>> sets a wrong
>>> schema pattern?
>>
>> Good pointm this doesn't quite seem right: it is unlikely that the 
>> same clock
>> is used for both the SPI bus and the APB bus.
>>
>>> Apparently just one clock is wanted on all observed platforms and 
>>> cases, this
>>> is implicitly confirmed by clock handling in the 
>>> drivers/spi/spi-pl022.c :
>>>
>>>          pl022->clk = devm_clk_get(&adev->dev, NULL);
>>>
>>> So, I would vote to fix the device tree bindings schema.
>>
>> Isn't this just using the wrong name? The name of the macro
>> LPC32XX_CLK_SSP0 might indicate that this is indeed the SPI clock
>> rather than the APB clock, so we only need to change clock-names
>> property here and leave it unchanged otherwise.
> 
> Yes, the name is wrong, here I'm ready to take the blame:
> 
> Fixes: 93898eb775e5 ("arm: dts: lpc32xx: add clock properties to device 
> nodes")
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

No, "apb_pclk" is part of the common AMBA binding, and is required by 
the "arm,primecell" compatible. You won't (usually) find it referenced 
in drivers because it's dealt with by amba_get_enable_pclk() via 
amba_probe().

Robin.
