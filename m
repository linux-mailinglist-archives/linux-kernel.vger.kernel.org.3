Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3414B5A62E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiH3MJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiH3MI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:08:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7FD760E1;
        Tue, 30 Aug 2022 05:08:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44A24B81625;
        Tue, 30 Aug 2022 12:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D3EC433C1;
        Tue, 30 Aug 2022 12:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661861335;
        bh=WVf0zIwSNz7QXh1sAosA0tOn/qaHav67AkrTOJOeNSU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OxVIFryQOjJvWjVh29E90hQkaa0jYuuC1q7bC7jp8mcNAJeDoL5mYd4CUNLXYkCY1
         +WJ3z4CHr+RE7Ay9avR9f9cnBUVud8g+TrBxec1DEV7InTUWAg3woPD9RUXJUMD23R
         KUxYYPjdc7CEvpS3NCtV6GLlKa65Adu+xMpaGKj3I4GjYVnOuAvyhMLCodSwGpuab/
         MUyJ9BlNvn7jhyFnActz6qRZi+fAqhX837t9RuWEYSP235PduFJoVbkOZubNgRoIq1
         nL6LrqklonfHJkh+gQ6LLDGM8fJuljbxZTckAP/mvpyIm9sZjdjF0ZDHKk1DiFDl+6
         oh58jkHdpD0PQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A9C3E5C0531; Tue, 30 Aug 2022 05:08:53 -0700 (PDT)
Date:   Tue, 30 Aug 2022 05:08:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220830120853.GU6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829195730.GO6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830104344.GA70936@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830104344.GA70936@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:43:44PM +0200, Frederic Weisbecker wrote:
> On Mon, Aug 29, 2022 at 12:57:30PM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 29, 2022 at 12:45:40PM -0400, Joel Fernandes wrote:
> > > While I agree with you that perhaps making it more generic is better, this did
> > > take a significant amount of time, testing and corner case hunting to come up
> > > with, and v5 is also in the works so I'd appreciate if we can do it the
> > > bypass-way and optimize later. Arguably the bypass way is quite simple and
> > > allows us to leverage its effects of rcu_barrier and such. And the API will not
> > > change.
> > 
> > Just confirming this conversation, on the hopefully unlikely off-chance
> > that there is any doubt.  ;-)
> > 
> > That said, if there is some compelling use case that is not addressed
> > by rcu_nocbs, keeping in mind that these can now be made dynamic, then
> > some adjustment will of course be needed.
> 
> Right there is that too.

But we do need the use case before changing the current direction.
Otherwise, all we are doing is slowing down the arrival of energy
efficiency for a very large number of systems for which we know that
there is a call_rcu_lazy() benefit.

Yes, doing the work twice might seem unattractive, but for purposes of
comparison, I did the CONFIG_RCU_FAST_NO_HZ eight or nine times before
I got something that saved significant real power on real hardware.
And in the end, CONFIG_RCU_FAST_NO_HZ was removed due to lack of use
compared to rcu_nocbs.  ;-)

> > > > Several highlights:
> > > > 
> > > > 1) NOCB is most often needed for nohz_full and the latter has terrible power
> > > > management. The CPU 0 is active all the time there.
> > > 
> > > I see. We don't use nohz_full much. NOCB itself gives good power improvement.
> > > 
> > > > 2) NOCB without nohz_full has extremely rare usecase (RT niche:
> > > > https://lore.kernel.org/lkml/CAFzL-7vqTX-y06Kc3HaLqRWAYE0d=ms3TzVtZLn0c6ATrKD+Qw@mail.gmail.com/
> > > > )
> > > 
> > > Really? Android has been using it for a long time. It seems to be quite popular
> > > in the battery-powered space.
> > > 
> > > > 2) NOCB implies performance issues.
> > > 
> > > Which kinds of? There is slightly worse boot times, but I'm guessing that's do
> > > with the extra scheduling overhead of the extra threads which is usually not a
> > > problem except that RCU is used in the critical path of boot up (on ChromeOS).
> > 
> > Back in 2010, Rik van Riel reported significant slowdowns for some types
> > of Java workloads, but for normal servers, not Android or ChromeOS.
> > I have no idea whether similar slowdowns exist today.  But if there is
> > no performance advantage to non-offloaded callbacks, we should first make
> > offloading the default, and if there are no complaints after a few years,
> > remove the non-offloaded case completely.
> 
> My gut feeling is that this is a bad idea. Yet I have no practical proof :o)

