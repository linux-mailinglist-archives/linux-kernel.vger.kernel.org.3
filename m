Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7754827A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbiFMInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239488AbiFMIn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:43:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FB6C45;
        Mon, 13 Jun 2022 01:43:27 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:43:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655109805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3okKoR/CVCiKXgcwp0iBGz3FvDwOvZJISWblwbYi/vE=;
        b=AbnN4E7Tmol75xO6g7uUAy+0993Qtb+8vfMMM/Ib0oblNCSthHUZ3ecWt6l24t41BG3jyU
        Fpfkhs89EfFPEHgZB2HE153FSc1K1Fou9/9phgtCo5rDHhTKFKXphovTEiSZMIefoBin6J
        62/te4+CV7xIfDcUKdacT9dJDHB2T8gOilA0CcqC7OD2RuQuMOZbD1vdtJ32zJTPoLwifT
        OCQZoCKm6uyBMU5STyWARRbe24aol7wR4jEuEiNAxXlQU6qm8Yq2VkIlgiiwT4oBpRp8+P
        tuLGXbhTKK4Fesvt03/MS26ipVyjMIRVsAxKBvFq6VbILDYevae/5UqyGyRZDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655109805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3okKoR/CVCiKXgcwp0iBGz3FvDwOvZJISWblwbYi/vE=;
        b=iu1tSyKl+wwAUQXFCWwJp92/2sU7PZnG1aabrKgxs5criIIm6tAKLhcquYSVK5wqiYBQFK
        YhlR0N7jAF2fKKBA==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Allow newidle balancing to bail out of load_balance
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220609025515.2086253-1-joshdon@google.com>
References: <20220609025515.2086253-1-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <165510980461.4207.16837948600111903560.tip-bot2@tip-bot2>
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

Commit-ID:     792b9f65a568f48c50b3175536db9cde5a1edcc0
Gitweb:        https://git.kernel.org/tip/792b9f65a568f48c50b3175536db9cde5a1edcc0
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Wed, 08 Jun 2022 19:55:15 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:30:01 +02:00

sched: Allow newidle balancing to bail out of load_balance

While doing newidle load balancing, it is possible for new tasks to
arrive, such as with pending wakeups. newidle_balance() already accounts
for this by exiting the sched_domain load_balance() iteration if it
detects these cases. This is very important for minimizing wakeup
latency.

However, if we are already in load_balance(), we may stay there for a
while before returning back to newidle_balance(). This is most
exacerbated if we enter a 'goto redo' loop in the LBF_ALL_PINNED case. A
very straightforward workaround to this is to adjust should_we_balance()
to bail out if we're doing a CPU_NEWLY_IDLE balance and new tasks are
detected.

This was tested with the following reproduction:
- two threads that take turns sleeping and waking each other up are
  affined to two cores
- a large number of threads with 100% utilization are pinned to all
  other cores

Without this patch, wakeup latency was ~120us for the pair of threads,
almost entirely spent in load_balance(). With this patch, wakeup latency
is ~6us.

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220609025515.2086253-1-joshdon@google.com
---
 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7d8ef01..8bed757 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9824,9 +9824,15 @@ static int should_we_balance(struct lb_env *env)
 	/*
 	 * In the newly idle case, we will allow all the CPUs
 	 * to do the newly idle load balance.
+	 *
+	 * However, we bail out if we already have tasks or a wakeup pending,
+	 * to optimize wakeup latency.
 	 */
-	if (env->idle == CPU_NEWLY_IDLE)
+	if (env->idle == CPU_NEWLY_IDLE) {
+		if (env->dst_rq->nr_running > 0 || env->dst_rq->ttwu_pending)
+			return 0;
 		return 1;
+	}
 
 	/* Try to find first idle CPU */
 	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
