Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEF64BA905
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbiBQS5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:57:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244657AbiBQS5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:57:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7150A5C85B;
        Thu, 17 Feb 2022 10:56:46 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=an+uuknNOI4I1L34/wn1zm9vIZR0T0TDAOSVeXtTsoA=;
        b=nGTt2QX05CfqEprHtTzmZqQ1P2AADQ6QScGd46IVKjwwdurOw5TrCKd7Hyvzhv2fPTgT3H
        ayGz9NV+9tRPTBL03CWt4aokyVDeONh2QSn1kFqfczfrvQmaehjxGBJQM3702bi0ZZblVD
        iJAXPwHKBUp1no6FOCckQTVG5ooNvfCeq/qDwkqWtPtSniMovvr0gxMQN91AuH/iPrKalD
        gQ/ar4O3mZF7y9DRkZ//+vKNk7M3HbRX0mQPm1rzoj8syLWz3fY7ybix5JPozAcTs5d0Oh
        glUeUKEPS9iGKYSFh9qDxNgRhWrB7lWEePvBOzVZRTy87Dl/MxzmCwOVU1AysQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=an+uuknNOI4I1L34/wn1zm9vIZR0T0TDAOSVeXtTsoA=;
        b=jdNm7FZdr6km7Vzf+xv5t14+bDNhPPOKNRCSqqGl71PkM+Licjbo9+hv/GJ21nLvahaN8C
        PRA6zmBo2OTw1iDg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/isolation: Split housekeeping cpumask per
 isolation features
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207155910.527133-9-frederic@kernel.org>
References: <20220207155910.527133-9-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <164512420399.16921.15928789351536425713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ed3b362d54f0038cafc985248350d301af7af686
Gitweb:        https://git.kernel.org/tip/ed3b362d54f0038cafc985248350d301af7af686
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 07 Feb 2022 16:59:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:56 +01:00

sched/isolation: Split housekeeping cpumask per isolation features

To prepare for supporting each housekeeping feature toward cpuset, split
the global housekeeping cpumask per HK_TYPE_* entry.

This will later allow, for example, to runtime modify the cpulist passed
through "isolcpus=", "nohz_full=" and "rcu_nocbs=" kernel boot
parameters.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lore.kernel.org/r/20220207155910.527133-9-frederic@kernel.org
---
 kernel/sched/isolation.c | 91 ++++++++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 883eee9..b4d1081 100644
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
+}
+
+static void __init housekeeping_setup_type(enum hk_type type,
+					   cpumask_var_t housekeeping_staging)
+{
+
+	alloc_bootmem_cpumask_var(&housekeeping.cpumasks[type]);
+	cpumask_copy(housekeeping.cpumasks[type],
+		     housekeeping_staging);
 }
 
-static int __init housekeeping_setup(char *str, enum hk_flags flags)
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
@@ -147,7 +180,7 @@ free_non_housekeeping_mask:
 
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
