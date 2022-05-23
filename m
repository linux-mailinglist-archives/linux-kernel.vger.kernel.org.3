Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C317531272
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiEWPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiEWPxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:53:11 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C15E403F5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:52:48 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id v124-20020a1cac82000000b003948b870a8dso10764841wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dVL5gjCgy3sq4Q5dk9TcMKWYTxrHdmNucgKBvsJek24=;
        b=BOrsiDkKxALDfSj2WNpuv5UPGYZgdAkk16vX9KGXvIW1K2WMewlMJRMqzBixXQ562b
         VYNaxeoEhROFQ/ydAmCPaZa17xTVOgwl7/E6tZfHcwpj69PTXpGq2fhpwyXJqGpkHe4z
         eOypQmsvGq5WLhnIptnSBOEp69TUIxM7TVYHYkYW18+MAlxt9RcfNK6eQxoB7SejyGgU
         dh1CDZHpWK3L3+u4ux6OkxqlwMkL66qpBi+yLmPCMyWzhH2o5QoCER9QnLk1vTHQLGWB
         juMdG2jnC/euQrHfDAmzVg5jF9oWc/EIdRVUxbQoSHqxeufIW0cK4Dd352iwBI+eaFUQ
         KvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dVL5gjCgy3sq4Q5dk9TcMKWYTxrHdmNucgKBvsJek24=;
        b=pZM7gN9jOlXv+vB2ccgVzu0nIFoA/zVRSTegeFaaY1tK2b+yYJqPgpdjugQesOFyFn
         CbVbYf8ZAaEFfdOgFRB/K2qr0HUVjJDL60qVJFGqDMOHQYdgBz7yGSxnDCkKwuBYZiTl
         B9g7EwSJcCVQ5d6LPh1lp6fRGCm7WYUnfgsWTaQ852iF9P9Xh/Nj6ZNytGKOGKzLoFbp
         r2P+QLyHNCgZH0KweeK0+aiFi7xRDpqFc8sLeyRKw1EckD7Tcu6vs08bVWNQZeRqisuF
         7XhXx/HpBEE6a4fjvvWFD3aFRsLUFiN86Hbr2GWB3xbP2MHxnQg+GjPE7HpMdg3d763A
         kwuw==
X-Gm-Message-State: AOAM531AQvCZsiBnZyiLHqcCORuQy+f4nJ2n8dY+wgF6M2fI0n4Z6ii7
        lSKF15mbuYvGX07j4qDLfVNupIU/ZTrGL134
X-Google-Smtp-Source: ABdhPJyR3TB+4hayhAcWaCKe/mCt7B4Zm6P7+7sMH42O3nHRlG34sIjBrhOkANX2qlPjWej/Mm23qjz52TWc2mlR
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:29d3:b0:397:4730:ee75 with
 SMTP id s19-20020a05600c29d300b003974730ee75mr7937400wmd.149.1653321166997;
 Mon, 23 May 2022 08:52:46 -0700 (PDT)
Date:   Mon, 23 May 2022 16:51:40 +0100
In-Reply-To: <20220523155140.2878563-1-vdonnefort@google.com>
Message-Id: <20220523155140.2878563-8-vdonnefort@google.com>
Mime-Version: 1.0
References: <20220523155140.2878563-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v9 7/7] sched/fair: Remove the energy margin in feec()
From:   Vincent Donnefort <vdonnefort@google.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        vdonnefort@google.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

find_energy_efficient_cpu() integrates a margin to protect tasks from
bouncing back and forth from a CPU to another. This margin is set as being
6% of the total current energy estimated on the system. This however does
not work for two reasons:

1. The energy estimation is not a good absolute value:

