Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50245549B77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245144AbiFMS1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245179AbiFMS1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:27:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E501F66EA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oK0xcqmp3fvIbfBPZeQby/6yA6WIfNUDIpk6YyHRX+U=; b=GzXnSFpSAIgg5NdHwe3L/um480
        8SDVb6Y+X+xFxV6wj5kKYt+nMJ3h9vTuKbPyEn2/9RT5c1ytbXxpyz9iYnfnzSwW56V2t7/qOzUWA
        G8e9GQB7eD9rDC3h+xhl26j0MFeDEzAzoIuHXuXbNDXvi12Jl36MLmGonw6uF6pEfly2s7Xnhukjg
        mtMK7DYBCvCKkV4qNJmID0TV9pIKrF2tRMNt+Vg5+VV/7WC4oACZWAcdhrqMQchOvajw6dOc9+B+X
        BpR1Tr8Q5sKxajQqxev6aTL+EvwP3davmr6cVpwWEnnclsF13F0hvTvH/YDN3pFPDrKCtGmakQh+n
        xcGwTCjA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0lFw-00GvEx-TY; Mon, 13 Jun 2022 14:41:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5555D302AE0;
        Mon, 13 Jun 2022 16:41:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 443862029F884; Mon, 13 Jun 2022 16:41:28 +0200 (CEST)
Date:   Mon, 13 Jun 2022 16:41:28 +0200
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
Message-ID: <YqdMmLqFS9cX4jRb@hirez.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:

> @@ -3196,11 +3187,52 @@ static int perf_event_modify_attr(struct
>  	return err;
>  }
>  
> -static void ctx_sched_out(struct perf_event_context *ctx,
> -			  struct perf_cpu_context *cpuctx,
> -			  enum event_type_t event_type)
> +static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
> +				enum event_type_t event_type)
>  {
> +	struct perf_event_context *ctx = pmu_ctx->ctx;
>  	struct perf_event *event, *tmp;
> +	struct pmu *pmu = pmu_ctx->pmu;
> +
> +	if (ctx->task && !ctx->is_active) {
> +		struct perf_cpu_pmu_context *cpc;
> +
> +		cpc = this_cpu_ptr(pmu->cpu_pmu_context);
> +		WARN_ON_ONCE(cpc->task_epc != pmu_ctx);
> +		cpc->task_epc = NULL;
> +	}
> +
> +	if (!event_type)
> +		return;
> +
> +	perf_pmu_disable(pmu);
> +	if (event_type & EVENT_PINNED) {
> +		list_for_each_entry_safe(event, tmp,
> +				&pmu_ctx->pinned_active,
> +				active_list)
> +			group_sched_out(event, ctx);
> +	}
> +
> +	if (event_type & EVENT_FLEXIBLE) {
> +		list_for_each_entry_safe(event, tmp,
> +				&pmu_ctx->flexible_active,
> +				active_list)
> +			group_sched_out(event, ctx);
> +		/*
> +		 * Since we cleared EVENT_FLEXIBLE, also clear
> +		 * rotate_necessary, is will be reset by
> +		 * ctx_flexible_sched_in() when needed.
> +		 */
> +		pmu_ctx->rotate_necessary = 0;
> +	}
> +	perf_pmu_enable(pmu);
> +}
> +
> +static void
> +ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
> +{
> +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
> +	struct perf_event_pmu_context *pmu_ctx;
>  	int is_active = ctx->is_active;
>  
>  	lockdep_assert_held(&ctx->lock);
> @@ -3251,24 +3283,8 @@ static void ctx_sched_out(struct perf_ev
>  	if (!ctx->nr_active || !(is_active & EVENT_ALL))
>  		return;
>  
> -	perf_pmu_disable(ctx->pmu);
> -	if (is_active & EVENT_PINNED) {
> -		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
> -			group_sched_out(event, cpuctx, ctx);
> -	}
> -
> -	if (is_active & EVENT_FLEXIBLE) {
> -		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list)
> -			group_sched_out(event, cpuctx, ctx);
> -
> -		/*
> -		 * Since we cleared EVENT_FLEXIBLE, also clear
> -		 * rotate_necessary, is will be reset by
> -		 * ctx_flexible_sched_in() when needed.
> -		 */
> -		ctx->rotate_necessary = 0;
> -	}
> -	perf_pmu_enable(ctx->pmu);
> +	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
> +		__pmu_ctx_sched_out(pmu_ctx, is_active);
>  }

You mentioned trouble with cpc->task_epc, there's one rebase mistake
from you and an original bug from me.

You lost the last hunk, I forgot to clear cpc on
perf_remove_from_context().

With these fixes I can run: 'perf test' without things going
insta-splat.

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2311,6 +2311,7 @@ __perf_remove_from_context(struct perf_e
 			   struct perf_event_context *ctx,
 			   void *info)
 {
+	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
 	unsigned long flags = (unsigned long)info;
 
 	if (ctx->is_active & EVENT_TIME) {
@@ -2325,8 +2326,17 @@ __perf_remove_from_context(struct perf_e
 		perf_child_detach(event);
 	list_del_event(event, ctx);
 
-	if (!event->pmu_ctx->nr_events)
-		event->pmu_ctx->rotate_necessary = 0;
+	if (!pmu_ctx->nr_events) {
+		pmu_ctx->rotate_necessary = 0;
+
+		if (ctx->task) {
+			struct perf_cpu_pmu_context *cpc;
+
+			cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
+			WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
+			cpc->task_epc = NULL;
+		}
+	}
 
 	if (!ctx->nr_events && ctx->is_active) {
 		if (ctx == &cpuctx->ctx)
@@ -3198,7 +3208,7 @@ static void __pmu_ctx_sched_out(struct p
 		struct perf_cpu_pmu_context *cpc;
 
 		cpc = this_cpu_ptr(pmu->cpu_pmu_context);
-		WARN_ON_ONCE(cpc->task_epc != pmu_ctx);
+		WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
 		cpc->task_epc = NULL;
 	}
 
@@ -3280,9 +3290,6 @@ ctx_sched_out(struct perf_event_context
 
 	is_active ^= ctx->is_active; /* changed bits */
 
-	if (!ctx->nr_active || !(is_active & EVENT_ALL))
-		return;
-
 	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
 }
