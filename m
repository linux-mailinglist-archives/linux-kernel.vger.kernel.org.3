Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168F4534BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346719AbiEZIlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiEZIlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:41:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A730DC5D84
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:41:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58ACA1474;
        Thu, 26 May 2022 01:41:05 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 268363F70D;
        Thu, 26 May 2022 01:41:03 -0700 (PDT)
Message-ID: <5a8d5c51-ae02-a335-6768-2bedf809ab63@arm.com>
Date:   Thu, 26 May 2022 09:40:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Question about SPIs' interrupt trigger type restrictions
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>,
        richard clark <richard.xnu.clark@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <CAJNi4rNwPQf747UM_hiYYwL=HDxg8QnPpfFPv1PfrtN9ZP1y1g@mail.gmail.com>
 <35f95ba3-8a7b-7918-0f9d-e14274a5ffe9@arm.com>
 <CAJNi4rMbBbLP2Tsv-wnnJKt4Y0moOE5-sNaZN1fCty908pwAKw@mail.gmail.com>
 <87ee0gn5rq.wl-maz@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <87ee0gn5rq.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-26 07:54, Marc Zyngier wrote:
> On Thu, 26 May 2022 04:44:41 +0100,
> richard clark <richard.xnu.clark@gmail.com> wrote:
>>
>> On Thu, May 26, 2022 at 3:14 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 2022-05-25 11:01, richard clark wrote:
>>>> Hi Marc,
>>>>
>>>> For below code snippet about SPI interrupt trigger type:
>>>>
>>>> static int gic_set_type(struct irq_data *d, unsigned int type)
>>>> {
>>>>           ...
>>>>           /* SPIs have restrictions on the supported types */
>>>>           if ((range == SPI_RANGE || range == ESPI_RANGE) &&
>>>>               type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
>>>>                   return -EINVAL;
>>>>           ...
>>>> }
>>>>
>>>> We have a device at hand whose interrupt type is SPI, Falling edge
>>>> will trigger the interrupt. But the request_irq(50, handler,
>>>> IRQ_TYPE_EDGE_FALLING, ...) will return -EINVAL.
>>>>
>>>> The question is, why must the SPI interrupt use IRQ_TYPE_EDGE_RISING
>>>> instead of IRQ_TYPE_EDGE_FALLING?
>>>
>>> Because that's what the GIC architecture[1] says. From section 1.2.1
>>> "Interrupt Types":
>>>
>>> "An interrupt that is edge-triggered has the following property:
>>>          • It is asserted on detection of a rising edge of an interrupt signal
>>
>> This rising edge detection is not true, it's also asserted by
>> falling edge, just like the GICD_ICFGR register says: Changing the
>> interrupt configuration between level-sensitive and *edge-triggered
>> (in either direction)* at a time when there is a pending interrupt
>> ...,
> 
> Let me finish the sentence for you:
> 
> <quote>
> ... will leave the interrupt in an UNKNOWN pending state.
> </quote>
> 
> and the direction here is about the configuration bit, not the edge
> direction.

Indeed it's clearly referring to either direction of *the change*, i.e. 
from edge to level and from level to edge.

>> which has been confirmed by GIC-500 on my platform.
> 
>  From the GIC500 r1p1 TRM, page 2-8:
> 
> <quote>
> SPIs are generated either by wire inputs or by writes to the AXI4
> slave programming interface.  The GIC-500 can support up to 960 SPIs
> corresponding to the external spi[991:32] signal. The number of SPIs
> available depends on the implemented configuration. The permitted
> values are 32-960, in steps of 32. The first SPI has an ID number of
> 32. You can configure whether each SPI is triggered on a rising edge
> or is active-HIGH level-sensitive.
> </quote>
> 
> So I have no idea what you are talking about, but you definitely have
> the wrong end of the stick. Both the architecture and the
> implementations are aligned with what the GIC drivers do.
> 
> If your system behaves differently, this is because something is
> inverting the signal, which is extremely common. Just describe this in
> your device tree, or lie to the kernel, whichever way you want.

I think the important concept to grasp here is that what we describe in 
DT is not properties of the device in isolation, but properties of its 
integration into the system as a whole. Consider the "reg" property, 
which in 99% of cases has nothing to do with the actual device it 
belongs to, but is instead describing a property of the interconnect, 
namely how its address map decodes to a particular interface, to which 
the given device happens to be attached.

At the HDL level, the device block may very well have an output signal 
which idles at logic-high, and pulses low to indicate an event, however 
it only becomes an *interrupt* if it is wired up to an interrupt 
controller; on its own it's just some output signal. What the DT 
interrupt specifier describes is that wiring, *from the interrupt 
controller's point of view*. If a pulsed signal is fed into an Arm GIC 
SPI input then as an interrupt it *is* IRQ_TYPE_EDGE_RISING, because 
that's how the GIC hardware will treat it. The integration as a whole 
takes care of the details and makes that happen, so what the logic 
levels at some arbitrary HDL boundary in the middle might be is simply 
not meaningful.

Thanks,
Robin.
