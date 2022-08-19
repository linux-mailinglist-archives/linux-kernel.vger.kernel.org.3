Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FED59A6D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351669AbiHST6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiHST6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:58:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7613048C84;
        Fri, 19 Aug 2022 12:58:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EA1EB828FA;
        Fri, 19 Aug 2022 19:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BCAC433D7;
        Fri, 19 Aug 2022 19:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660939111;
        bh=C1JXIdnVb41TYPer8h1wl9nVSvCgk1eQOMlT0zf3q+Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qnoRwB+boyyeOBhhtQg6yoVwUDOK7b0Ix9ZrUCqVx8jQkEUIJ3PZ0gPMC4NwUEI6u
         z11nEUBXOO3iTIlK2XN6A1SH4HBSmZpNc8pDgbdjaF01Y4SjT7YBKrR2KOk7v81uce
         +gi4/dvXn+R9/82q8ovrRiEVUecBXtDO5rLxlIo1q2Rv5AFbwVoO/15FqXbxexsk2x
         L5AEu4sMFk/o/G1CJuhWtM+8/3kcVINhEBlIk0lK+Tw3mhNKX3nsqTj0y1WboyzY7v
         sorv0xWGNxcwY3TpIivJ52e31q7zv2gd1tOuSoO2jKvJRdwQW5fRclc9BHONisD70V
         RPOwocckAcFMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2CCF05C0863; Fri, 19 Aug 2022 12:58:31 -0700 (PDT)
Date:   Fri, 19 Aug 2022 12:58:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
Message-ID: <20220819195831.GR2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220809034517.3867176-5-joel@joelfernandes.org>
 <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
 <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com>
 <CAEXW_YT3VnK5KJTbyXdCzs8j4jw9XFTSCF4Dt9QwLPtkPSb1tA@mail.gmail.com>
 <20220819023550.GN2125313@paulmck-ThinkPad-P17-Gen-1>
 <4deb7354-bac7-b530-47ba-54cf50cfce58@joelfernandes.org>
 <2d56e4ad-7d6e-2abb-461f-15f20128d42b@joelfernandes.org>
 <20220819171249.GP2125313@paulmck-ThinkPad-P17-Gen-1>
 <fa8b7857-b9fd-72ad-36a7-8b09e4472816@joelfernandes.org>
 <b2a2742c-8e4e-152d-812f-987c8a941ddf@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a2742c-8e4e-152d-812f-987c8a941ddf@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 03:40:00PM -0400, Joel Fernandes wrote:
