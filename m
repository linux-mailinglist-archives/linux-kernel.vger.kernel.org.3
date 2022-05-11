Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EEC52355A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244596AbiEKOZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiEKOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:25:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C9963394
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RrsRwnufM8aJb8X9Do0ueNVFWhI9Rg8k/jxvL6pTy3A=; b=vnzOmGsJ8JHF5tstWbXoHMfj1B
        yet9pcHyTbhthoPq81ecsWA4MmEu0qPUOXOm3kD0AxKaRrUBfYz+kzBvrzC1xr3a7PuvUDZ8YQ1I7
        2QxmPAu3g8eilLhw3+nFUiTgD4DRE5IoPiuYuYIk4O8PvR3XuWFldF5aCMIUNEHPEmQ6rc4ScgYTF
        aBYHYUzEyEUL0+NQNN5TgWP+vBQ5UlioCreu9ADuqI0GUHTcZPeGDJ3yGQtdr+s2RY1DNyNJqLtqs
        oP2UGPL9aASxNV1DvWesK4gvE5ug7avOO0hskbN83R3pkSzHWLOVLHe7TNtWi5fadrvLfMypH/Xnk
        cFd8s/Sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nonH5-005VvM-LM; Wed, 11 May 2022 14:25:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85EEE300859;
        Wed, 11 May 2022 16:25:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2FE7C203C276F; Wed, 11 May 2022 16:25:09 +0200 (CEST)
Message-ID: <20220511142345.354695274@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 11 May 2022 16:20:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH 5/5] perf/x86: Add a x86_pmu::limit_period static_call
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

Avoid a branch and indirect call.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -72,8 +72,9 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_add,  *x
 DEFINE_STATIC_CALL_NULL(x86_pmu_del,  *x86_pmu.del);
 DEFINE_STATIC_CALL_NULL(x86_pmu_read, *x86_pmu.read);
 
-DEFINE_STATIC_CALL_NULL(x86_pmu_set_period, *x86_pmu.set_period);
-DEFINE_STATIC_CALL_NULL(x86_pmu_update,     *x86_pmu.update);
+DEFINE_STATIC_CALL_NULL(x86_pmu_set_period,   *x86_pmu.set_period);
+DEFINE_STATIC_CALL_NULL(x86_pmu_update,       *x86_pmu.update);
+DEFINE_STATIC_CALL_NULL(x86_pmu_limit_period, *x86_pmu.limit_period);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_schedule_events,       *x86_pmu.schedule_events);
 DEFINE_STATIC_CALL_NULL(x86_pmu_get_event_constraints, *x86_pmu.get_event_constraints);
@@ -1391,8 +1392,7 @@ int x86_perf_event_set_period(struct per
 	if (left > x86_pmu.max_period)
 		left = x86_pmu.max_period;
 
-	if (x86_pmu.limit_period)
-		x86_pmu.limit_period(event, &left);
+	static_call_cond(x86_pmu_limit_period)(event, &left);
 
 	this_cpu_write(pmc_prev_left[idx], left);
 
@@ -2017,6 +2017,7 @@ static void x86_pmu_static_call_update(v
 
 	static_call_update(x86_pmu_set_period, x86_pmu.set_period);
 	static_call_update(x86_pmu_update, x86_pmu.update);
+	static_call_update(x86_pmu_limit_period, x86_pmu.limit_period);
 
 	static_call_update(x86_pmu_schedule_events, x86_pmu.schedule_events);
 	static_call_update(x86_pmu_get_event_constraints, x86_pmu.get_event_constraints);


