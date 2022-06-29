Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F813560587
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiF2QNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiF2QNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:13:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417AA252B3;
        Wed, 29 Jun 2022 09:13:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03AA5B82565;
        Wed, 29 Jun 2022 16:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DADC34114;
        Wed, 29 Jun 2022 16:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656519194;
        bh=AIKTRuti1Ch4YXrNwXL9OsbzUmqYoxIuCyCJpJgcCuA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NsmENiRRxTRt6Sx0nXI/nKnarbgGNWdzbKGm/2KX4mgjv7g8c5dSQPNd8NeGtMjRA
         KCNVW3l7NGJ+LAbDA38RYSP5dBIeVTVqNq5VyPrUd0Xm7WHhbcwfcxIxV/RXWlZd99
         SZAI6bEBDbjgPQxxTftljeUyzFhqtrRhFjAdE4YabO6iUlSzozUv2z8f8Zgfph2Np9
         dDN1aW7bj73viRFkqTvXFS+H4X0x+bHu870wGBOz3ITHydvttzJmsKBV5YZJtgeU7t
         8WL2K+ecLkryEXA8LnJuHP+URzBmvUJzsnu8fgzKoctD4xHJEAMRyjJz9d4rC0eOCt
         Oh+YavC7XRzBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 513EE5C0921; Wed, 29 Jun 2022 09:13:14 -0700 (PDT)
Date:   Wed, 29 Jun 2022 09:13:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 1/1] rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
Message-ID: <20220629161314.GF1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220627195353.1575285-1-urezki@gmail.com>
 <20220627213126.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yrrp2044RY6amuLo@pc638.lan>
 <YrrtyuMQX/ormVyO@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrrtyuMQX/ormVyO@pc638.lan>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:02:18PM +0200, Uladzislau Rezki wrote:
> On Tue, Jun 28, 2022 at 01:45:31PM +0200, Uladzislau Rezki wrote:
> > > On Mon, Jun 27, 2022 at 09:53:53PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > Currently the monitor work is scheduled with a fixed interval that
> > > > is HZ/20 or each 50 milliseconds. The drawback of such approach is
> > > > a low utilization of page slot in some scenarios. The page can store
> > > > up to 512 records. For example on Android system it can look like:
> > > 
> > > I was looking at queuing this one, but we need a bit more data.  In
> > > the meantime, here is my wordsmithing of the above paragraph:
> > > 
> > > Currently the monitor work is scheduled with a fixed interval of HZ/20,
> > > which is roughly 50 milliseconds. The drawback of this approach is
> > > low utilization of the 512 page slots in scenarios with infrequence
> > > kvfree_rcu() calls.  For example on an Android system:
> > > 
> > Good i will update with your changes :)
> > 
> > > > <snip>
> > > >   kworker/3:0-13872   [003] .... 11286.007048: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=1
> > > >   kworker/3:0-13872   [003] .... 11286.015638: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> > > >   kworker/1:2-20434   [001] .... 11286.051230: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> > > >   kworker/1:2-20434   [001] .... 11286.059322: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=2
> > > >   kworker/0:1-20052   [000] .... 11286.095295: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=2
> > > >   kworker/0:1-20052   [000] .... 11286.103418: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=1
> > > >   kworker/2:3-14372   [002] .... 11286.135155: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> > > >   kworker/2:3-14372   [002] .... 11286.135198: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> > > >   kworker/1:2-20434   [001] .... 11286.155377: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=5
> > > >   kworker/2:3-14372   [002] .... 11286.167181: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=5
> > > >   kworker/1:2-20434   [001] .... 11286.179202: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000008ef95e14 nr_records=1
> > > >   kworker/2:3-14372   [002] .... 11286.187398: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000c597d297 nr_records=6
> > > >   kworker/3:0-13872   [003] .... 11286.187445: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000050bf92e2 nr_records=3
> > > >   kworker/1:2-20434   [001] .... 11286.198975: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=4
> > > >   kworker/1:2-20434   [001] .... 11286.207203: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=4
> > > > <snip>
> > > > 
> > > > where a page only carries few records to reclaim a memory. In order
> > > > to improve batching and make utilization more efficient the patch sets
> > > > a drain interval to 1 second as default one. When a flood is detected
> > > > an interval is adjusted in a way that a reclaim work is re-scheduled
> > > > on a next timer jiffy.
> > > 
> > > And of the above paragraph:
> > > 
> > > Out of 512 slots, in all cases, fewer than 10 were actually used.
> > > In order to improve batching and make utilization more efficient this
> > > commit sets a drain interval to a fixed 1-second interval. Floods are
> > > detected when a page fills quickly, and in that case, the reclaim work
> > > is re-scheduled for the next scheduling-clock tick (jiffy).
> > > 
> > Same here, will apply this.
> > 
> > > ---
> > > 
> > > But what we need now is a trace like the one above showing higher utilization
> > > of the pages.  Could you please supply this?
> > > 
> > Yep, i will add traces to show that utilization becomes better what is
> > actually expectable.
> > 
> > --
> > Uladzislau Rezki
> Paul, see below the v3:
> 
> >From ff2a402a59442ba575f13f660ee1b140d44483b4 Mon Sep 17 00:00:00 2001
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Date: Wed, 1 Jun 2022 11:28:53 +0200
> Subject: [PATCH v3 1/1] rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
> 
> Currently the monitor work is scheduled with a fixed interval of HZ/20,
> which is roughly 50 milliseconds. The drawback of this approach is
> low utilization of the 512 page slots in scenarios with infrequence
> kvfree_rcu() calls.  For example on an Android system:
> 
> <snip>
>   kworker/3:3-507     [003] ....   470.286305: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000d0f0dde5 nr_records=6
>   kworker/6:1-76      [006] ....   470.416613: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000ea0d6556 nr_records=1
>   kworker/6:1-76      [006] ....   470.416625: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000003e025849 nr_records=9
>   kworker/1:1-73      [001] ....   470.438895: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000091a38dc1 nr_records=1
>   kworker/3:3-507     [003] ....   471.390000: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000815a8713 nr_records=48
>   kworker/1:1-73      [001] ....   471.725785: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000fda9bf20 nr_records=3
>   kworker/1:1-73      [001] ....   471.725833: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000a425b67b nr_records=76
>   kworker/3:3-507     [003] ....   471.958960: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000dce5bdbd nr_records=78
>   kworker/0:4-1411    [000] ....   472.085673: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000007996be9d nr_records=1
>   kworker/0:4-1411    [000] ....   472.085728: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000d0f0dde5 nr_records=5
>   kworker/6:1-76      [006] ....   472.260340: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000065630ee4 nr_records=102
>   kworker/2:1-78      [002] ....   472.527362: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000815a8713 nr_records=1
> <snip>
> 
> Out of 512 slots, in all cases, fewer than 10 were actually used.