> On 8/19/2022 2:14 PM, Joel Fernandes wrote:
> > On 8/19/2022 1:12 PM, Paul E. McKenney wrote:
> >> On Fri, Aug 19, 2022 at 12:30:49PM -0400, Joel Fernandes wrote:
> >>> On 8/18/2022 10:45 PM, Joel Fernandes wrote:
> >>>> On 8/18/2022 10:35 PM, Paul E. McKenney wrote:
> >>>>> On Thu, Aug 18, 2022 at 09:21:56PM -0400, Joel Fernandes wrote:
> >>>>>> On Thu, Aug 18, 2022 at 7:05 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >>>>>>>
> >>>>>>> On Thu, Aug 18, 2022 at 1:23 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >>>>>>>>
> >>>>>>>> [Sorry, adding back the CC list]
> >>>>>>>>
> >>>>>>>> On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
> >>>>>>>> <joel@joelfernandes.org> wrote:
> >>>>>>>>>
> >>>>>>>>> This is required to prevent callbacks triggering RCU machinery too
> >>>>>>>>> quickly and too often, which adds more power to the system.
> >>>>>>>>>
> >>>>>>>>> When testing, we found that these paths were invoked often when the
> >>>>>>>>> system is not doing anything (screen is ON but otherwise idle).
> >>>>>>>>
> >>>>>>>> Unfortunately, I am seeing a slow down in ChromeOS boot performance
> >>>>>>>> after applying this particular patch. It is the first time I could
> >>>>>>>> test ChromeOS boot times with the series since it was hard to find a
> >>>>>>>> ChromeOS device that runs the upstream kernel.
> >>>>>>>>
> >>>>>>>> Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
> >>>>>>>> patch? I wonder if the issue is with wake up interaction with the nocb
> >>>>>>>> GP threads.
> >>>>>>>>
> >>>>>>>> We ought to disable lazy RCU during boot since it would have little
> >>>>>>>> benefit anyway. But I am also concerned about some deeper problem I
> >>>>>>>> did not catch before.
> >>>>>>>>
> >>>>>>>> I'll look into tracing the fs paths to see if I can narrow down what's
> >>>>>>>> causing it. Will also try a newer kernel, I am currently testing on
> >>>>>>>> 5.19-rc4.
> >>>>>>>
> >>>>>>> I got somewhere with this. It looks like queuing CBs as lazy CBs
> >>>>>>> instead of normal CBs, are triggering expedited stalls during the boot
> >>>>>>> process:
> >>>>>>>
> >>>>>>>   39.949198] rcu: INFO: rcu_preempt detected expedited stalls on
> >>>>>>> CPUs/tasks: { } 28 jiffies s: 69 root: 0x0/.
> >>>>>>>
> >>>>>>> No idea how/why lazy RCU CBs would be related to expedited GP issues,
> >>>>>>> but maybe something hangs and causes that side-effect.
> >>>>>>>
> >>>>>>> initcall_debug did not help, as it seems initcalls all work fine, and
> >>>>>>> then 8 seconds after the boot, it starts slowing down a lot, followed
> >>>>>>> by the RCU stall messages. As a next step I'll enable ftrace during
> >>>>>>> the boot to see if I can get more insight. But I believe, its not the
> >>>>>>> FS layer, the FS layer just triggers lazy CBs, but there is something
> >>>>>>> wrong with the core lazy-RCU work itself.
> >>>>>>>
> >>>>>>> This kernel is 5.19-rc4. I'll also try to rebase ChromeOS on more
> >>>>>>> recent kernels and debug.
> >>>>>>
> >>>>>> More digging, thanks to trace_event= boot option , I find that the
> >>>>>> boot process does have some synchronous waits, and though these are
> >>>>>> "non-lazy", for some reason the lazy CBs that were previously queued
> >>>>>> are making them wait for the *full* lazy duration. Which points to a
> >>>>>> likely bug in the lazy RCU logic. These synchronous CBs should never
> >>>>>> be waiting like the lazy ones:
> >>>>>>
> >>>>>> [   17.715904]  => trace_dump_stack
> >>>>>> [   17.715904]  => __wait_rcu_gp
> >>>>>> [   17.715904]  => synchronize_rcu
> >>>>>> [   17.715904]  => selinux_netcache_avc_callback
> >>>>>> [   17.715904]  => avc_ss_reset
> >>>>>> [   17.715904]  => sel_write_enforce
> >>>>>> [   17.715904]  => vfs_write
> >>>>>> [   17.715904]  => ksys_write
> >>>>>> [   17.715904]  => do_syscall_64
> >>>>>> [   17.715904]  => entry_SYSCALL_64_after_hwframe
> >>>>>>
> >>>>>> I'm tired so I'll resume the debug later.
> >>>>>
> >>>>> At times like this, I often pull the suspect code into userspace and
> >>>>> run it through its paces.  In this case, a bunch of call_rcu_lazy()
> >>>>> invocations into an empty bypass list, followed by a call_rcu()
> >>>>> invocation, then a check to make sure that the bypass list is no longer
> >>>>> lazy.
> >>>>
> >>>> Thanks a lot for this great debug idea, I will look into it.
> >>>
> >>> It seems to be a subtle issue when a large number of callbacks are
> >>> queued trigging the lock-contention code, which happens at boot. It
> >>> appears the non-lazy ones and lazy ones collide, so you have the lazy
> >>> timer which wins, and then the regular bypass lock-contention timer is
> >>> not allowed to do its thing. Due to this, the rcuog thread wakes up much
> >>> later than a jiffie.
> >>
> >> Good show, and glad you found it!
> > 
> > Thanks!
> > 
> >>> Things are much better with the following change. However, this brings
> >>> me to a question about lock-contention based or any deferring and boot time.
> >>>
> >>> If you have a path like selinux doing a synchronize_rcu(), shouldn't we
> >>> skip the jiffie waiting for the bypass timer? Otherwise things
> >>> synchronously waiting will slow down more than usual. Maybe bypassing
> >>> should not be done for any case until boot up is done. I'm curious to
> >>> see if that improves boot time.
> >>
> >> Why not simply disable laziness at boot time and enable it only after
> >> booting is complete?  The exiting rcupdate.rcu_normal_after_boot kernel
> >> boot parameter uses a similar scheme.
> > 
> > That sounds like the right thing to good, but unfortunately it wont help
> > this problem. The boot time issue happens after init has started. So the
> > OS is still "booting" even though the kernel has.
> > 
> > Also the problem can happen after boot as well, like if RCU
> > lazy/non-lazy callbacks come back to back quickly, or so.
> > 
> > But yes nonetheless, I can see the value of disabling it till the
> > in-kernel boot completets.
> > 
> >>> @@ -580,7 +585,11 @@ static void __call_rcu_nocb_wake(struct rcu_data
> >>> *rdp, bool was_alldone,
> >>>         len = rcu_segcblist_n_cbs(&rdp->cblist);
> >>>         bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> >>>         lazy_len = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
> >>> -       if (was_alldone) {
> >>> +
> >>> +       // If we are in lazy-mode, we still need to do a wake up even if
> >>> +       // all CBs were previously done. Otherwise the GP thread will
> >>> +       // wait for the full lazy duration.
> >>> +       if (was_alldone || (READ_ONCE(rdp->nocb_defer_wakeup) ==
> >>> RCU_NOCB_WAKE_LAZY)) {
> >>>                 rdp->qlen_last_fqs_check = len;
> >>>                 // Only lazy CBs in bypass list
> >>>                 if (lazy_len && bypass_len == lazy_len) {
> >>
> >> And this change looks plausible, though as always, the system's opinion
> >> carries much more weight than does mine.
> > 
> > Sounds good, thanks, I am testing it more. Will update it for v4.
> 
> We could also do the following, I tested it and it fixes it. It seems more maintainable
> and less fragile, but it comes at a slightly higher (but likely negligible) cost. If there
> are lazy CBs queued, and any non-lazy one comes, then the first non-lazy one is not
> considered to be added to the bypass list but hopefully that's Ok with you. Later non-lazy
> ones will be added to the bypass.

At first I was concerned that you intended to reorder the callbacks,
but fortunately that is not what the patch below does.  ;-)

But don't you also need to clear the "lazy" flag at some point in this
execution path?  After all, once a non-lazy callback arrives, all the
callbacks are treated as if they are non-lazy, correct?

							Thanx, Paul

> @@ -484,9 +490,17 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head
> *rhp,
>         // since we are kick-starting RCU GP processing anyway for the non-lazy
>         // one, we can just reuse that GP for the already queued-up lazy ones.
>         if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
> -           (lazy && n_lazy_cbs >= qhimark)) {
> +           (!lazy && n_lazy_cbs) ||
> +           (lazy  && n_lazy_cbs >= qhimark)) {
>                 rcu_nocb_lock(rdp);
> -               *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> +
> +               // This variable helps decide if a wakeup of the rcuog thread
> +               // is needed. It is passed to __call_rcu_nocb_wake() by the
> +               // caller.  If only lazy CBs were previously queued and this one
> +               // is non-lazy, make sure the caller does a wake up.
> +               *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist) ||
> +                               (!lazy && n_lazy_cbs);
> +
>                 if (*was_alldone)
>                         trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>                                             lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
> @@ -500,7 +514,8 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head
> *rhp,
>         if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) || ncbs >= qhimark) {
>                 rcu_nocb_lock(rdp);
>                 if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy, false)) {
> -                       *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> +                       *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist) ||
> +                               (!lazy && n_lazy_cbs);
>                         if (*was_alldone)
>                                 trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>                                                     lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
