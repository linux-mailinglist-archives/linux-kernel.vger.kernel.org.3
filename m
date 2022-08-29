Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF235A46E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiH2KPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiH2KOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:14:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A5326DE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=k2xQ/LVf2SOdthxC920Ou1J9VXdYvbj3bbQ75rCmiM4=; b=FruITZ5wMFXzZuMH+u8PpjUs/w
        A5i5H8qgc1QaGwodBC+QbbupMbVT0/9nuP8lOrRRmCLEXBKIqVhZR1+/OJ7orkaByE0A2R5MZdk9w
        5hJoKPY44pg2ly1Eo6ap9Sw2qqa+tupQ78Rl/mmti1aIsRUbSzsz7xUm3QQ9Nbq44K9WqWyXSy67Z
        vlb8x8sXQp2UnHVGgP7uNQo2gN/PIcauqTJyjpLnWsscvcuPk/zLaCerik+TtI36LbOuP6XHqrjeD
        tRkNhKVUOMiPegCGwAjoy6spUIzUSmCFOtcWc1hD4NoEKnGR1xFNIUT7nDjT2LSY/mHBQpc26UHLp
        AV6h9Bnw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSbn1-00304u-5j; Mon, 29 Aug 2022 10:14:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D219300410;
        Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 76E2A20088DAC; Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Message-ID: <20220829101321.573713839@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Aug 2022 12:10:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com,
        ravi.bangoria@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH v2 3/9] perf/x86: Change x86_pmu::limit_period signature
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

In preparation for making it a static_call, change the signature.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/amd/core.c   |    8 +++-----
 arch/x86/events/core.c       |   13 ++++++++-----
 arch/x86/events/intel/core.c |   19 ++++++++-----------
 arch/x86/events/perf_event.h |    2 +-
 4 files changed, 20 insertions(+), 22 deletions(-)

--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1222,16 +1222,14 @@ static ssize_t amd_event_sysfs_show(char
 	return x86_event_sysfs_show(page, config, event);
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
 
@@ -1396,9 +1397,9 @@ int x86_perf_event_set_period(struct per
 		left = x86_pmu.max_period;
 
 	if (x86_pmu.limit_period)
-		left = x86_pmu.limit_period(event, left);
+		x86_pmu.limit_period(event, &left);
 
-	per_cpu(pmc_prev_left[idx], smp_processor_id()) = left;
+	this_cpu_write(pmc_prev_left[idx], left);
 
 	/*
 	 * The hw event starts counting from this event offset,
@@ -2675,7 +2676,9 @@ static int x86_pmu_check_period(struct p
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
@@ -4342,28 +4342,25 @@ static u8 adl_get_hybrid_cpu_type(void)
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
@@ -783,7 +783,7 @@ struct x86_pmu {
 	struct event_constraint *event_constraints;
 	struct x86_pmu_quirk *quirks;
 	int		perfctr_second_write;
-	u64		(*limit_period)(struct perf_event *event, u64 l);
+	void		(*limit_period)(struct perf_event *event, s64 *l);
 
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,


