Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B3059D211
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241021AbiHWH1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240991AbiHWH0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:26:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1819563F14
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YGVYzNl///TrtvQ4OCLF59zyGa6eQWyGYPlO0gH/1Q8=; b=jYkmVSS1hrWx3DiCUE5c+uKB0J
        mRitrgzk5bE/1AwopR2wIt3XYAal76wiRqDl1NlJs8rAcvOehTd1QB4fScpAQBYN7wATuKyJ51fap
        U6nu8XzTz806VJjmf0GxGARn9aHdfk1xMEMF6/IKkBLLcZ14V6X7HG+j3+fRY/meByyGa2G6He0Sg
        4MJuxg2CGjH+HdVnvrqfMGs52zDGxmgGmBwz+FEWl479xxNTi8E6V0nM7i35FfswqwtBJjpqHuJYO
        bTPy8Ex7IEUp4jk1hVXq/a9/MaEIX8gRSM58PXLWdWxjg6PCS3QNwFYccDUInLWOksSa43vfGKrUD
        e7Fvpezg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQOIn-005Jp4-HD; Tue, 23 Aug 2022 07:26:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23276980403; Tue, 23 Aug 2022 09:26:20 +0200 (CEST)
Date:   Tue, 23 Aug 2022 09:26:20 +0200
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
Message-ID: <YwSBHL4xxTqz0F9f@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <a7b87da8-cd78-77ef-dd93-7886d4197050@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b87da8-cd78-77ef-dd93-7886d4197050@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:47:24AM +0530, Ravi Bangoria wrote:
> [...]
> 
> >  static void
> > -ctx_sched_in(struct perf_event_context *ctx,
> > -	     struct perf_cpu_context *cpuctx,
> > -	     enum event_type_t event_type,
> > +ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type,
> >  	     struct task_struct *task)
> >  {
> > +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
> >  	int is_active = ctx->is_active;
> >  	u64 now;
> >  
> > @@ -3818,6 +3905,7 @@ ctx_sched_in(struct perf_event_context *ctx,
> >  		/* start ctx time */
> >  		now = perf_clock();
> >  		ctx->timestamp = now;
> > +		// XXX ctx->task =? task
> 
> Couldn't get this XXX, it's from your original patch. If you can recall, it
> would be helpful.

No memories at all; but looking at it; it seems to worry if ctx->task is
up-to-date; in this context the only thing that relies on the task is
the cgroup for which we update the timestamp in the next statement:

> >  		perf_cgroup_set_timestamp(task, ctx);

I suppose I should really write less cryptic notes; then again, I never
imagined this would take that many years to complete :/

> >  	}
> 
> Also, this hunk is under if (is_active ^ EVENT_TIME), which effectively is
> (is_active != EVENT_TIME). I'm assuming it should be (is_active & EVENT_TIME)?

So that code is identical to what it currently is upstream; but yes that
looks somewhat dodgy.

So the code itself (does as the comment says) starts time. This should
only be done if EVENT_TIME is not set. That is, I'm thinking it should
be something like:

	!(is_active & EVENT_TIME)

which happens to be the same as:

	is_active ^ EVENT_TIME

under the assumption is_active contains no other bits -- which I don't
think is a valid assumption.
