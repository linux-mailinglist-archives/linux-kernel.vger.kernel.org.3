Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C29E550A7F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiFSMFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237039AbiFSMFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:05:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E488610551
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m4so4616155pjv.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E6upA7dQmARbFr+KAXUGeDIU63hapFBrLDcIks9rJ7Y=;
        b=nLRlF2MddbWgWuSkPGPzAQOAeY+1srrVanyO9U7c6TBwjER317rFWwROhjeGFsNfKk
         TprPlwwqApJ3V5D2g7tvstV5qph66QfGbs0U9Nf6SBYKlU0c46sz4DKhuLWTk+nCkfue
         nzQJxWpVJIguQBylABxpyjdtggHYzNEvnbjuFhZ1zllZf9ay/tazxf48Y+JNdIPcQL96
         Y1g5G1sASCwkok1f2zFxGPLhGG7+f/irhMIHo0aQoWnku4wkXBchl7RYzLYm5Y+ywVV0
         6mYDX556xuUhah6lFhvUpBiNY93Vja7Fgz6H5/zuvYnYk0HWSM68Vi/gw1SDzCcEKkVO
         YyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6upA7dQmARbFr+KAXUGeDIU63hapFBrLDcIks9rJ7Y=;
        b=EvZe0OK+ObfUvCzgdqPvNIgNuAyjGDw4WMocneuQd564BF/L48Zj0XBgteO64z7DAu
         PEaP6C/fis6hdzW7acGD1cyEyTSHR87GGzUvZh0INEBxvz7BTOZT76G4b2v0T5xhL5e0
         o6KBpGlsv5iKuIBhVRWULb3nRgipciSS6oMbzvX7tJy4vzpbeqkALd9xyLn7p0h+sIAk
         FqNtOH3F85alKB9vZfACRoID++vLsFWZNvW7QYuw5UkkYG2i9E7mmtNUpH3Nx1wPPuYE
         Fajhg4MTh1f977Y4cToH9BSdH94mL/moGiMMDFwpDSH/Infgn9/RyMZYPyL/3QMm4Qvk
         rV1g==
X-Gm-Message-State: AJIora8Aep+lDvQ69mPEiK595pb31i6uIFtjuIamP+r96As3gPT0PHdo
        X8HrCx8uMFuvH7GIvrf6hRYhxg==
X-Google-Smtp-Source: AGRyM1saBjTZzEdInDmhVPL0g7JeW0AeljVLTSeDkdSq0eI2ldbbX0dCzK8gAvQ5Lq4/2jx4uS19lQ==
X-Received: by 2002:a17:90b:1b07:b0:1e8:41d8:fa2 with SMTP id nu7-20020a17090b1b0700b001e841d80fa2mr20945705pjb.204.1655640339369;
        Sun, 19 Jun 2022 05:05:39 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb1d5sm1594038plb.31.2022.06.19.05.05.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2022 05:05:39 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 5/7] sched/fair: skip SIS domain search if fully busy
Date:   Sun, 19 Jun 2022 20:04:49 +0800
Message-Id: <20220619120451.95251-6-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220619120451.95251-1-wuyun.abel@bytedance.com>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a full scan on SIS domain failed, then no unoccupied cpus available
and the LLC is fully busy. In this case we'd better spend the time on
something more useful, rather than wasting it trying to find an idle
cpu that probably not exist.

The fully busy status will be re-evaluated when any core of this LLC
domain enters load balancing, and cleared once idle cpus found.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/topology.h | 35 ++++++++++++++-
 kernel/sched/fair.c            | 82 +++++++++++++++++++++++++++++-----
 2 files changed, 104 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 56cffe42abbc..3e99ac98d766 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -77,10 +77,43 @@ extern int sched_domain_level_max;
 
 struct sched_group;
 
+/*
+ * States of the sched-domain
+ *
+ * - sd_has_icores
+ *	This state is only used in LLC domains to indicate worthy
+ *	of a full scan in SIS due to idle cores available.
+ *
+ * - sd_has_icpus
+ *	This state indicates that unoccupied (sched-idle/idle) cpus
+ *	might exist in this domain. For the LLC domains it is the
+ *	default state since these cpus are the main targets of SIS
+ *	search, and is also used as a fallback state of the other
+ *	states.
+ *
+ * - sd_is_busy
+ *	This state indicates there are no unoccupied cpus in this
+ *	domain. So for LLC domains, it gives the hint on whether
+ *	we should put efforts on the SIS search or not.
+ *
+ * For LLC domains, sd_has_icores is set when the last non-idle cpu of
+ * a core becomes idle. After a full SIS scan and if no idle cores found,
+ * sd_has_icores must be cleared and the state will be set to sd_has_icpus
+ * or sd_is_busy depending on whether there is any idle cpu. And during
+ * load balancing on each SMT domain inside the LLC, the state will be
+ * re-evaluated and switch from sd_is_busy to sd_has_icpus if idle cpus
+ * exist.
+ */
+enum sd_state {
+	sd_has_icores,
+	sd_has_icpus,
+	sd_is_busy
+};
+
 struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
