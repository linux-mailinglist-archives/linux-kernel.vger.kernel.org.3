Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20C4A81F7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349963AbiBCJwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:52:02 -0500
Received: from foss.arm.com ([217.140.110.172]:35148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237370AbiBCJwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:52:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC91F113E;
        Thu,  3 Feb 2022 01:52:00 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EA263F40C;
        Thu,  3 Feb 2022 01:51:58 -0800 (PST)
Date:   Thu, 3 Feb 2022 09:51:46 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH 5/6] sched/preempt: add PREEMPT_DYNAMIC using static keys
Message-ID: <YfulsiWkphburRNX@FVFF77S0Q05N>
References: <20211109172408.49641-1-mark.rutland@arm.com>
 <20211109172408.49641-6-mark.rutland@arm.com>
 <20220202232145.GA461279@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202232145.GA461279@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 12:21:45AM +0100, Frederic Weisbecker wrote:
> On Tue, Nov 09, 2021 at 05:24:07PM +0000, Mark Rutland wrote:
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index e5359b09de1d..8a94ccfc7dc8 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -93,7 +93,7 @@ struct user;
> >  extern int __cond_resched(void);
> >  # define might_resched() __cond_resched()
> >  
> > -#elif defined(CONFIG_PREEMPT_DYNAMIC)
> > +#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
> >  
> >  extern int __cond_resched(void);
> >  
> > @@ -104,6 +104,11 @@ static __always_inline void might_resched(void)
> >  	static_call_mod(might_resched)();
> >  }
> >  
> > +#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> > +
> > +extern int dynamic_might_resched(void);
> > +# define might_resched() dynamic_might_resched()
> > +
> >  #else
> >  
> >  # define might_resched() do { } while (0)
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 78c351e35fec..7710b6593c72 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2008,7 +2008,7 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
> >  #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
> >  extern int __cond_resched(void);
> >  
> > -#ifdef CONFIG_PREEMPT_DYNAMIC
> > +#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
> >  
> >  DECLARE_STATIC_CALL(cond_resched, __cond_resched);
> >  
> > @@ -2017,6 +2017,14 @@ static __always_inline int _cond_resched(void)
> >  	return static_call_mod(cond_resched)();
> >  }
> >  
> > +#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> > +extern int dynamic_cond_resched(void);
> > +
> > +static __always_inline int _cond_resched(void)
> > +{
> > +	return dynamic_cond_resched();
> 
> So in the end this is creating an indirect call for every preemption entrypoint.

Huh? "indirect call" usually means a branch to a function pointer, and I don't
think that's what you mean here. Do you just mean that we add a (direct)
call+return?

This gets inlined, and will be just a direct call to dynamic_cond_resched().
e,g. on arm64 this will be a single instruction:

	bl	dynamic_cond_resched

... and (as the commit message desribes) then the implementation of
dynamic_cond_resched will be the same as the regular __cond_resched *but* the
static key trampoline is inlined at the start, e.g.

| <dynamic_cond_resched>:
|        bti     c
|        b       <dynamic_cond_resched+0x10>
|        mov     w0, #0x0                        // #0
|        ret
|        mrs     x0, sp_el0
|        ldr     x0, [x0, #8]
|        cbnz    x0, <dynamic_cond_resched+0x8>
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      <preempt_schedule_common>
|        mov     w0, #0x1                        // #1
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret

... compared to the regular form of the function:

| <__cond_resched>:
|        bti     c
|        mrs     x0, sp_el0
|        ldr     x1, [x0, #8]
|        cbz     x1, <__cond_resched+0x18>
|        mov     w0, #0x0                        // #0
|        ret
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      <preempt_schedule_common>
|        mov     w0, #0x1                        // #1
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret

> It seems to me that this loses the whole point of using static keys.

As above, I don't think that's the case. Relative to static keys using
trampolines (which is all arm64 can implement), the gain is that we inline the
trampoline into the *callee*. That saves on I-cache footprint, the compiler can
generate the early returns more optimally (and compatibly with an CFI scheme we
wish to use), and we don't have to maintain a separate patching mechanism.

If you think that static call trampolines lose the whole point of static keys
then we've lost to begin with, since that's all we can reasonably implement.

> Is there something that prevents from using inlines or macros?

Inlining of *what* ?

Thanks,
Mark.
