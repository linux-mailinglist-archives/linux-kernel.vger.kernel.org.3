Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5894599728
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347705AbiHSIfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347650AbiHSIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:34:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739B832042
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/iVNNjB8U3q+4+g1NB6eYk8TE0j2SJ8SWzHSD2nk/y0=; b=iVwwDRSD4sV8BDBd10gpD7wRcO
        MzYvuV5LI624DLxP9qaCT/iadFn6Dp1+rVU/hPtquPhch/KYqOkK33Ix1k5OUyZk87/G+mDJeRcfP
        uHd1I5i5wpU5T/HoYpPngxP/4eOAnyxhbWZ6v2V00dR2PJP3bSjXUWY3HwZxOfRhFRoyzKnkx15Li
        WmEnDzKVjTePtF0RkbBmuwXzJGb9FReZx0PBxVsCEztVtqYBg1DWEWKp3/3s3J8jAUvzyBlr9t6Mo
        fJJTCRS4rGL4H4usxJR7hoLJFKDv5cUVWVNx7vL+eISK3UEVHUJm+o3lp6qZr910bo6nf+X/MoUy6
        tnh9yItg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOxRF-00AvAk-Gh; Fri, 19 Aug 2022 08:33:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08D06980120; Fri, 19 Aug 2022 10:33:08 +0200 (CEST)
Date:   Fri, 19 Aug 2022 10:33:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error
 for Alder Lake N
Message-ID: <Yv9Kw21Wl/f6KJTk@worktop.programming.kicks-ass.net>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv9EVP6O9r867om4@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv9EVP6O9r867om4@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 10:05:40AM +0200, Peter Zijlstra wrote:
> On Thu, Aug 18, 2022 at 11:15:30AM -0700, kan.liang@linux.intel.com wrote:
> 
> > The Alder Lake N only has e-cores. The X86_FEATURE_HYBRID_CPU flag is
> > not set. The perf cannot retrieve the correct CPU type via
> > get_this_hybrid_cpu_type(). The model specific get_hybrid_cpu_type() is
> > hardcode to p-core. The wrong CPU type is given to the PMU of the
> > Alder Lake N.
> 
> If ADL-N isn't in fact a hybrid CPU, then *WHY* are we running
> init_hybrid_pmu() and setting up all that nonsense?
> 
> That is, wouldn't the right thing be to remove ALDERLAKE_N from the rest
> of {ALDER,RAPTOP}LAKE and create a non-hybrid PMU setup for it?

Something like the *completely* untested below.. which adds it like a
regular atom chip (which it is).

(I basically did copy/paste of tremont and added bits from the cpu_atom
thing from alderlake -- but might well have missed something)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2db93498ff71..e509f1033a2d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5974,6 +5974,38 @@ __init int intel_pmu_init(void)
 		name = "Tremont";
 		break;
 
+	case INTEL_FAM6_ALDERLAKE_N:
+		x86_pmu.mid_ack = true;
+		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
+		       sizeof(hw_cache_event_ids));
+		memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
+		       sizeof(hw_cache_extra_regs));
+		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
+
+		intel_pmu_lbr_init_skl();
+
+		x86_pmu.event_constraints = intel_slm_event_constraints;
+		x86_pmu.pebs_constraints = intel_grt_pebs_event_constraints;
+		x86_pmu.extra_regs = intel_grt_extra_regs;
+		/*
+		 * It's recommended to use CPU_CLK_UNHALTED.CORE_P + NPEBS
+		 * for precise cycles.
+		 */
+		x86_pmu.pebs_aliases = NULL;
+		x86_pmu.pebs_prec_dist = true;
+		x86_pmu.lbr_pt_coexist = true;
+		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
+		x86_pmu.flags |= PMU_FL_PEBS_ALL;
+		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
+		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
+		x86_pmu.get_event_constraints = tnt_get_event_constraints;
+		td_attr = tnt_events_attrs;
+		extra_attr = slm_format_attr;
+		pr_cont("Gracemont events, ");
+		name = "Gracemont";
+		break;
+
 	case INTEL_FAM6_WESTMERE:
 	case INTEL_FAM6_WESTMERE_EP:
 	case INTEL_FAM6_WESTMERE_EX:
@@ -6318,7 +6350,6 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 		/*
