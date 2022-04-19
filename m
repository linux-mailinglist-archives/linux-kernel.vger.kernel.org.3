Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C589506FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbiDSOOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiDSOOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:14:32 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98869366A4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:11:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id b188so18191621oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KPmlSZW5wuOis6+47J772pVGWG7aMSwalV2yc9fDfY=;
        b=RIE1WOIv2p26iZYnNStOMvpSIoIk2DN2JSvprkbwRq4BKvmtz2pJC+uOn26Wlz8Inx
         sifk/Vw+eySaK93ykEQakbX93Ltb4j3aUAdfcqRlxJhvnC5dPOmyr47pSwJT5rh2Wz4C
         qvEo9+hqXVNal+7kM+Enb9PJq4QXHcHyRJO0xGw/nrjQfplJh1T7XVdqrQQvjFFY8w/A
         jRLL2O9KlYeAVjzDGU2Zmx+y64RTS1I46LGY+51146TAHI+wfMJJ3642UQCnq976z/CI
         yOKj6sCEXbh07Z094tNkE/kkF2REBodOwRQmgZQ2zp9p9Wmt6+vYt7c4eZIuK6OABDJD
         oOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KPmlSZW5wuOis6+47J772pVGWG7aMSwalV2yc9fDfY=;
        b=v7HY/O/4lM3Z4Dw6pvryBsp5xueJnD4LQpKEJ5xms3nkbb9bhq5f5pJNLVISe/BwCG
         Hxziup7G9kgQGmtdKKD/GemrsZktvsTTApWg64V6e/D/3CGwgZ3GtiM7Tj2iE4y/sJCO
         mxKDHOgq6/k7xZDyxDfkBFPXjYedVVOPaU+rm6IeVEPYf7IFdVcv7qkuvHicgoHvglQa
         pXFPiD8aUEDV6d0QqHQkV3pgTxQfYh4f44/9IPvsxKqfmzy8Lg2kKyygzuK18so9PSk+
         M0/siLgJ0q1+JQ+62cme0OTSC4solLbpiebkNLs+ppSODI0eJbEXHJFHFVgZ5l+sasB9
         7UQw==
X-Gm-Message-State: AOAM533iw2qH73mjh/L3aLogyv+PGLjhNTbBBj75MRXvb+TZgAr5c5FL
        zVF0xM3z/f7VHktYCYQecChnxyHKwLMxx/nihTnh4eP5gw6Tb9OE
X-Google-Smtp-Source: ABdhPJwmbdBTwMqt72vlD7clVXoOcnJYR0C0rb3bxkIkWZvCYpyYVBxBpSxFIcMUD/vi3r7nF+Y2+GNlhgvJ6jYOSow=
X-Received: by 2002:a05:6808:21a1:b0:322:b5a1:b261 with SMTP id
 be33-20020a05680821a100b00322b5a1b261mr2131167oib.211.1650377508351; Tue, 19
 Apr 2022 07:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
 <20220419085607.2014-1-hdanton@sina.com> <20220419134616.GE4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220419134616.GE4285@paulmck-ThinkPad-P17-Gen-1>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 Apr 2022 16:11:36 +0200
Message-ID: <CACT4Y+Y8Az3_gi-UX-KCfQ1dxARJtL1NhB1AGLv9o_5gNtkWOg@mail.gmail.com>
Subject: Re: [PATCH rcu 04/11] kernel/smp: Provide boot-time timeout for CSD
 lock diagnostics
To:     paulmck@kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 19 Apr 2022 at 15:46, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Apr 19, 2022 at 04:56:07PM +0800, Hillf Danton wrote:
> > On Mon, 18 Apr 2022 15:53:52 -0700 Paul E. McKenney wrote:
> > > Debugging of problems involving insanely long-running SMI handlers
> > > proceeds better if the CSD-lock timeout can be adjusted.  This commit
> > > therefore provides a new smp.csd_lock_timeout kernel boot parameter
> > > that specifies the timeout in milliseconds.  The default remains at the
> > > previously hard-coded value of five seconds.
> > >
> > > Cc: Rik van Riel <riel@surriel.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Cc: Juergen Gross <jgross@suse.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
> > >  kernel/smp.c                                    |  7 +++++--
> > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 3f1cc5e317ed..645c4c001b16 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -5377,6 +5377,17 @@
> > >     smart2=         [HW]
> > >                     Format: <io1>[,<io2>[,...,<io8>]]
> > >
> > > +   smp.csd_lock_timeout= [KNL]
> > > +                   Specify the period of time in milliseconds
> > > +                   that smp_call_function() and friends will wait
> > > +                   for a CPU to release the CSD lock.  This is
> > > +                   useful when diagnosing bugs involving CPUs
> > > +                   disabling interrupts for extended periods
> > > +                   of time.  Defaults to 5,000 milliseconds, and
> > > +                   setting a value of zero disables this feature.
> > > +                   This feature may be more efficiently disabled
> > > +                   using the csdlock_debug- kernel parameter.
> > > +
> >
> > Can non-responsive CSD lock detected trigger syzbot (warning) report?
>
> If they enable it by building with CONFIG_CSD_LOCK_WAIT_DEBUG=y, yes.

+syzkaller mailing list

Currently we don't enable CONFIG_CSD_LOCK_WAIT_DEBUG in syzbot configs.
Is it a generally useful debugging feature recommended to be enabled
in kernel testing systems?
If we enabled it, we also need to figure out where it fits into the
timeout hierarchy and adjust smp.csd_lock_timeout:
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/x86_64.yml#L15-L40


>                                                         Thanx, Paul
>
> > Hillf
> > >     smsc-ircc2.nopnp        [HW] Don't use PNP to discover SMC devices
> > >     smsc-ircc2.ircc_cfg=    [HW] Device configuration I/O port
> > >     smsc-ircc2.ircc_sir=    [HW] SIR base I/O port
> > > diff --git a/kernel/smp.c b/kernel/smp.c
> > > index 01a7c1706a58..d82439bac401 100644
> > > --- a/kernel/smp.c
> > > +++ b/kernel/smp.c
> > > @@ -183,7 +183,9 @@ static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
> > >  static DEFINE_PER_CPU(void *, cur_csd_info);
> > >  static DEFINE_PER_CPU(struct cfd_seq_local, cfd_seq_local);
> > >
> > > -#define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
> > > +static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
> > > +module_param(csd_lock_timeout, ulong, 0444);
> > > +
> > >  static atomic_t csd_bug_count = ATOMIC_INIT(0);
> > >  static u64 cfd_seq;
> > >
> > > @@ -329,6 +331,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> > >     u64 ts2, ts_delta;
> > >     call_single_data_t *cpu_cur_csd;
> > >     unsigned int flags = READ_ONCE(csd->node.u_flags);
> > > +   unsigned long long csd_lock_timeout_ns = csd_lock_timeout * NSEC_PER_MSEC;
> > >
> > >     if (!(flags & CSD_FLAG_LOCK)) {
> > >             if (!unlikely(*bug_id))
> > > @@ -341,7 +344,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> > >
> > >     ts2 = sched_clock();
> > >     ts_delta = ts2 - *ts1;
> > > -   if (likely(ts_delta <= CSD_LOCK_TIMEOUT))
> > > +   if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns <= 0))
> > >             return false;
> > >
> > >     firsttime = !*bug_id;
> > > --
> > > 2.31.1.189.g2e36527f23
