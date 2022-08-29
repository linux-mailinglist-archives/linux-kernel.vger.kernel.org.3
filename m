Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D300F5A46ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiH2KPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiH2KO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:14:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3671327
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=69XAIoGDwel9FBx285nF3+WxoH4y8KYpY4nBuO7IJh8=; b=GhXLVXKnL7l+3MH9wBD/NYWhEn
        zu9los2vnQFOrquulJccyn0yUSmujtV8CQI3FJINzMpNcKfYd2v3KUaqBP2FMUnuz7IFU4rQ4KF4e
        vmGnDBsI77Nv6lUw/ZIyE3ZyLd04qD5PX0NDkZWChxvAfedovn21p4fv5QJM/OfClVgL4gQWv5fQ0
        +xMYi9/CMvZQ/TBeIEC65iV/0SmDutQJkx8q68XIpEizwH76MfPkVVw9zkSiT53m1qk1pU8cFCmHc
        Rd2f0CDeAvUz2Y8y96RbZ03jazj6R8OrspQD8SmQdElkGY4uX1caIdOYK6gDtJHOazhHrNSde6wJT
        wm9jZUdw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSbn1-00304t-5k; Mon, 29 Aug 2022 10:14:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 830DF300137;
        Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6E3FA20099A4D; Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Message-ID: <20220829101321.440196408@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Aug 2022 12:10:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com,
        ravi.bangoria@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH v2 1/9] perf/x86: Add two more x86_pmu methods
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

In order to clean up x86_perf_event_{set_period,update)() start by
adding them as x86_pmu methods.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c       |   22 +++++++++++++++++-----
 arch/x86/events/perf_event.h |    5 +++++
 2 files changed, 22 insertions(+), 5 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -72,6 +72,9 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_add,  *x
 DEFINE_STATIC_CALL_NULL(x86_pmu_del,  *x86_pmu.del);
 DEFINE_STATIC_CALL_NULL(x86_pmu_read, *x86_pmu.read);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_set_period, *x86_pmu.set_period);
+DEFINE_STATIC_CALL_NULL(x86_pmu_update,     *x86_pmu.update);
+
 DEFINE_STATIC_CALL_NULL(x86_pmu_schedule_events,       *x86_pmu.schedule_events);
 DEFINE_STATIC_CALL_NULL(x86_pmu_get_event_constraints, *x86_pmu.get_event_constraints);
 DEFINE_STATIC_CALL_NULL(x86_pmu_put_event_constraints, *x86_pmu.put_event_constraints);
@@ -1518,7 +1521,7 @@ static void x86_pmu_start(struct perf_ev
 
 	if (flags & PERF_EF_RELOAD) {
 		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
-		x86_perf_event_set_period(event);
+		static_call(x86_pmu_set_period)(event);
 	}
 
 	event->hw.state = 0;
@@ -1610,7 +1613,7 @@ void x86_pmu_stop(struct perf_event *eve
 		 * Drain the remaining delta count out of a event
 		 * that we are disabling:
 		 */
-		x86_perf_event_update(event);
+		static_call(x86_pmu_update)(event);
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 }
@@ -1700,7 +1703,7 @@ int x86_pmu_handle_irq(struct pt_regs *r
 
 		event = cpuc->events[idx];
 
-		val = x86_perf_event_update(event);
+		val = static_call(x86_pmu_update)(event);
 		if (val & (1ULL << (x86_pmu.cntval_bits - 1)))
 			continue;
 
@@ -1709,7 +1712,7 @@ int x86_pmu_handle_irq(struct pt_regs *r
 		 */
 		handled++;
 
-		if (!x86_perf_event_set_period(event))
+		if (!static_call(x86_pmu_set_period)(event))
 			continue;
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
@@ -2023,6 +2026,9 @@ static void x86_pmu_static_call_update(v
 	static_call_update(x86_pmu_del, x86_pmu.del);
 	static_call_update(x86_pmu_read, x86_pmu.read);
 
+	static_call_update(x86_pmu_set_period, x86_pmu.set_period);
+	static_call_update(x86_pmu_update, x86_pmu.update);
+
 	static_call_update(x86_pmu_schedule_events, x86_pmu.schedule_events);
 	static_call_update(x86_pmu_get_event_constraints, x86_pmu.get_event_constraints);
 	static_call_update(x86_pmu_put_event_constraints, x86_pmu.put_event_constraints);
@@ -2042,7 +2048,7 @@ static void x86_pmu_static_call_update(v
 
 static void _x86_pmu_read(struct perf_event *event)
 {
-	x86_perf_event_update(event);
+	static_call(x86_pmu_update)(event);
 }
 
 void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
@@ -2148,6 +2154,12 @@ static int __init init_hw_perf_events(vo
 	if (!x86_pmu.guest_get_msrs)
 		x86_pmu.guest_get_msrs = (void *)&__static_call_return0;
 
+	if (!x86_pmu.set_period)
+		x86_pmu.set_period = x86_perf_event_set_period;
+
+	if (!x86_pmu.update)
+		x86_pmu.update = x86_perf_event_update;
+
 	x86_pmu_static_call_update();
 
 	/*
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -735,6 +735,8 @@ struct x86_pmu {
 	void		(*add)(struct perf_event *);
 	void		(*del)(struct perf_event *);
 	void		(*read)(struct perf_event *event);
+	int		(*set_period)(struct perf_event *event);
+	u64		(*update)(struct perf_event *event);
 	int		(*hw_config)(struct perf_event *event);
 	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign);
 	unsigned	eventsel;
@@ -1031,6 +1033,9 @@ static struct perf_pmu_format_hybrid_att
 struct pmu *x86_get_pmu(unsigned int cpu);
 extern struct x86_pmu x86_pmu __read_mostly;
 
+DECLARE_STATIC_CALL(x86_pmu_set_period, *x86_pmu.set_period);
+DECLARE_STATIC_CALL(x86_pmu_update,     *x86_pmu.update);
+
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {
 	if (static_cpu_has(X86_FEATURE_ARCH_LBR))


