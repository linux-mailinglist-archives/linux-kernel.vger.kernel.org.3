Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356154ECDDD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350954AbiC3UWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiC3UWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:22:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064A6E71;
        Wed, 30 Mar 2022 13:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72F7F61625;
        Wed, 30 Mar 2022 20:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C68C340EC;
        Wed, 30 Mar 2022 20:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648671662;
        bh=6E/t3geIzNsmY/ab+pp1pECJf+JOpjNODtEht52eKOM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=szSWw17ets4dkcBM0wRneEuLCQ6b4ggAmBQQVWbS1g/TG/07ZvEYxfpC/pg1drBpE
         me/KWNBIiXjyeFbeRlz/lIx/UDnCeO2KojQcSxBEnZ53OVQNMRPT2LINBq430Wf5Rk
         4T/taTu9owQo6o9SHg+gt5ebx2vwutVmKsjHWl2gdAhpH98EdOut5ALvENQeALA+hQ
         X8wuSx9Ulrk70piWzRy6OZUYeU/bqW65GARvBGGZRu0qi7GaD2m7hlrcKyFaV+rVq8
         RMXnrzQxriYFq0AfwM86lpiJZCN+BCah+PNBeFOx6naAL0dFkcUrmkgbRInNSYy3uU
         P67uQPuDdllFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5FB9B5C12E4; Wed, 30 Mar 2022 13:21:02 -0700 (PDT)
Date:   Wed, 30 Mar 2022 13:21:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Message-ID: <20220330202102.GN4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220311022226.595905-1-qiang1.zhang@intel.com>
 <Yist4IWWR/6BZzeK@linutronix.de>
 <PH0PR11MB58802B8804EDFFC73BA676F2DA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58807AD9A1BAA122218B92DBDA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220316165931.GI4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58806B59FC8148C9C5160A5FDA139@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220318145738.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <YkSw/oc496GftWld@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkSw/oc496GftWld@pc638.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 09:35:26PM +0200, Uladzislau Rezki wrote:
> > On Fri, Mar 18, 2022 at 05:50:35AM +0000, Zhang, Qiang1 wrote:
> > > On Sat, Mar 12, 2022 at 03:11:04AM +0000, Zhang, Qiang1 wrote:
> > > > On 2022-03-11 10:22:26 [+0800], Zqiang wrote:
> > > > > When RCU_BOOST is enabled, the boost kthreads will boosting readers
> > > > > who are blocking a given grace period, if the current reader tasks
> > > >                                        ^ Period.
> > > > 
> > > > > have a higher priority than boost kthreads(the boost kthreads priority
> > > > > not always 1, if the kthread_prio is set), 
> > > > 
> > > > >>This confuses me:
> > > > >>- Why does this matter
> > > > 
> > > > In preempt-rt system, if the kthread_prio is not set, it prio is 1.
> > > > the boost kthreads can preempt almost  rt task, It will affect
> > > > the real-time performance of some user rt  tasks.  In preempt-rt systems,
> > > > in most scenarios, this kthread_prio will be configured.
> > > >
> > > >Just following up...  These questions might have been answered, but
> > > >I am not seeing those answers right off-hand.
> > > >
> > > >Is the grace-period latency effect of choosing not to boost high-priority
> > > >tasks visible at the system level in any actual workload?
> > > >
> > > >Suppose that a SCHED_DEADLINE task has exhausted its time quantum,
> > > >and has thus been preempted within an RCU read-side critical section.
> > > >Can priority boosting from a SCHED_FIFO prio-1 task cause it to start
> > > >running?
> > > >
> > > >Do delays in RCU priority boosting cause excessive grace-period
> > > >latencies on real workloads, even when all the to-be-boosted
> > > >tasks are SCHED_OTHER?
> > > >
> > > >Thoughts?
> > > 
> > > I have tested this modification these days,  I originally planned to generate a Kconfig option to control
> > > whether to skip tasks with higher priority than boost kthreads. but it doesn't seem necessary
> > >  because I find it's optimization is not particularly
> > > obvious in the actual scene, I find that tasks with higher priority than boost kthreads 
> > > will quickly exit the rcu critical area , even if be preempted in the rcu critical area.
> > > sorry for the noise.
> > 
> > Thank you for getting back with this information, and no need to
> > apologize.  We all get excited about a potential change from time to time.
> > Part of us maintainers' jobs is to ask hard questions when that appears
> > to be happening.  ;-)
> > 
> > If you have continued interest in this area, it would be good to keep
> > looking.  After all, neither RCU expedited grace periods nor RCU priority
> > boosting were designed with these new use cases in mind, so it is quite
> > likely that there is a useful change to be made in there somewhere.
> > 
> > You see, RCU expedited grace periods were designed for throughput rather
> > than latency.  The original use case was an old networking API that
> > needed to wait for a grace period on each and every one of a series of
> > some tens of thousands of system calls.  If one or two of those system
> > calls took a few hundred milliseconds, but the rest completed in less than
> > a millisecond, no harm done.  (Yes, there are now newer APIs that allow
> > many changes to be made with only the one grace-period wait.  But the
> > kernel must continue to support the old API: Never Break Userspace.)
> > 
> > For its part, RCU priority boosting was originally designed for
> > debuggging.  The point was to avoid OOMing the system when someone
> > misconfigured their application's real-time priorities.  As you know,
> > such misconfiguration can easily prevent low-priority RCU readers from
> > ever completing.
> > 
> > So it is reasonably likely that some change or another is needed.  After
> > all, new use cases require new functionality and new fixes.  The trick
> > is figuring out which change makes sense amongst the huge group of other
> > possible changes that each add much more complexity than improvement.
> > But part of the process of finding that change that makes sense is trying
> > out quite a few changes that don't help all that much.  ;-)
> > 
> Sorry for the late response, but i think i should comment on it since i
> have tried to simulate and test this patch on Android device. Basically
> we do have RT tasks in Android and i do not see that the patch that is
> in question makes any difference. Actually i was not able to trigger its
> functionality at all.
> 
> >From the other hand, i have tried to simulate it making an RT environment
> with SCHED_FIFO tasks and some synchronize_rcu_expedited() users. Indeed
> i can trigger it but it is very specific env. and number of triggering or
> tasks bypassing(high prio) is almost zero.

Thank you both!

I will set this aside for the time being.  I am sure that further
adjustments will be needed, but time will tell.

							Thanx, Paul
