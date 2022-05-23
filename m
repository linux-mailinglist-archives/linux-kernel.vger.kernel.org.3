Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CD25311FA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbiEWPxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbiEWPwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:52:42 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85533C713
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:52:41 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id l15-20020a05600c1d0f00b003973901d3b4so2946772wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xvz8pTdOu4fQbxYqVMwf3pWiSGQYuX7yCHLpo5kL/L4=;
        b=SKL1Kklk7s8dSDdvMgS8eeSgC61HXgt2xH5Wl/6cGOyIdVc1bvXM/TaE4dskgCo3zp
         YAOVkWLsMwZY1MdvQmgrY0g90vHbmFB7O5tilQa7XHCgxyoz5EQrunxngyJX0gRyJOnr
         j9v9J0KrSC7XPDIK6da5ZxOjfp20MHezR/XsRqgBRk09vz6b6xv7h53ygZv+fTNVKMq7
         W9a/KrseFSAZx7jwXMUgYxVAx51lhTC6eHLHolzZ7OzK9oCy/VHNMnvfigheAqeDGBQo
         hEaG7P9i4u8XLEnqkBREH/5JAuNHp+eLPEhrYONoic0XEOM/sbse28D0teIvdp8Ouh3X
         iz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xvz8pTdOu4fQbxYqVMwf3pWiSGQYuX7yCHLpo5kL/L4=;
        b=ciMF1xW0ypoUYRKXWM4NSwJHWt5TzY2CHX/3SidWp107HOwkn4V1QyMedW24n/rzqO
         ZJd8qHgwSV2yw2STv9QLqZ/oXJs9WGHNOlr0NmrR3LlC5gkISQfvyGpI2ArUbbMmSMC/
         yme7nPldoYYZTYsmMUfVPzGfHkBGO+7T+KfvONm9SV8Ci+HEY5/LGXnk3X3WCicy2j9x
         DYsnZDTavXNidhlR/sKGE1zPHQSXug10fPJFsHK3rAW5BwUZNE3bR+c921RpoVTV17lm
         dSwNxBGhgsj4Z35mZDVRWAFipok4lZZGiRLeLW0MUqOeGYQccDXJbct7qT33UJw9xQVU
         LArw==
X-Gm-Message-State: AOAM531H4wRZRRQYnq+sgpjLwUA2NE4AX9qvkO5MQDbpmozRYWVvdmEe
        dQ/LRNKv04C2CGKhCmneH10++Al+3cDVeA/5
X-Google-Smtp-Source: ABdhPJzRWZfmINL35YWInJJwa4PhFHQMF9nvBoWzHY/4bHuTgOw/kokAQxUePqg8MGIpDYKtDFk2mcZWWiseKkQb
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:3d8b:b0:397:469c:7bbd with
 SMTP id bi11-20020a05600c3d8b00b00397469c7bbdmr8345997wmb.62.1653321160524;
 Mon, 23 May 2022 08:52:40 -0700 (PDT)
Date:   Mon, 23 May 2022 16:51:37 +0100
In-Reply-To: <20220523155140.2878563-1-vdonnefort@google.com>
Message-Id: <20220523155140.2878563-5-vdonnefort@google.com>
Mime-Version: 1.0
References: <20220523155140.2878563-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v9 4/7] sched/fair: Rename select_idle_mask to select_rq_mask
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
index 73a9dc522b73..2d7bba2f1da2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5897,7 +5897,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 /* Working cpumask for: load_balance, load_balance_newidle. */
 DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
-DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
+DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -6387,7 +6387,7 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
  */
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
@@ -6473,7 +6473,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
-	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	task_util = uclamp_task_util(p);
-- 
2.36.1.124.g0e6072fb45-goog

