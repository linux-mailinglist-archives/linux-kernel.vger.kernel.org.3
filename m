Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81825A0C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiHYJSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiHYJSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:18:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03558A9C10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VqZJ/jwCsluFFo6hdnIYFxBUdWMktKiNLEdK5Tkhdhg=; b=O0I8K2kbkDtnksZknhbWqmlZTr
        G/gQWJ+76GNrowrI1uLR0LldDIdpJdx/F69ZWzoWY3iB/2pTILH8sPzdyHHYp6pt1eexc7Uvu4as8
        poEMbvF78TFneJ64ad02M8CvE8s3B1MIyO5rFZ07pBQOjK8uUDZkN7VzayoOhYmhsOOevO6G0XA1k
        8jOU6V1g0nnLh5E37PdJS7S0yVq8frDHS+dp+VCchRet+ajDKhDnJWZhj8+4cl4YzRt6H9xiWOldG
        XzxwdOPGH70cuxYAsi6Th9KKHRG5i1frAL0Zp0UkUZwuHd9NONwhXBtIhn25fM0I7D8P9bFSQbsTl
        DeNERlEA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oR8zT-00H7mW-Rk; Thu, 25 Aug 2022 09:17:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA4D598014D; Thu, 25 Aug 2022 11:17:29 +0200 (CEST)
Date:   Thu, 25 Aug 2022 11:17:29 +0200
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
Message-ID: <Ywc+Kc7p9svJ79ml@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YwYWUbVvSAYseDaO@worktop.programming.kicks-ass.net>
 <YwY8u7gx6bO+RBcg@worktop.programming.kicks-ass.net>
 <10d8889e-4ca9-7e4e-a3e4-d769da79d047@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d8889e-4ca9-7e4e-a3e4-d769da79d047@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 11:09:05AM +0530, Ravi Bangoria wrote:
> > -static inline int __pmu_filter_match(struct perf_event *event)
> > -{
> > -	struct pmu *pmu = event->pmu;
> > -	return pmu->filter_match ? pmu->filter_match(event) : 1;
> > -}
> > -
> > -/*
> > - * Check whether we should attempt to schedule an event group based on
> > - * PMU-specific filtering. An event group can consist of HW and SW events,
> > - * potentially with a SW leader, so we must check all the filters, to
> > - * determine whether a group is schedulable:
> > - */
> > -static inline int pmu_filter_match(struct perf_event *event)
> > -{
> > -	struct perf_event *sibling;
> > -
> > -	if (!__pmu_filter_match(event))
> > -		return 0;
> > -
> > -	for_each_sibling_event(sibling, event) {
> > -		if (!__pmu_filter_match(sibling))
> > -			return 0;
> > -	}
> > -
> > -	return 1;
> > -}
> > -
> >  static inline int
> >  event_filter_match(struct perf_event *event)
> >  {
> >  	return (event->cpu == -1 || event->cpu == smp_processor_id()) &&
> > -	       perf_cgroup_match(event) && pmu_filter_match(event);
> > +	       perf_cgroup_match(event);
> 
> There are many callers of event_filter_match() which might not endup calling
> visit_groups_merge(). I hope this is intentional change?

I thought I did, but lets go through them again.

event_filter_match() is called from:

 - __perf_event_enable(); here we'll end up in ctx_sched_in() which
   will dutifully skip the pmu in question.

   (fwiw, this is one of those sites where ctx_sched_{out,in}() could do
   with a @pmu argument.

 - merge_sched_in(); this is after the new callsite in
   visit_groups_merge().

 - perf_adjust_freq_unthrottle_context(); if the pmu was skipped in
   visit_groups_merge() then ->state != ACTIVE and we'll bail out.

 - perf_iterate_ctx() / perf_iterate_sb_cpu(); these are for generating
   side-band events, and arguably not delivering them when running on
   the 'wrong' CPU wasn't right to begin with.


So I tihnk we're good. Hmm?
