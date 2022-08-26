Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5F05A31ED
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345373AbiHZWR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345255AbiHZWQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:16:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B88E398C;
        Fri, 26 Aug 2022 15:16:09 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:16:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYngtAiVWZ7UkU/fBoSy+5RHsoIi4gN1oXf80FU+Yig=;
        b=3oqsgFZySdi49EFFLmQgSxw4g8Nv+LrEX6o6w+WdkJtCkZ3wNVPT1HFUI+IDSt1KrMGTE6
        IqlHYuSCbANbyF8KTRjUH0vq83jBuUtzYdgm+gU/H9tJGexObI9RE0fq7cDMZe411Osnd6
        OH+Ow3c6Ix6MqLoO/IInd/u8+MPUiCHM/qwcWR8hjFMNGr8LYJ/VgH+FIc49gvgOBkGUlm
        ITl+uBeQNmfZ/4fWpb/Fvmg95btF9oFfDuyS1nGH0XpNpRAmOmaWRLud6HmDh3Fx6vJeCY
        s5CIK3c0gqHdetDxSjXpjnPtic3Cao8JFV0wwYDydZQEsbI2MZ3exXeHCrf8FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYngtAiVWZ7UkU/fBoSy+5RHsoIi4gN1oXf80FU+Yig=;
        b=uE3GOeYAWEs97UKG0PaS4rc9rVmTZS7bLxm+u8sGqVGmhA6Nz6XiN4Sj7hLZlb1szD6Zwg
        n2HGBV+EAjxntXAw==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/lbr: Detect LbrExtV2 support
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cfc6e45378ada258f1bab79b0de6e05c393a8f1dd=2E16602?=
 =?utf-8?q?11399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cfc6e45378ada258f1bab79b0de6e05c393a8f1dd=2E166021?=
 =?utf-8?q?1399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <166155216558.401.17707340866788891367.tip-bot2@tip-bot2>
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

Commit-ID:     703fb765f48897214e3eb110f35dddec80682f60
Gitweb:        https://git.kernel.org/tip/703fb765f48897214e3eb110f35dddec80682f60
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 11 Aug 2022 17:59:53 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:43 +02:00

perf/x86/amd/lbr: Detect LbrExtV2 support

AMD Last Branch Record Extension Version 2 (LbrExtV2) is driven by Core PMC
overflows. It records recently taken branches up to the moment when the PMC
overflow occurs.

Detect the feature during PMU initialization and set the branch stack depth
using CPUID leaf 0x80000022 EBX.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/fc6e45378ada258f1bab79b0de6e05c393a8f1dd.1660211399.git.sandipan.das@amd.com
---
 arch/x86/events/amd/Makefile      |  2 +-
 arch/x86/events/amd/core.c        |  9 +++++----
 arch/x86/events/amd/lbr.c         | 21 +++++++++++++++++++++
 arch/x86/events/perf_event.h      |  2 ++
 arch/x86/include/asm/perf_event.h |  3 ++-
 5 files changed, 31 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/events/amd/lbr.c

diff --git a/arch/x86/events/amd/Makefile b/arch/x86/events/amd/Makefile
index b9f5d46..527d947 100644
--- a/arch/x86/events/amd/Makefile
+++ b/arch/x86/events/amd/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CPU_SUP_AMD)		+= core.o
+obj-$(CONFIG_CPU_SUP_AMD)		+= core.o lbr.o
 obj-$(CONFIG_PERF_EVENTS_AMD_BRS)	+= brs.o
 obj-$(CONFIG_PERF_EVENTS_AMD_POWER)	+= power.o
 obj-$(CONFIG_X86_LOCAL_APIC)		+= ibs.o
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index ef35207..a3aa67b 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1374,10 +1374,11 @@ static int __init amd_core_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_PAIR;
 	}
 
-	/*
-	 * BRS requires special event constraints and flushing on ctxsw.
-	 */
-	if (boot_cpu_data.x86 >= 0x19 && !amd_brs_init()) {
+	/* LBR and BRS are mutually exclusive features */
+	if (amd_pmu_lbr_init() && !amd_brs_init()) {
+		/*
+		 * BRS requires special event constraints and flushing on ctxsw.
+		 */
 		x86_pmu.get_event_constraints = amd_get_event_constraints_f19h;
 		x86_pmu.sched_task = amd_pmu_brs_sched_task;
 		x86_pmu.limit_period = amd_pmu_limit_period;
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
new file mode 100644
index 0000000..4e5b5d3
--- /dev/null
+++ b/arch/x86/events/amd/lbr.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/perf_event.h>
+#include <asm/perf_event.h>
+
+#include "../perf_event.h"
+
+__init int amd_pmu_lbr_init(void)
+{
+	union cpuid_0x80000022_ebx ebx;
+
+	if (x86_pmu.version < 2 || !boot_cpu_has(X86_FEATURE_AMD_LBR_V2))
+		return -EOPNOTSUPP;
+
+	/* Set number of entries */
+	ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
+	x86_pmu.lbr_nr = ebx.split.lbr_v2_stack_sz;
+
+	pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
+
+	return 0;
+}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5deb34e..82e8a6d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1232,6 +1232,8 @@ static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 
 int amd_pmu_init(void);
 
+int amd_pmu_lbr_init(void);
+
 #ifdef CONFIG_PERF_EVENTS_AMD_BRS
 
 #define AMD_FAM19H_BRS_EVENT 0xc4 /* RETIRED_TAKEN_BRANCH_INSTRUCTIONS */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index f6fc8dd..9ac46db 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -207,7 +207,8 @@ union cpuid_0x80000022_ebx {
 	struct {
 		/* Number of Core Performance Counters */
 		unsigned int	num_core_pmc:4;
-		unsigned int	reserved:6;
+		/* Number of available LBR Stack Entries */
+		unsigned int	lbr_v2_stack_sz:6;
 		/* Number of Data Fabric Counters */
 		unsigned int	num_df_pmc:6;
 	} split;
