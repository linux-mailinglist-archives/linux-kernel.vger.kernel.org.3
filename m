Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49016520454
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbiEISSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbiEISSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF871B7937;
        Mon,  9 May 2022 11:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A73561602;
        Mon,  9 May 2022 18:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE0EC385B5;
        Mon,  9 May 2022 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652120057;
        bh=6Mwc6lR7327cRCAT/2yvwPPLCImmc8bAG3Wg5aFZMXM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=b6NG7XhQbR4i8VEnP0w1HJ3/e83chIx86ngqSSzoYRoIMuY6Ru7k/jRo0+it7dFoQ
         iJ6wDk8DmL46q2kidQpsEnqx3ZGElO1kykWZ3PFlsNA1yomKgJnvQd/5moj5txQG+g
         7wWio9a7kyzE/nr3IVjNAYHA0QmmMxnTYOvxBMd06kyDbe6XVE7G/BGsiwZ7NIN/Q7
         CTVjGGEpjWLUSFyCTEKS4rxBxwGgASQovJVh8tapccWmgMhlDXH/3uSTnCBZwcf15O
         I2oshRAtaXsgTvE1UoTo4HQh+23rCrLESCrAuxLVK4kc0LTIyC8lW/pIEsKBY+rOxF
         0C56WCcV4wIYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6C5C65C05F9; Mon,  9 May 2022 11:14:17 -0700 (PDT)
Date:   Mon, 9 May 2022 11:14:17 -0700
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
Message-ID: <20220509181417.GO1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220505190915.GW1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnVLQozNFvgk3olP@pc638.lan>
 <20220506182425.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnY33nq5jl6FLFOu@pc638.lan>
 <20220507223247.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com>
 <20220508213222.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ9t8gxp9cKCpba+e4NZ6ohPr8jHxJYuqRBFRtvSDa0Lw@mail.gmail.com>
 <20220509033740.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSbWetMt2_-m4G9Nt5S8ybATihB+5FMJMMo3jKDG4pPjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSbWetMt2_-m4G9Nt5S8ybATihB+5FMJMMo3jKDG4pPjg@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 01:17:00PM -0400, Joel Fernandes wrote:
> On Sun, May 8, 2022 at 11:37 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sun, May 08, 2022 at 08:17:49PM -0400, Joel Fernandes wrote:
> > > On Sun, May 8, 2022 at 5:32 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>  [...]
> > > > > Also, I think it is wrong to assume that a certain kind of system will
> > > > > always have a certain number of callbacks to process at a time. That
> > > > > seems prone to poor design due to assumptions which may not always be
> > > > > true.
> > > >
> > > > Who was assuming that?  Uladzislau was measuring rather than assuming,
> > > > if that was what you were getting at.  Or if you are thinking about
> > > > things like qhimark, your point is exactly why there is both a default
> > > > (which has worked quite well for a very long time) and the ability to
> > > > adjust based on the needs of your specific system.
> > >
> > > I was merely saying that based on measurements make assumptions, but
> > > in the real world the assumption may not be true, then everything
> > > falls apart. Instead I feel, callback threads should be RT only if 1.
> > > As you mentioned, the time based thing. 2. If the CB list is long and
> > > there's lot of processing. But instead, if it is made a CONFIG option,
> > > then that forces a fixed behavior which may fall apart in the real
> > > world. I think adding more CONFIGs and special cases is more complex
> > > but that's my opinion.
> >
> > Again, exactly what problem are you trying to solve?
> >
> > From what I can see, Uladzislau's issue can be addressed by statically
> > setting the rcuo kthreads to SCHED_OTHER at boot time.  The discussion
> > is on exactly how RCU is to be informed of this, at kernel build time.
> >
> > > > > Can we not have 2 sets of RCU offload threads, one which operate at RT
> > > > > and only process few callbacks at a time, while another which is the
> > > > > lower priority CFS offload thread - executes whenever there is a lot
> > > > > of CBs pending? Just a thought.
> > > >
> > > > How about if we start by solving the problems we know that we have?
> > >
> > > I don't know why you would say that, because we are talking about
> > > solving the specific problem Vlad's patch addresses, not random
> > > problems. Which is that, Android wants to run expedited GPs, but when
> > > the callback list is large, the RT nocb thread can starve other
> > > things. Did I misunderstand the patch? If so, sorry about that but
> > > that's what my email was discussing. i.e. running of CBs in RT
> > > threads. I suck at writing well as I clearly miscommunicated.
> >
> > OK.
> >
> > Why do you believe that this needs anything other than small adjustments
> > the defaults of existing Kconfig options?  Or am I completely missing
> > the point of your proposal?
> >
> > > > > Otherwise, I feel like we might be again proliferating CONFIG options
> > > > > and increasing burden on the user to get it the CONFIG right.
> > > >
> > > > I bet that we will solve this without adding any new Kconfig options.
> > > > And I bet that the burden is at worst on the device designer, not on
> > > > the user.  Plus it is entirely possible that there might be a way to
> > > > automatically configure things to handle what we know about today,
> > > > again without adding Kconfig options.
> > >
> > > Yes, agreed.
> >
> > If I change my last sentence to read as follows, are we still in
> > agreement?
> >
> >         Plus it is entirely possible that there might be a way to
> >         automatically configure things to handle what we know about today,
> >         again without adding Kconfig options and without changing runtime
> >         code beyond that covered by Uladzislau's patch.
> 
> Yes, actually the automatic configuration of things is what I meant,
> that's the "problem" I was referring to, where the system does the
> right thing for a broader range of systems, without requiring the
> users to find RCU issues and hand-tune them (that requires said users
> to have tracing and debugging skills and get lucky finding a problem).
> To be fair, I did not propose any solutions to such problems either,
> it is just some ideas. I don't like knobs too much and I don't trust
> users or system designers to get them right most of the time.
> 
> In that sense,  I don't think making rcuo threads run as RT or not
> (which this patch does) is really fixing the problems. In one case,
> you might have priority inversion, in another case you might cause
> starvation. Probably what is needed is best of both worlds. That said,
> I don't have better solutions right now than what I mentioned, which
> is to assign priorities to the callbacks themselves and run them in
> threads of different priorities.
> 
> For the record, I am not against the patch or anything like that (and
> even if I was, I am not sure that it matters for merging :P)

Fair enough!

And for the record at this end, I would not be surprised if in 2032
RCU offloaded callback invocation has sophisticated dynamic tuning of
priorities and much else besides.  But one step at a time!  ;-)

							Thanx, Paul
