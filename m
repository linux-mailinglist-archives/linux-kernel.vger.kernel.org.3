Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC43559F939
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbiHXMQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbiHXMQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:16:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7037A6BD69
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e8nBv61PbcSsA9fWy+AThJ1QLoUmiWCYPfn45AeR6QE=; b=dPqukcO/lafAYDyLMVm1h82LSV
        wY1poJqdnEe8hnwXo+nlITwiA3ztJXSelBWCrj7t8LBs7FeHKnRBRyZ8gqo8NZXcbo3sDbOC9yZij
        ar1ofZwJ+aRdGlhFJKr2WlM/fCzbLMArr2eQMHzZm1YBmoIPE20uwUtLBU8f9xZMhMlHj0ocbhl58
        Pkhlrq0PNZYRZFLCmKiDIA8E50GKQOPniY0KcPDDA0ycuINLYlX1JavMZIrDwb30iRK6mMexR0zXV
        +ax+pLfo3Mhm0arC4m1H4RSK+m3UjTL8tz8E9jdFj3jpNwTIUvPZgojCTFsnUZaSo/V/FxUKmszmf
        elnHAq1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQpHw-00GJ8j-Ds; Wed, 24 Aug 2022 12:15:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3983980BE2; Wed, 24 Aug 2022 14:15:13 +0200 (CEST)
Date:   Wed, 24 Aug 2022 14:15:13 +0200
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
Message-ID: <YwYWUbVvSAYseDaO@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:
>  void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu)
>  {
> -	struct perf_cpu_context *cpuctx;
> +	/* XXX: Don't need this quirk anymore */
> +	/*struct perf_cpu_context *cpuctx;
>  
>  	if (!pmu->pmu_cpu_context)
>  		return;
>  
>  	cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
> -	cpuctx->ctx.pmu = pmu;
> +	cpuctx->ctx.pmu = pmu;*/
>  }

Confirmed; my ADL seems to work fine without all that.

---
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index fd043cd0e3c9..7a2d12ad6d1f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2059,24 +2059,6 @@ void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
 	pr_info("... event mask:             %016Lx\n", intel_ctrl);
 }
 
-/*
- * The generic code is not hybrid friendly. The hybrid_pmu->pmu
- * of the first registered PMU is unconditionally assigned to
- * each possible cpuctx->ctx.pmu.
- * Update the correct hybrid PMU to the cpuctx->ctx.pmu.
- */
-void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu)
-{
-	/* XXX: Don't need this quirk anymore */
-	/*struct perf_cpu_context *cpuctx;
-
-	if (!pmu->pmu_cpu_context)
-		return;
-
-	cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
-	cpuctx->ctx.pmu = pmu;*/
-}
-
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -2197,9 +2179,6 @@ static int __init init_hw_perf_events(void)
 						(hybrid_pmu->cpu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
 			if (err)
 				break;
-
-			if (cpu_type == hybrid_pmu->cpu_type)
-				x86_pmu_update_cpu_context(&hybrid_pmu->pmu, raw_smp_processor_id());
 		}
 
 		if (i < x86_pmu.num_hybrid_pmus) {
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8a72e6fe27a5..768771e5e4e9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4508,8 +4508,6 @@ static bool init_hybrid_pmu(int cpu)
 	cpumask_set_cpu(cpu, &pmu->supported_cpus);
 	cpuc->pmu = &pmu->pmu;
 
-	x86_pmu_update_cpu_context(&pmu->pmu, cpu);
-
 	return true;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 94fb65d7b291..9c835ecb232e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1175,8 +1175,6 @@ int x86_pmu_handle_irq(struct pt_regs *regs);
 void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
 			  u64 intel_ctrl);
 
-void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu);
-
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
