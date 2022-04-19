Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD9D5060AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbiDSAKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbiDSAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:10:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94660B07;
        Mon, 18 Apr 2022 17:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A5706123D;
        Tue, 19 Apr 2022 00:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F23C385B0;
        Tue, 19 Apr 2022 00:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326869;
        bh=Odu9Jp/hxYy/VMF9e4eVFNWBvKvfuFd+U74qxGLF8ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clxgJoQ2pEzdSST8FXA+gyHzn/G2LU7vD7i7iM0uipY/ir+lmMpvulhzmgpGJOd2F
         zI6WUl8eAeCSH4kQLRMPUZ8OsR8o48Sp9x+9C4CacEmhzXP7ihFqkoNDe2xhydJXSF
         70FUyxY4HqTQSg6MO1kuvfQwp0YVl3NGtvq/IFNtnNyPh6SJg1VprzaLUE0GwQwiA5
         Ck08ROzo6lyJpR8uRsAmPOTun7gkLbUinV6wPt4zxcvHDrlvuXxG8R4WN6/HNJidSf
         l36nrmgK3sMKc4047KU2Tv+HpOnvpscSD/pFkKC88tSPKBa7+JicNYz1PvFhsCy6gr
         EdYh/SQC0EXkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2263A5C03F4; Mon, 18 Apr 2022 17:07:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/6] rcutorture: Suppress debugging grace period delays during flooding
Date:   Mon, 18 Apr 2022 17:07:42 -0700
Message-Id: <20220419000746.3949667-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000541.GA3949109@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000541.GA3949109@paulmck-ThinkPad-P17-Gen-1>
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

Tree RCU supports grace-period delays using the rcutree.gp_cleanup_delay,
rcutree.gp_init_delay, and rcutree.gp_preinit_delay kernel boot
parameters.  These delays are strictly for debugging purposes, and have
proven quite effective at exposing bugs involving race with CPU-hotplug
operations.  However, these delays can result in false positives when
used in conjunction with callback flooding, for example, those generated
by the rcutorture.fwd_progress kernel boot parameter.

This commit therefore suppresses grace-period delays while callback
flooding is in progress.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h        |  4 ++++
 kernel/rcu/rcutorture.c |  4 ++++
 kernel/rcu/tree.c       | 32 +++++++++++++++++++++++++++++---
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 24b5f2c2de87..7a221393fcdb 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -523,6 +523,8 @@ static inline bool rcu_check_boost_fail(unsigned long gp_state, int *cpup) { ret
 static inline void show_rcu_gp_kthreads(void) { }
 static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
 static inline void rcu_fwd_progress_check(unsigned long j) { }
+static inline void rcu_gp_slow_register(atomic_t *rgssp) { }
+static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
@@ -535,6 +537,8 @@ void rcu_fwd_progress_check(unsigned long j);
 void rcu_force_quiescent_state(void);
 extern struct workqueue_struct *rcu_gp_wq;
 extern struct workqueue_struct *rcu_par_gp_wq;
+void rcu_gp_slow_register(atomic_t *rgssp);
+void rcu_gp_slow_unregister(atomic_t *rgssp);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_RCU_NOCB_CPU
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 55d049c39608..f37b7a01dcd0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2916,10 +2916,12 @@ rcu_torture_cleanup(void)
 			pr_info("%s: Invoking %pS().\n", __func__, cur_ops->cb_barrier);
 			cur_ops->cb_barrier();
 		}
+		rcu_gp_slow_unregister(NULL);
 		return;
 	}
 	if (!cur_ops) {
 		torture_cleanup_end();
+		rcu_gp_slow_unregister(NULL);
 		return;
 	}
 
@@ -3016,6 +3018,7 @@ rcu_torture_cleanup(void)
 	else
 		rcu_torture_print_module_parms(cur_ops, "End of test: SUCCESS");
 	torture_cleanup_end();
+	rcu_gp_slow_unregister(&rcu_fwd_cb_nodelay);
 }
 
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
@@ -3320,6 +3323,7 @@ rcu_torture_init(void)
 	if (object_debug)
 		rcu_test_debug_objects();
 	torture_init_end();
+	rcu_gp_slow_register(&rcu_fwd_cb_nodelay);
 	return 0;
 
 unwind:
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4b8189455d5..db67dae8ed88 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1705,11 +1705,37 @@ static void note_gp_changes(struct rcu_data *rdp)
 		rcu_gp_kthread_wake();
 }
 
+static atomic_t *rcu_gp_slow_suppress;
+
+/* Register a counter to suppress debugging grace-period delays. */
+void rcu_gp_slow_register(atomic_t *rgssp)
+{
+	WARN_ON_ONCE(rcu_gp_slow_suppress);
+
+	WRITE_ONCE(rcu_gp_slow_suppress, rgssp);
+}
+EXPORT_SYMBOL_GPL(rcu_gp_slow_register);
+
+/* Unregister a counter, with NULL for not caring which. */
+void rcu_gp_slow_unregister(atomic_t *rgssp)
+{
+	WARN_ON_ONCE(rgssp && rgssp != rcu_gp_slow_suppress);
+
+	WRITE_ONCE(rcu_gp_slow_suppress, NULL);
+}
+EXPORT_SYMBOL_GPL(rcu_gp_slow_unregister);
+
+static bool rcu_gp_slow_is_suppressed(void)
+{
+	atomic_t *rgssp = READ_ONCE(rcu_gp_slow_suppress);
+
+	return rgssp && atomic_read(rgssp);
+}
+
 static void rcu_gp_slow(int delay)
 {
-	if (delay > 0 &&
-	    !(rcu_seq_ctr(rcu_state.gp_seq) %
-	      (rcu_num_nodes * PER_RCU_NODE_PERIOD * delay)))
+	if (!rcu_gp_slow_is_suppressed() && delay > 0 &&
+	    !(rcu_seq_ctr(rcu_state.gp_seq) % (rcu_num_nodes * PER_RCU_NODE_PERIOD * delay)))
 		schedule_timeout_idle(delay);
 }
 
-- 
2.31.1.189.g2e36527f23

