Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E4F5313EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiEWPx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbiEWPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:52:51 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9D722500
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:52:44 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so6064190wmr.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MjDJsLnT59g4872Q3lt9Zm37fZ4mNI7JXqzvW6ZT7os=;
        b=k6LzOD7lnD7O0uSf5smVZlRnelOmGfyMEvSaAQOqTDrf22Kp5q+M7woMSMG5dFKvyC
         oEB+yOM/2xn6X2wz8JGriYWz7wWQmRMRIG4/COPYtwK3ALt6G91UrlnadO2FVLUTtoW6
         c2QbVEbLrgDUetpAxAPMp1eG8TcQwiyt8lvPevg6rfiPOXwMLG+mbktAJFMClLQTmzrs
         +Y0IB5JpNUKBW7uE296saAt6QIuwpPhH1lAJPwrH4JTvWK31Au8Dasg+8JxUPU7is9Uk
         o5VS6I1FcOKb8Zyx81mh5PMX+YmelX8x2Y9rBKtwIyZgUuKha2xgT60sKG4Km9mBeI/u
         MW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MjDJsLnT59g4872Q3lt9Zm37fZ4mNI7JXqzvW6ZT7os=;
        b=NVZbcsJqiYkMYLpxZwKMzD3K8uNbgu8KsyH7iCrxhA06OEph68Nhr/010egDibAaHz
         xh3LN5JwcFlPvpAe/mWhoFRHe5cjlhsjFu4K19bHCrHZrSepJhuhEOPdxvr4DKpW/hBV
         cJave2HWH7aPn6i3+9ixp38hnPyyQVOL2PkoP4Fmx4VxyQgU4+0Kso6vueeCm7IcV00Y
         dxZXHrrois10QtL1EIX+1dMhR9PTzu5DfH0HExYDor3RjRLcW7PEhbr/3nWob/fuTMlh
         8Sbj+mwQjUUKe/+YUJy907hwryxo7z34Tzso61117YOCLtTcvtYzLtjUoZJ5s4Kqq0vv
         sVSg==
X-Gm-Message-State: AOAM532TxeAHeAW1wTg4KpbXXiYdpjghhGASYt/KxJHnxXOz7QEYMJ+W
        wMQ27DoNnS7xTKhoJkRWxecVatNEfskCzsfv
X-Google-Smtp-Source: ABdhPJyjIfbild4KI6OWBXv83Cutzr0T1BPrCrMfX9mm09aGpM5I5h2QkCDpbC46depJfLEONBOxZ4ILZUQFvpaR
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:1e1a:b0:20f:c403:9180 with
 SMTP id bj26-20020a0560001e1a00b0020fc4039180mr11277074wrb.147.1653321162622;
 Mon, 23 May 2022 08:52:42 -0700 (PDT)
Date:   Mon, 23 May 2022 16:51:38 +0100
In-Reply-To: <20220523155140.2878563-1-vdonnefort@google.com>
Message-Id: <20220523155140.2878563-6-vdonnefort@google.com>
Mime-Version: 1.0
References: <20220523155140.2878563-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v9 5/7] sched/fair: Use the same cpumask per-PD throughout find_energy_efficient_cpu()
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

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d7bba2f1da2..57074f27c0d2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6700,14 +6700,14 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
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
@@ -6718,7 +6718,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 	 * If an entire pd is outside of the current rd, it will not appear in
 	 * its pd list and will not be accounted by compute_energy().
 	 */
-	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
+	for_each_cpu(cpu, cpus) {
 		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
 		unsigned long cpu_util, util_running = util_freq;
 		struct task_struct *tsk = NULL;
@@ -6805,6 +6805,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
  */
 static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
 	int cpu, best_energy_cpu = prev_cpu, target = -1;
@@ -6839,7 +6840,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
 
-		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
+		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
+
+		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
@@ -6876,12 +6879,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -6890,7 +6893,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
 		if (max_spare_cap_cpu >= 0) {
-			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
+			cur_delta = compute_energy(p, max_spare_cap_cpu, cpus,
+						   pd);
 			if (cur_delta < base_energy_pd)
 				goto unlock;
 			cur_delta -= base_energy_pd;
-- 
2.36.1.124.g0e6072fb45-goog

