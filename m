Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B61509EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382280AbiDULuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiDULuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:50:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C9A25C52
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0881BCE20E8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FDCC385A5;
        Thu, 21 Apr 2022 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650541646;
        bh=DAjGn8s12WQcTrRyR60ljMJ4ckcvAvtAfNmqk1O+ZOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tekOZU5D45mBy0Ake2nWU95rR4+D7QHbKl6oYp5XBjgAvT0LjUUc9HPCrIZs0Z767
         bVYX2yPb7cVj4nOTFqrP8+Wi+jLjSJEo7+nd/yhQim3T8pcOvG5beq4E3IgaejMei+
         VKC8qQjaYCMhOTShFPBRCwfjXEiBXWnwP4VwQ6MfFaeDKwdnrAwc4EBW9/S4gHGcTq
         /cLlptpsmgPrz7aeKCoGkNlKRyeecdNYsRuBXSrH+VbnsQjG8FWFBOOIOvM+ysIHrr
         OZ42JZpBJXYOU07cYoPqJQ/Yp3UuMVE+rK8XTRmlT6NYhhOtaXrVwK3Nmfd3Xj+1/d
         1sQ7LGOK93NQA==
Date:   Thu, 21 Apr 2022 12:47:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: head: Fix cache inconsistency of the
 identity-mapped region
Message-ID: <20220421114719.GA8557@willie-the-truck>
References: <20220415170504.3781878-1-sdonthineni@nvidia.com>
 <87y202agz9.wl-maz@kernel.org>
 <6b08ece9-64c0-9de9-9876-ed2dceee9bb0@nvidia.com>
 <20220420100801.GA7235@willie-the-truck>
 <f1b32237-f178-0656-b3ee-814eec4edb71@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b32237-f178-0656-b3ee-814eec4edb71@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shanker,

First of all, thanks for continuing to share so many useful details here.
I'm pretty confident we'll eventually get to the bottom of this.

On Wed, Apr 20, 2022 at 10:02:13AM -0500, Shanker R Donthineni wrote:
> On 4/20/22 5:08 AM, Will Deacon wrote:
> > Non-coherent? You mean non-cacheable, right? At this stage, we only
> >>> have a single CPU, so I'm not sure coherency is the problem here. When
> >>> you say 'drop', is that an eviction? Replaced by what? By the previous
> >>> version of the cache line, containing the stale value?
> >> Yes,non-cacheable. The cache line corresponding to function enter_vhe() was
> >> marked with shareable & WB-cache as a result of write to RELA, the same cache
> >> line is being fetched with non-shareable & non-cacheable. The eviction is
> >> not pushed to PoC and got dropped because of cache-line attributes mismatch.
> > I'm really struggling to understand this. Why is the instruction fetch
> > non-shareable? I'm trying to align your observations with the rules about
> > mismatched aliases in the architecture and I'm yet to satisfy myself that
> > the CPU is allowed to drop a dirty line on the floor in response to an
> > unexpected hit.
> >
> > My mental model (which seems to align with Marc) is something like:
> >
> >
> > 1. The boot CPU fetches the line via a cacheable mapping and dirties it
> >    in its L1 as part of applying the relocations.
> 
> ARM-CPU core is sending ReadNotSharedDirty CHI command to LLC (last-level-cache).
> This cache-line is marked as checked-out in LLC, would be used to keep track
> of coherency.

Oh man, that CHI stuff always sends me into a spin so I'm probably not the
right person to debug it, but let's see...

> > 2. The boot CPU then enters EL2 with the MMU off and fetches the same
> >    line on the I-side. AFAICT, the architecture says this is done with
> >    outer-shareable, non-cacheable attributes.
> 
> ARM-CPU core is sending ReadNoSnoop CHI command when MMU disabled. The
> marked cache-line from the step 1) become invalid in LLC.

When you say "invalid" here, do you mean in the same sense as "cache
invalidation"? Why is that the right thing to do in response to a _read_?

Would the same invalidation happen if the ReadNoSnoop originated from a
different CPU?

> As per the ARM-ARM specification, CMO is recommended whenever memory
> attributes are changed for a given memory region.

The mismatched attribute section (B2.8) is quite a lot more nuanced than
that, and in particular I don't see it allowing for writes to be lost
in the presence of a mismatched read. Then again, the whole section is
hard to follow and doesn't really call out instruction fetch other than
in a note at the end.

> With my understating the CPU core must generate coherent accesses for
> Shared+Cacheable memory but not clear for OSH+non-cacheable regions
> in the spec.

Ok, but we don't need the reloc to be visible to the MMU-off fetch in
the case you're describing so coherency between the two aliases is not
required. The problem is that the cacheable data is being lost forever,
so even cacheable accesses can't retrieve it.

> Are you expecting "OSH+non-cacheable" must generate coherent accesses?
> 
> > 3. !!! Somehow the instruction fetch results in the _dirty_ line from (1)
> >        being discarded !!!
> 
> The ARM-CPU is sending WritebackFull CHI command to LLC for the cache line
> which was marked as invalid from step 2). The write CMD is ignored/dropped.

Is this because the LLC is inclusive and doesn't know what to do with the
writeback after invalidating the line earlier on? When else would a
writeback get silently dropped?

Stepping back a bit, my concern with all of this is that it seems as though
non-cacheable instruction fetches that alias with dirty lines on the data
side can lead to data loss. This feels like a significantly broader issue
than the relocation case you've run into, particularly as instruction fetch
with the MMU off is still permitted to fetch speculatively from within a
couple of pages of the PC. Cache maintenance doesn't feel like a viable
solution in general, as we'd need to ensure that no fetch occurs between
the write and the CMO, and this could occur on another CPU, off the back
of an IRQ or even a FIQ (with the fetch being made at a different exception
level).

Given that you have all the low-level details about the problem, it would
probably be worth pulling Arm into this so we can figure out what the right
solution is. I'm happy to be involved with that, if you like.

Will
