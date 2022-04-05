Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8A24F20B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 04:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiDECBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiDECBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF48C462B01;
        Mon,  4 Apr 2022 18:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A9060DC6;
        Tue,  5 Apr 2022 01:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31008C2BBE4;
        Tue,  5 Apr 2022 01:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649120887;
        bh=Jpz+Jv4Xaf7lFDh2SyosScKUc58hWmkQlsew08yht+o=;
        h=From:To:Cc:Subject:Date:From;
        b=gXub8KIAxJdu63/6MTrPAGneJXnd33dv3jqT5/0InvZyfMvDdsjypiJF0mto6q6Cv
         YWCf8Tb872r+2Rl4K9dpQUcB0YJk+XoyfGUjkRiSq1wT7U65peaU4UbicSrtviTo8W
         bKrnRxxCVyVNqiaycQ0H+MvUz/I08bwaZjFP+K+YB68g0lBYcBZPCap2uO3Um6Rr1H
         31i+hM6JhR63/nOoS0nS25pbmjnnod8+BTvHDo0btkMBCDBxLEzm+X8BmKfzrn5mVr
         hP8iJuyoWGAAyVcn2uyRCX0dpaOgNLWjJX73pEa9FAxZ6EIuT9Gx0YdUddFU/a11Oz
         lO9XgGO2Tr/5Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RT][PATCH 1/2] rcutorture: Also force sched priority to timersd on boosting test
Date:   Tue,  5 Apr 2022 03:07:51 +0200
Message-Id: <20220405010752.1347437-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ksoftirqd is statically boosted to the priority level right above the
one of rcu_torture_boost() so that timers, which torture readers rely on,
get a chance to run while rcu_torture_boost() is polling.

However timers processing got split from ksoftirqd into their own kthread
(timersd) that isn't boosted. It has the same SCHED_FIFO low prio as
rcu_torture_boost() and therefore timers can't preempt it and may
starve.

The issue can be triggered in practice on v5.17.1-rt17 using:

	./kvm.sh --allcpus --configs TREE04 --duration 10m --kconfig "CONFIG_EXPERT=y CONFIG_PREEMPT_RT=y"

