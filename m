Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C423C5075D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355900AbiDSQyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355197AbiDSQrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:47:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1052654;
        Tue, 19 Apr 2022 09:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34670B81BEA;
        Tue, 19 Apr 2022 16:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC726C385AB;
        Tue, 19 Apr 2022 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386699;
        bh=CrODZW/+Lw639iRuyZT4bLGZ80HCvsIfxVxfFqyNxds=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Wnu2dbr0/zNh6kDU6dU215pFN4Lfo/P0vNwnZFXDonb2ZrJ3J66dFY3Uu029Cv5PB
         xbspGDPXVcnch/ZMoyzygZCXNa3u53G5tov5FfJVaiwVb4BJo4GePMcX035jW47Pzm
         CTtW1PIrX1+HmTrgfLTu1acbHNErYJ5k0iHcPH0aZD9K6HbBJVJUfBkmYTO/ujI2qV
         nRxrjOrRlc+z1pU6jqMH4WphofQ54N58GjC9HwtSO0ug2jbnQ14iJ9S6RoGGDm+BZ9
         eTHjnljjViutH4q8ySAxJ3EUlx/ky3///Zz3dl7GCB2FKybU7swn/UfKfgDedKSpmc
         n1vabm5drtKhw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 96ABA5C031F; Tue, 19 Apr 2022 09:44:58 -0700 (PDT)
Date:   Tue, 19 Apr 2022 09:44:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rcu 04/11] kernel/smp: Provide boot-time timeout for CSD
 lock diagnostics
Message-ID: <20220419164458.GL4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
 <20220418225359.3945217-4-paulmck@kernel.org>
 <521cad0a-d6ef-77a8-9258-1cf9d3b6d63d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <521cad0a-d6ef-77a8-9258-1cf9d3b6d63d@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:11:46AM +0200, Juergen Gross wrote:
> On 19.04.22 00:53, Paul E. McKenney wrote:
> > Debugging of problems involving insanely long-running SMI handlers
> > proceeds better if the CSD-lock timeout can be adjusted.  This commit
> > therefore provides a new smp.csd_lock_timeout kernel boot parameter
> > that specifies the timeout in milliseconds.  The default remains at the
> > previously hard-coded value of five seconds.
> > 
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Juergen Gross <jgross@suse.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >   Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
> >   kernel/smp.c                                    |  7 +++++--
> >   2 files changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 3f1cc5e317ed..645c4c001b16 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5377,6 +5377,17 @@
> >   	smart2=		[HW]
> >   			Format: <io1>[,<io2>[,...,<io8>]]
> > +	smp.csd_lock_timeout= [KNL]
> > +			Specify the period of time in milliseconds
> > +			that smp_call_function() and friends will wait
> > +			for a CPU to release the CSD lock.  This is
> > +			useful when diagnosing bugs involving CPUs
> > +			disabling interrupts for extended periods
> > +			of time.  Defaults to 5,000 milliseconds, and
> > +			setting a value of zero disables this feature.
> > +			This feature may be more efficiently disabled
> > +			using the csdlock_debug- kernel parameter.
> > +
> >   	smsc-ircc2.nopnp	[HW] Don't use PNP to discover SMC devices
> >   	smsc-ircc2.ircc_cfg=	[HW] Device configuration I/O port
> >   	smsc-ircc2.ircc_sir=	[HW] SIR base I/O port
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 01a7c1706a58..d82439bac401 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -183,7 +183,9 @@ static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
> >   static DEFINE_PER_CPU(void *, cur_csd_info);
> >   static DEFINE_PER_CPU(struct cfd_seq_local, cfd_seq_local);
> > -#define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
> > +static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
> > +module_param(csd_lock_timeout, ulong, 0444);
> > +
> >   static atomic_t csd_bug_count = ATOMIC_INIT(0);
> >   static u64 cfd_seq;
> > @@ -329,6 +331,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> >   	u64 ts2, ts_delta;
> >   	call_single_data_t *cpu_cur_csd;
> >   	unsigned int flags = READ_ONCE(csd->node.u_flags);
> > +	unsigned long long csd_lock_timeout_ns = csd_lock_timeout * NSEC_PER_MSEC;
> >   	if (!(flags & CSD_FLAG_LOCK)) {
> >   		if (!unlikely(*bug_id))
> > @@ -341,7 +344,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> >   	ts2 = sched_clock();
> >   	ts_delta = ts2 - *ts1;
> > -	if (likely(ts_delta <= CSD_LOCK_TIMEOUT))
> > +	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns <= 0))
> 
> csd_lock_timeout_ns is unsigned, so "csd_lock_timeout_ns <= 0" should be rather
> "csd_lock_timeout_ns == 0".
> 
> With that fixed you can add my
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thank you, and will do on next rebase.

							Thanx, Paul
