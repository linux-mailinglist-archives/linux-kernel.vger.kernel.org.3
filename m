Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6FD57B52F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbiGTLQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiGTLPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:15:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53EA45F4B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YCB0bLN5g411xZI4SYSRceTxRwPE7yPTmCMnKxOvqf0=; b=KA5jg15jz9kSd9FyBP2jur0O00
        Gs+5/zChUUP8+w45n0fKp/D4rM0KWUz5vVPANAkq9FhSKd/RMNNMvhyly7TQLSR9VfEMBGjTHkSZP
        RzmyUA8naOImpkNzgNb115svVjDkfJBH9WvUA9vm7Jz7H1gvNBDCgYdP1IO56RPDTfbgey6KU4R3w
        ZTVd1SWKjnXLL05ypwUXzdiO5xF7N+r6Yk0NeCsg/Rq00nf/h0msbE55F/oCqIejvznsFr8CUnTTM
        exEtm5Y/kCJVAROy4BYRhH8aSqoQIIown9peKFnXN3NYsXx1L0gMUuWtqyaL0/VTwL0ThUvnWfB94
        k2IurtHQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oE7fR-005JLN-2p; Wed, 20 Jul 2022 11:15:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BBDE980BBE; Wed, 20 Jul 2022 13:14:59 +0200 (CEST)
Date:   Wed, 20 Jul 2022 13:14:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tim.c.chen@linux.intel.com,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        prime.zeng@huawei.com, jonathan.cameron@huawei.com,
        ego@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxarm@huawei.com, 21cnbao@gmail.com, guodong.xu@linaro.org,
        hesham.almatary@huawei.com, john.garry@huawei.com,
        shenyang39@huawei.com, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        wuyun.abel@bytedance.com
Subject: Re: [RESEND PATCH v5 2/2] sched/fair: Scan cluster before scanning
 LLC in wake-up path
Message-ID: <Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net>
References: <20220720081150.22167-1-yangyicong@hisilicon.com>
 <20220720081150.22167-3-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720081150.22167-3-yangyicong@hisilicon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 04:11:50PM +0800, Yicong Yang wrote:
> +	/* TODO: Support SMT system with cluster topology */
> +	if (!sched_smt_active() && sd) {
> +		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {

So that's no SMT and no wrap iteration..

Does something like this work?

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6437,6 +6437,30 @@ static int select_idle_cpu(struct task_s
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_SCHED_CLUSTER) &&
+	    static_branch_unlikely(&sched_cluster_active)) {
+		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
+		if (sdc) {
+			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
+				if (!cpumask_test_cpu(cpu, cpus))
+					continue;
+
+				if (has_idle_core) {
+					i = select_idle_core(p, cpu, cpus, &idle_cpu);
+					if ((unsigned int)i < nr_cpumask_bits)
+						return i;
+				} else {
+					if (--nr <= 0)
+						return -1;
+					idle_cpu = __select_idle_cpu(cpu, p);
+					if ((unsigned int)idle_cpu < nr_cpumask_bits)
+						break;
+				}
+			}
+			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
+		}
+	}
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -6444,7 +6468,7 @@ static int select_idle_cpu(struct task_s
 				return i;
 
 		} else {
-			if (!--nr)
+			if (--nr <= 0)
 				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
@@ -6543,7 +6567,7 @@ static int select_idle_sibling(struct ta
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) &&
+	if (prev != target && cpus_share_lowest_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
 	    asym_fits_capacity(task_util, prev))
 		return prev;
@@ -6569,7 +6593,7 @@ static int select_idle_sibling(struct ta
 	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
-	    cpus_share_cache(recent_used_cpu, target) &&
+	    cpus_share_lowest_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_capacity(task_util, recent_used_cpu)) {
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1813,7 +1813,9 @@ DECLARE_PER_CPU(struct sched_domain __rc
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
+
 extern struct static_key_false sched_asym_cpucapacity;
+extern struct static_key_false sched_cluster_active;
 
 struct sched_group_capacity {
 	atomic_t		ref;
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -670,7 +670,9 @@ DEFINE_PER_CPU(struct sched_domain_share
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
+
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
+DEFINE_STATIC_KEY_FALSE(sched_cluster_active);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -2268,6 +2270,7 @@ build_sched_domains(const struct cpumask
 	struct rq *rq = NULL;
 	int i, ret = -ENOMEM;
 	bool has_asym = false;
+	bool has_cluster = false;
 
 	if (WARN_ON(cpumask_empty(cpu_map)))
 		goto error;
@@ -2289,6 +2292,7 @@ build_sched_domains(const struct cpumask
 			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
 
 			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
+			has_cluster |= sd->flags & SD_CLUSTER;
 
 			if (tl == sched_domain_topology)
 				*per_cpu_ptr(d.sd, i) = sd;
@@ -2399,6 +2403,9 @@ build_sched_domains(const struct cpumask
 	if (has_asym)
 		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
 
+	if (has_cluster)
+		static_branch_inc_cpuslocked(&sched_cluster_active);
+
 	if (rq && sched_debug_verbose) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
@@ -2498,6 +2505,9 @@ static void detach_destroy_domains(const
 	if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, cpu)))
 		static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
 
+	if (rcu_access_pointer(per_cpu(sd_cluster, cpu)))
+		static_branch_dec_cpuslocked(&sched_cluster_active);
+
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map)
 		cpu_attach_domain(NULL, &def_root_domain, i);
