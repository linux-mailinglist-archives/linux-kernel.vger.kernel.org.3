Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3337646A61A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348833AbhLFT5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbhLFT5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:57:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C388C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 11:54:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8708BCE17E3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 19:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7519C341C2;
        Mon,  6 Dec 2021 19:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638820445;
        bh=fgHu0kEcoocmCUVYAYj+vbWZyCoZTlqZW/u+AtKnBgI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iBLGGzEftwuPvr/vVMtQP8KWT5tb2HFqAiG3xsmrMEeyff6XrcX+XwzOMHooy8cZC
         pj9DyxurHy48DG9eCVtvLURhICM5I8kJfWyhImK1ZuEur6rvHdejo+206Ca+WVNRPH
         jXieErR8nVPXUkqWCuWPpvob+JMP7jBf2Y8sbuMxye6ThGFYBrNWmC31m81drHVp0O
         JhLtjM0cR0abw414XLZoQ/NUSrz6Rr7PUcVU8eQFH5TnRo9y4h1MUyebRJ2qoaPkM8
         98o6FzLZ8xqPKEIb8udVYtk2X/Fb66fK5EHvWBxao+TdatIor9c7SGxskkOv0exAYA
         CVFfCP/VGQ2pQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 81FBD5C1461; Mon,  6 Dec 2021 11:54:05 -0800 (PST)
Date:   Mon, 6 Dec 2021 11:54:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu 1/2] kcsan: Avoid nested contexts reading
 inconsistent reorder_access
Message-ID: <20211206195405.GD641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211206064151.3337384-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206064151.3337384-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 07:41:50AM +0100, Marco Elver wrote:
> Nested contexts, such as nested interrupts or scheduler code, share the
> same kcsan_ctx. When such a nested context reads an inconsistent
> reorder_access due to an interrupt during set_reorder_access(), we can
> observe the following warning:
> 
>  | ------------[ cut here ]------------
>  | Cannot find frame for torture_random kernel/torture.c:456 in stack trace
>  | WARNING: CPU: 13 PID: 147 at kernel/kcsan/report.c:343 replace_stack_entry kernel/kcsan/report.c:343
>  | ...
>  | Call Trace:
>  |  <TASK>
>  |  sanitize_stack_entries kernel/kcsan/report.c:351 [inline]
>  |  print_report kernel/kcsan/report.c:409
>  |  kcsan_report_known_origin kernel/kcsan/report.c:693
>  |  kcsan_setup_watchpoint kernel/kcsan/core.c:658
>  |  rcutorture_one_extend kernel/rcu/rcutorture.c:1475
>  |  rcutorture_loop_extend kernel/rcu/rcutorture.c:1558 [inline]
>  |  ...
>  |  </TASK>
>  | ---[ end trace ee5299cb933115f5 ]---
>  | ==================================================================
>  | BUG: KCSAN: data-race in _raw_spin_lock_irqsave / rcutorture_one_extend
>  |
>  | write (reordered) to 0xffffffff8c93b300 of 8 bytes by task 154 on cpu 12:
>  |  queued_spin_lock                include/asm-generic/qspinlock.h:80 [inline]
>  |  do_raw_spin_lock                include/linux/spinlock.h:185 [inline]
>  |  __raw_spin_lock_irqsave         include/linux/spinlock_api_smp.h:111 [inline]
>  |  _raw_spin_lock_irqsave          kernel/locking/spinlock.c:162
>  |  try_to_wake_up                  kernel/sched/core.c:4003
>  |  sysvec_apic_timer_interrupt     arch/x86/kernel/apic/apic.c:1097
>  |  asm_sysvec_apic_timer_interrupt arch/x86/include/asm/idtentry.h:638
>  |  set_reorder_access              kernel/kcsan/core.c:416 [inline]    <-- inconsistent reorder_access
>  |  kcsan_setup_watchpoint          kernel/kcsan/core.c:693
>  |  rcutorture_one_extend           kernel/rcu/rcutorture.c:1475
>  |  rcutorture_loop_extend          kernel/rcu/rcutorture.c:1558 [inline]
>  |  rcu_torture_one_read            kernel/rcu/rcutorture.c:1600
>  |  rcu_torture_reader              kernel/rcu/rcutorture.c:1692
>  |  kthread                         kernel/kthread.c:327
>  |  ret_from_fork                   arch/x86/entry/entry_64.S:295
>  |
>  | read to 0xffffffff8c93b300 of 8 bytes by task 147 on cpu 13:
>  |  rcutorture_one_extend           kernel/rcu/rcutorture.c:1475
>  |  rcutorture_loop_extend          kernel/rcu/rcutorture.c:1558 [inline]
>  |  ...
> 
> The warning is telling us that there was a data race which KCSAN wants
> to report, but the function where the original access (that is now
> reordered) happened cannot be found in the stack trace, which prevents
> KCSAN from generating the right stack trace. The stack trace of "write
> (reordered)" now only shows where the access was reordered to, but
> should instead show the stack trace of the original write, with a final
> line saying "reordered to".
> 
> At the point where set_reorder_access() is interrupted, it just set
> reorder_access->ptr and size, at which point size is non-zero. This is
> sufficient (if ctx->disable_scoped is zero) for further accesses from
> nested contexts to perform checking of this reorder_access.
> 
> That then happened in _raw_spin_lock_irqsave(), which is called by
> scheduler code. However, since reorder_access->ip is still stale (ptr
> and size belong to a different ip not yet set) this finally leads to
> replace_stack_entry() not finding the frame in reorder_access->ip and
> generating the above warning.
> 
> Fix it by ensuring that a nested context cannot access reorder_access
> while we update it in set_reorder_access(): set ctx->disable_scoped for
> the duration that reorder_access is updated, which effectively locks
> reorder_access and prevents concurrent use by nested contexts. Note,
> set_reorder_access() can do the update only if disabled_scoped is zero
> on entry, and must therefore set disable_scoped back to non-zero after
> the initial check in set_reorder_access().
> 
> Signed-off-by: Marco Elver <elver@google.com>

I pulled both of these in, thank you!

							Thanx, Paul

> ---
>  kernel/kcsan/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 916060913966..fe12dfe254ec 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -412,11 +412,20 @@ set_reorder_access(struct kcsan_ctx *ctx, const volatile void *ptr, size_t size,
>  	if (!reorder_access || !kcsan_weak_memory)
>  		return;
>  
> +	/*
> +	 * To avoid nested interrupts or scheduler (which share kcsan_ctx)
> +	 * reading an inconsistent reorder_access, ensure that the below has
> +	 * exclusive access to reorder_access by disallowing concurrent use.
> +	 */
> +	ctx->disable_scoped++;
> +	barrier();
>  	reorder_access->ptr		= ptr;
>  	reorder_access->size		= size;
>  	reorder_access->type		= type | KCSAN_ACCESS_SCOPED;
>  	reorder_access->ip		= ip;
>  	reorder_access->stack_depth	= get_kcsan_stack_depth();
> +	barrier();
> +	ctx->disable_scoped--;
>  }
>  
>  /*
> -- 
> 2.34.1.400.ga245620fadb-goog
> 
