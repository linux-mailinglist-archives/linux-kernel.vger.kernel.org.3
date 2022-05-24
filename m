Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C41532B58
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbiEXNcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiEXNcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:32:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDE9331C
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 06:32:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 809751FB;
        Tue, 24 May 2022 06:32:03 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7026A3F70D;
        Tue, 24 May 2022 06:32:01 -0700 (PDT)
Date:   Tue, 24 May 2022 14:31:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 07/13] stackleak: rework poison scanning
Message-ID: <YozeTA/69F7rYvVi@FVFF77S0Q05N>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-8-mark.rutland@arm.com>
 <268ea8f7-472b-f1d4-6b8b-0c8fefccc0fa@linux.com>
 <YnplFtdEr8dBOvZU@FVFF77S0Q05N>
 <02e40030-52a5-f23c-85be-be59a7d3211c@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e40030-52a5-f23c-85be-be59a7d3211c@linux.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 08:33:01PM +0300, Alexander Popov wrote:
> On 10.05.2022 16:13, Mark Rutland wrote:
> > On Mon, May 09, 2022 at 04:51:35PM +0300, Alexander Popov wrote:
> > > Hello Mark!
> > > 
> > > On 27.04.2022 20:31, Mark Rutland wrote:
> > > > Currently we over-estimate the region of stack which must be erased.
> > > > 
> > > > To determine the region to be erased, we scan downards for a contiguous
> > > > block of poison values (or the low bound of the stack). There are a few
> > > > minor problems with this today:
> > > > 
> > > > * When we find a block of poison values, we include this block within
> > > >     the region to erase.
> > > > 
> > > >     As this is included within the region to erase, this causes us to
> > > >     redundantly overwrite 'STACKLEAK_SEARCH_DEPTH' (128) bytes with
> > > >     poison.
> > > 
> > > Right, this can be improved.
> > > 
> > > > * As the loop condition checks 'poison_count <= depth', it will run an
> > > >     additional iteration after finding the contiguous block of poison,
> > > >     decrementing 'erase_low' once more than necessary.
> > > 
> > > Actually, I think the current code is correct.
> > > 
> > > I'm intentionally searching one poison value more than
> > > STACKLEAK_SEARCH_DEPTH to avoid the corner case. See the BUILD_BUG_ON
> > > assertion in stackleak_track_stack() that describes it:
> > > 
> > > /*
> > >   * Having CONFIG_STACKLEAK_TRACK_MIN_SIZE larger than
> > >   * STACKLEAK_SEARCH_DEPTH makes the poison search in
> > >   * stackleak_erase() unreliable. Let's prevent that.
> > >   */
> > > BUILD_BUG_ON(CONFIG_STACKLEAK_TRACK_MIN_SIZE > STACKLEAK_SEARCH_DEPTH);
> > 
> > I had read that, but as written that doesn't imply that it's necessary to scan
> > one more element than STACKLEAK_SEARCH_DEPTH, nor why. I'm more than happy to
> > change the logic, but I think we need a very clear explanation as to why we
> > need to scan the specific number of bytes we scan, and we should account for
> > that *within* STACKLEAK_SEARCH_DEPTH for clarity.
> 
> I'll try to explain.
> 
> The stackleak gcc plugin instruments the kernel code inserting the
> 'stackleak_track_stack()' calls for the functions with a stack frame size
> greater than or equal to CONFIG_STACKLEAK_TRACK_MIN_SIZE.
> 
> The kernel functions with a smaller stack frame are not instrumented (the
> 'lowest_stack' value is not updated for them).

I understood these points.

It's also worth noting that `noinstr` code will also not be instrumented
regardless of frame size -- we might want some build-time assertion for those.

> Any kernel function may leave uninitialized data on its stack frame. The
> poison scanning must handle that correctly. The uninitialized groups of
> poison values must be smaller than the search depth, otherwise
> 'stackleak_erase()' is unreliable.

