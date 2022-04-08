Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A95B4F9B70
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiDHRQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiDHRQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:16:53 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B673C737
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:14:48 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k25so11368576iok.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7R4f+94qI2K6ExVGY0p3omvs96ezNwS+NBDPlgD2fHw=;
        b=x7VZ4v6GavJUvP98gYT0IO36JWQHaZDKGngI52NebyKbuqK1pSLvcTw9VmD10ofbT2
         UUqEY7AwTmD5wYhvsg1tBmxANERQwy4l2DC4yKxpmdgLiYK6e7hUGs/bKF/j3zuFEJnX
         hNbki2Le1C2/sceqwksGM2w1gCbZ0sbRHsdNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7R4f+94qI2K6ExVGY0p3omvs96ezNwS+NBDPlgD2fHw=;
        b=A9OIYEBXBDn47xLDMb6DwXl08si6NbpRbjTuJ/87Q+HnXBX2VUajSqUpfjiCmOYRnW
         m2re9OxDaI6jhnrNMmaWcg2xTmG3p8pBlyB2KJUZJhc7WwEke4R2sYPlaW32Q3XGhzxs
         uBWfdRCwmcNlVjIRJVangg2XogiaWPoJetv2RqUqMP0EosCGfjYLQjtW2k/eA/7/WNOT
         b9N8a3K5cZzn5+4OSOFp1mStKkW3PD8aVExEp0W32O5XaYNjCXPrD2TliW+YYCVLQKX/
         Zi7VHeII1usqnh2xCajq0H5x25KrErg/Fu+jkR9fdRO2r9q1JX0wX9qCfuH/ODJOX8jP
         yKHQ==
X-Gm-Message-State: AOAM533mtwgLIOTmXTPgBAzc6fmwAckqwYoYyS2cAaOSr9vOxvqhvbMP
        T0w+B3lmdGbzJDFpKR/G8VQ0iKxLnomXd09sWnQ12g==
X-Google-Smtp-Source: ABdhPJwodPR0Ms5rL/IPObV1MciwN2GKTSLms5DXA4ge0kHspY7LbH6tZPyh4NeU9b7ai5sRsjAiGZP96oCCaiFyuGA=
X-Received: by 2002:a05:6638:737:b0:317:d5e0:2b3a with SMTP id
 j23-20020a056638073700b00317d5e02b3amr9614023jad.52.1649438087384; Fri, 08
 Apr 2022 10:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220408045734.1158817-1-kaleshsingh@google.com>
 <CAEXW_YQ6_VpneJnBfhTOMr6DwJhNmvMAKDRMnpr8LxB9Gtt=Xg@mail.gmail.com>
 <20220408143444.GC4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YSrGKXh5DiJyrNvmbssSXbWBkA-XUjGRdS8HtGvW1r6hw@mail.gmail.com>
 <20220408153447.GE4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220408153447.GE4285@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Apr 2022 13:14:35 -0400
