Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3C856349E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiGANrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiGANrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:47:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE8724F23;
        Fri,  1 Jul 2022 06:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8EAFB83052;
        Fri,  1 Jul 2022 13:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C6DC3411E;
        Fri,  1 Jul 2022 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656683218;
        bh=qNRnX4/f3fAetpNX2EGxbsx6rB2uzCqWJnF0gKG0gMY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qkypO4CL5OweluutU1nYjdzKPJxYOZQUNwCkpf16XAJckuYolY6JwjIlwq59UZoFa
         VeK7nqI4kEv+5lu3A0kjKH5auYczqarx1Sgo6ExBlwVS8hcqO+JepZZhimRjrC1Ao3
         P0QjQV/snPRalKTBuFvbC5ArE27PKA53m9FNluaDwn+x3uW8KyB4R295aOgXfZyd1D
         S7hweNmkQOvwWQ8PrpFbucZpPO991D7NTzOrWtdKiKTT9Sc5YbmFv3kBV0oSRvyvaP
         0oYGU5xgNMIqBQv+5TGJ6sUbDknZK8n8xho4xufju/klzBJXrBjbNeYK2YJxHl1/D8
         BxbDcM1+tv02A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D782C5C06A1; Fri,  1 Jul 2022 06:46:57 -0700 (PDT)
Date:   Fri, 1 Jul 2022 06:46:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     frederic@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        zhangfei.gao@foxmail.com, boqun.feng@gmail.com, urezki@gmail.com,
        shameerali.kolothum.thodi@huawei.com, pbonzini@redhat.com,
        mtosatti@redhat.com, eric.auger@redhat.com,
        chenxiang66@hisilicon.com, maz@kernel.org, zhangfei.gao@linaro.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3] srcu: Reduce blocking agressiveness of expedited
 grace periods further
Message-ID: <20220701134657.GL1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220701031545.9868-1-quic_neeraju@quicinc.com>
 <20220701044955.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <0089986c-7276-cb6c-6fa8-a46ebc818244@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0089986c-7276-cb6c-6fa8-a46ebc818244@quicinc.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 10:34:22AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 7/1/2022 10:19 AM, Paul E. McKenney wrote:
> > On Fri, Jul 01, 2022 at 08:45:45AM +0530, Neeraj Upadhyay wrote:
> > > Commit 640a7d37c3f4 ("srcu: Block less aggressively for expedited
> > > grace periods") highlights a problem where aggressively blocking
> > > SRCU expedited grace periods, as was introduced in commit
> > > 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
> > > from consuming CPU"), introduces ~2 minutes delay to the overall
> > > ~3.5 minutes boot time, when starting VMs with "-bios QEMU_EFI.fd"
> > > cmdline on qemu, which results in very high rate of memslots
> > > add/remove, which causes > ~6000 synchronize_srcu() calls for
> > > kvm->srcu SRCU instance.
> > > 
> > > Below table captures the experiments done by Zhangfei Gao and Shameer
> > > to measure the boottime impact with various values of non-sleeping
> > > per phase counts, with HZ_250 and preemption enabled:
> > > 
> > > +──────────────────────────+────────────────+
> > > | SRCU_MAX_NODELAY_PHASE   | Boot time (s)  |
> > > +──────────────────────────+────────────────+
> > > | 100                      | 30.053         |
> > > | 150                      | 25.151         |
> > > | 200                      | 20.704         |
> > > | 250                      | 15.748         |
> > > | 500                      | 11.401         |
> > > | 1000                     | 11.443         |
> > > | 10000                    | 11.258         |
> > > | 1000000                  | 11.154         |
> > > +──────────────────────────+────────────────+
> > > 
> > > Analysis on the experiment results showed improved boot time
> > > with non blocking delays close to one jiffy duration. This
> > > was also seen when number of per-phase iterations were scaled
> > > to one jiffy.
> > > 
> > > So, this change scales per-grace-period phase number of non-sleeping
> > > polls, such that, non-sleeping polls are done for one jiffy. In addition
> > > to this, srcu_get_delay() call in srcu_gp_end(), which is used to calculate
> > > the delay used for scheduling callbacks, is replaced with the check for
> > > expedited grace period. This is done, to schedule cbs for completed expedited
> > > grace periods immediately, which results in improved boot time seen in
> > > experiments. Testing done by Marc and Zhangfei confirms that this change recovers
> > > most of the performance degradation in boottime; for CONFIG_HZ_250 configuration,
> > > boottime improves from 3m50s to 41s on Marc's setup; and from 2m40s to ~9.7s
> > > on Zhangfei's setup.
> > > 
> > > In addition to the changes to default per phase delays, this change
> > > adds 3 new kernel parameters - srcutree.srcu_max_nodelay,
> > > srcutree.srcu_max_nodelay_phase, srcutree.srcu_retry_check_delay.
> > > This allows users to configure the srcu grace period scanning delays,
> > > depending on their system configuration requirements.
> > > 
> > > Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > Tested-by: Marc Zyngier <maz@kernel.org>
> > > Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > 
> > OK, I am going to try pulling this one into the -rcu "dev" branch,
> > and thank you all!!!
> > 
> > Please see below for a wordsmithed/tagged version of this commit, and
> > please let me know if I messed something up.
> 
> Thanks! looks good to me; one minor nit below.
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 22f57fad06c5fd35cf4b80c652ebbb4dc626fdaa
> > Author: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Date:   Fri Jul 1 08:45:45 2022 +0530
> > 
> >      srcu: Make expedited RCU grace periods block even less frequently
> >      The purpose of commit 282d8998e997 ("srcu: Prevent expedited GPs
> >      and blocking readers from consuming CPU") was to prevent a long
> >      series of never-blocking expedited SRCU grace periods from blocking
> >      kernel-live-patching (KLP) progress.  Although it was successful, it also
> >      resulted in excessive boot times on certain embedded workloads running
> >      under qemu with the "-bios QEMU_EFI.fd" command line.  Here "excessive"
> >      means increasing the boot time up into the three-to-four minute range.
> >      This increase in boot time was due to the more than 6000 back-to-back
> >      invocations of synchronize_rcu_expedited() within the KVM host OS, which
> >      in turn resulted from qemu's emulation of a long series of MMIO accesses.
> >      Commit 640a7d37c3f4 ("srcu: Block less aggressively for expedited grace
> >      periods") did not significantly help this particular use case.
> >      Zhangfei Gao and Shameerali Kolothum Thodi did experiments varying the
> >      value of SRCU_MAX_NODELAY_PHASE with HZ=250 and with various values
> >      of non-sleeping per phase counts on a system with preemption enabled,
> >      and observed the following boot times:
> >      +──────────────────────────+────────────────+
> >      | SRCU_MAX_NODELAY_PHASE   | Boot time (s)  |
> >      +──────────────────────────+────────────────+
> >      | 100                      | 30.053         |
> >      | 150                      | 25.151         |
> >      | 200                      | 20.704         |
> >      | 250                      | 15.748         |
> >      | 500                      | 11.401         |
> >      | 1000                     | 11.443         |
> >      | 10000                    | 11.258         |
> >      | 1000000                  | 11.154         |
> >      +──────────────────────────+────────────────+
> >      Analysis on the experiment results additional improvements with non
> 
> Nit: "results additional improvements" -> "results show additional
> improvements"  ?

Good eyes, will fix on next rebase, and thank you again!

							Thanx, Paul

> Thanks
> Neeraj
> 
> >      blocking delays approaching one jiffy in duration. This improvement was
> >      also seen when number of per-phase iterations were scaled to one jiffy.
> >      This commit therefore scales per-grace-period phase number of non-sleeping
> >      polls so that non-sleeping polls extend for about one jiffy. In addition,
> >      the delay-calculation call to srcu_get_delay() in srcu_gp_end() is
> >      replaced with a simple check for an expedited grace period.  This change
> >      schedules callback invocation immediately after expedited grace periods
> >      complete, which results in greatly improved boot times.  Testing done
> >      by Marc and Zhangfei confirms that this change recovers most of the
> >      performance degradation in boottime; for CONFIG_HZ_250 configuration,
> >      specifically, boot times improve from 3m50s to 41s on Marc's setup;
> >      and from 2m40s to ~9.7s on Zhangfei's setup.
> >      In addition to the changes to default per phase delays, this
> >      change adds 3 new kernel parameters - srcutree.srcu_max_nodelay,
> >      srcutree.srcu_max_nodelay_phase, and srcutree.srcu_retry_check_delay.
> >      This allows users to configure the srcu grace period scanning delays in
> >      order to more quickly react to additional use cases.
> >      Fixes: 640a7d37c3f4 ("srcu: Block less aggressively for expedited grace periods")
> >      Fixes: 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")
> >      Reported-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> >      Reported-by: yueluck <yueluck@163.com>
> >      Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> >      Tested-by: Marc Zyngier <maz@kernel.org>
> >      Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> >      Link: https://lore.kernel.org/all/20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org/
> >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index af647714c113d..7e34086c64f5b 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5805,6 +5805,24 @@
> >   			expediting.  Set to zero to disable automatic
> >   			expediting.
> > +	srcutree.srcu_max_nodelay [KNL]
> > +			Specifies the number of no-delay instances
> > +			per jiffy for which the SRCU grace period
> > +			worker thread will be rescheduled with zero
> > +			delay. Beyond this limit, worker thread will
> > +			be rescheduled with a sleep delay of one jiffy.
> > +
> > +	srcutree.srcu_max_nodelay_phase [KNL]
> > +			Specifies the per-grace-period phase, number of
> > +			non-sleeping polls of readers. Beyond this limit,
> > +			grace period worker thread will be rescheduled
> > +			with a sleep delay of one jiffy, between each
> > +			rescan of the readers, for a grace period phase.
> > +
> > +	srcutree.srcu_retry_check_delay [KNL]
> > +			Specifies number of microseconds of non-sleeping
> > +			delay between each non-sleeping poll of readers.
> > +
> >   	srcutree.small_contention_lim [KNL]
> >   			Specifies the number of update-side contention
> >   			events per jiffy will be tolerated before
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 0db7873f4e95b..1c304fec89c02 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -511,10 +511,52 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
> >   	return sum;
> >   }
> > -#define SRCU_INTERVAL		1	// Base delay if no expedited GPs pending.
> > -#define SRCU_MAX_INTERVAL	10	// Maximum incremental delay from slow readers.
> > -#define SRCU_MAX_NODELAY_PHASE	3	// Maximum per-GP-phase consecutive no-delay instances.
> > -#define SRCU_MAX_NODELAY	100	// Maximum consecutive no-delay instances.
> > +/*
> > + * We use an adaptive strategy for synchronize_srcu() and especially for
> > + * synchronize_srcu_expedited().  We spin for a fixed time period
> > + * (defined below, boot time configurable) to allow SRCU readers to exit
> > + * their read-side critical sections.  If there are still some readers
> > + * after one jiffy, we repeatedly block for one jiffy time periods.
> > + * The blocking time is increased as the grace-period age increases,
> > + * with max blocking time capped at 10 jiffies.
> > + */
> > +#define SRCU_DEFAULT_RETRY_CHECK_DELAY		5
> > +
> > +static ulong srcu_retry_check_delay = SRCU_DEFAULT_RETRY_CHECK_DELAY;
> > +module_param(srcu_retry_check_delay, ulong, 0444);
> > +
> > +#define SRCU_INTERVAL		1		// Base delay if no expedited GPs pending.
> > +#define SRCU_MAX_INTERVAL	10		// Maximum incremental delay from slow readers.
> > +
> > +#define SRCU_DEFAULT_MAX_NODELAY_PHASE_LO	3UL	// Lowmark on default per-GP-phase
> > +							// no-delay instances.
> > +#define SRCU_DEFAULT_MAX_NODELAY_PHASE_HI	1000UL	// Highmark on default per-GP-phase
> > +							// no-delay instances.
> > +
> > +#define SRCU_UL_CLAMP_LO(val, low)	((val) > (low) ? (val) : (low))
> > +#define SRCU_UL_CLAMP_HI(val, high)	((val) < (high) ? (val) : (high))
> > +#define SRCU_UL_CLAMP(val, low, high)	SRCU_UL_CLAMP_HI(SRCU_UL_CLAMP_LO((val), (low)), (high))
> > +// per-GP-phase no-delay instances adjusted to allow non-sleeping poll upto
> > +// one jiffies time duration. Mult by 2 is done to factor in the srcu_get_delay()
> > +// called from process_srcu().
> > +#define SRCU_DEFAULT_MAX_NODELAY_PHASE_ADJUSTED	\
> > +	(2UL * USEC_PER_SEC / HZ / SRCU_DEFAULT_RETRY_CHECK_DELAY)
> > +
> > +// Maximum per-GP-phase consecutive no-delay instances.
> > +#define SRCU_DEFAULT_MAX_NODELAY_PHASE	\
> > +	SRCU_UL_CLAMP(SRCU_DEFAULT_MAX_NODELAY_PHASE_ADJUSTED,	\
> > +		      SRCU_DEFAULT_MAX_NODELAY_PHASE_LO,	\
> > +		      SRCU_DEFAULT_MAX_NODELAY_PHASE_HI)
> > +
> > +static ulong srcu_max_nodelay_phase = SRCU_DEFAULT_MAX_NODELAY_PHASE;
> > +module_param(srcu_max_nodelay_phase, ulong, 0444);
> > +
> > +// Maximum consecutive no-delay instances.
> > +#define SRCU_DEFAULT_MAX_NODELAY	(SRCU_DEFAULT_MAX_NODELAY_PHASE > 100 ?	\
> > +					 SRCU_DEFAULT_MAX_NODELAY_PHASE : 100)
> > +
> > +static ulong srcu_max_nodelay = SRCU_DEFAULT_MAX_NODELAY;
> > +module_param(srcu_max_nodelay, ulong, 0444);
> >   /*
> >    * Return grace-period delay, zero if there are expedited grace
> > @@ -535,7 +577,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
> >   			jbase += j - gpstart;
> >   		if (!jbase) {
> >   			WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> > -			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
> > +			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
> >   				jbase = 1;
> >   		}
> >   	}
> > @@ -612,15 +654,6 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
> >   }
> >   EXPORT_SYMBOL_GPL(__srcu_read_unlock);
> > -/*
> > - * We use an adaptive strategy for synchronize_srcu() and especially for
> > - * synchronize_srcu_expedited().  We spin for a fixed time period
> > - * (defined below) to allow SRCU readers to exit their read-side critical
> > - * sections.  If there are still some readers after a few microseconds,
> > - * we repeatedly block for 1-millisecond time periods.
> > - */
> > -#define SRCU_RETRY_CHECK_DELAY		5
> > -
> >   /*
> >    * Start an SRCU grace period.
> >    */
> > @@ -706,7 +739,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
> >    */
> >   static void srcu_gp_end(struct srcu_struct *ssp)
> >   {
> > -	unsigned long cbdelay;
> > +	unsigned long cbdelay = 1;
> >   	bool cbs;
> >   	bool last_lvl;
> >   	int cpu;
> > @@ -726,7 +759,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> >   	spin_lock_irq_rcu_node(ssp);
> >   	idx = rcu_seq_state(ssp->srcu_gp_seq);
> >   	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
> > -	cbdelay = !!srcu_get_delay(ssp);
> > +	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
> > +		cbdelay = 0;
> > +
> >   	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
> >   	rcu_seq_end(&ssp->srcu_gp_seq);
> >   	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
> > @@ -927,12 +962,16 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> >    */
> >   static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
> >   {
> > +	unsigned long curdelay;
> > +
> > +	curdelay = !srcu_get_delay(ssp);
> > +
> >   	for (;;) {
> >   		if (srcu_readers_active_idx_check(ssp, idx))
> >   			return true;
> > -		if (--trycount + !srcu_get_delay(ssp) <= 0)
> > +		if ((--trycount + curdelay) <= 0)
> >   			return false;
> > -		udelay(SRCU_RETRY_CHECK_DELAY);
> > +		udelay(srcu_retry_check_delay);
> >   	}
> >   }
> > @@ -1588,7 +1627,7 @@ static void process_srcu(struct work_struct *work)
> >   		j = jiffies;
> >   		if (READ_ONCE(ssp->reschedule_jiffies) == j) {
> >   			WRITE_ONCE(ssp->reschedule_count, READ_ONCE(ssp->reschedule_count) + 1);
> > -			if (READ_ONCE(ssp->reschedule_count) > SRCU_MAX_NODELAY)
> > +			if (READ_ONCE(ssp->reschedule_count) > srcu_max_nodelay)
> >   				curdelay = 1;
> >   		} else {
> >   			WRITE_ONCE(ssp->reschedule_count, 1);
> > @@ -1680,6 +1719,11 @@ static int __init srcu_bootup_announce(void)
> >   	pr_info("Hierarchical SRCU implementation.\n");
> >   	if (exp_holdoff != DEFAULT_SRCU_EXP_HOLDOFF)
> >   		pr_info("\tNon-default auto-expedite holdoff of %lu ns.\n", exp_holdoff);
> > +	if (srcu_retry_check_delay != SRCU_DEFAULT_RETRY_CHECK_DELAY)
> > +		pr_info("\tNon-default retry check delay of %lu us.\n", srcu_retry_check_delay);
> > +	if (srcu_max_nodelay != SRCU_DEFAULT_MAX_NODELAY)
> > +		pr_info("\tNon-default max no-delay of %lu.\n", srcu_max_nodelay);
> > +	pr_info("\tMax phase no-delay instances is %lu.\n", srcu_max_nodelay_phase);
> >   	return 0;
> >   }
> >   early_initcall(srcu_bootup_announce);