-	int		has_idle_cores;
+	int		state;	/* see enum sd_state */
 };
 
 struct sched_domain {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1cc86e76e38e..2ca37fdc6c4d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5642,11 +5642,15 @@ static inline void update_overutilized_status(struct rq *rq)
 static inline void update_overutilized_status(struct rq *rq) { }
 #endif
 
+static int unoccupied_rq(struct rq *rq)
+{
+	return rq->nr_running == rq->cfs.idle_h_nr_running;
+}
+
 /* Runqueue only has SCHED_IDLE tasks enqueued */
 static int sched_idle_rq(struct rq *rq)
 {
-	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
-			rq->nr_running);
+	return unlikely(rq->nr_running && unoccupied_rq(rq));
 }
 
 /*
@@ -6197,24 +6201,44 @@ static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
 
-static inline void set_idle_cores(int cpu, int val)
+static inline void sd_set_state(int cpu, enum sd_state state)
 {
 	struct sched_domain_shared *sds;
 
 	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
 	if (sds)
-		WRITE_ONCE(sds->has_idle_cores, val);
+		WRITE_ONCE(sds->state, state);
 }
 
-static inline bool test_idle_cores(int cpu)
+static inline enum sd_state sd_get_state(int cpu)
 {
 	struct sched_domain_shared *sds;
 
 	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
 	if (sds)
-		return READ_ONCE(sds->has_idle_cores);
+		return READ_ONCE(sds->state);
 
-	return false;
+	return sd_has_icpus;
+}
+
+static inline void set_idle_cores(int cpu, int idle)
+{
+	sd_set_state(cpu, idle ? sd_has_icores : sd_has_icpus);
+}
+
+static inline bool test_idle_cores(int cpu)
+{
+	return sd_get_state(cpu) == sd_has_icores;
+}
+
+static inline void set_idle_cpus(int cpu, int idle)
+{
+	sd_set_state(cpu, idle ? sd_has_icpus : sd_is_busy);
+}
+
+static inline bool test_idle_cpus(int cpu)
+{
+	return sd_get_state(cpu) != sd_is_busy;
 }
 
 /*
@@ -6298,7 +6322,7 @@ static int select_idle_smt(struct task_struct *p, int target)
 
 #else /* CONFIG_SCHED_SMT */
 
-static inline void set_idle_cores(int cpu, int val)
+static inline void set_idle_cores(int cpu, int idle)
 {
 }
 
@@ -6307,6 +6331,15 @@ static inline bool test_idle_cores(int cpu)
 	return false;
 }
 
+static inline void set_idle_cpus(int cpu, int idle)
+{
+}
+
+static inline bool test_idle_cpus(int cpu)
+{
+	return true;
+}
+
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	return __select_idle_cpu(core, p);
@@ -6382,7 +6415,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
-	if (has_idle_core)
+	if (idle_cpu == -1)
+		set_idle_cpus(target, false);
+	else if (has_idle_core)
 		set_idle_cores(target, false);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
@@ -6538,6 +6573,9 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
+
+		if (!has_idle_core && !test_idle_cpus(target))
+			return target;
 	}
 
 	i = select_idle_cpu(p, sd, has_idle_core, target);
@@ -8303,6 +8341,8 @@ struct sd_lb_stats {
 	unsigned long avg_load;	/* Average load across all groups in sd */
 	unsigned int prefer_sibling; /* tasks should go to sibling first */
 
+	int sd_state;
+
 	struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
 	struct sg_lb_stats local_stat;	/* Statistics of the local group */
 };
@@ -8321,6 +8361,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 		.local = NULL,
 		.total_load = 0UL,
 		.total_capacity = 0UL,
+		.sd_state = sd_is_busy,
 		.busiest_stat = {
 			.idle_cpus = UINT_MAX,
 			.group_type = group_has_spare,
@@ -8661,6 +8702,12 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
 	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
 }
 
+static inline void sd_classify(struct sd_lb_stats *sds, struct rq *rq)
+{
+	if (sds->sd_state != sd_has_icpus && unoccupied_rq(rq))
+		sds->sd_state = sd_has_icpus;
+}
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -8675,11 +8722,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
 {
-	int i, nr_running, local_group;
+	int i, nr_running, local_group, update_core;
 
 	memset(sgs, 0, sizeof(*sgs));
 
 	local_group = group == sds->local;
+	update_core = env->sd->flags & SD_SHARE_CPUCAPACITY;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
@@ -8692,6 +8740,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
 
+		if (update_core)
+			sd_classify(sds, rq);
+
 		if (nr_running > 1)
 			*sg_status |= SG_OVERLOAD;
 
@@ -9220,6 +9271,12 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 	return idlest;
 }
 
+static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
+{
+	if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
+		set_idle_cpus(env->dst_cpu, true);
+}
+
 /**
  * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
  * @env: The load balancing environment.
@@ -9270,8 +9327,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	/* Tag domain that child domain prefers tasks go to siblings first */
 	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
 
-
-	if (env->sd->flags & SD_NUMA)
+	if (env->sd->flags & SD_SHARE_CPUCAPACITY)
+		sd_update_state(env, sds);
+	else if (env->sd->flags & SD_NUMA)
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
 
 	if (!env->sd->parent) {
-- 
2.31.1

