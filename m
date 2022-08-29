Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E25A46EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiH2KPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiH2KOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:14:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C5426EA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=6ox9SsphMCojor9sb9ByAEKufXYN5OOq6Tkw9aA9+6M=; b=Xes8KpCX74mlxgfducWVp2+rUQ
        6YW8fFvyNktPbnwcG3c+91k/RMRUPa75MCjWRNC1g8R7rG76/m8sTGwomxL/ns28tJtah7NE8Q+jW
        CTDa1G9YFBXXogi9fpEntBpPBda5z9Ung7pUjPpx43DOCqNDMUxlUclWyTd40Y8nPN8w3vewEtENN
        C4DruyRoyyo2YkdJpwzAASqTylgQMEr+6x6Zim53/D9TKl+kh/E1tIGyzTCLJW8rjNlSTpKABMn0D
        x1NwtUCZDmuEmqT2G0Yy70Hs3fVcuflkRFya2AT9fdvT6zNzLVP20jqVQr38Rk2sVWOLYLtrc5I2E
        UAbMlFhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSbn1-00304r-3m; Mon, 29 Aug 2022 10:14:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A80A30034E;
        Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7066F20180FA7; Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Message-ID: <20220829101321.505933457@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Aug 2022 12:10:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com,
        ravi.bangoria@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH v2 2/9] perf/x86/intel: Move the topdown stuff into the intel driver
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

Use the new x86_pmu::{set_period,update}() methods to push the topdown
stuff into the Intel driver, where it belongs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c       |    7 -------
 arch/x86/events/intel/core.c |   28 +++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 10 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -119,9 +119,6 @@ u64 x86_perf_event_update(struct perf_ev
 	if (unlikely(!hwc->event_base))
 		return 0;
 
-	if (unlikely(is_topdown_count(event)) && x86_pmu.update_topdown_event)
-		return x86_pmu.update_topdown_event(event);
-
 	/*
 	 * Careful: an NMI might modify the previous event value.
 	 *
@@ -1373,10 +1370,6 @@ int x86_perf_event_set_period(struct per
 	if (unlikely(!hwc->event_base))
 		return 0;
 
-	if (unlikely(is_topdown_count(event)) &&
-	    x86_pmu.set_topdown_event_period)
-		return x86_pmu.set_topdown_event_period(event);
-
 	/*
 	 * If we are way outside a reasonable range then just skip forward:
 	 */
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2301,7 +2301,7 @@ static void intel_pmu_nhm_workaround(voi
 	for (i = 0; i < 4; i++) {
 		event = cpuc->events[i];
 		if (event)
-			x86_perf_event_update(event);
+			static_call(x86_pmu_update)(event);
 	}
 
 	for (i = 0; i < 4; i++) {
@@ -2316,7 +2316,7 @@ static void intel_pmu_nhm_workaround(voi
 		event = cpuc->events[i];
 
 		if (event) {
-			x86_perf_event_set_period(event);
+			static_call(x86_pmu_set_period)(event);
 			__x86_pmu_enable_event(&event->hw,
 					ARCH_PERFMON_EVENTSEL_ENABLE);
 		} else
@@ -2793,7 +2793,7 @@ static void intel_pmu_add_event(struct p
  */
 int intel_pmu_save_and_restart(struct perf_event *event)
 {
-	x86_perf_event_update(event);
+	static_call(x86_pmu_update)(event);
 	/*
 	 * For a checkpointed counter always reset back to 0.  This
 	 * avoids a situation where the counter overflows, aborts the
@@ -2805,9 +2805,27 @@ int intel_pmu_save_and_restart(struct pe
 		wrmsrl(event->hw.event_base, 0);
 		local64_set(&event->hw.prev_count, 0);
 	}
+	return static_call(x86_pmu_set_period)(event);
+}
+
+static int intel_pmu_set_period(struct perf_event *event)
+{
+	if (unlikely(is_topdown_count(event)) &&
+	    x86_pmu.set_topdown_event_period)
+		return x86_pmu.set_topdown_event_period(event);
+
 	return x86_perf_event_set_period(event);
 }
 
+static u64 intel_pmu_update(struct perf_event *event)
+{
+	if (unlikely(is_topdown_count(event)) &&
+	    x86_pmu.update_topdown_event)
+		return x86_pmu.update_topdown_event(event);
+
+	return x86_perf_event_update(event);
+}
+
 static void intel_pmu_reset(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
@@ -4635,6 +4653,10 @@ static __initconst const struct x86_pmu
 	.enable_all		= core_pmu_enable_all,
 	.enable			= core_pmu_enable_event,
 	.disable		= x86_pmu_disable_event,
+
+	.set_period		= intel_pmu_set_period,
+	.update			= intel_pmu_update,
+
 	.hw_config		= core_pmu_hw_config,
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,


