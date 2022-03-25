Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE6E4E7182
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346155AbiCYKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244975AbiCYKtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:49:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD931178;
        Fri, 25 Mar 2022 03:48:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1C2C71F745;
        Fri, 25 Mar 2022 10:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648205283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJlsTArYp0bxPhOxO1ha2kRrFs5TdxNwAkpXKaPVCcc=;
        b=goDoFNEtAIF/ukC99oceWIA86xrIhVKTMnwXKrRfUJTGt/LzRq09DZdLxevEx8kXXJl/Bj
        zDzCh/6nkm6WUwIL8PY4xcJW4OIjIQdGY3dQddOAGUd2zDFiAXGvcFa7jrg38Wu5ca4kpw
        Ntc5GWvuwfWqNjugs182i4gY+yILUQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648205283;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJlsTArYp0bxPhOxO1ha2kRrFs5TdxNwAkpXKaPVCcc=;
        b=xAetQyGZGhuU5Z5Ba2e+B+pDYyZB987R4slRmr234a5D83K0InAZyybTII+mvnXtGYDkoh
        5SWtQ9txK0dYI7BQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D125A3B92;
        Fri, 25 Mar 2022 10:48:02 +0000 (UTC)
Date:   Fri, 25 Mar 2022 10:48:00 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mtosatti@redhat.com, linux-rt-users@vger.kernel.org,
        vbabka@suse.cz, cl@linux.com, paulmck@kernel.org,
        willy@infradead.org
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
Message-ID: <20220325104800.GI4363@suse.de>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
 <20220303114550.GE4363@suse.de>
 <3c24840e8378c69224974f321ec5c06a36a33dd3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3c24840e8378c69224974f321ec5c06a36a33dd3.camel@redhat.com>
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

On Thu, Mar 24, 2022 at 07:59:56PM +0100, Nicolas Saenz Julienne wrote:
> Hi Mel,
> 
> On Thu, 2022-03-03 at 11:45 +0000, Mel Gorman wrote:
> > For unrelated reasons I looked at using llist to avoid locks entirely. It
> > turns out it's not possible and needs a lock. We know "local_locks to
> > per-cpu spinlocks" took a large penalty so I considered alternatives on
> > how a lock could be used.  I found it's possible to both remote drain
> > the lists and avoid the disable/enable of IRQs entirely as long as a
> > preempting IRQ is willing to take the zone lock instead (should be very
> > rare). The IRQ part is a bit hairy though as softirqs are also a problem
> > and preempt-rt needs different rules and the llist has to sort PCP
> > refills which might be a loss in total. However, the remote draining may
> > still be interesting. The full series is at
> > https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ mm-pcpllist-v1r2
> > 
> > It's still waiting on tests to complete and not all the changelogs are
> > complete which is why it's not posted.
> > 
> > This is a comparison of vanilla vs "local_locks to per-cpu spinlocks"
> > versus the git series up to "mm/page_alloc: Remotely drain per-cpu lists"
> > for the page faulting microbench I originally complained about.  The test
> > machine is a 2-socket CascadeLake machine.
> > 
> > pft timings
> >                                  5.17.0-rc5             5.17.0-rc5             5.17.0-rc5
> >                                     vanilla    mm-remotedrain-v2r1       mm-pcpdrain-v1r1
> > Amean     elapsed-1        32.54 (   0.00%)       33.08 *  -1.66%*       32.82 *  -0.86%*
> > Amean     elapsed-4         8.66 (   0.00%)        9.24 *  -6.72%*        8.69 *  -0.38%*
> > Amean     elapsed-7         5.02 (   0.00%)        5.43 *  -8.16%*        5.05 *  -0.55%*
> > Amean     elapsed-12        3.07 (   0.00%)        3.38 * -10.00%*        3.09 *  -0.72%*
> > Amean     elapsed-21        2.36 (   0.00%)        2.38 *  -0.89%*        2.19 *   7.39%*
> > Amean     elapsed-30        1.75 (   0.00%)        1.87 *  -6.50%*        1.62 *   7.59%*
> > Amean     elapsed-48        1.71 (   0.00%)        2.00 * -17.32%*        1.71 (  -0.08%)
> > Amean     elapsed-79        1.56 (   0.00%)        1.62 *  -3.84%*        1.56 (  -0.02%)
> > Amean     elapsed-80        1.57 (   0.00%)        1.65 *  -5.31%*        1.57 (  -0.04%)
> > 
> > Note the local_lock conversion took 1 1-17% penalty while the git tree
> > takes a negligile penalty while still allowing remote drains. It might
> > have some potential while being less complex than the RCU approach.
> 
> I finally got some time to look at this and made some progress:
> 
> First, I belive your 'mm-remotedrain-v2r1' results are wrong/inflated due to a
> bug in my series. Essentially, all 'this_cpu_ptr()' calls should've been
> 'raw_cpu_ptr()' and your build, which I bet enables CONFIG_DEBUG_PREEMPT,

