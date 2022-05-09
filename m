Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A855204B8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240313AbiEISrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbiEISrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:47:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6091868CB;
        Mon,  9 May 2022 11:43:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w19so25367489lfu.11;
        Mon, 09 May 2022 11:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5x0jMgOGKfQGL1jUJac1rDSNC7TdvExYknM3mjKrJkE=;
        b=dy6i0MLqrzBMsT47ZyLi04b2rWFzlfrf8ZKL3bsyOPDJ4qMEBLAx6euRK2QrhjYLdF
         n4vvs14SAuyFjQ3zuO7HwnKsmFml1mSMRr1fXHxd0Hn04i70A263DJQZY1ijqIkbfc0R
         7Sy2HymKsJqzyi1tKHNtQSDueKz327Rc33vlqjDiPDPrI/ouhwoaF4/6oCAcQH9frPTE
         E713kkNpstZVuopsKkXGlmGTuJ2RVGXcVk4mMY7BwMlbwFp7XXs3HjndIygt2cC08qqe
         DJ5qD2df1JLtB4uJJgNcL+OsYZno67ZYKgPFRhX3LhXXoxU8JEHQUvnyz4MLkFAtxNQN
         ekXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5x0jMgOGKfQGL1jUJac1rDSNC7TdvExYknM3mjKrJkE=;
        b=KwvhwuWyc0p+purPZiQQDOdilWf5tPLIxd+oys/ZVVdRHlstbSH3gX0ltC+f/uDvQh
         /8Kmfjz7ljb8J2Jh/Xb+R2MNgrbrv9jq34VsdomBj3DB6UX6VWMveirRSVqkgS8qs4hj
         xnHgVTKCImhSlvxy3b2uVaTrFwybCa4SuPauXi/BCpEz4vGGg0TwQh5P3pEDPHT1N0LW
         J33CdxVSRnUfusa5b4eWQ/wLJaPkv8eMExQbgn8mgXPiSlOGGa97Krwc9t3xil+iVI92
         6U+/OaZOe9ixNGWEnNKL2pyf0hA1YQrWQ4+XV0ZDqlz4acsL2+Z7NERkZfy1vnuIeaLX
         /R1w==
X-Gm-Message-State: AOAM532Al9pTAWzwJAQYrVLzaIhaSlFpyjRcjqZRCGSIuYbVsniRB7EI
        IpsfzjtrSq2kduskzgJvYX8=
X-Google-Smtp-Source: ABdhPJxv0Xk+xamXkMa86F2GIKQrCR5jVNg9oS+yg+rOzDAsx8Ma9QTwhsxhD0IaiPDrxML/ve+QZA==
X-Received: by 2002:ac2:5ecc:0:b0:472:3c01:9a2e with SMTP id d12-20020ac25ecc000000b004723c019a2emr13396976lfq.245.1652121816325;
        Mon, 09 May 2022 11:43:36 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id u12-20020ac243cc000000b0047255d211a1sm2019933lfl.208.2022.05.09.11.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 11:43:35 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 9 May 2022 20:43:33 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Chaiken <achaiken@aurora.tech>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <Ynlg1d/D0t6IqBmv@pc638.lan>
References: <YnY33nq5jl6FLFOu@pc638.lan>
 <20220507223247.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com>
 <20220508213222.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ9t8gxp9cKCpba+e4NZ6ohPr8jHxJYuqRBFRtvSDa0Lw@mail.gmail.com>
 <20220509033740.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSbWetMt2_-m4G9Nt5S8ybATihB+5FMJMMo3jKDG4pPjg@mail.gmail.com>
 <20220509181417.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnldSkaWu40cVimj@pc638.lan>
 <20220509183934.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509183934.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, May 09, 2022 at 08:28:26PM +0200, Uladzislau Rezki wrote:
