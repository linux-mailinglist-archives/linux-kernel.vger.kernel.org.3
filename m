Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC94F5A5593
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiH2Ubj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH2Ubg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:31:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E57857D0;
        Mon, 29 Aug 2022 13:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF2DDB81212;
        Mon, 29 Aug 2022 20:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D6AC433D6;
        Mon, 29 Aug 2022 20:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661805091;
        bh=yAcVyhR4Fp4nObm49EmGL6RuhBfk8nKoaX7upQKsAs0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MERu1m3aMzGFCNlYCUTb3O2TUUAeX5edSJ70RW+0wjgBXA1P3i7Cj4Q0/MZTepZr1
         Y5j9NGy8ieB5vytX+d+j6JCFKuzPI2r+AdAY5UanDY5X+e9Z/9MGa3xT+WZLIcZdYb
         ICpezDBi+Dur6WxSKXmWcqekiYH53rRiF9bGpdQJyHuVf22T3tCdS788XxyE6EUjV5
         AByxBs5j2UWSC7G+LBsE3C62WKXNnUUcNTR/LUvR32kL1rx3AVEHXu8J1b7rx2V/F3
         NdSVtX8NnuACfpcrRiAKO4OVr9Mk30dJAhHL7TCGFqX/QmBji8Wt2q3pUnJZWCkVLb
         MDDhGQNzeBdKg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 241C25C055D; Mon, 29 Aug 2022 13:31:31 -0700 (PDT)
Date:   Mon, 29 Aug 2022 13:31:31 -0700
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
Message-ID: <20220829203131.GP6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829194622.GA58291@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 09:46:22PM +0200, Frederic Weisbecker wrote:
> On Mon, Aug 29, 2022 at 12:45:40PM -0400, Joel Fernandes wrote:
> > Hi Frederick,
> > 
> > On 8/29/2022 9:40 AM, Frederic Weisbecker wrote:
> > > On Fri, Aug 19, 2022 at 08:48:43PM +0000, Joel Fernandes (Google) wrote:
> > >> Refresh tested on real ChromeOS userspace and hardware, passes boot time tests
> > >> and rcuscale tests.
> > >>
> > >> Fixes on top of v3:
> > >> - Fix boot issues due to a race in the lazy RCU logic which caused a missed
> > >>   wakeup of the RCU GP thread, causing synchronize_rcu() to stall.
> > >> - Fixed trace_rcu_callback tracepoint
> > >>
> > >> I tested power previously [1], I am in the process of testing power again but I
> > >> wanted share my latest code as others who are testing power as well could use
> > >> the above fixes.
> > > 
> > > Your patch is very likely to be _generally_ useful and therefore,
> > > the more I look into this, the more I wonder if it is a good idea to rely on
> > > bypass at all, let alone NOCB. Of course in the long term the goal is to have
> > > bypass working without NOCB but why even bothering implementing it for nocb
> > > in the first place?
> > 
> > This was discussed with Paul [1]. Quoting:
> > 
> > ----
> > Joel:
> > >> Also, does doing so not prevent usage of lazy CBs on systems without
> > >> NOCB? So if we want to future-proof this, I guess that might not be a
> > >> good decision.
> > >
> > Paul:
> > > True enough, but would this future actually arrive?  After all, if
> > > someone cared enough about energy efficiency to use call_rcu_lazy(),
> > > why wouldn't they also offload callbacks?
> > 
> > Joel: I am not sure, but I also don't mind making it depend on NOCB for now
> > (see below).
> > 
> > [1] https://www.spinics.net/lists/rcu/msg07908.html
> > ----
> > 
> > While I agree with you that perhaps making it more generic is better, this did
> > take a significant amount of time, testing and corner case hunting to come up
> > with, and v5 is also in the works so I'd appreciate if we can do it the
> > bypass-way and optimize later. Arguably the bypass way is quite simple and
> > allows us to leverage its effects of rcu_barrier and such. And the API will not
> > change.
> 
> Keep in mind that if we later need to rewrite the whole in order to have a
> generic approach, this will take even more time in the long run.
> 
> > > 2) NOCB without nohz_full has extremely rare usecase (RT niche:
> > > https://lore.kernel.org/lkml/CAFzL-7vqTX-y06Kc3HaLqRWAYE0d=ms3TzVtZLn0c6ATrKD+Qw@mail.gmail.com/
> > > )
> > 
> > Really? Android has been using it for a long time. It seems to be quite popular
> > in the battery-powered space.
> 
> It's really sad that this is the first time I hear about that. I've been working
> on this code for years now without this usecase in mind. And yet it's fundamental.
> 
> I asked several times around about other usecases of rcu_nocbs than nohz_full=
> and nobody reported that. I can hardly even google a significant link
> between power saving and rcu_nocbs=
> 
> If this is really used that way for a long time then it's a cruel disconnection
> between users and developers.

Knowing me, you probably asked about rcu_nocbs and I probably thought
you were asking about nohz_full.  :-/

