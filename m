Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FF954C10F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbiFOFML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiFOFMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:12:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A6F1A061;
        Tue, 14 Jun 2022 22:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F6D5CE1B8E;
        Wed, 15 Jun 2022 05:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E172DC34115;
        Wed, 15 Jun 2022 05:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269926;
        bh=SDEI63e9/9uZM5o98oQo7bGCVakbP20ZNncjcrDHYfg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ayPbaXTDrdyboZ8S6sUojSTGIs1xThNc9mWnmIobjSdEMwKL7176pBzPa0Ene3Hpz
         habZLmOZvQH3q02fVhab05iZVmTMq6dsHtvKMoYYhhqmmuOVFWg6V9qyT4G6IlGdrk
         a0M+k1wb9a+/yqhY/Q5KzJGONPGKx27NUmRv7JxLjY0koP5oVavELaPsHAaCDF0Q20
         c5oYaXRNDBmP4jZrugvMLRRhH+slly0PwTeGIeGMRZ/IokcjtLvpk9sitrGL0hOVko
         /arm+lNN7cI0Itd8AwYdLUU/VxmqYlkk2G2nSdhm1DDs+QzrORfnPb4uaRCO9SuqGQ
         pNh+L/0dmNbqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7F7C35C0BCC; Tue, 14 Jun 2022 22:12:05 -0700 (PDT)
Date:   Tue, 14 Jun 2022 22:12:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] rcu/kvfree: Introduce KFREE_DRAIN_JIFFIES_[MAX/MIN]
 interval
Message-ID: <20220615051205.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220602080644.432156-1-urezki@gmail.com>
 <20220602080644.432156-2-urezki@gmail.com>
 <20220604155108.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpxzB3/HRN/EEHa8@pc638.lan>
 <20220607034710.GE1790663@paulmck-ThinkPad-P17-Gen-1>
 <CA+KHdyXU1apQQbVVZ_zX7o86Qp-AQnif2u8aJFULqHNtfCGcSA@mail.gmail.com>
 <YqN1QqRmPpchDm/k@google.com>
 <YqcHrIMefthWe0t4@pc638.lan>
 <YqgtuBXW5pW4ivD/@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqgtuBXW5pW4ivD/@pc638.lan>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 08:42:00AM +0200, Uladzislau Rezki wrote:
