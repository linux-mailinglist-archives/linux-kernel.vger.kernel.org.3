Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A617465ACB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354428AbhLBAcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:32:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59968 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245739AbhLBAci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F55EB82197;
        Thu,  2 Dec 2021 00:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0CAC53FD3;
        Thu,  2 Dec 2021 00:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404954;
        bh=ChitOAD9GWPJHkVi+DRX3MJw9PUq6OJcuq26w/uVy7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZSYgp/LCbAEF1V43OLMv2FG4HD2B1bBSxomRrGIRSTjRdfnxasifxSjJyFWskdmkU
         FAkkUmzZdBnCDnxKbN64Nr/PoVbz5xDYlksCboBuKbbePOgomBn4AvCqsjmDyDKmKQ
         qYa/uJEOVsFXCCTg61vozk2R6ypbGX79dmEmeWFd0/zK6sIHF85LRkhOgBNAWVer8D
         ZS/D/MBg4HACKsPezVLUd+D6SQuvRbO5DZvp7adpHWqEqCX/ROJy28ySULzwkWzUBk
         Hnbmt9zRpPx4hGEZ5zGoTL8xNG86d+dzuhAUTVwzY7v6E1sl1mLs91QCswOmxpA4N6
         k163+wPLxWj+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 663175C1180; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/18] rcu/nocb: Make rcu_core() callbacks acceleration preempt-safe
Date:   Wed,  1 Dec 2021 16:28:59 -0800
Message-Id: <20211202002912.3127710-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

While reporting a quiescent state for a given CPU, rcu_core() takes
advantage of the freshly loaded grace period sequence number and the
locked rnp to accelerate the callbacks whose sequence number have been
assigned a stale value.

This action is only necessary when the rdp isn't offloaded, otherwise
the NOCB kthreads already take care of the callbacks progression.

However the check for the offloaded state is volatile because it is
performed outside the IRQs disabled section. It's possible for the
offloading process to preempt rcu_core() at that point on PREEMPT_RT.

This is dangerous because rcu_core() may end up accelerating callbacks
concurrently with NOCB kthreads without appropriate locking.

Fix this with moving the offloaded check inside the rnp locking section.

Reported-and-tested-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a329adfece86e..5985698f33414 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2278,7 +2278,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
-	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2305,8 +2304,10 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		/*
 		 * This GP can't end until cpu checks in, so all of our
 		 * callbacks can be processed during the next GP.
+		 *
+		 * NOCB kthreads have their own way to deal with that.
 		 */
-		if (!offloaded)
+		if (!rcu_rdp_is_offloaded(rdp))
 			needwake = rcu_accelerate_cbs(rnp, rdp);
 
 		rcu_disable_urgency_upon_qs(rdp);
-- 
2.31.1.189.g2e36527f23

