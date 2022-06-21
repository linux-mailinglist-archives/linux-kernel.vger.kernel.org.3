Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53205552DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348423AbiFUJEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348775AbiFUJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:04:36 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C0F15A26
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:04:35 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id z13-20020a056402274d00b004357fcdd51fso4260486edd.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uZkT0e9DzynSoNlb2+4Ge5Aa2zY9Tda7y0woN+dH9g4=;
        b=T+OHbeewkAFVIX4nvC8jC6nEMoX/Bm9vZeGRitoUIQGSdOwldSHJGY6AiPRR+mm6DY
         s9kWpC8Gr8RGzkZhrHZfHY1fQK8UhTrLuNt4d2VokXLzOX3BzUic5k3HCLvqz+G4feSF
         An1xZEZGnUqC8PZNdRLKdWkIlJeNdKKTRZMnpJl2sIXm5bsW3Lm/ZOPlIIFPGeHpnLRq
         ig4aZuw8QqJCdj6hDbhOQ/hxEWNTt6Jb1R2u+l6y1FGqCM10z8v3OwCTsytKqdigF40w
         Z0QtHIgQeJVb4b9vL4URzQxV5L2x/YDlKK/Uvo++HXPb72sp3ovQx9NcOfv/Opgnabf0
         HvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uZkT0e9DzynSoNlb2+4Ge5Aa2zY9Tda7y0woN+dH9g4=;
        b=PeEh2jEKhtBgLP5xCGIcT2sy56I3OKbxBguRayerqaMuJqKn8oW0DFVH2+NuxwbXpH
         o5XiKWUDuKNOTi83ADsYcqJ0ITfHt5pDaYfubHRKd8t5JaIyuwDBJ3lSpz64CJbj+pLS
         qfJFaoiBlmKmp/mJPhlc+6QNWqe+pVYxkes0qWm922LZdidMX/J4T6JCTRdLgWBs+8Vz
         5/ZYO68ViSmOqmy7Y0Q/kG4e3QRgPq3wAcdE1zPr9DER4we1K3Ryu27+htVXCKUZ42H+
         +IrAqcXzdpwzy2++++QAZClvJz2E+yhA1g68OxLU9QkUe1DE3q2ObJe11TumZnko6Sdw
         l9Ag==
X-Gm-Message-State: AJIora+OiQFQYjwXpcWPzD6euqYFRQiMxvQsUap789M/s4HngQqWzdHm
        QtxmdKHu6hyYH0o0+b3RyUdXdNOw7AcgxdkR
X-Google-Smtp-Source: AGRyM1to9dgPH8cgE4MqwlH/PJJCkEKVB76JmkNeY66OkPfDj+QRsV1Dl8QqANXfRxat/4yTj310EX0mGl57HafI
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a17:907:3e01:b0:722:c339:bde7 with SMTP
 id hp1-20020a1709073e0100b00722c339bde7mr8518978ejc.285.1655802273490; Tue,
 21 Jun 2022 02:04:33 -0700 (PDT)
Date:   Tue, 21 Jun 2022 10:04:11 +0100
In-Reply-To: <20220621090414.433602-1-vdonnefort@google.com>
Message-Id: <20220621090414.433602-5-vdonnefort@google.com>
Mime-Version: 1.0
References: <20220621090414.433602-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH v11 4/7] sched/fair: Rename select_idle_mask to select_rq_mask
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

Decouple the name of the per-cpu cpumask select_idle_mask from its usage
in select_idle_[cpu/capacity]() of the CFS run-queue selection
(select_task_rq_fair()).

This is to support the reuse of this cpumask in the Energy Aware
Scheduling (EAS) path (find_energy_efficient_cpu()) of the CFS run-queue
selection.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8fc1bd9f13b6..cf88be0cc599 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9570,7 +9570,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
 #endif
 
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
-DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
+DECLARE_PER_CPU(cpumask_var_t, select_rq_mask);
 
 void __init sched_init(void)
 {
@@ -9619,7 +9619,7 @@ void __init sched_init(void)
 	for_each_possible_cpu(i) {
 		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
-		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
+		per_cpu(select_rq_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee034a89bc87..aad1c2248547 100644
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
2.37.0.rc0.104.g0611611a94-goog

