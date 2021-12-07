Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E14246BD80
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbhLGOZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:25:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53292 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237694AbhLGOZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:25:48 -0500
Date:   Tue, 07 Dec 2021 14:22:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638886937;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OK4tlzRYAwUnaJEGRKyHwSjsFA0N+ILmf7IGpFjcDm4=;
        b=K3SX62/Sal4iOiBQN/tDLT5OzvF1tqp1m3ke3jqW3CSNnlVW1uCBQb9weDHiINmZPSfz+X
        qxFm62uR21J0q+mBHnIuEKW34RiWaASRYUAJNidHJvWZA+mE6wjCUsEIXMmuHV1HfSi3aq
        5+cOilJS1Ov4lriVC566x0xonSehVjlYgbmwhzsdCWLZ6Kr8yw0R63Sc99kZvc0p10y148
        8XTHBt9fIH+gwJM2YriJoG+bOzLUgEf7Q8wbIxOblXrJaVx1hTwruVVhwdnb3QhIzvCNHp
        LPjJaPqmtQJCicD+MqZwkjXsx448LgQmbPNNXsyqiV7XsJA/wX+eBpLDmUpsGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638886937;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OK4tlzRYAwUnaJEGRKyHwSjsFA0N+ILmf7IGpFjcDm4=;
        b=rd/25V7nQMzVWwRXxyxekGqU8sswJHIBxm0UKABAAbkzZTkRv5ChG594GSk1K0FBkbp6cU
        WdoNbWLCVZZs8aBQ==
From:   "tip-bot2 for Li Hua" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Try to restart rt period timer when rt
 runtime exceeded
Cc:     Hulk Robot <hulkci@huawei.com>, Li Hua <hucool.lihua@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211203033618.11895-1-hucool.lihua@huawei.com>
References: <20211203033618.11895-1-hucool.lihua@huawei.com>
MIME-Version: 1.0
Message-ID: <163888693639.11128.16223328603745388120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9b58e976b3b391c0cf02e038d53dd0478ed3013c
Gitweb:        https://git.kernel.org/tip/9b58e976b3b391c0cf02e038d53dd0478ed3013c
Author:        Li Hua <hucool.lihua@huawei.com>
AuthorDate:    Fri, 03 Dec 2021 03:36:18 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 07 Dec 2021 15:14:10 +01:00

sched/rt: Try to restart rt period timer when rt runtime exceeded

When rt_runtime is modified from -1 to a valid control value, it may
cause the task to be throttled all the time. Operations like the following
will trigger the bug. E.g:

  1. echo -1 > /proc/sys/kernel/sched_rt_runtime_us
  2. Run a FIFO task named A that executes while(1)
  3. echo 950000 > /proc/sys/kernel/sched_rt_runtime_us

When rt_runtime is -1, The rt period timer will not be activated when task
A enqueued. And then the task will be throttled after setting rt_runtime to
950,000. The task will always be throttled because the rt period timer is
not activated.

Fixes: d0b27fa77854 ("sched: rt-group: synchonised bandwidth period")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Hua <hucool.lihua@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211203033618.11895-1-hucool.lihua@huawei.com
---
 kernel/sched/rt.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b48baab..7b4f4fb 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -52,11 +52,8 @@ void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime)
 	rt_b->rt_period_timer.function = sched_rt_period_timer;
 }
 
-static void start_rt_bandwidth(struct rt_bandwidth *rt_b)
+static inline void do_start_rt_bandwidth(struct rt_bandwidth *rt_b)
 {
-	if (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF)
-		return;
-
 	raw_spin_lock(&rt_b->rt_runtime_lock);
 	if (!rt_b->rt_period_active) {
 		rt_b->rt_period_active = 1;
@@ -75,6 +72,14 @@ static void start_rt_bandwidth(struct rt_bandwidth *rt_b)
 	raw_spin_unlock(&rt_b->rt_runtime_lock);
 }
 
+static void start_rt_bandwidth(struct rt_bandwidth *rt_b)
+{
+	if (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF)
+		return;
+
+	do_start_rt_bandwidth(rt_b);
+}
+
 void init_rt_rq(struct rt_rq *rt_rq)
 {
 	struct rt_prio_array *array;
@@ -1031,13 +1036,17 @@ static void update_curr_rt(struct rq *rq)
 
 	for_each_sched_rt_entity(rt_se) {
 		struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
+		int exceeded;
 
 		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
 			raw_spin_lock(&rt_rq->rt_runtime_lock);
 			rt_rq->rt_time += delta_exec;
-			if (sched_rt_runtime_exceeded(rt_rq))
+			exceeded = sched_rt_runtime_exceeded(rt_rq);
+			if (exceeded)
 				resched_curr(rq);
 			raw_spin_unlock(&rt_rq->rt_runtime_lock);
+			if (exceeded)
+				do_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
 		}
 	}
 }
@@ -2911,8 +2920,12 @@ static int sched_rt_global_validate(void)
 
 static void sched_rt_do_global(void)
 {
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&def_rt_bandwidth.rt_runtime_lock, flags);
 	def_rt_bandwidth.rt_runtime = global_rt_runtime();
 	def_rt_bandwidth.rt_period = ns_to_ktime(global_rt_period());
+	raw_spin_unlock_irqrestore(&def_rt_bandwidth.rt_runtime_lock, flags);
 }
 
 int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
