Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C14351F1D6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 23:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiEHVgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 17:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiEHVgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 17:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A97DF29;
        Sun,  8 May 2022 14:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D707860DB6;
        Sun,  8 May 2022 21:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A5DC385AC;
        Sun,  8 May 2022 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652045543;
        bh=nRA+bETxekMJV4kJ3VQuMngCJKdiJUVudQN0BdqVkzg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L5Ew1Xd3Qko8gyXIQNTqb5e1g8OXTzMnzmAbhn6jbvGvZms1SQ85111AKddu/rlcm
         1ikBKPDJMNfIZ/2VImdcXx+FQv6QqCr65LGrYsUa0npWwav2Y6ze6PUUJm6tN4GJwO
         G+HxVwyWZacP61UNjhXcGwxylZtITa6KY+V6P6MrSuyLMuyIeSUqScQqMbsqzXTVzf
         j4G2IpM+tfgEThKmKNsFvScYvoOL3h4/w+P2EuLxsgoMvgibddLi/y7pL4smuijE68
         Nh3LW5SsDU7WlUeN37HAzZuG7nFFQi7t0ebBEB0kH44l8gElWr/sMi+2oyD5hICGuW
         sV96NtpKNdO8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BA4B75C0555; Sun,  8 May 2022 14:32:22 -0700 (PDT)
Date:   Sun, 8 May 2022 14:32:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Alison Chaiken <achaiken@aurora.tech>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <20220508213222.GL1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220505101641.28472-1-urezki@gmail.com>
 <20220505190915.GW1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnVLQozNFvgk3olP@pc638.lan>
 <20220506182425.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnY33nq5jl6FLFOu@pc638.lan>
 <20220507223247.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 02:28:49AM -0400, Joel Fernandes wrote:
