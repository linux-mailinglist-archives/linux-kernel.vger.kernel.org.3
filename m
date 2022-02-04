Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A9C4A99A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352107AbiBDNFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:05:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43900 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347190AbiBDNFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:05:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2C9861B94
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5E4C340EF;
        Fri,  4 Feb 2022 13:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643979910;
        bh=lpyoTQGGfPdBu6D5jCoW1Uwqc9k9CFLDPrxe0jkTtMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BecIEFLxszKNoUv4rr7cmZovS0iKx4AcRjz0TZyXIxG27hqzZXxlanjDaVcEhRTA6
         Ts8FsHjAXMUeBpFtrEZi0G477+SD4O8otigg0Xe6fQEYWL1gU88ySaXfrRUewognwK
         R9DqQMAu/PqIhlA2ZYJ0d4EfJ9wHBkE6rBZGKW652XvyGxESKF2PzOO2vPLTc4R7rg
         uDWUzbOKZz5Uk9zqwDMCO43zBd1KQGMyxu/D4DZT9NHSkD6ZhFz8ktt5SX7JL13coa
         pJA+GK/P44JywX9gfvPf06eY38LdZKMyzHszW0mcOUxDQK2YN3Hw6hEOjbepXH6v2+
         0fif9AecBmjgQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH 8/8] sched/isolation: Split housekeeping cpumask per isolation features
Date:   Fri,  4 Feb 2022 14:04:33 +0100
Message-Id: <20220204130433.488085-9-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204130433.488085-1-frederic@kernel.org>
References: <20220204130433.488085-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for supporting each housekeeping feature toward cpuset, split
the global housekeeping cpumask per HK_TYPE_* entry.

This will later allow, for example, to runtime modify the cpulist passed
through "isolcpus=", "nohz_full=" and "rcu_nocbs=" kernel boot
parameters.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Nitesh Lal <nilal@redhat.com>
Cc: Nicolas Saenz <nsaenzju@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Lameter <cl@gentwo.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Alex Belits <abelits@marvell.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Paul E. McKenney  <paulmck@kernel.org>
---
 kernel/sched/isolation.c | 91 +++++++++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 883eee9fae22..b4d10815c45a 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -23,12 +23,17 @@ enum hk_flags {
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
-static cpumask_var_t housekeeping_mask;
-static unsigned int housekeeping_flags;
+
+struct housekeeping {
+	cpumask_var_t cpumasks[HK_TYPE_MAX];
+	unsigned long flags;
+};
+
+static struct housekeeping housekeeping;
 
 bool housekeeping_enabled(enum hk_type type)
 {
-	return !!(housekeeping_flags & BIT(type));
+	return !!(housekeeping.flags & BIT(type));
 }
 EXPORT_SYMBOL_GPL(housekeeping_enabled);
 
@@ -37,12 +42,12 @@ int housekeeping_any_cpu(enum hk_type type)
 	int cpu;
 
 	if (static_branch_unlikely(&housekeeping_overridden)) {
-		if (housekeeping_flags & BIT(type)) {
-			cpu = sched_numa_find_closest(housekeeping_mask, smp_processor_id());
+		if (housekeeping.flags & BIT(type)) {
+			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
 			if (cpu < nr_cpu_ids)
 				return cpu;
 
-			return cpumask_any_and(housekeeping_mask, cpu_online_mask);
+			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
 		}
 	}
 	return smp_processor_id();
@@ -52,8 +57,8 @@ EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
 const struct cpumask *housekeeping_cpumask(enum hk_type type)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
-		if (housekeeping_flags & BIT(type))
-			return housekeeping_mask;
+		if (housekeeping.flags & BIT(type))
+			return housekeeping.cpumasks[type];
 	return cpu_possible_mask;
 }
 EXPORT_SYMBOL_GPL(housekeeping_cpumask);
@@ -61,40 +66,53 @@ EXPORT_SYMBOL_GPL(housekeeping_cpumask);
 void housekeeping_affine(struct task_struct *t, enum hk_type type)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
-		if (housekeeping_flags & BIT(type))
-			set_cpus_allowed_ptr(t, housekeeping_mask);
+		if (housekeeping.flags & BIT(type))
+			set_cpus_allowed_ptr(t, housekeeping.cpumasks[type]);
 }
 EXPORT_SYMBOL_GPL(housekeeping_affine);
 
 bool housekeeping_test_cpu(int cpu, enum hk_type type)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
