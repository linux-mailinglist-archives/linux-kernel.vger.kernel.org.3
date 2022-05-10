Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6452139B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbiEJL0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbiEJL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:26:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC4882A3740
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:22:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A16D811FB;
        Tue, 10 May 2022 04:22:29 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.1.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CD5F3F66F;
        Tue, 10 May 2022 04:22:28 -0700 (PDT)
Date:   Tue, 10 May 2022 12:22:18 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 06/13] stackleak: rework stack high bound handling
Message-ID: <YnpK6ju2FkzagbPY@FVFF77S0Q05N>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-7-mark.rutland@arm.com>
 <ff36f701-6950-b923-c4f5-d6182bdc7534@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff36f701-6950-b923-c4f5-d6182bdc7534@linux.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 12:27:22AM +0300, Alexander Popov wrote:
> On 27.04.2022 20:31, Mark Rutland wrote:
> > Prior to returning to userpace, we reset current->lowest_stack to a
> > reasonable high bound. Currently we do this by subtracting the arbitrary
> > value `THREAD_SIZE/64` from the top of the stack, for reasons lost to
> > history.
> > 
> > Looking at configurations today:
> > 
> > * On i386 where THREAD_SIZE is 8K, the bound will be 128 bytes. The
> >    pt_regs at the top of the stack is 68 bytes (with 0 to 16 bytes of
> >    padding above), and so this covers an additional portion of 44 to 60
> >    bytes.
> > 
> > * On x86_64 where THREAD_SIZE is at least 16K (up to 32K with KASAN) the
> >    bound will be at least 256 bytes (up to 512 with KASAN). The pt_regs
> >    at the top of the stack is 168 bytes, and so this cover an additional
> >    88 bytes of stack (up to 344 with KASAN).
> > 
> > * On arm64 where THREAD_SIZE is at least 16K (up to 64K with 64K pages
> >    and VMAP_STACK), the bound will be at least 256 bytes (up to 1024 with
> >    KASAN). The pt_regs at the top of the stack is 336 bytes, so this can
> >    fall within the pt_regs, or can cover an additional 688 bytes of
> >    stack.
> > 
> > Clearly the `THREAD_SIZE/64` value doesn't make much sense -- in the
> > worst case, this will cause more than 600 bytes of stack to be erased
> > for every syscall, even if actual stack usage were substantially
> > smaller.
> > 
> > This patches makes this slightly less nonsensical by consistently
> > resetting current->lowest_stack to the base of the task pt_regs. For
> > clarity and for consistency with the handling of the low bound, the
> > generation of the high bound is split into a helper with commentary
> > explaining why.
> > 
> > Since the pt_regs at the top of the stack will be clobbered upon the
> > next exception entry, we don't need to poison these at exception exit.
> > By using task_pt_regs() as the high stack boundary instead of
> > current_top_of_stack() we avoid some redundant poisoning, and the
> > compiler can share the address generation between the poisoning and
> > restting of `current->lowest_stack`, making the generated code more
> > optimal.
> > 
> > It's not clear to me whether the existing `THREAD_SIZE/64` offset was a
> > dodgy heuristic to skip the pt_regs, or whether it was attempting to
> > minimize the number of times stackleak_check_stack() would have to
> > update `current->lowest_stack` when stack usage was shallow at the cost
> > of unconditionally poisoning a small portion of the stack for every exit
> > to userspace.
> 
> I inherited this 'THREAD_SIZE/64' logic is from the original grsecurity patch.
> As I mentioned, originally this was written in asm.
> 
> For x86_64:
> 	mov	TASK_thread_sp0(%r11), %rdi
> 	sub	$256, %rdi
> 	mov	%rdi, TASK_lowest_stack(%r11)
> 
> For x86_32:
> 	mov TASK_thread_sp0(%ebp), %edi
> 	sub $128, %edi
> 	mov %edi, TASK_lowest_stack(%ebp)
> 
> 256 bytes for x86_64 and 128 bytes for x86_32 are exactly THREAD_SIZE/64.

To check my understanding, did you come up with the `THREAD_SIZE/64`
calculation from reverse-engineering the assembly?

I strongly suspect that has nothing to do with THEAD_SIZE, and was trying to
fall just below the task's pt_regs (and maybe some unconditional stack usage
just below that).

> I think this value was chosen as optimal for minimizing poison scanning.
> It's possible that stackleak_track_stack() is not called during the syscall
> because all the called functions have small stack frames.

I can believe that, but given the clearing cost appears to dominate the
scanning cost, I suspect we can live with making this precisely the bottom of
the pt_regs.

