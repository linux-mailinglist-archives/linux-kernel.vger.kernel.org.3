Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FA2562781
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 02:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiGAAAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 20:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiGAAAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 20:00:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F65A44C;
        Thu, 30 Jun 2022 17:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C05CB82CF4;
        Fri,  1 Jul 2022 00:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330A0C34115;
        Fri,  1 Jul 2022 00:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656633628;
        bh=Q2VHf7zWve/a5VDjxJCgfQ6aoS1R1ecy+y7cD7B68MA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XJbMEnw6hBpc5jFrXmaOcVYIqSNtk1kkj+q+bndIhB7JC+R8K7Pcc3eYpOvSIUATU
         A+05PTWaC+pYrHZB4EfuUrm8tJ4UwPWDoc0i5YCffzy0S640cXkB9oI5c914v4iyWh
         UeHXdE8ztOZfo1jVmaqBYIqPlmsHNNSRafynRXsFUlnDSz/VCE9D/u9ApDnrMlqpZW
         EWnaRgB+98HD9SxsAavPCAOgaA/9ZG9qyBqu7l3NatUvmrnFJuM9VfUCh8WvswqXBx
         VGGU5AfqhXWqzj01P20TIo5Jg/Ufcw0nu84XrA7m+dgD+aLwHIgsCrxSzYIbzQm8xz
         u4DxYa2XtRVdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C0D5B5C03AE; Thu, 30 Jun 2022 17:00:27 -0700 (PDT)
