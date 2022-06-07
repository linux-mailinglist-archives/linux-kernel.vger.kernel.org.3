Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F5953FEEF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbiFGMgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243875AbiFGMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:36:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C359DF68AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:36:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc7bdd666fso146685727b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FiXOdOteLG2uWXyI2t+PY63zK6LEMW1CJncp6bRpmgY=;
        b=EmLxjbzdrbPUO5RrzzqLKyObwGkJvgwOS8v+J0Gk66Ke5V+/cE7CWz8iArKxY731AL
         4I1VXV3XDs9zxjePv5PUuk2G0cszRgE15Fj2Vx+yas+DgT8/VcZrKy7gec2WA6po+wLA
         eDHCQGmJxd4x/XW1FT+73nwlzcHqU0/529MUVSPSINWp4XlPyk7hDzBQmyFqUCRrvErJ
         4i56nT8YNHZi+zMn9aSPREBeGEIYZddGyRgymCpcGhJwFl5H4THeYEPs2PdGHiTErG+M
         BBTiRNyJLQKO7dHAzT2RZZC2TcVF6olf/vjVUPMVtqSUGcZKbQvJ1zBZ5KEQljhkrCUo
         N4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FiXOdOteLG2uWXyI2t+PY63zK6LEMW1CJncp6bRpmgY=;
        b=XdgudnyE8SwHbRL3oHJz4IFg5xzobJzQoj8fAzrhXwopGnhta5JDaBvjVgGuy3Z3hT
         oSCNa6G1PKqnUy0p2MNXNNmhHnSdH7WCQN6BJ6VZLIj/g5mulp9sZ2fWGW4FkSOwSteX
         yLtAUH4lJVNDPddXPWx8iLW6L58grTHwsC8LGtpIQzqgg1MBFAFrj/M25UzH6YxnCP0W
         WgdNHWxJpXs0Awv7+1GF+2SkQLG+76oeJGMho7fhRBfFOhmhzFJSYXGt2e8hprKmnJCE
         rV99fse5nX92pWoQCgqRlM8RlYEBQlql3eqanaHiiGZH+/MeFqEBWCOZY7sDyUalQRKN
         b51g==
X-Gm-Message-State: AOAM531BURmou9sLBKlUj08KdsT6BSN029BQInbT/N0OVGU/Izgye4qa
        tmCL7ShjA4eCuJ7y2h/fo7VEw/A8h677yfqy
X-Google-Smtp-Source: ABdhPJwy1BfbGfOVpJMI/BLWGDHQ+Lh3jxxvJewYN+ZP/QiRGMCGUnvAckkDix2jEZpb15sXYdXRRImP0RLkD/Pc
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a25:504d:0:b0:662:73c9:55a4 with SMTP
 id e74-20020a25504d000000b0066273c955a4mr21008382ybb.258.1654605387474; Tue,
 07 Jun 2022 05:36:27 -0700 (PDT)
Date:   Tue,  7 Jun 2022 13:32:51 +0100
In-Reply-To: <20220607123254.565579-1-vdonnefort@google.com>
Message-Id: <20220607123254.565579-5-vdonnefort@google.com>
Mime-Version: 1.0
References: <20220607123254.565579-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v10 4/7] sched/fair: Rename select_idle_mask to select_rq_mask
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

Decouple the name of the per-cpu cpumask select_idle_mask from its usage
in select_idle_[cpu/capacity]() of the CFS run-queue selection
(select_task_rq_fair()).

This is to support the reuse of this cpumask in the Energy Aware
Scheduling (EAS) path (find_energy_efficient_cpu()) of the CFS run-queue
selection.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c531976ee960..68f5eb8a1de7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9502,7 +9502,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
 #endif
 
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
-DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
+DECLARE_PER_CPU(cpumask_var_t, select_rq_mask);
 
 void __init sched_init(void)
 {
@@ -9551,7 +9551,7 @@ void __init sched_init(void)
 	for_each_possible_cpu(i) {
 		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
-		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
+		per_cpu(select_rq_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f87ff939cbf3..bb5311cc5a44 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5898,7 +5898,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 /* Working cpumask for: load_balance, load_balance_newidle. */
 DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
-DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
+DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -6388,7 +6388,7 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
  */
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
@@ -6474,7 +6474,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
-	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	task_util = uclamp_task_util(p);
-- 
2.36.1.255.ge46751e96f-goog

