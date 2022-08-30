Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2C5A60B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiH3K01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiH3K0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:26:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73E939BBA;
        Tue, 30 Aug 2022 03:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4672A614B6;
        Tue, 30 Aug 2022 10:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2C9C433D6;
        Tue, 30 Aug 2022 10:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661855182;
        bh=1XT+vuHvOhszejKWUsM1yTB7NkXL/4mpb4qVxD2Zya8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CS+Sd2u72U6N9rSbiEfzO5UGSt+DFpstomUtQSBcMQkx7s0p78JHwKzP1ZJDSp8l3
         A+AR/4W+vXsmrxbPFv+RsCv3Wo2tSCOW+ZO6yri9MyBSn73Np8BL0B1fm2MlN7j+bm
         iSmqBJobAudDhX2mlNBTO0u4cgWEx5237CGo5GhsSUz6PowDC2NT71qdTp1Lok3ofa
         pFl+Fb8iVzB913oyIr083Ufdru4vo3Lm7ANawhXSCkqCx93V2ptn//V8pNSP36KoTE
         gS4DlPM0q0aKNFK3KEOid7GD7QH8BEZCXaSI3wS3KI8gVVYjui2yYhY3fqMTzL6Crc
         AC8H6//lOlUVA==
Date:   Tue, 30 Aug 2022 12:26:19 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220830102619.GB58291@lothringen>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:36:40PM -0400, Joel Fernandes wrote:
> On Mon, Aug 29, 2022 at 3:46 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > On Mon, Aug 29, 2022 at 12:45:40PM -0400, Joel Fernandes wrote:
> > > Hi Frederick,
> > >
> > > On 8/29/2022 9:40 AM, Frederic Weisbecker wrote:
> > > > On Fri, Aug 19, 2022 at 08:48:43PM +0000, Joel Fernandes (Google) wrote:
> > > >> Refresh tested on real ChromeOS userspace and hardware, passes boot time tests
> > > >> and rcuscale tests.
> > > >>
> > > >> Fixes on top of v3:
> > > >> - Fix boot issues due to a race in the lazy RCU logic which caused a missed
> > > >>   wakeup of the RCU GP thread, causing synchronize_rcu() to stall.
> > > >> - Fixed trace_rcu_callback tracepoint
> > > >>
> > > >> I tested power previously [1], I am in the process of testing power again but I
> > > >> wanted share my latest code as others who are testing power as well could use
> > > >> the above fixes.
> > > >
> > > > Your patch is very likely to be _generally_ useful and therefore,
> > > > the more I look into this, the more I wonder if it is a good idea to rely on
> > > > bypass at all, let alone NOCB. Of course in the long term the goal is to have
> > > > bypass working without NOCB but why even bothering implementing it for nocb
> > > > in the first place?
> > >
> > > This was discussed with Paul [1]. Quoting:
> > >
> > > ----
> > > Joel:
> > > >> Also, does doing so not prevent usage of lazy CBs on systems without
> > > >> NOCB? So if we want to future-proof this, I guess that might not be a
> > > >> good decision.
> > > >
> > > Paul:
> > > > True enough, but would this future actually arrive?  After all, if
> > > > someone cared enough about energy efficiency to use call_rcu_lazy(),
> > > > why wouldn't they also offload callbacks?
> > >
> > > Joel: I am not sure, but I also don't mind making it depend on NOCB for now
> > > (see below).
> > >
> > > [1] https://www.spinics.net/lists/rcu/msg07908.html
> > > ----
> > >
> > > While I agree with you that perhaps making it more generic is better, this did
> > > take a significant amount of time, testing and corner case hunting to come up
> > > with, and v5 is also in the works so I'd appreciate if we can do it the
> > > bypass-way and optimize later. Arguably the bypass way is quite simple and
> > > allows us to leverage its effects of rcu_barrier and such. And the API will not
> > > change.
> >
> > Keep in mind that if we later need to rewrite the whole in order to have a
> > generic approach, this will take even more time in the long run.
> 
> Agreed on that. But the use
> 
> > > > 2) NOCB without nohz_full has extremely rare usecase (RT niche:
> > > > https://lore.kernel.org/lkml/CAFzL-7vqTX-y06Kc3HaLqRWAYE0d=ms3TzVtZLn0c6ATrKD+Qw@mail.gmail.com/
> > > > )
> > >
> > > Really? Android has been using it for a long time. It seems to be quite popular
> > > in the battery-powered space.
> >
> > It's really sad that this is the first time I hear about that. I've been working
> > on this code for years now without this usecase in mind. And yet it's fundamental.
> >
> > I asked several times around about other usecases of rcu_nocbs than nohz_full=
> > and nobody reported that. I can hardly even google a significant link
> > between power saving and rcu_nocbs=
> >
> > If this is really used that way for a long time then it's a cruel disconnection
> > between users and developers.
> 
> I was not involved with Android or RCU back then. But my guess is I
> don't think it was enabled with the intent of saving power, it is just
> that using RCU_NO_CB_CPU has become the way to go to keep dynick-idle
> CPUs undisturbed: https://paulmck.livejournal.com/66807.html . Paul ,
> +Dietmar Eggemann can probably provide more history.