compute_energy() used in feec() is a good estimation for task placement as
it allows to compare the energy with and without a task. The computed
delta will give a good overview of the cost for a certain task placement.
It, however, doesn't work as an absolute estimation for the total energy
of the system. First it adds the contribution to idle CPUs into the
energy, second it mixes util_avg with util_est values. util_avg contains
the near history for a CPU usage, it doesn't tell at all what the current
utilization is. A system that has been quite busy in the near past will
hold a very high energy and then a high margin preventing any task
migration to a lower capacity CPU, wasting energy. It even creates a
negative feedback loop: by holding the tasks on a less efficient CPU, the
margin contributes in keeping the energy high.

2. The margin handicaps small tasks:

On a system where the workload is composed mostly of small tasks (which is
often the case on Android), the overall energy will be high enough to
create a margin none of those tasks can cross. On a Pixel4, a small
utilization of 5% on all the CPUs creates a global estimated energy of 140
joules, as per the Energy Model declaration of that same device. This
means, after applying the 6% margin that any migration must save more than
8 joules to happen. No task with a utilization lower than 40 would then be
able to migrate away from the biggest CPU of the system.

The 6% of the overall system energy was brought by the following patch:

 (eb92692b2544 sched/fair: Speed-up energy-aware wake-ups)

It was previously 6% of the prev_cpu energy. Also, the following one
made this margin value conditional on the clusters where the task fits:

 (8d4c97c105ca sched/fair: Only compute base_energy_pd if necessary)

We could simply revert that margin change to what it was, but the original
version didn't have strong grounds neither and as demonstrated in (1.) the
estimated energy isn't a good absolute value. Instead, removing it
completely. It is indeed, made possible by recent changes that improved
energy estimation comparison fairness (sched/fair: Remove task_util from
effective utilization in feec()) (PM: EM: Increase energy calculation
precision) and task utilization stabilization (sched/fair: Decay task
util_avg during migration)

Without a margin, we could have feared bouncing between CPUs. But running
LISA's eas_behaviour test coverage on three different platforms (Hikey960,
RB-5 and DB-845) showed no issue.

Removing the energy margin enables more energy-optimized placements for a
more energy efficient system.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5586b6848858..92907b384265 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6859,9 +6859,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
-	int cpu, best_energy_cpu = prev_cpu, target = -1;
 	struct root_domain *rd = this_rq()->rd;
-	unsigned long base_energy = 0;
+	int cpu, best_energy_cpu, target = -1;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 	struct energy_env eenv;
@@ -6893,8 +6892,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long cpu_cap, cpu_thermal_cap, util;
 		unsigned long cur_delta, max_spare_cap = 0;
 		bool compute_prev_delta = false;
-		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
+		unsigned long base_energy;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -6949,16 +6948,15 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		eenv_pd_busy_time(&eenv, cpus, p);
 		/* Compute the 'base' energy of the pd, without @p */
-		base_energy_pd = compute_energy(&eenv, pd, cpus, p, -1);
-		base_energy += base_energy_pd;
+		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
 		if (compute_prev_delta) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
-			if (prev_delta < base_energy_pd)
+			if (prev_delta < base_energy)
 				goto unlock;
-			prev_delta -= base_energy_pd;
+			prev_delta -= base_energy;
 			best_delta = min(best_delta, prev_delta);
 		}
 
@@ -6966,9 +6964,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		if (max_spare_cap_cpu >= 0) {
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
 						   max_spare_cap_cpu);
-			if (cur_delta < base_energy_pd)
+			if (cur_delta < base_energy)
 				goto unlock;
-			cur_delta -= base_energy_pd;
+			cur_delta -= base_energy;
 			if (cur_delta < best_delta) {
 				best_delta = cur_delta;
 				best_energy_cpu = max_spare_cap_cpu;
@@ -6977,12 +6975,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	}
 	rcu_read_unlock();
 
-	/*
-	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
-	 * least 6% of the energy used by prev_cpu.
-	 */
-	if ((prev_delta == ULONG_MAX) ||
-	    (prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
+	if (best_delta < prev_delta)
 		target = best_energy_cpu;
 
 	return target;
-- 
2.36.1.124.g0e6072fb45-goog

