Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE6A51559F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380744AbiD2UcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380719AbiD2UcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:32:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD87AFADA;
        Fri, 29 Apr 2022 13:28:52 -0700 (PDT)
Date:   Fri, 29 Apr 2022 20:28:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651264130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjOxnH0zAjk67XJJbJcjaklABTIfx8InMxQItIWdhSw=;
        b=g/6CfoK4nbr+O9PzrI+yUyo/DRk6SgHKlXCsx+Wv15VaMwM26o+lPxoBUEOQIwiHY0oDbd
        TTnj1uEXichsvbbBDgiHmhS7JPkySJXdke1tkcf5XrD8w6pP5PAi13XbEZZP1kvZHYEYat
        Wrnzs0tHtUlOOWqWSKf/h2JkSb87dkOEhdk0mmdj5Bf+Xk9mlqtFZx7iku504PGEixJLqr
        BwKZEw8+XfgNpb7WhJkr7+AVUsqFjmbMJaAx6jZi/6B7CgtHCCfEqta+o9T9HQdrR7O4TC
        h7+w14/CbgnRm69CdkRJ9mMJfhNeSMYgzB59MCpwb3u9luvUf0GooF28xI74TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651264130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjOxnH0zAjk67XJJbJcjaklABTIfx8InMxQItIWdhSw=;
        b=rCq82cjQOzp6mcZf9d1u8ESAchZnu+JDMxKz0mOupweWwM+dvHYcQPVEYgMoYUYy73Ggm6
        n9isYmMLLm55oeBQ==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/core: Add PerfMonV2 overflow handling
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf20b7e4da0b0a83bdbe05857f354146623bc63ab=2E16505?=
 =?utf-8?q?15382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cf20b7e4da0b0a83bdbe05857f354146623bc63ab=2E165051?=
 =?utf-8?q?5382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165126412930.4207.4180559415237628086.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     28e19f88827caeca1e61aae9a8a46882ef34988f
Gitweb:        https://git.kernel.org/tip/28e19f88827caeca1e61aae9a8a46882ef34988f
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 21 Apr 2022 11:16:58 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Apr 2022 11:06:27 +02:00

perf/x86/amd/core: Add PerfMonV2 overflow handling

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, use a new scheme to process Core PMC overflows
in the NMI handler using the new global control and status
registers. This will be bypassed on unsupported hardware
(x86_pmu.version < 2).

In x86_pmu_handle_irq(), overflows are detected by testing
the contents of the PERF_CTR register for each active PMC in
a loop. The new scheme instead inspects the overflow bits of
the global status register.

The Performance Counter Global Status (PerfCntrGlobalStatus)
register has overflow (PerfCntrOvfl) bits for each PMC. This
is, however, a read-only MSR. To acknowledge that overflows
have been processed, the NMI handler must clear the bits by
writing to the PerfCntrGlobalStatusClr register.

In x86_pmu_handle_irq(), PMCs counting the same event that
are started and stopped at the same time record slightly
different counts due to delays in between reads from the
PERF_CTR registers. This is fixed by stopping and starting
the PMCs at the same before and with a single write to the
Performance Counter Global Control (PerfCntrGlobalCtl) upon
entering and before exiting the NMI handler.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/f20b7e4da0b0a83bdbe05857f354146623bc63ab.1650515382.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 144 +++++++++++++++++++++++++++++++++---
 1 file changed, 133 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index a339c3e..262e39a 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <asm/apicdef.h>
+#include <asm/apic.h>
 #include <asm/nmi.h>
 
 #include "../perf_event.h"
@@ -669,6 +670,45 @@ static inline void amd_pmu_set_global_ctl(u64 ctl)
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
 }
 
