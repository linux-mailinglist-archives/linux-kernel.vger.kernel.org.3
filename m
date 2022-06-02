Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63353B2D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 06:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiFBEw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 00:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiFBEwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 00:52:42 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EB05586
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 21:52:39 -0700 (PDT)
X-UUID: 05070a5c46ec486298f547090cc1ff9d-20220602
X-Spam-Fingerprint: 0
X-GW-Reason: 13103
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HMTDkurrpnIDopoHlrqHmoLg=
X-Content-Feature: ica/max.line-size 100
        audit/email.address 2
        meta/cnt.alert 1
X-CPASD-INFO: 45cdf54338944cdfa48855161aff88cf@fYWdhJNnYmNfWHuAg6avoIFlaGhlYVG
        Fc5uGlmZoj4aVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3g3edhJhjZA==
X-CLOUD-ID: 45cdf54338944cdfa48855161aff88cf
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:186.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:311.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:2.0,SPC:0,SIG:-
        5,AUF:13,DUF:42070,ACD:302,DCD:404,SL:0,EISP:0,AG:0,CFC:0.794,CFSR:0.031,UAT:
        0,RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM
        :0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 05070a5c46ec486298f547090cc1ff9d-20220602
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 05070a5c46ec486298f547090cc1ff9d-20220602
X-User: huangbing@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <huangbing@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1684790633; Thu, 02 Jun 2022 11:25:21 +0800
From:   Bing Huang <huangbing@kylinos.cn>
To:     peterz@infradead.org, dietmar.eggemann@arm.com
Cc:     brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        vincent.guittot@linaro.org
Subject: [PATCH v3] sched/fair: static cpumasks for load balance
Date:   Thu,  2 Jun 2022 11:22:30 +0800
Message-Id: <20220602032230.400611-1-huangbing@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The both cpu mask load_balance_mask and select_idle_mask just only used
in fair.c, but allocation in core.c in CONFIG_CPUMASK_OFFSTACK=y case,
and global via declare per cpu variations. More or less, it looks wired.

Co-developed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Bing Huang <huangbing@kylinos.cn>
---

 v1->v2:
   move load_balance_mask and select_idle_mask allocation from 
   sched_init() to init_sched_fair_class()
 v2->v3: 
   fixup by Dietmar Eggemann <dietmar.eggemann@arm.com>

 kernel/sched/core.c | 11 -----------
 kernel/sched/fair.c | 13 +++++++++++--
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 696c6490bd5b..707df2aeebf8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9503,9 +9503,6 @@ LIST_HEAD(task_groups);
 static struct kmem_cache *task_group_cache __read_mostly;
 #endif
 
-DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
-DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
-
 void __init sched_init(void)
 {
 	unsigned long ptr = 0;
@@ -9549,14 +9546,6 @@ void __init sched_init(void)
 
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
index 8c5b74f66bd3..310b6f52a7df 100644
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


No virus found
		Checked by Hillstone Network AntiVirus
