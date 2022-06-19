Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F03550A83
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbiFSMFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbiFSMFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:05:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253A112607
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:44 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h192so7924748pgc.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xwlBWSQuxl+FhVvQ4gobOYGB99x/l1ra5rO9buXVpCw=;
        b=1mwzmDW2C0eF233nKRV8mYA+aqPNp4meuektnsm0Q8hI9zDirszomkmEZI7/SfnIpu
         V0cfDFFtYS7DGIvcCTsHMSBwEP6hUzr2ZA3r9DirW8+u6j9yw1uAe76megXADfDOzGyx
         UGB/eoUG2/VQx2PBloVgVTSaDe6HFItqeMMJr/NTKZHk/V1HIXP8KvANggCJamY8amqC
         7a9nFTZI/uJBNP3ngUeuHJEkyY4EcQfZRXKFFDdsAI2rKs+dVoqV1rmuFRP4RilfRs4i
         rkV2Y/I+Dbl8CBdjdGWy3yzaJv7rWREOYQ2u39UrWVYbbvxNWl+GabJmpiKI9/RCaJit
         ESoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xwlBWSQuxl+FhVvQ4gobOYGB99x/l1ra5rO9buXVpCw=;
        b=Y565tzfV9V8fVSzBTS1XX9np6MwbOajEK7HZyOYlkpSt47Vh1AcIald9EkCMATQbez
         vPRf/NSIFkZj6zsMa08WJV5UKZ685cMmZ9Ahju2VFqntpXQk6HdPm/KPncbph1ei5Bmv
         Btc1BmS/m2/SMb2XQkn+4XW+kKQL3NrhlMDqJbXXpzJ4aj+bEGGQD6Qt9Gr+9fXXCPfw
         tkLb2v9IWj1SlMF7ccXCSs47N+edknR+JtgCZd1mznwFit4zrLQ2dieLX6s42RAHQhLE
         NNTRc3+fn+2eI/PHKTksXWxxPBD1xi69CWV8AvVTuzH4fLoWkUQ9kmUrBOy7EK6rPvVS
         eRZQ==
X-Gm-Message-State: AJIora+mi5Nbnf2hVxymAoYuiXTa4lXsoavZHFLVHy8y2AbzwLlEFE+l
        1XW/0bUuBlr4V615vet6VQFZvg==
X-Google-Smtp-Source: AGRyM1tT8jEf9/hVotTDL1q8EIE5/jtAaxu+sEjO0EVGfd4UmZwBFvjggDSCB8VY8mvxW7JstLwgiA==
X-Received: by 2002:a05:6a00:198e:b0:51c:3511:4aff with SMTP id d14-20020a056a00198e00b0051c35114affmr19453365pfl.20.1655640343475;
        Sun, 19 Jun 2022 05:05:43 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb1d5sm1594038plb.31.2022.06.19.05.05.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2022 05:05:43 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 6/7] sched/fair: skip busy cores in SIS search
Date:   Sun, 19 Jun 2022 20:04:50 +0800
Message-Id: <20220619120451.95251-7-wuyun.abel@bytedance.com>
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

Try to improve efficiency of SIS domain search by filtering out busy
cores, and as a result the more overloaded the system is, the less
cpus will be scanned.

The filter is supposed to contain unoccupied cpus of the LLC. And we
propagate these cpus to the filter one at a time at core granule.
This can help spreading load to different cores given that the search
depth is limited. The chosen cpu to be propagated is guaranteed to be
unoccupied at that time.

When idle cpu exists, the last one is preferred in order not to
conflict with periodic load balancing during which the first idle
cpu (if any) is chosen to be fed with tasks.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/topology.h | 20 ++++++++
 kernel/sched/fair.c            | 90 +++++++++++++++++++++++++++++++---
 kernel/sched/topology.c        | 12 ++++-
 3 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 3e99ac98d766..b93edf587d84 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -103,6 +103,10 @@ struct sched_group;
  * load balancing on each SMT domain inside the LLC, the state will be
  * re-evaluated and switch from sd_is_busy to sd_has_icpus if idle cpus
  * exist.
