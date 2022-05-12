Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7512524F26
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354881AbiELOBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354932AbiELOBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:01:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7D92FFC7;
        Thu, 12 May 2022 07:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 500D2B82833;
        Thu, 12 May 2022 14:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1EBC385B8;
        Thu, 12 May 2022 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652364062;
        bh=vG0c5NdOF8Y08/Dxnr4xnnOdio+reSdLGOl6h5nExNw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K1mXObEY11mAWpCV7a6Aahlj/2UZ+KVxVjlSXY7WmHIkR7dBAp9XvpRiw/ouNfIka
         tRn7sOrb/ervDy459RSe4ddukj6B5Cwkhu2VrWe3UPSje2B6o1WCoJTj4EkIr8AGdW
         XOtdX7ggwmJETB3sYiPhyF1lQSvNN0J2qU92IFPzk5jIcMFCrpXxt8J2iF1zS+BJrs
         tnrLcXgOyupU8WgzLHoagRXsag5cZSJZsVSq8Om3zJvK28CBXcT6vY2xuGElbrheNx
         iPR/wIhDvXmmtAC1jvFhWEqTFfdoWLEjbK2aj7WdwCnbm5Tb505WMmCy3Q++pV+rIs
         NjTMs1Xj0dGig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 999C85C032C; Thu, 12 May 2022 07:01:01 -0700 (PDT)
Date:   Thu, 12 May 2022 07:01:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 1/1] rcu/nocb: Add an option to ON/OFF an offloading
 from RT context
Message-ID: <20220512140101.GM1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220511085703.101596-1-urezki@gmail.com>
 <Ynx61yH8RFkaXG6M@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynx61yH8RFkaXG6M@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 03:11:19AM +0000, Joel Fernandes wrote:
> On Wed, May 11, 2022 at 10:57:03AM +0200, Uladzislau Rezki (Sony) wrote:
> > Introduce a RCU_NOCB_CPU_CB_BOOST kernel option. So a user can
> > decide if an offloading has to be done in a high-prio context or
> > not. Please note an option depends on RCU_NOCB_CPU and RCU_BOOST
> > parameters. For CONFIG_PREEMPT_RT kernel both RCU_BOOST and the
> > RCU_NOCB_CPU_CB_BOOST are active by default.
> > 
> > This patch splits the CONFIG_RCU_BOOST config into two peaces:
> > a) boosting preempted RCU readers and the kthreads which are
> >    directly responsible for driving expedited grace periods
> >    forward;
> > b) boosting offloading-kthreads in a way that their scheduling
> >    class are changed from SCHED_NORMAL to SCHED_FIFO.
> > 
> > The main reason of such split is, for example on Android there
> > are some workloads which require fast expedited grace period to
> > be done whereas offloading in RT context can lead to starvation
> > and hogging a CPU for a long time what is not acceptable for
> > latency sensitive environment. For instance:
> > 
> > <snip>
> > <...>-60 [006] d..1 2979.028717: rcu_batch_start: rcu_preempt CBs=34619 bl=270
> > <snip>
> > 
> > invoking 34 619 callbacks will take time thus making other CFS
> > tasks waiting in run-queue to be starved due to such behaviour.
> > 
> > v1 -> v2:
> > - fix the comment about the rcuc/rcub/rcuop;
> > - check the kthread_prio against zero value;
> > - by default the RCU_NOCB_CPU_CB_BOOST is ON for PREEMPT_RT.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you both, and I will apply Joel's ack on the next rebase.

						Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > ---
> >  kernel/rcu/Kconfig     | 14 ++++++++++++++
> >  kernel/rcu/tree.c      |  6 +++++-
> >  kernel/rcu/tree_nocb.h |  3 ++-
> >  3 files changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index 27aab870ae4c..a4ed7b5e2b75 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -275,6 +275,20 @@ config RCU_NOCB_CPU_DEFAULT_ALL
> >  	  Say Y here if you want offload all CPUs by default on boot.
> >  	  Say N here if you are unsure.
> >  
> > +config RCU_NOCB_CPU_CB_BOOST
> > +	bool "Offload RCU callback from real-time kthread"
> > +	depends on RCU_NOCB_CPU && RCU_BOOST
> > +	default y if PREEMPT_RT
> > +	help
> > +	  Use this option to offload callbacks from the SCHED_FIFO context
> > +	  to make the process faster. As a side effect of this approach is
> > +	  a latency especially for the SCHED_OTHER tasks which will not be
> > +	  able to preempt an offloading kthread. That latency depends on a
> > +	  number of callbacks to be invoked.
> > +
> > +	  Say Y here if you want to set RT priority for offloading kthreads.
> > +	  Say N here if you are unsure.
> > +
> >  config TASKS_TRACE_RCU_READ_MB
> >  	bool "Tasks Trace RCU readers use memory barriers in user and idle"
> >  	depends on RCU_EXPERT && TASKS_TRACE_RCU
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 9dc4c4e82db6..1c3852b1e0c8 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -154,7 +154,11 @@ static void sync_sched_exp_online_cleanup(int cpu);
> >  static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
> >  static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
> >  
> > -/* rcuc/rcub/rcuop kthread realtime priority */
> > +/*
> > + * rcuc/rcub/rcuop kthread realtime priority. The "rcuop"
> > + * real-time priority(enabling/disabling) is controlled by
> > + * the extra CONFIG_RCU_NOCB_CPU_CB_BOOST configuration.
> > + */
> >  static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
> >  module_param(kthread_prio, int, 0444);
> >  
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 60cc92cc6655..fa8e4f82e60c 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1315,8 +1315,9 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
> >  	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
> >  		goto end;
> >  
> > -	if (kthread_prio)
> > +	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_CB_BOOST) && kthread_prio)
> >  		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
> > +
> >  	WRITE_ONCE(rdp->nocb_cb_kthread, t);
> >  	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
> >  	return;
> > -- 
> > 2.30.2
> > 
