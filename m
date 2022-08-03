Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4458916E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbiHCRa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238292AbiHCRaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:30:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FEC13D32;
        Wed,  3 Aug 2022 10:30:46 -0700 (PDT)
Date:   Wed, 03 Aug 2022 17:30:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659547844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hY2455sfa/TGB8TuKmql6RklNNRdnqF09PK6+bfdj9A=;
        b=WHL5j13zrwhXImRPdkj8yczyq1ZE9Wufcg8mJ6iZLr6se/e+dwtHkQWFAp79VpXNjKvLly
        n6sQBIEY38fzw+T9yHgP5QFMZG+hviHDaJO9Jh5vn5fKPHRMKu/AqtKblMl+GixTnB0Gsn
        qrNXc08fTEGJbQB835cXHaullWXTc6NgfxwHMjEvOz9i28Quk5BKf35d8CZrh4eM9M77rK
        MCb4W+qb1bFVff9rbeIPoF7ABlDWeDe8Zqhgira3uBwe4aXJ/6/716XKngEePt8E+VRX0F
        6Y5w42qidsr5//nMSbNib038JJEqlai2pAZ+pbBLKuhgDwHUOqNHF6JxMEHAyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659547844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hY2455sfa/TGB8TuKmql6RklNNRdnqF09PK6+bfdj9A=;
        b=lBzlfeQFwe9hN/bicVEOx/aXiiChQmyagVTThI2bd91F9n/m1jYjTVcjk8uLRugJFLa1Bs
        H0CmyG0TeTjStDAA==
From:   "tip-bot2 for Bing Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Make per-cpu cpumasks static
Cc:     Bing Huang <huangbing@kylinos.cn>, Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220722213609.3901-1-huangbing775@126.com>
References: <20220722213609.3901-1-huangbing775@126.com>
MIME-Version: 1.0
Message-ID: <165954784337.15455.14071193485990481761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     18c31c9711a90b48a77b78afb65012d9feec444c
Gitweb:        https://git.kernel.org/tip/18c31c9711a90b48a77b78afb65012d9feec444c
Author:        Bing Huang <huangbing@kylinos.cn>
AuthorDate:    Sat, 23 Jul 2022 05:36:09 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Aug 2022 19:17:33 +02:00

sched/fair: Make per-cpu cpumasks static

The load_balance_mask and select_rq_mask percpu variables are only used in
kernel/sched/fair.c.

Make them static and move their allocation into init_sched_fair_class().

Replace kzalloc_node() with zalloc_cpumask_var_node() to get rid of the
CONFIG_CPUMASK_OFFSTACK #ifdef and to align with per-cpu cpumask
allocation for RT (local_cpu_mask in init_sched_rt_class()) and DL
class (local_cpu_mask_dl in init_sched_dl_class()).

[ mingo: Tidied up changelog & touched up the code. ]

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220722213609.3901-1-huangbing775@126.com
---
 kernel/sched/core.c | 11 -----------
 kernel/sched/fair.c | 11 +++++++++--
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6785e3b..64c0899 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9563,9 +9563,6 @@ LIST_HEAD(task_groups);
 static struct kmem_cache *task_group_cache __read_mostly;
 #endif
 
-DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
-DECLARE_PER_CPU(cpumask_var_t, select_rq_mask);
-
 void __init sched_init(void)
 {
 	unsigned long ptr = 0;
@@ -9609,14 +9606,6 @@ void __init sched_init(void)
 
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
index d22c5e8..da38865 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5893,8 +5893,8 @@ dequeue_throttle:
 #ifdef CONFIG_SMP
 
 /* Working cpumask for: load_balance, load_balance_newidle. */
-DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
-DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
+static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
+static DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -12074,6 +12074,13 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
 __init void init_sched_fair_class(void)
 {
 #ifdef CONFIG_SMP
+	int i;
+
+	for_each_possible_cpu(i) {
+		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i), GFP_KERNEL, cpu_to_node(i));
+		zalloc_cpumask_var_node(&per_cpu(select_rq_mask,    i), GFP_KERNEL, cpu_to_node(i));
+	}
+
 	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
 
 #ifdef CONFIG_NO_HZ_COMMON