+ *
+ * For SMT domains, the state is updated during load balancing at SMT
+ * level. Upper levels are ignored due to the long intervals that make
+ * information out-of-date quickly.
  */
 enum sd_state {
 	sd_has_icores,
@@ -113,7 +117,18 @@ enum sd_state {
 struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
+
+	int		updating;
 	int		state;	/* see enum sd_state */
+
+	/*
+	 * Record unoccupied cpus for SIS domain search.
+	 *
+	 * NOTE: this field is variable length. (Allocated dynamically
+	 * by attaching extra space to the end of the structure,
+	 * depending on how many CPUs the kernel has booted up with)
+	 */
+	unsigned long   idle_cpus[];
 };
 
 struct sched_domain {
@@ -199,6 +214,11 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+static inline struct cpumask *sched_domain_icpus(struct sched_domain_shared *sds)
+{
+	return to_cpumask(sds->idle_cpus);
+}
+
 extern void partition_sched_domains_locked(int ndoms_new,
 					   cpumask_var_t doms_new[],
 					   struct sched_domain_attr *dattr_new);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ca37fdc6c4d..d55fdcedf2c0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6241,6 +6241,28 @@ static inline bool test_idle_cpus(int cpu)
 	return sd_get_state(cpu) != sd_is_busy;
 }
 
+static void sd_update_icpus(int core, int icpu)
+{
+	struct sched_domain_shared *sds;
+	struct cpumask *icpus;
+
+	sds = rcu_dereference(per_cpu(sd_llc_shared, core));
+	if (!sds)
+		return;
+
+	icpus = sched_domain_icpus(sds);
+
+	/*
+	 * XXX: The update is racy between different cores.
+	 * The non-atomic ops here is a tradeoff of accuracy
+	 * for easing the cache traffic.
+	 */
+	if (icpu == -1)
+		cpumask_andnot(icpus, icpus, cpu_smt_mask(core));
+	else if (!cpumask_test_cpu(icpu, icpus))
+		__cpumask_set_cpu(icpu, icpus);
+}
+
 /*
  * Scans the local SMT mask to see if the entire core is idle, and records this
  * information in sd_llc_shared->has_idle_cores.
@@ -6340,6 +6362,10 @@ static inline bool test_idle_cpus(int cpu)
 	return true;
 }
 
+static inline void sd_update_icpus(int core, int icpu)
+{
+}
+
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	return __select_idle_cpu(core, p);
@@ -6370,7 +6396,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	if (!this_sd)
 		return -1;
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	cpumask_and(cpus, has_idle_core ? sched_domain_span(sd) :
+		    sched_domain_icpus(sd->shared), p->cpus_ptr);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
@@ -8342,6 +8369,7 @@ struct sd_lb_stats {
 	unsigned int prefer_sibling; /* tasks should go to sibling first */
 
 	int sd_state;
+	int idle_cpu;
 
 	struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
 	struct sg_lb_stats local_stat;	/* Statistics of the local group */
@@ -8362,6 +8390,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 		.total_load = 0UL,
 		.total_capacity = 0UL,
 		.sd_state = sd_is_busy,
+		.idle_cpu = -1,
 		.busiest_stat = {
 			.idle_cpus = UINT_MAX,
 			.group_type = group_has_spare,
@@ -8702,10 +8731,18 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
 	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
 }
 
-static inline void sd_classify(struct sd_lb_stats *sds, struct rq *rq)
+static inline void sd_classify(struct sd_lb_stats *sds, struct rq *rq, int cpu)
 {
-	if (sds->sd_state != sd_has_icpus && unoccupied_rq(rq))
+	if (sds->sd_state != sd_has_icpus && unoccupied_rq(rq)) {
+		/*
+		 * Prefer idle cpus than unoccupied ones. This
+		 * is achieved by only allowing the idle ones
+		 * unconditionally overwrite the preious record
+		 * while the occupied ones can't.
+		 */
+		sds->idle_cpu = cpu;
 		sds->sd_state = sd_has_icpus;
+	}
 }
 
 /**
@@ -8741,7 +8778,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->sum_nr_running += nr_running;
 
 		if (update_core)
-			sd_classify(sds, rq);
+			sd_classify(sds, rq, i);
 
 		if (nr_running > 1)
 			*sg_status |= SG_OVERLOAD;
@@ -8757,7 +8794,16 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		 * No need to call idle_cpu() if nr_running is not 0
 		 */
 		if (!nr_running && idle_cpu(i)) {
+			/*
+			 * Prefer the last idle cpu by overwriting
+			 * preious one. The first idle cpu in this
+			 * domain (if any) can trigger balancing
+			 * and fed with tasks, so we'd better choose
+			 * a candidate in an opposite way.
+			 */
+			sds->idle_cpu = i;
 			sgs->idle_cpus++;
+
 			/* Idle cpu can't have misfit task */
 			continue;
 		}
@@ -9273,8 +9319,40 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 
 static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
 {
-	if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
-		set_idle_cpus(env->dst_cpu, true);
+	struct sched_domain_shared *sd_smt_shared = env->sd->shared;
+	enum sd_state new = sds->sd_state;
+	int this = env->dst_cpu;
+
+	/*
+	 * Parallel updating can hardly contribute accuracy to
+	 * the filter, besides it can be one of the burdens on
+	 * cache traffic.
+	 */
+	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
+		return;
+
+	/*
+	 * There is at least one unoccupied cpu available, so
+	 * propagate it to the filter to avoid false negative
+	 * issue which could result in lost tracking of some
+	 * idle cpus thus throughupt downgraded.
+	 */
+	if (new != sd_is_busy) {
+		if (!test_idle_cpus(this))
+			set_idle_cpus(this, true);
+	} else {
+		/*
+		 * Nothing changes so nothing to update or
+		 * propagate.
+		 */
+		if (sd_smt_shared->state == sd_is_busy)
+			goto out;
+	}
+
+	sd_update_icpus(this, sds->idle_cpu);
+	sd_smt_shared->state = new;
+out:
+	xchg(&sd_smt_shared->updating, 0);
 }
 
 /**
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..d3cd7cf5a136 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1641,6 +1641,16 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+
+		/*
+		 * Initialize SMT domains to be busy, so that we don't
+		 * need to propagate idle cpus to LLC domains which are
+		 * default to fully busy (no cpus set). This will be
+		 * updated in the first load balancing on SMT domains
+		 * if necessary.
+		 */
+		if (sd->flags & SD_SHARE_CPUCAPACITY)
+			WRITE_ONCE(sd->shared->state, sd_is_busy);
 	}
 
 	sd->private = sdd;
@@ -2106,7 +2116,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;
-- 
2.31.1

