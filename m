Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E956C5204A5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbiEISne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbiEISnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:43:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541285251F;
        Mon,  9 May 2022 11:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8D958CE1B1B;
        Mon,  9 May 2022 18:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08B4C385B2;
        Mon,  9 May 2022 18:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652121574;
        bh=XFm119uNAjqRDERrRhFqG0p28+jlG7RXHvmftj4Zo9o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jUZewNrAZscVLv1xUke5X62x7aNKrB9OhZ9JFhSpWuaPD0rX3N5YTPMMlA1f6gV+3
         MZ/xRlmDru8GjyD6TsEs9zPcXtkpIRHy10b9/2UUeGrZ8rvYoKu0bcpTFr6ToT2Wdy
         LEB3Faj9n5dDRFqfRLK+QoUX+j9hTsv13p1VZ2sxl0ogR7uINFK780RgeYG0VDev3B
         K3nIgNqgzkFZT8CUOazKZ/Jk4zfC984/wKTHmeHa/TbtG1UDmAo3wGmBh+JGvDPJIQ
         tsAX6dyouX9Cg1y1mQhvZRHpM/ixK418vCePQ9SjFMB5GRHpdnynPRU/n7IfTxmszj
         /lwhWSdenIAzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 323C25C05F9; Mon,  9 May 2022 11:39:34 -0700 (PDT)
Date:   Mon, 9 May 2022 11:39:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Chaiken <achaiken@aurora.tech>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <20220509183934.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220506182425.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnY33nq5jl6FLFOu@pc638.lan>
 <20220507223247.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com>
 <20220508213222.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ9t8gxp9cKCpba+e4NZ6ohPr8jHxJYuqRBFRtvSDa0Lw@mail.gmail.com>
 <20220509033740.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSbWetMt2_-m4G9Nt5S8ybATihB+5FMJMMo3jKDG4pPjg@mail.gmail.com>
 <20220509181417.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnldSkaWu40cVimj@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnldSkaWu40cVimj@pc638.lan>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 08:28:26PM +0200, Uladzislau Rezki wrote:
