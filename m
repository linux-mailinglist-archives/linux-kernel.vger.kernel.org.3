Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622CF465AA3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354339AbhLBAY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354212AbhLBAYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:24:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7785C061574;
        Wed,  1 Dec 2021 16:21:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0E67CE2139;
        Thu,  2 Dec 2021 00:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05931C5831C;
        Thu,  2 Dec 2021 00:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404457;
        bh=mdx5ahCUCGFGj7gmVOIaiUUse9lvAR8mGrQIois7W3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYkBa/D+yiJW8Vo/rf3DDegin8gXI/migd+DM7gMD7ZcE/W7uYm9hwuFJ6SZ+ci3v
         hbVLIpsb/F/d4WIuv/2Y14LTCGdNO4qwkGeHv5B5ue0xj0ockFvTiubkeOJeka4o/V
         a2DxJW1eoPGDSIL7mvt9fc4RKTm4yPB65Dcbqgm/fN6oMqc7J1VhgheFkuMS/rnzDc
         VDF+ndAOoZc2kiJx/MUrBsBRqoDqKRxKcm+6Zf7UFnzvoSX96jhY9Jau+1vre5G3wu
         LyDS7jbzpXNHwXwwTZVZ5mg2svFnoM9VVN1TxC/6ZtEHBYPg8WxdNuyTCDViFybZXZ
         rRtXzH3oBelXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8AF105C1184; Wed,  1 Dec 2021 16:20:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/6] srcu: Prevent redundant __srcu_read_unlock() wakeup
Date:   Wed,  1 Dec 2021 16:20:55 -0800
Message-Id: <20211202002055.3127133-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tiny SRCU readers can appear at task level, but also in interrupt and
softirq handlers.  Because Tiny SRCU is selected only in kernels built
with CONFIG_SMP=n and CONFIG_PREEMPTION=n, it is not possible for a grace
period to start while there is a non-task-level SRCU reader executing.
This means that it does not make sense for __srcu_read_unlock() to awaken
the Tiny SRCU grace period, because that can only happen when the grace
period is waiting for one value of ->srcu_idx and __srcu_read_unlock()
is ending the last reader for some other value of ->srcu_idx.  After all,
any such wakeup will be redundant.

Worse yet, in some cases, such wakeups generate lockdep splats:

	======================================================
	WARNING: possible circular locking dependency detected
	5.15.0-rc1+ #3758 Not tainted
	------------------------------------------------------
	rcu_torture_rea/53 is trying to acquire lock:
	ffffffff9514e6a8 (srcu_ctl.srcu_wq.lock){..-.}-{2:2}, at:
	xa/0x30

	but task is already holding lock:
	ffff95c642479d80 (&p->pi_lock){-.-.}-{2:2}, at:
	_extend+0x370/0x400

	which lock already depends on the new lock.

	the existing dependency chain (in reverse order) is:

	-> #1 (&p->pi_lock){-.-.}-{2:2}:
	       _raw_spin_lock_irqsave+0x2f/0x50
	       try_to_wake_up+0x50/0x580
	       swake_up_locked.part.7+0xe/0x30
	       swake_up_one+0x22/0x30
	       rcutorture_one_extend+0x1b6/0x400
	       rcu_torture_one_read+0x290/0x5d0
	       rcu_torture_timer+0x1a/0x70
	       call_timer_fn+0xa6/0x230
	       run_timer_softirq+0x493/0x4c0
	       __do_softirq+0xc0/0x371
	       irq_exit+0x73/0x90
	       sysvec_apic_timer_interrupt+0x63/0x80
	       asm_sysvec_apic_timer_interrupt+0x12/0x20
	       default_idle+0xb/0x10
	       default_idle_call+0x5e/0x170
	       do_idle+0x18a/0x1f0
	       cpu_startup_entry+0xa/0x10
	       start_kernel+0x678/0x69f
	       secondary_startup_64_no_verify+0xc2/0xcb

	-> #0 (srcu_ctl.srcu_wq.lock){..-.}-{2:2}:
	       __lock_acquire+0x130c/0x2440
	       lock_acquire+0xc2/0x270
	       _raw_spin_lock_irqsave+0x2f/0x50
	       swake_up_one+0xa/0x30
	       rcutorture_one_extend+0x387/0x400
	       rcu_torture_one_read+0x290/0x5d0
	       rcu_torture_reader+0xac/0x200
	       kthread+0x12d/0x150
	       ret_from_fork+0x22/0x30

	other info that might help us debug this:

	 Possible unsafe locking scenario:

	       CPU0                    CPU1
	       ----                    ----
	  lock(&p->pi_lock);
				       lock(srcu_ctl.srcu_wq.lock);
				       lock(&p->pi_lock);
	  lock(srcu_ctl.srcu_wq.lock);

	 *** DEADLOCK ***

	1 lock held by rcu_torture_rea/53:
	 #0: ffff95c642479d80 (&p->pi_lock){-.-.}-{2:2}, at:
	_extend+0x370/0x400

	stack backtrace:
	CPU: 0 PID: 53 Comm: rcu_torture_rea Not tainted 5.15.0-rc1+

	Hardware name: Red Hat KVM/RHEL-AV, BIOS
	e_el8.5.0+746+bbd5d70c 04/01/2014
	Call Trace:
	 check_noncircular+0xfe/0x110
	 ? find_held_lock+0x2d/0x90
	 __lock_acquire+0x130c/0x2440
	 lock_acquire+0xc2/0x270
	 ? swake_up_one+0xa/0x30
	 ? find_held_lock+0x72/0x90
	 _raw_spin_lock_irqsave+0x2f/0x50
	 ? swake_up_one+0xa/0x30
	 swake_up_one+0xa/0x30
	 rcutorture_one_extend+0x387/0x400
	 rcu_torture_one_read+0x290/0x5d0
	 rcu_torture_reader+0xac/0x200
	 ? rcutorture_oom_notify+0xf0/0xf0
	 ? __kthread_parkme+0x61/0x90
	 ? rcu_torture_one_read+0x5d0/0x5d0
	 kthread+0x12d/0x150
	 ? set_kthread_struct+0x40/0x40
	 ret_from_fork+0x22/0x30

This is a false positive because there is only one CPU, and both locks
are raw (non-preemptible) spinlocks.  However, it is worthwhile getting
rid of the redundant wakeup, which has the side effect of breaking
the theoretical deadlock cycle.  This commit therefore eliminates the
redundant wakeups.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutiny.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index a0ba2ed49bc61..92c002d654828 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -99,7 +99,7 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	int newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
 
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
-	if (!newval && READ_ONCE(ssp->srcu_gp_waiting))
+	if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task())
 		swake_up_one(&ssp->srcu_wq);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
-- 
2.31.1.189.g2e36527f23

