Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF445A5527
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiH2T6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiH2T5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:57:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D696755;
        Mon, 29 Aug 2022 12:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF2460F3C;
        Mon, 29 Aug 2022 19:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB43C433D6;
        Mon, 29 Aug 2022 19:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661803050;
        bh=UYkByX5TAD0Q+gWL2Ar4FVNX6MK35uEWPg68J9wSghs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=untBbCvCejdyNLQ+0FsDp9MgY0UCogWqvmlODiSMPk/WiAhJ7TLqd3EgoGM0Z76wR
         7SgygwNJCkHMr3rmp4anAvASrtZVRozg9gadBpCTBmWFMPqF39Fen+EJYWi4rhLqkl
         44fMFopHS5+tmZLMIj0ospVErbIzLj2R6454KBXRR15tNLNow9rsk/6gZjzdQp4DLh
         j40FREYBKgUdKGGZ4F63NOYgIzoLVZhqImzkj+zOjztMkaUX9mg2bfNKWoj164TaSf
         7Ft8qeqYhNO/WE04Cqubff70kRa3pVCH8FEptRH5WVEovTtJx+wk1uvmehGD/MhJ4z
         IARFANmYH9vlA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 53A145C055D; Mon, 29 Aug 2022 12:57:30 -0700 (PDT)
Date:   Mon, 29 Aug 2022 12:57:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220829195730.GO6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 12:45:40PM -0400, Joel Fernandes wrote:
> Hi Frederick,
> 
> On 8/29/2022 9:40 AM, Frederic Weisbecker wrote:
> > On Fri, Aug 19, 2022 at 08:48:43PM +0000, Joel Fernandes (Google) wrote:
> >> Refresh tested on real ChromeOS userspace and hardware, passes boot time tests
> >> and rcuscale tests.
> >>
> >> Fixes on top of v3:
> >> - Fix boot issues due to a race in the lazy RCU logic which caused a missed
> >>   wakeup of the RCU GP thread, causing synchronize_rcu() to stall.
> >> - Fixed trace_rcu_callback tracepoint
> >>
> >> I tested power previously [1], I am in the process of testing power again but I
> >> wanted share my latest code as others who are testing power as well could use
> >> the above fixes.
> > 
> > Your patch is very likely to be _generally_ useful and therefore,
> > the more I look into this, the more I wonder if it is a good idea to rely on
> > bypass at all, let alone NOCB. Of course in the long term the goal is to have
> > bypass working without NOCB but why even bothering implementing it for nocb
> > in the first place?
> 
> This was discussed with Paul [1]. Quoting:
> 
> ----
> Joel:
> >> Also, does doing so not prevent usage of lazy CBs on systems without
> >> NOCB? So if we want to future-proof this, I guess that might not be a
> >> good decision.
> >
> Paul:
> > True enough, but would this future actually arrive?  After all, if
> > someone cared enough about energy efficiency to use call_rcu_lazy(),
> > why wouldn't they also offload callbacks?
> 
> Joel: I am not sure, but I also don't mind making it depend on NOCB for now
> (see below).
> 
> [1] https://www.spinics.net/lists/rcu/msg07908.html
> ----
> 
> While I agree with you that perhaps making it more generic is better, this did
> take a significant amount of time, testing and corner case hunting to come up
> with, and v5 is also in the works so I'd appreciate if we can do it the
> bypass-way and optimize later. Arguably the bypass way is quite simple and
> allows us to leverage its effects of rcu_barrier and such. And the API will not
> change.

Just confirming this conversation, on the hopefully unlikely off-chance
that there is any doubt.  ;-)

That said, if there is some compelling use case that is not addressed
by rcu_nocbs, keeping in mind that these can now be made dynamic, then
some adjustment will of course be needed.

> > Several highlights:
> > 
> > 1) NOCB is most often needed for nohz_full and the latter has terrible power
> > management. The CPU 0 is active all the time there.
> 
> I see. We don't use nohz_full much. NOCB itself gives good power improvement.
> 
> > 2) NOCB without nohz_full has extremely rare usecase (RT niche:
> > https://lore.kernel.org/lkml/CAFzL-7vqTX-y06Kc3HaLqRWAYE0d=ms3TzVtZLn0c6ATrKD+Qw@mail.gmail.com/
> > )
> 
> Really? Android has been using it for a long time. It seems to be quite popular
> in the battery-powered space.
> 
> > 2) NOCB implies performance issues.
> 
> Which kinds of? There is slightly worse boot times, but I'm guessing that's do
> with the extra scheduling overhead of the extra threads which is usually not a
> problem except that RCU is used in the critical path of boot up (on ChromeOS).

