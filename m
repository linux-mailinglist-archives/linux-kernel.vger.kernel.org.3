Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F2A53B4C3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiFBIHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiFBIHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:07:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB6925597;
        Thu,  2 Jun 2022 01:06:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u23so6616583lfc.1;
        Thu, 02 Jun 2022 01:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQR0VZQWx9rUUOFT+ceJ/O2+n+5GoQSyy+hZt4SkVTc=;
        b=MtRhs/YpauIsWpFSqxt+iOJ5Jt0QzqyhvdeNZ12Mcrdzh84lFNLBxDxA/izAAEZ4K4
         fEtRaSIPaDmn8K/F6gZfrWVYUcKo70ro3pKpMYyv4f2kffFjmJRWwXxZ3mthG+E9g3f8
         9F6F0SI2ZGGebbMfUhYcS7lmHwUM5Zf9WBocYZPqr7XlPEtnoW3sVP6CLLODincUlggr
         IUXGnqQsAMYaLopWU4AvAegsXVz96yk3DOSNi6bhGtyFyh0JijIwvFJOPGlcwEpQU95K
         o9+eK37oXX5fzufGzhu0benNf3wRtq4Zyle1gGhqM1CGBtI2MxI8Jc+o2qcsLyZVpaws
         N9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQR0VZQWx9rUUOFT+ceJ/O2+n+5GoQSyy+hZt4SkVTc=;
        b=UhGHXuDFjUeeNILwYAjT3PhhXrO0WJ0xwUBLzu9MudEqCzpt30K6jKzoJipwLsgoUb
         S1UhyVBVco8c1erz96s8UytrWJrC7smhWW1L5pdhtc5SqTpfZ4IOnDbAon53LwcZox2k
         MswjuKwN4S1q8mtEarSOFkrZ/xDSBtDWqdnRkizvmT0JKUdJO5txZtleWO8ePPRe/tWv
         LkaEKClHd2LWS5lasWrNfwFmkU61ohPn/vO78O5Fd7lPFM/or2PL5Tem3yuUTQU046+v
         /4CkvefXwo2+RiTGFltDY9OBoKrSemK/O6+unMEJ3A+qjdMlhuUySiPPZ1t4ZVoHpPly
         qtZg==
X-Gm-Message-State: AOAM531Gccf8PCln/QmQWFT74EdQjBp+QVJgDKQTOYNe/+i5LZpF8k2R
        CLG34qpUE47UrrAXTLYwDJbmzi2W3OiAqA==
X-Google-Smtp-Source: ABdhPJw4sqEks1k7ycbRFRrvOoRe7bPly2W9kWMwQFcNDrihn7LIaq9EMnGDgN8UpnqmM0Ie04kEow==
X-Received: by 2002:a19:4915:0:b0:479:813:65d3 with SMTP id w21-20020a194915000000b00479081365d3mr2725561lfa.25.1654157216054;
        Thu, 02 Jun 2022 01:06:56 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id bx11-20020a05651c198b00b002556bce7e76sm700458ljb.65.2022.06.02.01.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 01:06:55 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 2/2] rcu/kvfree: Introduce KFREE_DRAIN_JIFFIES_[MAX/MIN] interval
Date:   Thu,  2 Jun 2022 10:06:44 +0200
Message-Id: <20220602080644.432156-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602080644.432156-1-urezki@gmail.com>
References: <20220602080644.432156-1-urezki@gmail.com>
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

where a page only carries few records to reclaim a memory. In order to
improve batching and make utilization more efficient the patch introduces
a drain interval that can be set either to KFREE_DRAIN_JIFFIES_MAX or
KFREE_DRAIN_JIFFIES_MIN. It is adjusted if a flood is detected, in this
case a memory reclaim occurs more often whereas in mostly idle cases the
interval is set to its maximum timeout that improves the utilization of
page slots.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fd16c0b46d9e..c02a64995b85 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3249,7 +3249,8 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
 
 /* Maximum number of jiffies to wait before draining a batch. */
-#define KFREE_DRAIN_JIFFIES (HZ / 50)
+#define KFREE_DRAIN_JIFFIES_MAX (HZ)
+#define KFREE_DRAIN_JIFFIES_MIN (HZ / 50)
 #define KFREE_N_BATCHES 2
 #define FREE_N_CHANNELS 2
 
@@ -3510,6 +3511,26 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 	return !!krcp->head;
 }
 
+static void
+schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
+{
+	long delay, delay_left;
+
+	delay = READ_ONCE(krcp->count) >= KVFREE_BULK_MAX_ENTR ?
+		KFREE_DRAIN_JIFFIES_MIN:KFREE_DRAIN_JIFFIES_MAX;
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
@@ -3567,7 +3588,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	// work to repeat an attempt. Because previous batches are
 	// still in progress.
 	if (need_offload_krc(krcp))
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+		schedule_delayed_monitor_work(krcp);
 
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
@@ -3755,7 +3776,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+		schedule_delayed_monitor_work(krcp);
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
@@ -3831,7 +3852,7 @@ void __init kfree_rcu_scheduler_running(void)
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (need_offload_krc(krcp))
-			schedule_delayed_work_on(cpu, &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+			schedule_delayed_monitor_work(krcp);
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 }
-- 
2.30.2

