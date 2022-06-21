Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA72552DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348465AbiFUJEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348548AbiFUJEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:04:38 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A856186D0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:04:37 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id l17-20020a05600c4f1100b0039c860db521so6101599wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MIz7mf9O+yDJg4rZecZM10jb/99QC/Kv+YtCD3EQfrA=;
        b=NrUeQOoS9ADwqZ/phm7tK20C/K3dSCmWla0NedrshRR7W2phNCvwjfPAEg78eDqsM1
         BNvdvg3AZffHgpSQJE++K0VH8Bb6gY1GUIWADtqGLdxqzHGSvlaQFy42xU6tTHByyGNJ
         Xj0tr3XMhGJM8GgLC6cJlOJn+o+pfttewK9vszflcYE1lInN5I04ptkiea8QtrJ8oZrO
         Yq4Yg+0QoDKn2q1JGEn59Fp61g+rIRVHplSwSdvvvKcE+3txmnpntFD4TQixOfy3RokS
         ybvgMeSGtFLyXhCdOsNdnwUBkFVU4ZCR02MbwLyjYl9sM2dSrqZj/TFyMlYbcv1dlfex
         oQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MIz7mf9O+yDJg4rZecZM10jb/99QC/Kv+YtCD3EQfrA=;
        b=ZPjazyxOa9qunUs3FLAQ1rNfK5Z54cqdGtwEsDn4EL9l//cx+FqZgeP9DAvyGCImlU
         ++0j49TxvPg6NubRLbWfac2g5XmE4fykrx6fmu/6bma1u2EkuY9a8FObbdzly5BRF5+2
         Iov+tEQSaVBjQ3N/Ty3KcJZREbnkOaJBRVO9dPmCskucn3FFx8zq6EA09x+O99RVGr5e
         lZ16X5ZRURicdEb9ywN0OXBlDcmC2+24ZWMxxR2z+Du0umJQv+OaYPNOlkwKWsh8IVXi
         wLDyHRcL7m6cYXcYUSDUndWzGpF7lYttHuacidKjdZ3Hmdg28T0hRcTUIny6pi/j3FxM
         P7yw==
X-Gm-Message-State: AOAM5321OVw/PUMW9YN/HRLbPEEOOltqSedBBlEZ7d6Mp/L6h8F4MbLU
        vc8C4PVw9CkATi+vWYh2apeaswt4vQ6xFbJT
X-Google-Smtp-Source: ABdhPJzwNyHYXBKWXt9ezF/mnWGVK1/cu3Wd9/J14ZWMeBdjcXqZbtEbiXaFvXnAlxC8qfYzAN7mylQrgALHdCCF
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:3052:b0:39c:6540:c280 with
 SMTP id n18-20020a05600c305200b0039c6540c280mr1747602wmh.1.1655802275960;
 Tue, 21 Jun 2022 02:04:35 -0700 (PDT)
Date:   Tue, 21 Jun 2022 10:04:12 +0100
In-Reply-To: <20220621090414.433602-1-vdonnefort@google.com>
Message-Id: <20220621090414.433602-6-vdonnefort@google.com>
Mime-Version: 1.0
References: <20220621090414.433602-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH v11 5/7] sched/fair: Use the same cpumask per-PD throughout find_energy_efficient_cpu()
From:   Vincent Donnefort <vdonnefort@google.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        vdonnefort@google.com, Lukasz Luba <lukasz.luba@arm.com>
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
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aad1c2248547..112f760ff47e 100644
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
2.37.0.rc0.104.g0611611a94-goog

