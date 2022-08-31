Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF365A851E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiHaSLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiHaSK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:10:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120971EACB;
        Wed, 31 Aug 2022 11:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80265B82274;
        Wed, 31 Aug 2022 18:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4630EC433C1;
        Wed, 31 Aug 2022 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969363;
        bh=gYye8cztVvf5q0SrvDpPmm9vHD/4KC8Vluo/kUFEdSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVFROl2UCqgbvgrItfItWT6+BhZ7AGvu+cQEZqlY6yfPI8k6tJunzLjMFOO+bfax+
         rgTgdn5eXU4lng9ZP0cKq3yG0h+qJqDftPjOhixCDi9bWPRbGpEj71qOueVa1V7GtP
         jqugCTjD4Vh4Fteozl8sDqqrpoPsNAewTxZUZX215lt2Qsd/MAz/zzI1gB+jD9797a
         LFgVsX1Pwe7qixLw9gRO7M1H4yjUK2ChNh2EG5QpoOj8nRB6I3/ikvLqS5uA9CNK7i
         2dRDJ0evwqEJiN13ewkuAE6WxO6j8I+6hL9/L4lz1mRCBJHD0LLWyn+nbbuR7gIaDb
         +Birq9x4oLTrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 04DBB5C02A9; Wed, 31 Aug 2022 11:09:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/3] rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
Date:   Wed, 31 Aug 2022 11:09:21 -0700
Message-Id: <20220831180921.2694017-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180916.GA2693797@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180916.GA2693797@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

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
---
 kernel/rcu/tree.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3d234d536d4c3..7b90478b752e8 100644
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
-- 
2.31.1.189.g2e36527f23

