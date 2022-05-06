Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8096851E110
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444450AbiEFVcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444427AbiEFVb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:31:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7733463BE4;
        Fri,  6 May 2022 14:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3A7E61225;
        Fri,  6 May 2022 21:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2BAC385AE;
        Fri,  6 May 2022 21:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651872491;
        bh=vuKmchvYMiIAdcHRKjUL3If/sLibZifSzK86MojhD6M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GuRRbQRyvE+UFF98aNKuoeXr1hc8IGvdds38g27OaW/US+DJyktjsmZCc4VPsHqiB
         syVj+4k8NpmgCypj5VT6OdliX4woCgWLQGZ9XMQkjRn/c4hAZc63ZHy/QFIypdr1ZD
         wqTr5cn4qkRzFq9cQSfJFySoiNUMdZWL2h3Fg5s8brxVsCmJQkyT8ACL6I7FVr8buS
         JKz6rrGOssSMMbscDcCC/s9tXMaiwTJ4hqRRfasP5c4ercoBbKqL58vCuRS7hD6AmH
         1mzrmUpX62VjFbqFCbU0lP4c20IWIitIQz2mHrRHPtzjDtQ3LwL/ucfhn/81atDODi
         CacH7ma+mFVxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 04F4D5C0640; Fri,  6 May 2022 11:24:26 -0700 (PDT)
Date:   Fri, 6 May 2022 11:24:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        bigeasy@linutronix.de
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <20220506182425.GC1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220505101641.28472-1-urezki@gmail.com>
 <20220505190915.GW1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnVLQozNFvgk3olP@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnVLQozNFvgk3olP@pc638.lan>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 06:22:26PM +0200, Uladzislau Rezki wrote:
> > On Thu, May 05, 2022 at 12:16:41PM +0200, Uladzislau Rezki (Sony) wrote:
> > > Introduce a RCU_NOCB_CPU_CB_BOOST kernel option. So a user can
> > > decide if an offloading has to be done in a high-prio context or
> > > not. Please note an option depends on RCU_NOCB_CPU and RCU_BOOST
> > > parameters and by default it is off.
> > > 
> > > This patch splits the boosting preempted RCU readers and those
> > > kthreads which directly responsible for driving expedited grace
> > > periods forward with enabling/disabling the offloading from/to
> > > SCHED_FIFO/SCHED_OTHER contexts.
> > > 
> > > The main reason of such split is, for example on Android there
> > > are some workloads which require fast expedited grace period to
> > > be done whereas offloading in RT context can lead to starvation
> > > and hogging a CPU for a long time what is not acceptable for
> > > latency sensitive environment. For instance:
> > > 
> > > <snip>
> > > <...>-60 [006] d..1 2979.028717: rcu_batch_start: rcu_preempt CBs=34619 bl=270
> > > <snip>
> > > 
> > > invoking 34 619 callbacks will take time thus making other CFS
> > > tasks waiting in run-queue to be starved due to such behaviour.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > All good points!
> > 
> > Some questions and comments below.
> > 
> > Adding Sebastian on CC for his perspective.
> > 
> > 						Thanx, Paul
> > 
> > > ---
> > >  kernel/rcu/Kconfig     | 14 ++++++++++++++
> > >  kernel/rcu/tree.c      |  5 ++++-
> > >  kernel/rcu/tree_nocb.h |  3 ++-
> > >  3 files changed, 20 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > index 27aab870ae4c..074630b94902 100644
> > > --- a/kernel/rcu/Kconfig
> > > +++ b/kernel/rcu/Kconfig
> > > @@ -275,6 +275,20 @@ config RCU_NOCB_CPU_DEFAULT_ALL
> > >  	  Say Y here if you want offload all CPUs by default on boot.
> > >  	  Say N here if you are unsure.
> > >  
> > > +config RCU_NOCB_CPU_CB_BOOST
> > > +	bool "Perform offloading from real-time kthread"
> > > +	depends on RCU_NOCB_CPU && RCU_BOOST
> > > +	default n
> > 
> > I understand that you need this to default to "n" on your systems.
> > However, other groups already using callback offloading should not see
> > a sudden change.  I don't see an Android-specific defconfig file, but
> > perhaps something in drivers/android/Kconfig?
> > 
> > One easy way to make this work would be to invert the sense of this
> > Kconfig option ("RCU_NOCB_CB_NO_BOOST"?), continue having it default to
> > "n", but then select it somewhere in drivers/android/Kconfig.  But I
> > would not be surprised if there is a better way.
> > 
> It was done deliberately, i mean off by default. Because the user has to
> think before enabling it for its workloads. It is not a big issue for
> kthreads which drive a grace period forward, because their context runtime
> i find pretty short. Whereas an offloading callback kthread can stuck
> for a long time depending on workloads.
> 
> Also, i put it that way because initially those kthreads were staying
> as SCHED_NORMAL even though the RCU_BOOST was set in kernel config.
> 
> <snip>
> commit c8b16a65267e35ecc5621dbc81cbe7e5b0992fce
> Author: Alison Chaiken <achaiken@aurora.tech>
> Date:   Tue Jan 11 15:32:52 2022 -0800
> 
>     rcu: Elevate priority of offloaded callback threads
>     
>     When CONFIG_PREEMPT_RT=y, the rcutree.kthread_prio command-line
>     parameter signals initialization code to boost the priority of rcuc
>     callbacks to the designated value.  With the additional
>     CONFIG_RCU_NOCB_CPU=y configuration and an additional rcu_nocbs
>     command-line parameter, the callbacks on the listed cores are
>     offloaded to new rcuop kthreads that are not pinned to the cores whose
>     post-grace-period work is performed.  While the rcuop kthreads perform
>     the same function as the rcuc kthreads they offload, the kthread_prio
>     parameter only boosts the priority of the rcuc kthreads.  Fix this
>     inconsistency by elevating rcuop kthreads to the same priority as the rcuc
>     kthreads.
>     
>     Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> <snip>
> 
> I have a doubt that it is needed for CONFIG_PREEMPT_RT=y. The reason i mentioned
> above it is a source of extra latency. That is why i have made it inactive by default.
> 
> Any thoughts?

