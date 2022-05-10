Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2EB5213E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbiEJLkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbiEJLkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:40:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8D2A5E75C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:36:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 955B611FB;
        Tue, 10 May 2022 04:36:10 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.1.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 297F43F66F;
        Tue, 10 May 2022 04:36:09 -0700 (PDT)
Date:   Tue, 10 May 2022 12:36:05 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 01/13] arm64: stackleak: fix current_top_of_stack()
Message-ID: <YnpOJX4SNmFvCogw@FVFF77S0Q05N>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-2-mark.rutland@arm.com>
 <3d65baac-93b6-7f21-1bf6-9b17d1fce843@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d65baac-93b6-7f21-1bf6-9b17d1fce843@linux.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 08:24:38PM +0300, Alexander Popov wrote:
> Hi Mark!
> 
> On 27.04.2022 20:31, Mark Rutland wrote:
> > Due to some historical confusion, arm64's current_top_of_stack() isn't
> > what the stackleak code expects. This could in theory result in a number
> > of problems, and practically results in an unnecessary performance hit.
> > We can avoid this by aligning the arm64 implementation with the x86
> > implementation.
> > 
> > The arm64 implementation of current_top_of_stack() was added
> > specifically for stackleak in commit:
> > 
> >    0b3e336601b82c6a ("arm64: Add support for STACKLEAK gcc plugin")
> > 
> > This was intended to be equivalent to the x86 implementation, but the
> > implementation, semantics, and performance characteristics differ
> > wildly:
> > 
> > * On x86, current_top_of_stack() returns the top of the current task's
> >    task stack, regardless of which stack is in active use.
> > 
> >    The implementation accesses a percpu variable which the x86 entry code
> >    maintains, and returns the location immediately above the pt_regs on
> >    the task stack (above which x86 has some padding).
> > 
> > * On arm64 current_top_of_stack() returns the top of the stack in active
> >    use (i.e. the one which is currently being used).
> > 
> >    The implementation checks the SP against a number of
> >    potentially-accessible stacks, and will BUG() if no stack is found.
> 
> As I could understand, for arm64, calling stackleak_erase() not from the
> thread stack would bring troubles because current_top_of_stack() would
> return an unexpected address from a foreign stack. Is this correct?

Yes.

> But this bug doesn't happen because arm64 always calls stackleak_erase()
> from the current thread stack. Right?

Yes.

> > The core stackleak_erase() code determines the upper bound of stack to
> > erase with:
> > 
> > | if (on_thread_stack())
> > |         boundary = current_stack_pointer;
> > | else
> > |         boundary = current_top_of_stack();
> > 
> > On arm64 stackleak_erase() is always called on a task stack, and
> > on_thread_stack() should always be true. On x86, stackleak_erase() is
> > mostly called on a trampoline stack, and is sometimes called on a task
> > stack.
> > 
> > Currently, this results in a lot of unnecessary code being generated for
> > arm64 for the impossible !on_thread_stack() case. Some of this is
> > inlined, bloating stackleak_erase(), while portions of this are left
> > out-of-line and permitted to be instrumented (which would be a
> > functional problem if that code were reachable).
> 
> Sorry, I didn't understand this part about instrumentation. Could you
> elaborate please?

Portions of the code are regular .text, and are subject to instrumentation by
KASAN/UBSAN/KCOV, ftrace, etc, where the compiler will (implicitly) insert
calls to out-of-line instrumentation callbacks. Some (but not all) of those are
disabled in the Makefile. For example, ftrace instrumentation is possible.

Generally, the instrumentation callbacks expect to run with a full kernel
environment (e.g. with RCU watching, IRQ tracing state correct), but at the
time stackleak_erase() is called, this is not the case. so those could go wrong
and corrupt state.

Additionally, since those calls are added implicitly by the compiler, they can
manipulate state at arbitrary points throughout the function where we might not
expect it (e.g. changing current->lowest_stack).

The general stance is that we should use noinstr to disable instrumentation,
and anything that needs to be inlined into noinstr needs to be marked with
__always_inline (which is guaranteed to either inline or cause a compile-time
error if it is not possible to inline).

This patch reworks things to avoid the potential problems; as per the commit
message I don't beleive anything goes wrong in practice today.

Thanks,
Mark.

> > As a first step towards improving this, this patch aligns arm64's
> > implementation of current_top_of_stack() with x86's, always returning
> > the top of the current task's stack. With GCC 11.1.0 this results in the
> > bulk of the unnecessary code being removed, including all of the
> > out-of-line instrumentable code.
> > 
> > While I don't believe there's a functional problem in practice I've
> > marked this as a fix since the semantic was clearly wrong, the fix
> > itself is simple, and other code might rely upon this in future.
> > 
> > Fixes: 0b3e336601b82c6a ("arm64: Add support for STACKLEAK gcc plugin")
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Popov <alex.popov@linux.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >   arch/arm64/include/asm/processor.h | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> > index 73e38d9a540ce..6b1a12c23fe77 100644
> > --- a/arch/arm64/include/asm/processor.h
> > +++ b/arch/arm64/include/asm/processor.h
> > @@ -381,12 +381,10 @@ long get_tagged_addr_ctrl(struct task_struct *task);
> >    * of header definitions for the use of task_stack_page.
> >    */
> > -#define current_top_of_stack()								\
> > -({											\
> > -	struct stack_info _info;							\
> > -	BUG_ON(!on_accessible_stack(current, current_stack_pointer, 1, &_info));	\
> > -	_info.high;									\
> > -})
> > +/*
> > + * The top of the current task's task stack
> > + */
> > +#define current_top_of_stack()	((unsigned long)current->stack + THREAD_SIZE)
> >   #define on_thread_stack()	(on_task_stack(current, current_stack_pointer, 1, NULL))
> >   #endif /* __ASSEMBLY__ */
> 
