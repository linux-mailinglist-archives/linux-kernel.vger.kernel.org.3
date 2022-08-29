Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8FD5A42C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiH2F4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiH2F4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:56:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58EC224083
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 22:55:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2908D1424;
        Sun, 28 Aug 2022 22:55:25 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B626B3F766;
        Sun, 28 Aug 2022 22:55:45 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>
Cc:     Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] sched/pelt: Introduce PELT multiplier
Date:   Mon, 29 Aug 2022 07:54:50 +0200
Message-Id: <20220829055450.1703092-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

The new sysctl sched_pelt_multiplier allows a user to set a clock
multiplier to x2 or x4 (x1 being the default). This clock multiplier
artificially speeds up PELT ramp up/down similarly to use a faster
half-life than the default 32ms.

  - x1: 32ms half-life
  - x2: 16ms half-life
  - x4: 8ms  half-life

Internally, a new clock is created: rq->clock_task_mult. It sits in the
clock hierarchy between rq->clock_task and rq->clock_pelt.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/pelt.c  | 60 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/pelt.h  | 42 ++++++++++++++++++++++++++++---
 kernel/sched/sched.h |  1 +
 4 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 603a80ec9b0e..6203cead4ad3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -727,7 +727,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
 		update_irq_load_avg(rq, irq_delta + steal);
 #endif
-	update_rq_clock_pelt(rq, delta);
+	update_rq_clock_task_mult(rq, delta);
 }
 
 void update_rq_clock(struct rq *rq)
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 9adfc4744544..9fa853a64269 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -472,3 +472,63 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	return ret;
 }
 #endif
+
+__read_mostly unsigned int sched_pelt_lshift;
+
+#ifdef CONFIG_SYSCTL
+static unsigned int sysctl_sched_pelt_multiplier = 1;
+
+int sched_pelt_multiplier(struct ctl_table *table, int write, void *buffer,
+			  size_t *lenp, loff_t *ppos)
+{
+	static DEFINE_MUTEX(mutex);
+	unsigned int old;
+	int ret;
+
+	mutex_lock(&mutex);
+	old = sysctl_sched_pelt_multiplier;
+	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (ret)
+		goto undo;
+	if (!write)
+		goto done;
+
+	switch (sysctl_sched_pelt_multiplier)  {
+	case 1:
+		fallthrough;
+	case 2:
+		fallthrough;
+	case 4:
+		WRITE_ONCE(sched_pelt_lshift,
+			   sysctl_sched_pelt_multiplier >> 1);
+		goto done;
+	default:
+		ret = -EINVAL;
+	}
+
+undo:
+	sysctl_sched_pelt_multiplier = old;
+done:
+	mutex_unlock(&mutex);
+
+	return ret;
+}
+
+static struct ctl_table sched_pelt_sysctls[] = {
+	{
+		.procname       = "sched_pelt_multiplier",
+		.data           = &sysctl_sched_pelt_multiplier,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = sched_pelt_multiplier,
+	},
+	{}
+};
+
+static int __init sched_pelt_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_pelt_sysctls);
+	return 0;
+}
+late_initcall(sched_pelt_sysctl_init);
+#endif
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 3a0e0dc28721..9b35b5072bae 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -61,6 +61,14 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 	WRITE_ONCE(avg->util_est.enqueued, enqueued);
 }
 
+static inline u64 rq_clock_task_mult(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	assert_clock_updated(rq);
+
+	return rq->clock_task_mult;
+}
+
 static inline u64 rq_clock_pelt(struct rq *rq)
 {
 	lockdep_assert_rq_held(rq);
@@ -72,7 +80,7 @@ static inline u64 rq_clock_pelt(struct rq *rq)
 /* The rq is idle, we can sync to clock_task */
 static inline void _update_idle_rq_clock_pelt(struct rq *rq)
 {
-	rq->clock_pelt  = rq_clock_task(rq);
+	rq->clock_pelt = rq_clock_task_mult(rq);
 
 	u64_u32_store(rq->clock_idle, rq_clock(rq));
 	/* Paired with smp_rmb in migrate_se_pelt_lag() */
@@ -121,6 +129,27 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 	rq->clock_pelt += delta;
 }
 
+extern unsigned int sched_pelt_lshift;
+
+/*
+ * absolute time   |1      |2      |3      |4      |5      |6      |
+ * @ mult = 1      --------****************--------****************-
+ * @ mult = 2      --------********----------------********---------
+ * @ mult = 4      --------****--------------------****-------------
+ * clock task mult
+ * @ mult = 2      |   |   |2  |3  |   |   |   |   |5  |6  |   |   |
+ * @ mult = 4      | | | | |2|3| | | | | | | | | | |5|6| | | | | | |
+ *
+ */
+static inline void update_rq_clock_task_mult(struct rq *rq, s64 delta)
+{
+	delta <<= READ_ONCE(sched_pelt_lshift);
+
+	rq->clock_task_mult += delta;
+
+	update_rq_clock_pelt(rq, delta);
+}
+
 /*
  * When rq becomes idle, we have to check if it has lost idle time
  * because it was fully busy. A rq is fully used when the /Sum util_sum
@@ -147,7 +176,7 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
 	 * rq's clock_task.
 	 */
 	if (util_sum >= divider)
-		rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
+		rq->lost_idle_time += rq_clock_task_mult(rq) - rq->clock_pelt;
 
 	_update_idle_rq_clock_pelt(rq);
 }
@@ -218,13 +247,18 @@ update_irq_load_avg(struct rq *rq, u64 running)
 	return 0;
 }
 
-static inline u64 rq_clock_pelt(struct rq *rq)
+static inline u64 rq_clock_task_mult(struct rq *rq)
 {
 	return rq_clock_task(rq);
 }
 
+static inline u64 rq_clock_pelt(struct rq *rq)
+{
+	return rq_clock_task_mult(rq);
+}
+
 static inline void
-update_rq_clock_pelt(struct rq *rq, s64 delta) { }
+update_rq_clock_task_mult(struct rq *rq, s64 delta) { }
 
 static inline void
 update_idle_rq_clock_pelt(struct rq *rq) { }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index da17be6f27fd..62fc3cf10ea7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1007,6 +1007,7 @@ struct rq {
 	u64			clock;
 	/* Ensure that all clocks are in the same cache line */
 	u64			clock_task ____cacheline_aligned;
+	u64			clock_task_mult;
 	u64			clock_pelt;
 	unsigned long		lost_idle_time;
 	u64			clock_pelt_idle;
-- 
2.25.1