> > On Mon, May 09, 2022 at 01:17:00PM -0400, Joel Fernandes wrote:
> > > On Sun, May 8, 2022 at 11:37 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Sun, May 08, 2022 at 08:17:49PM -0400, Joel Fernandes wrote:
> > > > > On Sun, May 8, 2022 at 5:32 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >  [...]
> > > > > > > Also, I think it is wrong to assume that a certain kind of system will
> > > > > > > always have a certain number of callbacks to process at a time. That
> > > > > > > seems prone to poor design due to assumptions which may not always be
> > > > > > > true.
> > > > > >
> > > > > > Who was assuming that?  Uladzislau was measuring rather than assuming,
> > > > > > if that was what you were getting at.  Or if you are thinking about
> > > > > > things like qhimark, your point is exactly why there is both a default
> > > > > > (which has worked quite well for a very long time) and the ability to
> > > > > > adjust based on the needs of your specific system.
> > > > >
> > > > > I was merely saying that based on measurements make assumptions, but
> > > > > in the real world the assumption may not be true, then everything
> > > > > falls apart. Instead I feel, callback threads should be RT only if 1.
> > > > > As you mentioned, the time based thing. 2. If the CB list is long and
> > > > > there's lot of processing. But instead, if it is made a CONFIG option,
> > > > > then that forces a fixed behavior which may fall apart in the real
> > > > > world. I think adding more CONFIGs and special cases is more complex
> > > > > but that's my opinion.
> > > >
> > > > Again, exactly what problem are you trying to solve?
> > > >
> > > > From what I can see, Uladzislau's issue can be addressed by statically
> > > > setting the rcuo kthreads to SCHED_OTHER at boot time.  The discussion
> > > > is on exactly how RCU is to be informed of this, at kernel build time.
> > > >
> > > > > > > Can we not have 2 sets of RCU offload threads, one which operate at RT
> > > > > > > and only process few callbacks at a time, while another which is the
> > > > > > > lower priority CFS offload thread - executes whenever there is a lot
> > > > > > > of CBs pending? Just a thought.
> > > > > >
> > > > > > How about if we start by solving the problems we know that we have?
> > > > >
> > > > > I don't know why you would say that, because we are talking about
> > > > > solving the specific problem Vlad's patch addresses, not random
> > > > > problems. Which is that, Android wants to run expedited GPs, but when
> > > > > the callback list is large, the RT nocb thread can starve other
> > > > > things. Did I misunderstand the patch? If so, sorry about that but
> > > > > that's what my email was discussing. i.e. running of CBs in RT
> > > > > threads. I suck at writing well as I clearly miscommunicated.
> > > >
> > > > OK.
> > > >
> > > > Why do you believe that this needs anything other than small adjustments
> > > > the defaults of existing Kconfig options?  Or am I completely missing
> > > > the point of your proposal?
> > > >
> > > > > > > Otherwise, I feel like we might be again proliferating CONFIG options
> > > > > > > and increasing burden on the user to get it the CONFIG right.
> > > > > >
> > > > > > I bet that we will solve this without adding any new Kconfig options.
> > > > > > And I bet that the burden is at worst on the device designer, not on
> > > > > > the user.  Plus it is entirely possible that there might be a way to
> > > > > > automatically configure things to handle what we know about today,
> > > > > > again without adding Kconfig options.
> > > > >
> > > > > Yes, agreed.
> > > >
> > > > If I change my last sentence to read as follows, are we still in
> > > > agreement?
> > > >
> > > >         Plus it is entirely possible that there might be a way to
> > > >         automatically configure things to handle what we know about today,
> > > >         again without adding Kconfig options and without changing runtime
> > > >         code beyond that covered by Uladzislau's patch.
> > > 
> > > Yes, actually the automatic configuration of things is what I meant,
> > > that's the "problem" I was referring to, where the system does the
> > > right thing for a broader range of systems, without requiring the
> > > users to find RCU issues and hand-tune them (that requires said users
> > > to have tracing and debugging skills and get lucky finding a problem).
> > > To be fair, I did not propose any solutions to such problems either,
> > > it is just some ideas. I don't like knobs too much and I don't trust
> > > users or system designers to get them right most of the time.
> > > 
> > > In that sense,  I don't think making rcuo threads run as RT or not
> > > (which this patch does) is really fixing the problems. In one case,
> > > you might have priority inversion, in another case you might cause
> > > starvation. Probably what is needed is best of both worlds. That said,
> > > I don't have better solutions right now than what I mentioned, which
> > > is to assign priorities to the callbacks themselves and run them in
> > > threads of different priorities.
> > > 
> > > For the record, I am not against the patch or anything like that (and
> > > even if I was, I am not sure that it matters for merging :P)
> > 
> > Fair enough!
> > 
> > And for the record at this end, I would not be surprised if in 2032
> > RCU offloaded callback invocation has sophisticated dynamic tuning of
> > priorities and much else besides.  But one step at a time!  ;-)
> > 
> hh... It is hard to comment because i am a bit lost in this big conversation :)
> 
> What i have got so far. Joel does not like adding extra *_CONFIG
> options, actually me too since it becomes more complicated thus
> it requires more specific attention from users. I prefer to make
> the code common but it is not possible sometimes to make it common,
> because we have different kind of kernels and workloads.
> 
> >From the other hand the patch splits the BOOSTING logic into two peaces
> because driving the grace periods kthreads in RT priority is not a big
> issue because their run-times are short. Whereas running the "kthreads-callbacks"
> in the RT context can be long so we end up in throttled situation for
> other workloads.
> 
> I see that Paul would like to keep it for CONFIG_PREEMPT_RT, because it
> was mainly designed for that kind of kernels. So we can align with Alison
> patch and her decision, so i do not see any issues. So far RT folk seems
> does not mind in having "callback-kthreads" as SCHED_FIFO :)
> 
> Do you agree with start from keeping it ON for CONFIG_PREEMPT_RT conf.
> by default and OFF for other cases?

Yes, please!

This allows your current RCU_NOCB_CPU_CB_BOOST with something like
this in place of the "default n":

	default y if PREEMPT_RT
	default n if !PREEMPT_RT

There might be a simpler way of doing this, but this would work.

Could you please send a v2 with the requested updates?

						Thanx, Paul
