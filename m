Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA79D4ECD53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350766AbiC3Thb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiC3Th0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:37:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D1B43EF4;
        Wed, 30 Mar 2022 12:35:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bu29so37734259lfb.0;
        Wed, 30 Mar 2022 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IFsqv1oaAdQe9qXxPZqxM0d4mVwloIwzyCl6BJ2d4mA=;
        b=JtkEzWQSfPteeoho9q+o1Fj8ns9onoRt427Rl2xx3ZMkFC+IfmukecerLvdoJH1WrM
         9IB5ERM6zto0lxq98wm6YTj3JaXgzTsB/9xBWSbeGKmG+FMkNDH3/AEjMjQqepqIZgW0
         LOUMvvLPWP7HMRQCFsml7EE2KjXZU7hkxGfNj4Rv8f7sqyKmzSFHzf5oNMJRElWJQjYf
         DDvUnDgAtPcjYLKtpg0SF1NT8kcjYF0JpJQs71LRKeiAdFkk24l4GgWGqSzUQQL5N3WQ
         K04wuCRRT/6W85JJIjSQYfyia+2caM6zU1Mjkaz8xgr0zB8qrt5TUTxLVrKmRsWLdEQ4
         WB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IFsqv1oaAdQe9qXxPZqxM0d4mVwloIwzyCl6BJ2d4mA=;
        b=htBFkipLFzQB4xWIra+CU08pdp2ru03tsNYKHsShQIG2AdHs2f7ZCOu/kc7Q3Wt4TZ
         Tx6RSuYVSQ3LX1hm2IE2q8Dk3SlCgClOQ7dZzQ4Zxae73Hajeyk9VggCZOBgDz5dKvS1
         C6jki50Jm9uhY7IJkjI9kspA0zkxPk/WU7FBcR/mzljcMw2MnN+B/au95kbt7SgzYKTr
         yfTIn2b748OGnH5n0Y7lXqRYQjOl3nRhAeHDZo8IjGIxkC1Do5OPuC5JZ03JWjyQkycz
         7Ix9p1MP2Qfrd5OL+tpkMTYWCy+6KnlpR1VfpRg/x3J/abnIRbUcqnMQesZGUPAEEBJQ
         +PKg==
X-Gm-Message-State: AOAM530sYwJPfc8fd7qVT1mwv0gWUBNUE2DI/haXYy0mnV6kIxe8I/vw
        kLTLyJbjMwh2u7TrPAWVv2cECUGr0VAWmQ==
X-Google-Smtp-Source: ABdhPJzYxrayHLEq28gi1pY81vEHwqW/E31kKsNkQnePYcjsD6l1PI6JGyTkqCPk/rEwwje4TvX7qA==
X-Received: by 2002:a05:6512:3e15:b0:44a:4d88:4dcf with SMTP id i21-20020a0565123e1500b0044a4d884dcfmr7810659lfv.227.1648668935218;
        Wed, 30 Mar 2022 12:35:35 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id y9-20020a2e95c9000000b0024af5798ebasm58782ljh.49.2022.03.30.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 12:35:34 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 30 Mar 2022 21:35:26 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Message-ID: <YkSw/oc496GftWld@pc638.lan>
References: <20220311022226.595905-1-qiang1.zhang@intel.com>
 <Yist4IWWR/6BZzeK@linutronix.de>
 <PH0PR11MB58802B8804EDFFC73BA676F2DA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58807AD9A1BAA122218B92DBDA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220316165931.GI4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58806B59FC8148C9C5160A5FDA139@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220318145738.GY4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318145738.GY4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Mar 18, 2022 at 05:50:35AM +0000, Zhang, Qiang1 wrote:
> > On Sat, Mar 12, 2022 at 03:11:04AM +0000, Zhang, Qiang1 wrote:
> > > On 2022-03-11 10:22:26 [+0800], Zqiang wrote:
> > > > When RCU_BOOST is enabled, the boost kthreads will boosting readers
> > > > who are blocking a given grace period, if the current reader tasks
> > >                                        ^ Period.
> > > 
> > > > have a higher priority than boost kthreads(the boost kthreads priority
> > > > not always 1, if the kthread_prio is set), 
> > > 
> > > >>This confuses me:
> > > >>- Why does this matter
> > > 
> > > In preempt-rt system, if the kthread_prio is not set, it prio is 1.
> > > the boost kthreads can preempt almost  rt task, It will affect
> > > the real-time performance of some user rt  tasks.  In preempt-rt systems,
> > > in most scenarios, this kthread_prio will be configured.
> > >
> > >Just following up...  These questions might have been answered, but
> > >I am not seeing those answers right off-hand.
> > >
> > >Is the grace-period latency effect of choosing not to boost high-priority
> > >tasks visible at the system level in any actual workload?
> > >
> > >Suppose that a SCHED_DEADLINE task has exhausted its time quantum,
> > >and has thus been preempted within an RCU read-side critical section.
> > >Can priority boosting from a SCHED_FIFO prio-1 task cause it to start
> > >running?
> > >
> > >Do delays in RCU priority boosting cause excessive grace-period
> > >latencies on real workloads, even when all the to-be-boosted
> > >tasks are SCHED_OTHER?
> > >
> > >Thoughts?
> > 
> > I have tested this modification these days,  I originally planned to generate a Kconfig option to control
> > whether to skip tasks with higher priority than boost kthreads. but it doesn't seem necessary
> >  because I find it's optimization is not particularly
> > obvious in the actual scene, I find that tasks with higher priority than boost kthreads 
> > will quickly exit the rcu critical area , even if be preempted in the rcu critical area.
> > sorry for the noise.
> 
> Thank you for getting back with this information, and no need to
> apologize.  We all get excited about a potential change from time to time.
> Part of us maintainers' jobs is to ask hard questions when that appears
> to be happening.  ;-)
> 
> If you have continued interest in this area, it would be good to keep
> looking.  After all, neither RCU expedited grace periods nor RCU priority
> boosting were designed with these new use cases in mind, so it is quite
> likely that there is a useful change to be made in there somewhere.
> 
> You see, RCU expedited grace periods were designed for throughput rather
> than latency.  The original use case was an old networking API that
> needed to wait for a grace period on each and every one of a series of
> some tens of thousands of system calls.  If one or two of those system
> calls took a few hundred milliseconds, but the rest completed in less than
> a millisecond, no harm done.  (Yes, there are now newer APIs that allow
> many changes to be made with only the one grace-period wait.  But the
> kernel must continue to support the old API: Never Break Userspace.)
> 
> For its part, RCU priority boosting was originally designed for
> debuggging.  The point was to avoid OOMing the system when someone
> misconfigured their application's real-time priorities.  As you know,
> such misconfiguration can easily prevent low-priority RCU readers from
> ever completing.
> 
> So it is reasonably likely that some change or another is needed.  After
> all, new use cases require new functionality and new fixes.  The trick
> is figuring out which change makes sense amongst the huge group of other
> possible changes that each add much more complexity than improvement.
> But part of the process of finding that change that makes sense is trying
> out quite a few changes that don't help all that much.  ;-)
> 
Sorry for the late response, but i think i should comment on it since i
have tried to simulate and test this patch on Android device. Basically
we do have RT tasks in Android and i do not see that the patch that is
in question makes any difference. Actually i was not able to trigger its
functionality at all.

From the other hand, i have tried to simulate it making an RT environment
with SCHED_FIFO tasks and some synchronize_rcu_expedited() users. Indeed
i can trigger it but it is very specific env. and number of triggering or
tasks bypassing(high prio) is almost zero.

--
Uladzislau Rezki
