Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00835AE507
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiIFKKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiIFKKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:10:49 -0400
Received: from outbound-smtp62.blacknight.com (outbound-smtp62.blacknight.com [46.22.136.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D8831EF2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:10:46 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 984DAFACC6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:10:45 +0100 (IST)
Received: (qmail 11564 invoked from network); 6 Sep 2022 10:10:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Sep 2022 10:10:45 -0000
Date:   Tue, 6 Sep 2022 10:57:17 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Message-ID: <20220906095717.maao4qtel4fhbmfq@techsingularity.net>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <20220829130831.odhemmcmuecqxkbz@techsingularity.net>
 <51009414-5ffb-b6ec-a501-7b2514a0f3cc@bytedance.com>
 <20220829145621.7cxrywgxow5ov7ki@techsingularity.net>
 <0ffb0903-431f-88fe-3a56-150b283f5304@bytedance.com>
 <20220902102528.keooutttg3hq3sy5@techsingularity.net>
 <1fc40679-b7c3-24f2-aa27-f1edab71228e@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1fc40679-b7c3-24f2-aa27-f1edab71228e@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 10:40:00PM +0800, Abel Wu wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6089251a4720..59b27a2ef465 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6427,21 +6427,36 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >   		if (sd_share) {
> >   			/* because !--nr is the condition to stop scan */
> >   			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
> > -			/* overloaded LLC is unlikely to have idle cpu/core */
> > -			if (nr == 1)
> > -				return -1;
> > +
> > +			/*
> > +			 * Non-overloaded case: Scan full domain if there is
> > +			 * 	an idle core. Otherwise, scan for an idle
> > +			 * 	CPU based on nr_idle_scan
> > +			 * Overloaded case: Unlikely to have an idle CPU but
> > +			 * 	conduct a limited scan if there is potentially
> > +			 * 	an idle core.
> > +			 */
> > +			if (nr > 1) {
> > +				if (has_idle_core)
> > +					nr = sd->span_weight;
> > +			} else {
> > +				if (!has_idle_core)
> > +					return -1;
> > +				nr = 2;
> > +			}
> >   		}
> >   	}
> >   	for_each_cpu_wrap(cpu, cpus, target + 1) {
> > +		if (!--nr)
> > +			break;
> > +
> >   		if (has_idle_core) {
> >   			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >   			if ((unsigned int)i < nr_cpumask_bits)
> >   				return i;
> >   		} else {
> > -			if (!--nr)
> > -				return -1;
> >   			idle_cpu = __select_idle_cpu(cpu, p);
> >   			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >   				break;
> 
> I spent last few days testing this, with 3 variations (assume
> has_idle_core):
> 
>  a) full or limited (2cores) scan when !nr_idle_scan
>  b) whether clear sds->has_idle_core when partial scan failed
>  c) scale scan depth with load or not
> 
> some observations:
> 
>  1) It seems always bad if not clear sds->has_idle_core when
>     partial scan fails. It is due to over partially scanned
>     but still can not find an idle core. (Following ones are
>     based on clearing has_idle_core even in partial scans.)
> 

Ok, that's rational. There will be corner cases where there was no idle
CPU near the target when there is an idle core far away but it would be
counter to the purpose of SIS_UTIL to care about that corner case.

>  2) Unconditionally full scan when has_idle_core is not good
>     for netperf_{udp,tcp} and tbench4. It is probably because
>     the SIS success rate of these workloads is already high
>     enough (netperf ~= 100%, tbench4 ~= 50%, compared to that
>     hackbench ~= 3.5%) which negate a lot of the benefit full
>     scan brings.
> 

That's also rational. For a single client/server on netperf, it's expected
that the SIS success rate is high and scanning is minimal. As the client
and server are sharing data on localhost and somewhat synchronous, it may
even partially benefit from SMT sharing.

So basic approach would be "always clear sds->has_idle_core" + "limit
scan even when has_idle_core is true", right?

If so, stick a changelog on it and resend!

>  3) Scaling scan depth with load seems good for the hackbench
>     socket tests, and neutral in pipe tests. And I think this
>     is just the case you mentioned before, under fast wake-up
>     workloads the has_idle_core will become not that reliable,
>     so a full scan won't always win.
> 

My recommendation is leave this out for now but assuming the rest of
the patches get picked up, consider posting it for the next major kernel
version (i.e. separate the basic and clever approaches by one major kernel
version). By separating them, there is less chance of a false positive
bisection pointing to the wrong patch. Any regression will not be perfectly
reproducible so the changes of a false positive bisection is relatively high.

-- 
Mel Gorman
SUSE Labs
