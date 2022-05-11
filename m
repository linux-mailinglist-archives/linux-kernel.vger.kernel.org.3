Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4073E523764
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbiEKPfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244494AbiEKPfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:35:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA562BF8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y+SBYyRLp190lyhAhB9+txzCudgdVn83IFku4q2UpiI=; b=W6mS9Eai/Z5pjlxzsAPFQvsRlY
        wcDDvWD9+nBz1rjwweVulL1LtnRXcru3r8shsbbqXkYuIOO/gO8WaskIoqE8R62zpHJIwQHy+dOlo
        48gGe4kQJFqVB6E5W19o7WSf18r3Q5R6lNeisizy4yxMJLsQ/4f3jsRk+mT0l8Cxx2Kuig3v2Zrem
        ZmJMSMHyl06+Bu89FCBx2mcjHjqV5OP900H3dmQnl4fpq4G9KwKRdtD29LIPL2VcyhdW6g3UJnjMt
        WufnTU272CgIshDTz3TKIe/rbqM59IXcn8Bc61O+OKMXuvRW7WMC3l692bydBEiMnkKrzJa1MR7JM
        axkSfN4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nooMS-00DCk5-O8; Wed, 11 May 2022 15:34:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5A4C3002BE;
        Wed, 11 May 2022 17:34:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8819F2038BE61; Wed, 11 May 2022 17:34:46 +0200 (CEST)
Date:   Wed, 11 May 2022 17:34:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: [RFC][PATCH 6/5] perf/x86/intel: Remove
 x86_pmu::set_topdown_event_period
Message-ID: <YnvXlrbpTEOmeIiw@hirez.programming.kicks-ass.net>
References: <20220511142037.353492804@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511142037.353492804@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Subject: perf/x86/intel: Remove x86_pmu::set_topdown_event_period
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed May 11 16:41:25 CEST 2022

Now that it is all internal to the intel driver, remove
x86_pmu::set_topdown_event_period.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c |   16 ++++++++++------
 arch/x86/events/perf_event.h |    1 -
 2 files changed, 10 insertions(+), 7 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2520,6 +2520,8 @@ static int adl_set_topdown_event_period(
 	return icl_set_topdown_event_period(event);
 }
 
+DEFINE_STATIC_CALL(intel_pmu_set_topdown_event_period, x86_perf_event_set_period);
+
 static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
 {
 	u32 val;
@@ -2810,9 +2812,8 @@ int intel_pmu_save_and_restart(struct pe
 
 static int intel_pmu_set_period(struct perf_event *event)
 {
-	if (unlikely(is_topdown_count(event)) &&
-	    x86_pmu.set_topdown_event_period)
-		return x86_pmu.set_topdown_event_period(event);
+	if (unlikely(is_topdown_count(event)))
+		return static_call(intel_pmu_set_topdown_event_period)(event);
 
 	return x86_perf_event_set_period(event);
 }
@@ -6191,7 +6192,8 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_skl(pmem);
 		x86_pmu.num_topdown_events = 4;
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
-		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
+		static_call_update(intel_pmu_set_topdown_event_period,
+				   &icl_set_topdown_event_period);
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
@@ -6228,7 +6230,8 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_skl(pmem);
 		x86_pmu.num_topdown_events = 8;
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
-		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
+		static_call_update(intel_pmu_set_topdown_event_period,
+				   &icl_set_topdown_event_period);
 		pr_cont("Sapphire Rapids events, ");
 		name = "sapphire_rapids";
 		break;
@@ -6261,7 +6264,8 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_skl(false);
 		x86_pmu.num_topdown_events = 8;
 		x86_pmu.update_topdown_event = adl_update_topdown_event;
-		x86_pmu.set_topdown_event_period = adl_set_topdown_event_period;
+		static_call_update(intel_pmu_set_topdown_event_period,
+				   &adl_set_topdown_event_period);
 
 		x86_pmu.filter_match = intel_pmu_filter_match;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -879,7 +879,6 @@ struct x86_pmu {
 	 */
 	int		num_topdown_events;
 	u64		(*update_topdown_event)(struct perf_event *event);
-	int		(*set_topdown_event_period)(struct perf_event *event);
 
 	/*
 	 * perf task context (i.e. struct perf_event_context::task_ctx_data)
