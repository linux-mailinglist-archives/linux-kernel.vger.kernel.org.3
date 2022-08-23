Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5559DDCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354727AbiHWK0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353661AbiHWKLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:11:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6892A51416
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8IYpVH+wrNIhljjOkDaC835XwJRG4JpBDhf3B4CAyfo=; b=RRGqRzXHyy+OsbPTr0ZFcMoynE
        dHy27asZDsNDQVq070c9q+N2fBOA99Sd7fQgEWlicegx0yAiYolzmPRHGmNFBHJJYBK/ySx471CzI
        k13mZGzxV9gx4gvexg4reEWOAEoeRYHQzsn+L9izMDbAHkLsAWDa8Re3MWxR8dkmuWGkoiUQUYohf
        0wxuFyFzEUMQN4FfgMKdfNkyHsUWENGbHdIUaAkSefyWlrDnfDU1T25JAcSoZ3xhTKkadDpbxFgy7
        VQE4fH12ikuTYmuubdVDpv4pQpTOQiG9DKrJoLO5/gUJX9Y5g5SR7lGGnxhCkR79ukK8nyjl49Hhf
        RYVI0osg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQPjE-00F7Hi-Cd; Tue, 23 Aug 2022 08:57:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06827980403; Tue, 23 Aug 2022 10:57:41 +0200 (CEST)
Date:   Tue, 23 Aug 2022 10:57:41 +0200
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
Message-ID: <YwSWhXW+BUA3WkIE@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdNKJllCVMci3ov@hirez.programming.kicks-ass.net>
 <aab04cfb-2dd5-89dc-213d-7fa253615864@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab04cfb-2dd5-89dc-213d-7fa253615864@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:46:32AM +0530, Ravi Bangoria wrote:
> On 13-Jun-22 8:13 PM, Peter Zijlstra wrote:
> > On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:

> >> +static void ctx_pinned_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
> >>  {
> >> +	struct perf_event_pmu_context *pmu_ctx;
> >>  	int can_add_hw = 1;
> >>  
> >> -	if (ctx != &cpuctx->ctx)
> >> -		cpuctx = NULL;
> >> -
> >> -	visit_groups_merge(cpuctx, &ctx->pinned_groups,
> >> -			   smp_processor_id(),
> >> -			   merge_sched_in, &can_add_hw);
> >> +	if (pmu) {
> >> +		visit_groups_merge(ctx, &ctx->pinned_groups,
> >> +				   smp_processor_id(), pmu,
> >> +				   merge_sched_in, &can_add_hw);
> >> +	} else {
> >> +		/*
> >> +		 * XXX: This can be optimized for per-task context by calling
> >> +		 * visit_groups_merge() only once with:
> >> +		 *   1) pmu=NULL
> >> +		 *   2) Ignoring pmu in perf_event_groups_cmp() when it's NULL
> >> +		 *   3) Making can_add_hw a per-pmu variable
> >> +		 *
> >> +		 * Though, it can not be opimized for per-cpu context because
> >> +		 * per-cpu rb-tree consist of pmu-subtrees and pmu-subtrees
> >> +		 * consist of cgroup-subtrees. i.e. a cgroup events of same
> >> +		 * cgroup but different pmus are seperated out into respective
> >> +		 * pmu-subtrees.
> >> +		 */
> >> +		list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> >> +			can_add_hw = 1;
> >> +			visit_groups_merge(ctx, &ctx->pinned_groups,
> >> +					   smp_processor_id(), pmu_ctx->pmu,
> >> +					   merge_sched_in, &can_add_hw);
> >> +		}
> >> +	}
> >>  }
> > 
> > I'm not sure I follow.. task context can have multiple PMUs just the
> > same as CPU context can, that's more or less the entire point of the
> > patch.
> 
> Current rbtree key is {cpu, cgroup_id, group_idx}. However, effective key for
> task specific context is {cpu, group_idx} because cgroup_id is always 0. And
> effective key for cpu specific context is {cgroup_id, group_idx} because cpu
> is same for entire rbtree.
> 
> With New design, rbtree key will be {cpu, pmu, cgroup_id, group_idx}. But as
> explained above, effective key for task specific context will be {cpu, pmu,
> group_idx}. Thus, we can handle pmu=NULL in visit_groups_merge(), same as you
> did in the very first RFC[1]. (This may make things more complicated though
> because we might also need to increase heap size to accommodate all pmu events
> in single heap. Current heap size is 2 for task specific context, which is
> sufficient if we iterate over all pmus).
> 
> Same optimization won't work for cpu specific context because, it's effective
> key would be {pmu, cgroup_id, group_idx} i.e. each pmu subtree is made up of
> cgroup subtrees.

Agreed, new order is: {cpu, pmu, cgroup_id, group_idx}

Event scheduling looks at the {cpu, pmu, cgroup_id} subtree to find the
leftmost group_idx event to schedule next.

However, since cgroup events are per-cpu events, per-task events will
always have cgroup=NULL. Resulting in the subtrees:

  {-1, pmu, NULL} and {cpu, pmu, NULL}

Which is what the code does, it iterates ctx->pmu_ctx_list to find all
@pmu values and then for each does the schedule dance.

Now, I suppose making that:

  {-1, NULL, NULL}, {cpu, NULL, NULL}

could work, but wouldn't iterating the the tree be more expensive than
just finding the sub-trees as we do now?

You also talk about extending extending the heap, which I read like
doing the heap-merge over:

 {-1, pmu0, NULL}, {-1, pmu1, NULL}, ...
 {cpu, pmu0, NULL}, ...

But that doesn't make sense, the schedule dance is per-pmu.

Or am I just still not getting it?