Date:   Thu, 30 Jun 2022 17:00:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 1/1] rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
Message-ID: <20220701000027.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220630163335.3670-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630163335.3670-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 06:33:35PM +0200, Uladzislau Rezki (Sony) wrote:
> Currently the monitor work is scheduled with a fixed interval of HZ/20,
> which is roughly 50 milliseconds. The drawback of this approach is
> low utilization of the 512 page slots in scenarios with infrequence
> kvfree_rcu() calls.  For example on an Android system:
> 
> <snip>
>   kworker/3:3-507     [003] ....   470.286305: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000d0f0dde5 nr_records=6
>   kworker/6:1-76      [006] ....   470.416613: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000ea0d6556 nr_records=1
>   kworker/6:1-76      [006] ....   470.416625: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000003e025849 nr_records=9
>   kworker/3:3-507     [003] ....   471.390000: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000815a8713 nr_records=48
>   kworker/1:1-73      [001] ....   471.725785: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000fda9bf20 nr_records=3
>   kworker/1:1-73      [001] ....   471.725833: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000a425b67b nr_records=76
>   kworker/0:4-1411    [000] ....   472.085673: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000007996be9d nr_records=1
>   kworker/0:4-1411    [000] ....   472.085728: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000d0f0dde5 nr_records=5
>   kworker/6:1-76      [006] ....   472.260340: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000065630ee4 nr_records=102
> <snip>
> 
> in many cases, out of 512 slots, fewer than 10 were actually used.
> In order to improve batching and make utilization more efficient this
> commit sets a drain interval to a fixed 5-seconds interval. Floods are
> detected when a page fills quickly, and in that case, the reclaim work
> is re-scheduled for the next scheduling-clock tick (jiffy).
> 
> After this change:
> 
> <snip>
>   kworker/7:1-371     [007] ....  5630.725708: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000005ab0ffb3 nr_records=121
>   kworker/7:1-371     [007] ....  5630.989702: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000060c84761 nr_records=47
>   kworker/7:1-371     [007] ....  5630.989714: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000000babf308 nr_records=510
>   kworker/7:1-371     [007] ....  5631.553790: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000bb7bd0ef nr_records=169
>   kworker/7:1-371     [007] ....  5631.553808: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044c78753 nr_records=510
>   kworker/5:6-9428    [005] ....  5631.746102: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000d98519aa nr_records=123
>   kworker/4:7-9434    [004] ....  5632.001758: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000526c9d44 nr_records=322
>   kworker/4:7-9434    [004] ....  5632.002073: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000002c6a8afa nr_records=185
>   kworker/7:1-371     [007] ....  5632.277515: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000007f4a962f nr_records=510
> <snip>
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Very good!  As usual, I did a bit of wordsmithing, so please let
me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 57720248bb6152ea37348bc04a7f73940e4b5efe
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Thu Jun 30 18:33:35 2022 +0200

    rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
    
    Currently the monitor work is scheduled with a fixed interval of HZ/20,
    which is roughly 50 milliseconds. The drawback of this approach is
    low utilization of the 512 page slots in scenarios with infrequence
    kvfree_rcu() calls.  For example on an Android system:
    
    <snip>
      kworker/3:3-507     [003] ....   470.286305: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000d0f0dde5 nr_records=6
      kworker/6:1-76      [006] ....   470.416613: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000ea0d6556 nr_records=1
      kworker/6:1-76      [006] ....   470.416625: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000003e025849 nr_records=9
      kworker/3:3-507     [003] ....   471.390000: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000815a8713 nr_records=48
      kworker/1:1-73      [001] ....   471.725785: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000fda9bf20 nr_records=3
      kworker/1:1-73      [001] ....   471.725833: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000a425b67b nr_records=76
      kworker/0:4-1411    [000] ....   472.085673: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000007996be9d nr_records=1
      kworker/0:4-1411    [000] ....   472.085728: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000d0f0dde5 nr_records=5
      kworker/6:1-76      [006] ....   472.260340: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000065630ee4 nr_records=102
    <snip>
    
    In many cases, out of 512 slots, fewer than 10 were actually used.
    In order to improve batching and make utilization more efficient this
    commit sets a drain interval to a fixed 5-seconds interval. Floods are
    detected when a page fills quickly, and in that case, the reclaim work
    is re-scheduled for the next scheduling-clock tick (jiffy).
    
    After this change:
    
    <snip>
      kworker/7:1-371     [007] ....  5630.725708: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000005ab0ffb3 nr_records=121
      kworker/7:1-371     [007] ....  5630.989702: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000060c84761 nr_records=47
      kworker/7:1-371     [007] ....  5630.989714: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000000babf308 nr_records=510
      kworker/7:1-371     [007] ....  5631.553790: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000bb7bd0ef nr_records=169
      kworker/7:1-371     [007] ....  5631.553808: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044c78753 nr_records=510
      kworker/5:6-9428    [005] ....  5631.746102: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000d98519aa nr_records=123
      kworker/4:7-9434    [004] ....  5632.001758: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000526c9d44 nr_records=322
      kworker/4:7-9434    [004] ....  5632.002073: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000002c6a8afa nr_records=185
      kworker/7:1-371     [007] ....  5632.277515: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000007f4a962f nr_records=510
    <snip>
    
    Here, all but one of the cases, more than one hundreds slots were used,
    representing an order-of-magnitude improvement.
    
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b2c499f89e9ff..84d2817766888 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2832,7 +2832,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
 
 /* Maximum number of jiffies to wait before draining a batch. */
-#define KFREE_DRAIN_JIFFIES (HZ / 50)
+#define KFREE_DRAIN_JIFFIES (5 * HZ)
 #define KFREE_N_BATCHES 2
 #define FREE_N_CHANNELS 2
 
@@ -3093,6 +3093,21 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 	return !!krcp->head;
 }
 
+static void
+schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
+{
+	long delay, delay_left;
+
+	delay = READ_ONCE(krcp->count) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
+	if (delayed_work_pending(&krcp->monitor_work)) {
+		delay_left = krcp->monitor_work.timer.expires - jiffies;
+		if (delay < delay_left)
+			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
+		return;
+	}
+	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
+}
+
 /*
  * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
  */
@@ -3150,7 +3165,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	// work to repeat an attempt. Because previous batches are
 	// still in progress.
 	if (need_offload_krc(krcp))
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+		schedule_delayed_monitor_work(krcp);
 
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
@@ -3339,7 +3354,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+		schedule_delayed_monitor_work(krcp);
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
@@ -3415,7 +3430,7 @@ void __init kfree_rcu_scheduler_running(void)
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (need_offload_krc(krcp))
-			schedule_delayed_work_on(cpu, &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+			schedule_delayed_monitor_work(krcp);
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 }
