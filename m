Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D894AA4AC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378454AbiBDXxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:53:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45760 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378366AbiBDXxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27266B83973;
        Fri,  4 Feb 2022 23:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69F9C340F2;
        Fri,  4 Feb 2022 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018809;
        bh=Io8OOvJ7kPMPed5CAYEEfGmPgC4ynlJcaTeSoyVPSfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HvNySBPy41L+uE/AP+XKfXsUGiEqyb6EvS/9P6HLdyXgpjXyBfIV0YYNoaIVH58Rz
         p98ba9dZ1AoeEbEHrXJBsI7b6kjz+cFVYO75jhjJSUiJuN4XGpv94eZYtoLVoUjUWI
         jRXJuBh8hNGb+jDxKTdYmzWeJgTBtCXv0lv8Wnp/LjkJVuPGVVPf1v0A5Jy7Oiltdk
         IL6RQfsMazxQsnSztHWdfEwZFh8bS6hIKKAnbZ8EbAbKLIc8b8jqQs+73PUG1Egy0P
         f49trSNrhjlM5m852TStUkHy1IInkA96Qf+3zEvsuw02KB3NloIvWPGDfD6ky2WJGf
         ePoBnkn5hLG3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7AF635C08DD; Fri,  4 Feb 2022 15:53:29 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/8] rcutorture: Make rcu_fwd_cb_nodelay be a counter
Date:   Fri,  4 Feb 2022 15:53:23 -0800
Message-Id: <20220204235327.2948-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back when only one rcutorture kthread could do forward-progress testing,
it was just fine for rcu_fwd_cb_nodelay to be a non-atomic bool.  It was
set at the start of forward-progress testing and cleared at the end.
But now that there are multiple threads, the value can be cleared while
one of the threads is still doing forward-progress testing.  This commit
therefore makes rcu_fwd_cb_nodelay be an atomic counter, replacing the
WRITE_ONCE() operations with atomic_inc() and atomic_dec().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index fefc3fa1a9c2a..afe95c6948957 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -284,7 +284,7 @@ static atomic_t barrier_cbs_invoked;	/* Barrier callbacks invoked. */
 static wait_queue_head_t *barrier_cbs_wq; /* Coordinate barrier testing. */
 static DECLARE_WAIT_QUEUE_HEAD(barrier_wq);
 
-static bool rcu_fwd_cb_nodelay;		/* Short rcu_torture_delay() delays. */
+static atomic_t rcu_fwd_cb_nodelay;	/* Short rcu_torture_delay() delays. */
 
 /*
  * Allocate an element from the rcu_tortures pool.
@@ -387,7 +387,7 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 	 * period, and we want a long delay occasionally to trigger
 	 * force_quiescent_state. */
 
-	if (!READ_ONCE(rcu_fwd_cb_nodelay) &&
+	if (!atomic_read(&rcu_fwd_cb_nodelay) &&
 	    !(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
 		started = cur_ops->get_gp_seq();
 		ts = rcu_trace_clock_local();
@@ -1276,7 +1276,7 @@ rcu_torture_writer(void *arg)
 		boot_ended = rcu_inkernel_boot_has_ended();
 		stutter_waited = stutter_wait("rcu_torture_writer");
 		if (stutter_waited &&
-		    !READ_ONCE(rcu_fwd_cb_nodelay) &&
+		    !atomic_read(&rcu_fwd_cb_nodelay) &&
 		    !cur_ops->slow_gps &&
 		    !torture_must_stop() &&
 		    boot_ended)
@@ -2290,7 +2290,7 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
 	}
 
 	/* Tight loop containing cond_resched(). */
-	WRITE_ONCE(rcu_fwd_cb_nodelay, true);
+	atomic_inc(&rcu_fwd_cb_nodelay);
 	cur_ops->sync(); /* Later readers see above write. */
 	if  (selfpropcb) {
 		WRITE_ONCE(fcs.stop, 0);
@@ -2335,7 +2335,7 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
 		destroy_rcu_head_on_stack(&fcs.rh);
 	}
 	schedule_timeout_uninterruptible(HZ / 10); /* Let kthreads recover. */
-	WRITE_ONCE(rcu_fwd_cb_nodelay, false);
+	atomic_dec(&rcu_fwd_cb_nodelay);
 }
 
 /* Carry out call_rcu() forward-progress testing. */
@@ -2362,7 +2362,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 		return; /* Can't do call_rcu() fwd prog without ->call. */
 
 	/* Loop continuously posting RCU callbacks. */
-	WRITE_ONCE(rcu_fwd_cb_nodelay, true);
+	atomic_inc(&rcu_fwd_cb_nodelay);
 	cur_ops->sync(); /* Later readers see above write. */
 	WRITE_ONCE(rfp->rcu_fwd_startat, jiffies);
 	stopat = rfp->rcu_fwd_startat + MAX_FWD_CB_JIFFIES;
@@ -2435,7 +2435,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 	}
 	schedule_timeout_uninterruptible(HZ); /* Let CBs drain. */
 	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
-	WRITE_ONCE(rcu_fwd_cb_nodelay, false);
+	atomic_dec(&rcu_fwd_cb_nodelay);
 }
 
 
-- 
2.31.1.189.g2e36527f23

