Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2092D55FFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiF2MV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiF2MVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:21:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC4832FFF4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:21:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED2B5153B;
        Wed, 29 Jun 2022 05:21:22 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 00E073F66F;
        Wed, 29 Jun 2022 05:21:20 -0700 (PDT)
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
Subject: [PATCH 1/3] sched: Introduce sched_asym_cpucap_active()
Date:   Wed, 29 Jun 2022 14:20:51 +0200
Message-Id: <20220629122053.287165-2-dietmar.eggemann@arm.com>
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

Create an inline helper for conditional code to be only executed on
asymmetric CPU capacity systems. This makes these (currently ~10 and
future) conditions a lot more readable.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/cpudeadline.c | 2 +-
 kernel/sched/deadline.c    | 4 ++--
 kernel/sched/fair.c        | 8 ++++----
 kernel/sched/rt.c          | 4 ++--
 kernel/sched/sched.h       | 5 +++++
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 02d970a879ed..57c92d751bcd 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -123,7 +123,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 		unsigned long cap, max_cap = 0;
 		int cpu, max_cpu = -1;
 
-		if (!static_branch_unlikely(&sched_asym_cpucapacity))
+		if (!sched_asym_cpucap_active())
 			return 1;
 
 		/* Ensure the capacity of the CPUs fits the task. */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5867e186c39a..3f9d90b8a8b6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -144,7 +144,7 @@ static inline unsigned long __dl_bw_capacity(int i)
  */
 static inline unsigned long dl_bw_capacity(int i)
 {
-	if (!static_branch_unlikely(&sched_asym_cpucapacity) &&
+	if (!sched_asym_cpucap_active() &&
 	    capacity_orig_of(i) == SCHED_CAPACITY_SCALE) {
 		return dl_bw_cpus(i) << SCHED_CAPACITY_SHIFT;
 	} else {
@@ -1846,7 +1846,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 	 * Take the capacity of the CPU into account to
 	 * ensure it fits the requirement of the task.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity))
+	if (sched_asym_cpucap_active())
 		select_rq |= !dl_task_fits_capacity(p, cpu);
 
 	if (select_rq) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f80ae86bb404..f32e0866b9c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4211,7 +4211,7 @@ static inline int task_fits_capacity(struct task_struct *p,
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 {
-	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+	if (!sched_asym_cpucap_active())
 		return;
 
 	if (!p || p->nr_cpus_allowed == 1) {
@@ -6452,7 +6452,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 
 static inline bool asym_fits_capacity(unsigned long task_util, int cpu)
 {
-	if (static_branch_unlikely(&sched_asym_cpucapacity))
+	if (sched_asym_cpucap_active())
 		return fits_capacity(task_util, capacity_of(cpu));
 
 	return true;
@@ -6472,7 +6472,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * On asymmetric system, update task utilization because we will check
 	 * that the task fits with cpu's capacity.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+	if (sched_asym_cpucap_active()) {
 		sync_entity_load_avg(&p->se);
 		task_util = uclamp_task_util(p);
 	}
@@ -6526,7 +6526,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * For asymmetric CPU capacity systems, our domain of interest is
 	 * sd_asym_cpucapacity rather than sd_llc.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+	if (sched_asym_cpucap_active()) {
 		sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
 		/*
 		 * On an asymmetric CPU capacity system where an exclusive
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed9664840..f0c297c1bd78 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -509,7 +509,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 	unsigned int cpu_cap;
 
 	/* Only heterogeneous systems can benefit from this check */
-	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+	if (!sched_asym_cpucap_active())
 		return true;
 
 	min_cap = uclamp_eff_value(p, UCLAMP_MIN);
@@ -1894,7 +1894,7 @@ static int find_lowest_rq(struct task_struct *task)
 	 * If we're on asym system ensure we consider the different capacities
 	 * of the CPUs when searching for the lowest_mask.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+	if (sched_asym_cpucap_active()) {
 
 		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
 					  task, lowest_mask,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 02c970501295..79f65a6799c6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1759,6 +1759,11 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 
+static __always_inline bool sched_asym_cpucap_active(void)
+{
+	return static_branch_unlikely(&sched_asym_cpucapacity);
+}
+
 struct sched_group_capacity {
 	atomic_t		ref;
 	/*
-- 
2.25.1

