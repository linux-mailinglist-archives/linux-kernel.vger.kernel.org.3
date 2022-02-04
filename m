Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1EF4A9C34
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359829AbiBDPsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBDPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:48:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D05C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:48:13 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nG0oa-00034l-Tz; Fri, 04 Feb 2022 16:48:00 +0100
Message-ID: <4748285a-e554-0f7f-525c-efdea0003ab8@pengutronix.de>
Date:   Fri, 4 Feb 2022 16:47:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/16] STM32 configure UART nodes for DMA
Content-Language: en-US
To:     Erwan LE RAY <erwan.leray@foss.st.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
 <cc7633c5-de5f-0abf-4ac8-64a74633dfcc@pengutronix.de>
 <f5aec360-c33c-0145-6596-541003e305b2@foss.st.com>
 <98823363-710c-6286-8e63-ba8e5dcadeba@foss.st.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <98823363-710c-6286-8e63-ba8e5dcadeba@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Erwan,

On 04.02.22 16:41, Erwan LE RAY wrote:
> Hi Ahmad,
> 
> 
> On 2/4/22 2:22 PM, Alexandre TORGUE wrote:
>> Hi Ahmad
>>
>> On 2/3/22 18:25, Ahmad Fatoum wrote:
>>> Hello Erwan,
>>>
>>> On 03.02.22 18:10, Erwan Le Ray wrote:
>>>> Add DMA configuration to UART nodes in stm32mp15x (SOC level) and
>>>> remove it at board level to keep current PIO behavior when needed.
>>>> For stm32-ed1 and stm32-dkx boards, UART4 (console) and UART7
>>>> (no HW flow control pin available) are kept in PIO mode, while USART3
>>>> is now configured in DMA mode.
>>>> UART4 (console UART) has to be kept in irq mode, as DMA support for
>>>> console has been removed from the driver by commit e359b4411c28
>>>> ("serial: stm32: fix threaded interrupt handling").
>>>
>>> Do I understand correctly that your first patch breaks consoles of
>>> most/all boards, because they will briefly use DMA, which is refused
>>> by the stm32-usart driver and then you add a patch for each board
>>> to fix that breakage?
>>
>> We have two solutions and both have pro/drawbacks. The first one (Erwan ones, can break the boot if the patch is taken "alone". Your proposition avoids this breakage but deletes a non define property (which is a bit weird). However I prefer to keep a functional behavior, and keep Ahmad proposition. Ahmad, just one question, dt-bindings check doesn't complain about it ?
>>
>> Cheers
>> Alex
>>
>>>
>>> Such intermittent breakage makes bisection a hassle. /delete-property/
>>> is a no-op when the property doesn't exist, so you could move the first
>>> patch to the very end to avoid intermittent breakage.
>>>
>>> I also think that the driver's behavior is a bit harsh. I think it would
>>> be better for the UART driver to print a warning and fall back to
>>> PIO for console instead of outright refusing and rendering the system
>>> silent. That's not mutually exclusive with your patch series here, of course.
>>>
>>> Cheers,
>>> Ahmad
>>>
> 
> The driver implementation will consider the request to probe the UART console in DMA mode as an error (-ENODEV), and will fallback this UART probe in irq mode.
> Whatever the patch ordering, the boot will never be broken. The board dt patches aim to get a "proper" implementation, but from functional perspective the driver will manage a request to probe an UART console in DMA mode as an error and fall it back in irq mode.

Thanks for the clarification. In that case, your changes look good to me.

Cheers,
Ahmad

> 
> Cheers, Erwan.
> 
>>>>
>>>> For other stm32mp15x-based boards, current configuration is kept for
>>>> all UART instances.
>>>>
>>>> Erwan Le Ray (16):
>>>>    ARM: dts: stm32: add DMA configuration to UART nodes on stm32mp151
>>>>    ARM: dts: stm32: keep uart4 behavior on stm32mp157c-ed1
>>>>    ARM: dts: stm32: keep uart4 and uart7 behavior on stm32mp15xx-dkx
>>>>    ARM: dts: stm32: keep uart4 behavior on icore-stm32mp1-ctouch2
>>>>    ARM: dts: stm32: keep uart4 behavior on icore-stm32mp1-edimm2.2
>>>>    ARM: dts: stm32: keep uart4 behavior on stm32mp157a-iot-box
>>>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp1-microdev2.0-of7
>>>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp1-microdev2.0
>>>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp157a-stinger96
>>>>    ARM: dts: stm32: keep uart4 behavior on stm32mp157c-lxa-mc1
>>>>    ARM: dts: stm32: keep uart4 behavior on stm32mp157c-odyssey
>>>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-drc02
>>>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-pdk2
>>>>    ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-picoitx
>>>>    ARM: dts: stm32: keep uart4 behavior on stm32mp15xx-dhcom-som
>>>>    ARM: dts: stm32: keep uart nodes behavior on
>>>>      stm32mp15xx-dhcor-avenger96
>>>>
>>>>   arch/arm/boot/dts/stm32mp151.dtsi             | 21 +++++++++++++++++++
>>>>   .../stm32mp157a-icore-stm32mp1-ctouch2.dts    |  2 ++
>>>>   .../stm32mp157a-icore-stm32mp1-edimm2.2.dts   |  2 ++
>>>>   arch/arm/boot/dts/stm32mp157a-iot-box.dts     |  2 ++
>>>>   ...157a-microgea-stm32mp1-microdev2.0-of7.dts |  4 ++++
>>>>   ...32mp157a-microgea-stm32mp1-microdev2.0.dts |  4 ++++
>>>>   arch/arm/boot/dts/stm32mp157a-stinger96.dtsi  |  6 ++++++
>>>>   arch/arm/boot/dts/stm32mp157c-ed1.dts         |  2 ++
>>>>   arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts     |  2 ++
>>>>   arch/arm/boot/dts/stm32mp157c-odyssey.dts     |  2 ++
>>>>   .../arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi |  4 ++++
>>>>   arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi |  4 ++++
>>>>   .../boot/dts/stm32mp15xx-dhcom-picoitx.dtsi   |  4 ++++
>>>>   arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi  |  2 ++
>>>>   .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |  6 ++++++
>>>>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        |  4 ++++
>>>>   16 files changed, 71 insertions(+)
>>>>
>>>
>>>
>>
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
