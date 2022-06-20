Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3005526E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343799AbiFTWU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiFTWUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EE11B79D;
        Mon, 20 Jun 2022 15:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE96612F5;
        Mon, 20 Jun 2022 22:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD07C385A2;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763634;
        bh=41amnyMn1rIKChCQFUfwJMh9tfKMg6S8/hCqGWL9D8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFGzayjGIscFAUjdwfZ2osfwf3BlM1a3uXsow9v3z/VoGNIUrz3J83Tb1R1wTjfYs
         6xnK9lc7k3Q7tiFZ34avH+fskYxhjU5zqiv7KxPQaDKlWg6mKy3uA/9M694ye49ofd
         9XiED9jwQ0aB1GwQuz3LAd4444j/z3zBqwlbXe310EN5aEhPPISDlzJGMtt6wGh7xf
         EFGA50lOBj/vie5Bl6ZSdnoh1rifsYcA8r30noIF/UELEHUIDwlOCg18fI9AJ40ASP
         hMgFmrwZuN79ZzE4KXE031VYlk7/acOfpZ76kwupsk7aOkxYdZuWWwDwZBGDN5QEeT
         zd5XoB7FpACMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0CCEC5C0D1B; Mon, 20 Jun 2022 15:20:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/12] rcu/kvfree: Remove useless monitor_todo flag
Date:   Mon, 20 Jun 2022 15:20:29 -0700
Message-Id: <20220620222032.3839547-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

monitor_todo is not needed as the work struct already tracks
if work is pending. Just use that to know if work is pending
using schedule_delayed_work() helper.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5445b19b48408..7919d7b48fa6a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3216,7 +3216,6 @@ struct kfree_rcu_cpu_work {
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
- * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
  * @initialized: The @rcu_work fields have been initialized
  * @count: Number of objects for which GP not started
  * @bkvcache:
@@ -3241,7 +3240,6 @@ struct kfree_rcu_cpu {
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
-	bool monitor_todo;
 	bool initialized;
 	int count;
 
@@ -3421,6 +3419,18 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3477,9 +3487,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	// of the channels that is still busy we should rearm the
 	// work to repeat an attempt. Because previous batches are
 	// still in progress.
-	if (!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head)
-		krcp->monitor_todo = false;
-	else
+	if (need_offload_krc(krcp))
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
@@ -3667,11 +3675,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
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
@@ -3746,14 +3751,8 @@ void __init kfree_rcu_scheduler_running(void)
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
2.31.1.189.g2e36527f23