Back in 2010, Rik van Riel reported significant slowdowns for some types
of Java workloads, but for normal servers, not Android or ChromeOS.
I have no idea whether similar slowdowns exist today.  But if there is
no performance advantage to non-offloaded callbacks, we should first make
offloading the default, and if there are no complaints after a few years,
remove the non-offloaded case completely.

My guess is that at the very least, scheduler corner cases will force
us to keep non-offloaded callbacks, but you never know.  In any case,
a wakeup is considerably more expensive than a non-atomic OR of a bit
in a per-CPU variable, so there is some chance that offloading causes
some important workloads considerable performance degradation.

> > 3) We are mixing up two very different things in a single list of callbacks:
> >    lazy callbacks and flooding callbacks, as a result we are adding lots of
> >    off-topic corner cases all around:
> >      * a seperate lazy len field to struct rcu_cblist whose purpose is much more
> >        general than just bypass/lazy
> >      * "lazy" specialized parameters to general purpose cblist management
> >        functions
> 
> I think just 1 or 2 functions have a new lazy param. It didn't seem too
> intrusive to me.

It has been getting simpler!  ;-)

I bet that the lazy_len field can be a boolean and independent of
->cblist, and that doing that would simplify things at least a little bit.
But, yes, an all-lazy indicator of some sort would still need to exist.

> > 4) This is further complexifying bypass core code, nocb timer management, core
> >    nocb group management, all of which being already very complicated.
> 
> True, I agree, a few more cases to handle for sure, but I think I got them all
> now (hopefully).

If we do need lazy callbacks on non-offloaded CPUs, there will need to
be changes to both the bypass logic (possibly just those changes that
Joel already has, but Murphy might disagree) and to the ->cblist logic.
At the very least, the wakeup logic would need adjustment from current
-rcu and there would still need to be some way of tracking whether or
not all the callbacks in the bypass list are lazy.

> > 5) The !NOCB implementation is going to be very different
> > 
> > Ok I can admit one counter argument in favour of using NO_CB:
> > 
> > -1) The scheduler can benefit from a wake CPU to run the callbacks on behalf of a bunch
> > of idle CPUs, instead of waking up that bunch of CPUs. But still we are dealing
> > with callbacks that can actually wait...

You lost me on this one.  Having a callback invoked on a non-idle CPU
should save significant power without significant delay in callback
invocation.  What am I missing here?

> Yeah that's huge. Significant amount of power improvement seems to come from
> idle CPUs not being disturbed and their corresponding timer ticks turned off for
> longer periods. That's experimentally confirmed (NO_CB giving significant power
> improvement on battery-power systems as compared to !NO_CB).
> 
> > So here is a proposal: how about forgetting NOCB for now and instead add a new
> > RCU_LAZY_TAIL segment in the struct rcu_segcblist right after RCU_NEXT_TAIL?
> > Then ignore that segment until some timer expiry has been met or the CPU is
> > known to be busy? Probably some tiny bits need to be tweaked in segcblist
> > management functions but probably not that much. And also make sure that entrain()
> > queues to RCU_LAZY_TAIL.
> > 
> > Then the only difference in the case of NOCB is that we add a new timer to the
> > nocb group leader instead of a local timer in !NOCB.

It is certainly good to look into alternatives!  Especially if this has
somehow broken (de)offloading.  (Not seeing it in my testing, but then
again, I have not yet tested this series all that much.)

How does the separate RCU_LAZY_TAIL segment help?  I would think
that you would instead want an all-lazy flag on each of the existing
RCU_NEXT_READY_TAIL and RCU_NEXT_TAIL segments.  After all, if there is
even one non-lazy callback in either segment, we need the corresponding
grace period to run sooner rather than later.  And if we are running a
given grace period anyway, it costs little to handle the lazy callbacks
while we are at it.

Or is there a use case where it helps a lot to defer lazy callbacks that
could have been handled by a grace period that needed to happen anyway,
due to the presence of non-lazy callbacks?  I am having a hard time coming
up with one, but perhaps that is a failure of imagination on my part.

There would still need to be changes to the bypass code because NOCB is
what gets both Android and ChromeOS big power savings.

And yes, no matter what, rcu_barrier_entrain() needs to motivate any lazy
callbacks.  Currently, this falls out from the flushing of the bypass.
Presumably, offloading and deoffloading could also take advantage of
bypass flushing.

And I have no idea whether it would make sense for the NOCB and !NOCB
case to share a laziness-motivation timer.

> It sounds reasonable, but I'll go with Paul on the usecase argument - who would
> actually care about lazy CBs outside of power, and would those guys ever use
> !NO_CB if they cared about power / battery?

And if they are not using NOCB, does call_rcu_lazy() actually help?

But again, if call_rcu_lazy() needs to handle the !NOCB case, then it
needs to handle the !NOCB case.  However, given ChromeOS and Android,
we know that it call_rcu_lazy() needs to handle the NOCB case regardless.

						Thanx, Paul
