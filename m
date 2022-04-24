Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B1750D31F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiDXQJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiDXQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:09:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0210B3C7D;
        Sun, 24 Apr 2022 09:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91DC4B80DD4;
        Sun, 24 Apr 2022 16:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5296FC385A9;
        Sun, 24 Apr 2022 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650816406;
        bh=Z6BkxhVfjzdhlhaRDYAuE17V9Z1evObXTCQkezbRmi8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IvhtOEhAjEEPB6LOexUkpg34L7pxnmbDkFcMSjgUB26AyuUM20+KZf1izVbehzeip
         LP4ekFIy2VplhSz+UNys5v87RYkGonBI+Q1GvB4/XHEjXIP775W+nUz5Phb3o+jMFI
         eDTPN/9tnFeZy7MQXfWpejNr4oKy4xfEfYoLTypdY8SmFjOcVNcdSqSJybRyXzPMql
         nQ9APFI8pZL1Db3rhI1KlhzvdfgGt25/RumjUw1D+D8AengmWfpkl8WRI2hVF1/cAF
         4EZ8J93io/YzOhvt5QshwLZUrAro5gJODKn4UZEjnrSJdOoW/jOcJ5PKwdsZeuT4MU
         Bd1vquawpLHuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EFEA95C0364; Sun, 24 Apr 2022 09:06:45 -0700 (PDT)
Date:   Sun, 24 Apr 2022 09:06:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Message-ID: <20220424160645.GN4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220424041747.3172671-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424041747.3172671-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 12:17:47PM +0800, Zqiang wrote:
> If the rcutree.use_softirq is configured, when RCU Stall event
> happened, dump status of all rcuc kthreads who due to starvation
> prevented grace period ends on CPUs that not report quiescent
> state.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Much, much better, thank you!

A few more comments below.

							Thanx, Paul

> ---
>  v1->v2:
>  rework rcuc_kthread_dump function
>  v2->v3:
>  merge this rcuc-stalled information into print_cpu_stall_info()
> 
>  kernel/rcu/tree_stall.h | 46 ++++++++++++++++-------------------------
>  1 file changed, 18 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index d7956c03edbd..3482e37d2e3e 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -407,7 +407,19 @@ static bool rcu_is_gp_kthread_starving(unsigned long *jp)
>  
>  static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp)
>  {
> -	unsigned long j = jiffies - READ_ONCE(rdp->rcuc_activity);
> +	int cpu;
> +	struct task_struct *rcuc;
> +	unsigned long j;
> +
> +	rcuc = rdp->rcu_cpu_kthread_task;
> +	if (!rcuc)
> +		return false;
> +
> +	cpu = task_cpu(rcuc);
> +	if (cpu_is_offline(cpu) || idle_cpu(cpu))
> +		return false;
> +
> +	j = jiffies - READ_ONCE(rdp->rcuc_activity);

Localizing this logic is a good improvement, thank you!

>  	if (jp)
>  		*jp = j;
> @@ -432,6 +444,8 @@ static void print_cpu_stall_info(int cpu)
>  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  	char *ticks_title;
>  	unsigned long ticks_value;
> +	bool rcuc_starved;
> +	unsigned long j;
>  
>  	/*
>  	 * We could be printing a lot while holding a spinlock.  Avoid
> @@ -449,7 +463,8 @@ static void print_cpu_stall_info(int cpu)
>  	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
>  	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
>  			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
> -	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
> +	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
> +	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld rcuc=%ld jiffies(%s) %s\n",

The trick here is to sprintf() to format the "rcuc=%ld jiffies" part of
the message, then just have "%s" instead of the "rcuc=%ld jiffies(%s)",
and then ...

>  	       cpu,
>  	       "O."[!!cpu_online(cpu)],
>  	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
> @@ -462,32 +477,10 @@ static void print_cpu_stall_info(int cpu)
>  	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
>  	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
>  	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
> +	       j, rcuc_starved ? "starved" : "",

... here have:

	       rcu_starved ? buf : "",

Where "buf" is the place you sprintf()ed into.  This is especially
important for kernels that don't have rcuc kthreads in the first place.
We don't need the poor CPU-stalled systems administrator wasting time
wondering what an rcuc is an why anyone would care.  ;-)

>  	       falsepositive ? " (false positive?)" : "");
>  }
>  
> -static void rcuc_kthread_dump(struct rcu_data *rdp)
> -{
> -	int cpu;
> -	unsigned long j;
> -	struct task_struct *rcuc;
> -
> -	rcuc = rdp->rcu_cpu_kthread_task;
> -	if (!rcuc)
> -		return;
> -
> -	cpu = task_cpu(rcuc);
> -	if (cpu_is_offline(cpu) || idle_cpu(cpu))
> -		return;
> -
> -	if (!rcu_is_rcuc_kthread_starving(rdp, &j))
> -		return;
> -
> -	pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
> -	sched_show_task(rcuc);
> -	if (!trigger_single_cpu_backtrace(cpu))
> -		dump_cpu_task(cpu);
> -}
> -
>  /* Complain about starvation of grace-period kthread.  */
>  static void rcu_check_gp_kthread_starvation(void)
>  {
> @@ -659,9 +652,6 @@ static void print_cpu_stall(unsigned long gps)
>  	rcu_check_gp_kthread_expired_fqs_timer();
>  	rcu_check_gp_kthread_starvation();
>  
> -	if (!use_softirq)
> -		rcuc_kthread_dump(rdp);
> -
>  	rcu_dump_cpu_stacks();
>  
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> -- 
> 2.25.1
> 
