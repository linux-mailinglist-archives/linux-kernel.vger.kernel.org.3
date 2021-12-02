Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78FF465A7E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354133AbhLBAPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:15:43 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44186 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354104AbhLBAOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:14:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4BF96CE213D;
        Thu,  2 Dec 2021 00:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57674C53FCD;
        Thu,  2 Dec 2021 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403842;
        bh=NExofyuCthmUUe6PhhWv3xolTLjZjeKOTOFgLxofhzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSrLDnCN2kbOU1k99GNtzwJfZMhbENk6LeiKuCelJi8lFnuZOYvB/I3kVp8ENnwiI
         k+sAO0qg3Gqlixw++pqBFslI1jkcfedyhuzzl+JOe67XEtG3+K2ndpXrmo/w+24Hrn
         d2OyZAPtirQDwdiIg2Euz9xFg/hozwQzImm2m0BGyGFjTh562D5ggKu2pWK9H3zp+k
         OKxAzF9VBrhKCyE3TvGR93iqUBZdB9cuzUwhtNJtA33dAghNwe4VekEAusedLC8elO
         IxN/7p+hKRfCllr02Lr4W5NHVrFopIIwIlCtkWQluFPT9A6px+bpzMsF/6R88Ib2A6
         sroNoKa8MBihg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 028AC5C1180; Wed,  1 Dec 2021 16:10:42 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/7] rcu: Prevent expedited GP from enabling tick on offline CPU
Date:   Wed,  1 Dec 2021 16:10:38 -0800
Message-Id: <20211202001040.3126390-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
References: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an RCU expedited grace period starts just when a CPU is in the process
of going offline, so that the outgoing CPU has completed its pass through
stop-machine but has not yet completed its final dive into the idle loop,
RCU will attempt to enable that CPU's scheduling-clock tick via a call
to tick_dep_set_cpu().  For this to happen, that CPU has to have been
online when the expedited grace period completed its CPU-selection phase.

This is pointless:  The outgoing CPU has interrupts disabled, so it cannot
take a scheduling-clock tick anyway.  In addition, the tick_dep_set_cpu()
function's eventual call to irq_work_queue_on() will splat as follows:

smpboot: CPU 1 is now offline
WARNING: CPU: 6 PID: 124 at kernel/irq_work.c:95
+irq_work_queue_on+0x57/0x60
Modules linked in:
CPU: 6 PID: 124 Comm: kworker/6:2 Not tainted 5.15.0-rc1+ #3
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
+rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
Workqueue: rcu_gp wait_rcu_exp_gp
RIP: 0010:irq_work_queue_on+0x57/0x60
Code: 8b 05 1d c7 ea 62 a9 00 00 f0 00 75 21 4c 89 ce 44 89 c7 e8
+9b 37 fa ff ba 01 00 00 00 89 d0 c3 4c 89 cf e8 3b ff ff ff eb ee <0f> 0b eb b7
+0f 0b eb db 90 48 c7 c0 98 2a 02 00 65 48 03 05 91
 6f
RSP: 0000:ffffb12cc038fe48 EFLAGS: 00010282
RAX: 0000000000000001 RBX: 0000000000005208 RCX: 0000000000000020
RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff9ad01f45a680
RBP: 000000000004c990 R08: 0000000000000001 R09: ffff9ad01f45a680
R10: ffffb12cc0317db0 R11: 0000000000000001 R12: 00000000fffecee8
R13: 0000000000000001 R14: 0000000000026980 R15: ffffffff9e53ae00
FS:  0000000000000000(0000) GS:ffff9ad01f580000(0000)
+knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000de0c000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tick_nohz_dep_set_cpu+0x59/0x70
 rcu_exp_wait_wake+0x54e/0x870
 ? sync_rcu_exp_select_cpus+0x1fc/0x390
 process_one_work+0x1ef/0x3c0
 ? process_one_work+0x3c0/0x3c0
 worker_thread+0x28/0x3c0
 ? process_one_work+0x3c0/0x3c0
 kthread+0x115/0x140
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
---[ end trace c5bf75eb6aa80bc6 ]---

This commit therefore avoids invoking tick_dep_set_cpu() on offlined
CPUs to limit both futility and false-positive splats.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 12f1a18d7b6d6..a96d17206d87a 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -506,7 +506,10 @@ static void synchronize_rcu_expedited_wait(void)
 				if (rdp->rcu_forced_tick_exp)
 					continue;
 				rdp->rcu_forced_tick_exp = true;
-				tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+				preempt_disable();
+				if (cpu_online(cpu))
+					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+				preempt_enable();
 			}
 		}
 		j = READ_ONCE(jiffies_till_first_fqs);
-- 
2.31.1.189.g2e36527f23

