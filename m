Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5354E7158
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355979AbiCYKgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242067AbiCYKfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:35:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A490BA8EDA;
        Fri, 25 Mar 2022 03:34:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C9C71570;
        Fri, 25 Mar 2022 03:34:19 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 519613F73D;
        Fri, 25 Mar 2022 03:34:17 -0700 (PDT)
Message-ID: <5ae774b7-f888-f201-d77d-0ab0cf0faed3@arm.com>
Date:   Fri, 25 Mar 2022 10:34:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH devicetree 00/10] Do something about ls-extirq
 interrupt-map breakage
Content-Language: en-GB
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>, "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
 <87ilvrk1r0.wl-maz@kernel.org> <20211214095853.4emzycaxkuqr4tun@skbuf>
 <87czlzjxmz.wl-maz@kernel.org> <20220324171041.t5yoocinj6gizcc7@skbuf>
 <87lewz5kr5.wl-maz@kernel.org> <20220324173405.nusk6247ouvek46y@skbuf>
 <87k0cj5io4.wl-maz@kernel.org> <20220324190904.boo2izjc3mym2wkh@skbuf>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220324190904.boo2izjc3mym2wkh@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-24 19:09, Vladimir Oltean wrote:
> On Thu, Mar 24, 2022 at 06:06:51PM +0000, Marc Zyngier wrote:
>>> I was just raising this as what I thought would be a simple and
>>> non-controversial counter example to your remark "If you change something,
>>> you *must* guarantee forward *and* backward compatibility."
>>
>> If you change something *in the binding*, which was implicit in the
>> context, and makes no sense out of context.
>>
>>> Practically speaking, what has happened is that the board DT appeared in
>>> kernel N, the ls-extirq driver in kernel N+1, and the DT was updated to
>>> enable PHY interrupts in kernel N+2. That DT update practically broke
>>> kernel N from running correctly on DTs taken from kernel N+2 onwards.
>>> This is the observable behavior, we can find as many justifications for
>>> it as we wish.
>>
>> Well, you can also argue that the DT was broken at N and N+1 for not
>> describing the HW correctly and completely. No binding has changed
>> here. Your DT was incomplete, and someone fixed it for you.
>>
>> We can argue this things forever and a half. I've laid down the ground
>> rules for the stuff I maintain. If you're not happy with this, you can
>> fix it by either removing the NXP hardware from the tree, or taking
>> over from me as the irqchip maintainer. I'd be perfectly happy with
>> any (and even more, with both) of these outcomes.
> 
> Ok, my intention wasn't to inflame you even though the way in which I
> presented the problem might have suggested otherwise.
> 
> With my developer hat I still don't agree with you even with the
> additional clarification you've made that you were referring only to
> bindings and not to any and all DT changes. The reason being that the DT
> blob is a whole, and it doesn't matter if there's a regression because
> of a binding change or something else, you still need to be prepared to
> update it, sometimes in lockstep with the kernel, like it or not.
> 
> But as a user, I just wanted to get an opinion from you what can we do
> to deal better with this situation: optional interrupt provided by
> device with missing driver, which of_irq_get() doesn't seem to understand.

FWIW, of_irq_get() absolutely understands how to handle a missing IRQ 
provider driver; it returns -EPROBE_DEFER. If a caller considers the IRQ 
optional, then it's up to that caller to decide how long to keep waiting 
for the provider to appear until giving up and carrying on without it. 
If your phy driver is making the dumb decision to wait for ever for 
something which isn't critical, then you're free to fix it, or perhaps 
even propose for of_irq_get() to opt in to the 
driver_deferred_probe_check_state() mechanism if you believe it's a 
sufficiently general case.

If a new DT with an additional new property (either on an existing 
machine, or on a completely new machine which has the property from the 
start) exposes a bug in a driver, that's unfortunate, but it is entirely 
irrelevant to the ABI implications of changing the interpretation of an 
existing property.

Robin.
