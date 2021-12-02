Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF6465AD1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354482AbhLBAdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:33:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59978 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344693AbhLBAck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E538B82190;
        Thu,  2 Dec 2021 00:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC2EC5831A;
        Thu,  2 Dec 2021 00:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404954;
        bh=kCOlLK//e4LEgC73l0i+/mMJ7uIJzwXcEac9OYTBdlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTbNWQlGXvMX1ryABodMf5bK4a8v1xmyEP/iZZUZLPi2jWiav3zljQwShvSG988du
         FNKuonrW43j94/5WsgO7Acp7BnVTQ4dsK3d9vb5ODZ5TMRDgL82aL9tQg5LtURTCEF
         wasc2w09akl78sqRIGjTPrIrKt7Uw5bOIcCQ/+nTf/U0HSO2aefjkV2AKM1c0ImVHZ
         HjdvXJ9QO9E1gHvC7+sFszMr2HeDKy3gw0eEXPuQDBY/M/7+YrzGiArKEB/GxdPoby
         jEBmpQBfpTJVHsytJfhEbZOu1X3vAV12lkhB1aaqjEIbM/qU4Su6n45whAQucEHP3K
         t6q/9tNgImnAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6A84B5C1278; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
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
Subject: [PATCH rcu 07/18] rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check
Date:   Wed,  1 Dec 2021 16:29:01 -0800
Message-Id: <20211202002912.3127710-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

It's not entirely obvious why rdp->qlen_last_fqs_check is updated before
processing the queue only on offloaded rdp. There can be different
effect to that, either in favour of triggering the force quiescent state
path or not. For example:

1) If the number of callbacks has decreased since the last
   rdp->qlen_last_fqs_check update (because we recently called
   rcu_do_batch() and we executed below qhimark callbacks) and the number
   of processed callbacks on a subsequent do_batch() arranges for
   exceeding qhimark on non-offloaded but not on offloaded setup, then we
   may spare a later run to the force quiescent state
   slow path on __call_rcu_nocb_wake(), as compared to the non-offloaded
   counterpart scenario.

   Here is such an offloaded scenario instance:

    qhimark = 1000
    rdp->last_qlen_last_fqs_check = 3000
    rcu_segcblist_n_cbs(rdp) = 2000

    rcu_do_batch() {
        if (offloaded)
            rdp->last_qlen_fqs_check = rcu_segcblist_n_cbs(rdp) // 2000
        // run 1000 callback
        rcu_segcblist_n_cbs(rdp) = 1000
        // Not updating rdp->qlen_last_fqs_check
        if (count < rdp->qlen_last_fqs_check - qhimark)
            rdp->qlen_last_fqs_check = count;
    }

    call_rcu() * 1001 {
        __call_rcu_nocb_wake() {
            // not taking the fqs slowpath:
            // rcu_segcblist_n_cbs(rdp) == 2001
            // rdp->qlen_last_fqs_check == 2000
            // qhimark == 1000
            if (len > rdp->qlen_last_fqs_check + qhimark)
                ...
    }

    In the case of a non-offloaded scenario, rdp->qlen_last_fqs_check
    would be 1000 and the fqs slowpath would have executed.

2) If the number of callbacks has increased since the last
   rdp->qlen_last_fqs_check update (because we recently queued below
   qhimark callbacks) and the number of callbacks executed in rcu_do_batch()
   doesn't exceed qhimark for either offloaded or non-offloaded setup,
   then it's possible that the offloaded scenario later run the force
   quiescent state slow path on __call_rcu_nocb_wake() while the
   non-offloaded doesn't.

    qhimark = 1000
    rdp->last_qlen_last_fqs_check = 3000
    rcu_segcblist_n_cbs(rdp) = 2000

    rcu_do_batch() {
        if (offloaded)
            rdp->last_qlen_last_fqs_check = rcu_segcblist_n_cbs(rdp) // 2000
        // run 100 callbacks
        // concurrent queued 100
        rcu_segcblist_n_cbs(rdp) = 2000
        // Not updating rdp->qlen_last_fqs_check
        if (count < rdp->qlen_last_fqs_check - qhimark)
            rdp->qlen_last_fqs_check = count;
    }

    call_rcu() * 1001 {
        __call_rcu_nocb_wake() {
            // Taking the fqs slowpath:
            // rcu_segcblist_n_cbs(rdp) == 3001
            // rdp->qlen_last_fqs_check == 2000
            // qhimark == 1000
            if (len > rdp->qlen_last_fqs_check + qhimark)
                ...
    }

    In the case of a non-offloaded scenario, rdp->qlen_last_fqs_check
    would be 3000 and the fqs slowpath would have executed.

The reason for updating rdp->qlen_last_fqs_check when invoking callbacks
for offloaded CPUs is that there is usually no point in waking up either
the rcuog or rcuoc kthreads while in this state.  After all, both threads
are prohibited from indefinite sleeps.

The exception is when some huge number of callbacks are enqueued while
rcu_do_batch() is in the midst of invoking, in which case interrupting
the rcuog kthread's timed sleep might get more callbacks set up for the
next grace period.

Reported-and-tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Original-patch-by: Thomas Gleixner <tglx@linutronix.de>
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
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb9abb80377fe..4cbfc4e4fa9ed 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2498,7 +2498,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
-	if (offloaded)
+	if (rcu_rdp_is_offloaded(rdp))
 		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
 
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
-- 
2.31.1.189.g2e36527f23

