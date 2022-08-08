Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802A158C336
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiHHGUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiHHGUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:20:30 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C74272A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:20:27 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 2786DVQ5076732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Mon, 8 Aug 2022 14:13:31 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 8 Aug 2022 14:13:31 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <xuewen.yan@unisoc.com>
Subject: [RFC PATCH] psi: introduce PSI UNINTERRUPTIBLE
Date:   Mon, 8 Aug 2022 14:13:28 +0800
Message-ID: <1659939208-22454-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 2786DVQ5076732
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Uninterruptible sleep has not been monitored as an important system status yet.
Imagin that a set of psi triggers are created for monitoring a special group, while
get nothing high for none of the pressures, which could be the processes within
are stock in some given resources and turn to be UN status. Introduce PSI_UN as
a sub-type among PSI system here.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/psi_types.h | 11 ++++++++---
 kernel/sched/psi.c        | 10 ++++++++++
 kernel/sched/stats.h      |  6 +++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index c7fe7c0..8cc1979 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -15,6 +15,7 @@ enum psi_task_count {
 	NR_IOWAIT,
 	NR_MEMSTALL,
 	NR_RUNNING,
+	NR_UNINTERRUPTIBLE,
 	/*
 	 * This can't have values other than 0 or 1 and could be
 	 * implemented as a bit flag. But for now we still have room
@@ -32,7 +33,7 @@ enum psi_task_count {
 	 * threads and memstall ones.
 	 */
 	NR_MEMSTALL_RUNNING,
-	NR_PSI_TASK_COUNTS = 5,
+	NR_PSI_TASK_COUNTS = 6,
 };
 
 /* Task state bitmasks */
@@ -41,13 +42,15 @@ enum psi_task_count {
 #define TSK_RUNNING	(1 << NR_RUNNING)
 #define TSK_ONCPU	(1 << NR_ONCPU)
 #define TSK_MEMSTALL_RUNNING	(1 << NR_MEMSTALL_RUNNING)
+#define TSK_UNINTERRUPTIBLE	(1 << NR_UNINTERRUPTIBLE)
 
 /* Resources that workloads could be stalled on */
 enum psi_res {
 	PSI_IO,
 	PSI_MEM,
 	PSI_CPU,
-	NR_PSI_RESOURCES = 3,
+	PSI_UN,
+	NR_PSI_RESOURCES = 4,
 };
 
 /*
@@ -63,9 +66,11 @@ enum psi_states {
 	PSI_MEM_FULL,
 	PSI_CPU_SOME,
 	PSI_CPU_FULL,
+	PSI_UN_SOME,
+	PSI_UN_FULL,
 	/* Only per-CPU, to weigh the CPU in the global average: */
 	PSI_NONIDLE,
-	NR_PSI_STATES = 7,
+	NR_PSI_STATES = 9,
 };
 
 enum psi_aggregators {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a337f3e..a37b4a4 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -231,6 +231,10 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 		return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
 	case PSI_CPU_FULL:
 		return unlikely(tasks[NR_RUNNING] && !tasks[NR_ONCPU]);
+	case PSI_UN_SOME:
+		return unlikely(tasks[NR_UNINTERRUPTIBLE]);
+	case PSI_UN_FULL:
+		return unlikely(tasks[NR_UNINTERRUPTIBLE] && !tasks[NR_RUNNING]);
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -683,6 +687,12 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 			groupc->times[PSI_CPU_FULL] += delta;
 	}
 
+	if (groupc->state_mask & (1 << PSI_UN_SOME)) {
+		groupc->times[PSI_UN_SOME] += delta;
+		if (groupc->state_mask & (1 << PSI_UN_FULL))
+			groupc->times[PSI_UN_FULL] += delta;
+	}
+
 	if (groupc->state_mask & (1 << PSI_NONIDLE))
 		groupc->times[PSI_NONIDLE] += delta;
 }
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index baa839c..bf98829 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -132,6 +132,7 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 		if (p->in_iowait)
 			clear |= TSK_IOWAIT;
 	}
+	clear |= TSK_UNINTERRUPTIBLE;
 
 	psi_task_change(p, clear, set);
 }
@@ -139,6 +140,7 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 static inline void psi_dequeue(struct task_struct *p, bool sleep)
 {
 	int clear = TSK_RUNNING;
+	int set = 0;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
@@ -154,8 +156,10 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 
 	if (p->in_memstall)
 		clear |= (TSK_MEMSTALL | TSK_MEMSTALL_RUNNING);
+	if (READ_ONCE(p->__state) & TASK_UNINTERRUPTIBLE)
+		set = TSK_UNINTERRUPTIBLE;
 
-	psi_task_change(p, clear, 0);
+	psi_task_change(p, clear, set);
 }
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)
-- 
1.9.1

