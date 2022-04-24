Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F409250D38C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiDXQlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiDXQlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:41:09 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6506127A51
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:38:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VB2XPHZ_1650818277;
Received: from rt2b04371.sqa.tbc.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VB2XPHZ_1650818277)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Apr 2022 00:38:03 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        akpm@linux-foundation.org, tglx@linutronix.de, luto@kernel.org,
        legion@kernel.org, fenghua.yu@intel.com, david@redhat.com,
        bristot@redhat.com, bigeasy@linutronix.de, ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: Skip sched_core_fork/free() when core sched is disabled
Date:   Mon, 25 Apr 2022 00:37:56 +0800
Message-Id: <1650818276-129374-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As __put_task_struct() and copy_process() are hot path functions,
the call of sched_core_fork/free() will bring overhead when core
sched is disabled, and we skip them when core sched is disabled().

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 include/linux/sched.h | 10 ++++++++++
 kernel/fork.c         |  9 ++++++---
 kernel/sched/sched.h  | 10 ----------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f64f8f2..a2266df 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2406,9 +2406,19 @@ static inline void rseq_syscall(struct pt_regs *regs)
 extern void sched_core_fork(struct task_struct *p);
 extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 				unsigned long uaddr);
+DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
+static inline bool sched_core_disabled(void)
+{
+	return !static_branch_unlikely(&__sched_core_enabled);
+}
+
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
 static inline void sched_core_fork(struct task_struct *p) { }
+static inline bool sched_core_disabled(void)
+{
+	return true;
+}
 #endif
 
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 0d13baf..611f80b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -843,7 +843,8 @@ void __put_task_struct(struct task_struct *tsk)
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
-	sched_core_free(tsk);
+	if (!sched_core_disabled())
+		sched_core_free(tsk);
 	free_task(tsk);
 }
 EXPORT_SYMBOL_GPL(__put_task_struct);
@@ -2381,7 +2382,8 @@ static __latent_entropy struct task_struct *copy_process(
 
 	klp_copy_process(p);
 
-	sched_core_fork(p);
+	if (!sched_core_disabled())
+		sched_core_fork(p);
 
 	spin_lock(&current->sighand->siglock);
 
@@ -2469,7 +2471,8 @@ static __latent_entropy struct task_struct *copy_process(
 	return p;
 
 bad_fork_cancel_cgroup:
-	sched_core_free(p);
+	if (!sched_core_disabled())
+		sched_core_free(p);
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	cgroup_cancel_fork(p, args);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5b21448..c6aeeda 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1157,11 +1157,6 @@ static inline bool sched_core_enabled(struct rq *rq)
 	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
 }
 
-static inline bool sched_core_disabled(void)
-{
-	return !static_branch_unlikely(&__sched_core_enabled);
-}
-
 /*
  * Be careful with this function; not for general use. The return value isn't
  * stable unless you actually hold a relevant rq->__lock.
@@ -1257,11 +1252,6 @@ static inline bool sched_core_enabled(struct rq *rq)
 	return false;
 }
 
-static inline bool sched_core_disabled(void)
-{
-	return true;
-}
-
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	return &rq->__lock;
-- 
1.8.3.1

