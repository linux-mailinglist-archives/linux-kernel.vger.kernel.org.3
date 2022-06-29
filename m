Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6884F55FFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiF2MVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiF2MVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:21:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F07852EA2F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:21:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03B461691;
        Wed, 29 Jun 2022 05:21:25 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 028C53F66F;
        Wed, 29 Jun 2022 05:21:22 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sched/deadline: Make dl_cpuset_cpumask_can_shrink() capacity-aware
Date:   Wed, 29 Jun 2022 14:20:52 +0200
Message-Id: <20220629122053.287165-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629122053.287165-1-dietmar.eggemann@arm.com>
References: <20220629122053.287165-1-dietmar.eggemann@arm.com>
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

dl_cpuset_cpumask_can_shrink() is used to validate whether there is
still enough CPU capacity for DL tasks in the reduced cpuset.

Currently it still operates on `# remaining CPUs in the cpuset` (1).
Change this to use the already capacity-aware DL admission control
__dl_overflow() for the `cpumask can shrink` test.

  dl_b->bw = sched_rt_period << BW_SHIFT / sched_rt_period

  dl_b->bw * (1) >= currently allocated bandwidth in root_domain (rd)

  Replace (1) w/ `\Sum CPU capacity in rd >> SCHED_CAPACITY_SHIFT`

Adapt __dl_bw_capacity() to take a cpumask instead of a CPU number
argument so that `rd->span` and `cpumask of the reduced cpuset` can
be used here.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/deadline.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3f9d90b8a8b6..34de6060dea6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -124,15 +124,12 @@ static inline int dl_bw_cpus(int i)
 	return cpus;
 }
 
-static inline unsigned long __dl_bw_capacity(int i)
+static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)
 {
-	struct root_domain *rd = cpu_rq(i)->rd;
 	unsigned long cap = 0;
+	int i;
 
-	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
-			 "sched RCU must be held");
-
-	for_each_cpu_and(i, rd->span, cpu_active_mask)
+	for_each_cpu_and(i, mask, cpu_active_mask)
 		cap += capacity_orig_of(i);
 
 	return cap;
@@ -148,7 +145,10 @@ static inline unsigned long dl_bw_capacity(int i)
 	    capacity_orig_of(i) == SCHED_CAPACITY_SCALE) {
 		return dl_bw_cpus(i) << SCHED_CAPACITY_SHIFT;
 	} else {
-		return __dl_bw_capacity(i);
+		RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
+				 "sched RCU must be held");
+
+		return __dl_bw_capacity(cpu_rq(i)->rd->span);
 	}
 }
 
@@ -3004,17 +3004,15 @@ bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 				 const struct cpumask *trial)
 {
-	int ret = 1, trial_cpus;
+	unsigned long flags, cap;
 	struct dl_bw *cur_dl_b;
-	unsigned long flags;
+	int ret = 1;
 
 	rcu_read_lock_sched();
 	cur_dl_b = dl_bw_of(cpumask_any(cur));
-	trial_cpus = cpumask_weight(trial);
-
+	cap = __dl_bw_capacity(trial);
 	raw_spin_lock_irqsave(&cur_dl_b->lock, flags);
-	if (cur_dl_b->bw != -1 &&
-	    cur_dl_b->bw * trial_cpus < cur_dl_b->total_bw)
+	if (__dl_overflow(cur_dl_b, cap, 0, 0))
 		ret = 0;
 	raw_spin_unlock_irqrestore(&cur_dl_b->lock, flags);
 	rcu_read_unlock_sched();
-- 
2.25.1

