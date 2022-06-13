Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6269C549B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245477AbiFMS3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbiFMS2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:28:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293BDB225B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IEfVO3p8TtmbkhfyAZCfpHMcYnsk1901oHfnPETiUxk=; b=lA+oiSffR4bHoAK/vJesjSm3LC
        iOXSHmhjhGvnJAPG5VrcmU/ECoQobY1YDOf98/cIA4KhDXRObEFXNGAW7DP+8fL9RoPxjxvtAomHS
        mfZkq4xsCGyya7Jqtd8gAMt3nLYBBPwVHs3OxkLhk/ht34YAqqXjqQKcL67rS4qgfA68kpi1r+40Z
        0sJvOyEP/EqWHHdKbmk6kdispjZe7A1Mp2eF7DQXxg07UNTjT3+LjdemvLPa34rKTNqc6lqZqxDx+
        Q+jebNIZgh0VZ9oW9g9T6rA6A6aMasi7QOJG84qV822lzyCaNl/DgqZexFYzMLCtv2wEY27JKLtc7
        cxfTlEKA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0lII-007aoc-TQ; Mon, 13 Jun 2022 14:43:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EAE333002BE;
        Mon, 13 Jun 2022 16:43:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1E8D284A2B0D; Mon, 13 Jun 2022 16:43:52 +0200 (CEST)
Date:   Mon, 13 Jun 2022 16:43:52 +0200
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
Message-ID: <YqdNKJllCVMci3ov@hirez.programming.kicks-ass.net>
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

> @@ -3652,17 +3697,28 @@ static noinline int visit_groups_merge(s
>  			.size = ARRAY_SIZE(itrs),
>  		};
>  		/* Events not within a CPU context may be on any CPU. */
> -		__heap_add(&event_heap, perf_event_groups_first(groups, -1, NULL));
> +		__heap_add(&event_heap, perf_event_groups_first(groups, -1, pmu, NULL));
>  	}
>  	evt = event_heap.data;
>  
> -	__heap_add(&event_heap, perf_event_groups_first(groups, cpu, NULL));
> +	__heap_add(&event_heap, perf_event_groups_first(groups, cpu, pmu, NULL));
>  
>  #ifdef CONFIG_CGROUP_PERF
>  	for (; css; css = css->parent)
> -		__heap_add(&event_heap, perf_event_groups_first(groups, cpu, css->cgroup));
> +		__heap_add(&event_heap, perf_event_groups_first(groups, cpu, pmu, css->cgroup));
>  #endif
>  
> +	if (event_heap.nr) {
> +		/*
> +		 * XXX: For now, visit_groups_merge() gets called with pmu
> +		 * pointer never NULL. But these functions needs to be called
> +		 * once for each pmu if I implement pmu=NULL optimization.
> +		 */
> +		__link_epc((*evt)->pmu_ctx);
> +		perf_assert_pmu_disabled((*evt)->pmu_ctx->pmu);
> +	}
> +
> +
>  	min_heapify_all(&event_heap, &perf_min_heap);
>  
>  	while (event_heap.nr) {

> @@ -3741,39 +3799,67 @@ static int merge_sched_in(struct perf_ev
>  	return 0;
>  }
>  
> -static void
> -ctx_pinned_sched_in(struct perf_event_context *ctx,
> -		    struct perf_cpu_context *cpuctx)
> +static void ctx_pinned_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
>  {
> +	struct perf_event_pmu_context *pmu_ctx;
>  	int can_add_hw = 1;
>  
> -	if (ctx != &cpuctx->ctx)
> -		cpuctx = NULL;
> -
> -	visit_groups_merge(cpuctx, &ctx->pinned_groups,
> -			   smp_processor_id(),
> -			   merge_sched_in, &can_add_hw);
> +	if (pmu) {
> +		visit_groups_merge(ctx, &ctx->pinned_groups,
> +				   smp_processor_id(), pmu,
> +				   merge_sched_in, &can_add_hw);
> +	} else {
> +		/*
> +		 * XXX: This can be optimized for per-task context by calling
> +		 * visit_groups_merge() only once with:
> +		 *   1) pmu=NULL
> +		 *   2) Ignoring pmu in perf_event_groups_cmp() when it's NULL
> +		 *   3) Making can_add_hw a per-pmu variable
> +		 *
> +		 * Though, it can not be opimized for per-cpu context because
> +		 * per-cpu rb-tree consist of pmu-subtrees and pmu-subtrees
> +		 * consist of cgroup-subtrees. i.e. a cgroup events of same
> +		 * cgroup but different pmus are seperated out into respective
> +		 * pmu-subtrees.
> +		 */
> +		list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> +			can_add_hw = 1;
> +			visit_groups_merge(ctx, &ctx->pinned_groups,
> +					   smp_processor_id(), pmu_ctx->pmu,
> +					   merge_sched_in, &can_add_hw);
> +		}
> +	}
>  }

I'm not sure I follow.. task context can have multiple PMUs just the
same as CPU context can, that's more or less the entire point of the
patch.
