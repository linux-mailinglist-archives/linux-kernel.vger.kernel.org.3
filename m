Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20D14F9BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbiDHRlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiDHRlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:41:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576F87C176;
        Fri,  8 Apr 2022 10:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0816621B9;
        Fri,  8 Apr 2022 17:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C30C385A5;
        Fri,  8 Apr 2022 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649439549;
        bh=2wrDh/YZbJ/uC5KUJ7txH9R5Jnp0s5e2bq9OiFLG3Tg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MgFbvO5viH3Aa8tNVJfs5i0MlkJ5DHWWlB+T89djR3Ev1iCZHbYkg/qPMweHRDree
         Dcpllej+50ZZEQET90FkOJd96U2Rk8ctA3EMpsz/GbuyuRepFjFYYol72psS9/rq1c
         RRuEXdJZjrt63avie59BnM6KWqWGsUc8Bmcn0A7wN49vt6aGC/DPs7oGpd6pkTLlcr
         Cvp1dFTwnepiiGb7rndSaiNWgFDJ+WqjZaQEShBGVg/1MApKEq/ETqqgwmcnoSv8Kh
         M7Y9Ms+ofAICm4EO0s7xXuSdef6ozIa7m7SWxKvdn39WKdy3O9mrrXptd9g9tSMaI4
         fOOpccgsIFEBQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DEFDB5C015B; Fri,  8 Apr 2022 10:39:08 -0700 (PDT)
Date:   Fri, 8 Apr 2022 10:39:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team <kernel-team@android.com>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT
 kthread_worker
Message-ID: <20220408173908.GJ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220408045734.1158817-1-kaleshsingh@google.com>
 <CAEXW_YQ6_VpneJnBfhTOMr6DwJhNmvMAKDRMnpr8LxB9Gtt=Xg@mail.gmail.com>
 <20220408143444.GC4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSrGKXh5DiJyrNvmbssSXbWBkA-XUjGRdS8HtGvW1r6hw@mail.gmail.com>
 <20220408153447.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YT-vJmXgWPQ_1J34iTb+ZhrAgN7c-HPz7kW17HmvKzJ3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YT-vJmXgWPQ_1J34iTb+ZhrAgN7c-HPz7kW17HmvKzJ3A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 01:14:35PM -0400, Joel Fernandes wrote:
> On Fri, Apr 8, 2022 at 11:34 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Apr 08, 2022 at 10:41:26AM -0400, Joel Fernandes wrote:
> > > On Fri, Apr 8, 2022 at 10:34 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Fri, Apr 08, 2022 at 06:42:42AM -0400, Joel Fernandes wrote:
> > > > > On Fri, Apr 8, 2022 at 12:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> > > > > >
> > > > > [...]
> > > > > > @@ -334,15 +334,13 @@ static bool exp_funnel_lock(unsigned long s)
> > > > > >   * Select the CPUs within the specified rcu_node that the upcoming
> > > > > >   * expedited grace period needs to wait for.
> > > > > >   */
> > > > > > -static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > > > > > +static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
> > > > > >  {
> > > > > >         int cpu;
> > > > > >         unsigned long flags;
> > > > > >         unsigned long mask_ofl_test;
> > > > > >         unsigned long mask_ofl_ipi;
> > > > > >         int ret;
> > > > > > -       struct rcu_exp_work *rewp =
> > > > > > -               container_of(wp, struct rcu_exp_work, rew_work);
> > > > > >         struct rcu_node *rnp = container_of(rewp, struct rcu_node, rew);
> > > > > >
> > > > > >         raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > > > @@ -417,13 +415,119 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > > > > >                 rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
> > > > > >  }
> > > > > >
> > > > > > +static void rcu_exp_sel_wait_wake(unsigned long s);
> > > > > > +
> > > > > > +#ifdef CONFIG_RCU_EXP_KTHREAD
> > > > >
> > > > > Just my 2c:
> > > > >
> > > > > Honestly, I am not sure if the benefits of duplicating the code to use
> > > > > normal workqueues outweighs the drawbacks (namely code complexity,
> > > > > code duplication - which can in turn cause more bugs and maintenance
> > > > > headaches down the line). The code is harder to read and adding more
> > > > > 30 character function names does not help.
> > > > >
> > > > > For something as important as expedited GPs, I can't imagine a
> > > > > scenario where an RT kthread worker would cause "issues". If it does
> > > > > cause issues, that's what the -rc cycles and the stable releases are
> > > > > for. I prefer to trust the process than take a one-foot-in-the-door
> > > > > approach.
> > > > >
> > > > > So please, can we just keep it simple?
> > > >
> > > > Yes and no.
> > > >
> > > > This is a bug fix, but only for those systems that are expecting real-time
> > > > response from synchronize_rcu_expedited().  As far as I know, this is only
> > > > Android.  The rest of the systems are just fine with the current behavior.
> > >
> > > As far as you know, but are you sure?
> >
> > None of us are sure.  We are balancing risks and potential benefits.
> 
> Right.
> 
> > > > In addition, this bug fix introduces significant risks, especially in
> > > > terms of performance for throughput-oriented workloads.
> > >
> > > Could you explain what the risk is? That's the part I did not follow.
> > > How can making synchronize_rcu_expedited() work getting priority
> > > introduce throughput issues?
> >
> > Status quo has synchronize_rcu_expedited() workqueues running as
> > SCHED_OTHER.
> 
> Yeah, so if we go by this, you are saying RCU_BOOST likely does not
> work correctly on status quo right? I do not see what in the commit
> message indicates that this is an Android-only issue, let me know what
> I am missing.

