Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83AA519B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347224AbiEDJ10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347125AbiEDJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:27:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420EF255BF;
        Wed,  4 May 2022 02:23:24 -0700 (PDT)
Date:   Wed, 04 May 2022 09:23:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651656202;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kz1QPqzXOM0cYVAx3B79d5D4n7/yR1WkuK5Z44yYHtQ=;
        b=rlw9ZmjaqRK1LDlRhMkhxZs9FzgtTk+7n7pZTTX2EJLJXGfYmg6LtwBqAMPTRfHiI5sVGX
        wydAOXsQOW1n2AtUwCJRmQrf75a7lc9zFWOdhRk1e4yJ8UNpfI4bO3cnCOkJNt9Ha1bmkC
        LfyOs+aujLwjLIyAYxP4pYRq+DVs2emr1wA4IUk+VEXs9mWRutzkbye+ZRpm9EI9NPp0/u
        1a7WNm7EB9J7u8Hon0too9+x0AzoMXpG60lbSwBLKBwHm25VZITNiTHtO4ILiXlZENYCql
        sQwplQaqCr8U4iRaJYWKfMpAPdfxFu+ZkDnfmrhS7CV4mTVqyC1xyNhIx3+uJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651656202;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kz1QPqzXOM0cYVAx3B79d5D4n7/yR1WkuK5Z44yYHtQ=;
        b=yBtuNdIJQLjNYKtErpUZvNt9SvduhoVif4aHLl6xMK0RLX/pj/DwmAW6ZbSAGSI7jM0kHL
        pYrwFvnhd2oo8XBA==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/core: Add PerfMonV2 counter control
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cdfe8e934074aaabc6ba748dfaccd0a77c974bb82=2E16505?=
 =?utf-8?q?15382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cdfe8e934074aaabc6ba748dfaccd0a77c974bb82=2E165051?=
 =?utf-8?q?5382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165165620180.4207.1345040590129398389.tip-bot2@tip-bot2>
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

Commit-ID:     9622e67e3980c01872490de0925e5c6c23247c94
Gitweb:        https://git.kernel.org/tip/9622e67e3980c01872490de0925e5c6c23247c94
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 21 Apr 2022 11:16:57 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 May 2022 11:18:27 +02:00

perf/x86/amd/core: Add PerfMonV2 counter control

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, use a new scheme to manage the Core PMCs using
the new global control and status registers. This will be
bypassed on unsupported hardware (x86_pmu.version < 2).

Currently, all PMCs have dedicated control (PERF_CTL) and
counter (PERF_CTR) registers. For a given PMC, the enable
(En) bit of its PERF_CTL register is used to start or stop
counting.

The Performance Counter Global Control (PerfCntrGlobalCtl)
register has enable (PerfCntrEn) bits for each PMC. For a
PMC to start counting, both PERF_CTL and PerfCntrGlobalCtl
enable bits must be set. If either of those are cleared,
the PMC stops counting.

In x86_pmu_{en,dis}able_all(), the PERF_CTL registers of
all active PMCs are written to in a loop. Ideally, PMCs
counting the same event that were started and stopped at
the same time should record the same counts. Due to delays
in between writes to the PERF_CTL registers across loop
iterations, the PMCs cannot be enabled or disabled at the
same instant and hence, record slightly different counts.
This is fixed by enabling or disabling all active PMCs at
the same time with a single write to the PerfCntrGlobalCtl
register.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/dfe8e934074aaabc6ba748dfaccd0a77c974bb82.1650515382.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 50 +++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 52fd794..a339c3e 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -664,6 +664,11 @@ static void amd_pmu_cpu_dead(int cpu)
 	amd_pmu_cpu_reset(cpu);
 }
 
+static inline void amd_pmu_set_global_ctl(u64 ctl)
+{
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
+}
+
 /*
  * When a PMC counter overflows, an NMI is used to process the event and
  * reset the counter. NMI latency can result in the counter being updated
@@ -693,15 +698,11 @@ static void amd_pmu_wait_on_overflow(int idx)
 	}
 }
 
-static void amd_pmu_disable_all(void)
+static void amd_pmu_check_overflow(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int idx;
 
-	amd_brs_disable_all();
-
-	x86_pmu_disable_all();
-
 	/*
 	 * This shouldn't be called from NMI context, but add a safeguard here
 	 * to return, since if we're in NMI context we can't wait for an NMI
@@ -748,6 +749,26 @@ static void amd_pmu_enable_all(int added)
 	}
 }
 
+static void amd_pmu_v2_enable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	/*
+	 * Testing cpu_hw_events.enabled should be skipped in this case unlike
+	 * in x86_pmu_enable_event().
+	 *
+	 * Since cpu_hw_events.enabled is set only after returning from
+	 * x86_pmu_start(), the PMCs must be programmed and kept ready.
+	 * Counting starts only after x86_pmu_enable_all() is called.
+	 */
+	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
+}
+
+static void amd_pmu_v2_enable_all(int added)
+{
+	amd_pmu_set_global_ctl(amd_pmu_global_cntr_mask);
+}
+
 static void amd_pmu_disable_event(struct perf_event *event)
 {
 	x86_pmu_disable_event(event);
@@ -765,6 +786,20 @@ static void amd_pmu_disable_event(struct perf_event *event)
 	amd_pmu_wait_on_overflow(event->hw.idx);
 }
 
+static void amd_pmu_disable_all(void)
+{
+	amd_brs_disable_all();
+	x86_pmu_disable_all();
+	amd_pmu_check_overflow();
+}
+
+static void amd_pmu_v2_disable_all(void)
+{
+	/* Disable all PMCs */
+	amd_pmu_set_global_ctl(0);
+	amd_pmu_check_overflow();
+}
+
 static void amd_pmu_add_event(struct perf_event *event)
 {
 	if (needs_branch_stack(event))
@@ -1216,6 +1251,11 @@ static int __init amd_core_pmu_init(void)
 		x86_pmu.num_counters = ebx.split.num_core_pmc;
 
 		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
+
+		/* Update PMC handling functions */
+		x86_pmu.enable_all = amd_pmu_v2_enable_all;
+		x86_pmu.disable_all = amd_pmu_v2_disable_all;
+		x86_pmu.enable = amd_pmu_v2_enable_event;
 	}
 
 	/*
