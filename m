Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309E757E8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiGVVhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVVhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:37:18 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86492B8512
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 14:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fuKew
        TK4UifSjCraiPlQjY4qDtMzxu374t6eQzjxfAY=; b=ToPelJp4gHnW0oTXGoKgD
        k8uWPxDVJulqznwWGck08YQvenEJpnN2zeK9FZLyg2vxMNPJVB6TnLJ3ERDTi++E
        5oZG1i1b+EGqj/L/8w1NfDXwOYfY6mwK9KHwswFCNzUMJ8yUTKkofNte4WDH/zAN
        /IDSFcs6YE+DPL6Xmv6NvA=
Received: from localhost.localdomain (unknown [113.247.45.12])
        by smtp2 (Coremail) with SMTP id DMmowAB34f1JGNtiTAQaFg--.51171S2;
        Sat, 23 Jul 2022 05:36:11 +0800 (CST)
From:   huangbing775@126.com
To:     dietmar.eggemann@arm.com, vincent.guittot@linaro.org
Cc:     brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        peterz@infradead.org
Subject: [RESEND PATCH v5] sched/fair: Make per-cpu cpumasks static
Date:   Sat, 23 Jul 2022 05:36:09 +0800
Message-Id: <20220722213609.3901-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowAB34f1JGNtiTAQaFg--.51171S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1xCF4DGr4rWw47urW3ZFb_yoW5ZF1fpr
        WkK3yUW395ta4kX3yvy34kCr1Fg3s3GwsxtanYvF95Gr9rG3WUKrnYgF13urW09rWkGF1f
        KFWvyrW2qw1jyw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsNVkUUUUU=
X-Originating-IP: [113.247.45.12]
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbijAxGr1pEIsU9BQAAso
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bing Huang <huangbing@kylinos.cn>

load_balance_mask and select_rq_mask are only used in fair.c. Make
them static and move their allocation into init_sched_fair_class().

Replace kzalloc_node() with zalloc_cpumask_var_node() to get rid of the
CONFIG_CPUMASK_OFFSTACK #ifdef and to align with per-cpu cpumask
allocation for RT (local_cpu_mask in init_sched_rt_class()) and DL
class (local_cpu_mask_dl in init_sched_dl_class()).

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---

 v1->v2:
   move load_balance_mask and select_idle_mask allocation from
   sched_init() to init_sched_fair_class()
 v2->v3:
   fixup by Dietmar Eggemann <dietmar.eggemann@arm.com>
 v3->v4:
   change the patch title and commit message
 v4->v5:
   change select_idle_mask to select_rq_mask

 kernel/sched/core.c | 11 -----------
 kernel/sched/fair.c | 13 +++++++++++--
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eda7bffe852a..475bfb5f0187 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9597,9 +9597,6 @@ LIST_HEAD(task_groups);
 static struct kmem_cache *task_group_cache __read_mostly;
 #endif
 
-DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
-DECLARE_PER_CPU(cpumask_var_t, select_rq_mask);
-
 void __init sched_init(void)
 {
 	unsigned long ptr = 0;
@@ -9643,14 +9640,6 @@ void __init sched_init(void)
 
 #endif /* CONFIG_RT_GROUP_SCHED */
 	}
-#ifdef CONFIG_CPUMASK_OFFSTACK
-	for_each_possible_cpu(i) {
-		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
-			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
-		per_cpu(select_rq_mask, i) = (cpumask_var_t)kzalloc_node(
-			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
-	}
-#endif /* CONFIG_CPUMASK_OFFSTACK */
 
 	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ac64b5bb7cc9..b044fda2df9d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5897,8 +5897,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 #ifdef CONFIG_SMP
 
 /* Working cpumask for: load_balance, load_balance_newidle. */
-DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
-DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
+static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
+static DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -12049,6 +12049,15 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
 __init void init_sched_fair_class(void)
 {
 #ifdef CONFIG_SMP
+	int i;
+
+	for_each_possible_cpu(i) {
+		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i),
+					GFP_KERNEL, cpu_to_node(i));
+		zalloc_cpumask_var_node(&per_cpu(select_rq_mask, i),
+					GFP_KERNEL, cpu_to_node(i));
+	}
+
 	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
 
 #ifdef CONFIG_NO_HZ_COMMON
-- 
2.25.1

