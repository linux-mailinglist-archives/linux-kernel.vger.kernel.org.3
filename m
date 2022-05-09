Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9500051F310
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiEIDvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiEIDle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2F874DD6;
        Sun,  8 May 2022 20:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAE5E61003;
        Mon,  9 May 2022 03:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2247DC385AE;
        Mon,  9 May 2022 03:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652067461;
        bh=PXmaQUPKWn6FIRhLSdrppCDTsYvhjxB5E2sIHwZBn6E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ojOg4aCEQ07DdQf6iMb7EjlpRO6Lcea+7YD9FfUrIiww1ip1Yjqd5DcrrKbwAcmRn
         MCAY7rndRdv1CHaqf8pYILfNNrMJih9CzBy+xH4bYKcKkGtoepGjivPMjgf2W2EnzU
         bFVXaMNu8xFwENfG46sZP4Os4f+x/GHFPI75u7rPJqZP1LJLqB1pmz8XCiUi3dK3Xs
         F3ep8yKEeljq3K5z2DyyMVqgMitDFPJhRmwcVADA2+5OA4MzPORr6PAyCXpE/ff5Zx
         Mj3SIkkMeL0QHUpToCTtxxJYiWJYKvlIB+U7rgPQH9jcHNRoOCxSdbrzAZhXZ8/dA9
         tFnoh4YfTLa2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ADAFA5C0741; Sun,  8 May 2022 20:37:40 -0700 (PDT)
Date:   Sun, 8 May 2022 20:37:40 -0700
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
Message-ID: <20220509033740.GM1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220505101641.28472-1-urezki@gmail.com>
 <20220505190915.GW1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnVLQozNFvgk3olP@pc638.lan>
 <20220506182425.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnY33nq5jl6FLFOu@pc638.lan>
 <20220507223247.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com>
 <20220508213222.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ9t8gxp9cKCpba+e4NZ6ohPr8jHxJYuqRBFRtvSDa0Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQ9t8gxp9cKCpba+e4NZ6ohPr8jHxJYuqRBFRtvSDa0Lw@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 08:17:49PM -0400, Joel Fernandes wrote:
> On Sun, May 8, 2022 at 5:32 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > > > > > > > One easy way to make this work would be to invert the sense of this
> > > > > > > > Kconfig option ("RCU_NOCB_CB_NO_BOOST"?), continue having it default to
> > > > > > > > "n", but then select it somewhere in drivers/android/Kconfig.  But I
> > > > > > > > would not be surprised if there is a better way.
> > > > >
> > > > > In that situation probably we should just enable it by default.
> > > >
> > > > You are within your rights to cause it to be enabled by default -within-
> > > > -Android-.  You are -not- within your rights to break other workloads.
> > > >
> > > > If ChromeOS needs it too, they too can enable it -within- -ChromeOS-.
> > > >
> > > > It is not -that- hard, guys!  ;-)
> > >
> > > I think on the topic of RT, +Steven Rostedt should chime in as well
> > > considering he wrote a good chunk of the RT scheduler ;-). Personally,
> > > I feel the issue of "rcu callback offload" threads running as RT or
> > > not should not be a matter of CONFIG option or the system in concern.
> > > Instead it should be a function of how many callbacks there are to
> > > run.  The reason I say this is, RT threads should not be doing a lot
> > > of work anyway, lest they cause RT throttling and starvation of other
> > > threads.
> >
> > This gets complicated surprisingly quickly.  For but one example, you
> > would find yourself wanting time-based boosting, most likely before you
> > wanted boosting based on numbers of callbacks.  And it is all too easy
> > to drive considerably complexity into the mix before proving that it is
> > really needed.  Especially given how rare the need for RCU priority
> > boosting is to begin with.
> 
> I think this patch does not deal with or change the behavior of
> dynamic priority boosting preempted RCU readers, but rather it makes
> it such that the no-cb offload threads that execute the callbacks. So
> I am not sure why you are talking about the boosting behavior of
> preempted RCU readers? I was referring only to the nocb offload
> kthreads which as I understand, Vlad *does not* want to run at RT
> priority.

OK.  Exactly what is the problem that you are trying to solve?  ;-)

And yes, I fully understand that Uladzislau does not want to run the rcuo
kthreads at RT priority, even in kernels built with CONFIG_RCU_BOOST=y.
Which makes sense, given that he is looking to solve a very different
problem than CONFIG_RCU_BOOST was designed to solve.  So adjustments must
be made.  The discussion is the exact form of the next set of adjustments,
which I expect to be quite straightforward.

> > > Also, I think it is wrong to assume that a certain kind of system will
> > > always have a certain number of callbacks to process at a time. That
> > > seems prone to poor design due to assumptions which may not always be
> > > true.
> >
> > Who was assuming that?  Uladzislau was measuring rather than assuming,
> > if that was what you were getting at.  Or if you are thinking about
> > things like qhimark, your point is exactly why there is both a default
> > (which has worked quite well for a very long time) and the ability to
> > adjust based on the needs of your specific system.
> 
> I was merely saying that based on measurements make assumptions, but
> in the real world the assumption may not be true, then everything
> falls apart. Instead I feel, callback threads should be RT only if 1.
> As you mentioned, the time based thing. 2. If the CB list is long and
> there's lot of processing. But instead, if it is made a CONFIG option,
> then that forces a fixed behavior which may fall apart in the real
> world. I think adding more CONFIGs and special cases is more complex
> but that's my opinion.

Again, exactly what problem are you trying to solve?

From what I can see, Uladzislau's issue can be addressed by statically
setting the rcuo kthreads to SCHED_OTHER at boot time.  The discussion
is on exactly how RCU is to be informed of this, at kernel build time.

> > > Can we not have 2 sets of RCU offload threads, one which operate at RT
> > > and only process few callbacks at a time, while another which is the
> > > lower priority CFS offload thread - executes whenever there is a lot
> > > of CBs pending? Just a thought.
> >
> > How about if we start by solving the problems we know that we have?
> 
> I don't know why you would say that, because we are talking about
> solving the specific problem Vlad's patch addresses, not random
> problems. Which is that, Android wants to run expedited GPs, but when
> the callback list is large, the RT nocb thread can starve other
> things. Did I misunderstand the patch? If so, sorry about that but
> that's what my email was discussing. i.e. running of CBs in RT
> threads. I suck at writing well as I clearly miscommunicated.

OK.

Why do you believe that this needs anything other than small adjustments
the defaults of existing Kconfig options?  Or am I completely missing
the point of your proposal?

> > > Otherwise, I feel like we might be again proliferating CONFIG options
> > > and increasing burden on the user to get it the CONFIG right.
> >
> > I bet that we will solve this without adding any new Kconfig options.
> > And I bet that the burden is at worst on the device designer, not on
> > the user.  Plus it is entirely possible that there might be a way to
> > automatically configure things to handle what we know about today,
> > again without adding Kconfig options.
> 
> Yes, agreed.

If I change my last sentence to read as follows, are we still in
agreement?

	Plus it is entirely possible that there might be a way to
	automatically configure things to handle what we know about today,
	again without adding Kconfig options and without changing runtime
	code beyond that covered by Uladzislau's patch.

							Thanx, Paul