> > > On Mon, May 09, 2022 at 01:17:00PM -0400, Joel Fernandes wrote:
> > > > On Sun, May 8, 2022 at 11:37 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Sun, May 08, 2022 at 08:17:49PM -0400, Joel Fernandes wrote:
> > > > > > On Sun, May 8, 2022 at 5:32 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >  [...]
> > > > > > > > Also, I think it is wrong to assume that a certain kind of system will
> > > > > > > > always have a certain number of callbacks to process at a time. That
> > > > > > > > seems prone to poor design due to assumptions which may not always be
> > > > > > > > true.
> > > > > > >
> > > > > > > Who was assuming that?  Uladzislau was measuring rather than assuming,
> > > > > > > if that was what you were getting at.  Or if you are thinking about
> > > > > > > things like qhimark, your point is exactly why there is both a default
> > > > > > > (which has worked quite well for a very long time) and the ability to
> > > > > > > adjust based on the needs of your specific system.
> > > > > >
> > > > > > I was merely saying that based on measurements make assumptions, but
> > > > > > in the real world the assumption may not be true, then everything
> > > > > > falls apart. Instead I feel, callback threads should be RT only if 1.
> > > > > > As you mentioned, the time based thing. 2. If the CB list is long and
> > > > > > there's lot of processing. But instead, if it is made a CONFIG option,
> > > > > > then that forces a fixed behavior which may fall apart in the real
> > > > > > world. I think adding more CONFIGs and special cases is more complex
> > > > > > but that's my opinion.
> > > > >
> > > > > Again, exactly what problem are you trying to solve?
> > > > >
> > > > > From what I can see, Uladzislau's issue can be addressed by statically
> > > > > setting the rcuo kthreads to SCHED_OTHER at boot time.  The discussion
> > > > > is on exactly how RCU is to be informed of this, at kernel build time.
> > > > >
> > > > > > > > Can we not have 2 sets of RCU offload threads, one which operate at RT
> > > > > > > > and only process few callbacks at a time, while another which is the
> > > > > > > > lower priority CFS offload thread - executes whenever there is a lot
> > > > > > > > of CBs pending? Just a thought.
> > > > > > >
> > > > > > > How about if we start by solving the problems we know that we have?
> > > > > >
> > > > > > I don't know why you would say that, because we are talking about
> > > > > > solving the specific problem Vlad's patch addresses, not random
> > > > > > problems. Which is that, Android wants to run expedited GPs, but when
> > > > > > the callback list is large, the RT nocb thread can starve other
> > > > > > things. Did I misunderstand the patch? If so, sorry about that but
> > > > > > that's what my email was discussing. i.e. running of CBs in RT
> > > > > > threads. I suck at writing well as I clearly miscommunicated.
> > > > >
> > > > > OK.
> > > > >
> > > > > Why do you believe that this needs anything other than small adjustments
> > > > > the defaults of existing Kconfig options?  Or am I completely missing
> > > > > the point of your proposal?
> > > > >
> > > > > > > > Otherwise, I feel like we might be again proliferating CONFIG options
> > > > > > > > and increasing burden on the user to get it the CONFIG right.
> > > > > > >
> > > > > > > I bet that we will solve this without adding any new Kconfig options.
> > > > > > > And I bet that the burden is at worst on the device designer, not on
> > > > > > > the user.  Plus it is entirely possible that there might be a way to
> > > > > > > automatically configure things to handle what we know about today,
> > > > > > > again without adding Kconfig options.
> > > > > >
> > > > > > Yes, agreed.
> > > > >
> > > > > If I change my last sentence to read as follows, are we still in
> > > > > agreement?
> > > > >
> > > > >         Plus it is entirely possible that there might be a way to
> > > > >         automatically configure things to handle what we know about today,
> > > > >         again without adding Kconfig options and without changing runtime
> > > > >         code beyond that covered by Uladzislau's patch.
> > > > 
> > > > Yes, actually the automatic configuration of things is what I meant,
> > > > that's the "problem" I was referring to, where the system does the
> > > > right thing for a broader range of systems, without requiring the
> > > > users to find RCU issues and hand-tune them (that requires said users
> > > > to have tracing and debugging skills and get lucky finding a problem).
> > > > To be fair, I did not propose any solutions to such problems either,
> > > > it is just some ideas. I don't like knobs too much and I don't trust
> > > > users or system designers to get them right most of the time.
> > > > 
> > > > In that sense,  I don't think making rcuo threads run as RT or not
> > > > (which this patch does) is really fixing the problems. In one case,
> > > > you might have priority inversion, in another case you might cause
> > > > starvation. Probably what is needed is best of both worlds. That said,
> > > > I don't have better solutions right now than what I mentioned, which
> > > > is to assign priorities to the callbacks themselves and run them in
> > > > threads of different priorities.
> > > > 
> > > > For the record, I am not against the patch or anything like that (and
> > > > even if I was, I am not sure that it matters for merging :P)
> > > 
> > > Fair enough!
> > > 
> > > And for the record at this end, I would not be surprised if in 2032
> > > RCU offloaded callback invocation has sophisticated dynamic tuning of
> > > priorities and much else besides.  But one step at a time!  ;-)
> > > 
> > hh... It is hard to comment because i am a bit lost in this big conversation :)
> > 
> > What i have got so far. Joel does not like adding extra *_CONFIG
> > options, actually me too since it becomes more complicated thus
> > it requires more specific attention from users. I prefer to make
> > the code common but it is not possible sometimes to make it common,
> > because we have different kind of kernels and workloads.
> > 
> > >From the other hand the patch splits the BOOSTING logic into two peaces
> > because driving the grace periods kthreads in RT priority is not a big
> > issue because their run-times are short. Whereas running the "kthreads-callbacks"
> > in the RT context can be long so we end up in throttled situation for
> > other workloads.
> > 
> > I see that Paul would like to keep it for CONFIG_PREEMPT_RT, because it
> > was mainly designed for that kind of kernels. So we can align with Alison
> > patch and her decision, so i do not see any issues. So far RT folk seems
> > does not mind in having "callback-kthreads" as SCHED_FIFO :)
> > 
> > Do you agree with start from keeping it ON for CONFIG_PREEMPT_RT conf.
> > by default and OFF for other cases?
> 
> Yes, please!
> 
> This allows your current RCU_NOCB_CPU_CB_BOOST with something like
> this in place of the "default n":
> 
> 	default y if PREEMPT_RT
> 	default n if !PREEMPT_RT
> 
> There might be a simpler way of doing this, but this would work.
> 
> Could you please send a v2 with the requested updates?
> 
No problem, will send an updated version.

--
Uladzislau Rezki
