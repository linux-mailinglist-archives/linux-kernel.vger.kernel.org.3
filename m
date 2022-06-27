Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB555D6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbiF0TyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbiF0Tx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:53:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1D419C06;
        Mon, 27 Jun 2022 12:53:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a39so11116876ljq.11;
        Mon, 27 Jun 2022 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GISRLXmQNkrShCICwknhBotRpu2A+UkG2L0nlRZ0p3k=;
        b=ZbgC3ouD3LER2MyBctJ/9W1rSV7+oocIp6E1BzOFABaBkKbCh/TYu0F7hG4/VIMc3B
         dBcf09h/liqs+S9wje6t5C8u+RnFG1nfL+7pJAnLK9nsgHxbl6x2prhLDi7NQ7i/0PvN
         gN7ySWJ7METUVb9Go66mIwobURNEl6UH4+0tGLvWOW6HOMbQrxdUMGME79u2QSVbUyEN
         oVMDtA+ntTAEs/wXkZOzL6kdRbEojQEl6qGpsoZUL7x30VzXSJAZCnf0DdNiyWsrCjbF
         85XAbHHOb6+MgrnKMS01Ueyy7+UarMcWpdJ2BNS4UIlcRaH8p7NisVCgmii+Yc4hrAMb
         rLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GISRLXmQNkrShCICwknhBotRpu2A+UkG2L0nlRZ0p3k=;
        b=3qYrHVg6K0f9HFHy3wklnUkj3pLjZRwlQNTtbjB6UIkmCw9mzv+tszUN1ju/McfhpC
         YHUwqwYrQdKAIUKLH2iRY2psuSbyfN6w42TGsf3aPcCPdpV14tKXtrnuVOu+RshOI0cD
         FSFlmQqLzXgTs6m4BAglvYTccasVXMp+94cgvjiLedm7rwYB3fPyHSOoOETtX0pDZ7aR
         H27pdkE0kp1KtA/Qlwl6vfGiy9lmzdXwJCR3xLaFc9fcyixh4tk2i7tFK7YOIFyh0tLx
         aicI5diPt2pFcoMfaSJOa0XA+o//bA4RyNkFnxgTHBQ0vbgT0rY5wKxmyPCV2Uq3VVbk
         RAZA==
X-Gm-Message-State: AJIora+xaODwvDN6fQAqK/0aj3RTGtf9Q5aMu0Iqpp6/6RvtypfwFMCg
        06Vajtgho8ehozwBxqpOXmjdu+nqEl5HRmzn
X-Google-Smtp-Source: AGRyM1uUQ1j3RjQw0sU4O/h72O63rqBfOz6UOvkx+nJOcTO3jwgcJdDjMBhBtxQlBnj4DRAmiQCQQA==
X-Received: by 2002:a2e:22c6:0:b0:25a:8c16:baf with SMTP id i189-20020a2e22c6000000b0025a8c160bafmr7858179lji.132.1656359635887;
        Mon, 27 Jun 2022 12:53:55 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id a9-20020a19ca09000000b00477a6c86f17sm1920038lfg.8.2022.06.27.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:53:55 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 1/1] rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
Date:   Mon, 27 Jun 2022 21:53:53 +0200
Message-Id: <20220627195353.1575285-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the monitor work is scheduled with a fixed interval that
is HZ/20 or each 50 milliseconds. The drawback of such approach is
a low utilization of page slot in some scenarios. The page can store
up to 512 records. For example on Android system it can look like:

<snip>
  kworker/3:0-13872   [003] .... 11286.007048: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=1
  kworker/3:0-13872   [003] .... 11286.015638: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
  kworker/1:2-20434   [001] .... 11286.051230: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
  kworker/1:2-20434   [001] .... 11286.059322: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=2
  kworker/0:1-20052   [000] .... 11286.095295: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=2
  kworker/0:1-20052   [000] .... 11286.103418: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=1
  kworker/2:3-14372   [002] .... 11286.135155: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
  kworker/2:3-14372   [002] .... 11286.135198: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
  kworker/1:2-20434   [001] .... 11286.155377: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=5
  kworker/2:3-14372   [002] .... 11286.167181: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=5
  kworker/1:2-20434   [001] .... 11286.179202: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000008ef95e14 nr_records=1
  kworker/2:3-14372   [002] .... 11286.187398: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000c597d297 nr_records=6
  kworker/3:0-13872   [003] .... 11286.187445: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000050bf92e2 nr_records=3
  kworker/1:2-20434   [001] .... 11286.198975: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=4
  kworker/1:2-20434   [001] .... 11286.207203: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=4
