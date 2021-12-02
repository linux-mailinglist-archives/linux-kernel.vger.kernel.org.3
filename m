Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B32465ACD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354461AbhLBAdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:33:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59982 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344802AbhLBAck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A26EB82193;
        Thu,  2 Dec 2021 00:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA99C58325;
        Thu,  2 Dec 2021 00:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404955;
        bh=2DdkVuz5c3cWAsQ97esB1iNtkrTH2B/c1ewNeW407Lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TKMcpTs92KleWAZDiSAXG5h6pUFy6ojSw1D2xHm3KOZjwM78WuVM9+pYgBv4qE4yG
         NkJ6lU22YUcPgBvBaB4S4eY6/olGO5a0JrQcwGORolqFE2FwjXDdC+26+Z53gGa1JQ
         Gwb8ubc2yuALC61/PrYA+7GV28dcowP3Qfds6H7BDvbB5hZWV7/+zZeM7ok1leVqMX
         J/IkamBvFE0a5D9iE0MYh0Oj3cTOX4LAHZOe7lAiMZVsdUjndAyUDRoRJwqbRyq+8/
         aCHERHi8jBVkNX1P6HJn+5pVhu8opxQmVmprpxlfRkWNoj0EcbuU1gK5uIo+xa/tys
         L+ZQAZpO/GqbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6EA775C13F5; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/18] rcu/nocb: Limit number of softirq callbacks only on softirq
Date:   Wed,  1 Dec 2021 16:29:03 -0800
Message-Id: <20211202002912.3127710-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The current condition to limit the number of callbacks executed in a
row checks the offloaded state of the rdp. Not only is it volatile
but it is also misleading: the rcu_core() may well be executing
callbacks concurrently with NOCB kthreads, and the offloaded state
would then be verified on both cases. As a result the limit would
spuriously not apply anymore on softirq while in the middle of
(de-)offloading process.

Fix and clarify the condition with those constraints in mind:

_ If callbacks are processed either by rcuc or NOCB kthread, the call
  to cond_resched_tasks_rcu_qs() is enough to take care of the overload.

_ If instead callbacks are processed by softirqs:
  * If need_resched(), exit the callbacks processing
  * Otherwise if CPU is idle we can continue
  * Otherwise exit because a softirq shouldn't interrupt a task for too
    long nor deprive other pending softirq vectors of the CPU.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 20587d035d03b..4f4d9ea6a9cb5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2525,9 +2525,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		/*
 		 * Stop only if limit reached and CPU has something to do.
 		 */
-		if (count >= bl && !offloaded &&
-		    (need_resched() ||
-		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
+		if (count >= bl && in_serving_softirq() &&
+		    (need_resched() || !is_idle_task(current)))
 			break;
 		if (unlikely(tlimit)) {
 			/* only call local_clock() every 32 callbacks */
-- 
2.31.1.189.g2e36527f23