> > Hello, Joel, Paul.
> > 
> > > Hi Vlad, Paul,
> > > 
> > > On Thu, Jun 09, 2022 at 03:10:57PM +0200, Uladzislau Rezki wrote:
> > > > On Tue, Jun 7, 2022 at 5:47 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Sun, Jun 05, 2022 at 11:10:31AM +0200, Uladzislau Rezki wrote:
> > > > > > > On Thu, Jun 02, 2022 at 10:06:44AM +0200, Uladzislau Rezki (Sony) wrote:
> > > > > > > > Currently the monitor work is scheduled with a fixed interval that
> > > > > > > > is HZ/20 or each 50 milliseconds. The drawback of such approach is
> > > > > > > > a low utilization of page slot in some scenarios. The page can store
> > > > > > > > up to 512 records. For example on Android system it can look like:
> > > > > > > >
> > > > > > > > <snip>
> > > > > > > >   kworker/3:0-13872   [003] .... 11286.007048: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=1
> > > > > > > >   kworker/3:0-13872   [003] .... 11286.015638: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> > > > > > > >   kworker/1:2-20434   [001] .... 11286.051230: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> > > > > > > >   kworker/1:2-20434   [001] .... 11286.059322: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=2
> > > > > > > >   kworker/0:1-20052   [000] .... 11286.095295: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=2
> > > > > > > >   kworker/0:1-20052   [000] .... 11286.103418: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=1
> > > > > > > >   kworker/2:3-14372   [002] .... 11286.135155: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> > > > > > > >   kworker/2:3-14372   [002] .... 11286.135198: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> > > > > > > >   kworker/1:2-20434   [001] .... 11286.155377: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=5
> > > > > > > >   kworker/2:3-14372   [002] .... 11286.167181: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=5
> > > > > > > >   kworker/1:2-20434   [001] .... 11286.179202: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000008ef95e14 nr_records=1
> > > > > > > >   kworker/2:3-14372   [002] .... 11286.187398: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000c597d297 nr_records=6
> > > > > > > >   kworker/3:0-13872   [003] .... 11286.187445: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000050bf92e2 nr_records=3
> > > > > > > >   kworker/1:2-20434   [001] .... 11286.198975: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=4
> > > > > > > >   kworker/1:2-20434   [001] .... 11286.207203: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=4
> > > > > > > > <snip>
> > > > > > > >
> > > > > > > > where a page only carries few records to reclaim a memory. In order to
> > > > > > > > improve batching and make utilization more efficient the patch introduces
> > > > > > > > a drain interval that can be set either to KFREE_DRAIN_JIFFIES_MAX or
> > > > > > > > KFREE_DRAIN_JIFFIES_MIN. It is adjusted if a flood is detected, in this
> > > > > > > > case a memory reclaim occurs more often whereas in mostly idle cases the
> > > > > > > > interval is set to its maximum timeout that improves the utilization of
> > > > > > > > page slots.
> > > > > > > >
> > > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > >
> > > > > > > That does look like a problem well worth solving!
> > > > > > >
> > > > > > Agree, better ideas make better final solution :)
> > > > > >
> > > > > > >
> > > > > > > But I am missing one thing. If we are having a callback flood, why do we
> > > > > > > need a shorter timeout?
> > > > > > >
> > > > > > To offload faster, because otherwise we run into classical issue, it is a low
> > > > > > memory condition state resulting in OOM.
> > > > >
> > > > > But doesn't each callback queued during the flood give us an opportunity
> > > > > to react to the flood?  That will be way more fine-grained than any
> > > > > reasonable timer, right?  Or am I missing something?
> > > > >
> > > > We can set the timer to zero or to current "jiffies" to initiate the
> > > > offloading if the
> > > > page is full. In that sense probably it make sense to propagate those two attr.
> > > > to user space, so the user can configure min/max drain interval.
> > > > 
> > > > Or we can only deal with fixed interval exposed via sysfs to control it by user.
> > > > In that case we can get rid of MIN one and just trigger a timer if the page is
> > > > full. I think this approach is better.
> > > 
> > > Yes I also think triggering timer with zero-timeout is better. Can you (Vlad)
> > > accomplish that by just calling the timer callback inline, instead of queuing
> > > a timer? I imagine you would just do queue_work() instead of
> > > queue_delayed_work() in this scenario.
> > > 
> > > > > I do agree that the action would often need to be indirect to avoid the
> > > > > memory-allocation-state hassles, but we already can do that, either via
> > > > > an extremely short-term hrtimer or something like irq-work.
> > > > >
> > > > > > > Wouldn't a check on the number of blocks queued be simpler, more direct,
> > > > > > > and provide faster response to the start of a callback flood?
> > > > > > >
> > > > > > I rely on krcp->count because not always we can store the pointer in the page
> > > > > > slots. We can not allocate a page in the caller context thus we use page-cache
> > > > > > worker that fills the cache in normal context. While it populates the cache,
> > > > > > pointers temporary are queued to the linked-list.
> > > > > >
> > > > > > Any thoughts?
> > > > >
> > > > > There are a great many ways to approach this.  One of them is to maintain
> > > > > a per-CPU free-running counter of kvfree_rcu() calls, and to reset this
> > > > > counter each jiffy.
> > > > >
> > > > > Or am I missing a trick here?
> > > > >
> > > > Do you mean to have a per-cpu timer that checks the per-cpu-freed counter
> > > > and schedule the work when if it is needed? Or i have missed your point?
> > > 
> > > I think he (Paul) is describing the way 'flood detection' can work similar to how the
> > > bypass list code is implemented. There he maintains a count which only if
> > > exceeds a limit, will queue on to the bypass list.
> > > 
> > OK, i see that. We also do similar thing. We say it is a flood - when a
> > page becomes full, so it is kind of threshold that we pass.
> > 
> > > This code:
> > > 
> > >         // If we have advanced to a new jiffy, reset counts to allow
> > >         // moving back from ->nocb_bypass to ->cblist.
> > >         if (j == rdp->nocb_nobypass_last) {
> > >                 c = rdp->nocb_nobypass_count + 1;
> > >         } else {
> > >                 WRITE_ONCE(rdp->nocb_nobypass_last, j);
> > >                 c = rdp->nocb_nobypass_count - nocb_nobypass_lim_per_jiffy;
> > >                 if (ULONG_CMP_LT(rdp->nocb_nobypass_count,
> > >                                  nocb_nobypass_lim_per_jiffy))
> > >                         c = 0;
> > >                 else if (c > nocb_nobypass_lim_per_jiffy)
> > >                         c = nocb_nobypass_lim_per_jiffy;
> > >         }
> > >         WRITE_ONCE(rdp->nocb_nobypass_count, c);
> > > 
> > > 
> > > Your (Vlad's) approach OTOH is also fine to me, you check if page is full and
> > > make that as a 'flood is happening' detector.
> > > 
> > OK, thank you Joel. I also think, that way we improve batching and utilization
> > of the page what is actually an intention of the patch in question.
> > 
> Paul, will you pick this patch?

I did pick up the first one:

16224f4cdf03 ("rcu/kvfree: Remove useless monitor_todo flag")

On the second one, if you use page-fill as your flood detector, can't
you simplify things by just using the one longer timeout, as discussed
in this thread?

Or did I miss a turn somewhere?

							Thanx, Paul

> Thanks!
> 
> --
> Uladzislau Rezki
