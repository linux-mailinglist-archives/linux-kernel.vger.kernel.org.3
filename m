Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9A75A46F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiH2KPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiH2KPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:15:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C2765F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OQAAMSjRHuYgCLVl5R9t0nt04B2gvVrpsDsjFaKL1VI=; b=GoW94x/AMI1g98fioJPJuyHJF1
        KdxLLlUDJNiygWcb/xx2+hyr/PLqQ3xsiFpfbmK9R7ThxZTqfcRXrRdieG7DuaHAiUk0j0F9uus7E
        vGvIhj0nksX3GdH9NQeJUiTzaOlq+xvTt0f1yi1KKoKSIjGh0WMER0bdwAmpxiQ3htRkz30vyXxX4
        Bekf/iMdZh7hE7f8VuxvTJcm5UrNn32qKmkCx0LHWnxTuCCDIRZFQg3dWtYH784xuqFpQuEjXGEjB
        HQVQ/qLIqgyObVExFXCnOVxIkkt/vlv3POQBrMEZMawZ4haAI/fCaDXFQ+3EwhJMgc+Et+J3/S4wt
        YP6tW28w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSbn1-007SzK-J5; Mon, 29 Aug 2022 10:14:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D504B3006C4;
        Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A48CD207F7FB4; Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Message-ID: <20220829101321.971473694@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Aug 2022 12:10:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com,
        ravi.bangoria@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH v2 9/9] perf/x86/intel: Optimize short PEBS counters
References: <20220829100959.917169441@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XXX: crazy idea; really not sure this is worth the extra complexity

It is possible to have the counter programmed to a value smaller than
the sampling period. In that case, the code suppresses the sample,
recalculates the remaining events and reprograms the counter.

This should also work for PEBS counters (and it does); however
triggering a full PEBS assist and parsing the event from the DS is
more overhead than is required.

As such, detect this case and temporarily suppress PEBS. This will
then trigger a regular PMI for the counter which will reprogram the
event and re-enable PEBS once the target period is in reach.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c |   80 ++++++++++++++++++++++++++++++++++++++-----
 arch/x86/events/perf_event.h |    9 ++++
 2 files changed, 81 insertions(+), 8 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2722,12 +2722,7 @@ static void intel_pmu_enable_fixed(struc
 
 	intel_set_masks(event, idx);
 
-	/*
-	 * Enable IRQ generation (0x8), if not PEBS,
-	 * and enable ring-3 counting (0x2) and ring-0 counting (0x1)
-	 * if requested:
-	 */
-	if (!event->attr.precise_ip)
+	if (hwc->config & ARCH_PERFMON_EVENTSEL_INT)
 		bits |= 0x8;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_USR)
 		bits |= 0x2;
@@ -2816,12 +2811,75 @@ int intel_pmu_save_and_restart(struct pe
 	return static_call(x86_pmu_set_period)(event);
 }
 
+static void intel_pmu_update_config(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 config = hwc->config;
+
+	if (hwc->idx >= INTEL_PMC_IDX_FIXED) { /* PEBS is limited to real PMCs */
+		u64 mask = 0xf, bits = 0;
+
+		if (config & ARCH_PERFMON_EVENTSEL_INT)
+			bits |= 0x8;
+		if (config & ARCH_PERFMON_EVENTSEL_USR)
+			bits |= 0x2;
+		if (config & ARCH_PERFMON_EVENTSEL_OS)
+			bits |= 0x1;
+
+		bits <<= (hwc->idx * 4);
+		mask <<= (hwc->idx * 4);
+
+		config = this_cpu_read(intel_fixed_ctrl);
+		config &= ~mask;
+		config |= bits;
+		this_cpu_write(intel_fixed_ctrl, config);
+	}
+
+	wrmsrl(hwc->config_base, config);
+}
+
+static void intel_pmu_handle_short_pebs(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* if the event is not enabled; intel_pmu_pebs_enable() DTRT */
+	if (!test_bit(hwc->idx, cpuc->active_mask))
+		return;
+
+	WARN_ON_ONCE(cpuc->enabled);
+
+	if (intel_pmu_is_short_pebs(event)) {
+
+		/* stripped down intel_pmu_pebs_disable() */
+		cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
+		hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
+
+		intel_pmu_update_config(event);
+
+	} else if (!(cpuc->pebs_enabled & (1ULL << hwc->idx))) {
+
+		/* stripped down intel_pmu_pebs_enable() */
+		hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
+		cpuc->pebs_enabled |= (1ULL << hwc->idx);
+
+		intel_pmu_update_config(event);
+	}
+}
+
 static int intel_pmu_set_period(struct perf_event *event)
 {
+	int ret;
+
 	if (unlikely(is_topdown_count(event)))
 		return static_call(intel_pmu_set_topdown_event_period)(event);
 
-	return x86_perf_event_set_period(event);
+	ret = x86_perf_event_set_period(event);
+
+	if (event->attr.precise_ip)
+		intel_pmu_handle_short_pebs(event);
+
+	return ret;
 }
 
 static u64 intel_pmu_update(struct perf_event *event)
@@ -2975,6 +3033,9 @@ static int handle_pmi_common(struct pt_r
 		 * MSR_IA32_PEBS_ENABLE is not updated. Because the
 		 * cpuc->enabled has been forced to 0 in PMI.
 		 * Update the MSR if pebs_enabled is changed.
+		 *
+		 * Also; short counters temporarily disable PEBS, see
+		 * intel_pmu_set_period().
 		 */
 		if (pebs_enabled != cpuc->pebs_enabled)
 			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
@@ -3856,7 +3917,10 @@ static int intel_pmu_hw_config(struct pe
 		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
 			return -EINVAL;
 
-		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
+		if (!(event->attr.freq ||
+		      (event->attr.wakeup_events && !event->attr.watermark) ||
+		      event->attr.sample_period > x86_pmu.max_period)) {
+
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
 			      ~intel_pmu_large_pebs_flags(event))) {
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1063,6 +1063,15 @@ static inline bool x86_pmu_has_lbr_calls
 DECLARE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 DECLARE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
 
+static inline bool intel_pmu_is_short_pebs(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	s64 counter = this_cpu_read(pmc_prev_left[hwc->idx]);
+	s64 left = local64_read(&hwc->period_left);
+
+	return counter < left;
+}
+
 int x86_perf_event_set_period(struct perf_event *event);
 
 /*


