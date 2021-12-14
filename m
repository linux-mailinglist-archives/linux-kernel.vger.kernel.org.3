Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B59474DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhLNWFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:05:43 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58776 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhLNWEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4319DCE1B0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3F9C341CB;
        Tue, 14 Dec 2021 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519482;
        bh=BUHnT9DH9EeTBui6UNdyD5bFEI55a2sXFJWD61Lk/70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eL0okwhysr+SgYq2M0y/yusC/H+XgGGfH2CTBTcyebB+hTU8rVfe9hnMvaYlcfwvm
         11NyDYKJxYhZELICegUWpJ915cxHNctIAAz0LxvpZDAAdekRAVIRo46yT7eAv4yquz
         ExPxYsATPsu7Kz7aki+uqx9SfI/HN6lzPNvlLUxporGbwTegpm6+FoX4JoBOa96i/Q
         FTNT2R7Mp+RTOZL+mXMgbA3ubMG/xSD4jzFH3vMjnFhk3Z3KM40XXS03R7/1WMQ3ZA
         jz25rmVW32xUKtTp7kVgcLy4I9oo3k3cxQvqHqJ018lnCFm8NUZAm0ELUAn+x/4CTF
         y+HOkOlf2DGdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 900775C2C7A; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 28/29] kcsan: Avoid nested contexts reading inconsistent reorder_access
Date:   Tue, 14 Dec 2021 14:04:38 -0800
Message-Id: <20211214220439.2236564-28-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Nested contexts, such as nested interrupts or scheduler code, share the
same kcsan_ctx. When such a nested context reads an inconsistent
reorder_access due to an interrupt during set_reorder_access(), we can
observe the following warning:

 | ------------[ cut here ]------------
 | Cannot find frame for torture_random kernel/torture.c:456 in stack trace
 | WARNING: CPU: 13 PID: 147 at kernel/kcsan/report.c:343 replace_stack_entry kernel/kcsan/report.c:343
 | ...
 | Call Trace:
 |  <TASK>
 |  sanitize_stack_entries kernel/kcsan/report.c:351 [inline]
 |  print_report kernel/kcsan/report.c:409
 |  kcsan_report_known_origin kernel/kcsan/report.c:693
 |  kcsan_setup_watchpoint kernel/kcsan/core.c:658
 |  rcutorture_one_extend kernel/rcu/rcutorture.c:1475
 |  rcutorture_loop_extend kernel/rcu/rcutorture.c:1558 [inline]
 |  ...
 |  </TASK>
 | ---[ end trace ee5299cb933115f5 ]---
 | ==================================================================
 | BUG: KCSAN: data-race in _raw_spin_lock_irqsave / rcutorture_one_extend
 |
 | write (reordered) to 0xffffffff8c93b300 of 8 bytes by task 154 on cpu 12:
 |  queued_spin_lock                include/asm-generic/qspinlock.h:80 [inline]
 |  do_raw_spin_lock                include/linux/spinlock.h:185 [inline]
 |  __raw_spin_lock_irqsave         include/linux/spinlock_api_smp.h:111 [inline]
 |  _raw_spin_lock_irqsave          kernel/locking/spinlock.c:162
 |  try_to_wake_up                  kernel/sched/core.c:4003
 |  sysvec_apic_timer_interrupt     arch/x86/kernel/apic/apic.c:1097
 |  asm_sysvec_apic_timer_interrupt arch/x86/include/asm/idtentry.h:638
 |  set_reorder_access              kernel/kcsan/core.c:416 [inline]    <-- inconsistent reorder_access
 |  kcsan_setup_watchpoint          kernel/kcsan/core.c:693
 |  rcutorture_one_extend           kernel/rcu/rcutorture.c:1475
 |  rcutorture_loop_extend          kernel/rcu/rcutorture.c:1558 [inline]
 |  rcu_torture_one_read            kernel/rcu/rcutorture.c:1600
 |  rcu_torture_reader              kernel/rcu/rcutorture.c:1692
 |  kthread                         kernel/kthread.c:327
 |  ret_from_fork                   arch/x86/entry/entry_64.S:295
 |
 | read to 0xffffffff8c93b300 of 8 bytes by task 147 on cpu 13:
 |  rcutorture_one_extend           kernel/rcu/rcutorture.c:1475
 |  rcutorture_loop_extend          kernel/rcu/rcutorture.c:1558 [inline]
 |  ...

The warning is telling us that there was a data race which KCSAN wants
to report, but the function where the original access (that is now
reordered) happened cannot be found in the stack trace, which prevents
KCSAN from generating the right stack trace. The stack trace of "write
(reordered)" now only shows where the access was reordered to, but
should instead show the stack trace of the original write, with a final
line saying "reordered to".

At the point where set_reorder_access() is interrupted, it just set
reorder_access->ptr and size, at which point size is non-zero. This is
sufficient (if ctx->disable_scoped is zero) for further accesses from
nested contexts to perform checking of this reorder_access.

That then happened in _raw_spin_lock_irqsave(), which is called by
scheduler code. However, since reorder_access->ip is still stale (ptr
and size belong to a different ip not yet set) this finally leads to
replace_stack_entry() not finding the frame in reorder_access->ip and
generating the above warning.

Fix it by ensuring that a nested context cannot access reorder_access
while we update it in set_reorder_access(): set ctx->disable_scoped for
the duration that reorder_access is updated, which effectively locks
reorder_access and prevents concurrent use by nested contexts. Note,
set_reorder_access() can do the update only if disabled_scoped is zero
on entry, and must therefore set disable_scoped back to non-zero after
the initial check in set_reorder_access().

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 9160609139666..fe12dfe254ecf 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -412,11 +412,20 @@ set_reorder_access(struct kcsan_ctx *ctx, const volatile void *ptr, size_t size,
 	if (!reorder_access || !kcsan_weak_memory)
 		return;
 
+	/*
+	 * To avoid nested interrupts or scheduler (which share kcsan_ctx)
+	 * reading an inconsistent reorder_access, ensure that the below has
+	 * exclusive access to reorder_access by disallowing concurrent use.
+	 */
+	ctx->disable_scoped++;
+	barrier();
 	reorder_access->ptr		= ptr;
 	reorder_access->size		= size;
 	reorder_access->type		= type | KCSAN_ACCESS_SCOPED;
 	reorder_access->ip		= ip;
 	reorder_access->stack_depth	= get_kcsan_stack_depth();
+	barrier();
+	ctx->disable_scoped--;
 }
 
 /*
-- 
2.31.1.189.g2e36527f23