> On Sat, May 7, 2022 at 6:32 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sat, May 07, 2022 at 11:11:58AM +0200, Uladzislau Rezki wrote:
> > > > On Fri, May 06, 2022 at 06:22:26PM +0200, Uladzislau Rezki wrote:
> > > > > > On Thu, May 05, 2022 at 12:16:41PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > > > > Introduce a RCU_NOCB_CPU_CB_BOOST kernel option. So a user can
> > > > > > > decide if an offloading has to be done in a high-prio context or
> > > > > > > not. Please note an option depends on RCU_NOCB_CPU and RCU_BOOST
> > > > > > > parameters and by default it is off.
> > > > > > >
> > > > > > > This patch splits the boosting preempted RCU readers and those
> > > > > > > kthreads which directly responsible for driving expedited grace
> > > > > > > periods forward with enabling/disabling the offloading from/to
> > > > > > > SCHED_FIFO/SCHED_OTHER contexts.
> > > > > > >
> > > > > > > The main reason of such split is, for example on Android there
> > > > > > > are some workloads which require fast expedited grace period to
> > > > > > > be done whereas offloading in RT context can lead to starvation
> > > > > > > and hogging a CPU for a long time what is not acceptable for
> > > > > > > latency sensitive environment. For instance:
> > > > > > >
> > > > > > > <snip>
> > > > > > > <...>-60 [006] d..1 2979.028717: rcu_batch_start: rcu_preempt CBs=34619 bl=270
> > > > > > > <snip>
> > > > > > >
> > > > > > > invoking 34 619 callbacks will take time thus making other CFS
> > > > > > > tasks waiting in run-queue to be starved due to such behaviour.
> > > > > > >
> > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > >
> > > > > > All good points!
> > > > > >
> > > > > > Some questions and comments below.
> > > > > >
> > > > > > Adding Sebastian on CC for his perspective.
> > > > > >
> > > > > >                                                 Thanx, Paul
> > > > > >
> > > > > > > ---
> > > > > > >  kernel/rcu/Kconfig     | 14 ++++++++++++++
> > > > > > >  kernel/rcu/tree.c      |  5 ++++-
> > > > > > >  kernel/rcu/tree_nocb.h |  3 ++-
> > > > > > >  3 files changed, 20 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > > > > > index 27aab870ae4c..074630b94902 100644
> > > > > > > --- a/kernel/rcu/Kconfig
> > > > > > > +++ b/kernel/rcu/Kconfig
> > > > > > > @@ -275,6 +275,20 @@ config RCU_NOCB_CPU_DEFAULT_ALL
> > > > > > >         Say Y here if you want offload all CPUs by default on boot.
> > > > > > >         Say N here if you are unsure.
> > > > > > >
> > > > > > > +config RCU_NOCB_CPU_CB_BOOST
> > > > > > > +     bool "Perform offloading from real-time kthread"
> > > > > > > +     depends on RCU_NOCB_CPU && RCU_BOOST
> > > > > > > +     default n
> > > > > >
> > > > > > I understand that you need this to default to "n" on your systems.
> > > > > > However, other groups already using callback offloading should not see
> > > > > > a sudden change.  I don't see an Android-specific defconfig file, but
> > > > > > perhaps something in drivers/android/Kconfig?
> > > > > >
> > > We saw a sudden change when the priority was lifted up for rcuop kthreads.
> > > I would like to know the reason. As for Android, i would like to avoid
> > > it to be Android specific. It is better just to enable boosting by
> > > default for nocb kthreads.
> >
> > No, because that breaks an existing use case, which uses RCU_BOOST
> > to avoid OOM on busy systems.
> >
> > > > > > One easy way to make this work would be to invert the sense of this
> > > > > > Kconfig option ("RCU_NOCB_CB_NO_BOOST"?), continue having it default to
> > > > > > "n", but then select it somewhere in drivers/android/Kconfig.  But I
> > > > > > would not be surprised if there is a better way.
> > >
> > > In that situation probably we should just enable it by default.
> >
> > You are within your rights to cause it to be enabled by default -within-
> > -Android-.  You are -not- within your rights to break other workloads.
> >
> > If ChromeOS needs it too, they too can enable it -within- -ChromeOS-.
> >
> > It is not -that- hard, guys!  ;-)
> 
> I think on the topic of RT, +Steven Rostedt should chime in as well
> considering he wrote a good chunk of the RT scheduler ;-). Personally,
> I feel the issue of "rcu callback offload" threads running as RT or
> not should not be a matter of CONFIG option or the system in concern.
> Instead it should be a function of how many callbacks there are to
> run.  The reason I say this is, RT threads should not be doing a lot
> of work anyway, lest they cause RT throttling and starvation of other
> threads.

This gets complicated surprisingly quickly.  For but one example, you
would find yourself wanting time-based boosting, most likely before you
wanted boosting based on numbers of callbacks.  And it is all too easy
to drive considerably complexity into the mix before proving that it is
really needed.  Especially given how rare the need for RCU priority
boosting is to begin with.

> Also, I think it is wrong to assume that a certain kind of system will
> always have a certain number of callbacks to process at a time. That
> seems prone to poor design due to assumptions which may not always be
> true.

Who was assuming that?  Uladzislau was measuring rather than assuming,
if that was what you were getting at.  Or if you are thinking about
things like qhimark, your point is exactly why there is both a default
(which has worked quite well for a very long time) and the ability to
adjust based on the needs of your specific system.

> Can we not have 2 sets of RCU offload threads, one which operate at RT
> and only process few callbacks at a time, while another which is the
> lower priority CFS offload thread - executes whenever there is a lot
> of CBs pending? Just a thought.

How about if we start by solving the problems we know that we have?

> Otherwise, I feel like we might be again proliferating CONFIG options
> and increasing burden on the user to get it the CONFIG right.

I bet that we will solve this without adding any new Kconfig options.
And I bet that the burden is at worst on the device designer, not on
the user.  Plus it is entirely possible that there might be a way to
automatically configure things to handle what we know about today,
again without adding Kconfig options.

							Thanx, Paul