Thanks for the pointer!

> > > > 2) NOCB implies performance issues.
> > >
> > > Which kinds of? There is slightly worse boot times, but I'm guessing that's do
> > > with the extra scheduling overhead of the extra threads which is usually not a
> > > problem except that RCU is used in the critical path of boot up (on ChromeOS).
> >
> > I never measured it myself but executing callbacks on another CPUs, with
> > context switches and locking can only involve significant performance issues if callbacks
> > are frequent. So it's a tradeoff between power and performance.
> 
> In my testing of benchmarks on real systems with 8-16 CPUs, the
> performance hit is down in the noise. It is possible though that maybe
> one can write a non-realistic synthetic test to force the performance
> issues, but I've not seen it in the real world. Maybe on
> networking-heavy servers with lots of cores, you'll see it but their
> batteries if any would be pretty big :-).

Yeah I suspect this should have an impact on servers. And even servers may
deserve idleness sometimes.

> 
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
> > What bothers me is that struct cblist has a general purpose and we are adding a field
> > and a parameter that is relevant to only one specialized user.
> 
> To Paul's point, we can change it to a flag I think. The 3 states are:
> - no CBs.
> - All lazy
> - All non-lazy

Yeah that makes sense, should we take the generic direction!

> 
> Or, worse case, we can move the flag to the per-cpu rcu_data
> structure, I think. Does that alleviate your concern?
> 
> > > > 4) This is further complexifying bypass core code, nocb timer management, core
> > > >    nocb group management, all of which being already very complicated.
> > >
> > > True, I agree, a few more cases to handle for sure, but I think I got them all
> > > now (hopefully).
> >
> > Now I'm worried about maintainability. Hence why I'd rather see a generic code
> > for them all if possible.
> 
> Maintainability is a concern for any new code. I rely a lot on testing
> both synthetic, and real-world. I have spent a lot of time on test
> code on this.

And I thank you for that. I've always been terrible at performance/power/latency
testing so I'm always relieved when others take over on that :)

> 
> > > > So here is a proposal: how about forgetting NOCB for now and instead add a new
> > > > RCU_LAZY_TAIL segment in the struct rcu_segcblist right after RCU_NEXT_TAIL?
> > > > Then ignore that segment until some timer expiry has been met or the CPU is
> > > > known to be busy? Probably some tiny bits need to be tweaked in segcblist
> > > > management functions but probably not that much. And also make sure that entrain()
> > > > queues to RCU_LAZY_TAIL.
> > > >
> > > > Then the only difference in the case of NOCB is that we add a new timer to the
> > > > nocb group leader instead of a local timer in !NOCB.
> > >
> > > It sounds reasonable, but I'll go with Paul on the usecase argument - who would
> > > actually care about lazy CBs outside of power, and would those guys ever use
> > > !NO_CB if they cared about power / battery?
> >
> > _Everybody_ cares about power. Those who don't yet will very soon ;-)
> >
> > And given the numbers you provided with your measurements, I bet this will
> > be significant with !NOCB as well. This is not only delaying callbacks execution,
> > this also reduces the frequency of grace periods, and that impact should be
> > quite visible.
> 
> I will defer to Paul on whether the current approach is a viable
> solution. If it is not, and we are to take a different design route,
> it would be good to know that so I can cease current efforts and go
> back to the drawing board.

Ok.

> 
> >
> > Note I'm not stricly opposed to the current approach. But I can't say I'm
> > comfortable with it.
> 
> Maybe we can find a way in the code to see what can be changed. One
> concern you rightly raised is the length variables , but I think
> that's not a blocker.

That's just a detail indeed. If we proceed with the current NOCB approach I'll
give a deeper review.

> 
> > Can we do a simple test? Would it be possible to affine every rcuo%c/%d kthread
> > to the corresponding CPU%d? For example affine rcuop/1 to CPU 1, rcuop/2 to
> > CPU2, etc... And then relaunch your measurements on top of that?
> 
> We already did that and it does not help, it makes things worse. The
> decision of where to run RCU threads is best left to the scheduler
> (for both performance and power).

That's the point, we want to artificially remove NOCB advantages to get
a behaviour close to !NOCB, so that we know if it's worth expanding the
patchset to !NOCB.

Let me clarify. The point of NOCB, powerwise, is that the RCU kthreads
track and execute the callbacks to an optimized selection of CPUs, thanks to the
scheduler. And the new lazy flow optimize that further.

Now we would like to know if call_rcu_lazy() also works on !NOCB. But we have
no way to test that right now because we only have an implemention for NOCB.

But if we affine each rcuop/%d to their corresponding CPU%d, we get a behaviour
that is close to !NOCB because then the scheduler doesn't help anymore and
callbacks are executed locally (the only difference is that we do context
switches, locking and and we still have rcuog around but still, that
should give a rough idea of what we get with !NOCB).

Therefore if you test your measurements again before and after your patchset,
both with each rcuop/%d affine to their CPU%d counterpart, you should get a
comparison of before VS after your patchset on what would be an implementation
on !NOCB.

Thanks.
