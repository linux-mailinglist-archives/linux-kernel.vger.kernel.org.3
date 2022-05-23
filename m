Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50986531F88
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiEXAB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiEXABu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:01:50 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A405EBFC
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:01:45 -0700 (PDT)
X-UUID: 59e43390c90949f5a03ab528df18cf46-20220523
X-Spam-Fingerprint: 0
X-GW-Reason: 11109
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HMTDkurrpnIDopoHlrqHmoLg=
X-Content-Feature: ica/max.line-size 100
        audit/email.address 1
        meta/cnt.alert 1
X-CPASD-INFO: 01f6ae0840124056a23b88ed5e5fae0e@eYGgVo6XXmhgUHN-
        g3OAcIFjY5JoZIWzd59Vlo-
        VXIWVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3f3OgVpGTYA==
X-CLOUD-ID: 01f6ae0840124056a23b88ed5e5fae0e
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:197.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:353.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:7,DUF:41185,ACD:293,DCD:395,SL:0,EISP:0,AG:0,CFC:0.825,CFSR:0.036,UAT:0
        ,RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:
        0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 59e43390c90949f5a03ab528df18cf46-20220523
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 59e43390c90949f5a03ab528df18cf46-20220523
X-User: huangbing@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <huangbing@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1108139998; Mon, 23 May 2022 17:46:00 +0800
From:   Bing Huang <huangbing@kylinos.cn>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org, Bing Huang <huangbing@kylinos.cn>
Subject: [PATCH] sche/fair: static cpumasks for load balance
Date:   Mon, 23 May 2022 17:42:16 +0800
Message-Id: <20220523094216.1746504-1-huangbing@kylinos.cn>
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

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
---
 kernel/sched/core.c  | 13 +++----------
 kernel/sched/fair.c  | 18 ++++++++++++++++--
 kernel/sched/sched.h |  4 ++++
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d58c0389eb23..64934c5e236d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9448,9 +9448,6 @@ LIST_HEAD(task_groups);
 static struct kmem_cache *task_group_cache __read_mostly;
 #endif
 
-DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
-DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
-
 void __init sched_init(void)
 {
 	unsigned long ptr = 0;
@@ -9494,14 +9491,10 @@ void __init sched_init(void)
 
 #endif /* CONFIG_RT_GROUP_SCHED */
 	}
+
 #ifdef CONFIG_CPUMASK_OFFSTACK
-	for_each_possible_cpu(i) {
-		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
-			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
-		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
-			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
-	}
-#endif /* CONFIG_CPUMASK_OFFSTACK */
+	init_working_cpumask();
+#endif
 
 	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a68482d66535..3a4b0dd1beb5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5831,8 +5831,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 #ifdef CONFIG_SMP
 
 /* Working cpumask for: load_balance, load_balance_newidle. */
-DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
-DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
+static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
+static DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -7052,6 +7052,20 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 }
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_CPUMASK_OFFSTACK
+void __init init_working_cpumask(void)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
+				cpumask_size(), GFP_KERNEL, cpu_to_node(i));
+		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
+				cpumask_size(), GFP_KERNEL, cpu_to_node(i));
+	}
+}
+#endif
+
 static unsigned long wakeup_gran(struct sched_entity *se)
 {
 	unsigned long gran = sysctl_sched_wakeup_granularity;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..9065be3def51 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3087,4 +3087,8 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
+#ifdef CONFIG_CPUMASK_OFFSTACK
+extern void __init init_working_cpumask(void);
+#endif /* CONFIG_CPUMASK_OFFSTACK */
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