> > For now I've simply removed the offset, and if we need/want to minimize
> > updates for shallow stack usage it should be easy to add a better
> > heuristic atop, with appropriate commentary so we know what's going on.
> 
> I like your idea to erase the thread stack up to pt_regs if we call the
> stackleak erasing from the trampoline stack.
> 
> But here I don't understand where task_pt_regs() points to...

As mentioned in the commit message, there's a struct pt_regs at the top of each
task stack (created at exception entry, and consumed by exception return),
which contains the user register state. On arm64 and x86_64, that's *right* at
the top of the stack, but on i386 there can be some padding above that.
task_pt_regs(tsk) points at the base of that pt_regs.

That looks something like the following (with increasing addresses going
upwards):

  ----------------   <--- task_stack_page(tsk) + THREAD_SIZE
  (optional padding)
  ----------------   <--- task_top_of_stack(tsk) // x86 only
      /\
      ||
      || pt_regs
      ||
      \/
  ----------------   <--- task_pt_regs(tsk)
      /\
      ||
      ||
      ||
      || Usable task stack
      ||
      ||
      ||
      \/ 
  ----------------
  STACK_END_MAGIC
  ----------------   <--- task_stack_page(tsk)

Thanks,
Mark.

> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Popov <alex.popov@linux.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >   include/linux/stackleak.h | 14 ++++++++++++++
> >   kernel/stackleak.c        | 19 ++++++++++++++-----
> >   2 files changed, 28 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
> > index 67430faa5c518..467661aeb4136 100644
> > --- a/include/linux/stackleak.h
> > +++ b/include/linux/stackleak.h
> > @@ -28,6 +28,20 @@ stackleak_task_low_bound(const struct task_struct *tsk)
> >   	return (unsigned long)end_of_stack(tsk) + sizeof(unsigned long);
> >   }
> > +/*
> > + * The address immediately after the highest address on tsk's stack which we
> > + * can plausibly erase.
> > + */
> > +static __always_inline unsigned long
> > +stackleak_task_high_bound(const struct task_struct *tsk)
> > +{
> > +	/*
> > +	 * The task's pt_regs lives at the top of the task stack and will be
> > +	 * overwritten by exception entry, so there's no need to erase them.
> > +	 */
> > +	return (unsigned long)task_pt_regs(tsk);
> > +}
> > +
> >   static inline void stackleak_task_init(struct task_struct *t)
> >   {
> >   	t->lowest_stack = stackleak_task_low_bound(t);
> > diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> > index d5f684dc0a2d9..ba346d46218f5 100644
> > --- a/kernel/stackleak.c
> > +++ b/kernel/stackleak.c
> > @@ -73,6 +73,7 @@ late_initcall(stackleak_sysctls_init);
> >   static __always_inline void __stackleak_erase(void)
> >   {
> >   	const unsigned long task_stack_low = stackleak_task_low_bound(current);
> > +	const unsigned long task_stack_high = stackleak_task_high_bound(current);
> >   	unsigned long erase_low = current->lowest_stack;
> >   	unsigned long erase_high;
> >   	unsigned int poison_count = 0;
> > @@ -93,14 +94,22 @@ static __always_inline void __stackleak_erase(void)
> >   #endif
> >   	/*
> > -	 * Now write the poison value to the kernel stack between 'erase_low'
> > -	 * and 'erase_high'. We assume that the stack pointer doesn't change
> > -	 * when we write poison.
> > +	 * Write poison to the task's stack between 'erase_low' and
> > +	 * 'erase_high'.
> > +	 *
> > +	 * If we're running on a different stack (e.g. an entry trampoline
> > +	 * stack) we can erase everything below the pt_regs at the top of the
> > +	 * task stack.
> > +	 *
> > +	 * If we're running on the task stack itself, we must not clobber any
> > +	 * stack used by this function and its caller. We assume that this
> > +	 * function has a fixed-size stack frame, and the current stack pointer
> > +	 * doesn't change while we write poison.
> >   	 */
> >   	if (on_thread_stack())
> >   		erase_high = current_stack_pointer;
> >   	else
> > -		erase_high = current_top_of_stack();
> > +		erase_high = task_stack_high;
> >   	while (erase_low < erase_high) {
> >   		*(unsigned long *)erase_low = STACKLEAK_POISON;
> > @@ -108,7 +117,7 @@ static __always_inline void __stackleak_erase(void)
> >   	}
> >   	/* Reset the 'lowest_stack' value for the next syscall */
> > -	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
> > +	current->lowest_stack = task_stack_high;
> >   }
> >   asmlinkage void noinstr stackleak_erase(void)
> 
