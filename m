Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D494A9F7D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377749AbiBDSsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377746AbiBDSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:48:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A74CC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 10:48:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EC49B8389D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 18:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182B2C004E1;
        Fri,  4 Feb 2022 18:48:16 +0000 (UTC)
Date:   Fri, 4 Feb 2022 18:48:13 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v2 7/7] arm64: support PREEMPT_DYNAMIC
Message-ID: <Yf107Tg2cW0wR22+@arm.com>
References: <20220204150557.434610-1-mark.rutland@arm.com>
 <20220204150557.434610-8-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204150557.434610-8-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 03:05:57PM +0000, Mark Rutland wrote:
> This patch enables support for PREEMPT_DYNAMIC on arm64, allowing the
> preemption model to be chosen at boot time.
> 
> Specifically, this patch selects HAVE_PREEMPT_DYNAMIC_KEY, so that each
> preemption function is an out-of-line call with an early return
> depending upon a static key. This leaves almost all the codegen up to
> the compiler, and side-steps a number of pain points with static calls
> (e.g. interaction with CFI schemes). This should have no worse overhead
> than using non-inline static calls, as those use out-of-line trampolines
> with early returns.
> 
> For example, the dynamic_cond_resched() wrapper looks as follows (with
> the first `B` being replaced with a `NOP` when the function is
> disabled):
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
> Since arm64 does not yet use the generic entry code, we must define our
> own `sk_dynamic_irqentry_exit_cond_resched`, which will be
> enabled/disabled by the common code in kernel/sched/core.c. All other
> preemption functions and associated static keys are defined there.
> 
> Note that PREEMPT_DYNAMIC is `def bool y`, so this will default to
> enabled.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Will Deacon <will@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
