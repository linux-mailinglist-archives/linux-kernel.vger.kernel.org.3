Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E033D5AE2EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbiIFIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbiIFIhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:37:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664037757C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662453342; x=1693989342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+hfxFTBslo19p0IshemZ5IUFjK6rhpELRZSOm1JDagE=;
  b=NSF5dJhEJXhuZV8yg7IyKXrggTO9n4Lf7Ng8mkoXQyRBXHNilTwfSpZh
   Y+4nAsBcw2av0OQsItrSwkwnvQUG6fhUOfnQMMfvsMThh8LrWSbGqE11+
   XGN+xFpoFZELaznpdG/sQWGO+nKY6+ipGm1+PZCysb/MzMWQHm8EfGFV1
   jgQednG0WGSE+ShfPnfp5GJEXmBLwlj2YIcbA9bydOZwCJtOtCUmGrhH8
   Ll+91qrXpb2sU5HBeRmgwM2JmT7xxRbhGWUcGQKtnpxyYIGUoJQLFA2xn
   0GjLosafCb6DjlaAloG6GXc848valsOMtx1MbYh5HptsLktBNe6/ZJNad
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="297850690"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="297850690"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 01:35:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="675597149"
Received: from linux-pnp-server-13.sh.intel.com ([10.239.176.176])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2022 01:35:34 -0700
From:   Jiebin Sun <jiebin.sun@intel.com>
To:     akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com, jiebin.sun@intel.com
Subject: [PATCH v3 2/2] ipc/msg: mitigate the lock contention with percpu counter
Date:   Wed,  7 Sep 2022 00:54:30 +0800
Message-Id: <20220906165430.851424-3-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906165430.851424-1-jiebin.sun@intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220906165430.851424-1-jiebin.sun@intel.com>
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
cache bounce and overhead. Change them to percpu_counter
greatly improve the performance. Since there is one percpu
struct per namespace, additional memory cost is minimal.
Reading of the count done in msgctl call, which is infrequent.
So the need to sum up the counts in each CPU is infrequent.

Apply the patch and test the pts/stress-ng-1.4.0
-- system v message passing (160 threads).

Score gain: 3.38x

CPU: ICX 8380 x 2 sockets
Core number: 40 x 2 physical cores
Benchmark: pts/stress-ng-1.4.0
-- system v message passing (160 threads)

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
---
 include/linux/ipc_namespace.h |  5 ++--
 ipc/msg.c                     | 44 ++++++++++++++++++++++++-----------
 ipc/namespace.c               |  5 +++-
 ipc/util.h                    |  4 ++--
 4 files changed, 39 insertions(+), 19 deletions(-)

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
diff --git a/ipc/msg.c b/ipc/msg.c
index a0d05775af2c..87c30decb23f 100644
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
@@ -1297,20 +1299,34 @@ COMPAT_SYSCALL_DEFINE5(msgrcv, int, msqid, compat_uptr_t, msgp,
 }
 #endif
 
-void msg_init_ns(struct ipc_namespace *ns)
+int msg_init_ns(struct ipc_namespace *ns)
 {
+	int ret;
+
 	ns->msg_ctlmax = MSGMAX;
 	ns->msg_ctlmnb = MSGMNB;
 	ns->msg_ctlmni = MSGMNI;
 
-	atomic_set(&ns->msg_bytes, 0);
-	atomic_set(&ns->msg_hdrs, 0);
+	ret = percpu_counter_init(&ns->percpu_msg_bytes, 0, GFP_KERNEL);
+	if (ret)
+		goto fail_msg_bytes;
+	ret = percpu_counter_init(&ns->percpu_msg_hdrs, 0, GFP_KERNEL);
+	if (ret)
+		goto fail_msg_hdrs;
 	ipc_init_ids(&ns->ids[IPC_MSG_IDS]);
+	return 0;
+
+	fail_msg_hdrs:
+		percpu_counter_destroy(&ns->percpu_msg_bytes);
+	fail_msg_bytes:
+		return ret;
 }
 
 #ifdef CONFIG_IPC_NS
 void msg_exit_ns(struct ipc_namespace *ns)
 {
+	percpu_counter_destroy(&ns->percpu_msg_bytes);
+	percpu_counter_destroy(&ns->percpu_msg_hdrs);
 	free_ipcs(ns, &msg_ids(ns), freeque);
 	idr_destroy(&ns->ids[IPC_MSG_IDS].ipcs_idr);
 	rhashtable_destroy(&ns->ids[IPC_MSG_IDS].key_ht);
diff --git a/ipc/namespace.c b/ipc/namespace.c
index e1fcaedba4fa..8316ea585733 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -66,8 +66,11 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	if (!setup_ipc_sysctls(ns))
 		goto fail_mq;
 
+	err = msg_init_ns(ns);
+	if (err)
+		goto fail_put;
+
 	sem_init_ns(ns);
-	msg_init_ns(ns);
 	shm_init_ns(ns);
 
 	return ns;
diff --git a/ipc/util.h b/ipc/util.h
index 2dd7ce0416d8..1b0086c6346f 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -64,7 +64,7 @@ static inline void mq_put_mnt(struct ipc_namespace *ns) { }
 
 #ifdef CONFIG_SYSVIPC
 void sem_init_ns(struct ipc_namespace *ns);
-void msg_init_ns(struct ipc_namespace *ns);
+int msg_init_ns(struct ipc_namespace *ns);
 void shm_init_ns(struct ipc_namespace *ns);
 
 void sem_exit_ns(struct ipc_namespace *ns);
@@ -72,7 +72,7 @@ void msg_exit_ns(struct ipc_namespace *ns);
 void shm_exit_ns(struct ipc_namespace *ns);
 #else
 static inline void sem_init_ns(struct ipc_namespace *ns) { }
-static inline void msg_init_ns(struct ipc_namespace *ns) { }
+static inline int msg_init_ns(struct ipc_namespace *ns) { return 0;}
 static inline void shm_init_ns(struct ipc_namespace *ns) { }
 
 static inline void sem_exit_ns(struct ipc_namespace *ns) { }
-- 
2.31.1

