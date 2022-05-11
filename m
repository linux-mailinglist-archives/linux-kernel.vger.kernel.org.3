Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12856523558
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbiEKOZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiEKOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:25:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BD640A3B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=rLl5J2DLGbXLQLGLVKmwEFUM1mLMY8M0xRVjlffGnsU=; b=q9t0EthDCuaahUXWGXSW15D4rB
        Nx39cShAfuD3IONFAluhd2In0ym90Ye6I9rTyDBakNP4GacdJGA1ARxYA3D3smwR2F8aIzR1CshR9
        lN29Znudh3Zhg9X9MY87VoOl06vPZSsXftzubIjR+i3kSfShSUKwR84lYsermWQk0SmMVlJYty2X7
        HXN7V+/GykB+K5KkQPYjDugFq2ys4E262veU4867ihtjESl+XoXxhGBIyIYqL/j0WsZhFMfzZon2S
        Lw0hEfLDeOxgovZXnqMM3sSCBCQvkskTg/KsOdZc0LA7ii1fQ4Q3BUEqv815uzIG4UZSpEBi9e5/+
        lhnyXCHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nonH5-005VvF-21; Wed, 11 May 2022 14:25:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45E2D30080B;
        Wed, 11 May 2022 16:25:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2B7BA203BFA31; Wed, 11 May 2022 16:25:09 +0200 (CEST)
Message-ID: <20220511142345.289907761@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 11 May 2022 16:20:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH 4/5] perf/x86: Change x86_pmu::limit_period signature
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

In preparation for making it a static_call, change the signature.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/amd/core.c   |    8 +++-----
 arch/x86/events/core.c       |   18 ++++++++----------
 arch/x86/events/intel/core.c |   19 ++++++++-----------
 arch/x86/events/perf_event.h |    2 +-
 4 files changed, 20 insertions(+), 27 deletions(-)

--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1258,16 +1258,14 @@ static void amd_pmu_sched_task(struct pe
 		amd_pmu_brs_sched_task(ctx, sched_in);
 }
 
-static u64 amd_pmu_limit_period(struct perf_event *event, u64 left)
+static void amd_pmu_limit_period(struct perf_event *event, s64 *left)
 {
 	/*
 	 * Decrease period by the depth of the BRS feature to get the last N
 	 * taken branches and approximate the desired period
 	 */
-	if (has_branch_stack(event) && left > x86_pmu.lbr_nr)
-		left -= x86_pmu.lbr_nr;
-
-	return left;
+	if (has_branch_stack(event) && *left > x86_pmu.lbr_nr)
+		*left -= x86_pmu.lbr_nr;
 }
 
 static __initconst const struct x86_pmu amd_pmu = {
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -621,8 +621,9 @@ int x86_pmu_hw_config(struct perf_event
 		event->hw.config |= event->attr.config & X86_RAW_EVENT_MASK;
 
 	if (event->attr.sample_period && x86_pmu.limit_period) {
-		if (x86_pmu.limit_period(event, event->attr.sample_period) >
-				event->attr.sample_period)
+		s64 left = event->attr.sample_period;
+		x86_pmu.limit_period(event, &left);
+		if (left > event->attr.sample_period)
 			return -EINVAL;
 	}
 
@@ -1386,19 +1387,14 @@ int x86_perf_event_set_period(struct per
 		hwc->last_period = period;
 		ret = 1;
 	}
-	/*
-	 * Quirk: certain CPUs dont like it if just 1 hw_event is left:
-	 */
-	if (unlikely(left < 2))
-		left = 2;
 
 	if (left > x86_pmu.max_period)
 		left = x86_pmu.max_period;
 
 	if (x86_pmu.limit_period)
-		left = x86_pmu.limit_period(event, left);
+		x86_pmu.limit_period(event, &left);
 
-	per_cpu(pmc_prev_left[idx], smp_processor_id()) = left;
+	this_cpu_write(pmc_prev_left[idx], left);
 
 	/*
 	 * The hw event starts counting from this event offset,
@@ -2672,7 +2668,9 @@ static int x86_pmu_check_period(struct p
 		return -EINVAL;
 
 	if (value && x86_pmu.limit_period) {
-		if (x86_pmu.limit_period(event, value) > value)
+		s64 left = value;
+		x86_pmu.limit_period(event, &left);
+		if (left > value)
 			return -EINVAL;
 	}
 
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4244,28 +4244,25 @@ static u8 adl_get_hybrid_cpu_type(void)
  * Therefore the effective (average) period matches the requested period,
  * despite coarser hardware granularity.
  */
-static u64 bdw_limit_period(struct perf_event *event, u64 left)
+static void bdw_limit_period(struct perf_event *event, s64 *left)
 {
 	if ((event->hw.config & INTEL_ARCH_EVENT_MASK) ==
 			X86_CONFIG(.event=0xc0, .umask=0x01)) {
-		if (left < 128)
-			left = 128;
-		left &= ~0x3fULL;
+		if (*left < 128)
+			*left = 128;
+		*left &= ~0x3fULL;
 	}
-	return left;
 }
 
-static u64 nhm_limit_period(struct perf_event *event, u64 left)
+static void nhm_limit_period(struct perf_event *event, s64 *left)
 {
-	return max(left, 32ULL);
+	*left = max(*left, 32LL);
 }
 
-static u64 spr_limit_period(struct perf_event *event, u64 left)
+static void spr_limit_period(struct perf_event *event, s64 *left)
 {
 	if (event->attr.precise_ip == 3)
-		return max(left, 128ULL);
-
-	return left;
+		*left = max(*left, 128LL);
 }
 
 PMU_FORMAT_ATTR(event,	"config:0-7"	);
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -773,7 +773,7 @@ struct x86_pmu {
 	struct event_constraint *event_constraints;
 	struct x86_pmu_quirk *quirks;
 	int		perfctr_second_write;
-	u64		(*limit_period)(struct perf_event *event, u64 l);
+	void		(*limit_period)(struct perf_event *event, s64 *l);
 
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,