Indeed, the burden of proof is on those who believe that such slowdowns
have somehow vanished over the past 12 years.  ;-)

> > My guess is that at the very least, scheduler corner cases will force
> > us to keep non-offloaded callbacks, but you never know.  In any case,
> > a wakeup is considerably more expensive than a non-atomic OR of a bit
> > in a per-CPU variable, so there is some chance that offloading causes
> > some important workloads considerable performance degradation.
> 
> Definetly!
> 
> > 
> > > > 3) We are mixing up two very different things in a single list of callbacks:
> > > >    lazy callbacks and flooding callbacks, as a result we are adding lots of
> > > >    off-topic corner cases all around:
> > > >      * a seperate lazy len field to struct rcu_cblist whose purpose is much more
> > > >        general than just bypass/lazy
> > > >      * "lazy" specialized parameters to general purpose cblist management
> > > >        functions
> > > 
> > > I think just 1 or 2 functions have a new lazy param. It didn't seem too
> > > intrusive to me.
> > 
> > It has been getting simpler!  ;-)
> > 
> > I bet that the lazy_len field can be a boolean and independent of
> > ->cblist, and that doing that would simplify things at least a little bit.
> > But, yes, an all-lazy indicator of some sort would still need to exist.
> 
> Yeah, I'll check the patch in detail.

Much appreciated!  I believe that the upcoming v5 has some significant
differences from v4.

> > > > 4) This is further complexifying bypass core code, nocb timer management, core
> > > >    nocb group management, all of which being already very complicated.
> > > 
> > > True, I agree, a few more cases to handle for sure, but I think I got them all
> > > now (hopefully).
> > 
> > If we do need lazy callbacks on non-offloaded CPUs, there will need to
> > be changes to both the bypass logic (possibly just those changes that
> > Joel already has, but Murphy might disagree) and to the ->cblist logic.
> > At the very least, the wakeup logic would need adjustment from current
> > -rcu and there would still need to be some way of tracking whether or
> > not all the callbacks in the bypass list are lazy.
> 
> Sure but we can arrange for pushing the complexity in a common place between
> NOCB and !NOCB.

Easy to say, easy to say...  ;-)

> > > > 5) The !NOCB implementation is going to be very different
> > > > 
> > > > Ok I can admit one counter argument in favour of using NO_CB:
> > > > 
> > > > -1) The scheduler can benefit from a wake CPU to run the callbacks on behalf of a bunch
> > > > of idle CPUs, instead of waking up that bunch of CPUs. But still we are dealing
> > > > with callbacks that can actually wait...
> > 
> > You lost me on this one.  Having a callback invoked on a non-idle CPU
> > should save significant power without significant delay in callback
> > invocation.  What am I missing here?
> 
> The thing is that if the callback can wait, and does actually, then the
> advantage of call_rcu_lazy() should be visible whether the callbacks are
> offloaded or not.

Except that in common configurations of NOCB, the scheduler has much
more freedom to move the work to non-idle CPUs.  Plus in Joel et al.'s
testing, it was the reduced number of grace periods that provided the
power savings.  So if a grace period is happening anyway, then I know of
no benefit from deferring lazy callbacks.  (Which is why I was suggesting
marking laziness of RCU_NEXT_READY_TAIL as well as RCU_NEXT_TAIL.)

