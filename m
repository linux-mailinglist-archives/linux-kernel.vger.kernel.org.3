Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AD8508584
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377498AbiDTKLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242267AbiDTKK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:10:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91481D321
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D6F06172E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C0AC385A0;
        Wed, 20 Apr 2022 10:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650449290;
        bh=f6z1gXeiJBl2KVrH55r4CWpl47NKlUNpy2tVGwsjx2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYtjYbNtRHcOJfIrBZEa2JEs7WhJLuCzqWDk5GoHzkmoa7t5D6gJNcJs9kPWuY0Go
         s+Kiiw8FKSZ0AHvMcxv8qSC67viPI4tZQQQc5JanQkTkQDtSyIK7/FD34m7oJm/Z3A
         TV+tQF0QQ+0WgDrihAdbQUwFYIFl93KKby2xR5mea3w+obqc5ei3NjkQ0Zi4d/EKlz
         T60k8aSfKse82LjUii+QY0lPDxgrNu2bCEqTfADvlBrP9mBsNQhMAcCH/z9gww2H3h
         QE8udVQDXaGueoY9OgQndJ4/j09NLYtZe3xUQ0ndQymWMdZkt+UgIcw4CV0mYD6VKt
         Rbhx/aY24RvTA==
Date:   Wed, 20 Apr 2022 11:08:04 +0100
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
Message-ID: <20220420100801.GA7235@willie-the-truck>
References: <20220415170504.3781878-1-sdonthineni@nvidia.com>
 <87y202agz9.wl-maz@kernel.org>
 <6b08ece9-64c0-9de9-9876-ed2dceee9bb0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b08ece9-64c0-9de9-9876-ed2dceee9bb0@nvidia.com>
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

On Mon, Apr 18, 2022 at 07:53:20AM -0500, Shanker R Donthineni wrote:
> On 4/18/22 4:16 AM, Marc Zyngier wrote:
> > External email: Use caution opening links or attachments

Ok.

> > On Fri, 15 Apr 2022 18:05:03 +0100,
> > Shanker Donthineni <sdonthineni@nvidia.com> wrote:
> >> The secondary cores boot is stuck due to data abort while executing the
> >> instruction 'ldr x8, =__secondary_switched'. The RELA value of this
> >> instruction was updated by a primary boot core from __relocate_kernel()
> >> but those memory updates are not visible to CPUs after calling
> >> switch_to_vhe() causing problem.
> >>
> >> The cacheable/shareable attributes of the identity-mapped regions are
> >> different while CPU executing in EL1 (MMU enabled) and for a short period
> >> of time in hyp-stub (EL2-MMU disabled). As per the ARM-ARM specification
> >> (DDI0487G_b), this is not allowed.
> >>
> >> G5.10.3 Cache maintenance requirement:
> >>  "If the change affects the cacheability attributes of the area of memory,
> >>  including any change between Write-Through and Write-Back attributes,
> >>  software must ensure that any cached copies of affected locations are
> >>  removed from the caches, typically by cleaning and invalidating the
> >>  locations from the levels of cache that might hold copies of the locations
> >>  affected by the attribute change."
> >>
> >> Clean+invalidate the identity-mapped region till PoC before switching to
> >> VHE world to fix the cache inconsistency.
> >>
> >> Problem analysis with disassembly (vmlinux):
> >>  1) Both __primary_switch() and enter_vhe() are part of the identity region
> >>  2) RELA entries and enter_vhe() are sharing the same cache line fff800010970480
> >>  3) Memory ffff800010970484-ffff800010970498 is updated with EL1-MMU enabled
> >>  4) CPU fetches intrsuctions of enter_vhe() with EL2-MMU disabled
> >>    - Non-coherent access causing the cache line fff800010970480 drop
> > Non-coherent? You mean non-cacheable, right? At this stage, we only
> > have a single CPU, so I'm not sure coherency is the problem here. When
> > you say 'drop', is that an eviction? Replaced by what? By the previous
> > version of the cache line, containing the stale value?
> Yes,non-cacheable. The cache line corresponding to function enter_vhe() was
> marked with shareable & WB-cache as a result of write to RELA, the same cache
> line is being fetched with non-shareable & non-cacheable. The eviction is
> not pushed to PoC and got dropped because of cache-line attributes mismatch.

I'm really struggling to understand this. Why is the instruction fetch
non-shareable? I'm trying to align your observations with the rules about
mismatched aliases in the architecture and I'm yet to satisfy myself that
the CPU is allowed to drop a dirty line on the floor in response to an
unexpected hit.

My mental model (which seems to align with Marc) is something like:


1. The boot CPU fetches the line via a cacheable mapping and dirties it
   in its L1 as part of applying the relocations.

2. The boot CPU then enters EL2 with the MMU off and fetches the same
   line on the I-side. AFAICT, the architecture says this is done with
   outer-shareable, non-cacheable attributes.

3. !!! Somehow the instruction fetch results in the _dirty_ line from (1)
       being discarded !!!

4. A secondary CPU later on fetches the line via a cacheable mapping and
   explodes because the relocation hasn't been applied.


Is that what you're seeing? If so, we really need more insight into what
is going on at step (3) because it feels like it could have a much more
significant impact than the issue we're trying to fix here. How is the line
dropped? Is it due to back invalidation from a shared cache? Is it due to
IDC snooping? Does the line actually stick around on the D-side, but somehow
the I-side is shared between CPUs?

Many questions...

Will
