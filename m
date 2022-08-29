Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CAE5A46EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiH2KPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiH2KPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:15:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A197663
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=W4onxSZKhwfLLpxsFTRSf73IGco3HKn+5oDZh6sBf9A=; b=OfVrbhROQnbSrlhQeauPRWsn27
        l3k8QQuMPM3spyryd4rkdwJx7wc79vjcmq1NxYfBta/LqqGylGwsE6mOBhe5bjCkIzADBqd0P65gt
        S9p0/xiS2MRMBJEsQnQJG8E0as2zm3gjSCgS0Jd2KqiAORGKFghMm4I8vpa9HwGhoE31A2IOd+wOP
        EIHyh+jit0o7oyQvSv1aH/IQdma4AYCQtwlaxknYLiDh1V1rOw0avvtYRZ6ZdfLaldbMbI3JIHV66
        c0Hf9TzJ9gqEPddx7aQk6kBJ75jFS7bz9jvPSFp9aIN8ifT55x5u32VGqu4NsFZt0tQMJyHQLcb8X
        Gc1Ln08Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSbn1-007SzM-J2; Mon, 29 Aug 2022 10:14:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4F4F3005DB;
        Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 83D28207617BD; Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Message-ID: <20220829101321.771635301@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Aug 2022 12:10:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com,
        ravi.bangoria@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH v2 6/9] perf/x86/intel: Remove x86_pmu::update_topdown_event
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

Now that it is all internal to the intel driver, remove
x86_pmu::update_topdown_event.

Assumes that is_topdown_count(event) can only be true when the
hardware has topdown stuff and the function is set.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c |   22 ++++++++++++----------
 arch/x86/events/perf_event.h |    1 -
 2 files changed, 12 insertions(+), 11 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2672,6 +2672,7 @@ static u64 adl_update_topdown_event(stru
 	return icl_update_topdown_event(event);
 }
 
+DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
 
 static void intel_pmu_read_topdown_event(struct perf_event *event)
 {
@@ -2683,7 +2684,7 @@ static void intel_pmu_read_topdown_event
 		return;
 
 	perf_pmu_disable(event->pmu);
-	x86_pmu.update_topdown_event(event);
+	static_call(intel_pmu_update_topdown_event)(event);
 	perf_pmu_enable(event->pmu);
 }
 
@@ -2691,7 +2692,7 @@ static void intel_pmu_read_event(struct
 {
 	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
 		intel_pmu_auto_reload_read(event);
-	else if (is_topdown_count(event) && x86_pmu.update_topdown_event)
+	else if (is_topdown_count(event))
 		intel_pmu_read_topdown_event(event);
 	else
 		x86_perf_event_update(event);
@@ -2820,9 +2821,8 @@ static int intel_pmu_set_period(struct p
 
 static u64 intel_pmu_update(struct perf_event *event)
 {
-	if (unlikely(is_topdown_count(event)) &&
-	    x86_pmu.update_topdown_event)
-		return x86_pmu.update_topdown_event(event);
+	if (unlikely(is_topdown_count(event)))
+		return static_call(intel_pmu_update_topdown_event)(event);
 
 	return x86_perf_event_update(event);
 }
@@ -2950,8 +2950,7 @@ static int handle_pmi_common(struct pt_r
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned long *)&status)) {
 		handled++;
-		if (x86_pmu.update_topdown_event)
-			x86_pmu.update_topdown_event(NULL);
+		static_call(intel_pmu_update_topdown_event)(NULL);
 	}
 
 	/*
@@ -6191,7 +6190,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(pmem);
 		x86_pmu.num_topdown_events = 4;
-		x86_pmu.update_topdown_event = icl_update_topdown_event;
+		static_call_update(intel_pmu_update_topdown_event,
+				   &icl_update_topdown_event);
 		static_call_update(intel_pmu_set_topdown_event_period,
 				   &icl_set_topdown_event_period);
 		pr_cont("Icelake events, ");
@@ -6229,7 +6229,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(pmem);
 		x86_pmu.num_topdown_events = 8;
-		x86_pmu.update_topdown_event = icl_update_topdown_event;
+		static_call_update(intel_pmu_update_topdown_event,
+				   &icl_update_topdown_event);
 		static_call_update(intel_pmu_set_topdown_event_period,
 				   &icl_set_topdown_event_period);
 		pr_cont("Sapphire Rapids events, ");
@@ -6266,7 +6267,8 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_adl();
 		x86_pmu.pebs_latency_data = adl_latency_data_small;
 		x86_pmu.num_topdown_events = 8;
-		x86_pmu.update_topdown_event = adl_update_topdown_event;
+		static_call_update(intel_pmu_update_topdown_event,
+				   &adl_update_topdown_event);
 		static_call_update(intel_pmu_set_topdown_event_period,
 				   &adl_set_topdown_event_period);
 
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -889,7 +889,6 @@ struct x86_pmu {
 	 * Intel perf metrics
 	 */
 	int		num_topdown_events;
-	u64		(*update_topdown_event)(struct perf_event *event);
 
 	/*
 	 * perf task context (i.e. struct perf_event_context::task_ctx_data)