Though with the re-run, this now needs to be something like "In many
cases, out of 512 slots, fewer than 10 were actually used."

> In order to improve batching and make utilization more efficient this
> commit sets a drain interval to a fixed 1-second interval. Floods are
> detected when a page fills quickly, and in that case, the reclaim work
> is re-scheduled for the next scheduling-clock tick (jiffy).
> 
> After this change:
> 
> <snip>
>   kworker/0:5-1415    [000] ....   239.852727: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000005d2561ea nr_records=178
>   kworker/3:0-38      [003] ....   239.855113: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000039c44d27 nr_records=93
>   kworker/1:4-1747    [001] ....   239.872647: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000004abb2f7e nr_records=109
>   kworker/4:59-288    [004] ....   239.884829: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000049e7a308 nr_records=182
>   kworker/0:5-1415    [000] ....   240.028762: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000037eae6d6 nr_records=86
>   kworker/3:0-38      [003] ....   240.040769: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000003be0ae55 nr_records=244
>   kworker/3:0-38      [003] ....   240.068639: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000021905efe nr_records=45
>         <...>-1415    [000] ....   240.868830: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000007c97e065 nr_records=461
>         <...>-1415    [000] ....   241.068646: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000000725886e nr_records=25
>   kworker/0:5-1415    [000] ....   241.100931: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000021905efe nr_records=300
>   worker/4:59-2880    [004] ....   241.801181: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000004abb2f7e nr_records=180
>   worker/6:60-2554    [006] ....   242.000565: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000006d3084af nr_records=40
> <snip>

Much better!  Looking forward to the updated patch.

							Thanx, Paul

> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index fd16c0b46d9e..37f89bedf45e 100644
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
> @@ -3510,6 +3510,25 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
>  	return !!krcp->head;
>  }
>  
> +static void
> +schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> +{
> +	long delay, delay_left;
> +
> +	delay = READ_ONCE(krcp->count) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
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
> @@ -3567,7 +3586,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  	// work to repeat an attempt. Because previous batches are
>  	// still in progress.
>  	if (need_offload_krc(krcp))
> -		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +		schedule_delayed_monitor_work(krcp);
>  
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  }
> @@ -3755,7 +3774,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> -		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +		schedule_delayed_monitor_work(krcp);
>  
>  unlock_return:
>  	krc_this_cpu_unlock(krcp, flags);
> @@ -3831,7 +3850,7 @@ void __init kfree_rcu_scheduler_running(void)
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
