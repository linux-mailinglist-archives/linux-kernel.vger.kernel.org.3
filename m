Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598B9521642
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 15:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiEJNGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242186AbiEJNF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:05:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F7C126194A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:01:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47B3023A;
        Tue, 10 May 2022 06:01:59 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.1.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D27493F73D;
        Tue, 10 May 2022 06:01:57 -0700 (PDT)
Date:   Tue, 10 May 2022 14:01:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 05/13] stackleak: clarify variable names
Message-ID: <YnpiPWYqkA7RW3lm@FVFF77S0Q05N>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-6-mark.rutland@arm.com>
 <e1cf0177-40a0-ffca-6be4-57fd97860c4a@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1cf0177-40a0-ffca-6be4-57fd97860c4a@linux.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 11:49:46PM +0300, Alexander Popov wrote:
> On 27.04.2022 20:31, Mark Rutland wrote:
> > The logic within __stackleak_erase() can be a little hard to follow, as
> > `boundary` switches from being the low bound to the high bound mid way
> > through the function, and `kstack_ptr` is used to represent the start of
> > the region to erase while `boundary` represents the end of the region to
> > erase.
> > 
> > Make this a little clearer by consistently using clearer variable names.
> > The `boundary` variable is removed, the bounds of the region to erase
> > are described by `erase_low` and `erase_high`, and bounds of the task
> > stack are described by `task_stack_low` and `task_stck_high`.
> 
> A typo here in `task_stck_high`.

Ah; whoops.

> > As the same time, remove the comment above the variables, since it is
> > unclear whether it's intended as rationale, a complaint, or a TODO, and
> > is more confusing than helpful.
> 
> Yes, this comment is a bit confusing :) I can elaborate.
> 
> In the original grsecurity patch, the stackleak erasing was written in asm.
> When I adopted it and proposed for the upstream, Linus strongly opposed this.
> So I developed stackleak erasing in C.
> 
> And I wrote this comment to remember that having 'kstack_ptr' and 'boundary'
> variables on the stack (which we are clearing) would not be good.

Ok, so I think that falls into the "complaint" bucket I mentioned. I understand
that we don't have any guarantee from the compiler as to how it will use the
stack, and that's obviously a potential problem.

> That was also the main reason why I reused the 'boundary' variable: I wanted
> the compiler to allocate it in the register and I avoided creating many
> local variables.
>
> Mark, did your refactoring make the compiler allocate local variables on the
> stack instead of the registers?

Considering the whole series, testing with GCC 11.1.0:

* On arm64:
     before: stackleak_erase() uses 48 bytes of stack
     after: stackleak_erase() uses 0 bytes of stack

     Note: this is entirely due to patch 1; arm64 has enough GPRs that it
     doesn't need to use the stack.

* On x86_64:
     before: stackleak_erase() uses 0 bytes of stack
     after:  stackleak_erase() uses 0 bytes of stack

* On i386
     before: stackleak_erase() uses 8 bytes of stach
     after:  stackleak_erase() uses 16 bytes of stack

The i386 case isn't ideal, but given that those bytes will easily be used by
the entry triage code before getting to any syscall handling, I don't believe
that's an issue in practice.

Thanks,
Mark.

> > There should be no functional change as a result of this patch.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Popov <alex.popov@linux.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >   kernel/stackleak.c | 30 ++++++++++++++----------------
> >   1 file changed, 14 insertions(+), 16 deletions(-)
> > 
> > diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> > index 24b7cf01b2972..d5f684dc0a2d9 100644
> > --- a/kernel/stackleak.c
> > +++ b/kernel/stackleak.c
> > @@ -73,40 +73,38 @@ late_initcall(stackleak_sysctls_init);
> >   static __always_inline void __stackleak_erase(void)
> >   {
> >   	const unsigned long task_stack_low = stackleak_task_low_bound(current);
> > -
> > -	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
> > -	unsigned long kstack_ptr = current->lowest_stack;
> > -	unsigned long boundary = task_stack_low;
> > +	unsigned long erase_low = current->lowest_stack;
> > +	unsigned long erase_high;
> >   	unsigned int poison_count = 0;
> >   	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
> >   	/* Search for the poison value in the kernel stack */
> > -	while (kstack_ptr > boundary && poison_count <= depth) {
> > -		if (*(unsigned long *)kstack_ptr == STACKLEAK_POISON)
> > +	while (erase_low > task_stack_low && poison_count <= depth) {
> > +		if (*(unsigned long *)erase_low == STACKLEAK_POISON)
> >   			poison_count++;
> >   		else
> >   			poison_count = 0;
> > -		kstack_ptr -= sizeof(unsigned long);
> > +		erase_low -= sizeof(unsigned long);
> >   	}
> >   #ifdef CONFIG_STACKLEAK_METRICS
> > -	current->prev_lowest_stack = kstack_ptr;
> > +	current->prev_lowest_stack = erase_low;
> >   #endif
> >   	/*
> > -	 * Now write the poison value to the kernel stack. Start from
> > -	 * 'kstack_ptr' and move up till the new 'boundary'. We assume that
> > -	 * the stack pointer doesn't change when we write poison.
> > +	 * Now write the poison value to the kernel stack between 'erase_low'
> > +	 * and 'erase_high'. We assume that the stack pointer doesn't change
> > +	 * when we write poison.
> >   	 */
> >   	if (on_thread_stack())
> > -		boundary = current_stack_pointer;
> > +		erase_high = current_stack_pointer;
> >   	else
> > -		boundary = current_top_of_stack();
> > +		erase_high = current_top_of_stack();
> > -	while (kstack_ptr < boundary) {
> > -		*(unsigned long *)kstack_ptr = STACKLEAK_POISON;
> > -		kstack_ptr += sizeof(unsigned long);
> > +	while (erase_low < erase_high) {
> > +		*(unsigned long *)erase_low = STACKLEAK_POISON;
> > +		erase_low += sizeof(unsigned long);
> >   	}
> >   	/* Reset the 'lowest_stack' value for the next syscall */
> 