I had understood this, but I had understood that for a caller->callee pair,
*something* would be pushed onto the stack. On arm64 that'd be a frame record
in the caller's stack frame, and on x86 that would be the return address
between the stack frames of the caller and callee. Since any unrecorded frame
is less than CONFIG_STACKLEAK_TRACK_MIN_SIZE, the non-poison bytes would fall
within CONFIG_STACKLEAK_TRACK_MIN_SIZE bytes.

There is a potential edge case on arm64, since the frame record is permitted to
be placed anywhere within the stack frame, and in theory it could be placed
high on the caller and low on the callee. If we wanted to handle that, we'd
need to scan 2 times the tracking size. In practice compilers consistently
place the frame record at one end (usually the low end, as part of constructing
the frame).

> So with this BUILD_BUG_ON I control that
>   CONFIG_STACKLEAK_TRACK_MIN_SIZE <= STACKLEAK_SEARCH_DEPTH.
> 
> To be sure and avoid mistakes in the edge cases, 'stackleak_erase()' is
> searching one poison value more than STACKLEAK_SEARCH_DEPTH.

Just to check my understanding, did you have a specific edge-case in mind, or
was that "just in case"?

It would be really nice if we had an example.

> If you don't like this one additional poison value in the search, I would
> propose to change the assertion.

If we clearly document *why*, then changing the assertion is fine by me.
However, as above I don't think that this is necessary.

As an aside, why is it possible to configure CONFIG_STACKLEAK_TRACK_MIN_SIZE to
be bigger than STACKLEAK_SEARCH_DEPTH in the first place?

In security/Kconfig.hardening we have:

| config STACKLEAK_TRACK_MIN_SIZE
|         int "Minimum stack frame size of functions tracked by STACKLEAK"
|         default 100 
|         range 0 4096
|         depends on GCC_PLUGIN_STACKLEAK
|         help
|           The STACKLEAK gcc plugin instruments the kernel code for tracking
|           the lowest border of the kernel stack (and for some other purposes).
|           It inserts the stackleak_track_stack() call for the functions with
|           a stack frame size greater than or equal to this parameter.
|           If unsure, leave the default value 100.

... where the vast majority of that range is going to lead to a BUILD_BUG().

Thanks,
Mark.

