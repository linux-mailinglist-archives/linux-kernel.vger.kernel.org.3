Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39E85A31F3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbiHZWSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345312AbiHZWSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:18:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FFFE97F7;
        Fri, 26 Aug 2022 15:16:28 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:16:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8rcOv9bnjFEhaP3jUDMABc6AkpKsSPaO+6Q7g/NYuo=;
        b=soh7whY9hpUNj9IdXiS5pppsD/5lKUo2kUyO6I2+k6XNCPs9LihZLBhP3acLjhanDs+OvX
        i1j9IGeA2hScNrT6IllOEq8sFs251IYnl/cHWuA/iq0EMIpUq1WFmhbP9yHwkFGjne06TQ
        pi4Cs/4rXVlTFeoAZDibDr057zZEACT7vHMpv00QaTBonI9YketJ4+gdgkRfCL0ig/VRQs
        5awRosSGwOVSwnkhhzu80mTWLR2HnKpsbSJam5m2B0mSQZCPcY2u0LZDE1Y7iQoEaRQjx1
        czah0akk0JScLlozE+c2Rl7Fyx0BB4+7OwMqy3/fat/LkB9yNzqWqK+ik5aLDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8rcOv9bnjFEhaP3jUDMABc6AkpKsSPaO+6Q7g/NYuo=;
        b=xz27I/UiJUldxqZekmKozq73WC2hv5vZYh327A6eWL9CoAwzB9JvtM/o+5bANbYcHDLWfi
        XohwSs+ErHsaf+DQ==
From:   "tip-bot2 for Shang XiaoJing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add update_current_exec_runtime helper
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824082856.15674-1-shangxiaojing@huawei.com>
References: <20220824082856.15674-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Message-ID: <166155218400.401.13859107788980871095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5531ecffa4b923bc7739e9ea73c552d80af602dc
Gitweb:        https://git.kernel.org/tip/5531ecffa4b923bc7739e9ea73c552d80af602dc
Author:        Shang XiaoJing <shangxiaojing@huawei.com>
AuthorDate:    Wed, 24 Aug 2022 16:28:56 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:35 +02:00

sched: Add update_current_exec_runtime helper

Wrap repeated code in helper function update_current_exec_runtime for
update the exec time of the current.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220824082856.15674-1-shangxiaojing@huawei.com
---
 kernel/sched/deadline.c  |  6 +-----
 kernel/sched/rt.c        |  6 +-----
 kernel/sched/sched.h     | 10 ++++++++++
 kernel/sched/stop_task.c | 11 ++++-------
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1d9c909..4cbdc0c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1333,11 +1333,7 @@ static void update_curr_dl(struct rq *rq)
 
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
+	update_current_exec_runtime(curr, now, delta_exec);
 
 	if (dl_entity_is_special(dl_se))
 		return;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 054b671..4bc84a1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1062,11 +1062,7 @@ static void update_curr_rt(struct rq *rq)
 
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
+	update_current_exec_runtime(curr, now, delta_exec);
 
 	if (!rt_bandwidth_enabled())
 		return;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 74130a6..da17be6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3158,4 +3158,14 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
+static inline void update_current_exec_runtime(struct task_struct *curr,
+						u64 now, u64 delta_exec)
+{
+	curr->se.sum_exec_runtime += delta_exec;
+	account_group_exec_runtime(curr, delta_exec);
+
+	curr->se.exec_start = now;
+	cgroup_account_cputime(curr, delta_exec);
+}
+
 #endif /* _KERNEL_SCHED_SCHED_H */
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index d04073a..8559059 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -71,20 +71,17 @@ static void yield_task_stop(struct rq *rq)
 static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 {
 	struct task_struct *curr = rq->curr;
-	u64 delta_exec;
+	u64 now, delta_exec;
 
-	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
+	now = rq_clock_task(rq);
+	delta_exec = now - curr->se.exec_start;
 	if (unlikely((s64)delta_exec < 0))
 		delta_exec = 0;
 
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = rq_clock_task(rq);
-	cgroup_account_cputime(curr, delta_exec);
+	update_current_exec_runtime(curr, now, delta_exec);
 }
 
 /*
