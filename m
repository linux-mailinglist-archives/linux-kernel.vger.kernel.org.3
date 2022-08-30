Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D645A6126
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiH3Ku4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiH3KuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BB61A39B;
        Tue, 30 Aug 2022 03:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D23DD60B8A;
        Tue, 30 Aug 2022 10:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB13C433D6;
        Tue, 30 Aug 2022 10:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661856605;
        bh=5zv8W9z3kEX6VLd73dgxcZrGz10KMFZOlfooDLr1Zhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s8AdVO8SRaItH1cCotJE4Wngtw5G6UpxqfKvJXh/dbi4RLw93FGQnvcgsCTwLbHhL
         iCwKFriDlyKbMogSZ7FSaT/3wS8aPUeTbPD3it0/wxnXhaGSQb9ZtxB/ZNB4cUjTcT
         qr7Nd3h4DpwQ6Gl57JRqkBM1pFhw1fkM/QNZEthUk7GwYd17xgNNbN0CVzYF8XOTzn
         YEGxqFGKqiadNuNX/6w3vMPinQeEWyhNIiDGxIOv2H1mIhN+IkDy0wkAlazmERnkto
         TdwsZtuU0aL54otjHvieBLcTQAKVB1miKNqDRT3DHfH+Pfr0ke58fbfb1prU29cPct
         Ly5AeYe+Kwo/A==
Date:   Tue, 30 Aug 2022 12:50:02 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220830105002.GB70936@lothringen>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <20220829203131.GP6159@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829203131.GP6159@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 01:31:31PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 29, 2022 at 09:46:22PM +0200, Frederic Weisbecker wrote:
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
> Knowing me, you probably asked about rcu_nocbs and I probably thought
> you were asking about nohz_full.  :-/

Can't remember but no big deal, now we know about it and we can move forward
with that in mind.

> 
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
> It has indeed been a problem for some workloads in the past.  But I don't
> know of any recent measurements.  And NOCB has gotten at least somewhat
> faster over the years.

I should try a comparison on a simple kernel build someday.

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
> This does sound like a bad idea, now that you mention it.  Joel, if
> this is still in place, can it be moved near the rcu_data structure's
> bypass-related fields?
> 
> And by the way, thank you for reviewing this patch series!

I'll go into a deeper review if we proceed.

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
> 
> Apparently not enough to use CONFIG_RCU_FAST_NO_HZ.  Though to be fair,
> that option had its own performance issues.  And it would not reduce
> grace periods anywhere near as much as call_rcu_lazy().  But the problem
> was that last I checked on server workloads, the callbacks were mostly
> those that could not reasonably be lazy.

Right, but like I said, even servers can sometimes find a moment to think about
their good life.

> > And given the numbers you provided with your measurements, I bet this will
> > be significant with !NOCB as well. This is not only delaying callbacks execution,
> > this also reduces the frequency of grace periods, and that impact should be
> > quite visible.
> > 
> > Note I'm not stricly opposed to the current approach. But I can't say I'm
> > comfortable with it.
> > 
> > Can we do a simple test? Would it be possible to affine every rcuo%c/%d kthread
> > to the corresponding CPU%d? For example affine rcuop/1 to CPU 1, rcuop/2 to
> > CPU2, etc... And then relaunch your measurements on top of that?
> > 
> > The point is that having the callback kthreads affined to their corresponding
> > CPUs should elude the power saving advantages of rcu_nocbs=, back to roughly
> > a !NOCB behaviour powerwise (except we have context switches). If you find good
> > numbers with this setup then you'll find good numbers with !NOCB.
> 
> Another test would be to look at which callbacks are being invoked
> on each grace period.  We have to have a substantial number of grace
> periods having all lazy callbacks before call_rcu_lazy() has any chance
> of helping.  This would need to happen on a server platform because
> Android and ChromeOS data might or might not carry over.

Also that yes.

Thanks.