> > > Yeah that's huge. Significant amount of power improvement seems to come from
> > > idle CPUs not being disturbed and their corresponding timer ticks turned off for
> > > longer periods. That's experimentally confirmed (NO_CB giving significant power
> > > improvement on battery-power systems as compared to !NO_CB).
> > > 
> > > > So here is a proposal: how about forgetting NOCB for now and instead add a new
> > > > RCU_LAZY_TAIL segment in the struct rcu_segcblist right after RCU_NEXT_TAIL?
> > > > Then ignore that segment until some timer expiry has been met or the CPU is
> > > > known to be busy? Probably some tiny bits need to be tweaked in segcblist
> > > > management functions but probably not that much. And also make sure that entrain()
> > > > queues to RCU_LAZY_TAIL.
> > > > 
> > > > Then the only difference in the case of NOCB is that we add a new timer to the
> > > > nocb group leader instead of a local timer in !NOCB.
> > 
> > It is certainly good to look into alternatives!  Especially if this has
> > somehow broken (de)offloading.  (Not seeing it in my testing, but then
> > again, I have not yet tested this series all that much.)
> > 
> > How does the separate RCU_LAZY_TAIL segment help?  I would think
> > that you would instead want an all-lazy flag on each of the existing
> > RCU_NEXT_READY_TAIL and RCU_NEXT_TAIL segments.  After all, if there is
> > even one non-lazy callback in either segment, we need the corresponding
> > grace period to run sooner rather than later.  And if we are running a
> > given grace period anyway, it costs little to handle the lazy callbacks
> > while we are at it.
> 
> Good point! That sounds much better.
> 
> > Or is there a use case where it helps a lot to defer lazy callbacks that
> > could have been handled by a grace period that needed to happen anyway,
> > due to the presence of non-lazy callbacks?  I am having a hard time coming
> > up with one, but perhaps that is a failure of imagination on my part.
> 
> I don't see one right now.

Perhaps there isn't one, or perhaps Murphy is waiting to teach us both
a lesson.  ;-)

> > There would still need to be changes to the bypass code because NOCB is
> > what gets both Android and ChromeOS big power savings.
> 
> Actually using the flag on RCU_NEXT_TAIL and RCU_NEXT_READ_TAIL would
> avoid touching the bypass code.
> 
> I see a big advantage in that we don't mix up two orthogonal things anymore:
> flooding callbacks (normal bypass) and callbacks that can actually wait
> (lazy callbacks), both needing a different treatment.

At the very least, the bypass code would need to change in order to
track the laziness of the bypassing callbacks.  Plus wouldn't there
need to be some adjustment of was_alldone indication to the caller of
rcu_nocb_try_bypass() in order to avoid that caller starting a grace
period that should have been lazily deferred?  Or am I missing a trick
here?

And again, touching ->cblist increase risk to workloads that are not
yet known to benefit from call_rcu_lazy().

> > And yes, no matter what, rcu_barrier_entrain() needs to motivate any lazy
> > callbacks.  Currently, this falls out from the flushing of the bypass.
> > Presumably, offloading and deoffloading could also take advantage of
> > bypass flushing.
> > 
> > And I have no idea whether it would make sense for the NOCB and !NOCB
> > case to share a laziness-motivation timer.
> 
> No at least the timer will need to be different. It should integrate into
> the existing one in NOCB whereas !NOCB should have something more simple.

I would guess that we will find a devil or two in those details.

> > > It sounds reasonable, but I'll go with Paul on the usecase argument - who would
> > > actually care about lazy CBs outside of power, and would those guys ever use
> > > !NO_CB if they cared about power / battery?
> > 
> > And if they are not using NOCB, does call_rcu_lazy() actually help?
> 
> I suspect yes, due to the frequency of grace periods lowering.

But your suspicion rests on the assumption that server workloads often
have nothing but lazy callbacks queued, correct?

If so, what is a good way to check that assumption?  Measure the fraction
of full seconds during which nothing but lazy callbacks are queued?
Measure the fraction of grace periods that handled only lazy callbacks?

Or is there some better approach?

							Thanx, Paul