Message-ID: <CAEXW_YT-vJmXgWPQ_1J34iTb+ZhrAgN7c-HPz7kW17HmvKzJ3A@mail.gmail.com>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 11:34 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Apr 08, 2022 at 10:41:26AM -0400, Joel Fernandes wrote:
> > On Fri, Apr 8, 2022 at 10:34 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Fri, Apr 08, 2022 at 06:42:42AM -0400, Joel Fernandes wrote:
> > > > On Fri, Apr 8, 2022 at 12:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> > > > >
> > > > [...]
> > > > > @@ -334,15 +334,13 @@ static bool exp_funnel_lock(unsigned long s)
> > > > >   * Select the CPUs within the specified rcu_node that the upcoming
> > > > >   * expedited grace period needs to wait for.
> > > > >   */
> > > > > -static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > > > > +static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
> > > > >  {
> > > > >         int cpu;
> > > > >         unsigned long flags;
> > > > >         unsigned long mask_ofl_test;
> > > > >         unsigned long mask_ofl_ipi;
> > > > >         int ret;
> > > > > -       struct rcu_exp_work *rewp =
> > > > > -               container_of(wp, struct rcu_exp_work, rew_work);
> > > > >         struct rcu_node *rnp = container_of(rewp, struct rcu_node, rew);
> > > > >
> > > > >         raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > > @@ -417,13 +415,119 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > > > >                 rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
> > > > >  }
> > > > >
> > > > > +static void rcu_exp_sel_wait_wake(unsigned long s);
> > > > > +
> > > > > +#ifdef CONFIG_RCU_EXP_KTHREAD
> > > >
> > > > Just my 2c:
> > > >
> > > > Honestly, I am not sure if the benefits of duplicating the code to use
> > > > normal workqueues outweighs the drawbacks (namely code complexity,
> > > > code duplication - which can in turn cause more bugs and maintenance
> > > > headaches down the line). The code is harder to read and adding more
> > > > 30 character function names does not help.
> > > >
> > > > For something as important as expedited GPs, I can't imagine a
> > > > scenario where an RT kthread worker would cause "issues". If it does
> > > > cause issues, that's what the -rc cycles and the stable releases are
> > > > for. I prefer to trust the process than take a one-foot-in-the-door
> > > > approach.
> > > >
> > > > So please, can we just keep it simple?
> > >
> > > Yes and no.
> > >
> > > This is a bug fix, but only for those systems that are expecting real-time
> > > response from synchronize_rcu_expedited().  As far as I know, this is only
> > > Android.  The rest of the systems are just fine with the current behavior.
> >
> > As far as you know, but are you sure?
>
> None of us are sure.  We are balancing risks and potential benefits.

Right.

> > > In addition, this bug fix introduces significant risks, especially in
> > > terms of performance for throughput-oriented workloads.
> >
> > Could you explain what the risk is? That's the part I did not follow.
> > How can making synchronize_rcu_expedited() work getting priority
> > introduce throughput issues?
>
> Status quo has synchronize_rcu_expedited() workqueues running as
> SCHED_OTHER.

Yeah, so if we go by this, you are saying RCU_BOOST likely does not
work correctly on status quo right? I do not see what in the commit
message indicates that this is an Android-only issue, let me know what
I am missing.

The users affected by this will instead have these running
> as SCHED_FIFO.  That changes scheduling.  For users not explicitly
> needing low-latency synchronize_rcu_expedited(), this change is very
> unlikely to be for the better.  And historically, unnecessarily running
> portions of RCU at real-time priorities has been a change for the worse.
> As in greatly increased context-switch rates and consequently degraded
> performance.  Please note that this is not a theoretical statement:  Real
> users have really been burned by too much SCHED_FIFO in RCU kthreads in
> the past.

Android also has suffered from too much SCHED_FIFO in the past. I
remember the display thread called 'surfaceflinger' had to be dropped
from RT privilege at one point.

> > > So yes, let's do this bug fix (with appropriate adjustment), but let's
> > > also avoid exposing the non-Android workloads to risks from the inevitable
> > > unintended consequences.  ;-)
> >
> > I would argue the risk is also adding code complexity and more bugs
> > without clear rationale for why it is being done. There's always risk
> > with any change, but that's the -rc cycles and stable kernels help
> > catch those. I think we should not add more code complexity if it is a
> > theoretical concern.
> >
> > There's also another possible risk - there is a possible hidden
> > problem here that probably the non-Android folks haven't noticed or
> > been able to debug. I would rather just do the right thing.
> >
> > Just my 2c,
>
> Sorry, but my answer is still "no".
>
> Your suggested change risks visiting unacceptable performance
> degradation on a very large number of innocent users for whom current
> synchronize_rcu_expedited() latency is plenty good enough.

I believe the process will catch any such risk, but it is your call! ;-)

Thanks,

- Joel
