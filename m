Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B2453D78D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 17:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbiFDPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiFDPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 11:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD7F22B10;
        Sat,  4 Jun 2022 08:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A8B160E8B;
        Sat,  4 Jun 2022 15:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD509C385B8;
        Sat,  4 Jun 2022 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654357868;
        bh=FEHQcNsLZMGrxEuxhkujinKsM+I5SB2FNJRR5waG0Wo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GK6HZgSyOY/sI/Z/nQMjz6QGfyQDcWO77ehVPs5geDr/s9xKWgl5EtWKkaCga0DvN
         YtJ5K1Vv4rpgdyl5+0EJMdc1oSJ7U9Ed7VLCO1ATSQRRgVB8YhmSPJEkaA8c6nUf/M
         EgUtvxL8JNaHcL2Zp9bc9PuuW0vo5ktwf6wMSND05sAZ5B2IRJb23WP76T7vJc4hdw
         3CbcP3eBOSrpIc4qs3W8IqvR4bdSkZ4xosouApL4/H6u54qrTd26HyXfWo/9ZFJcym
         DUQv0f8eedVTftEsGg9hmYcbkYex0zGyull6SFGkZXFB9+iLb+sXKDTMw8/17vxGUI
         IzOhBrvnPKg/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 515FE5C04E6; Sat,  4 Jun 2022 08:51:08 -0700 (PDT)
Date:   Sat, 4 Jun 2022 08:51:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] rcu/kvfree: Introduce KFREE_DRAIN_JIFFIES_[MAX/MIN]
 interval
Message-ID: <20220604155108.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220602080644.432156-1-urezki@gmail.com>
 <20220602080644.432156-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602080644.432156-2-urezki@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 10:06:44AM +0200, Uladzislau Rezki (Sony) wrote:
> Currently the monitor work is scheduled with a fixed interval that
> is HZ/20 or each 50 milliseconds. The drawback of such approach is
> a low utilization of page slot in some scenarios. The page can store
> up to 512 records. For example on Android system it can look like:
> 
> <snip>
>   kworker/3:0-13872   [003] .... 11286.007048: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=1
>   kworker/3:0-13872   [003] .... 11286.015638: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
>   kworker/1:2-20434   [001] .... 11286.051230: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
>   kworker/1:2-20434   [001] .... 11286.059322: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=2
>   kworker/0:1-20052   [000] .... 11286.095295: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=2
>   kworker/0:1-20052   [000] .... 11286.103418: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=1
>   kworker/2:3-14372   [002] .... 11286.135155: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
>   kworker/2:3-14372   [002] .... 11286.135198: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
>   kworker/1:2-20434   [001] .... 11286.155377: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=5
>   kworker/2:3-14372   [002] .... 11286.167181: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=5
>   kworker/1:2-20434   [001] .... 11286.179202: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000008ef95e14 nr_records=1
>   kworker/2:3-14372   [002] .... 11286.187398: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000c597d297 nr_records=6
>   kworker/3:0-13872   [003] .... 11286.187445: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000050bf92e2 nr_records=3
>   kworker/1:2-20434   [001] .... 11286.198975: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=4
>   kworker/1:2-20434   [001] .... 11286.207203: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=4
> <snip>
> 
> where a page only carries few records to reclaim a memory. In order to
> improve batching and make utilization more efficient the patch introduces
> a drain interval that can be set either to KFREE_DRAIN_JIFFIES_MAX or
> KFREE_DRAIN_JIFFIES_MIN. It is adjusted if a flood is detected, in this
> case a memory reclaim occurs more often whereas in mostly idle cases the
> interval is set to its maximum timeout that improves the utilization of
> page slots.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

That does look like a problem well worth solving!

But I am missing one thing.  If we are having a callback flood, why do we
need a shorter timeout?  Wouldn't a check on the number of blocks queued
be simpler, more direct, and provide faster response to the start of a
callback flood?

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index fd16c0b46d9e..c02a64995b85 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3249,7 +3249,8 @@ EXPORT_SYMBOL_GPL(call_rcu);
>  
>  
>  /* Maximum number of jiffies to wait before draining a batch. */
> -#define KFREE_DRAIN_JIFFIES (HZ / 50)
> +#define KFREE_DRAIN_JIFFIES_MAX (HZ)
> +#define KFREE_DRAIN_JIFFIES_MIN (HZ / 50)
>  #define KFREE_N_BATCHES 2
>  #define FREE_N_CHANNELS 2
>  
> @@ -3510,6 +3511,26 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
>  	return !!krcp->head;
>  }
>  
> +static void
> +schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> +{
> +	long delay, delay_left;
> +
> +	delay = READ_ONCE(krcp->count) >= KVFREE_BULK_MAX_ENTR ?
> +		KFREE_DRAIN_JIFFIES_MIN:KFREE_DRAIN_JIFFIES_MAX;
> +
> +	if (delayed_work_pending(&krcp->monitor_work)) {
> +		delay_left = krcp->monitor_work.timer.expires - jiffies;
> +
> +		if (delay < delay_left)
> +			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
> +
> +		return;
> +	}
> +
> +	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> +}
> +
>  /*
>   * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
>   */
> @@ -3567,7 +3588,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  	// work to repeat an attempt. Because previous batches are
>  	// still in progress.
>  	if (need_offload_krc(krcp))
> -		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +		schedule_delayed_monitor_work(krcp);
>  
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  }
> @@ -3755,7 +3776,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> -		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +		schedule_delayed_monitor_work(krcp);
>  
>  unlock_return:
>  	krc_this_cpu_unlock(krcp, flags);
> @@ -3831,7 +3852,7 @@ void __init kfree_rcu_scheduler_running(void)
>  
>  		raw_spin_lock_irqsave(&krcp->lock, flags);
>  		if (need_offload_krc(krcp))
> -			schedule_delayed_work_on(cpu, &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +			schedule_delayed_monitor_work(krcp);
>  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  	}
>  }
> -- 
> 2.30.2
> 