My first thought is that Alison does real RT work.  Let's please therefore
avoid assuming that she doesn't know what she is doing.  ;-)

One thing that she knows is that RT workloads usually run the most
latency-sensitive parts of their application at far higher priority
than they do the rcuo[ps] kthreads.  This means that they do not have
the same issues with these kthreads that you see.

> > > +	help
> > > +	  Use this option to offload callbacks from the SCHED_FIFO context
> > > +	  to make the process faster. As a side effect of this approach is
> > > +	  a latency especially for the SCHED_OTHER tasks which will not be
> > > +	  able to preempt an offloading kthread. That latency depends on a
> > > +	  number of callbacks to be invoked.
> > > +
> > > +	  Say Y here if you want to set RT priority for offloading kthreads.
> > > +	  Say N here if you are unsure.
> > > +
> > >  config TASKS_TRACE_RCU_READ_MB
> > >  	bool "Tasks Trace RCU readers use memory barriers in user and idle"
> > >  	depends on RCU_EXPERT && TASKS_TRACE_RCU
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 9dc4c4e82db6..d769a15bc0e3 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -154,7 +154,10 @@ static void sync_sched_exp_online_cleanup(int cpu);
> > >  static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
> > >  static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
> > >  
> > > -/* rcuc/rcub/rcuop kthread realtime priority */
> > > +/*
> > > + * rcuc/rcub/rcuop kthread realtime priority. The former
> > > + * depends on if CONFIG_RCU_NOCB_CPU_CB_BOOST is set.
> > 
> > Aren't the rcuo[ps] kthreads controlled by the RCU_NOCB_CPU_CB_BOOST
> > Kconfig option?  (As opposed to the "former", which is "rcuc".)
> > 
> The CONFIG_RCU_NOCB_CPU_CB_BOOST controls only the last what is
> the rcuo CB kthread or "rcuo%c/%d" name. Sorry it is not "former"
> it is the last in the rcuc/rcub/rcuop sequence. It was a typo :)

I do know that feeling!  Absolutely not a problem, please just fix it
in the next version.

> > > + */
> > >  static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
> > >  module_param(kthread_prio, int, 0444);
> > >  
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index 60cc92cc6655..a2823be9b1d0 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -1315,8 +1315,9 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
> > >  	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
> > >  		goto end;
> > >  
> > > -	if (kthread_prio)
> > > +	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_CB_BOOST))
> > 
> > Don't we need both non-zero kthread_prio and the proper setting of the
> > new Kconfig option before we run it at SCHED_FIFO?
> > 
> > Yes, we could rely on sched_setscheduler_nocheck() erroring out in
> > that case, but that sounds like an accident waiting to happen.
> > 
> As far as i see it is odd, because the "kthread_prio" is verified so
> there is a sanity check to check if the value is correct for SCHED_FIFO
> case and does some adjustment if not. There is sanitize_kthread_prio()
> that does all trick.

Agreed, and like I said, we could rely on sched_setscheduler_nocheck()
erroring out in that case.  But people do sometimes turn error cases
into some other functionality.  Keeping the check of kthread_prio makes
it clear to people reading the code what our intent is and also avoids
strange breakage should someone find a use for SCHED_FIFO priority zero.

So please put the check of kthread_prio back in for the next version.

> Looking at the kthread_prio variable. If it is set all the code that
> takes into account of it switches to SCHED_FIFO class. Maybe rename it
> to something kthread_rt_prio? It might be a bad idea though because of
> former dependencies of distros and so on :)

Where were you when the kthread_prio patch was first submitted?  ;-)

But agreed, last I checked there were some tens of billions of Linux
kernel instances running out there.  If such a change affected only
0.1% of that total, we could be ruining tens of millions of system's
days with such a name change.  There would thus need to be a very good
reason to change the name, and we don't have one.

							Thanx, Paul
