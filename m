Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF064968B2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiAVA1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:27:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47592 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiAVA1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:27:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C4F619D7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 00:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88D0C340E1;
        Sat, 22 Jan 2022 00:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642811222;
        bh=VKO20dbIeKjW6ot+U/2LJjKMWTK9KZoi6EFm1n4+s1M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=psqk26OMglrIaBgCIMYNaylglk0S8LkWqwVRhBsqpOs1Oem7E9xrR5+z1ALWOBsap
         dDB0EkryJJyk8zFAjbxXBhrR/xSXEZrJDWTbtbHmU/HZ1UULhtzhRdKBR4NS/ChyNw
         nlGWWGkCRSEKiHsbc1Bf/7bAA2ESyMHBqxcv76NgH8IE5wAC5BRQKG9LbXYx29lVZM
         r0C3vl8IqlvK//7y5x3WfjkhKvmd9gl0HZfb2TsmOfZtya5wE6qg80Cjr2yTxTVOal
         BLfdiY+nFXx13qixJ348RaYyK3X3veWvHGd4TNqBWuHmLK0f/Dvrc/fExQyiSZRAEi
         Z0FRNMON35pdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A01ED5C4C94; Fri, 21 Jan 2022 16:27:02 -0800 (PST)
Date:   Fri, 21 Jan 2022 16:27:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Add per-CPU rcuc task info to RCU CPU stall warnings
Message-ID: <20220122002702.GD947480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220121183000.3942472-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121183000.3942472-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2022 at 02:30:00AM +0800, Zqiang wrote:
> When the 'use_softirq' be set zero, all RCU_SOFTIRQ processing
> be moved to per-CPU rcuc kthreads, if the rcuc kthreads is
> being starved, quiescent state can not report in time. the
> RCU stall may be triggered. this commit adds a stack trace of
> this CPU and dump rcuc kthreads stack to help analyze what
> prevents rcuc kthreads from running.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Excellent point, that information could be quite useful!

Questions below.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c        |  3 +++
>  kernel/rcu/tree.h        |  1 +
>  kernel/rcu/tree_plugin.h |  3 +++
>  kernel/rcu/tree_stall.h  | 39 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 46 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a4c25a6283b0..e3fc31a0f546 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2850,10 +2850,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
>  {
>  	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
>  	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
> +	unsigned long *j = this_cpu_ptr(&rcu_data.rcuc_activity);
>  	int spincnt;
>  
>  	trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
>  	for (spincnt = 0; spincnt < 10; spincnt++) {
> +		WRITE_ONCE(*j, jiffies);
>  		local_bh_disable();
>  		*statusp = RCU_KTHREAD_RUNNING;
>  		local_irq_disable();
> @@ -2874,6 +2876,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
>  	schedule_timeout_idle(2);
>  	trace_rcu_utilization(TPS("End CPU kthread@rcu_yield"));
>  	*statusp = RCU_KTHREAD_WAITING;
> +	WRITE_ONCE(*j, jiffies);
>  }
>  
>  static struct smp_hotplug_thread rcu_cpu_thread_spec = {
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 486fc901bd08..4e0fdebb62e8 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -237,6 +237,7 @@ struct rcu_data {
>  					/* rcuc per-CPU kthread or NULL. */
>  	unsigned int rcu_cpu_kthread_status;
>  	char rcu_cpu_has_work;
> +	unsigned long rcuc_activity;
>  
>  	/* 7) Diagnostic data, including RCU CPU stall warnings. */
>  	unsigned int softirq_snap;	/* Snapshot of softirq activity. */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c5b45c2f68a1..327bbfd79cc6 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -996,12 +996,15 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
>   */
>  static void rcu_cpu_kthread_setup(unsigned int cpu)
>  {
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  #ifdef CONFIG_RCU_BOOST
>  	struct sched_param sp;
>  
>  	sp.sched_priority = kthread_prio;
>  	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
>  #endif /* #ifdef CONFIG_RCU_BOOST */
> +
> +	WRITE_ONCE(rdp->rcuc_activity, jiffies);
>  }
>  
>  #ifdef CONFIG_RCU_BOOST
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 21bebf7c9030..cdead9e9ee20 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -379,6 +379,15 @@ static bool rcu_is_gp_kthread_starving(unsigned long *jp)
>  	return j > 2 * HZ;
>  }
>  
> +static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp)
> +{
> +	unsigned long j = jiffies - READ_ONCE(rdp->rcuc_activity);
> +
> +	if (jp)
> +		*jp = j;
> +	return j > 2 * HZ;
> +}
> +
>  /*
>   * Print out diagnostic information for the specified stalled CPU.
>   *
> @@ -430,6 +439,33 @@ static void print_cpu_stall_info(int cpu)
>  	       falsepositive ? " (false positive?)" : "");
>  }
>  
> +static void rcuc_kthread_dump(struct rcu_data *rdp)
> +{
> +	int cpu;
> +	unsigned long j;
> +	struct task_struct *rcuc = rdp->rcu_cpu_kthread_task;
> +
> +	if (rcu_is_rcuc_kthread_starving(rdp, &j)) {
> +		cpu = rcuc ? task_cpu(rcuc) : -1;
> +
> +		if (rcuc) {
> +			pr_err("%s kthread starved for %ld jiffies, stack dump:\n",
> +									rcuc->comm, j);
> +			sched_show_task(rcuc);
> +			if (cpu >= 0) {
> +				if (cpu_is_offline(cpu))
> +					pr_err("%s kthread last ran on offline CPU %d\n",

But if the CPU is offline, wouldn't we want to avoid printing anything?
In that case it is perfectly normal for that CPU's rcuc kthread to not run
at all.

> +										rcuc->comm, cpu);
> +				else {
> +					pr_err("Dump current CPU stack:\n");
> +					if (!trigger_single_cpu_backtrace(cpu))
> +						dump_cpu_task(cpu);
> +				}

Don't we also need to check for the CPU being idle, and to also avoid
printing anything in that case as well?  If the CPU is idle, it is
again perfectly normal for that CPUs rcuc kthread to not run at all.
Something about battery lifetime on certain types of devices running
the Linux kernel.  ;-)

Also neither offline nor idle CPUs block grace periods.

> +			}
> +		}
> +	}
> +}
> +
>  /* Complain about starvation of grace-period kthread.  */
>  static void rcu_check_gp_kthread_starvation(void)
>  {
> @@ -601,6 +637,9 @@ static void print_cpu_stall(unsigned long gps)
>  	rcu_check_gp_kthread_expired_fqs_timer();
>  	rcu_check_gp_kthread_starvation();
>  
> +	if (!use_softirq)
> +		rcuc_kthread_dump(rdp);
> +
>  	rcu_dump_cpu_stacks();
>  
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> -- 
> 2.25.1
> 
