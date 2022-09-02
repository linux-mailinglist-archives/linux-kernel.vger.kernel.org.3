Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B07B5AA87E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiIBHE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiIBHEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:04:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED410BC101
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662102263; x=1693638263;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cox5lSStTXxvPDdJM1Bm7NWqe+SAjCN+fp0k9U9fd3E=;
  b=ZCSg8GLbY4pIrO+4HceP7bvoxCP2hrMUVuy+6+PcLCMfDaaNfzJv8erX
   8s9h5RRnIYXoOaEl7yFFH1H8o2mwZ+vYU7E42/h57U3wmHMpd9Pjx2Gku
   mGt5g9njiIU8rDqq94s13r5DpF3qF6EfOCkw467d2f+PLKev1psEUJsiC
   RoAGtgriZACaPNzz8UBckqTW1C+pG+rJfUtcFmd7yjJOWzmx8RUJ50gwB
   57C1bUTRpopfzmkMAk081JlclTLG9J33jzgKh1wYy7tt/OnlaVoW3PtLk
   chLM9/5e77QNpOOgx5xbVnbWyAObFRzyAHvxcEMyk2Lr4bs+GTqJfohGC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="359870096"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="359870096"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 00:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674234906"
Received: from linux-pnp-server-13.sh.intel.com ([10.239.176.176])
  by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2022 00:04:19 -0700
From:   Jiebin Sun <jiebin.sun@intel.com>
To:     akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com, jiebin.sun@intel.com
Subject: [PATCH] ipc/msg.c: mitigate the lock contention with percpu counter
Date:   Fri,  2 Sep 2022 23:22:43 +0800
Message-Id: <20220902152243.479592-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msg_bytes and msg_hdrs atomic counters are frequently
updated when IPC msg queue is in heavy use, causing heavy
cache bounce and overhead. Change them to percpu_counters
greatly improve the performance. Since there is one unique
ipc namespace, additional memory cost is minimal. Reading
of the count done in msgctl call, which is infrequent. So
the need to sum up the counts in each CPU is infrequent.

Apply the patch and test the pts/stress-ng-1.4.0
-- system v message passing (160 threads).

Score gain: 3.38x

CPU: ICX 8380 x 2 sockets
Core number: 40 x 2 physical cores
Benchmark: pts/stress-ng-1.4.0
-- system v message passing (160 threads)

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
---
 include/linux/ipc_namespace.h  |  5 +++--
 include/linux/percpu_counter.h |  9 +++++++++
 ipc/msg.c                      | 30 +++++++++++++++++-------------
 lib/percpu_counter.c           |  6 ++++++
 4 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index e3e8c8662b49..e8240cf2611a 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -11,6 +11,7 @@
 #include <linux/refcount.h>
 #include <linux/rhashtable-types.h>
 #include <linux/sysctl.h>
+#include <linux/percpu_counter.h>
 
 struct user_namespace;
 
@@ -36,8 +37,8 @@ struct ipc_namespace {
 	unsigned int	msg_ctlmax;
 	unsigned int	msg_ctlmnb;
 	unsigned int	msg_ctlmni;
-	atomic_t	msg_bytes;
-	atomic_t	msg_hdrs;
+	struct percpu_counter percpu_msg_bytes;
+	struct percpu_counter percpu_msg_hdrs;
 
 	size_t		shm_ctlmax;
 	size_t		shm_ctlall;
diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 01861eebed79..6eec30122cc3 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -40,6 +40,7 @@ int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
 
 void percpu_counter_destroy(struct percpu_counter *fbc);
 void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
+void percpu_counter_add_local(struct percpu_counter *fbc, s64 amount);
 void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
 			      s32 batch);
 s64 __percpu_counter_sum(struct percpu_counter *fbc);
@@ -138,6 +139,14 @@ percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 	preempt_enable();
 }
 
