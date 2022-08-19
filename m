Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638C959A518
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351262AbiHSRrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351682AbiHSRqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:46:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762F010BE2C;
        Fri, 19 Aug 2022 10:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8519B82854;
        Fri, 19 Aug 2022 17:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883C8C433D6;
        Fri, 19 Aug 2022 17:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660929169;
        bh=9jzyWZnZEyriuWF1hvhrtMHPgTWIh4shqshxrcgQSis=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oznBGPqzi3lr2YajpnP6Z0E57P//I3GEwLF4X3w4ijavLc/VYBJlnHbvnGrK4RSKX
         WvY8GGhWwyUr8cFMNdBqZh5Xulc/Kocs7vgUXt9YiAcPqz/tbAwrh6X9iuszBtwrPx
         6tjHV+MXHxytqVDc2RLnqdL3VwbDphrFqSxOSCmD73+mVEwVdRMIbMcCPYbccFyHkc
         yfM1wPkiLB6x0RmvPus5Hgq/diyrsXCWKdNy/hYFwyMrGrfohAgfcDMr9FISP0c2Yo
         Hzd/141FYUD6qez7Rly3VpBJVVsffyfh1xEw2yVpwTMS0/cF4gYv0ShXrvbJ8LWM6V
         NtCm/3cYUUOHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1C2C25C0164; Fri, 19 Aug 2022 10:12:49 -0700 (PDT)
Date:   Fri, 19 Aug 2022 10:12:49 -0700
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
Message-ID: <20220819171249.GP2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <20220809034517.3867176-5-joel@joelfernandes.org>
 <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
 <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com>
 <CAEXW_YT3VnK5KJTbyXdCzs8j4jw9XFTSCF4Dt9QwLPtkPSb1tA@mail.gmail.com>
 <20220819023550.GN2125313@paulmck-ThinkPad-P17-Gen-1>
 <4deb7354-bac7-b530-47ba-54cf50cfce58@joelfernandes.org>
 <2d56e4ad-7d6e-2abb-461f-15f20128d42b@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d56e4ad-7d6e-2abb-461f-15f20128d42b@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 12:30:49PM -0400, Joel Fernandes wrote:
