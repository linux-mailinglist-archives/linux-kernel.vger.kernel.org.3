Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501234BBF0F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiBRSJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:09:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbiBRSJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:09:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5371285AB5;
        Fri, 18 Feb 2022 10:09:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 964BFB826B9;
        Fri, 18 Feb 2022 18:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470FBC340E9;
        Fri, 18 Feb 2022 18:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645207767;
        bh=MgoMihgQ8vusrPtnllASKdZxBMSNyiaMLb6Llh3Epcw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q+8hXqNp8Tr8uQaoOmKF57Zl2j+ehECfFueVhqBYiYbb+kXVOKFaguHHr+GMap6Hm
         j/oD65mwwoL+Y3LfmCCo4pEKM3dcRVI6c9agkNzArhNe4ZV8roCAKRvWwz9ntBVaYz
         C4ttEipjf1hoBmDeCpZFlryBTA2tlXglwhIIMs3pTKP01DXKnvnk0gsVpjrLWI8Yxi
         yNgHq6B+LuacGxClufc75Ry9OGPpBYmmlv4UQqAquoBqX3IziXsnGU0TD6RFbzZwrD
         xowpxZi9iPxRuHjiMx/5fqSHS1R213dRx/GI/DLn75Lne3gbHdje140ETA456qJjjl
         UNrGmqRue8fog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 051595C03DB; Fri, 18 Feb 2022 10:09:27 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:09:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, rostedt@goodmis.org, tj@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH rcu 3/3] rcu: Allow expedited RCU grace periods on
 incoming CPUs
Message-ID: <20220218180926.GX4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220209233811.GC557593@lothringen>
 <20220214164435.GA2805255@paulmck-ThinkPad-P17-Gen-1>
 <f8cff19c-5e8f-a7ed-c2ff-49a264b4e342@quicinc.com>
 <20220215173951.GH4285@paulmck-ThinkPad-P17-Gen-1>
 <ca0cac53-68ec-7df4-e617-2a4cd9710491@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca0cac53-68ec-7df4-e617-2a4cd9710491@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 11:03:03PM +0530, Mukesh Ojha wrote:
> 
> On 2/15/2022 11:09 PM, Paul E. McKenney wrote:
> > On Tue, Feb 15, 2022 at 07:53:10PM +0530, Mukesh Ojha wrote:
> > > On 2/14/2022 10:14 PM, Paul E. McKenney wrote:
> > > > On Thu, Feb 10, 2022 at 12:38:11AM +0100, Frederic Weisbecker wrote:
> > > > > On Fri, Feb 04, 2022 at 02:55:07PM -0800, Paul E. McKenney wrote:
> > > > > > Although it is usually safe to invoke synchronize_rcu_expedited() from a
> > > > > > preemption-enabled CPU-hotplug notifier, if it is invoked from a notifier
> > > > > > between CPUHP_AP_RCUTREE_ONLINE and CPUHP_AP_ACTIVE, its attempts to
> > > > > > invoke a workqueue handler will hang due to RCU waiting on a CPU that
> > > > > > the scheduler is not paying attention to.  This commit therefore expands
> > > > > > use of the existing workqueue-independent synchronize_rcu_expedited()
> > > > > > from early boot to also include CPUs that are being hotplugged.
> > > > > > 
> > > > > > Link:https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
> > > > > > Reported-by: Mukesh Ojha<quic_mojha@quicinc.com>
> > > > > > Cc: Tejun Heo<tj@kernel.org>
> > > > > > Signed-off-by: Paul E. McKenney<paulmck@kernel.org>
> > > > > I'm surprised by this scheduler behaviour.
> > > > > 
> > > > > Since sched_cpu_activate() hasn't been called yet,
> > > > > rq->balance_callback = balance_push_callback. As a result, balance_push() should
> > > > > be called at the end of schedule() when the workqueue is picked as the next task.
> > > > > Then eventually the workqueue should be immediately preempted by the stop task to
> > > > > be migrated elsewhere.
> > > > > 
> > > > > So I must be missing something. For the fun, I booted the following and it
> > > > > didn't produce any issue:
> > > > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 80faf2273ce9..b1e74a508881 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -4234,6 +4234,8 @@ int rcutree_online_cpu(unsigned int cpu)
> > > > >    	// Stop-machine done, so allow nohz_full to disable tick.
> > > > >    	tick_dep_clear(TICK_DEP_BIT_RCU);
> > > > > +	if (cpu != 0)
> > > > > +		synchronize_rcu_expedited();
> > > > >    	return 0;
> > > > >    }
> > > > That does seem compelling.  And others have argued that the workqueue
> > > > system's handling of offline CPUs should deal with this.
> > > > 
> > > > Mukesh, was this a theoretical bug, or did you actually make it happen?
> > > > If you made it happen, as seems to have been the case given your original
> > > > email [1], could you please post your reproducer?
> > > No, it was not theoretical one. We saw this issue only once in our testing
> > > and i don't think it is easy to reproduce otherwise
> > > it would been fixed by now.
> > > 
> > > When one of thread calling synchronize_expedite_rcu with timer of 20s but it
> > > did not get the exp funnel
> > > lock for 20s and there we crash it with panic() on timeout.
> > > 
> > > The other thread cpuhp which was having the lock got stuck at the point
> > > mentioned at the below link.
> > > 
> > > https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
> > OK.  Are you able to create an in-kernel reproducer, perhaps similar to
> > Frederic's change above?
> > 
> > I am worried that the patch that I am carrying might be fixing some
> > other bug by accident...
> 
> Just for information, we are running on 5.10 kernel and after numerous
> attempt, i was not able to reproduce the issue:-)

