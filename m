Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EB95A46EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiH2KPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiH2KOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:14:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F9126F7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cjwMj5/XK3Arj3+DPDxgPLyq06v8ipOyphQTAJ1oEvk=; b=J9FKQjfLSa3gkKEh5/6FMIOwYh
        olQqOGNnjxr0fBB1tSswORAa+uMxiqB7kQnBWK1iO119KCY9W2l29Ipz5bNv65Nrj6mT0COVg9mNW
        2UvMW282KntYrhZ7W5MGkzXEvwIvM1Wo0DIT79Y03O3QSJDKZUC4Wc/WKzdGnJoCGrMf2BvNFf3TJ
        B5zqtfTZUIqcD8aetotki/FzeU4klgBZ/oluJi2OaV0eECddys/toZt9m4PLYbycmFy2g69YhtIa6
        ALzomFgRK2QmF6vM/FJCiuq8nx87KqUK+EqhoXUlBebku72rJivkOObQKwU5cYjCXftlesV4Oa48A
        6hpJv0sQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSbn1-003053-Nd; Mon, 29 Aug 2022 10:14:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D505B300750;
        Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8FB9F207296FB; Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Message-ID: <20220829101321.839502514@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Aug 2022 12:10:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com,
        ravi.bangoria@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH v2 7/9] perf/x86/p4: Remove perfctr_second_write quirk
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

Now that we have a x86_pmu::set_period() method, use it to remove the
perfctr_second_write quirk from the generic code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c       |   12 +-----------
 arch/x86/events/intel/p4.c   |   37 +++++++++++++++++++++++++++----------
 arch/x86/events/perf_event.h |    2 +-
 3 files changed, 29 insertions(+), 22 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1356,7 +1356,7 @@ static void x86_pmu_enable(struct pmu *p
 	static_call(x86_pmu_enable_all)(added);
 }
 
-static DEFINE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
+DEFINE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
 
 /*
  * Set the next IRQ period, based on the hwc->period_left value.
@@ -1416,16 +1416,6 @@ int x86_perf_event_set_period(struct per
 	if (is_counter_pair(hwc))
 		wrmsrl(x86_pmu_event_addr(idx + 1), 0xffff);
 
-	/*
-	 * Due to erratum on certan cpu we need
-	 * a second write to be sure the register
-	 * is updated properly
-	 */
-	if (x86_pmu.perfctr_second_write) {
-		wrmsrl(hwc->event_base,
-			(u64)(-left) & x86_pmu.cntval_mask);
-	}
-
 	perf_event_update_userpage(event);
 
 	return ret;
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1006,6 +1006,29 @@ static void p4_pmu_enable_all(int added)
 	}
 }
 
+static int p4_pmu_set_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	s64 left = this_cpu_read(pmc_prev_left[hwc->idx]);
+	int ret;
+
+	ret = x86_perf_event_set_period(event);
+
+	if (hwc->event_base) {
+		/*
+		 * This handles erratum N15 in intel doc 249199-029,
+		 * the counter may not be updated correctly on write
+		 * so we need a second write operation to do the trick
+		 * (the official workaround didn't work)
+		 *
+		 * the former idea is taken from OProfile code
+		 */
+		wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
+	}
+
+	return ret;
+}
+
 static int p4_pmu_handle_irq(struct pt_regs *regs)
 {
 	struct perf_sample_data data;
@@ -1044,7 +1067,7 @@ static int p4_pmu_handle_irq(struct pt_r
 		/* event overflow for sure */
 		perf_sample_data_init(&data, 0, hwc->last_period);
 
-		if (!x86_perf_event_set_period(event))
+		if (!static_call(x86_pmu_set_period)(event))
 			continue;
 
 
@@ -1316,6 +1339,9 @@ static __initconst const struct x86_pmu
 	.enable_all		= p4_pmu_enable_all,
 	.enable			= p4_pmu_enable_event,
 	.disable		= p4_pmu_disable_event,
+
+	.set_period		= p4_pmu_set_period,
+
 	.eventsel		= MSR_P4_BPU_CCCR0,
 	.perfctr		= MSR_P4_BPU_PERFCTR0,
 	.event_map		= p4_pmu_event_map,
@@ -1334,15 +1360,6 @@ static __initconst const struct x86_pmu
 	.max_period		= (1ULL << (ARCH_P4_CNTRVAL_BITS - 1)) - 1,
 	.hw_config		= p4_hw_config,
 	.schedule_events	= p4_pmu_schedule_events,
-	/*
-	 * This handles erratum N15 in intel doc 249199-029,
-	 * the counter may not be updated correctly on write
-	 * so we need a second write operation to do the trick
-	 * (the official workaround didn't work)
-	 *
-	 * the former idea is taken from OProfile code
-	 */
-	.perfctr_second_write	= 1,
 
 	.format_attrs		= intel_p4_formats_attr,
 };
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -772,7 +772,6 @@ struct x86_pmu {
 
 	struct event_constraint *event_constraints;
 	struct x86_pmu_quirk *quirks;
-	int		perfctr_second_write;
 	void		(*limit_period)(struct perf_event *event, s64 *l);
 
 	/* PMI handler bits */
@@ -1049,6 +1048,7 @@ static inline bool x86_pmu_has_lbr_calls
 }
 
 DECLARE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
+DECLARE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
 
 int x86_perf_event_set_period(struct perf_event *event);
 