I no longer have the logs but it could have and I didn't check the
dmesg at the time to see if there were warnings in it. It really should
add something to parse that log and automatically report if there are
unexpected warnings, oops or prove-locking warnings if enabled.

> wasted time trowing warnings about per-cpu variable usage with preemption
> enabled. Making the overall performance look worse than it actually is. My
> build didn't enable it, which made me miss this whole issue. I'm sorry for the
> noise and time wasted on such a silly thing. Note that the local_lock to
> spin_lock conversion can handle the preeemption alright, it is part of the
> design[1].
> 
> As for your idea of not disabling interrupts in the hot paths, it seems to
> close the performance gap created by the lock conversion. That said, I'm not
> sure I understand why you find the need to keep the local_locks around, not
> only it casuses problems for RT systems, but IIUC they aren't really protecting
> anything other than the 'this_cpu_ptr()' usage (which isn't really needed).

The local lock was preserved because something has to stabilise the per-cpu
pointer due to preemption and migration.  On !RT, that's a preempt_disable
and on RT it's a spinlock both which prevent a migration. The secondary
goal of using local lock was to allow some allocations to be done without
disabling IRQs at all with the penalty that an IRQ arriving in at the
wrong time will have to allocate directly from the buddy lists which
should be rare.

> I
> rewrote your patch on top of my lock conversion series and I'm in the process
> of testing it on multiple systems[2].
> 
> Let me know what you think.
> Thanks!
> 
> [1] It follows this pattern:
> 
> 	struct per_cpu_pages *pcp;
> 
> 	pcp = raw_cpu_ptr(page_zone(page)->per_cpu_pageset);
> 	// <- Migration here is OK: spin_lock protects vs eventual pcplist
> 	// access from local CPU as long as all list access happens through the
> 	// pcp pointer.
> 	spin_lock(&pcp->lock);
> 	do_stuff_with_pcp_lists(pcp);
> 	spin_unlock(&pcp->lock);
> 

And this was the part I am concerned with. We are accessing a PCP
structure that is not necessarily the one belonging to the CPU we
are currently running on. This type of pattern is warned about in
Documentation/locking/locktypes.rst

---8<---
A typical scenario is protection of per-CPU variables in thread context::

  struct foo *p = get_cpu_ptr(&var1);

  spin_lock(&p->lock);
  p->count += this_cpu_read(var2);

This is correct code on a non-PREEMPT_RT kernel, but on a PREEMPT_RT kernel
this breaks. The PREEMPT_RT-specific change of spinlock_t semantics does
not allow to acquire p->lock because get_cpu_ptr() implicitly disables
preemption. The following substitution works on both kernels::
---8<---

Now we don't explicitly have this pattern because there isn't an
obvious this_cpu_read() for example but it can accidentally happen for
counting. __count_zid_vm_events -> __count_vm_events -> raw_cpu_add is
an example although a harmless one.

Any of the mod_page_state ones are more problematic though because we
lock one PCP but potentially update the per-cpu pcp stats of another CPU
of a different PCP that we have not locked and those counters must be
accurate.

It *might* still be safe but it's subtle, it could be easily accidentally
broken in the future and it would be hard to detect because it would be
very slow corruption of VM counters like NR_FREE_PAGES that must be
accurate.

-- 
Mel Gorman
SUSE Labs