+static inline void
+percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
+{
+	preempt_disable();
+	fbc->count += amount;
+	preempt_enable();
+}
+
 static inline void
 percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 {
diff --git a/ipc/msg.c b/ipc/msg.c
index a0d05775af2c..1b498537f05e 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -39,6 +39,7 @@
 #include <linux/nsproxy.h>
 #include <linux/ipc_namespace.h>
 #include <linux/rhashtable.h>
+#include <linux/percpu_counter.h>
 
 #include <asm/current.h>
 #include <linux/uaccess.h>
@@ -285,10 +286,10 @@ static void freeque(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 	rcu_read_unlock();
 
 	list_for_each_entry_safe(msg, t, &msq->q_messages, m_list) {
-		atomic_dec(&ns->msg_hdrs);
+		percpu_counter_add_local(&ns->percpu_msg_hdrs, -1);
 		free_msg(msg);
 	}
-	atomic_sub(msq->q_cbytes, &ns->msg_bytes);
+	percpu_counter_add_local(&ns->percpu_msg_bytes, -(msq->q_cbytes));
 	ipc_update_pid(&msq->q_lspid, NULL);
 	ipc_update_pid(&msq->q_lrpid, NULL);
 	ipc_rcu_putref(&msq->q_perm, msg_rcu_free);
@@ -495,17 +496,18 @@ static int msgctl_info(struct ipc_namespace *ns, int msqid,
 	msginfo->msgssz = MSGSSZ;
 	msginfo->msgseg = MSGSEG;
 	down_read(&msg_ids(ns).rwsem);
-	if (cmd == MSG_INFO) {
+	if (cmd == MSG_INFO)
 		msginfo->msgpool = msg_ids(ns).in_use;
-		msginfo->msgmap = atomic_read(&ns->msg_hdrs);
-		msginfo->msgtql = atomic_read(&ns->msg_bytes);
+	max_idx = ipc_get_maxidx(&msg_ids(ns));
+	up_read(&msg_ids(ns).rwsem);
+	if (cmd == MSG_INFO) {
+		msginfo->msgmap = percpu_counter_sum(&ns->percpu_msg_hdrs);
+		msginfo->msgtql = percpu_counter_sum(&ns->percpu_msg_bytes);
 	} else {
 		msginfo->msgmap = MSGMAP;
 		msginfo->msgpool = MSGPOOL;
 		msginfo->msgtql = MSGTQL;
 	}
-	max_idx = ipc_get_maxidx(&msg_ids(ns));
-	up_read(&msg_ids(ns).rwsem);
 	return (max_idx < 0) ? 0 : max_idx;
 }
 
@@ -935,8 +937,8 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 		list_add_tail(&msg->m_list, &msq->q_messages);
 		msq->q_cbytes += msgsz;
 		msq->q_qnum++;
-		atomic_add(msgsz, &ns->msg_bytes);
-		atomic_inc(&ns->msg_hdrs);
+		percpu_counter_add_local(&ns->percpu_msg_bytes, msgsz);
+		percpu_counter_add_local(&ns->percpu_msg_hdrs, 1);
 	}
 
 	err = 0;
@@ -1159,8 +1161,8 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 			msq->q_rtime = ktime_get_real_seconds();
 			ipc_update_pid(&msq->q_lrpid, task_tgid(current));
 			msq->q_cbytes -= msg->m_ts;
-			atomic_sub(msg->m_ts, &ns->msg_bytes);
-			atomic_dec(&ns->msg_hdrs);
+			percpu_counter_add_local(&ns->percpu_msg_bytes, -(msg->m_ts));
+			percpu_counter_add_local(&ns->percpu_msg_hdrs, -1);
 			ss_wakeup(msq, &wake_q, false);
 
 			goto out_unlock0;
@@ -1303,14 +1305,16 @@ void msg_init_ns(struct ipc_namespace *ns)
 	ns->msg_ctlmnb = MSGMNB;
 	ns->msg_ctlmni = MSGMNI;
 
-	atomic_set(&ns->msg_bytes, 0);
-	atomic_set(&ns->msg_hdrs, 0);
+	percpu_counter_init(&ns->percpu_msg_bytes, 0, GFP_KERNEL);
+	percpu_counter_init(&ns->percpu_msg_hdrs, 0, GFP_KERNEL);
 	ipc_init_ids(&ns->ids[IPC_MSG_IDS]);
 }
 
 #ifdef CONFIG_IPC_NS
 void msg_exit_ns(struct ipc_namespace *ns)
 {
+	percpu_counter_destroy(&ns->percpu_msg_bytes);
+	percpu_counter_destroy(&ns->percpu_msg_hdrs);
 	free_ipcs(ns, &msg_ids(ns), freeque);
 	idr_destroy(&ns->ids[IPC_MSG_IDS].ipcs_idr);
 	rhashtable_destroy(&ns->ids[IPC_MSG_IDS].key_ht);
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index ed610b75dc32..d33cb750962a 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -72,6 +72,12 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
 }
 EXPORT_SYMBOL(percpu_counter_set);
 
+void percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
+{
+	this_cpu_add(*fbc->counters, amount);
+}
+EXPORT_SYMBOL(percpu_counter_add_local);
+
 /*
  * This function is both preempt and irq safe. The former is due to explicit
  * preemption disable. The latter is guaranteed by the fact that the slow path
-- 
2.31.1

