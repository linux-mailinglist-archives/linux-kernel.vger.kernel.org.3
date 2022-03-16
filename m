Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5650B4DB6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350105AbiCPRAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiCPRAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:00:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B9453E12;
        Wed, 16 Mar 2022 09:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7517EB81A66;
        Wed, 16 Mar 2022 16:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29167C340E9;
        Wed, 16 Mar 2022 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647449972;
        bh=cnadLeya2RVXcK9hXSU+BT7h71m43eVlGL4w/1EEdG0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Asm6Trp5HmdK9kspYRj08hT5NKP0OhV2Al4rL93IFQ0r1FAazVmg9SAzV04GjP61b
         MgQY93B68fUm903vgOutIvTisAm8staIjJdU1+Ru2lc5yuuoOj7Jh+DO0/hJqdIc1Q
         tEiGYO+u4ZCM7IgMeNJ/gk43NUzg+gzjyLRkVOTOogknfrqwBXGZuiuvKtj5OLI6K9
         ogvO4cRzGXnLcolLB1jzhiiCMNZp6xmJ38Zblk2cUwxbsyJmaPX/7S78whfvSXf8x/
         39Nn0DjCJ2aGIVexvzNq6U7zp3EN7iobNjo3O9xiIrOY/kmrz1UcETdmS6NdCSkJgz
         xE64vCC36WSOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B75675C0387; Wed, 16 Mar 2022 09:59:31 -0700 (PDT)
Date:   Wed, 16 Mar 2022 09:59:31 -0700
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
Message-ID: <20220316165931.GI4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220311022226.595905-1-qiang1.zhang@intel.com>
 <Yist4IWWR/6BZzeK@linutronix.de>
 <PH0PR11MB58802B8804EDFFC73BA676F2DA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58807AD9A1BAA122218B92DBDA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58807AD9A1BAA122218B92DBDA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 03:11:04AM +0000, Zhang, Qiang1 wrote:
> On 2022-03-11 10:22:26 [+0800], Zqiang wrote:
> > When RCU_BOOST is enabled, the boost kthreads will boosting readers
> > who are blocking a given grace period, if the current reader tasks
>                                        ^ Period.
> 
> > have a higher priority than boost kthreads(the boost kthreads priority
> > not always 1, if the kthread_prio is set), 
> 
> >>This confuses me:
> >>- Why does this matter
> 
> In preempt-rt system, if the kthread_prio is not set, it prio is 1.
> the boost kthreads can preempt almost  rt task, It will affect
> the real-time performance of some user rt  tasks.  In preempt-rt systems,
> in most scenarios, this kthread_prio will be configured.

Just following up...  These questions might have been answered, but
I am not seeing those answers right off-hand.

Is the grace-period latency effect of choosing not to boost high-priority
tasks visible at the system level in any actual workload?

Suppose that a SCHED_DEADLINE task has exhausted its time quantum,
and has thus been preempted within an RCU read-side critical section.
Can priority boosting from a SCHED_FIFO prio-1 task cause it to start
running?

Do delays in RCU priority boosting cause excessive grace-period
latencies on real workloads, even when all the to-be-boosted
tasks are SCHED_OTHER?

Thoughts?

							Thanx, Paul

> Thanks
> Zqiang
> 
> >>- If it is not RT prio, what is then? Higher or lower? Afaik it is
> >>  always >= 1.
> 
> >>>If it is not RT prio, the sanitize_kthread_prio() will limit RT prio
> 
> > boosting is useless, skip
> > current task and select next task to boosting, reduce the time for a
> > given grace period.
> 
> >>So if the task, that is stuck in a rcu_read() section, has a higher
> >>priority than the boosting thread then boosting is futile. Understood.
> >>
> >>Please correct me if I'm wrong but this is intended for !SCHED_OTHER
> >>tasks since there shouldn't a be PI chain on boost_mtx so that its
> >>default RT priority is boosted above what has been configured.
> 
> >>>Yes, you are right. If the boosting task which itself already boosted due to PI chain,
> >>>and Its priority may only be temporarily higher than boost kthreads,  once that
> >>>PI boost is lifted the task may still be in a RCU section, but if we have been skipped it,
> >>>this task have been missed the opportunity to be boosted.
> 
> >>
> >>You skip boosting tasks which are itself already boosted due to a PI
> >>chain. Once that PI boost is lifted the task may still be in a RCU
> >>section. But if I understand you right, your intention is skip boosting
> >>tasks with a higher priority and concentrate and those which are in
> >>need. This shouldn't make a difference unless the scheduler is able to
> >>move the rcu-boosted task to another CPU.
> >>
> 
> >>>Yes, It make sense when the rcu-boosted kthreads and task which to be boosting
> >>>should run  difference CPU .
> 
> >>Am I right so far? If so this should be part of the commit message (the
> >>intention and the result). Also, please add that part with
> >>boost_exp_tasks. The comment above boost_mtx is now above
> >>boost_exp_tasks with a space so it looks (at least to me) like these two
> >>don't belong together.
> 
> >>>Yes, I will add your description to the commit  information.
> 
> 
> > Suggested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> >Sebastian