> > > 2) NOCB implies performance issues.
> > 
> > Which kinds of? There is slightly worse boot times, but I'm guessing that's do
> > with the extra scheduling overhead of the extra threads which is usually not a
> > problem except that RCU is used in the critical path of boot up (on ChromeOS).
> 
> I never measured it myself but executing callbacks on another CPUs, with
> context switches and locking can only involve significant performance issues if callbacks
> are frequent. So it's a tradeoff between power and performance.

It has indeed been a problem for some workloads in the past.  But I don't
know of any recent measurements.  And NOCB has gotten at least somewhat
faster over the years.

> > > 3) We are mixing up two very different things in a single list of callbacks:
> > >    lazy callbacks and flooding callbacks, as a result we are adding lots of
> > >    off-topic corner cases all around:
> > >      * a seperate lazy len field to struct rcu_cblist whose purpose is much more
> > >        general than just bypass/lazy
> > >      * "lazy" specialized parameters to general purpose cblist management
> > >        functions
> > 
> > I think just 1 or 2 functions have a new lazy param. It didn't seem too
> > intrusive to me.
> 
> What bothers me is that struct cblist has a general purpose and we are adding a field
> and a parameter that is relevant to only one specialized user.

This does sound like a bad idea, now that you mention it.  Joel, if
this is still in place, can it be moved near the rcu_data structure's
bypass-related fields?

And by the way, thank you for reviewing this patch series!

> > > 4) This is further complexifying bypass core code, nocb timer management, core
> > >    nocb group management, all of which being already very complicated.
> > 
> > True, I agree, a few more cases to handle for sure, but I think I got them all
> > now (hopefully).
> 
> Now I'm worried about maintainability. Hence why I'd rather see a generic code
> for them all if possible.

Let's see what Joel's v5 looks like.

> > > 5) The !NOCB implementation is going to be very different
> > > 
> > > Ok I can admit one counter argument in favour of using NO_CB:
> > > 
> > > -1) The scheduler can benefit from a wake CPU to run the callbacks on behalf of a bunch
> > > of idle CPUs, instead of waking up that bunch of CPUs. But still we are dealing
> > > with callbacks that can actually wait...
> > 
> > Yeah that's huge. Significant amount of power improvement seems to come from
> > idle CPUs not being disturbed and their corresponding timer ticks turned off for
> > longer periods. That's experimentally confirmed (NO_CB giving significant power
> > improvement on battery-power systems as compared to !NO_CB).
> 
> It's a good news to hear that nocbs is used way beyond its initial purpose.
> But still very sad to hear about that several years late.

It came as a bit of a surprise to me as well, but was why I felt
comfortable removing CONFIG_RCU_FAST_NO_HZ.

If I remember correctly, the Android power-aware-scheduler folks first
tried it out.

> > > So here is a proposal: how about forgetting NOCB for now and instead add a new
> > > RCU_LAZY_TAIL segment in the struct rcu_segcblist right after RCU_NEXT_TAIL?
> > > Then ignore that segment until some timer expiry has been met or the CPU is
> > > known to be busy? Probably some tiny bits need to be tweaked in segcblist
> > > management functions but probably not that much. And also make sure that entrain()
> > > queues to RCU_LAZY_TAIL.
> > > 
> > > Then the only difference in the case of NOCB is that we add a new timer to the
> > > nocb group leader instead of a local timer in !NOCB.
> > 
> > It sounds reasonable, but I'll go with Paul on the usecase argument - who would
> > actually care about lazy CBs outside of power, and would those guys ever use
> > !NO_CB if they cared about power / battery?
> 
> _Everybody_ cares about power. Those who don't yet will very soon ;-)

Apparently not enough to use CONFIG_RCU_FAST_NO_HZ.  Though to be fair,
that option had its own performance issues.  And it would not reduce
grace periods anywhere near as much as call_rcu_lazy().  But the problem
was that last I checked on server workloads, the callbacks were mostly
those that could not reasonably be lazy.

> And given the numbers you provided with your measurements, I bet this will
> be significant with !NOCB as well. This is not only delaying callbacks execution,
> this also reduces the frequency of grace periods, and that impact should be
> quite visible.
> 
> Note I'm not stricly opposed to the current approach. But I can't say I'm
> comfortable with it.
> 
> Can we do a simple test? Would it be possible to affine every rcuo%c/%d kthread
> to the corresponding CPU%d? For example affine rcuop/1 to CPU 1, rcuop/2 to
> CPU2, etc... And then relaunch your measurements on top of that?
> 
> The point is that having the callback kthreads affined to their corresponding
> CPUs should elude the power saving advantages of rcu_nocbs=, back to roughly
> a !NOCB behaviour powerwise (except we have context switches). If you find good
> numbers with this setup then you'll find good numbers with !NOCB.

Another test would be to look at which callbacks are being invoked
on each grace period.  We have to have a substantial number of grace
periods having all lazy callbacks before call_rcu_lazy() has any chance
of helping.  This would need to happen on a server platform because
Android and ChromeOS data might or might not carry over.

							Thanx, Paul
