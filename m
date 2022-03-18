Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985E74DDC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiCRO7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiCRO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:59:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78F5111DF9;
        Fri, 18 Mar 2022 07:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63AF6B821A5;
        Fri, 18 Mar 2022 14:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAECBC340EF;
        Fri, 18 Mar 2022 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647615459;
        bh=Gnz4QaOXs0bhWCz1P8uq4YZhQKqIxGRhaSaTHKGnuGk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VWoZE7yf0kJW63Q3zTDQupjhdUA5qZs39yRVJ6UaBkUuFF5DtSRWwNSu+RhHjmpkl
         YZixTQ7hQqNMfSrZ3GzWi7RcUpBpWynCAyk6XZlI00QOaj2P1ESWZYSaGxs9GS+rUg
         IzGtQcCAywqB04sxrMkEoKO4SLv1UzjhCHuYNNqHUczv//R/hV8ymFO/81G9Si/wxY
         S+Ve/t9arUvqITBxtPM5dlxv1HNpIKK2hjCXHtnIwa02/yV6G6mNn2beznBshD4srs
         7HeUzTa7PRx5p/3qpLdEFOUoGdLd9WOU6FeXjgvQTmnO4ynjtLhfybP+7z5W+do86z
         Mo1mT+loT2XzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8D2625C04E0; Fri, 18 Mar 2022 07:57:38 -0700 (PDT)
Date:   Fri, 18 Mar 2022 07:57:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Message-ID: <20220318145738.GY4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220311022226.595905-1-qiang1.zhang@intel.com>
 <Yist4IWWR/6BZzeK@linutronix.de>
 <PH0PR11MB58802B8804EDFFC73BA676F2DA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58807AD9A1BAA122218B92DBDA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220316165931.GI4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58806B59FC8148C9C5160A5FDA139@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58806B59FC8148C9C5160A5FDA139@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 05:50:35AM +0000, Zhang, Qiang1 wrote:
> On Sat, Mar 12, 2022 at 03:11:04AM +0000, Zhang, Qiang1 wrote:
> > On 2022-03-11 10:22:26 [+0800], Zqiang wrote:
> > > When RCU_BOOST is enabled, the boost kthreads will boosting readers
> > > who are blocking a given grace period, if the current reader tasks
> >                                        ^ Period.
> > 
> > > have a higher priority than boost kthreads(the boost kthreads priority
> > > not always 1, if the kthread_prio is set), 
> > 
> > >>This confuses me:
> > >>- Why does this matter
> > 
> > In preempt-rt system, if the kthread_prio is not set, it prio is 1.
> > the boost kthreads can preempt almost  rt task, It will affect
> > the real-time performance of some user rt  tasks.  In preempt-rt systems,
> > in most scenarios, this kthread_prio will be configured.
> >
> >Just following up...  These questions might have been answered, but
> >I am not seeing those answers right off-hand.
> >
> >Is the grace-period latency effect of choosing not to boost high-priority
> >tasks visible at the system level in any actual workload?
> >
> >Suppose that a SCHED_DEADLINE task has exhausted its time quantum,
> >and has thus been preempted within an RCU read-side critical section.
> >Can priority boosting from a SCHED_FIFO prio-1 task cause it to start
> >running?
> >
> >Do delays in RCU priority boosting cause excessive grace-period
> >latencies on real workloads, even when all the to-be-boosted
> >tasks are SCHED_OTHER?
> >
> >Thoughts?
> 
> I have tested this modification these days,  I originally planned to generate a Kconfig option to control
> whether to skip tasks with higher priority than boost kthreads. but it doesn't seem necessary
>  because I find it's optimization is not particularly
> obvious in the actual scene, I find that tasks with higher priority than boost kthreads 
> will quickly exit the rcu critical area , even if be preempted in the rcu critical area.
> sorry for the noise.

Thank you for getting back with this information, and no need to
apologize.  We all get excited about a potential change from time to time.
Part of us maintainers' jobs is to ask hard questions when that appears
to be happening.  ;-)

If you have continued interest in this area, it would be good to keep
looking.  After all, neither RCU expedited grace periods nor RCU priority
boosting were designed with these new use cases in mind, so it is quite
likely that there is a useful change to be made in there somewhere.

You see, RCU expedited grace periods were designed for throughput rather
than latency.  The original use case was an old networking API that
needed to wait for a grace period on each and every one of a series of
some tens of thousands of system calls.  If one or two of those system
calls took a few hundred milliseconds, but the rest completed in less than
a millisecond, no harm done.  (Yes, there are now newer APIs that allow
many changes to be made with only the one grace-period wait.  But the
kernel must continue to support the old API: Never Break Userspace.)

For its part, RCU priority boosting was originally designed for
debuggging.  The point was to avoid OOMing the system when someone
misconfigured their application's real-time priorities.  As you know,
such misconfiguration can easily prevent low-priority RCU readers from
ever completing.

So it is reasonably likely that some change or another is needed.  After
all, new use cases require new functionality and new fixes.  The trick
is figuring out which change makes sense amongst the huge group of other
possible changes that each add much more complexity than improvement.
But part of the process of finding that change that makes sense is trying
out quite a few changes that don't help all that much.  ;-)

							Thanx, Paul

> Thanks,
> Zqiang
> 
> >
> >							Thanx, Paul
> >
> > Thanks
> > Zqiang
> > 
> > >>- If it is not RT prio, what is then? Higher or lower? Afaik it is
> > >>  always >= 1.
> > 
> > >>>If it is not RT prio, the sanitize_kthread_prio() will limit RT prio
> > 
> > > boosting is useless, skip
> > > current task and select next task to boosting, reduce the time for a
> > > given grace period.
> > 
> > >>So if the task, that is stuck in a rcu_read() section, has a higher
> > >>priority than the boosting thread then boosting is futile. Understood.
> > >>
> > >>Please correct me if I'm wrong but this is intended for !SCHED_OTHER
> > >>tasks since there shouldn't a be PI chain on boost_mtx so that its
> > >>default RT priority is boosted above what has been configured.
> > 
> > >>>Yes, you are right. If the boosting task which itself already boosted due to PI chain,
> > >>>and Its priority may only be temporarily higher than boost kthreads,  once that
> > >>>PI boost is lifted the task may still be in a RCU section, but if we have been skipped it,
> > >>>this task have been missed the opportunity to be boosted.
> > 
> > >>
> > >>You skip boosting tasks which are itself already boosted due to a PI
> > >>chain. Once that PI boost is lifted the task may still be in a RCU
> > >>section. But if I understand you right, your intention is skip boosting
> > >>tasks with a higher priority and concentrate and those which are in
> > >>need. This shouldn't make a difference unless the scheduler is able to
> > >>move the rcu-boosted task to another CPU.
> > >>
> > 
> > >>>Yes, It make sense when the rcu-boosted kthreads and task which to be boosting
> > >>>should run  difference CPU .
> > 
> > >>Am I right so far? If so this should be part of the commit message (the
> > >>intention and the result). Also, please add that part with
> > >>boost_exp_tasks. The comment above boost_mtx is now above
> > >>boost_exp_tasks with a space so it looks (at least to me) like these two
> > >>don't belong together.
> > 
> > >>>Yes, I will add your description to the commit  information.
> > 
> > 
> > > Suggested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > 
> > >Sebastian
