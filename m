Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392A4552748
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbiFTW4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344911AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721A81F2F7;
        Mon, 20 Jun 2022 15:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CEA1B8165E;
        Mon, 20 Jun 2022 22:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CA1C36AF9;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=JNzFpbIIBwtENr69CSR+HwfoGvWSvolmvJkcMjcX2IU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfpOOwNqcat+LA+Ivn/6HaqoNdRCBHHZ0kL9v82XSPnL1mtc8oHMkxIAs+FS6A3ma
         IOQaWCqVmgcs1eqMubaNNKvSOjr61ELqLuVuQcJmQfbgu/jpKHEsChpQxV+FzPzJJs
         thIL2dKlLl8o123vW9qJeBSROt9XLTdeUr/2ZJbCt6x+4xGXcojyOO+kM0OgkSBwtA
         5TdbPtFvI9/xJw5JPN3/QrzwUxnuTCxHa4BKAyYOPQlM1Bgo8itPCfjxtbgzDZcGCC
         d/6P+Q7jqFa2Xz4PKzZ1AmPI8quUnZQG/bII601s88lqBhqCbUIcvW3vnJeEe3EcZp
         YQa5j3mRM3bvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4877F5C118A; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 17/32] rcu-tasks: Add data structures for lightweight grace periods
Date:   Mon, 20 Jun 2022 15:53:56 -0700
Message-Id: <20220620225411.3842519-17-paulmck@kernel.org>
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

This commit adds fields to task_struct and to rcu_tasks_percpu that will
be used to avoid the task-list scan for RCU Tasks Trace grace periods,
and also initializes these fields.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 include/linux/sched.h | 2 ++
 init/init_task.c      | 1 +
 kernel/fork.c         | 1 +
 kernel/rcu/tasks.h    | 4 ++++
 4 files changed, 8 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e6eb5871593e9..b88caf54e1686 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -844,6 +844,8 @@ struct task_struct {
 	int				trc_ipi_to_cpu;
 	union rcu_special		trc_reader_special;
 	struct list_head		trc_holdout_list;
+	struct list_head		trc_blkd_node;
+	int				trc_blkd_cpu;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 	struct sched_info		sched_info;
diff --git a/init/init_task.c b/init/init_task.c
index 73cc8f03511a3..ff6c4b9bfe6b1 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -157,6 +157,7 @@ struct task_struct init_task
 	.trc_reader_nesting = 0,
 	.trc_reader_special.s = 0,
 	.trc_holdout_list = LIST_HEAD_INIT(init_task.trc_holdout_list),
+	.trc_blkd_node = LIST_HEAD_INIT(init_task.trc_blkd_node),
 #endif
 #ifdef CONFIG_CPUSETS
 	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c696..1950eb8702441 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1814,6 +1814,7 @@ static inline void rcu_copy_process(struct task_struct *p)
 	p->trc_reader_nesting = 0;
 	p->trc_reader_special.s = 0;
 	INIT_LIST_HEAD(&p->trc_holdout_list);
+	INIT_LIST_HEAD(&p->trc_blkd_node);
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 64eb4d7b142e3..fd4508af055e6 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -29,6 +29,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @rtp_work: Work queue for invoking callbacks.
  * @rtp_irq_work: IRQ work queue for deferred wakeups.
  * @barrier_q_head: RCU callback for barrier operation.
+ * @rtp_blkd_tasks: List of tasks blocked as readers.
  * @cpu: CPU number corresponding to this entry.
  * @rtpp: Pointer to the rcu_tasks structure.
  */
@@ -40,6 +41,7 @@ struct rcu_tasks_percpu {
 	struct work_struct rtp_work;
 	struct irq_work rtp_irq_work;
 	struct rcu_head barrier_q_head;
+	struct list_head rtp_blkd_tasks;
 	int cpu;
 	struct rcu_tasks *rtpp;
 };
@@ -256,6 +258,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
 		rtpcp->cpu = cpu;
 		rtpcp->rtpp = rtp;
+		if (!rtpcp->rtp_blkd_tasks.next)
+			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
 		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
-- 
2.31.1.189.g2e36527f23

