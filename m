Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C34F5A91D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiIAIN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbiIAIMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:12:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15BE12BF6A;
        Thu,  1 Sep 2022 01:12:50 -0700 (PDT)
Date:   Thu, 01 Sep 2022 08:12:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662019969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NnKN6DMDjh99jIycTwhhdg1L7Pj2jph5AgmlhOsGcng=;
        b=vyXXqXvxAPJ5sd3VWGR31K2TIQjcuLBWul0irfIfoUPcUlVYi/qRonBm7nIRWHIfjUFSD8
        uPtO+S+yQPPWHpX/YlThHSblHw7JBTwEwgtjPznLHm+iZNczOGnluo6TZC0K8HOGNNb8Rb
        VptHCgCuG0ovFNyN5tBv5Jtm+qgsLQ5QJrqCIm7HK2sg0Ue2sKP7vpWg+Boi/3eVhjP8yh
        SMhlqLdRWDKBJDzLO6uR3HwwAXLDqfiC5XvtuLaTtXGq9vtlORFHayrruD2mm68OYaV3PN
        uO7wfjQczX+K65Ke+4YHzRYDUTeGIIhSktzqrnV9Kt/Ol5dyIFRUkmEEDNKQ2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662019969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NnKN6DMDjh99jIycTwhhdg1L7Pj2jph5AgmlhOsGcng=;
        b=Nbablo6AUjRjU+dKdVrlj/eM2d5iifoYxTF79fdpBic5Za4FtnV2zt63bH2/jlc3RWslLI
        DBJTKRWikmvwNyDg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/hw_breakpoint: Optimize constant number of
 breakpoint slots
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ian Rogers <irogers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829124719.675715-7-elver@google.com>
References: <20220829124719.675715-7-elver@google.com>
MIME-Version: 1.0
Message-ID: <166201996819.401.16934538244848420851.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     be3f152568cc7f5f573d21d5f86a2c4f3cc047ab
Gitweb:        https://git.kernel.org/tip/be3f152568cc7f5f573d21d5f86a2c4f3cc047ab
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 29 Aug 2022 14:47:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 Aug 2022 10:56:22 +02:00

perf/hw_breakpoint: Optimize constant number of breakpoint slots

Optimize internal hw_breakpoint state if the architecture's number of
breakpoint slots is constant. This avoids several kmalloc() calls and
potentially unnecessary failures if the allocations fail, as well as
subtly improves code generation and cache locality.

The protocol is that if an architecture defines hw_breakpoint_slots via
the preprocessor, it must be constant and the same for all types.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20220829124719.675715-7-elver@google.com
---
 arch/sh/include/asm/hw_breakpoint.h  |  5 +-
 arch/x86/include/asm/hw_breakpoint.h |  5 +-
 kernel/events/hw_breakpoint.c        | 94 +++++++++++++++++----------
 3 files changed, 63 insertions(+), 41 deletions(-)

diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
index 199d17b..361a0f5 100644
--- a/arch/sh/include/asm/hw_breakpoint.h
+++ b/arch/sh/include/asm/hw_breakpoint.h
@@ -48,10 +48,7 @@ struct pmu;
 /* Maximum number of UBC channels */
 #define HBP_NUM		2
 