Thank you for checking!

I will drop this commit from -rcu's "dev" branch, but leave a tag
"exponl.2022.02.18a" should it ever prove necessary.

							Thanx, Paul

> Thanks,
> -Mukesh
> 
> > 
> > 							Thanx, Paul
> > 
> > > e.g Below sample test in combination of many other test in parallel
> > > 
> > > :loop
> > > 
> > > adb shell "echo 0 > /sys/devices/system/cpu/cpu0/online"
> > > 
> > > adb shell "echo 1 > /sys/devices/system/cpu/cpu0/online"
> > > 
> > > adb shell "echo 0 > /sys/devices/system/cpu/cpu1/online"
> > > 
> > > adb shell "echo 1 > /sys/devices/system/cpu/cpu1/online"
> > > 
> > > adb shell "echo 0 > /sys/devices/system/cpu/cpu2/online"
> > > 
> > > adb shell "echo 1 > /sys/devices/system/cpu/cpu2/online"
> > > 
> > > adb shell "echo 0 > /sys/devices/system/cpu/cpu3/online"
> > > 
> > > adb shell "echo 1 > /sys/devices/system/cpu/cpu3/online"
> > > 
> > > adb shell "echo 0 > /sys/devices/system/cpu/cpu4/online"
> > > 
> > > adb shell "echo 1 > /sys/devices/system/cpu/cpu4/online"
> > > 
> > > adb shell "echo 0 > /sys/devices/system/cpu/cpu5/online"
> > > 
> > > adb shell "echo 1 > /sys/devices/system/cpu/cpu5/online"
> > > 
> > > adb shell "echo 0 > /sys/devices/system/cpu/cpu6/online"
> > > 
> > > adb shell "echo 1 > /sys/devices/system/cpu/cpu6/online"
> > > 
> > > adb shell "echo 0 > /sys/devices/system/cpu/cpu7/online"
> > > 
> > > adb shell "echo 1 > /sys/devices/system/cpu/cpu7/online"
> > > 
> > > goto loop
> > > 
> > > 
> > > 
> > > Thanks, Mukesh
> > > 
> > > > 							Thanx, Paul
> > > > 
> > > > [1]https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
