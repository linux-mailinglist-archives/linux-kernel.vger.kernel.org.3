Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5B852355D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244589AbiEKOZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244560AbiEKOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:25:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F9F633A0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=69XAIoGDwel9FBx285nF3+WxoH4y8KYpY4nBuO7IJh8=; b=Ih99V/BJlIdC9sEbXKvAS+KVKa
        niWZ3kd8r8UynTXMsHglgGBNYaVYw0KfvDk0n4WrpYbZM0tCJhgs4B3M8lbeGXmB0nW8sBqCaNwRO
        sJfJEXF6/hHt5MninTZuIX/eRvfoXmGC6yLDfVGcjERDhNvyoSBlBCo6aRkRKH3grZoGN07X5pTNc
        oHgjfoh8+xtW7NvS8b4gfudf9+mq875JSCiRxqzOIVKrM3OHqOUNxDciXzynLrph8o2+HDoToy57r
        aqTMnbh0F9ppSjqXb5VR/382NHAmqQ2g+IWxmCcrEVX4oJkv27pKtTfYWtF1dhMLMgublJ2BY+5Py
        LXA2d6BQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nonH5-00DBu5-0m; Wed, 11 May 2022 14:25:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37B993005B9;
        Wed, 11 May 2022 16:25:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 224C4201E6488; Wed, 11 May 2022 16:25:09 +0200 (CEST)
Message-ID: <20220511142345.146224050@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 11 May 2022 16:20:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH 2/5] perf/x86: Add two more x86_pmu methods
References: <20220511142037.353492804@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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