triggering the following:

	 rcu-torture: rcu_torture_boost boosting failed
	 Boost inversion thread ->rt_priority 1 gp_state 12908 jiffies 3501
	 rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: 0x402 ->rt_priority 2 delta ->gp_start 3502 ->gp_activity 3502 ->gp_req_activity 3502 ->gp_wake_time 3502 ->gp_wake_seq 12897 ->gp_seq 12901 ->gp_seq_needed 12904 ->gp_max 4057 ->gp_flags 0x0
	 rcu:     rcu_node 0:7 ->gp_seq 12901 ->gp_seq_needed 12904 ->qsmask 0x2 .... ->n_boosts 0
	 rcu:     rcu_node 0:3 ->gp_seq 12901 ->gp_seq_needed 12908 ->qsmask 0x0 b... ->n_boosts 22
	 rcu:     cpu 0 ->gp_seq_needed 12904
	 rcu:     rcu_node 4:7 ->gp_seq 12901 ->gp_seq_needed 12908 ->qsmask 0x0 b..G ->n_boosts 6
	 rcu:     cpu 5 ->gp_seq_needed 12904
	 rcu:    CB 1^0->2 KbclSW F5089 L5089 C1 ..... q0 S CPU 0
	 rcu:    CB 2^0->3 KbclSW F16859 L16859 C1 ..... q0 S CPU 0
	 rcu:    CB 3^0->-1 KbclSW F3502 L3502 C2 .W12908.N. q4 S CPU 0
	 rcu: nocb GP 4 KldtS .[W.] .G:12904 rnp 4:7 1459 S CPU 0
	 rcu:    CB 4^4->5 KbclSW F9918 L10534 C4 ..... q0 S CPU 0
	 rcu:    CB 5^4->6 KbclSW F2550 L2550 C2 .W12904.N. q8 S CPU 0
	 rcu:    CB 6^4->7 KbclSW F6639 L7253 C0 ..... q0 S CPU 0
	 rcu:    CB 7^4->-1 KbclSW F30685 L30685 C1 ..... q0 S CPU 0
	 rcu: RCU callbacks invoked since boot: 236075
	 rcu_tasks: RTGS_WAIT_CBS(11) since 409853 g:0 i:0/0 k.
	 rcu_tasks_rude: RTGS_WAIT_CBS(11) since 409851 g:0 i:0/0 k.
	 rcu_tasks_trace: RTGS_WAIT_CBS(11) since 409848 g:0 i:0/0 k. N0 h:0/0/0
	 Boost inversion: GP 12908 still pending.
	 rcu-torture: rtc: 0000000093327eb2 ver: 1504 tfle: 0 rta: 1505 rtaf: 0 rtf: 1493 rtmbe: 0 rtmbkf: 0/782 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 1 rtb: 7 nt: 66220 onoff: 6/6:11/12 40,763:29,5050 1537:11766 (HZ=1000) barrier: 239/240:0 read-exits: 67 nocb-toggles: 0:0
	 rcu-torture: !!!
	 ------------[ cut here ]------------
	 WARNING: CPU: 5 PID: 121 at kernel/rcu/rcutorture.c:1870 rcu_torture_stats_print+0x5ad/0x610
	 Modules linked in:
	 CPU: 5 PID: 121 Comm: rcu_torture_sta Not tainted 5.17.1-rt17 #63
	 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)
	 RIP: 0010:rcu_torture_stats_print+0x5ad/0x610
	 Code: c7 01 02 00 74 02 0f 0b 48 83 3d 35 c7 01 02 00 74 02 0f 0b 48 83 3d 21 c7 01 02 00 74 02 0f 0b 48 83 3d 0d c7 01 02 00 74 02 <0f> 0b 83 eb 01 0f 8e ba fc ff ff 0f 0b e9 b3 fc ff ff 8b 05 8f c6
	 RSP: 0018:ffffa7560041fdf8 EFLAGS: 00010202
	 RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
	 RDX: 0000000000000000 RSI: 40000000ffffe735 RDI: 00000000ffffffff
	 RBP: 00000000000005d5 R08: ffffffffaf65f6e0 R09: ffffffffafee3a7c
	 R10: ffffa75600427d58 R11: 0000000020212121 R12: ffffa7560041fe20
	 R13: ffffa7560041fe78 R14: 0000000000000000 R15: 000000000001bd20
	 FS:  0000000000000000(0000) GS:ffff9fe7df540000(0000) knlGS:0000000000000000
	 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	 CR2: 0000000000000000 CR3: 0000000014216000 CR4: 00000000000006e0
	 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
	 Call Trace:
	  <TASK>
	  ? lock_timer_base+0x62/0x80
	  ? rcu_torture_stats_print+0x610/0x610
	  rcu_torture_stats+0x29/0x70
	  kthread+0x118/0x130
	  ? kthread_complete_and_exit+0x20/0x20
	  ret_from_fork+0x22/0x30
	  </TASK>

Fix this with statically boosting timersd just like is done with ksoftirqd.

Suggested-by: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/interrupt.h | 1 +
 kernel/rcu/rcutorture.c   | 6 ++++++
 kernel/softirq.c          | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index db4a23d07a57..e4b8a04e67ce 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -606,6 +606,7 @@ extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
 
 #ifdef CONFIG_PREEMPT_RT
+DECLARE_PER_CPU(struct task_struct *, timersd);
 extern void raise_timer_softirq(void);
 extern void raise_hrtimer_softirq(void);
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 422f7e4cc08d..ac9715ed58ba 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3283,6 +3283,12 @@ rcu_torture_init(void)
 				WARN_ON_ONCE(!t);
 				sp.sched_priority = 2;
 				sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+#ifdef CONFIG_PREEMPT_RT
+				t = per_cpu(timersd, cpu);
+				WARN_ON_ONCE(!t);
+				sp.sched_priority = 2;
+				sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+#endif
 			}
 		}
 	}
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 22948c2109f5..89eb45614af6 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -624,7 +624,7 @@ static inline void tick_irq_exit(void)
 #endif
 }
 
-static DEFINE_PER_CPU(struct task_struct *, timersd);
+DEFINE_PER_CPU(struct task_struct *, timersd);
 static DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
 
 static unsigned int local_pending_timers(void)
-- 
2.25.1