> On 8/18/2022 10:45 PM, Joel Fernandes wrote:
> > On 8/18/2022 10:35 PM, Paul E. McKenney wrote:
> >> On Thu, Aug 18, 2022 at 09:21:56PM -0400, Joel Fernandes wrote:
> >>> On Thu, Aug 18, 2022 at 7:05 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >>>>
> >>>> On Thu, Aug 18, 2022 at 1:23 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >>>>>
> >>>>> [Sorry, adding back the CC list]
> >>>>>
> >>>>> On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
> >>>>> <joel@joelfernandes.org> wrote:
> >>>>>>
> >>>>>> This is required to prevent callbacks triggering RCU machinery too
> >>>>>> quickly and too often, which adds more power to the system.
> >>>>>>
> >>>>>> When testing, we found that these paths were invoked often when the
> >>>>>> system is not doing anything (screen is ON but otherwise idle).
> >>>>>
> >>>>> Unfortunately, I am seeing a slow down in ChromeOS boot performance
> >>>>> after applying this particular patch. It is the first time I could
> >>>>> test ChromeOS boot times with the series since it was hard to find a
> >>>>> ChromeOS device that runs the upstream kernel.
> >>>>>
> >>>>> Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
> >>>>> patch? I wonder if the issue is with wake up interaction with the nocb
> >>>>> GP threads.
> >>>>>
> >>>>> We ought to disable lazy RCU during boot since it would have little
> >>>>> benefit anyway. But I am also concerned about some deeper problem I
> >>>>> did not catch before.
> >>>>>
> >>>>> I'll look into tracing the fs paths to see if I can narrow down what's
> >>>>> causing it. Will also try a newer kernel, I am currently testing on
> >>>>> 5.19-rc4.
> >>>>
> >>>> I got somewhere with this. It looks like queuing CBs as lazy CBs
> >>>> instead of normal CBs, are triggering expedited stalls during the boot
> >>>> process:
> >>>>
> >>>>   39.949198] rcu: INFO: rcu_preempt detected expedited stalls on
> >>>> CPUs/tasks: { } 28 jiffies s: 69 root: 0x0/.
> >>>>
> >>>> No idea how/why lazy RCU CBs would be related to expedited GP issues,
> >>>> but maybe something hangs and causes that side-effect.
> >>>>
> >>>> initcall_debug did not help, as it seems initcalls all work fine, and
> >>>> then 8 seconds after the boot, it starts slowing down a lot, followed
> >>>> by the RCU stall messages. As a next step I'll enable ftrace during
> >>>> the boot to see if I can get more insight. But I believe, its not the
> >>>> FS layer, the FS layer just triggers lazy CBs, but there is something
> >>>> wrong with the core lazy-RCU work itself.
> >>>>
> >>>> This kernel is 5.19-rc4. I'll also try to rebase ChromeOS on more
> >>>> recent kernels and debug.
> >>>
> >>> More digging, thanks to trace_event= boot option , I find that the
> >>> boot process does have some synchronous waits, and though these are
> >>> "non-lazy", for some reason the lazy CBs that were previously queued
> >>> are making them wait for the *full* lazy duration. Which points to a
> >>> likely bug in the lazy RCU logic. These synchronous CBs should never
> >>> be waiting like the lazy ones:
> >>>
> >>> [   17.715904]  => trace_dump_stack
> >>> [   17.715904]  => __wait_rcu_gp
> >>> [   17.715904]  => synchronize_rcu
> >>> [   17.715904]  => selinux_netcache_avc_callback
> >>> [   17.715904]  => avc_ss_reset
> >>> [   17.715904]  => sel_write_enforce
> >>> [   17.715904]  => vfs_write
> >>> [   17.715904]  => ksys_write
> >>> [   17.715904]  => do_syscall_64
> >>> [   17.715904]  => entry_SYSCALL_64_after_hwframe
> >>>
> >>> I'm tired so I'll resume the debug later.
> >>
> >> At times like this, I often pull the suspect code into userspace and
> >> run it through its paces.  In this case, a bunch of call_rcu_lazy()
> >> invocations into an empty bypass list, followed by a call_rcu()
> >> invocation, then a check to make sure that the bypass list is no longer
> >> lazy.
> > 
> > Thanks a lot for this great debug idea, I will look into it.
> 
> It seems to be a subtle issue when a large number of callbacks are
> queued trigging the lock-contention code, which happens at boot. It
> appears the non-lazy ones and lazy ones collide, so you have the lazy
> timer which wins, and then the regular bypass lock-contention timer is
> not allowed to do its thing. Due to this, the rcuog thread wakes up much
> later than a jiffie.

Good show, and glad you found it!

> Things are much better with the following change. However, this brings
> me to a question about lock-contention based or any deferring and boot time.
> 
> If you have a path like selinux doing a synchronize_rcu(), shouldn't we
> skip the jiffie waiting for the bypass timer? Otherwise things
> synchronously waiting will slow down more than usual. Maybe bypassing
> should not be done for any case until boot up is done. I'm curious to
> see if that improves boot time.

Why not simply disable laziness at boot time and enable it only after
booting is complete?  The exiting rcupdate.rcu_normal_after_boot kernel
boot parameter uses a similar scheme.

> @@ -580,7 +585,11 @@ static void __call_rcu_nocb_wake(struct rcu_data
> *rdp, bool was_alldone,
>         len = rcu_segcblist_n_cbs(&rdp->cblist);
>         bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>         lazy_len = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
> -       if (was_alldone) {
> +
> +       // If we are in lazy-mode, we still need to do a wake up even if
> +       // all CBs were previously done. Otherwise the GP thread will
> +       // wait for the full lazy duration.
> +       if (was_alldone || (READ_ONCE(rdp->nocb_defer_wakeup) ==
> RCU_NOCB_WAKE_LAZY)) {
>                 rdp->qlen_last_fqs_check = len;
>                 // Only lazy CBs in bypass list
>                 if (lazy_len && bypass_len == lazy_len) {

And this change looks plausible, though as always, the system's opinion
carries much more weight than does mine.

							Thanx, Paul
