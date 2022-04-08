Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045574F9C0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbiDHR4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiDHR4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:56:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6782A63C7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:54:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r206-20020a1c44d7000000b0038ccb70e239so554283wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 10:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XW2Xw3dzTJrifHchmV+fjS4daM/TuuRpqcaPhZlRbkM=;
        b=aPlaOQ6iI/r3Gc7wwM1OnVYk+ShDYkDvK/h97q+/Xj/Zdi2eBnFxfxG9H07+yzJ+eg
         AxFUIXA2zNV4WmUYmtMHdqEPXw2ErkM9rZgEPaoR+JFMneD8BJu0ZHLX/4310QOLCdEK
         PpsqjQMzNP5JAIe3HhtEz1QOuNogbTaBgdhu4UGPEy0HFuY0galMUdWbEZ/8jy2oUfS1
         /a3obcqGGPHl41RqUqZ65V2ewAdKgfdEKiXytzFussCPisKCnSALCeFWOyPe1etq5Bw+
         42ZscUjonAOL/wNE9W7FBJa+8DRfjIKtzVXOYdLsdRVTAZEKvRA2QTTu/Tdb4+WOu4CY
         EMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XW2Xw3dzTJrifHchmV+fjS4daM/TuuRpqcaPhZlRbkM=;
        b=w4rU44b/LPil2ltYD4s48oQo+zbhfpjdDhhu3xdEDneL8CVyDTELfsLXQ7suAeyIjv
         gqK1BkuA4rA3cPV1qw/fOzk6ykz9gUsfMlSFX6iFJTDlfFvOSmw4lMWVhopKiP92+qiD
         JQEpMudfnztAAswkKISBqKKZ8iECPnMxygZWX7x44syzr2Rc72HAVnneLrchusjHGgxf
         xFqrGrTlXmFRC+v7auOq0FQ9lWZZrT9PZGQgxLuq6QDpDUAbhomBztIIhlSzU7CsvVtn
         SFyq6Jktt7xpRl7kQ29Sfm/yLMY04v9ylaztekq7Z1RgOBrplwKR507dB6STP87WsG/Z
         17Ig==
X-Gm-Message-State: AOAM531dFoLlTpm7+5QE8tjSUYNrzg1MOf2uiuYB6AJzIQgovyjKEa0A
        h4y6cOc9rJ9zo8dqAWapOQ/4sS63LUzrVZo9Td0Z2w==
X-Google-Smtp-Source: ABdhPJyYYeRqiSyVL3mth5Hy5DKtRXUjr9L/c4nsugTNu1a3fZ5oOMxdLc/1cPSMyPIakb8A6TvdddvQpEBmiH+OH/Q=
X-Received: by 2002:a1c:ac44:0:b0:38e:a7df:3179 with SMTP id
 v65-20020a1cac44000000b0038ea7df3179mr3527686wme.61.1649440444687; Fri, 08
 Apr 2022 10:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220408045734.1158817-1-kaleshsingh@google.com>
 <CAEXW_YQ6_VpneJnBfhTOMr6DwJhNmvMAKDRMnpr8LxB9Gtt=Xg@mail.gmail.com>
 <20220408143444.GC4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YSrGKXh5DiJyrNvmbssSXbWBkA-XUjGRdS8HtGvW1r6hw@mail.gmail.com>
 <20220408153447.GE4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YT-vJmXgWPQ_1J34iTb+ZhrAgN7c-HPz7kW17HmvKzJ3A@mail.gmail.com>
 <20220408173908.GJ4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220408173908.GJ4285@paulmck-ThinkPad-P17-Gen-1>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 8 Apr 2022 10:53:53 -0700