-static inline int hw_breakpoint_slots(int type)
-{
-	return HBP_NUM;
-}
+#define hw_breakpoint_slots(type) (HBP_NUM)
 
 /* arch/sh/kernel/hw_breakpoint.c */
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index a1f0e90..0bc931c 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -44,10 +44,7 @@ struct arch_hw_breakpoint {
 /* Total number of available HW breakpoint registers */
 #define HBP_NUM 4
 
-static inline int hw_breakpoint_slots(int type)
-{
-	return HBP_NUM;
-}
+#define hw_breakpoint_slots(type) (HBP_NUM)
 
 struct perf_event_attr;
 struct perf_event;
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 7df46b2..9fb66d3 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -40,13 +40,16 @@ struct bp_cpuinfo {
 	/* Number of pinned cpu breakpoints in a cpu */
 	unsigned int	cpu_pinned;
 	/* tsk_pinned[n] is the number of tasks having n+1 breakpoints */
+#ifdef hw_breakpoint_slots
+	unsigned int	tsk_pinned[hw_breakpoint_slots(0)];
+#else
 	unsigned int	*tsk_pinned;
+#endif
 	/* Number of non-pinned cpu/task breakpoints in a cpu */
 	unsigned int	flexible; /* XXX: placeholder, see fetch_this_slot() */
 };
 
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
-static int nr_slots[TYPE_MAX] __ro_after_init;
 
 static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
 {
@@ -73,6 +76,54 @@ struct bp_busy_slots {
 /* Serialize accesses to the above constraints */
 static DEFINE_MUTEX(nr_bp_mutex);
 
+#ifdef hw_breakpoint_slots
+/*
+ * Number of breakpoint slots is constant, and the same for all types.
+ */
+static_assert(hw_breakpoint_slots(TYPE_INST) == hw_breakpoint_slots(TYPE_DATA));
+static inline int hw_breakpoint_slots_cached(int type)	{ return hw_breakpoint_slots(type); }
+static inline int init_breakpoint_slots(void)		{ return 0; }
+#else
+/*
+ * Dynamic number of breakpoint slots.
+ */
+static int __nr_bp_slots[TYPE_MAX] __ro_after_init;
+
+static inline int hw_breakpoint_slots_cached(int type)
+{
+	return __nr_bp_slots[type];
+}
+
+static __init int init_breakpoint_slots(void)
+{
+	int i, cpu, err_cpu;
+
+	for (i = 0; i < TYPE_MAX; i++)
+		__nr_bp_slots[i] = hw_breakpoint_slots(i);
+
+	for_each_possible_cpu(cpu) {
+		for (i = 0; i < TYPE_MAX; i++) {
+			struct bp_cpuinfo *info = get_bp_info(cpu, i);
+
+			info->tsk_pinned = kcalloc(__nr_bp_slots[i], sizeof(int), GFP_KERNEL);
+			if (!info->tsk_pinned)
+				goto err;
+		}
+	}
+
+	return 0;
+err:
+	for_each_possible_cpu(err_cpu) {
+		for (i = 0; i < TYPE_MAX; i++)
+			kfree(get_bp_info(err_cpu, i)->tsk_pinned);
+		if (err_cpu == cpu)
+			break;
+	}
+
+	return -ENOMEM;
+}
+#endif
+
 __weak int hw_breakpoint_weight(struct perf_event *bp)
 {
 	return 1;
@@ -95,7 +146,7 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
 	unsigned int *tsk_pinned = get_bp_info(cpu, type)->tsk_pinned;
 	int i;
 
-	for (i = nr_slots[type] - 1; i >= 0; i--) {
+	for (i = hw_breakpoint_slots_cached(type) - 1; i >= 0; i--) {
 		if (tsk_pinned[i] > 0)
 			return i + 1;
 	}
@@ -312,7 +363,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 	fetch_this_slot(&slots, weight);
 
 	/* Flexible counters need to keep at least one slot */
-	if (slots.pinned + (!!slots.flexible) > nr_slots[type])
+	if (slots.pinned + (!!slots.flexible) > hw_breakpoint_slots_cached(type))
 		return -ENOSPC;
 
 	ret = arch_reserve_bp_slot(bp);
@@ -632,7 +683,7 @@ bool hw_breakpoint_is_used(void)
 			if (info->cpu_pinned)
 				return true;
 
-			for (int slot = 0; slot < nr_slots[type]; ++slot) {
+			for (int slot = 0; slot < hw_breakpoint_slots_cached(type); ++slot) {
 				if (info->tsk_pinned[slot])
 					return true;
 			}
@@ -716,42 +767,19 @@ static struct pmu perf_breakpoint = {
 
 int __init init_hw_breakpoint(void)
 {
-	int cpu, err_cpu;
-	int i, ret;
-
-	for (i = 0; i < TYPE_MAX; i++)
-		nr_slots[i] = hw_breakpoint_slots(i);
-
-	for_each_possible_cpu(cpu) {
-		for (i = 0; i < TYPE_MAX; i++) {
-			struct bp_cpuinfo *info = get_bp_info(cpu, i);
-
-			info->tsk_pinned = kcalloc(nr_slots[i], sizeof(int),
-							GFP_KERNEL);
-			if (!info->tsk_pinned) {
-				ret = -ENOMEM;
-				goto err;
-			}
-		}
-	}
+	int ret;
 
 	ret = rhltable_init(&task_bps_ht, &task_bps_ht_params);
 	if (ret)
-		goto err;
+		return ret;
+
+	ret = init_breakpoint_slots();
+	if (ret)
+		return ret;
 
 	constraints_initialized = true;
 
 	perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
 
 	return register_die_notifier(&hw_breakpoint_exceptions_nb);
-
-err:
-	for_each_possible_cpu(err_cpu) {
-		for (i = 0; i < TYPE_MAX; i++)
-			kfree(get_bp_info(err_cpu, i)->tsk_pinned);
-		if (err_cpu == cpu)
-			break;
-	}
-
-	return ret;
 }