> What do you think?
> 
> > > >     As this is included within the region to erase, this causes us to
> > > >     redundantly overwrite an additional unsigned long with poison.
> > > > 
> > > > * As we always decrement 'erase_low' after checking an element on the
> > > >     stack, we always include the element below this within the region to
> > > >     erase.
> > > > 
> > > >     As this is included within the region to erase, this causes us to
> > > >     redundantly overwrite an additional unsigned long with poison.
> > > > 
> > > >     Note that this is not a functional problem. As the loop condition
> > > >     checks 'erase_low > task_stack_low', we'll never clobber the
> > > >     STACK_END_MAGIC. As we always decrement 'erase_low' after this, we'll
> > > >     never fail to erase the element immediately above the STACK_END_MAGIC.
> > > 
> > > Right, I don't see any bug in the current erasing code.
> > > 
> > > When I wrote the current code, I carefully checked all the corner cases. For
> > > example, on the first stack erasing, the STACK_END_MAGIC was not
> > > overwritten, but the memory next to it was erased. Same for the beginning of
> > > the stack: I carefully checked that no unpoisoned bytes were left on the
> > > thread stack.
> > > 
> > > > In total, this can cause us to erase `128 + 2 * sizeof(unsigned long)`
> > > > bytes more than necessary, which is unfortunate.
> > > > 
> > > > This patch reworks the logic to find the address immediately above the
> > > > poisoned region, by finding the lowest non-poisoned address. This is
> > > > factored into a stackleak_find_top_of_poison() helper both for clarity
> > > > and so that this can be shared with the LKDTM test in subsequent
> > > > patches.
> > > 
> > > You know, I wrote stackleak_erase() in very plain C. I wanted a compiler to
> > > generate assembly that is very close to the original asm version. I worried
> > > that compilers might do weird stuff with the local variables and the stack
> > > pointer.
> > > 
> > > So I checked stackleak for gcc versions 4.8, 5, 6, 7, 8, 9, and 10 on
> > > x86_64, i386 and arm64. This is my project that helped with this work:
> > > https://github.com/a13xp0p0v/kernel-build-containers
> > 
> > I've used the kernel.org cross toolchains, as published at:
> > 
> >    https://mirrors.edge.kernel.org/pub/tools/crosstool/
> > 
> > > Mark, in this patch series you use many local variables and helper functions.
> > > Honestly, this worries me. For example, compilers can (and usually do)
> > > ignore the presence of the 'inline' specifier for the purpose of
> > > optimization.
> > 
> > I've deliberately used `__always_inline` rather than regular `inline` to
> > prevent code being placed out-of-line. As mentioned in oether replies it has a
> > stronger semantic.
> > 
> > Thanks,
> > Mark.
> > 
> > > 
> > > Thanks!
> > > 
> > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Alexander Popov <alex.popov@linux.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >    include/linux/stackleak.h | 26 ++++++++++++++++++++++++++
> > > >    kernel/stackleak.c        | 18 ++++--------------
> > > >    2 files changed, 30 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
> > > > index 467661aeb4136..c36e7a3b45e7e 100644
> > > > --- a/include/linux/stackleak.h
> > > > +++ b/include/linux/stackleak.h
> > > > @@ -42,6 +42,32 @@ stackleak_task_high_bound(const struct task_struct *tsk)
> > > >    	return (unsigned long)task_pt_regs(tsk);
> > > >    }
> > > > +/*
> > > > + * Find the address immediately above the poisoned region of the stack, where
> > > > + * that region falls between 'low' (inclusive) and 'high' (exclusive).
> > > > + */
> > > > +static __always_inline unsigned long
> > > > +stackleak_find_top_of_poison(const unsigned long low, const unsigned long high)
> > > > +{
> > > > +	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
> > > > +	unsigned int poison_count = 0;
> > > > +	unsigned long poison_high = high;
> > > > +	unsigned long sp = high;
> > > > +
> > > > +	while (sp > low && poison_count < depth) {
> > > > +		sp -= sizeof(unsigned long);
> > > > +
> > > > +		if (*(unsigned long *)sp == STACKLEAK_POISON) {
> > > > +			poison_count++;
> > > > +		} else {
> > > > +			poison_count = 0;
> > > > +			poison_high = sp;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return poison_high;
> > > > +}
> > > > +
> > > >    static inline void stackleak_task_init(struct task_struct *t)
> > > >    {
> > > >    	t->lowest_stack = stackleak_task_low_bound(t);
> > > > diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> > > > index ba346d46218f5..afd54b8e10b83 100644
> > > > --- a/kernel/stackleak.c
> > > > +++ b/kernel/stackleak.c
> > > > @@ -74,20 +74,10 @@ static __always_inline void __stackleak_erase(void)
> > > >    {
> > > >    	const unsigned long task_stack_low = stackleak_task_low_bound(current);
> > > >    	const unsigned long task_stack_high = stackleak_task_high_bound(current);
> > > > -	unsigned long erase_low = current->lowest_stack;
> > > > -	unsigned long erase_high;
> > > > -	unsigned int poison_count = 0;
> > > > -	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
> > > > -
> > > > -	/* Search for the poison value in the kernel stack */
> > > > -	while (erase_low > task_stack_low && poison_count <= depth) {
> > > > -		if (*(unsigned long *)erase_low == STACKLEAK_POISON)
> > > > -			poison_count++;
> > > > -		else
> > > > -			poison_count = 0;
> > > > -
> > > > -		erase_low -= sizeof(unsigned long);
> > > > -	}
> > > > +	unsigned long erase_low, erase_high;
> > > > +
> > > > +	erase_low = stackleak_find_top_of_poison(task_stack_low,
> > > > +						 current->lowest_stack);
> > > >    #ifdef CONFIG_STACKLEAK_METRICS
> > > >    	current->prev_lowest_stack = erase_low;
> > > 
> 