Message-ID: <CAC_TJvf_ubOPUVpNYK9UUWXn5J5hpiTkOt2++kYTGbF9bM_pYw@mail.gmail.com>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 10:39 AM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Fri, Apr 08, 2022 at 01:14:35PM -0400, Joel Fernandes wrote:
> > On Fri, Apr 8, 2022 at 11:34 AM Paul E. McKenney <paulmck@kernel.org> w=
rote:
> > >
> > > On Fri, Apr 08, 2022 at 10:41:26AM -0400, Joel Fernandes wrote:
> > > > On Fri, Apr 8, 2022 at 10:34 AM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> > > > >
> > > > > On Fri, Apr 08, 2022 at 06:42:42AM -0400, Joel Fernandes wrote:
> > > > > > On Fri, Apr 8, 2022 at 12:57 AM Kalesh Singh <kaleshsingh@googl=
e.com> wrote:
> > > > > > >
> > > > > > [...]
> > > > > > > @@ -334,15 +334,13 @@ static bool exp_funnel_lock(unsigned lo=
ng s)
> > > > > > >   * Select the CPUs within the specified rcu_node that the up=
coming
> > > > > > >   * expedited grace period needs to wait for.
> > > > > > >   */
> > > > > > > -static void sync_rcu_exp_select_node_cpus(struct work_struct=
 *wp)
> > > > > > > +static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_w=
ork *rewp)
> > > > > > >  {
> > > > > > >         int cpu;
> > > > > > >         unsigned long flags;
> > > > > > >         unsigned long mask_ofl_test;
> > > > > > >         unsigned long mask_ofl_ipi;
> > > > > > >         int ret;
> > > > > > > -       struct rcu_exp_work *rewp =3D
> > > > > > > -               container_of(wp, struct rcu_exp_work, rew_wor=
k);
> > > > > > >         struct rcu_node *rnp =3D container_of(rewp, struct rc=
u_node, rew);
> > > > > > >
> > > > > > >         raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > > > > @@ -417,13 +415,119 @@ static void sync_rcu_exp_select_node_c=
pus(struct work_struct *wp)
> > > > > > >                 rcu_report_exp_cpu_mult(rnp, mask_ofl_test, f=
alse);
> > > > > > >  }
> > > > > > >
> > > > > > > +static void rcu_exp_sel_wait_wake(unsigned long s);
> > > > > > > +
> > > > > > > +#ifdef CONFIG_RCU_EXP_KTHREAD
> > > > > >
> > > > > > Just my 2c:
> > > > > >
> > > > > > Honestly, I am not sure if the benefits of duplicating the code=
 to use
> > > > > > normal workqueues outweighs the drawbacks (namely code complexi=
ty,
> > > > > > code duplication - which can in turn cause more bugs and mainte=
nance
> > > > > > headaches down the line). The code is harder to read and adding=
 more
> > > > > > 30 character function names does not help.
> > > > > >
> > > > > > For something as important as expedited GPs, I can't imagine a
> > > > > > scenario where an RT kthread worker would cause "issues". If it=
 does
> > > > > > cause issues, that's what the -rc cycles and the stable release=
s are
> > > > > > for. I prefer to trust the process than take a one-foot-in-the-=
door
> > > > > > approach.
> > > > > >
> > > > > > So please, can we just keep it simple?
> > > > >
> > > > > Yes and no.
> > > > >
> > > > > This is a bug fix, but only for those systems that are expecting =
real-time
> > > > > response from synchronize_rcu_expedited().  As far as I know, thi=
s is only
> > > > > Android.  The rest of the systems are just fine with the current =
behavior.
> > > >
> > > > As far as you know, but are you sure?
> > >
> > > None of us are sure.  We are balancing risks and potential benefits.
> >
> > Right.
> >
> > > > > In addition, this bug fix introduces significant risks, especiall=
y in
> > > > > terms of performance for throughput-oriented workloads.
> > > >
> > > > Could you explain what the risk is? That's the part I did not follo=
w.
> > > > How can making synchronize_rcu_expedited() work getting priority
> > > > introduce throughput issues?
> > >
> > > Status quo has synchronize_rcu_expedited() workqueues running as
> > > SCHED_OTHER.
> >
> > Yeah, so if we go by this, you are saying RCU_BOOST likely does not
> > work correctly on status quo right? I do not see what in the commit
> > message indicates that this is an Android-only issue, let me know what
> > I am missing.
>
> Android is in the process of imposing a new requirement, which I have bee=
n
> letting you get away with calling a bug.  Mostly because I don't care tha=
t
> much what it is called.  Either way, the code base needs to accommodate
> Android's needs with acceptably low risk of breakage elsewhere.
>
> You are right that RCU_BOOST has run additional kthreads at real-time
> priority, and has done so for quite some time.  But RCU_BOOST has not
> (repeat, NOT) implied real-time response from synchronize_rcu_expedited()=
,
> and the ONLY request thus far has come from Android.
>
> Face it, the fact that synchronize_rcu_expedited() can achieve
> tens-of-milliseconds "worst-case" latencies latencies is quite
> amazing.  Let's not spoil things by visiting the changes on
> workloads that neither need nor care about "worst-case" latencies
> from synchronize_rcu_expedited().
>
> The "worst case" with the double quotes is because a single long-running
> CPU-bound reader will force increased latencies.  Then again, that is
> exactly why Uladzislau created this commit:
>
> 0b74356e7b95 ("rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT")
>
> Please note that this commit's short timeouts depend on ANDROID.  If you
> are serious about also having this work in ChromeOS, please send a patch
> on top of Uladzislau's that also covers ChromeOS.
>
> But please be very careful what you wish for...
>
> Right now, you get expedited RCU CPU stall warnings at 21 seconds
> in mainline kernels.  With this commit, that become 20 milliseconds,
> but only for ANDROID.
>
> I could easily imagine that the Android guys would welcome help
> fixing long-running RCU readers, but I find it even easier to
> imagine that some of the more vocal ChromeOS users might stridently
> object to being involuntarily recruited to provide such help.  ;-)

