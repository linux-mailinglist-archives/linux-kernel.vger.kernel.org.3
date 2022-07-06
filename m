Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2705E5681D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiGFIg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiGFIgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:36:45 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35E0F24954
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=g4Xr+
        M8f7iFLiepv2AynXK5I1Rg75EOr7E+xZ6cYTpA=; b=ihe3wgefSEnqSXfwERG/F
        djTbWspyfNpllI4eK7MVicqkcHVk8EQ+G4shA18mPl5cfiQbVFAIJf73I49Z4wKn
        toRP8eucI8EhkfkQF1Zv+41NAGgKE2gsrLTZeIp2zmfzA3fLSx48qG77f/tIbghT
        8avi6GGPB+r3BUUQgImzgQ=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp1 (Coremail) with SMTP id C8mowACXz9_aSMViAIZgGA--.38248S2;
        Wed, 06 Jul 2022 16:33:32 +0800 (CST)
From:   Bing Huang <huangbing775@126.com>
To:     rostedt@goodmis.org, dietmar.eggemann@arm.com
Cc:     brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Subject: [PATCH v4] sched/fair: Make per-cpu cpumasks static
Date:   Wed,  6 Jul 2022 16:33:30 +0800
Message-Id: <20220706083330.27944-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowACXz9_aSMViAIZgGA--.38248S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1xCF4DGr43JF4DKFWktFb_yoW5CFyUpr
        WDK3yUW395tF1vq392y34kCr9Yg3s3CwsxJanYvF95JF9rt3W8KrnYqF17urW0gFWkGF4f
        KFZYqrW2qw1jyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNL0OUUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbijB02r1pEIeKRoAAAsk
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bing Huang <huangbing@kylinos.cn>

load_balance_mask and select_idle_mask are only used in fair.c. Make
them static and move their allocation into init_sched_fair_class().

Replace kzalloc_node() with zalloc_cpumask_var_node() to get rid of the
CONFIG_CPUMASK_OFFSTACK #ifdef and to align with per-cpu cpumask
allocation for RT (local_cpu_mask in init_sched_rt_class()) and DL
class (local_cpu_mask_dl in init_sched_dl_class()).

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

 v1->v2:
   move load_balance_mask and select_idle_mask allocation from
   sched_init() to init_sched_fair_class()
 v2->v3:
   fixup by Dietmar Eggemann <dietmar.eggemann@arm.com>
 v3->v4:
   change the patch title and commit message

 kernel/sched/core.c | 11 -----------
 kernel/sched/fair.c | 13 +++++++++++--
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecd..2feff25fd905 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9530,9 +9530,6 @@ LIST_HEAD(task_groups);
 static struct kmem_cache *task_group_cache __read_mostly;
 #endif
 
-DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
-DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
-
 void __init sched_init(void)
 {
 	unsigned long ptr = 0;
@@ -9576,14 +9573,6 @@ void __init sched_init(void)
 
 #endif /* CONFIG_RT_GROUP_SCHED */
 	}
-#ifdef CONFIG_CPUMASK_OFFSTACK
-	for_each_possible_cpu(i) {
-		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
-			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
-		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
-			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
-	}
-#endif /* CONFIG_CPUMASK_OFFSTACK */
 
 	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9326..61ae0853721e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5843,8 +5843,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 #ifdef CONFIG_SMP
 
 /* Working cpumask for: load_balance, load_balance_newidle. */
-DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
-DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
+static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
+static DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -11841,6 +11841,15 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
 __init void init_sched_fair_class(void)
 {
 #ifdef CONFIG_SMP
+	int i;
+
+	for_each_possible_cpu(i) {
+		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i),
+					GFP_KERNEL, cpu_to_node(i));
+		zalloc_cpumask_var_node(&per_cpu(select_idle_mask, i),
+					GFP_KERNEL, cpu_to_node(i));
+	}
+
 	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
 
 #ifdef CONFIG_NO_HZ_COMMON
-- 
2.25.1

