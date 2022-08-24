Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9951059FDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiHXPGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbiHXPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:06:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE2C8C003
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C5zZpSROsAEjBXSTdYZODsv0la2OfM73GAkSkwQIiXo=; b=B2TSGZSBwDNbuQwEDUmQNtiCFF
        sYpzKiUzw5m5AfjCT8MRrXvR3mKbnc5epkmog0IgYy3A0d6Aq/4LbgKu/kt+ldieiha5e6aju5dDl
        Ht1pPigQ3KuG6tW0lUtYlgxv2ZkFPcCzVjJ2WwkV0Bm/fTtaCiCQTXbfTsMvmTFJUa+eCMMCoP8lc
        Niivxz8Wu8RPHps36oDAO9FVj/puHN/Dkz1XfsN8MNqCP1knQ7zib/F5FY+B56N1UNcQeGR1fd01b
        PyXqgg8vCoFi8/7TvHmf4C/+E/Zm8wPyDqPFiBnT4Pevl3fdLFIa2ByahiAbLOr287EN0NBolB0QN
        DRGcIHlg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQrws-005lDG-Vr; Wed, 24 Aug 2022 15:05:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F5D4980BE2; Wed, 24 Aug 2022 16:59:07 +0200 (CEST)
Date:   Wed, 24 Aug 2022 16:59:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com
Subject: Re: [RFC v2] perf: Rewrite core context handling
Message-ID: <YwY8u7gx6bO+RBcg@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YwYWUbVvSAYseDaO@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwYWUbVvSAYseDaO@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 02:15:13PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:
> >  void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu)
> >  {
> > -	struct perf_cpu_context *cpuctx;
> > +	/* XXX: Don't need this quirk anymore */
> > +	/*struct perf_cpu_context *cpuctx;
> >  
> >  	if (!pmu->pmu_cpu_context)
> >  		return;
> >  
> >  	cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
> > -	cpuctx->ctx.pmu = pmu;
> > +	cpuctx->ctx.pmu = pmu;*/
> >  }
> 
> Confirmed; my ADL seems to work fine without all that.

Additionally; this doesn't insta crash.

---
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1e6138..016072a89f8f 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1019,10 +1019,10 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
-static int armv8pmu_filter_match(struct perf_event *event)
+static bool armv8pmu_filter(struct pmu *pmu, int cpu)
 {
-	unsigned long evtype = event->hw.config_base & ARMV8_PMU_EVTYPE_EVENT;
-	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
+	struct arm_pmu *armpmu = to_arm_pmu(pmu);
+	return !cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus);
 }
 
 static void armv8pmu_reset(void *info)
@@ -1253,7 +1253,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->stop			= armv8pmu_stop;
 	cpu_pmu->reset			= armv8pmu_reset;
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
-	cpu_pmu->filter_match		= armv8pmu_filter_match;
+	cpu_pmu->filter			= armv8pmu_filter;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7a2d12ad6d1f..a8f1e38c66a7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -86,6 +86,8 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_swap_task_ctx, *x86_pmu.swap_task_ctx);
 DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
 DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_filter, *x86_pmu.filter);
