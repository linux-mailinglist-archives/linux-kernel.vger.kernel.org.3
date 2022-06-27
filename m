Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8A055DEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbiF0Vbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiF0Vb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:31:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A0BCB0;
        Mon, 27 Jun 2022 14:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72A8A617E5;
        Mon, 27 Jun 2022 21:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C67C341CC;
        Mon, 27 Jun 2022 21:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656365487;
        bh=pFl5jXI+R+FItl0KPDFfejeWnXc79fJW2HdbYJ9gCA8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TwseWLeFDqNy+Np5qHxdGmckLk7PGJxNAVdMEMAh8E+kJASSQSNEq8KqEEJ1CtphS
         bVx3xEiMpozqHiXZSETG+MwqJjWWgTqGS//NCYUMmXl2+7NL7Tyqgcayd9+J20G2L9
         3nsyPfXT8b5xZKBL2eO+e8VVjq4qD5J3nOh7oakUzJZyx3tw13+CVywhNh8oAsMVWS
         DyYEhWzbLhNgOAwKE0jTlP+pfWJjREWdhBe6rr799cgN8DZlg/hbetmm6YtuCWpuMF
         BSkGPU+dqW/z1DrLDmI4t4rZiyYdAE/0Kxsb9umZLT2fo/umIdVdDghkLz+AS7wBHW
         iKoMX2i6wVmyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6905D5C04B1; Mon, 27 Jun 2022 14:31:26 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:31:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 1/1] rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
Message-ID: <20220627213126.GO1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220627195353.1575285-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627195353.1575285-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:53:53PM +0200, Uladzislau Rezki (Sony) wrote:
> Currently the monitor work is scheduled with a fixed interval that
> is HZ/20 or each 50 milliseconds. The drawback of such approach is
> a low utilization of page slot in some scenarios. The page can store
> up to 512 records. For example on Android system it can look like:

I was looking at queuing this one, but we need a bit more data.  In
the meantime, here is my wordsmithing of the above paragraph:

Currently the monitor work is scheduled with a fixed interval of HZ/20,
which is roughly 50 milliseconds. The drawback of this approach is
low utilization of the 512 page slots in scenarios with infrequence
kvfree_rcu() calls.  For example on an Android system:

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
> where a page only carries few records to reclaim a memory. In order
> to improve batching and make utilization more efficient the patch sets
> a drain interval to 1 second as default one. When a flood is detected
> an interval is adjusted in a way that a reclaim work is re-scheduled
> on a next timer jiffy.

And of the above paragraph:

Out of 512 slots, in all cases, fewer than 10 were actually used.
In order to improve batching and make utilization more efficient this
commit sets a drain interval to a fixed 1-second interval. Floods are
detected when a page fills quickly, and in that case, the reclaim work
is re-scheduled for the next scheduling-clock tick (jiffy).

---

But what we need now is a trace like the one above showing higher utilization
of the pages.  Could you please supply this?

> - default -
> Total time taken by all kfree'ers: 11510245312 ns, loops: 10000, batches: 1553, memory footprint: 70MB
> Total time taken by all kfree'ers: 9813329636  ns, loops: 10000, batches: 1544, memory footprint: 67MB
> Total time taken by all kfree'ers: 10085206318 ns, loops: 10000, batches: 1499, memory footprint: 156MB
> Total time taken by all kfree'ers: 9582207782  ns, loops: 10000, batches: 1456, memory footprint: 103MB
> Total time taken by all kfree'ers: 9872195750  ns, loops: 10000, batches: 1519, memory footprint: 105MB
> Total time taken by all kfree'ers: 9574438300  ns, loops: 10000, batches: 1480, memory footprint: 101MB
> Total time taken by all kfree'ers: 9990015265  ns, loops: 10000, batches: 1489, memory footprint: 127MB
> Total time taken by all kfree'ers: 9978971689  ns, loops: 10000, batches: 1455, memory footprint: 94MB
> Total time taken by all kfree'ers: 10357628090 ns, loops: 10000, batches: 1456, memory footprint: 64MB
> Total time taken by all kfree'ers: 9838469975  ns, loops: 10000, batches: 1448, memory footprint: 131MB
> 
> - patch -
> Total time taken by all kfree'ers: 8488575321  ns, loops: 10000, batches: 1735, memory footprint: 82MB
> Total time taken by all kfree'ers: 9256401034  ns, loops: 10000, batches: 1762, memory footprint: 76MB
> Total time taken by all kfree'ers: 9198011994  ns, loops: 10000, batches: 1751, memory footprint: 82MB
> Total time taken by all kfree'ers: 10590540622 ns, loops: 10000, batches: 1540, memory footprint: 94MB
> Total time taken by all kfree'ers: 9953902918  ns, loops: 10000, batches: 1638, memory footprint: 89MB
> Total time taken by all kfree'ers: 10176669464 ns, loops: 10000, batches: 1613, memory footprint: 84MB
> Total time taken by all kfree'ers: 9387490978  ns, loops: 10000, batches: 1762, memory footprint: 85MB
> Total time taken by all kfree'ers: 9530535341  ns, loops: 10000, batches: 1781, memory footprint: 66MB
> Total time taken by all kfree'ers: 9945442340  ns, loops: 10000, batches: 1758, memory footprint: 68MB
> Total time taken by all kfree'ers: 9188848287  ns, loops: 10000, batches: 1781, memory footprint: 67MB
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index fd16c0b46d9e..c11670ba008e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3249,7 +3249,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
>  
>  
>  /* Maximum number of jiffies to wait before draining a batch. */
> -#define KFREE_DRAIN_JIFFIES (HZ / 50)
> +#define KFREE_DRAIN_JIFFIES (HZ)
>  #define KFREE_N_BATCHES 2
>  #define FREE_N_CHANNELS 2
>  
> @@ -3510,6 +3510,26 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
>  	return !!krcp->head;
>  }
>  
> +static void
> +schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> +{
> +	long delay, delay_left;
> +
> +	delay = READ_ONCE(krcp->count) >= KVFREE_BULK_MAX_ENTR ?
> +		1:KFREE_DRAIN_JIFFIES;

The above fits as one line in 100 characters, like this:

	delay = READ_ONCE(krcp->count) >= KVFREE_BULK_MAX_ENTR ?  1 : KFREE_DRAIN_JIFFIES;

Many of the blank lines below this point in this function are better
removed.

Other than that, looks good!  Could you please resend with the added
trace with the patch applied?

							Thanx, Paul

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
> @@ -3567,7 +3587,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  	// work to repeat an attempt. Because previous batches are
>  	// still in progress.
>  	if (need_offload_krc(krcp))
> -		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +		schedule_delayed_monitor_work(krcp);
>  
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  }
> @@ -3755,7 +3775,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> -		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +		schedule_delayed_monitor_work(krcp);
>  
>  unlock_return:
>  	krc_this_cpu_unlock(krcp, flags);
> @@ -3831,7 +3851,7 @@ void __init kfree_rcu_scheduler_running(void)
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
