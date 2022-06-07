Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2256253FEF8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbiFGMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243932AbiFGMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:36:46 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4892F748D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:36:31 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id j31-20020a05600c1c1f00b0039c481c4664so1643758wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nvUNUSsfDcrJkRdCH0vHPCOdzRcLBCI7rHMSciyZaNA=;
        b=NvThgSuko/eVQz6yt1/15Drzh2a0WHrph/66GW5ujTe8OebNv+hPxQ0fdiYgV3vue4
         JdQZuhtMkSpshe+g4YMLczjLWMjH6jUa4t2rbyl6fgVCrtPk02K+X26yX2+m1JJtcP8D
         xCqvwRoJckXNymIU3ExjseUODbVvRESGLqj5tLF7leDY/17LGWuGyuF92grtMfKqI8wU
         oSL67w6fhNxO7BiB0UpUs5d/NccgpZeaxfnE9fMREOnC+JUz/r8ZacNkfji8TUynGtIa
         yHa9jVzdnJUvBt02D7qeNnoTCk6+DaspVdcwKc4M2jWUKTs+Xs1qyb0m0jRWSZKrwLmI
         oGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nvUNUSsfDcrJkRdCH0vHPCOdzRcLBCI7rHMSciyZaNA=;
        b=wVYVWyYvBCPov9omd9fWGjfA71Oul7p2NEMWeRZeUmW505ltVV7ZQ+RMnTVcfBmpRG
         Y3yor6UKYrRtNJLGMmKGoGFrQ9q54BF2xirwU7RJYCOsXUSGbhIFShZzJbh47UZ7e49U
         jElOW6wzoa4MZQOyIAUCjlkyz///gey4sfIOxPcQ8qWanepBi3oPrKH9BIpgA4BEJEgy
         K0DL9Wkg7ZwVL8kClKQWVYZJAdo4JQmRQbKcKoDEIgU+0c9fk6Ti7xQzI37VDwe6mRwf
         3ecrGkYEV/dm23R6Evvl16+/CbIJtxT28UCtrdpZFiQiJ/Caft3i0Cng2DcuqV6xY3yR
         lP3A==
X-Gm-Message-State: AOAM532OUEiFMxQKbyKIljf2cq6bQBayg/lrg+m8lKCzBMSAbE+aCcTm
        sL893ailY//pLpukkgEmkRlcS1iTcQWR7J3i
X-Google-Smtp-Source: ABdhPJzFmdk8/egt+rlpl8iSxIMnvpBH6dE/g2fcTu7RYieLrKyiSrSjFERv8PwtSGc9yj6WR3are68XP6tnzrRY
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:2312:b0:397:7647:2ac4 with
 SMTP id 18-20020a05600c231200b0039776472ac4mr28210511wmo.125.1654605389667;
 Tue, 07 Jun 2022 05:36:29 -0700 (PDT)
Date:   Tue,  7 Jun 2022 13:32:52 +0100
In-Reply-To: <20220607123254.565579-1-vdonnefort@google.com>
Message-Id: <20220607123254.565579-6-vdonnefort@google.com>
Mime-Version: 1.0
References: <20220607123254.565579-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v10 5/7] sched/fair: Use the same cpumask per-PD throughout find_energy_efficient_cpu()
From:   Vincent Donnefort <vdonnefort@google.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        vdonnefort@google.com
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

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

The Perf Domain (PD) cpumask (struct em_perf_domain.cpus) stays
invariant after Energy Model creation, i.e. it is not updated after
CPU hotplug operations.

That's why the PD mask is used in conjunction with the cpu_online_mask
(or Sched Domain cpumask). Thereby the cpu_online_mask is fetched
multiple times (in compute_energy()) during a run-queue selection
for a task.

cpu_online_mask may change during this time which can lead to wrong
energy calculations.

To be able to avoid this, use the select_rq_mask per-cpu cpumask to
create a cpumask out of PD cpumask and cpu_online_mask and pass it
through the function calls of the EAS run-queue selection path.

The PD cpumask for max_spare_cap_cpu/compute_prev_delta selection
(find_energy_efficient_cpu()) is now ANDed not only with the SD mask
but also with the cpu_online_mask. This is fine since this cpumask
has to be in syc with the one used for energy computation
(compute_energy()).
An exclusive cpuset setup with at least one asymmetric CPU capacity
island (hence the additional AND with the SD cpumask) is the obvious
exception here.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bb5311cc5a44..08e604ddf520 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6701,14 +6701,14 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
  * task.
  */
 static long
-compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
+compute_energy(struct task_struct *p, int dst_cpu, struct cpumask *cpus,
+	       struct perf_domain *pd)
 {
-	struct cpumask *pd_mask = perf_domain_span(pd);
 	unsigned long max_util = 0, sum_util = 0, cpu_cap;
 	int cpu;
 
-	cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
-	cpu_cap -= arch_scale_thermal_pressure(cpumask_first(pd_mask));
+	cpu_cap = arch_scale_cpu_capacity(cpumask_first(cpus));
+	cpu_cap -= arch_scale_thermal_pressure(cpumask_first(cpus));
 
 	/*
 	 * The capacity state of CPUs of the current rd can be driven by CPUs
@@ -6719,7 +6719,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 	 * If an entire pd is outside of the current rd, it will not appear in
 	 * its pd list and will not be accounted by compute_energy().
 	 */
-	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
+	for_each_cpu(cpu, cpus) {
 		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
 		unsigned long cpu_util, util_running = util_freq;
 		struct task_struct *tsk = NULL;
@@ -6806,6 +6806,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
  */
 static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
 	int cpu, best_energy_cpu = prev_cpu, target = -1;
@@ -6840,7 +6841,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
 
-		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
+		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
+
+		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
@@ -6877,12 +6880,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			continue;
 
 		/* Compute the 'base' energy of the pd, without @p */
-		base_energy_pd = compute_energy(p, -1, pd);
+		base_energy_pd = compute_energy(p, -1, cpus, pd);
 		base_energy += base_energy_pd;
 
 		/* Evaluate the energy impact of using prev_cpu. */
 		if (compute_prev_delta) {
-			prev_delta = compute_energy(p, prev_cpu, pd);
+			prev_delta = compute_energy(p, prev_cpu, cpus, pd);
 			if (prev_delta < base_energy_pd)
 				goto unlock;
 			prev_delta -= base_energy_pd;
@@ -6891,7 +6894,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
 		if (max_spare_cap_cpu >= 0) {
-			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
+			cur_delta = compute_energy(p, max_spare_cap_cpu, cpus,
+						   pd);
 			if (cur_delta < base_energy_pd)
 				goto unlock;
 			cur_delta -= base_energy_pd;
-- 
2.36.1.255.ge46751e96f-goog

