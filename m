Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD3A5AB789
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiIBR2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbiIBR2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:28:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D240D346B;
        Fri,  2 Sep 2022 10:28:32 -0700 (PDT)
Date:   Fri, 02 Sep 2022 17:28:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662139710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgRoNYONY177gv/d1dFqiMdDLkHqPWmXgx++I7ksaVI=;
        b=a54CLRW3eFQr8Mmbg7xRkGDr0TfSmmb5t0TQbAruEubgSWJfVBUOC5ZXmDx4fM/IXytV4x
        Vu9gEt7mpKQzQ0bdya5hr8LhJrZ0mLGMDkn34eUE58SOuMSR4ccDRm/l2gv2UliuI9515I
        VnKsUToFnu228NkjnoRmCwT3OvbhHovwbzEVvH7pvwjEXTOp6deND5bwxNBGtYO/H7J6J5
        eeq5hWiPd6zZJ2gE+3K2HBWawZTo+WEg4bf0YDZ7ghV/onKpWJ9MnHXf8i98mShwx9WXIZ
        et5ERqwYKre+cFKfZJyxWDMbfJXNHKup8Ol80WR5k8P/Ne02HIZS8yX9LMdPFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662139710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgRoNYONY177gv/d1dFqiMdDLkHqPWmXgx++I7ksaVI=;
        b=4k7iOzmIz6u7FuzrjgLFW/xQGr6muoOSSIJj7vsCeuHpoTTovNrUAj8sKxTWaQ1Z24TeXR
        o85xfmdg49A6rNAA==
From:   "tip-bot2 for Shang XiaoJing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Add replenish_dl_new_period helper
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220826100037.12146-1-shangxiaojing@huawei.com>
References: <20220826100037.12146-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Message-ID: <166213970919.401.16005611865289043769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     96458e7f7dc5ad14bd7577cbf1638e1504ad79dd
Gitweb:        https://git.kernel.org/tip/96458e7f7dc5ad14bd7577cbf1638e1504ad79dd
Author:        Shang XiaoJing <shangxiaojing@huawei.com>
AuthorDate:    Fri, 26 Aug 2022 18:00:37 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 01 Sep 2022 11:19:54 +02:00

sched/deadline: Add replenish_dl_new_period helper

Wrap repeated code in helper function replenish_dl_new_period, which set
the deadline and runtime of input dl_se based on pi_of(dl_se). Note that
setup_new_dl_entity originally set the deadline and runtime base on
dl_se, which should equals to pi_of(dl_se) for non-boosted task.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Link: https://lore.kernel.org/r/20220826100037.12146-1-shangxiaojing@huawei.com
---
 kernel/sched/deadline.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 34271af..3bf4b12 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -770,6 +770,14 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags);
 static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags);
 static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p, int flags);
 
+static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
+					    struct rq *rq)
+{
+	/* for non-boosted task, pi_of(dl_se) == dl_se */
+	dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+	dl_se->runtime = pi_of(dl_se)->dl_runtime;
+}
+
 /*
  * We are being explicitly informed that a new instance is starting,
  * and this means that:
@@ -803,8 +811,7 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 	 * future; in fact, we must consider execution overheads (time
 	 * spent on hardirq context, etc.).
 	 */
-	dl_se->deadline = rq_clock(rq) + dl_se->dl_deadline;
-	dl_se->runtime = dl_se->dl_runtime;
+	replenish_dl_new_period(dl_se, rq);
 }
 
 /*
@@ -836,10 +843,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 * This could be the case for a !-dl task that is boosted.
 	 * Just go with full inherited parameters.
 	 */
-	if (dl_se->dl_deadline == 0) {
-		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
-		dl_se->runtime = pi_of(dl_se)->dl_runtime;
-	}
+	if (dl_se->dl_deadline == 0)
+		replenish_dl_new_period(dl_se, rq);
 
 	if (dl_se->dl_yielded && dl_se->runtime > 0)
 		dl_se->runtime = 0;
@@ -866,8 +871,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 */
 	if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
 		printk_deferred_once("sched: DL replenish lagged too much\n");
-		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
-		dl_se->runtime = pi_of(dl_se)->dl_runtime;
+		replenish_dl_new_period(dl_se, rq);
 	}
 
 	if (dl_se->dl_yielded)
@@ -1024,8 +1028,7 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 			return;
 		}
 
-		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
-		dl_se->runtime = pi_of(dl_se)->dl_runtime;
+		replenish_dl_new_period(dl_se, rq);
 	}
 }
 