+
 /*
  * This one is magic, it will get called even when PMU init fails (because
  * there is no PMU), in which case it should simply return NULL.
@@ -2038,6 +2040,7 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_pebs_aliases, x86_pmu.pebs_aliases);
 
 	static_call_update(x86_pmu_guest_get_msrs, x86_pmu.guest_get_msrs);
+	static_call_update(x86_pmu_filter, x86_pmu.filter);
 }
 
 static void _x86_pmu_read(struct perf_event *event)
@@ -2668,12 +2671,13 @@ static int x86_pmu_aux_output_match(struct perf_event *event)
 	return 0;
 }
 
-static int x86_pmu_filter_match(struct perf_event *event)
+static bool x86_pmu_filter(struct pmu *pmu, int cpu)
 {
-	if (x86_pmu.filter_match)
-		return x86_pmu.filter_match(event);
+	bool ret = false;
 
-	return 1;
+	static_call_cond(x86_pmu_filter)(pmu, cpu, &ret);
+
+	return ret;
 }
 
 static struct pmu pmu = {
@@ -2704,7 +2708,7 @@ static struct pmu pmu = {
 
 	.aux_output_match	= x86_pmu_aux_output_match,
 
-	.filter_match		= x86_pmu_filter_match,
+	.filter			= x86_pmu_filter,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 768771e5e4e9..40cebd9b90a1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4675,12 +4675,11 @@ static int intel_pmu_aux_output_match(struct perf_event *event)
 	return is_intel_pt_event(event);
 }
 
-static int intel_pmu_filter_match(struct perf_event *event)
+static void intel_pmu_filter(struct pmu *pmu, int cpu, bool *ret)
 {
-	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
-	unsigned int cpu = smp_processor_id();
+	struct x86_hybrid_pmu *hpmu = hybrid_pmu(pmu);
 
-	return cpumask_test_cpu(cpu, &pmu->supported_cpus);
+	*ret = !cpumask_test_cpu(cpu, &hpmu->supported_cpus);
 }
 
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
@@ -6348,7 +6347,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.update_topdown_event = adl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = adl_set_topdown_event_period;
 
-		x86_pmu.filter_match = intel_pmu_filter_match;
+		x86_pmu.filter = intel_pmu_filter;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
 		x86_pmu.limit_period = spr_limit_period;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 9c835ecb232e..b3ff55fc5794 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -924,7 +924,7 @@ struct x86_pmu {
 
 	int (*aux_output_match) (struct perf_event *event);
 
-	int (*filter_match)(struct perf_event *event);
+	void (*filter)(struct pmu *pmu, int cpu, bool *ret);
 	/*
 	 * Hybrid support
 	 *
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 0407a38b470a..0f9519874fde 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -99,7 +99,7 @@ struct arm_pmu {
 	void		(*stop)(struct arm_pmu *);
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
-	int		(*filter_match)(struct perf_event *event);
+	bool		(*filter)(struct pmu *pmu, int cpu);
 	int		num_events;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7847818e5397..4be3aaae89be 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -519,9 +519,10 @@ struct pmu {
 					/* optional */
 
 	/*
-	 * Filter events for PMU-specific reasons.
+	 * Skip programming this PMU on the given CPU. Typically needed for
+	 * big.LITTLE things.
 	 */
-	int (*filter_match)		(struct perf_event *event); /* optional */
+	bool (*filter)			(struct pmu *pmu, int cpu); /* optional */
 
 	/*
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c6b64a48dea6..180842ba8473 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2181,38 +2181,11 @@ static bool is_orphaned_event(struct perf_event *event)
 	return event->state == PERF_EVENT_STATE_DEAD;
 }
 
-static inline int __pmu_filter_match(struct perf_event *event)
-{
-	struct pmu *pmu = event->pmu;
-	return pmu->filter_match ? pmu->filter_match(event) : 1;
-}
-
-/*
- * Check whether we should attempt to schedule an event group based on
- * PMU-specific filtering. An event group can consist of HW and SW events,
- * potentially with a SW leader, so we must check all the filters, to
- * determine whether a group is schedulable:
- */
-static inline int pmu_filter_match(struct perf_event *event)
-{
-	struct perf_event *sibling;
-
-	if (!__pmu_filter_match(event))
-		return 0;
-
-	for_each_sibling_event(sibling, event) {
-		if (!__pmu_filter_match(sibling))
-			return 0;
-	}
-
-	return 1;
-}
-
 static inline int
 event_filter_match(struct perf_event *event)
 {
 	return (event->cpu == -1 || event->cpu == smp_processor_id()) &&
-	       perf_cgroup_match(event) && pmu_filter_match(event);
+	       perf_cgroup_match(event);
 }
 
 static void
@@ -3661,6 +3634,9 @@ static noinline int visit_groups_merge(struct perf_event_context *ctx,
 	struct perf_event **evt;
 	int ret;
 
+	if (pmu->filter && pmu->filter(pmu, cpu))
+		return 0;
+
 	if (!ctx->task) {
 		cpuctx = this_cpu_ptr(&cpu_context);
 		event_heap = (struct min_heap){
