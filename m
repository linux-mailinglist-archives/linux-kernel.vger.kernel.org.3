Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B2353FEFC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243854AbiFGMhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbiFGMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:36:46 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FD1F8E45
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:36:35 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id j31-20020a05600c1c1f00b0039c481c4664so1643831wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5oLMmecAB4JpTaTHQDIdvvJjgDzGdlEK5hcMT3Wizqc=;
        b=VGGsUjEWSv2g7R21YreqKsmCoLWPymyGs92DWaEY67GG1BkH1hY5FAYGrDKliXF2F3
         HFgWN2TDWnvUVf21hWFRB1HpQ69qs3zulM0b0VnRJks4R8CprosDf8ppcaOte/V3qTsS
         Ihq/VQhWDqaXt3O4PAxw0cst3KZ7njPFB1WSkTjjRycDb9I+2HDNAnSW0THjv5t5wbKA
         fh8YsIZDYuK+A6jHlMQMOXJQ4MVrhQNsi5rVvw+2FSG8Ap8iUQEHHdZhUGKftp3GAMbk
         LbRYW7f2vfycEQS3MVKRM4c2qvqIahaAckpouuRjKMnXB878U0BiQ/iLaszS99P/+ih9
         pS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5oLMmecAB4JpTaTHQDIdvvJjgDzGdlEK5hcMT3Wizqc=;
        b=cP0A/ekcfh2upmkVqMkeoF6vf9ER0YRVm9ZU7DIyHElCIfyWs4rncMPO8+uN+41AT8
         daYVXCU7VN629vjGd948pt84APvHrwz+69Td3CfMyvjiiuxNEsA3BTBX9mFe6zG+DbNs
         j/1u2Bf97V9kvmDBPRn/tAKajstfMIjmt2I1bpignhV7O0lUrGBc6ay3xmm80vxlznyg
         +XU280FgcLdeXa+EV0GPllHj6SYP+joCJde/h9CYYalRsGR6YgtkwE4vnAExMFYnilcI
         9mk9lNvuVYyHkJkyOAy5fIMLeXtgZdl8gKUB7CryKzOIMt/67MOl+hfSW6fiPo7PIi2n
         ictw==
X-Gm-Message-State: AOAM533ZfgSvyssvWsYb95gLFiMXVKRa4LYzt7Y9C2BPTafezcJ7OFd2
        xE15KRpSs2VcivPa4ZMOA/yijTkXfdMYKyY7
X-Google-Smtp-Source: ABdhPJwysF4QBlODtChLq5dY4NILC6Q7Fp7kctFcNLOAJlOd4P6bNhUXuSbv/BTxbXnYSpC3nWf2Q9rUQYrnNOi/
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:f403:0:b0:218:82e:4c9e with SMTP id
 g3-20020adff403000000b00218082e4c9emr11975373wro.247.1654605394002; Tue, 07
 Jun 2022 05:36:34 -0700 (PDT)
Date:   Tue,  7 Jun 2022 13:32:54 +0100
In-Reply-To: <20220607123254.565579-1-vdonnefort@google.com>
Message-Id: <20220607123254.565579-8-vdonnefort@google.com>
Mime-Version: 1.0
References: <20220607123254.565579-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v10 7/7] sched/fair: Remove the energy margin in feec()
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
index 780aee03b3cc..b8541a9c30c3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6860,9 +6860,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -6894,8 +6893,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long cpu_cap, cpu_thermal_cap, util;
 		unsigned long cur_delta, max_spare_cap = 0;
 		bool compute_prev_delta = false;
-		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
+		unsigned long base_energy;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -6953,17 +6952,16 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		eenv_pd_busy_time(&eenv, cpus, p);
 		/* Compute the 'base' energy of the pd, without @p */
-		base_energy_pd = compute_energy(&eenv, pd, cpus, p, -1);
-		base_energy += base_energy_pd;
+		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
 		if (compute_prev_delta) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
-			if (prev_delta < base_energy_pd)
+			if (prev_delta < base_energy)
 				goto unlock;
-			prev_delta -= base_energy_pd;
+			prev_delta -= base_energy;
 			best_delta = min(best_delta, prev_delta);
 		}
 
@@ -6972,9 +6970,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
 						   max_spare_cap_cpu);
 			/* CPU utilization has changed */
-			if (cur_delta < base_energy_pd)
+			if (cur_delta < base_energy)
 				goto unlock;
-			cur_delta -= base_energy_pd;
+			cur_delta -= base_energy;
 			if (cur_delta < best_delta) {
 				best_delta = cur_delta;
 				best_energy_cpu = max_spare_cap_cpu;
@@ -6983,12 +6981,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
2.36.1.255.ge46751e96f-goog

