Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89D9562053
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiF3Qdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiF3Qdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:33:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250753AA55;
        Thu, 30 Jun 2022 09:33:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j21so34726942lfe.1;
        Thu, 30 Jun 2022 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYu3wnU4VMLFIgoHCbBAkP3VZMsuvdsMzpnLVjK/d0s=;
        b=GTBdcnWdOb3tbjwANa5tSyYVmT05/n+yOxJ86cMBR398q6W3YidHbxHKNr0A9AxI43
         FgeyjwwYqfeTce01bE0JHt6g69xzudhbqu2rwYdkufJa+DgWvFnJcCgkvurOFSXTHjCf
         F8/3mHrXIAjJDW6F9gBJCk3kgDIIKqAzYn0gL0PL8pfeedgtwu7veqM9IFVwDEJM6D7C
         PcQjUdICCOMfLrf17GkzH03uKKUe1LCN9hAlzzbskk0iHnxVaoPWp4UdBDito166UTAC
         TsTunBHKoTFcK9EEwwCOqAYOQ8jFJi7jG5DxglgOhqhZj/3Rnq8SS/jTi3Dv4DdHeqC+
         dsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYu3wnU4VMLFIgoHCbBAkP3VZMsuvdsMzpnLVjK/d0s=;
        b=KAaZK+15IJDXdAbMsj67jkMYppDEg9Y2ajQJcX9e9x6l2ofQ8URjilk1s+un+zYs4s
         Dtpl47W7ZS+7d/1OX3jAO6BM2WbPY3XGH43rGQteLqqKfXFFB488Yc+HnlqJPJiUK21/
         yoZLP4NtVSN2abLcAYNkLFgrEAPFXSb3UvoiyTdYXDOq4EuC6VW91V+6FlINBgB45aZ0
         Gt8COmZm32qNPW0N2AeNF7VrgPRLf05wk6wcsbc8ZxMX3rqj5XglYsLnSNViag3FGcgP
         r/M4/t5DZAYwLwHeYD2F8ufRhm0rrdMTO9dqefRQLNp6+tS80mHS72KSKHv9ziRlhNlf
         3i0w==
X-Gm-Message-State: AJIora+pR2DB4h2jsmFq+Ak70M80eWX7mIx51zg0gBT19TarKVjwOM/K
        Q3qJBLvU2Wfy6fn3KN8GlmqfCcrI5AD9BA==
X-Google-Smtp-Source: AGRyM1stLGr0cokXrCdM57VzEU/jSYUbbqPGUEnZSUYNuTODANVs6ZyJdRbwj43qs7K0Ec/1t7ewfw==
X-Received: by 2002:a05:6512:33ca:b0:47f:acc5:6c8b with SMTP id d10-20020a05651233ca00b0047facc56c8bmr6755919lfg.612.1656606818283;
        Thu, 30 Jun 2022 09:33:38 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id j14-20020a2e850e000000b0025a6e20abe9sm2728720lji.130.2022.06.30.09.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 09:33:37 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v4 1/1] rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
Date:   Thu, 30 Jun 2022 18:33:35 +0200
Message-Id: <20220630163335.3670-1-urezki@gmail.com>
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

in many cases, out of 512 slots, fewer than 10 were actually used.
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

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fd16c0b46d9e..a1b0a5736916 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3249,7 +3249,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
 
 /* Maximum number of jiffies to wait before draining a batch. */
-#define KFREE_DRAIN_JIFFIES (HZ / 50)
+#define KFREE_DRAIN_JIFFIES (5 * HZ)
 #define KFREE_N_BATCHES 2
 #define FREE_N_CHANNELS 2
 
@@ -3510,6 +3510,25 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 	return !!krcp->head;
 }
 
+static void
+schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
+{
+	long delay, delay_left;
+
+	delay = READ_ONCE(krcp->count) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
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
@@ -3567,7 +3586,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	// work to repeat an attempt. Because previous batches are
 	// still in progress.
 	if (need_offload_krc(krcp))
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+		schedule_delayed_monitor_work(krcp);
 
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
@@ -3755,7 +3774,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+		schedule_delayed_monitor_work(krcp);
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
@@ -3831,7 +3850,7 @@ void __init kfree_rcu_scheduler_running(void)
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (need_offload_krc(krcp))
-			schedule_delayed_work_on(cpu, &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+			schedule_delayed_monitor_work(krcp);
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 }
-- 
2.30.2

