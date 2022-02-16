Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD194B91BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbiBPTtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:49:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238313AbiBPTtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:49:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74861202068
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:49:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1602A12FC;
        Wed, 16 Feb 2022 11:49:05 -0800 (PST)
Received: from [10.57.40.147] (unknown [10.57.40.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 342B73F70D;
        Wed, 16 Feb 2022 11:49:03 -0800 (PST)
Message-ID: <27b10c12-e3f2-6ac4-26b5-44625e61d7ae@arm.com>
Date:   Wed, 16 Feb 2022 19:48:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] dma-contiguous: Prioritize restricted DMA pool over
 shared DMA pool
Content-Language: en-GB
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        opendmb@gmail.com, robh@kernel.org, will@kernel.org,
        tientzu@chromium.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>
References: <20220215224344.1779145-1-f.fainelli@gmail.com>
 <39ed2187-2345-297d-2dd3-0b0974ce8b31@arm.com>
 <50ae9c05-2ec4-09a8-965c-0d70ea74d879@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <50ae9c05-2ec4-09a8-965c-0d70ea74d879@gmail.com>
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

On 2022-02-16 17:37, Florian Fainelli wrote:
> On 2/16/22 3:13 AM, Robin Murphy wrote:
>> On 2022-02-15 22:43, Florian Fainelli wrote:
>>> Some platforms might define the same memory region to be suitable for
>>> used by a kernel supporting CONFIG_DMA_RESTRICTED_POOL while maintaining
>>> compatibility with older kernels that do not support that. This is
>>> achieved by declaring the node this way;
>>
>> Those platforms are doing something inexplicably wrong, then.
> 
> Matter of perspective I guess.
> 
>>
>> "restricted-dma-pool" says that DMA for the device has to be bounced
>> through a dedicated pool because it can't be trusted with visibility of
>> regular OS memory. "reusable" tells the OS that it's safe to use the
>> pool as regular OS memory while it's idle. Do you see how those concepts
>> are fundamentally incompatible?
> 
>  From the perspective of the software or firmware agent that is
> responsible for setting up the appropriate protection on the reserved
> memory, it does not matter what the compatible string is, the only
> properties that matter are the base address, size, and possibly whether
> 'no-map' is specified or not to set-up appropriate protection for the
> various memory controller agents (CPU, PCIe, everything else).
> 
> Everything else is just information provided to the OS in order to
> provide a different implementation keyed off the compatible string. So
> with that in mind, you can imagine that before the introduction of
> 'restricted-dma-pool' in 5.15, some platforms already had such a concept
> of a reserved DMA region, that was backed by a device private CMA pool,
> they would allocate memory from that region and would create their own
> middle layer for bounce buffering if they liked to. This is obviously
> not ideal on a number of levels starting from not being done at the
> appropriate level but it was done.
> 
> Now that 'restricted-dma-pool' is supported, transitioning them over is
> obviously better and updating the compatible string for those specific
> regions to include the more descriptive 'restrictded-dma-pool' sounded
> to me as an acceptable way to maintain forward/backward DTB
> compatibility rather than doubly reserving these region one with the
> "old" compatible and one with the "new" compatible, not that the system
> is even capable of doing that anyway, so we would have had to
> essentially make them adjacent.
> 
> And no, we are not bringing Linux version awareness to our boot loader
> mangling the Device Tree blob, that's not happening, hence this patch.

If the patch was adding a "brcm,insecure-dma-pool" compatible and 
hooking it up, I'd be less bothered. As it is, I remain unconvinced that 
describing two things that are not interchangeable with each other as 
interchangeable with each other is in any way "better".

>> Linux is right to reject contradictory information rather than attempt
>> to guess at what might be safe or not.
> 
> The piece of contradictory information here specifically is the
> 'reusable' boolean property, but as I explain the commit message
> message, if you have a "properly formed" 'restricted-dma-pool' region
> then it should not have that property in the first place, but even if it
> does, it does not harm anything to have it.
> 
>>
>> Furthermore, down at the practical level, a SWIOTLB pool is used for
>> bouncing streaming DMA API mappings, while a coherent/CMA pool is used
>> for coherent DMA API allocations; they are not functionally
>> interchangeable either. If a device depends on coherent allocations
>> rather than streaming DMA, it should still have a coherent pool even
>> under a physical memory protection scheme, and if it needs both
>> streaming DMA and coherent buffers then it can have both types of pool -
>> the bindings explicitly call that out. It's true that SWIOTLB pools can
>> act as an emergency fallback for small allocations for I/O-coherent
>> devices, but that's not really intended to be relied upon heavily.
>>
>> So no, I do not see anything wrong with the current handling of
>> nonsensical DTs here, sorry.
> 
> There is nothing wrong in the current code, but with changes that have
> no adverse effect on "properly" constructed reserved memory entries we
> can accept both types of reservation and maintain forward/backward
> compatibility in our case. So why not?

Would you be happy to give me blanket permission to point a gun at your 
foot and pull the trigger at any point in the future, if right now I 
show you an unloaded gun?

Security and lazy shortcuts do not mix well. You are literally arguing 
that mainline Linux should support a back-door ABI for illegal DT 
properties which at worst has the potential to defeat a generic security 
feature. The "restricted-dma-pool" binding explicitly says "When using 
this, the no-map and reusable properties must not be set" (I should spin 
up a patch enforcing that in the schema...). No matter how convinced you 
are that no OS past present or future could possibly ever behave 
differently from the particular downstream software stack you care 
about, NAK to subverting the "restricted-dma-pool" compatible in any 
way, sorry. I for one wish to have no part in the next 
trendy-name-compromise down the line where a protected VM can be tricked 
into exposing its page cache to a "DMA attack" by an untrusted 
hypervisor because fixing Florian's bootloader is hard.

Cheers,
Robin.
