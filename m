Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4414053B4C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiFBIHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiFBIHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:07:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F9321E3E;
        Thu,  2 Jun 2022 01:06:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u26so5878741lfd.8;
        Thu, 02 Jun 2022 01:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBiEytnqVV6KZEHfiDm2RTGAdJaYp3vV0HNg/DjF4eM=;
        b=UCQ5LM1GgV3j5AdbzjajAjaFr+4rQT2nThVsU9pOjCy5eIJ5KWJGFrZONwKPTujZvb
         8QJiB0bw1GQme6bX3wWCUoNJcnCWXUivtvXW7AfcbMmZNzDcOBEukXdXrvq4NS+zjBnG
         R2TUr17IM5R+OiCT0y8mAmD/0VOu6JEMVdNZFqzSjGTmbUJXBSVil8p5sDEp85os97ZE
         qxjm3nHyAiAUaxoSN1BqBkQ7imk+CphV88evutT445bW3ITR3wtlzCK14DFKMUkxgc7B
         BI87u4XfWWouzlWDcQ4LzStjEbxQgk3SXJp1IGtENbk/14SWxr2tAXTqp+NzICQWr8Hp
         hBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBiEytnqVV6KZEHfiDm2RTGAdJaYp3vV0HNg/DjF4eM=;
        b=gS8cgu3Lu6EfNLlxLBt5BD7NlgTp5ee0erU+hCHMKwqJL/taqEL6f84yGfsYqbf64l
         FNkwIUPlU6CdXonFy38kbCJ0oSHsNw9GY4TbLcnv5q8ttOuQcX93q7+bOP4rpfsRpWT3
         8zmnwi8/96aX8ec5PWDpmjUemI5kNzDELQEsGkE0YuZdlAoPhCUGsagiCXtBKHlW4XXd
         mMO0kRLMo1gVUdgtr6m9ImC8rK8cFLArg4nlogb//JU08ieDjQXzwjiJyhNJdZqyhaVe
         YQu68UvOQH7SWyQmeta84bltGwysfGaVBYVn2Zk8Pro7x7r8OenJRK9n61qB/avXxbd2
         HZtg==
X-Gm-Message-State: AOAM530k0xOfdpaSzV6+wjuy3Ql0KgNRle2Rd5qzJLymejLzpzfhOxkT
        M8Rk1+pt+A97/NAcz6Ql/NGJlWBvoebnEQ==
X-Google-Smtp-Source: ABdhPJxS5HgtaA+QdncMQxQRsVb46/FKHRaBXh2QWiIvoD5V+8qKNfS1ZrcHBIiYHrRMzucu098E8w==
X-Received: by 2002:ac2:4f03:0:b0:443:5d9d:819d with SMTP id k3-20020ac24f03000000b004435d9d819dmr2654919lfr.165.1654157214838;
        Thu, 02 Jun 2022 01:06:54 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id bx11-20020a05651c198b00b002556bce7e76sm700458ljb.65.2022.06.02.01.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 01:06:54 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/2] rcu/kvfree: Remove useless monitor_todo flag
Date:   Thu,  2 Jun 2022 10:06:43 +0200
Message-Id: <20220602080644.432156-1-urezki@gmail.com>
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

monitor_todo is not needed as the work struct already tracks
if work is pending. Just use that to know if work is pending
using schedule_delayed_work() helper.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 222d59299a2a..fd16c0b46d9e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3295,7 +3295,6 @@ struct kfree_rcu_cpu_work {
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
- * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
  * @initialized: The @rcu_work fields have been initialized
  * @count: Number of objects for which GP not started
  * @bkvcache:
@@ -3320,7 +3319,6 @@ struct kfree_rcu_cpu {
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
-	bool monitor_todo;
 	bool initialized;
 	int count;
 
@@ -3500,6 +3498,18 @@ static void kfree_rcu_work(struct work_struct *work)
 	}
 }
 
+static bool
+need_offload_krc(struct kfree_rcu_cpu *krcp)
+{
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		if (krcp->bkvhead[i])
+			return true;
+
+	return !!krcp->head;
+}
+
 /*
  * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
  */
@@ -3556,9 +3566,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	// of the channels that is still busy we should rearm the
 	// work to repeat an attempt. Because previous batches are
 	// still in progress.
-	if (!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head)
-		krcp->monitor_todo = false;
-	else
+	if (need_offload_krc(krcp))
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
@@ -3746,11 +3754,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	WRITE_ONCE(krcp->count, krcp->count + 1);
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
-	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
-	    !krcp->monitor_todo) {
-		krcp->monitor_todo = true;
+	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
-	}
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
@@ -3825,14 +3830,8 @@ void __init kfree_rcu_scheduler_running(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
-		if ((!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head) ||
-				krcp->monitor_todo) {
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
-			continue;
-		}
-		krcp->monitor_todo = true;
-		schedule_delayed_work_on(cpu, &krcp->monitor_work,
-					 KFREE_DRAIN_JIFFIES);
+		if (need_offload_krc(krcp))
+			schedule_delayed_work_on(cpu, &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 }
-- 
2.30.2