<snip>

where a page only carries few records to reclaim a memory. In order
to improve batching and make utilization more efficient the patch sets
a drain interval to 1 second as default one. When a flood is detected
an interval is adjusted in a way that a reclaim work is re-scheduled
on a next timer jiffy.

- default -
Total time taken by all kfree'ers: 11510245312 ns, loops: 10000, batches: 1553, memory footprint: 70MB
Total time taken by all kfree'ers: 9813329636  ns, loops: 10000, batches: 1544, memory footprint: 67MB
Total time taken by all kfree'ers: 10085206318 ns, loops: 10000, batches: 1499, memory footprint: 156MB
Total time taken by all kfree'ers: 9582207782  ns, loops: 10000, batches: 1456, memory footprint: 103MB
Total time taken by all kfree'ers: 9872195750  ns, loops: 10000, batches: 1519, memory footprint: 105MB
Total time taken by all kfree'ers: 9574438300  ns, loops: 10000, batches: 1480, memory footprint: 101MB
Total time taken by all kfree'ers: 9990015265  ns, loops: 10000, batches: 1489, memory footprint: 127MB
Total time taken by all kfree'ers: 9978971689  ns, loops: 10000, batches: 1455, memory footprint: 94MB
Total time taken by all kfree'ers: 10357628090 ns, loops: 10000, batches: 1456, memory footprint: 64MB
Total time taken by all kfree'ers: 9838469975  ns, loops: 10000, batches: 1448, memory footprint: 131MB

- patch -
Total time taken by all kfree'ers: 8488575321  ns, loops: 10000, batches: 1735, memory footprint: 82MB
Total time taken by all kfree'ers: 9256401034  ns, loops: 10000, batches: 1762, memory footprint: 76MB
Total time taken by all kfree'ers: 9198011994  ns, loops: 10000, batches: 1751, memory footprint: 82MB
Total time taken by all kfree'ers: 10590540622 ns, loops: 10000, batches: 1540, memory footprint: 94MB
Total time taken by all kfree'ers: 9953902918  ns, loops: 10000, batches: 1638, memory footprint: 89MB
Total time taken by all kfree'ers: 10176669464 ns, loops: 10000, batches: 1613, memory footprint: 84MB
Total time taken by all kfree'ers: 9387490978  ns, loops: 10000, batches: 1762, memory footprint: 85MB
Total time taken by all kfree'ers: 9530535341  ns, loops: 10000, batches: 1781, memory footprint: 66MB
Total time taken by all kfree'ers: 9945442340  ns, loops: 10000, batches: 1758, memory footprint: 68MB
Total time taken by all kfree'ers: 9188848287  ns, loops: 10000, batches: 1781, memory footprint: 67MB

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fd16c0b46d9e..c11670ba008e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3249,7 +3249,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
 
 /* Maximum number of jiffies to wait before draining a batch. */
-#define KFREE_DRAIN_JIFFIES (HZ / 50)
+#define KFREE_DRAIN_JIFFIES (HZ)
 #define KFREE_N_BATCHES 2
 #define FREE_N_CHANNELS 2
 
@@ -3510,6 +3510,26 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 	return !!krcp->head;
 }
 
+static void
+schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
+{
+	long delay, delay_left;
+
+	delay = READ_ONCE(krcp->count) >= KVFREE_BULK_MAX_ENTR ?
+		1:KFREE_DRAIN_JIFFIES;
+
+	if (delayed_work_pending(&krcp->monitor_work)) {
+		delay_left = krcp->monitor_work.timer.expires - jiffies;
+
+		if (delay < delay_left)
+			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
+
+		return;
+	}
+
+	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
+}
+
 /*
  * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
  */
@@ -3567,7 +3587,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	// work to repeat an attempt. Because previous batches are
 	// still in progress.
 	if (need_offload_krc(krcp))
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+		schedule_delayed_monitor_work(krcp);
 
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
@@ -3755,7 +3775,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+		schedule_delayed_monitor_work(krcp);
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
@@ -3831,7 +3851,7 @@ void __init kfree_rcu_scheduler_running(void)
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (need_offload_krc(krcp))
-			schedule_delayed_work_on(cpu, &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+			schedule_delayed_monitor_work(krcp);
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 }
-- 
2.30.2