-		if (housekeeping_flags & BIT(type))
-			return cpumask_test_cpu(cpu, housekeeping_mask);
+		if (housekeeping.flags & BIT(type))
+			return cpumask_test_cpu(cpu, housekeeping.cpumasks[type]);
 	return true;
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 
 void __init housekeeping_init(void)
 {
-	if (!housekeeping_flags)
+	enum hk_type type;
+
+	if (!housekeeping.flags)
 		return;
 
 	static_branch_enable(&housekeeping_overridden);
 
-	if (housekeeping_flags & HK_FLAG_TICK)
+	if (housekeeping.flags & HK_FLAG_TICK)
 		sched_tick_offload_init();
 
-	/* We need at least one CPU to handle housekeeping work */
-	WARN_ON_ONCE(cpumask_empty(housekeeping_mask));
+	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
+		/* We need at least one CPU to handle housekeeping work */
+		WARN_ON_ONCE(cpumask_empty(housekeeping.cpumasks[type]));
+	}
 }
 
-static int __init housekeeping_setup(char *str, enum hk_flags flags)
+static void __init housekeeping_setup_type(enum hk_type type,
+					   cpumask_var_t housekeeping_staging)
+{
+
+	alloc_bootmem_cpumask_var(&housekeeping.cpumasks[type]);
+	cpumask_copy(housekeeping.cpumasks[type],
+		     housekeeping_staging);
+}
+
+static int __init housekeeping_setup(char *str, unsigned long flags)
 {
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
 	int err = 0;
 
-	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
+	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
 			pr_warn("Housekeeping: nohz unsupported."
 				" Build with CONFIG_NO_HZ_FULL\n");
@@ -115,26 +133,41 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
 		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
 		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
-		if (!housekeeping_flags) {
+		if (!housekeeping.flags) {
 			pr_warn("Housekeeping: must include one present CPU, "
 				"using boot CPU:%d\n", smp_processor_id());
 		}
 	}
 
-	if (!housekeeping_flags) {
-		alloc_bootmem_cpumask_var(&housekeeping_mask);
-		cpumask_copy(housekeeping_mask, housekeeping_staging);
+	if (!housekeeping.flags) {
+		/* First setup call ("nohz_full=" or "isolcpus=") */
+		enum hk_type type;
+
+		for_each_set_bit(type, &flags, HK_TYPE_MAX)
+			housekeeping_setup_type(type, housekeeping_staging);
 	} else {
-		if (!cpumask_equal(housekeeping_staging, housekeeping_mask)) {
-			pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
-			goto free_housekeeping_staging;
+		/* Second setup call ("nohz_full=" after "isolcpus=" or the reverse) */
+		enum hk_type type;
+		unsigned long iter_flags = flags & housekeeping.flags;
+
+		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX) {
+			if (!cpumask_equal(housekeeping_staging,
+					   housekeeping.cpumasks[type])) {
+				pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
+				goto free_housekeeping_staging;
+			}
 		}
+
+		iter_flags = flags & ~housekeeping.flags;
+
+		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
+			housekeeping_setup_type(type, housekeeping_staging);
 	}
 
-	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK))
+	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK))
 		tick_nohz_full_setup(non_housekeeping_mask);
 
-	housekeeping_flags |= flags;
+	housekeeping.flags |= flags;
 	err = 1;
 
 free_housekeeping_staging:
@@ -147,7 +180,7 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 
 static int __init housekeeping_nohz_full_setup(char *str)
 {
-	unsigned int flags;
+	unsigned long flags;
 
 	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
 		HK_FLAG_MISC | HK_FLAG_KTHREAD;
@@ -158,7 +191,7 @@ __setup("nohz_full=", housekeeping_nohz_full_setup);
 
 static int __init housekeeping_isolcpus_setup(char *str)
 {
-	unsigned int flags = 0;
+	unsigned long flags = 0;
 	bool illegal = false;
 	char *par;
 	int len;
-- 
2.25.1

