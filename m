Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBCD4E52E1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244198AbiCWNT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiCWNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:19:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9929B5FF14;
        Wed, 23 Mar 2022 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tidbQ28V1Z4b3XDUjQz0tCiyzqh7PCycYcQY6xRAP6g=; b=AIBQqFsjXdlLO6yz8HkbcHmlzH
        Vm/jeFeUAPe6zjc4fBCDgllGCAuRPIlk+vPzP83AflrwTGJRrNsExxI0OnVmsVXNqlMURjfnIMD0k
        YIL9ic9InO5Bdvh75c48J6Y0MdYfr4x5cHhNEHW+D+sUwne62Eu06Z0YrlpAEfMQoBVp7ixLdchRK
        HbKkUz6oawwOZ5TdCpAjdUufRxfqTmLGZh0wmOsOF8GqDkZUYkUxojITmvvw4XADpD3tWGSinUEmk
        Z0Qz1zScJFryDBZkK+pRtDmIhi6zqpJBHUiAu8WPDlvrdtTNdGcfUyTkPXgHqRKeAFatl2cVxLFt7
        NaujgeRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX0rw-00CYa6-UO; Wed, 23 Mar 2022 13:17:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AD0C986200; Wed, 23 Mar 2022 14:17:44 +0100 (CET)
Date:   Wed, 23 Mar 2022 14:17:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [External] Re: [PATCH v2 2/6] perf/core: Introduce percpu
 perf_cgroup
Message-ID: <20220323131744.GY8939@worktop.programming.kicks-ass.net>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-3-zhouchengming@bytedance.com>
 <20220323125116.GX8939@worktop.programming.kicks-ass.net>
 <f6a46509-a373-5c7a-8694-8eaf0ebc69ab@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6a46509-a373-5c7a-8694-8eaf0ebc69ab@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:07:01PM +0800, Chengming Zhou wrote:
> On 2022/3/23 8:51 下午, Peter Zijlstra wrote:
> > On Tue, Mar 22, 2022 at 08:08:30PM +0800, Chengming Zhou wrote:
> > 
> >> diff --git a/kernel/events/core.c b/kernel/events/core.c
> >> index 8b5cf2aedfe6..848a3bfa9513 100644
> >> --- a/kernel/events/core.c
> >> +++ b/kernel/events/core.c
> > 
> >> @@ -843,11 +845,21 @@ static void perf_cgroup_switch(struct task_struct *task)
> >>  	 */
> >>  	local_irq_save(flags);
> >>  
> >> +	cgrp = perf_cgroup_from_task(task, NULL);
> >> +	if (cgrp == __this_cpu_read(cpu_perf_cgroup))
> >> +		goto out;

So this compares the cpu thing against the task thing, if matching, we
bail.

> >> +
> >> +	__this_cpu_write(cpu_perf_cgroup, cgrp);

Then we set cpu thing.

> >> +
> >>  	list = this_cpu_ptr(&cgrp_cpuctx_list);
> >>  	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
> >>  		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
> >>  
> >>  		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> >> +
> >> +		if (cpuctx->cgrp == cgrp)
> >> +			continue;
> >> +
> >>  		perf_pmu_disable(cpuctx->ctx.pmu);
> >>  
> >>  		cpu_ctx_sched_out(cpuctx, EVENT_ALL);

> >> +		cpuctx->cgrp = cgrp

But here we already have exactly the same pattern, we match cpuctx thing
against task thing and skip/set etc.

> > Also, I really don't see the point of cpu_perf_cgroup, cpuctx->cgrp
> > should be able to do this.
> 
> But the problem is that we have two cpuctx on the percpu list, do you
> mean we should use perf_cgroup of the first cpuctx to compare with
> the next task's perf_cgroup ?
> 
> Or we should delete the cgrp in cpuctx, and use this new percpu cpu_perf_cgroup?

I'm a bit confused, per the above, you already do exactly what the new
cpu_perf_cgroup does on the cpuctx->cgrp variable. AFAICT the only think
the new per-cpu variable does is avoid a lock, howveer:


> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -833,6 +833,7 @@ static DEFINE_PER_CPU(struct list_head,
> >   */
> >  static void perf_cgroup_switch(struct task_struct *task)
> >  {
> > +	struct perf_cgroup *cgrp;
> >  	struct perf_cpu_context *cpuctx, *tmp;
> >  	struct list_head *list;
> >  	unsigned long flags;
> > @@ -843,11 +844,20 @@ static void perf_cgroup_switch(struct ta
> >  	 */
> >  	local_irq_save(flags);
> >  
> > +	cgrp = perf_cgroup_from_task(task, NULL);
> > +
> >  	list = this_cpu_ptr(&cgrp_cpuctx_list);
> >  	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
> >  		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
> >  
> > +		if (READ_ONCE(cpuctx->cgrp == cgrp))
> > +			continue

I think we can avoid that by doing an early check, hmm?

> > +
> >  		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> > +
> > +		if (cpuctx->cgrp == cgrp)
> > +			goto next;
> > +
> >  		perf_pmu_disable(cpuctx->ctx.pmu);
> >  
> >  		cpu_ctx_sched_out(cpuctx, EVENT_ALL);
> > @@ -855,50 +865,22 @@ static void perf_cgroup_switch(struct ta
> >  		 * must not be done before ctxswout due
> >  		 * to event_filter_match() in event_sched_out()
> >  		 */
> > -		cpuctx->cgrp = perf_cgroup_from_task(task,
> > -						     &cpuctx->ctx);
> > +		WRITE_ONCE(cpuctx->cgrp, cgrp);
