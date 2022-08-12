Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F989590F06
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbiHLKQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbiHLKQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:16:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E5A4275CF;
        Fri, 12 Aug 2022 03:16:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 739AB106F;
        Fri, 12 Aug 2022 03:16:29 -0700 (PDT)
Received: from pierre123.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E76C3F70D;
        Fri, 12 Aug 2022 03:16:25 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH] sched/topology: Remove EM_MAX_COMPLEXITY limit
Date:   Fri, 12 Aug 2022 12:16:19 +0200
Message-Id: <20220812101620.627838-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
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

From: Pierre Gondois <Pierre.Gondois@arm.com>

The Energy Aware Scheduler (EAS) estimates the energy consumption
of placing a task on different CPUs. The goal is to minimize this
energy consumption. Estimating the energy of different task placements
is increasingly complex with the size of the platform. To avoid having
a slow wake-up path, EAS is only enabled if this complexity is low
enough.

The current complexity limit was set in:
commit b68a4c0dba3b1 ("sched/topology: Disable EAS on inappropriate
platforms").
base on the first implementation of EAS, which was re-computing
the power of the whole platform for each task placement scenario, cf:
commit 390031e4c309 ("sched/fair: Introduce an energy estimation helper
function").
but the complexity of EAS was reduced in:
commit eb92692b2544d ("sched/fair: Speed-up energy-aware wake-ups")
and find_energy_efficient_cpu() (feec) algorithm was updated in:
commit 3e8c6c9aac42 ("sched/fair: Remove task_util from effective
utilization in feec()")

find_energy_efficient_cpu() (feec) is now doing:
feec()
\_ for_each_pd(pd) [0]
  // get max_spare_cap_cpu and compute_prev_delta
  \_ for_each_cpu(pd) [1]

  \_ get_pd_busy_time(pd) [2]
    \_ for_each_cpu(pd)

  // evaluate pd energy without the task
  \_ get_pd_max_util(pd, -1) [3.0]
    \_ for_each_cpu(pd)
  \_ compute_energy(pd, -1)
    \_ for_each_ps(pd)

  // evaluate pd energy with the task on prev_cpu
  \_ get_pd_max_util(pd, prev_cpu) [3.1]
    \_ for_each_cpu(pd)
  \_ compute_energy(pd, prev_cpu)
    \_ for_each_ps(pd)

  // evaluate pd energy with the task on max_spare_cap_cpu
  \_ get_pd_max_util(pd, max_spare_cap_cpu) [3.2]
    \_ for_each_cpu(pd)
  \_ compute_energy(pd, max_spare_cap_cpu)
    \_ for_each_ps(pd)

[3.1] happens only once since prev_cpu is unique. To have an upper
bound of the complexity, [3.1] is taken into account for all pds.
So with the same definitions for nr_pd, nr_cpus and nr_ps,
the complexity is of:
nr_pd * (2 * [nr_cpus in pd] + 3 * ([nr_cpus in pd] + [nr_ps in pd]))
 [0]  * (     [1] + [2]      +       [3.0] + [3.1] + [3.2]          )
= 5 * nr_cpus + 3 * nr_ps

The complexity limit was set to 2048 in:
commit b68a4c0dba3b1 ("sched/topology: Disable EAS on inappropriate
platforms")
to make "EAS usable up to 16 CPUs with per-CPU DVFS and less than 8
performance states each". For the same platform, the complexity would
actually be of:
5 * 16 + 3 * 7 = 101

Since the EAS complexity was greatly reduced, bigger platforms can
handle EAS. For instance, a platform with 256 CPUs with 256
performance states each would reach it. To reflect this improvement,
remove the EAS complexity check.

Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
---
 Documentation/scheduler/sched-energy.rst | 37 ++--------------------
 kernel/sched/topology.c                  | 39 ++----------------------
 2 files changed, 6 insertions(+), 70 deletions(-)

diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index 8fbce5e767d9..3d1d71134d16 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -356,38 +356,7 @@ placement. For EAS it doesn't matter whether the EM power values are expressed
 in milli-Watts or in an 'abstract scale'.
 
 
-6.3 - Energy Model complexity
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The task wake-up path is very latency-sensitive. When the EM of a platform is
-too complex (too many CPUs, too many performance domains, too many performance
-states, ...), the cost of using it in the wake-up path can become prohibitive.
-The energy-aware wake-up algorithm has a complexity of:
-
-	C = Nd * (Nc + Ns)
-
-with: Nd the number of performance domains; Nc the number of CPUs; and Ns the
-total number of OPPs (ex: for two perf. domains with 4 OPPs each, Ns = 8).
-
-A complexity check is performed at the root domain level, when scheduling
-domains are built. EAS will not start on a root domain if its C happens to be
-higher than the completely arbitrary EM_MAX_COMPLEXITY threshold (2048 at the
-time of writing).
-
-If you really want to use EAS but the complexity of your platform's Energy
-Model is too high to be used with a single root domain, you're left with only
-two possible options:
-
-    1. split your system into separate, smaller, root domains using exclusive
-       cpusets and enable EAS locally on each of them. This option has the
-       benefit to work out of the box but the drawback of preventing load
-       balance between root domains, which can result in an unbalanced system
-       overall;
-    2. submit patches to reduce the complexity of the EAS wake-up algorithm,
-       hence enabling it to cope with larger EMs in reasonable time.
-
-
-6.4 - Schedutil governor
+6.3 - Schedutil governor
 ^^^^^^^^^^^^^^^^^^^^^^^^
 
 EAS tries to predict at which OPP will the CPUs be running in the close future
@@ -405,7 +374,7 @@ frequency requests and energy predictions.
 Using EAS with any other governor than schedutil is not supported.
 
 
-6.5 Scale-invariant utilization signals
+6.4 Scale-invariant utilization signals
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 In order to make accurate prediction across CPUs and for all performance
@@ -417,7 +386,7 @@ Using EAS on a platform that doesn't implement these two callbacks is not
 supported.
 
 
-6.6 Multithreading (SMT)
+6.5 Multithreading (SMT)
 ^^^^^^^^^^^^^^^^^^^^^^^^
 
 EAS in its current form is SMT unaware and is not able to leverage
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..ce2fa85b2362 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -346,32 +346,13 @@ static void sched_energy_set(bool has_eas)
  *    1. an Energy Model (EM) is available;
  *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
  *    3. no SMT is detected.
- *    4. the EM complexity is low enough to keep scheduling overheads low;
- *    5. schedutil is driving the frequency of all CPUs of the rd;
- *    6. frequency invariance support is present;
- *
- * The complexity of the Energy Model is defined as:
- *
- *              C = nr_pd * (nr_cpus + nr_ps)
- *
- * with parameters defined as:
- *  - nr_pd:    the number of performance domains
- *  - nr_cpus:  the number of CPUs
- *  - nr_ps:    the sum of the number of performance states of all performance
- *              domains (for example, on a system with 2 performance domains,
- *              with 10 performance states each, nr_ps = 2 * 10 = 20).
- *
- * It is generally not a good idea to use such a model in the wake-up path on
- * very complex platforms because of the associated scheduling overheads. The
- * arbitrary constraint below prevents that. It makes EAS usable up to 16 CPUs
- * with per-CPU DVFS and less than 8 performance states each, for example.
+ *    4. schedutil is driving the frequency of all CPUs of the rd;
+ *    5. frequency invariance support is present;
  */
-#define EM_MAX_COMPLEXITY 2048
-
 extern struct cpufreq_governor schedutil_gov;
 static bool build_perf_domains(const struct cpumask *cpu_map)
 {
-	int i, nr_pd = 0, nr_ps = 0, nr_cpus = cpumask_weight(cpu_map);
+	int i;
 	struct perf_domain *pd = NULL, *tmp;
 	int cpu = cpumask_first(cpu_map);
 	struct root_domain *rd = cpu_rq(cpu)->rd;
@@ -429,20 +410,6 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 			goto free;
 		tmp->next = pd;
 		pd = tmp;
-
-		/*
-		 * Count performance domains and performance states for the
-		 * complexity check.
-		 */
-		nr_pd++;
-		nr_ps += em_pd_nr_perf_states(pd->em_pd);
-	}
-
-	/* Bail out if the Energy Model complexity is too high. */
-	if (nr_pd * (nr_ps + nr_cpus) > EM_MAX_COMPLEXITY) {
-		WARN(1, "rd %*pbl: Failed to start EAS, EM complexity is too high\n",
-						cpumask_pr_args(cpu_map));
-		goto free;
 	}
 
 	perf_domain_debug(cpu_map, pd);
-- 
2.25.1

