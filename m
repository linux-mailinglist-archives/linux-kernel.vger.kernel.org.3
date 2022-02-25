Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDC64C3D17
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiBYE2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBYE2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:28:11 -0500
X-Greylist: delayed 55157 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 20:27:38 PST
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71348B82C2;
        Thu, 24 Feb 2022 20:27:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C043E41EA7;
        Fri, 25 Feb 2022 04:27:33 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220224130741.63924-1-marcan@marcan.st>
 <YhfN4YtR+Nq5vmVr@lakrids> <87r17s2ifv.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 0/7] irqchip/apple-aic: Add support for AICv2
Message-ID: <678cdea0-a717-633f-4612-ce50453057cb@marcan.st>
Date:   Fri, 25 Feb 2022 13:27:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87r17s2ifv.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2022 04.06, Marc Zyngier wrote:
> On Thu, 24 Feb 2022 18:26:41 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> On Thu, Feb 24, 2022 at 10:07:34PM +0900, Hector Martin wrote:
>>> Hi folks,
>>
>> Hi Hector,
>>
>>> In the t6000/t6001 (M1 Pro / Max) SoCs, Apple introduced a new version
>>> of their interrupt controller. This is a significant departure from
>>> AICv1 and seems designed to better scale to larger chips. This series
>>> adds support for it to the existing AIC driver.
>>>
>>> Gone are CPU affinities; instead there seems to be some kind of
>>> "automagic" dispatch to willing CPU cores, and cores can also opt-out
>>> via an IMP-DEF sysreg (!). Right now the bootloader just sets up all
>>> cores to accept IRQs, and we ignore all this and let the magic
>>> algorithm pick a CPU to accept the IRQ.
>>
>> Maybe that's ok for the set of peripherals attached, but in general that
>> violates existing expectations regarding affinity, and I fear there'll
>> be some subtle brokenness resulting from this automatic target
>> selection.
>>
>> For example, in the perf events subsystem there are PMU drivers (even
>> those for "uncore" or "system" devices which are shared by many/all
>> CPUs) which rely on a combination of interrupt affinity and local IRQ
>> masking (without any other locking) to provide exclusion between a PMU's
>> IRQ handler and any other management operations for that PMU (which are
>> all handled from the same CPU).
> 
> It will definitely break anything that relies on managed interrupts,
> where the kernel expects to allocate interrupts that have a strict
> affinity. Drivers using this feature can legitimately expect that they
> can keep their state in per-CPU pointers, and that obviously breaks.
> 
> This may affect any PCIe device with more than a couple of queues.
> Maybe users of this HW do not care (yet), but we'll have to find a way
> to tell drivers of the limitation.

Yes, we already had a brief discussion about this in the v1 thread:

https://lore.kernel.org/linux-arm-kernel/4a83dfb1-3188-8b09-fc60-d3083230fb54@marcan.st/

TL;DR there is no explicit per-IRQ affinity control, nor does an unknown
one seem possible, since there just aren't enough bits for it in per-IRQ
registers. AICv1 had that, but AICv2 got rid of it in favor of heuristic
magic and global per-CPU controls.

This hasn't actually been fully tested yet, but current hypothesis is
the mapping goes:

1 IRQ -> group (0-7) -> priority (0-3?) -> 1 CPU (local priority threshold)

This is based on the fact that the per-IRQ group field is 3 bits, and
the per-CPU mask IMP-DEF sysreg is 2 bits. There may or may not be
per-IRQ cluster controls. But that still leaves all IRQs funnelled into,
at most, 3-4 classes per CPU cluster, and 8 groups globally, so there's
no way to implement proper per-IRQ affinity (since we have 10 CPUs on
these platforms).

My guess is Apple has bet on heuristic magic to optimize IRQ delivery to
avoid waking up (deep?-)sleeping CPUs on low-priority events and
optimize for power, and forgone strict per-CPU queues which are how many
drivers optimize for performance. This makes some sense, since these are
largely consumer/prosumer platforms, many of them battery-powered, not
128-CPU datacenter monsters with multiple 10GbE interfaces. They can
probably get away without hard multiqueue stuff.

This won't be an issue for PMU interrupts (including the uncore PMU),
since those do not go through AIC per se but rather the FIQ path (which
is inherently per-CPU), same as the local timers. Marc's PMU support
patch set already takes care of adding support for those FIQ sources.
But it will indeed break some PCIe drivers for devices that users might
have arbitrarily attached through Thunderbolt.

Since we do not support Thunderbolt yet, I suggest we kick this can down
the road until we have test cases for how this breaks and how to fix it :-)

There are also other fun things to be done with the local CPU masking,
e.g. directing low-priority IRQs away from CPUs running real-time
threads. I definitely want to take a look in more detail at the controls
we *do* have, especially since I have a personal interest in RT for
audio production (and these platforms have no SMM/TEE, no latency
spikes, and fast cpufreq, woo!). But for now this works and brings up
the platform, so that yak is probably best shaved in the future. Let me
know if you're interested in having more discussions about RT-centric
features, though. I suspect we'll need some new kernel
mechanisms/interfaces to handle e.g. the CPU IMPDEF mask/prio stuff...

Aside, I wonder how they'll handle multi-die devices... for a single
die, you can probably well get away with no CPU pinning, but for
multi-die, are they going to do NUMA? If so, they'd want at least die
controls to avoid bouncing cache lines between dies too much... though
for some reason, I'm getting the feeling they're just going to
interleave memory and pretend it's UMA. Good chance we find out next
month...

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
