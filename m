Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C461552743
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345366AbiFTWzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344872AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190A71EEDA;
        Mon, 20 Jun 2022 15:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E126147F;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E05C36AFB;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=f/FLpu1SXIltT2kOQ+Mu+hUvWlDconhu6rDtZvA1rcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+zWMyqh3USScJIq7iioPeU1Vr1SqxBf1MLTn9Tvw/XTM1gtvC1Uk0HoGnGTFytAC
         ng41dvjeglsWfJRtJpgVVSWWGWuGSCpcJDUHow/c4Nm3o4GdM2SCAVTKrqUwuI8sOJ
         QGaP0uA2LgB0eTrWYrRxwY52KtgUALVI9RcE7kOwdr+zKMAoRm+njyoAivuP9BIzNQ
         EXyBqfu3x7O52QdG14xGctsrfQiQdM5vQxlioaGSnho028q7pPj/0RPWvbkaqsC2J7
         fvIxX/sdGyVHsORh46lKoajk2Wsh4O2lEC2KvVOXgBhBgGQ5EbA44ycq79woThfs2W
         iPRVD617m0MHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4A9A65C11D7; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 18/32] rcu-tasks: Track blocked RCU Tasks Trace readers
Date:   Mon, 20 Jun 2022 15:53:57 -0700
Message-Id: <20220620225411.3842519-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit places any task that has ever blocked within its current
RCU Tasks Trace read-side critical section on a per-CPU list within the
rcu_tasks_percpu structure.  Tasks are removed from this list when they
exit by the exit_tasks_rcu_finish_trace() function.  The purpose of this
commit is to provide the information needed to eliminate the current
scan of the full task list.

This commit offsets the INT_MIN value for ->trc_reader_nesting with the
new nesting level in order to avoid queueing tasks that are exiting
their read-side critical sections.

[ paulmck: Apply kernel test robot feedback. ]
[ paulmck: Apply feedback from syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 include/linux/rcupdate.h       | 11 +++++++++--
 include/linux/rcupdate_trace.h |  2 +-
 kernel/rcu/tasks.h             | 22 +++++++++++++++++++++-
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 1e728d544fc1e..ebdfeead44e51 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -174,12 +174,19 @@ void synchronize_rcu_tasks(void);
 #define TRC_NEED_QS_CHECKED	0x2  // Task has been checked for needing quiescent state.
 
 u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new);
+void rcu_tasks_trace_qs_blkd(struct task_struct *t);
 
 # define rcu_tasks_trace_qs(t)							\
 	do {									\
+		int ___rttq_nesting = READ_ONCE((t)->trc_reader_nesting);	\
+										\
 		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
-		    likely(!READ_ONCE((t)->trc_reader_nesting)))		\
+		    likely(!___rttq_nesting)) {					\
 			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
+		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
+			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
+			rcu_tasks_trace_qs_blkd(t);				\
+		}								\
 	} while (0)
 # else
 # define rcu_tasks_trace_qs(t) do { } while (0)
@@ -188,7 +195,7 @@ u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new);
 #define rcu_tasks_qs(t, preempt)					\
 do {									\
 	rcu_tasks_classic_qs((t), (preempt));				\
-	rcu_tasks_trace_qs((t));					\
+	rcu_tasks_trace_qs(t);						\
 } while (0)
 
 # ifdef CONFIG_TASKS_RUDE_RCU
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 6f9c358173989..9bc8cbb33340b 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -75,7 +75,7 @@ static inline void rcu_read_unlock_trace(void)
 	nesting = READ_ONCE(t->trc_reader_nesting) - 1;
 	barrier(); // Critical section before disabling.
 	// Disable IPI-based setting of .need_qs.
-	WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
+	WRITE_ONCE(t->trc_reader_nesting, INT_MIN + nesting);
 	if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
 		WRITE_ONCE(t->trc_reader_nesting, nesting);
 		return;  // We assume shallow reader nesting.
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fd4508af055e6..bab75ec26bdbb 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1261,6 +1261,24 @@ void rcu_read_unlock_trace_special(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
 
+/* Add a newly blocked reader task to its CPU's list. */
+void rcu_tasks_trace_qs_blkd(struct task_struct *t)
+{
+	unsigned long flags;
+	struct rcu_tasks_percpu *rtpcp;
+
+	local_irq_save(flags);
+	rtpcp = this_cpu_ptr(rcu_tasks_trace.rtpcpu);
+	raw_spin_lock_rcu_node(rtpcp); // irqs already disabled
+	t->trc_blkd_cpu = smp_processor_id();
+	if (!rtpcp->rtp_blkd_tasks.next)
+		INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
+	list_add(&t->trc_blkd_node, &rtpcp->rtp_blkd_tasks);
+	t->trc_reader_special.b.blocked = true;
+	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_trace_qs_blkd);
+
 /* Add a task to the holdout list, if it is not already on the list. */
 static void trc_add_holdout(struct task_struct *t, struct list_head *bhp)
 {
@@ -1586,9 +1604,11 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 /* Report any needed quiescent state for this exiting task. */
 static void exit_tasks_rcu_finish_trace(struct task_struct *t)
 {
+	union rcu_special trs = READ_ONCE(t->trc_reader_special);
+
 	rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
 	WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
-	if (WARN_ON_ONCE(rcu_ld_need_qs(t) & TRC_NEED_QS))
+	if (WARN_ON_ONCE(rcu_ld_need_qs(t) & TRC_NEED_QS) || trs.b.blocked)
 		rcu_read_unlock_trace_special(t);
 	else
 		WRITE_ONCE(t->trc_reader_nesting, 0);
-- 
2.31.1.189.g2e36527f23