Thanks for the discussion everyone.

We didn't fully switch to kthread workers to avoid changing the
behavior for users that don=E2=80=99t need this low latency exp GPs. Anothe=
r
(and perhaps more important) reason is because kthread_worker offers
reduced concurrency than workqueues which Pual reported can pose
issues on systems with a large number of CPUs.

The Kconfig depends on RCU_EXPERT. Android enables RCU_EXPERT in the
common kernels defconfigs to allow configuring performance
optimizations. Changing to depend on CONFIG_ANDROID would also mean
less testing. So I prefer to keep RCU_EXPERT.

If PREEMT_RT systems don=E2=80=99t disable expedited grace periods, we can
remove default off for those. Steve?

Thanks,
Kalesh

>
> > The users affected by this will instead have these running
> > > as SCHED_FIFO.  That changes scheduling.  For users not explicitly
> > > needing low-latency synchronize_rcu_expedited(), this change is very
> > > unlikely to be for the better.  And historically, unnecessarily runni=
ng
> > > portions of RCU at real-time priorities has been a change for the wor=
se.
> > > As in greatly increased context-switch rates and consequently degrade=
d
> > > performance.  Please note that this is not a theoretical statement:  =
Real
> > > users have really been burned by too much SCHED_FIFO in RCU kthreads =
in
> > > the past.
> >
> > Android also has suffered from too much SCHED_FIFO in the past. I
> > remember the display thread called 'surfaceflinger' had to be dropped
> > from RT privilege at one point.
>
> "With great power..."  ;-)
>
>                                                         Thanx, Paul
>
> > > > > So yes, let's do this bug fix (with appropriate adjustment), but =
let's
> > > > > also avoid exposing the non-Android workloads to risks from the i=
nevitable
> > > > > unintended consequences.  ;-)
> > > >
> > > > I would argue the risk is also adding code complexity and more bugs
> > > > without clear rationale for why it is being done. There's always ri=
sk
> > > > with any change, but that's the -rc cycles and stable kernels help
> > > > catch those. I think we should not add more code complexity if it i=
s a
> > > > theoretical concern.
> > > >
> > > > There's also another possible risk - there is a possible hidden
> > > > problem here that probably the non-Android folks haven't noticed or
> > > > been able to debug. I would rather just do the right thing.
> > > >
> > > > Just my 2c,
> > >
> > > Sorry, but my answer is still "no".
> > >
> > > Your suggested change risks visiting unacceptable performance
> > > degradation on a very large number of innocent users for whom current
> > > synchronize_rcu_expedited() latency is plenty good enough.
> >
> > I believe the process will catch any such risk, but it is your call! ;-=
)
> >
> > Thanks,
> >
> > - Joel
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
