Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41674C420C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbiBYKRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiBYKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:17:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B722B943
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:16:30 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EBFAC212BC;
        Fri, 25 Feb 2022 10:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645784188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r1P82MEtdqFXdkO4dbmVgIiqPz/a2BToMMSIvHNnNfo=;
        b=sOYpezKruEK6j92RK9p3JK2B+y7jwxcTHP44KUq83WaTr7c0HbezBQpulC3b0YFR57Ovz8
        Hm5D7LItqDWez15Mz3Izj68+gYX2ZnpsmidQ4cZGbdU4C20ce6zqveDnqR/D5+8APJDFhI
        YAV8p2FlBzoc7hA7IvcRQXoK5rexbgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645784188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r1P82MEtdqFXdkO4dbmVgIiqPz/a2BToMMSIvHNnNfo=;
        b=QYXOBOqpNI2hcz0SG3BBPw9XbUGv+Jy53S58ASoZRisPsHoqT7vryx8jk4hLlQ76bHOnro
        RRZYOHtvE3jX6yCQ==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BB6EBA3B87;
        Fri, 25 Feb 2022 10:16:27 +0000 (UTC)
Date:   Fri, 25 Feb 2022 10:16:25 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
Message-ID: <20220225101625.GB4363@suse.de>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
 <20220224164711.GA4363@suse.de>
 <99805673-50a1-78cd-b710-0f00ce7de809@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <99805673-50a1-78cd-b710-0f00ce7de809@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 04:15:06PM +0800, Abel Wu wrote:
> > As the overloaded mask may be updated on each idle, it could be a
> > significant source of cache misses between CPUs sharing the domain for
> > workloads that rapidly idle so there should be data on whether cache misses
> > are increased heavily. It also potentially delays the CPU reaching idle
> > but it may not be by much.
> 
> Yes, that's why I cached overloaded status in rq->overloaded. So in
> this case of short running tasks, when cpus rapidly/frequently go
> idle, the cpumask/counter are not actually updated if the cached
> status is already 0 (not overloaded).
> 

Which is a good idea in some respects. It tries to limit the number of
updates and treats it as a boolean but it's probably prone to races.

> > The filter may be out of date. It takes up to one tick to detect
> > overloaded and the filter to have a positive impact. As a CPU is not
> > guaranteed to enter idle if there is at least one CPU-bound task, it may
> > also be up to 1 tick before the mask is cleared. I'm not sure this is a
> > serious problem though as SIS would not pick the CPU with the CPU-bound
> > task anyway.
> 
> Yes, it can be out of date, but increasing the accuracy means more
> frequent update which would introduce cache issues you mentioned
> above. Rate limit the updating to tick at the LLC basis might be an
> acceptable tradeoff I presume.
> 
> > 
> > At minimum, the filter should be split out and considered first as it
> > is the most likely reason why a performance difference was measured. It
> > has some oddities like why nr_overloaded is really a boolean and as
> > it's under rq lock, it's not clear why it's atomic. The changelog
> > would ideally contain some comment on the impact to cache misses
> > if any and some sort of proof that SIS search depth is reduced which
> > https://lore.kernel.org/lkml/20210726102247.21437-2-mgorman@techsingularity.net/
> > may be some help.
> > 
> > At that point, compare the idle task balancing on top to isolate how
> > much it improves things if any and identify why existing balancing is
> > insufficient. Split out the can_migrate_task change beforehand in case it
> > is the main source of difference as opposed to the new balancing mechanism.
> > 
> 
> The nr_overloaded sits in shared domain structure thus shared in
> LLC domain and needs to be atomic_t, while rq->overloaded is a
> boolean updated under rq lock. Maybe the naming can cause some
> confusion, please lighten me up if you have better idea :)
> 

The naming doesn't help because it's not really "the number of overloaded
rq's". atomic_t would be slightly safer against parallel updates but
it's race prone. I didn't think about it deeply but I suspect that two
separate rq's could disagree on what the boolean value should be if one rq
is overloaded, the other is not and they are updating via the idle path at
the same time. This probably can happen because the locking is rq based
and the cpumask is shared. On the flip side, making it an accurate count
would result in more updates and incur cache misses as well as probably
needing a cpumask check instead of a nr_overloaded comparison to determine
if the rq is already accounted for so it costs more. You are very likely
trading accuracy versus cost of update.

Whichever choice you make, add comments on the pros/cons and describe
the limitation of either approach. e.g. if overloaded is effectively a
boolean, describe in a comment the limitations.

> And yes, I agree it would be nice if test result on SIS search
> depth can be shown, and I actually did the test, but the result
> didn't show a reduction in depth due to sched-idle balancing
> will also consume sched-idle/idle cpus. I will apply your patch
> and make some further tests on that, thanks.
> 

Just remember to use the patch to measure changes in SIS depth but
performance figures should not include the patch as the schedstat
overhead distorts results.

Also place the filter first and do any measurements of any change to
balancing versus the filter. I'm suggesting placing the filter first
because it's less controversial than a new balancer. Just be aware that
the filter alone is not a guarantee of merging as there have been a few
approaches to filtering and so far all of them had downsides on either cost
or accuracy. IIRC the only active approach to reducing search cost in SIS
is https://lore.kernel.org/all/20220207034013.599214-1-yu.c.chen@intel.com/
and it's likely to get a new version due to
https://lore.kernel.org/all/20220207135253.GF23216@worktop.programming.kicks-ass.net/.
It also updates sched_domain_shared but with a single boolean instead of
an atomic+cpumask.

-- 
Mel Gorman
SUSE Labs
