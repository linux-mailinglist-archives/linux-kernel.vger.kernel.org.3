Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31504473733
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbhLMWFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243361AbhLMWFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:05:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0002C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:05:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72B356126E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 22:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39756C34600;
        Mon, 13 Dec 2021 22:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639433104;
        bh=Qf6Ek4AOVKGXkCaS8N754FOQ4GZ8VNQHP64V66crnEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZCzX39AH4q4ioXr/G3bKEcNN56zLDou2/2aV8RcQCyTQ1u/pd7+nymSI/ZHf/EX9
         Cz9yANRak/h0I32gKptVTMHGNMS2WLpMRiepFg9yJ0dqs9UHf9YR3iMRJElvonzfA4
         LQMX9/lXLIiUf+jp5BIfmrYVL8IyznK6uXOalXiEO63nUU2ut8wr4IHHaHYS/jfwhX
         MuhRME8kiEtNCPqj1fi9Jg3ylNAnRsVKAUYfUp5izF0H2VO4RUg18tAtaGlaVNcbI+
         7lRY4+KakBolGtoXdg2CCLarXf55bx7ORqpKMEd1WxUESVfQfGGnZTypJlABuxOyGC
         vux/qapmO4r+A==
Date:   Mon, 13 Dec 2021 23:05:01 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, will@kernel.org
Subject: Re: [PATCH 5/6] sched/preempt: add PREEMPT_DYNAMIC using static keys
Message-ID: <20211213220501.GB786870@lothringen>
References: <20211109172408.49641-1-mark.rutland@arm.com>
 <20211109172408.49641-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109172408.49641-6-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:24:07PM +0000, Mark Rutland wrote:
> Where an architecture selects HAVE_STATIC_CALL but not
> HAVE_STATIC_CALL_INLINE, each static call has an out-of-line trampoline
> which will either branch to a callee or return to the caller.
> 
> On such architectures, a number of constraints can conspire to make
> those trampolines more complicated and potentially less useful than we'd
> like. For example:
> 
> * Hardware and software control flow integrity schemes can require the
>   additition of "landing pad" instructions (e.g. `BTI` for arm64), which
>   will also be present at the "real" callee.
> 
> * Limited branch ranges can require that trampolines generate or load an
>   address into a registter and perform an indirect brach (or at least
>   have a slow path that does so). This loses some of the benefits of
>   having a direct branch.
> 
> * Interaction with SW CFI schemes can be complicated and fragile, e.g.
>   requiring that we can recognise idiomatic codegen and remove
>   indirections understand, at least until clang proves more helpful
>   mechanisms for dealing with this.
> 
> For PREEMPT_DYNAMIC, we don't need the full power of static calls, as we
> really only need to enable/disable specific preemption functions. We can
> achieve the same effect without a number of the pain points above by
> using static keys to fold early return cases into the preemption
> functions themselves rather than in an out-of-line trampoline,
> effectively inlining the trampoline into the start of the function.
> 
> For arm64, this results in good code generation, e.g. the
> dynamic_cond_resched() wrapper looks as follows (with the first `B` being
> replaced with a `NOP` when the function is disabled):
> 
> | <dynamic_cond_resched>:
> |        bti     c
> |        b       <dynamic_cond_resched+0x10>
> |        mov     w0, #0x0                        // #0
> |        ret
> |        mrs     x0, sp_el0
> |        ldr     x0, [x0, #8]
> |        cbnz    x0, <dynamic_cond_resched+0x8>
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mov     x29, sp
> |        bl      <preempt_schedule_common>
> |        mov     w0, #0x1                        // #1
> |        ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> 
> ... compared to the regular form of the function:
> 
> | <__cond_resched>:
> |        bti     c
> |        mrs     x0, sp_el0
> |        ldr     x1, [x0, #8]
> |        cbz     x1, <__cond_resched+0x18>
> |        mov     w0, #0x0                        // #0
> |        ret
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mov     x29, sp
> |        bl      <preempt_schedule_common>
> |        mov     w0, #0x1                        // #1
> |        ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> 
> Any architecture which implements static keys should be able to use this
> to implement PREEMPT_DYNAMIC with similar cost to non-inlined static
> calls.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>

Anyone has an opinion on that? Can we do better on the arm64 static call side
or should we resign ourself to using that static keys direction?

Also I assume that, sooner or later, arm64 will eventually need a static call
implementation....

Thanks.