Android is in the process of imposing a new requirement, which I have been
letting you get away with calling a bug.  Mostly because I don't care that
much what it is called.  Either way, the code base needs to accommodate
Android's needs with acceptably low risk of breakage elsewhere.

You are right that RCU_BOOST has run additional kthreads at real-time
priority, and has done so for quite some time.  But RCU_BOOST has not
(repeat, NOT) implied real-time response from synchronize_rcu_expedited(),
and the ONLY request thus far has come from Android.

Face it, the fact that synchronize_rcu_expedited() can achieve
tens-of-milliseconds "worst-case" latencies latencies is quite
amazing.  Let's not spoil things by visiting the changes on
workloads that neither need nor care about "worst-case" latencies
from synchronize_rcu_expedited().

The "worst case" with the double quotes is because a single long-running
CPU-bound reader will force increased latencies.  Then again, that is
exactly why Uladzislau created this commit:

0b74356e7b95 ("rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT")

Please note that this commit's short timeouts depend on ANDROID.  If you
are serious about also having this work in ChromeOS, please send a patch
on top of Uladzislau's that also covers ChromeOS.

But please be very careful what you wish for...

Right now, you get expedited RCU CPU stall warnings at 21 seconds
in mainline kernels.  With this commit, that become 20 milliseconds,
but only for ANDROID.

I could easily imagine that the Android guys would welcome help
fixing long-running RCU readers, but I find it even easier to
imagine that some of the more vocal ChromeOS users might stridently
object to being involuntarily recruited to provide such help.  ;-)

> The users affected by this will instead have these running
> > as SCHED_FIFO.  That changes scheduling.  For users not explicitly
> > needing low-latency synchronize_rcu_expedited(), this change is very
> > unlikely to be for the better.  And historically, unnecessarily running
> > portions of RCU at real-time priorities has been a change for the worse.
> > As in greatly increased context-switch rates and consequently degraded
> > performance.  Please note that this is not a theoretical statement:  Real
> > users have really been burned by too much SCHED_FIFO in RCU kthreads in
> > the past.
> 
> Android also has suffered from too much SCHED_FIFO in the past. I
> remember the display thread called 'surfaceflinger' had to be dropped
> from RT privilege at one point.

"With great power..."  ;-)

							Thanx, Paul

> > > > So yes, let's do this bug fix (with appropriate adjustment), but let's
> > > > also avoid exposing the non-Android workloads to risks from the inevitable
> > > > unintended consequences.  ;-)
> > >
> > > I would argue the risk is also adding code complexity and more bugs
> > > without clear rationale for why it is being done. There's always risk
> > > with any change, but that's the -rc cycles and stable kernels help
> > > catch those. I think we should not add more code complexity if it is a
> > > theoretical concern.
> > >
> > > There's also another possible risk - there is a possible hidden
> > > problem here that probably the non-Android folks haven't noticed or
> > > been able to debug. I would rather just do the right thing.
> > >
> > > Just my 2c,
> >
> > Sorry, but my answer is still "no".
> >
> > Your suggested change risks visiting unacceptable performance
> > degradation on a very large number of innocent users for whom current
> > synchronize_rcu_expedited() latency is plenty good enough.
> 
> I believe the process will catch any such risk, but it is your call! ;-)
> 
> Thanks,
> 
> - Joel