+static inline u64 amd_pmu_get_global_status(void)
+{
+	u64 status;
+
+	/* PerfCntrGlobalStatus is read-only */
+	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
+
+	return status & amd_pmu_global_cntr_mask;
+}
+
+static inline void amd_pmu_ack_global_status(u64 status)
+{
+	/*
+	 * PerfCntrGlobalStatus is read-only but an overflow acknowledgment
+	 * mechanism exists; writing 1 to a bit in PerfCntrGlobalStatusClr
+	 * clears the same bit in PerfCntrGlobalStatus
+	 */
+
+	/* Only allow modifications to PerfCntrGlobalStatus.PerfCntrOvfl */
+	status &= amd_pmu_global_cntr_mask;
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, status);
+}
+
+static bool amd_pmu_test_overflow_topbit(int idx)
+{
+	u64 counter;
+
+	rdmsrl(x86_pmu_event_addr(idx), counter);
+
+	return !(counter & BIT_ULL(x86_pmu.cntval_bits - 1));
+}
+
+static bool amd_pmu_test_overflow_status(int idx)
+{
+	return amd_pmu_get_global_status() & BIT_ULL(idx);
+}
+
+DEFINE_STATIC_CALL(amd_pmu_test_overflow, amd_pmu_test_overflow_topbit);
+
 /*
  * When a PMC counter overflows, an NMI is used to process the event and
  * reset the counter. NMI latency can result in the counter being updated
@@ -681,7 +721,6 @@ static inline void amd_pmu_set_global_ctl(u64 ctl)
 static void amd_pmu_wait_on_overflow(int idx)
 {
 	unsigned int i;
-	u64 counter;
 
 	/*
 	 * Wait for the counter to be reset if it has overflowed. This loop
@@ -689,8 +728,7 @@ static void amd_pmu_wait_on_overflow(int idx)
 	 * forever...
 	 */
 	for (i = 0; i < OVERFLOW_WAIT_COUNT; i++) {
-		rdmsrl(x86_pmu_event_addr(idx), counter);
-		if (counter & (1ULL << (x86_pmu.cntval_bits - 1)))
+		if (!static_call(amd_pmu_test_overflow)(idx))
 			break;
 
 		/* Might be in IRQ context, so can't sleep */
@@ -830,6 +868,24 @@ static void amd_pmu_del_event(struct perf_event *event)
  * handled a counter. When an un-handled NMI is received, it will be claimed
  * only if arriving within that window.
  */
+static inline int amd_pmu_adjust_nmi_window(int handled)
+{
+	/*
+	 * If a counter was handled, record a timestamp such that un-handled
+	 * NMIs will be claimed if arriving within that window.
+	 */
+	if (handled) {
+		this_cpu_write(perf_nmi_tstamp, jiffies + perf_nmi_window);
+
+		return handled;
+	}
+
+	if (time_after(jiffies, this_cpu_read(perf_nmi_tstamp)))
+		return NMI_DONE;
+
+	return NMI_HANDLED;
+}
+
 static int amd_pmu_handle_irq(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -857,20 +913,84 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	if (pmu_enabled)
 		amd_pmu_enable_all(0);
 
+	return amd_pmu_adjust_nmi_window(handled);
+}
+
+static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_sample_data data;
+	struct hw_perf_event *hwc;
+	struct perf_event *event;
+	int handled = 0, idx;
+	u64 status, mask;
+	bool pmu_enabled;
+
 	/*
-	 * If a counter was handled, record a timestamp such that un-handled
-	 * NMIs will be claimed if arriving within that window.
+	 * Save the PMU state as it needs to be restored when leaving the
+	 * handler
 	 */
-	if (handled) {
-		this_cpu_write(perf_nmi_tstamp, jiffies + perf_nmi_window);
+	pmu_enabled = cpuc->enabled;
+	cpuc->enabled = 0;
 
-		return handled;
+	/* Stop counting */
+	amd_pmu_v2_disable_all();
+
+	status = amd_pmu_get_global_status();
+
+	/* Check if any overflows are pending */
+	if (!status)
+		goto done;
+
+	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+		if (!test_bit(idx, cpuc->active_mask))
+			continue;
+
+		event = cpuc->events[idx];
+		hwc = &event->hw;
+		x86_perf_event_update(event);
+		mask = BIT_ULL(idx);
+
+		if (!(status & mask))
+			continue;
+
+		/* Event overflow */
+		handled++;
+		perf_sample_data_init(&data, 0, hwc->last_period);
+
+		if (!x86_perf_event_set_period(event))
+			continue;
+
+		if (perf_event_overflow(event, &data, regs))
+			x86_pmu_stop(event, 0);
+
+		status &= ~mask;
 	}
 
-	if (time_after(jiffies, this_cpu_read(perf_nmi_tstamp)))
-		return NMI_DONE;
+	/*
+	 * It should never be the case that some overflows are not handled as
+	 * the corresponding PMCs are expected to be inactive according to the
+	 * active_mask
+	 */
+	WARN_ON(status > 0);
 
-	return NMI_HANDLED;
+	/* Clear overflow bits */
+	amd_pmu_ack_global_status(~status);
+
+	/*
+	 * Unmasking the LVTPC is not required as the Mask (M) bit of the LVT
+	 * PMI entry is not set by the local APIC when a PMC overflow occurs
+	 */
+	inc_irq_stat(apic_perf_irqs);
+
+done:
+	cpuc->enabled = pmu_enabled;
+
+	/* Resume counting only if PMU is active */
+	if (pmu_enabled)
+		amd_pmu_v2_enable_all(0);
+
+	return amd_pmu_adjust_nmi_window(handled);
 }
 
 static struct event_constraint *
@@ -1256,6 +1376,8 @@ static int __init amd_core_pmu_init(void)
 		x86_pmu.enable_all = amd_pmu_v2_enable_all;
 		x86_pmu.disable_all = amd_pmu_v2_disable_all;
 		x86_pmu.enable = amd_pmu_v2_enable_event;
+		x86_pmu.handle_irq = amd_pmu_v2_handle_irq;
+		static_call_update(amd_pmu_test_overflow, amd_pmu_test_overflow_status);
 	}
 
 	/*
