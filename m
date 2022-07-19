Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E2F57A63F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbiGSSNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbiGSSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:13:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C5545C7;
        Tue, 19 Jul 2022 11:13:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B56C0CE1D68;
        Tue, 19 Jul 2022 18:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D125EC341CA;
        Tue, 19 Jul 2022 18:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658254377;
        bh=7IDEQsSu7XGqQii5Hc55YDEBs2XOffvwiVZc7i3vViY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BZLbvDWJPiufqo5dGCS1gcr5T+Rf2GCsVy84i8mp60q0oy+Yg3GzltJegWE7JaLK6
         m8e2wtyKNE66YKOJ7/5z+WAjW6paWNSd3dPZpcsLCaasT+CNv7/xaqrzqgtADBUup4
         Ti3gPi5PBCjC46LZZws8AZceUXi5P3RoJj8hpsBNGaVLkc1bmZ88/f9uQmFclx4rN3
         Uyd4szTQD/uUqyfVzaT6O+uEYsr620plkpVZrFQbvbhxdqjpHb0guBOPz2n7uxffnY
         Jp3BB6cSk3GzmJwtlgqWBmx1RFTlYaCPDSL/GZ148RRmGVl/qh7jOwvt49uYkH7DAm
         ZWerw5Uc8M+og==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 76FC25C0813; Tue, 19 Jul 2022 11:12:57 -0700 (PDT)
Date:   Tue, 19 Jul 2022 11:12:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH rcu 4/7] rcu/nocb: Add an option to offload all CPUs on
 boot
Message-ID: <20220719181257.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
 <20220620224503.3841196-4-paulmck@kernel.org>
 <7a09896b-88dd-040b-86c0-863f8279a04e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a09896b-88dd-040b-86c0-863f8279a04e@quicinc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:04:07PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 6/21/2022 4:15 AM, Paul E. McKenney wrote:
> > From: Joel Fernandes <joel@joelfernandes.org>
> > 
> > Systems built with CONFIG_RCU_NOCB_CPU=y but booted without either
> > the rcu_nocbs= or rcu_nohz_full= kernel-boot parameters will not have
> > callback offloading on any of the CPUs, nor can any of the CPUs be
> > switched to enable callback offloading at runtime.  Although this is
> > intentional, it would be nice to have a way to offload all the CPUs
> > without having to make random bootloaders specify either the rcu_nocbs=
> > or the rcu_nohz_full= kernel-boot parameters.
> > 
> > This commit therefore provides a new CONFIG_RCU_NOCB_CPU_DEFAULT_ALL
> > Kconfig option that switches the default so as to offload callback
> > processing on all of the CPUs.  This default can still be overridden
> > using the rcu_nocbs= and rcu_nohz_full= kernel-boot parameters.
> > 
> > Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
> > Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
> > (In v4.1, fixed issues with CONFIG maze reported by kernel test robot).
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> 
> 
> Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> 
> One query on cpumask_setall() below
> 
> >   Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
> >   kernel/rcu/Kconfig                              | 13 +++++++++++++
> >   kernel/rcu/tree_nocb.h                          | 15 ++++++++++++++-
> >   3 files changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 2522b11e593f2..34605c275294c 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3659,6 +3659,9 @@
> >   			just as if they had also been called out in the
> >   			rcu_nocbs= boot parameter.
> > +			Note that this argument takes precedence over
> > +			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
> > +
> >   	noiotrap	[SH] Disables trapped I/O port accesses.
> >   	noirqdebug	[X86-32] Disables the code which attempts to detect and
> > @@ -4557,6 +4560,9 @@
> >   			no-callback mode from boot but the mode may be
> >   			toggled at runtime via cpusets.
> > +			Note that this argument takes precedence over
> > +			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
> > +
> >   	rcu_nocb_poll	[KNL]
> >   			Rather than requiring that offloaded CPUs
> >   			(specified by rcu_nocbs= above) explicitly
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index 1c630e573548d..27aab870ae4cf 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -262,6 +262,19 @@ config RCU_NOCB_CPU
> >   	  Say Y here if you need reduced OS jitter, despite added overhead.
> >   	  Say N here if you are unsure.
> > +config RCU_NOCB_CPU_DEFAULT_ALL
> > +	bool "Offload RCU callback processing from all CPUs by default"
> > +	depends on RCU_NOCB_CPU
> > +	default n
> > +	help
> > +	  Use this option to offload callback processing from all CPUs
> > +	  by default, in the absence of the rcu_nocbs or nohz_full boot
> > +	  parameter. This also avoids the need to use any boot parameters
> > +	  to achieve the effect of offloading all CPUs on boot.
> > +
> > +	  Say Y here if you want offload all CPUs by default on boot.
> > +	  Say N here if you are unsure.
> > +
> >   config TASKS_TRACE_RCU_READ_MB
> >   	bool "Tasks Trace RCU readers use memory barriers in user and idle"
> >   	depends on RCU_EXPERT && TASKS_TRACE_RCU
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 4cf9a29bba79d..60cc92cc66552 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1197,11 +1197,21 @@ void __init rcu_init_nohz(void)
> >   {
> >   	int cpu;
> >   	bool need_rcu_nocb_mask = false;
> > +	bool offload_all = false;
> >   	struct rcu_data *rdp;
> > +#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> > +	if (!rcu_state.nocb_is_setup) {
> > +		need_rcu_nocb_mask = true;
> > +		offload_all = true;
> > +	}
> > +#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
> > +
> >   #if defined(CONFIG_NO_HZ_FULL)
> > -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> > +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
> >   		need_rcu_nocb_mask = true;
> > +		offload_all = false; /* NO_HZ_FULL has its own mask. */
> > +	}
> >   #endif /* #if defined(CONFIG_NO_HZ_FULL) */
> >   	if (need_rcu_nocb_mask) {
> > @@ -1222,6 +1232,9 @@ void __init rcu_init_nohz(void)
> >   		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
> >   #endif /* #if defined(CONFIG_NO_HZ_FULL) */
> > +	if (offload_all)
> > +		cpumask_setall(rcu_nocb_mask);
> 
> Do we need to do a cpumask_and(rcu_nocb_mask, cpu_possible_mask,
> rcu_nocb_mask) after setting all cpus in rcu_nocb_mask (cpumask_subset()
> check below takes care of it though)?

Without that cpumask_and(), systems with sparse CPU numbering schemes
(for example, 0, 4, 8, 12, ...) will get a pr_info(), and as you noted,
the needed cpumask_and().

I am inclined to see a complaint before we change this.  And perhaps if
this is to change, the change should be in cpumask_setall() rather than
in rcu_init_nohz().  But that is an argument for later, if at all.  ;-)

And thank you for reviewing this series!

							Thanx, Paul

> Thanks
> Neeraj
> 
> > +
> >   	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
> >   		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
> >   		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
