Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523DD589D98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbiHDOhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239888AbiHDOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:36:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C819932461
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:36:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 406FA1480;
        Thu,  4 Aug 2022 07:36:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.10.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14A213F73B;
        Thu,  4 Aug 2022 07:36:44 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 5/9] sched/uclamp: Make asym_fits_capacity() use util_fits_cpu()
Date:   Thu,  4 Aug 2022 15:36:05 +0100
Message-Id: <20220804143609.515789-6-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804143609.515789-1-qais.yousef@arm.com>
References: <20220804143609.515789-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new util_fits_cpu() to ensure migration margin and capacity
pressure are taken into account correctly when uclamp is being used
otherwise we will fail to consider CPUs as fitting in scenarios where
they should.

s/asym_fits_capacity/asym_fits_cpu/ to better reflect what it does now.

Fixes: b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/fair.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3079ca867f2c..38cf56ade66d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6631,10 +6631,13 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	return best_cpu;
 }
 
-static inline bool asym_fits_capacity(unsigned long task_util, int cpu)
+static inline bool asym_fits_cpu(unsigned long util,
+				 unsigned long util_min,
+				 unsigned long util_max,
+				 int cpu)
 {
 	if (sched_asym_cpucap_active())
-		return fits_capacity(task_util, capacity_of(cpu));
+		return util_fits_cpu(util, util_min, util_max, cpu);
 
 	return true;
 }
@@ -6646,7 +6649,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
 	bool has_idle_core = false;
 	struct sched_domain *sd;
-	unsigned long task_util;
+	unsigned long task_util, util_min, util_max;
 	int i, recent_used_cpu;
 
 	/*
@@ -6655,7 +6658,9 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	if (sched_asym_cpucap_active()) {
 		sync_entity_load_avg(&p->se);
-		task_util = uclamp_task_util(p);
+		task_util = task_util_est(p);
+		util_min = uclamp_eff_value(p, UCLAMP_MIN);
+		util_max = uclamp_eff_value(p, UCLAMP_MAX);
 	}
 
 	/*
@@ -6664,7 +6669,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	lockdep_assert_irqs_disabled();
 
 	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
-	    asym_fits_capacity(task_util, target))
+	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
 	/*
@@ -6672,7 +6677,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
-	    asym_fits_capacity(task_util, prev))
+	    asym_fits_cpu(task_util, util_min, util_max, prev))
 		return prev;
 
 	/*
@@ -6687,7 +6692,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    in_task() &&
 	    prev == smp_processor_id() &&
 	    this_rq()->nr_running <= 1 &&
-	    asym_fits_capacity(task_util, prev)) {
+	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
 		return prev;
 	}
 
@@ -6699,7 +6704,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    cpus_share_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
-	    asym_fits_capacity(task_util, recent_used_cpu)) {
+	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
 		return recent_used_cpu;
 	}
 
-- 
2.25.1

