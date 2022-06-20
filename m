Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521CD552734
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbiFTWy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344311AbiFTWyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7E1186F3;
        Mon, 20 Jun 2022 15:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16B5A6135C;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70502C341C4;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=/TaKYGM1aHXlwsLVMwzJDjkSwops8NdezYFQd3XKrQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLdINv71jmfFO1F2VOnvflvp4VlXQUqQLHzn9aEvgzWoKW0PttSiNeNxPdUXKakc0
         k8b7Xc8AKLDP3jNhUJCWnmmyHX7wjnndrg4jrnkcQ5tbYb/QJbcUn97znfhHCUyaqt
         DRH8FVdrSNZQs4Zj1XovIYluB4RFtc821IeDG9ZySiQw0gJDN3gHAvkYpbuTuseB/I
         sj1MmebocoK377Ny6w3wVNlwDfXIYylM3Nupkw6XcZsiL2lRF7MeSlm73bwHsfUl0K
         lc8S1eGu3acGuxgTDz275nMOK2GBXEkUP+hbAqJ2D9OAC1KlMJT4D7xPzQHA3E36qx
         PNJjn2Q7y0bxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2E8215C0A33; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH rcu 04/32] rcu-tasks: Drive synchronous grace periods from calling task
Date:   Mon, 20 Jun 2022 15:53:43 -0700
Message-Id: <20220620225411.3842519-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
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

This commit causes synchronous grace periods to be driven from the task
invoking synchronize_rcu_*(), allowing these functions to be invoked from
the mid-boot dead zone extending from when the scheduler was initialized
to to point that the various RCU tasks grace-period kthreads are spawned.
This change will allow the self-tests to run in a consistent manner.

Reported-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ad993c4ed924f..bd9f2e24f5c73 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -495,17 +495,21 @@ static void rcu_tasks_invoke_cbs_wq(struct work_struct *wp)
 }
 
 // Wait for one grace period.
-static void rcu_tasks_one_gp(struct rcu_tasks *rtp)
+static void rcu_tasks_one_gp(struct rcu_tasks *rtp, bool midboot)
 {
 	int needgpcb;
 
 	mutex_lock(&rtp->tasks_gp_mutex);
-	set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 
 	// If there were none, wait a bit and start over.
-	rcuwait_wait_event(&rtp->cbs_wait,
-			   (needgpcb = rcu_tasks_need_gpcb(rtp)),
-			   TASK_IDLE);
+	if (unlikely(midboot)) {
+		needgpcb = 0x2;
+	} else {
+		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
+		rcuwait_wait_event(&rtp->cbs_wait,
+				   (needgpcb = rcu_tasks_need_gpcb(rtp)),
+				   TASK_IDLE);
+	}
 
 	if (needgpcb & 0x2) {
 		// Wait for one grace period.
@@ -540,7 +544,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	for (;;) {
 		// Wait for one grace period and invoke any callbacks
 		// that are ready.
-		rcu_tasks_one_gp(rtp);
+		rcu_tasks_one_gp(rtp, false);
 
 		// Paranoid sleep to keep this from entering a tight loop.
 		schedule_timeout_idle(rtp->gp_sleep);
@@ -554,8 +558,12 @@ static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 	RCU_LOCKDEP_WARN(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
 			 "synchronize_rcu_tasks called too soon");
 
-	/* Wait for the grace period. */
-	wait_rcu_gp(rtp->call_func);
+	// If the grace-period kthread is running, use it.
+	if (READ_ONCE(rtp->kthread_ptr)) {
+		wait_rcu_gp(rtp->call_func);
+		return;
+	}
+	rcu_tasks_one_gp(rtp, true);
 }
 
 /* Spawn RCU-tasks grace-period kthread. */
-- 
2.31.1.189.g2e36527f23

