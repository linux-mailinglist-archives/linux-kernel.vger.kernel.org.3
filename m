Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6403479917
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 07:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhLRGCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 01:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhLRGCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 01:02:30 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DE5C06173E;
        Fri, 17 Dec 2021 22:02:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4F1C241E2F;
        Sat, 18 Dec 2021 06:02:26 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211209043249.65474-1-marcan@marcan.st>
 <20211209043249.65474-7-marcan@marcan.st> <87o85lu0ck.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 6/6] irqchip/apple-aic: Add support for AICv2
Message-ID: <4a83dfb1-3188-8b09-fc60-d3083230fb54@marcan.st>
Date:   Sat, 18 Dec 2021 15:02:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87o85lu0ck.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2021 03.47, Marc Zyngier wrote:
>> + * This is followed by a set of event registers, each 16K page aligned.
>> + * The first one is the AP event register we will use. Unfortunately,
>> + * the actual implemented die count is not specified anywhere in the
>> + * capability registers, so we have to explcitly specify the event
> 
> explicitly

Thanks, fixed!

> 
>> + * register offset in the device tree to remain forward-compatible.
> 
> Do the current machines actually have more than a single die?

Not the current ones, but there are loud rumors everywhere of multi-die
products... might as well try to support them ahead of time. The current
machines *do* have two register sets, implying support for 2-die
configurations, and although no IRQs are ever asserted from hardware,
SW_GEN mode works and you can trigger die-ID 1 events.

The interpretation of the capability registers comes from what the macOS
driver does (that's the only part I looked at it for, since it's kind of
hard to divine with only a single data point from the hardware). Their
driver is definitely designed for multi die machines already. The
register layout I worked out by probing the hardware; it was blatantly
obvious that there was a second set of IRQ mask arrays after the first,
that macOS didn't use (yet)...

>> +static struct irq_chip aic2_chip = {
>> +	.name = "AIC2",
>> +	.irq_mask = aic_irq_mask,
>> +	.irq_unmask = aic_irq_unmask,
>> +	.irq_eoi = aic_irq_eoi,
>> +	.irq_set_type = aic_irq_set_type,
>> +};
> 
> How is the affinity managed if you don't have a callback? A number of
> things are bound to break if you don't have one. And a description of
> how an interrupt gets routed wouldn't go amiss!

It isn't... we don't know all the details yet, but it seems to be Some
Kind Of Magic™.

There definitely is no way of individually mapping IRQs to specific
CPUs; there just aren't enough implemented register bits to allow that.

What we do have is a per-IRQ config consisting of:

- Target CPU, 4 bits. This seems to be for pointing IRQs at coprocessors
(there's actually an init dance to map a few IRQs to specific
coprocessors; m1n1 takes care of that right now*). Only 0 sends IRQs to
the AP here, so this is not useful to us.

- IRQ config group, 3 bits. This selects one of 8 IRQ config registers.
These do indirectly control how the IRQ is delivered; at least they have
some kind of delay value (coalescing?) and I suspect may do some kind of
priority control, though the details of that aren't clear yet. I don't
recall seeing macOS do anything interesting with these groups, I think
it always uses group 0.

Then each CPU has an IMP-DEF sysreg that allows it to opt-in or opt-out
of receiving IRQs (!). It actually has two bits, so there may be some
kind of priority/subset control here too. By default all other CPUs are
opted out, which isn't great... so m1n1 initializes it to opt in all
CPUs to IRQ delivery.

The actual delivery flow here seems to be something like AIC/something
picks a CPU (using some kind of heuristic/CPU state? I noticed WFI seems
to have an effect here) for initial delivery, and if the IRQ isn't acked
in a timely manner, it punts and broadcasts the IRQ to all CPUs. The IRQ
ack register is shared by all CPUs; I don't know if there is some kind
of per-CPU difference in what it can return, but I haven't observed that
yet, so I guess whatever CPU gets the IRQ gets to handle anything that
is pending.

There are also some extra features; e.g. there is definitely a set of
registers for measuring IRQ latency (tells you how long it took from IRQ
assertion to the CPU acking it). There's also some kind of global
control over which CPU *cluster* is tried first for delivery (defaults
to e-cluster, but you can change it to either p-cluster). We don't use
those right now.

So there is definitely room for further research here, but the current
state of affairs is the driver doesn't do affinity at all, and IRQs are
handled by "some" CPU. In practice, I see a decent (but not completely
uniform) spread of which CPU handles any given IRQ. I assume it's
something like it prefers a busy CPU, to avoid waking up a core just to
handle an IRQ.

* I don't know how masks are supposed to be managed for those IRQs used
by copros; I guess we'll find out when we get there and notice something
is broken if we don't unmask them... but I guess given the IRQ handling
flow here, that copro should be doing the masking/unmasking itself.

>> +		aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_SELF | AIC_IPI_OTHER);
>> +		if (!aic_irqc->info.fast_ipi) {
>> +			aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF);
>> +			aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
>> +		} else {
>> +			aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF | AIC_IPI_OTHER);
>> +		}
> 
> Why is this specific to v1 and not affecting v2? I'm sure there is a
> good reason, but documenting these differences would certainly help
> reviewing (which version implement which registers, for example).

Only v1 has legacy IPIs (which is why we had to implement Fast IPIs for
this one). AIC_IPI_* registers are for AICv1 specifically; other than
the event register fields which are the same (but not the register
offset itself), and the general concept of the mask/sw_gen/hw_status
register arrays, there aren't really any shared registers between AICv1
and AICv2.

I'll add a comment to clarify this.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
