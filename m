Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F315075CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355132AbiDSQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355606AbiDSQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:58:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD743DDEC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:49:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DACF9B81BDF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88096C385A9;
        Tue, 19 Apr 2022 16:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386948;
        bh=COxvLNpbK323jqgWp91NgzZvOEoA6dxCIIi+cjvamIw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FSVQ82FX8P3wZ7Y+CIYI45t3YAjOkFGFiMiHfrX6TS1ZbPlb6hxSi3DRTJf1W9e3L
         EyvLcV79VHyZV+mQLNHelW8qQL0h+RKZ50/BCLv1WeFbkaxjun3Co6tBxzbIithlKk
         liTM0tdHAd09tIkt8dEzpcnwnMshKy+kp3LhQt/tNThnSyolvALE1jZCI91Oux8l5A
         o1l2a1deYEvWM7oXApNVUoFekAPa1MlKEOQzhzDnuK4wzEoptECnjZQTawV5+jStJr
         bBqdT0GsYbSdOwkVpQI+u3/NVhVTyAJm8ydEr/biXUo2agHHupAXWS84OtbiKMcTBD
         uw6SFoF+pxAPw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3521D5C031F; Tue, 19 Apr 2022 09:49:08 -0700 (PDT)
Date:   Tue, 19 Apr 2022 09:49:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH rcu 04/11] kernel/smp: Provide boot-time timeout for CSD
 lock diagnostics
Message-ID: <20220419164908.GM4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
 <20220419085607.2014-1-hdanton@sina.com>
 <20220419134616.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+Y8Az3_gi-UX-KCfQ1dxARJtL1NhB1AGLv9o_5gNtkWOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y8Az3_gi-UX-KCfQ1dxARJtL1NhB1AGLv9o_5gNtkWOg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 04:11:36PM +0200, Dmitry Vyukov wrote:
> On Tue, 19 Apr 2022 at 15:46, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Apr 19, 2022 at 04:56:07PM +0800, Hillf Danton wrote:
> > > On Mon, 18 Apr 2022 15:53:52 -0700 Paul E. McKenney wrote:
> > > > Debugging of problems involving insanely long-running SMI handlers
> > > > proceeds better if the CSD-lock timeout can be adjusted.  This commit
> > > > therefore provides a new smp.csd_lock_timeout kernel boot parameter
> > > > that specifies the timeout in milliseconds.  The default remains at the
> > > > previously hard-coded value of five seconds.
> > > >
> > > > Cc: Rik van Riel <riel@surriel.com>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > Cc: Juergen Gross <jgross@suse.com>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
> > > >  kernel/smp.c                                    |  7 +++++--
> > > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > index 3f1cc5e317ed..645c4c001b16 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -5377,6 +5377,17 @@
> > > >     smart2=         [HW]
> > > >                     Format: <io1>[,<io2>[,...,<io8>]]
> > > >
> > > > +   smp.csd_lock_timeout= [KNL]
> > > > +                   Specify the period of time in milliseconds
> > > > +                   that smp_call_function() and friends will wait
> > > > +                   for a CPU to release the CSD lock.  This is
> > > > +                   useful when diagnosing bugs involving CPUs
> > > > +                   disabling interrupts for extended periods
> > > > +                   of time.  Defaults to 5,000 milliseconds, and
> > > > +                   setting a value of zero disables this feature.
> > > > +                   This feature may be more efficiently disabled
> > > > +                   using the csdlock_debug- kernel parameter.
> > > > +
> > >
> > > Can non-responsive CSD lock detected trigger syzbot (warning) report?
> >
> > If they enable it by building with CONFIG_CSD_LOCK_WAIT_DEBUG=y, yes.
> 
> +syzkaller mailing list
> 
> Currently we don't enable CONFIG_CSD_LOCK_WAIT_DEBUG in syzbot configs.
> Is it a generally useful debugging feature recommended to be enabled
> in kernel testing systems?

With the default value for smp.csd_lock_timeout, it detects CPUs that have
had interrupts disabled for more than five seconds, which can be useful
for detecting what would otherwise be silent response-time failures.

> If we enabled it, we also need to figure out where it fits into the
> timeout hierarchy and adjust smp.csd_lock_timeout:
> https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/x86_64.yml#L15-L40

On this, I must defer to you guys.  I can say that the larger the value
that you choose for smp.csd_lock_timeout, the nearer the beginnning of
that group it should go, but you guys knew that already.  ;-)

                                                        Thanx, Paul

> > > Hillf
> > > >     smsc-ircc2.nopnp        [HW] Don't use PNP to discover SMC devices
> > > >     smsc-ircc2.ircc_cfg=    [HW] Device configuration I/O port
> > > >     smsc-ircc2.ircc_sir=    [HW] SIR base I/O port
> > > > diff --git a/kernel/smp.c b/kernel/smp.c
> > > > index 01a7c1706a58..d82439bac401 100644
> > > > --- a/kernel/smp.c
> > > > +++ b/kernel/smp.c
> > > > @@ -183,7 +183,9 @@ static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
> > > >  static DEFINE_PER_CPU(void *, cur_csd_info);
> > > >  static DEFINE_PER_CPU(struct cfd_seq_local, cfd_seq_local);
> > > >
> > > > -#define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
> > > > +static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
> > > > +module_param(csd_lock_timeout, ulong, 0444);
> > > > +
> > > >  static atomic_t csd_bug_count = ATOMIC_INIT(0);
> > > >  static u64 cfd_seq;
> > > >
> > > > @@ -329,6 +331,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> > > >     u64 ts2, ts_delta;
> > > >     call_single_data_t *cpu_cur_csd;
> > > >     unsigned int flags = READ_ONCE(csd->node.u_flags);
> > > > +   unsigned long long csd_lock_timeout_ns = csd_lock_timeout * NSEC_PER_MSEC;
> > > >
> > > >     if (!(flags & CSD_FLAG_LOCK)) {
> > > >             if (!unlikely(*bug_id))
> > > > @@ -341,7 +344,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> > > >
> > > >     ts2 = sched_clock();
> > > >     ts_delta = ts2 - *ts1;
> > > > -   if (likely(ts_delta <= CSD_LOCK_TIMEOUT))
> > > > +   if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns <= 0))
> > > >             return false;
> > > >
> > > >     firsttime = !*bug_id;
> > > > --
> > > > 2.31.1.189.g2e36527f23
