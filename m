Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F21959D1D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbiHWHLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbiHWHKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:10:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AE161D4D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C2pTduGyZThsWDZ7oC5CKV3xWc+y+875pkYxXtFqY94=; b=kTxXVzajFLNaE21Oh0oBb5svei
        YALwqCin7NrV0NgtCaQEf12Ay6WPdvFTlr/x69cbTnb1czPMSYO8AQdC4y4ov19zADapzu9zmPCZb
        YrohODibAGyH5IlYQ2H7hc7bN+aOYjrZAA99PUuuxkhjyLfcejpsMA+AvwQ18T+CzpP6TOgjcB26K
        +nc8vzpmXnEpi/sgYhrLxWkmjzDPTZQjybmkjE9YVG0n4ncKdexBn47psr8FZiHVh8Giw198epFeM
        MKaSx4QBZlEJ4JIlc5o9tuRG2RLXS9D23q4u04cnvQHqkF12w4gMQnjquAfMW4rGCpcAx+dWPBeQ6
        UTbYeGzA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQO32-00F2yZ-GR; Tue, 23 Aug 2022 07:10:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64F12980403; Tue, 23 Aug 2022 09:10:02 +0200 (CEST)
Date:   Tue, 23 Aug 2022 09:10:02 +0200
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
Message-ID: <YwR9ShCHDBgrvT9s@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <2acacbcb-2bdb-30d6-3300-8d125b06a0f3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acacbcb-2bdb-30d6-3300-8d125b06a0f3@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:43:03AM +0530, Ravi Bangoria wrote:
> [...]
> 
> >  /*
> > @@ -2718,7 +2706,6 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
> >  			struct perf_event_context *task_ctx,
> >  			enum event_type_t event_type)
> >  {
> > -	enum event_type_t ctx_event_type;
> >  	bool cpu_event = !!(event_type & EVENT_CPU);
> >  
> >  	/*
> > @@ -2728,11 +2715,13 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
> >  	if (event_type & EVENT_PINNED)
> >  		event_type |= EVENT_FLEXIBLE;
> >  
> > -	ctx_event_type = event_type & EVENT_ALL;
> > +	event_type &= EVENT_ALL;
> >  
> > -	perf_pmu_disable(cpuctx->ctx.pmu);
> > -	if (task_ctx)
> > -		task_ctx_sched_out(cpuctx, task_ctx, event_type);
> > +	perf_ctx_disable(&cpuctx->ctx);
> > +	if (task_ctx) {
> > +		perf_ctx_disable(task_ctx);
> > +		task_ctx_sched_out(task_ctx, event_type);
> > +	}
> >  
> >  	/*
> >  	 * Decide which cpu ctx groups to schedule out based on the types
> > @@ -2742,17 +2731,20 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
> >  	 *  - otherwise, do nothing more.
> >  	 */
> >  	if (cpu_event)
> > -		cpu_ctx_sched_out(cpuctx, ctx_event_type);
> > -	else if (ctx_event_type & EVENT_PINNED)
> > -		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
> > +		ctx_sched_out(&cpuctx->ctx, event_type);
> > +	else if (event_type & EVENT_PINNED)
> > +		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
> >  
> >  	perf_event_sched_in(cpuctx, task_ctx, current);
> > -	perf_pmu_enable(cpuctx->ctx.pmu);
> > +
> > +	perf_ctx_enable(&cpuctx->ctx);
> > +	if (task_ctx)
> > +		perf_ctx_enable(task_ctx);
> >  }
> 
> ctx_resched() reschedule entire perf_event_context while adding new event
> to the context or enabling existing event in the context. We can probably
> optimize it by rescheduling only affected pmu_ctx.

Yes, it would probably make sense to add a pmu argument there and limit
the rescheduling where possible.
