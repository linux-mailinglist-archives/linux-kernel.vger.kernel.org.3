Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41F44A7498
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245093AbiBBP3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:29:39 -0500
Received: from foss.arm.com ([217.140.110.172]:37926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbiBBP3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:29:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BFB9113E;
        Wed,  2 Feb 2022 07:29:37 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCD4E3F73B;
        Wed,  2 Feb 2022 07:29:35 -0800 (PST)
Date:   Wed, 2 Feb 2022 15:29:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, will@kernel.org
Subject: Re: [PATCH 5/6] sched/preempt: add PREEMPT_DYNAMIC using static keys
Message-ID: <YfqjXBgZuNos2nqF@FVFF77S0Q05N>
References: <20211109172408.49641-1-mark.rutland@arm.com>
 <20211109172408.49641-6-mark.rutland@arm.com>
 <20211213220501.GB786870@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213220501.GB786870@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:05:01PM +0100, Frederic Weisbecker wrote:
> On Tue, Nov 09, 2021 at 05:24:07PM +0000, Mark Rutland wrote:
> > Where an architecture selects HAVE_STATIC_CALL but not
> > HAVE_STATIC_CALL_INLINE, each static call has an out-of-line trampoline
> > which will either branch to a callee or return to the caller.
> > 
> > On such architectures, a number of constraints can conspire to make
> > those trampolines more complicated and potentially less useful than we'd
> > like. For example:
> > 
> > * Hardware and software control flow integrity schemes can require the
> >   additition of "landing pad" instructions (e.g. `BTI` for arm64), which
> >   will also be present at the "real" callee.
> > 
> > * Limited branch ranges can require that trampolines generate or load an
> >   address into a registter and perform an indirect brach (or at least
> >   have a slow path that does so). This loses some of the benefits of
> >   having a direct branch.
> > 
> > * Interaction with SW CFI schemes can be complicated and fragile, e.g.
> >   requiring that we can recognise idiomatic codegen and remove
> >   indirections understand, at least until clang proves more helpful
> >   mechanisms for dealing with this.
> > 
> > For PREEMPT_DYNAMIC, we don't need the full power of static calls, as we
> > really only need to enable/disable specific preemption functions. We can
> > achieve the same effect without a number of the pain points above by
> > using static keys to fold early return cases into the preemption
> > functions themselves rather than in an out-of-line trampoline,
> > effectively inlining the trampoline into the start of the function.
> > 
> > For arm64, this results in good code generation, e.g. the
> > dynamic_cond_resched() wrapper looks as follows (with the first `B` being
> > replaced with a `NOP` when the function is disabled):
> > 
> > | <dynamic_cond_resched>:
> > |        bti     c
> > |        b       <dynamic_cond_resched+0x10>
> > |        mov     w0, #0x0                        // #0
> > |        ret
> > |        mrs     x0, sp_el0
> > |        ldr     x0, [x0, #8]
> > |        cbnz    x0, <dynamic_cond_resched+0x8>
> > |        paciasp
> > |        stp     x29, x30, [sp, #-16]!
> > |        mov     x29, sp
> > |        bl      <preempt_schedule_common>
> > |        mov     w0, #0x1                        // #1
> > |        ldp     x29, x30, [sp], #16
> > |        autiasp
> > |        ret
> > 
> > ... compared to the regular form of the function:
> > 
> > | <__cond_resched>:
> > |        bti     c
> > |        mrs     x0, sp_el0
> > |        ldr     x1, [x0, #8]
> > |        cbz     x1, <__cond_resched+0x18>
> > |        mov     w0, #0x0                        // #0
> > |        ret
> > |        paciasp
> > |        stp     x29, x30, [sp, #-16]!
> > |        mov     x29, sp
> > |        bl      <preempt_schedule_common>
> > |        mov     w0, #0x1                        // #1
> > |        ldp     x29, x30, [sp], #16
> > |        autiasp
> > |        ret
> > 
> > Any architecture which implements static keys should be able to use this
> > to implement PREEMPT_DYNAMIC with similar cost to non-inlined static
> > calls.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> 
> Anyone has an opinion on that? Can we do better on the arm64 static call side
> or should we resign ourself to using that static keys direction?

From speaking with other arm64 folk, I think we're agreed that this is
preferable to implementing static calls (especially givne the pain points with
interaction with CFI).

I don't think it's fair to say we're "resigning outselves" to using static keys
-- this is vastly simpler to implement and maintain the static call approach,
should perform no worse than the form of static call trampolines that we'd have
to implement for static calls, and makes it easier for architectures to enable
PREEMPT_DYNAMIC, so it seems like an all-round win.

> Also I assume that, sooner or later, arm64 will eventually need a static call
> implementation....

I really hope not, becuase the current design of static calls (with arbitrary
targets) is not a great fit for arm64.

The only other major use for static keys on the arm64 side is for tracing
hooks, and that's *purely* to avoid the overhead that the current clang CFI
scheme imposes for modules. For that I'd rather fix the CFI scheme, because
that also interacts poorly with static calls to begin with...

Thanks,
Mark.
