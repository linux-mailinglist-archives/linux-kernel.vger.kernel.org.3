Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611AB480B98
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhL1Qxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhL1Qxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:53:48 -0500
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C389EC061574;
        Tue, 28 Dec 2021 08:53:47 -0800 (PST)
Received: from p54bc6060.dip0.t-ipconnect.de ([84.188.96.96] helo=[192.168.1.135]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n2FjN-0001hf-Gj; Tue, 28 Dec 2021 17:53:45 +0100
Message-ID: <06c1662a-76ff-2ede-a308-ce87186a2311@birger-koblitz.de>
Date:   Tue, 28 Dec 2021 17:53:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v2 4/5] dt-bindings: interrupt-controller:
 realtek,rtl-intc: map output lines
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
References: <cover.1640548009.git.sander@svanheule.net>
 <0a91967d40d486bb8cccd0dcf5a817df11317cf0.1640548009.git.sander@svanheule.net>
 <87r19yz47t.wl-maz@kernel.org>
 <7a02b3af9b68adeba787418eb042cd262ee335b7.camel@svanheule.net>
From:   Birger Koblitz <mail@birger-koblitz.de>
In-Reply-To: <7a02b3af9b68adeba787418eb042cd262ee335b7.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1640710427;a6aadc82;
X-HE-SMSGID: 1n2FjN-0001hf-Gj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/12/2021 17:21, Sander Vanheule wrote:
> On Mon, 2021-12-27 at 11:17 +0000, Marc Zyngier wrote:
>> On Sun, 26 Dec 2021 19:59:27 +0000,
>> Sander Vanheule <sander@svanheule.net> wrote:
>>>
>>> Amend the binding to also require a list of parent interrupts, and an
>>> optional mask to specify which parent is mapped to which output.
>>>
>>> Without this information, any driver would have to make an assumption on
>>> which parent interrupt is connected to which output.
>>
>> Why should an endpoint driver care at all?
> 
> Interrupt inputs to interrupt outputs are SW configurable, but outputs to parent
> interrupts are hard-wired and cannot be modified. "interrupt-map" defines an input to
> parent interrupt mapping, so it seems a piece of information is missing. This is currently
> provided as an assumption in the driver ("CPU IRQs (2..7) are connected to outputs
> (1..6)").
> 
> Input-to-output is SW configurable, so that can be put in the driver. Output-to-parent is
> hardware configuration,
> 
> 
>>>
>>> Additionally, extend (or add) the relevant descriptions to more clearly
>>> describe the inputs and outputs of this router.
>>>
>>> Signed-off-by: Sander Vanheule <sander@svanheule.net>
>>> ---
>>> Since it does not properly describe the hardware, I would still really
>>> rather get rid of "interrupt-map", even though that would mean breaking
>>> ABI for this binding. As we've argued before [1], that is our prefered
>>> solution, and would enable us to not carry more (hacky) code because of
>>> a mistake with the initial submission.
>>
>> Again, this is too late. Broken bindings live forever.
>>
>>>
>>> Vendors don't ship independent DT blobs for devices with this hardware,
>>> so the independent devicetree/kernel upgrades issue is really rather
>>> theoretical here. Realtek isn't driving the development of the bindings
>>> and associated drivers for this platform. They have their SDK and seem
>>> to care very little about proper kernel integration.
>>
>> Any vendor can do whatever they want. You can do the same thing if you
>> really want to.
>>
>>>
>>> Furthermore, there are currently no device descriptions in the kernel
>>> using this binding. There are in OpenWrt, but OpenWrt firmware images
>>> for this platform always contain both the kernel and the appended DTB,
>>> so there's also no breakage to worry about.
>>
>> That's just one use case. Who knows who is using this stuff in a
>> different context? Nobody can tell.
>>
>>>
>>> [1] https://lore.kernel.org/all/9c169aad-3c7b-2ffb-90a2-1ca791a3f411@phrozen.org/
>>>
>>> Differences with v1:
>>> - Don't drop the "interrupt-map" property
>>> - Add the "realtek,output-valid-mask" property
>>> ---
>>>   .../realtek,rtl-intc.yaml                     | 38 ++++++++++++++++---
>>>   1 file changed, 33 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-
>>> intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-
>>> intc.yaml
>>> index 9e76fff20323..29014673c34e 100644
>>> --- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
>>> @@ -6,6 +6,10 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>   
>>>   title: Realtek RTL SoC interrupt controller devicetree bindings
>>>   
>>> +description:
>>> +  Interrupt router for Realtek MIPS SoCs, allowing up to 32 SoC interrupts to
>>> +  be routed to one of up to 15 parent interrupts, or left disconnected.
>>> +
>>>   maintainers:
>>>     - Birger Koblitz <mail@birger-koblitz.de>
>>>     - Bert Vermeulen <bert@biot.com>
>>> @@ -22,7 +26,11 @@ properties:
>>>       maxItems: 1
>>>   
>>>     interrupts:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 15
>>> +    description:
>>> +      List of parent interrupts, in the order that they are connected to this
>>> +      interrupt router's outputs.
>>
>> Is that to support multiple SoCs? I'd expect a given SoC to have a
>> fixed number of output interrupts.
> 
> It is, and they do AFAICT. But all values from 1 to 15 can be written to the routing
> registers, so I wanted this definition to be as broad as possible.
> 
> The SoCs I'm working with only connect to the six CPU HW interrupts, but I don't know what
> the actual limit of this interrupt hardware is, or if the outputs always connect to the
> MIPS CPU HW interrupts.
> 
 From what I know, the IRQ controller is used solely by Realtek in the RTL838x, RTL839x and
RTL930x SoC families, all of them MIPS 4KEc or 34Kc with the standard 7 CPU IRQ lines.
In their final RTL931x series they abandoned their custom IRQ controller and went for
an InterAptiv core with a standard MIPS GIC.

Multiple SoCs are supported by these SoCs via direct register access for configuration either
via SPI or I2C, for which the SoCs have HW support as a slave and master (only RTL93xx).
Optionally, a GPIO pin can be used for raising an IRQ between SoCs. Fast control of the switch
hardware in the SoCs is done by proprietary Ethernet frames. At least for OpenWRT, only the original
7 IRQ outputs are used. Adding support for 15 does not seem to hurt, though and if necessary
the driver can do additional error checking.

Cheers,
   Birger

