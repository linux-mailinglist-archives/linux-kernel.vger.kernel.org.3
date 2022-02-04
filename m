Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED0C4AA434
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378033AbiBDXUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:20:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59500 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378026AbiBDXUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:20:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36F0BB83938;
        Fri,  4 Feb 2022 23:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29D1C340ED;
        Fri,  4 Feb 2022 23:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016837;
        bh=aPqpQB1V+ial4RA4tbGtfUo/DpQXz9yRajIkK4rcS3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVWZi99bWMS34YhGfPTLsbxyF2nQVo5mmIeoFG8CZQvc69HEUc49kClUrDUBuaYY3
         91cJenx5fhKD3Qh5z2qQrUw/mIvtfB2tqR+3YMIP2o71yg/PWcgUDGljfaOjeDaKTI
         M9XePeCZlR3Q9ZgaNGReUBtIzgT+joeaIP2ElDPMA6UH3zSt+V25KjZPt6/25Osxjd
         NGm4pOwGOTD+smf28ndce5g8tY22MkCkAmI59YdaIzARABqAyntVYc+Q8Ga27TJtZm
         VWkn86zXnsAPH4PoQlrHBv4zzTMedEWGqNC6vJdWBRS1k7RnnqYcEbWRJKGKuwOsYH
         CL06t2GgVxsfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A36795C0829; Fri,  4 Feb 2022 15:20:37 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/5] rcu: Refactor rcu_barrier() empty-list handling
Date:   Fri,  4 Feb 2022 15:20:33 -0800
Message-Id: <20220204232036.460-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204232027.GA4194214@paulmck-ThinkPad-P17-Gen-1>
References: <20220204232027.GA4194214@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit saves a few lines by checking first for an empty callback
list.  If the callback list is empty, then that CPU is taken care of,
regardless of its online or nocb state.  Also simplify tracing accordingly
and fold a few lines together.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h |  9 ++++-----
 kernel/rcu/tree.c          | 25 ++++++++-----------------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 670e41783edd8..90b2fb0292cb1 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -794,16 +794,15 @@ TRACE_EVENT_RCU(rcu_torture_read,
  * Tracepoint for rcu_barrier() execution.  The string "s" describes
  * the rcu_barrier phase:
  *	"Begin": rcu_barrier() started.
+ *	"CB": An rcu_barrier_callback() invoked a callback, not the last.
  *	"EarlyExit": rcu_barrier() piggybacked, thus early exit.
  *	"Inc1": rcu_barrier() piggyback check counter incremented.
- *	"OfflineNoCBQ": rcu_barrier() found offline no-CBs CPU with callbacks.
- *	"OnlineQ": rcu_barrier() found online CPU with callbacks.
- *	"OnlineNQ": rcu_barrier() found online CPU, no callbacks.
+ *	"Inc2": rcu_barrier() piggyback check counter incremented.
  *	"IRQ": An rcu_barrier_callback() callback posted on remote CPU.
  *	"IRQNQ": An rcu_barrier_callback() callback found no callbacks.
- *	"CB": An rcu_barrier_callback() invoked a callback, not the last.
  *	"LastCB": An rcu_barrier_callback() invoked the last callback.
- *	"Inc2": rcu_barrier() piggyback check counter incremented.
+ *	"NQ": rcu_barrier() found a CPU with no callbacks.
+ *	"OnlineQ": rcu_barrier() found online CPU with callbacks.
  * The "cpu" argument is the CPU or -1 if meaningless, the "cnt" argument
  * is the count of remaining callbacks, and "done" is the piggybacking count.
  */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8f6cf86a76c2d..87ea516f87779 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4030,8 +4030,7 @@ void rcu_barrier(void)
 
 	/* Did someone else do our work for us? */
 	if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
-		rcu_barrier_trace(TPS("EarlyExit"), -1,
-				  rcu_state.barrier_sequence);
+		rcu_barrier_trace(TPS("EarlyExit"), -1, rcu_state.barrier_sequence);
 		smp_mb(); /* caller's subsequent code after above check. */
 		mutex_unlock(&rcu_state.barrier_mutex);
 		return;
@@ -4059,26 +4058,18 @@ void rcu_barrier(void)
 	 */
 	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
-		if (cpu_is_offline(cpu) &&
-		    !rcu_rdp_is_offloaded(rdp))
+		if (!rcu_segcblist_n_cbs(&rdp->cblist)) {
+			rcu_barrier_trace(TPS("NQ"), cpu, rcu_state.barrier_sequence);
 			continue;
-		if (rcu_segcblist_n_cbs(&rdp->cblist) && cpu_online(cpu)) {
-			rcu_barrier_trace(TPS("OnlineQ"), cpu,
-					  rcu_state.barrier_sequence);
+		}
+		if (cpu_online(cpu)) {
+			rcu_barrier_trace(TPS("OnlineQ"), cpu, rcu_state.barrier_sequence);
 			smp_call_function_single(cpu, rcu_barrier_func, (void *)cpu, 1);
-		} else if (rcu_segcblist_n_cbs(&rdp->cblist) &&
-			   cpu_is_offline(cpu)) {
-			rcu_barrier_trace(TPS("OfflineNoCBQ"), cpu,
-					  rcu_state.barrier_sequence);
+		} else {
+			rcu_barrier_trace(TPS("OfflineNoCBQ"), cpu, rcu_state.barrier_sequence);
 			local_irq_disable();
 			rcu_barrier_func((void *)cpu);
 			local_irq_enable();
-		} else if (cpu_is_offline(cpu)) {
-			rcu_barrier_trace(TPS("OfflineNoCBNoQ"), cpu,
-					  rcu_state.barrier_sequence);
-		} else {
-			rcu_barrier_trace(TPS("OnlineNQ"), cpu,
-					  rcu_state.barrier_sequence);
 		}
 	}
 	cpus_read_unlock();
-- 
2.31.1.189.g2e36527f23

