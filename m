Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E65A853B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiHaSOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiHaSNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F6BEA324;
        Wed, 31 Aug 2022 11:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3728F61C2F;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962E4C433D6;
        Wed, 31 Aug 2022 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969531;
        bh=v7yYUjYkw2p9AIgEWjIca4+sC4Wrp4YQLNStAinHtuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uU3/9oeCtiLmY3BeUxgqBGLQozhfkzEgEfkxp9Zieqil7lOW+RvPiB58/xcOwOGjp
         cykaGIA1GRhfLTgc6nOF46The/C0HWqRQqzBzpuxda33XVzTMZvZ1/QqbD/XWgKUoP
         I9BsfshWebdbyHZO+blkMZh0HDBpmtVjrn93aFEF378PMdJ0/tMV8eohcoavwjaSoL
         VHrH4/RyfDTnbJoUlsoZpCEN38R94+ytulPRGQqAcGMaUqxfMW1hOaQcUgWI0IvPWo
         +u5snDqeI/HjlujdgPF0CbLEdQEH4wARjb62d/s0jm9Xjjqi1mXF70r1nncax66EYs
         mbMwXtcHq4OOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 586545C015D; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/25] rcu: Add full-sized polling for get_completed*() and poll_state*()
Date:   Wed, 31 Aug 2022 11:11:46 -0700
Message-Id: <20220831181210.2695080-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_completed_synchronize_rcu() and poll_state_synchronize_rcu()
APIs compress the combined expedited and normal grace-period states into a
single unsigned long, which conserves storage, but can miss grace periods
in certain cases involving overlapping normal and expedited grace periods.
Missing the occasional grace period is usually not a problem, but there
are use cases that care about each and every grace period.

This commit therefore adds the first members of the full-state RCU
grace-period polling API, namely the get_completed_synchronize_rcu_full()
and poll_state_synchronize_rcu_full() functions.  These use up to three
times the storage (rcu_gp_oldstate structure instead of unsigned long),
but which are guaranteed not to miss grace periods, at least in situations
where the single-CPU grace-period optimization does not apply.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  3 ++
 include/linux/rcutiny.h  |  9 +++++
 include/linux/rcutree.h  |  8 +++++
 kernel/rcu/rcutorture.c  |  9 +++++
 kernel/rcu/tiny.c        | 10 ++++++
 kernel/rcu/tree.c        | 76 +++++++++++++++++++++++++++++++++++++---
 6 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f527f27e64387..faaa174dfb27c 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -42,7 +42,10 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_barrier_tasks(void);
 void rcu_barrier_tasks_rude(void);
 void synchronize_rcu(void);
+
+struct rcu_gp_oldstate;
 unsigned long get_completed_synchronize_rcu(void);
+void get_completed_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 
 #ifdef CONFIG_PREEMPT_RCU
 
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 62815c0a2dcef..1fbff8600d92d 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -14,10 +14,19 @@
 
 #include <asm/param.h> /* for HZ */
 
+struct rcu_gp_oldstate {
+	unsigned long rgos_norm;
+};
+
 unsigned long get_state_synchronize_rcu(void);
 unsigned long start_poll_synchronize_rcu(void);
 bool poll_state_synchronize_rcu(unsigned long oldstate);
 
+static inline bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
+{
+	return poll_state_synchronize_rcu(rgosp->rgos_norm);
+}
+
 static inline void cond_synchronize_rcu(unsigned long oldstate)
 {
 	might_sleep();
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 47eaa4cb0df72..4ccbc3aa9dc20 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -40,11 +40,19 @@ bool rcu_eqs_special_set(int cpu);
 void rcu_momentary_dyntick_idle(void);
 void kfree_rcu_scheduler_running(void);
 bool rcu_gp_might_be_stalled(void);
+
+struct rcu_gp_oldstate {
+	unsigned long rgos_norm;
+	unsigned long rgos_exp;
+	unsigned long rgos_polled;
+};
+
 unsigned long start_poll_synchronize_rcu_expedited(void);
 void cond_synchronize_rcu_expedited(unsigned long oldstate);
 unsigned long get_state_synchronize_rcu(void);
 unsigned long start_poll_synchronize_rcu(void);
 bool poll_state_synchronize_rcu(unsigned long oldstate);
+bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 void cond_synchronize_rcu(unsigned long oldstate);
 
 bool rcu_is_idle_cpu(int cpu);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d8e1b270a065f..b31e6ed64d1b9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -336,8 +336,10 @@ struct rcu_torture_ops {
 	void (*cond_sync_exp)(unsigned long oldstate);
 	unsigned long (*get_gp_state)(void);
 	unsigned long (*get_gp_completed)(void);
+	void (*get_gp_completed_full)(struct rcu_gp_oldstate *rgosp);
 	unsigned long (*start_gp_poll)(void);
 	bool (*poll_gp_state)(unsigned long oldstate);
+	bool (*poll_gp_state_full)(struct rcu_gp_oldstate *rgosp);
 	void (*cond_sync)(unsigned long oldstate);
 	call_rcu_func_t call;
 	void (*cb_barrier)(void);
@@ -503,8 +505,10 @@ static struct rcu_torture_ops rcu_ops = {
 	.exp_sync		= synchronize_rcu_expedited,
 	.get_gp_state		= get_state_synchronize_rcu,
 	.get_gp_completed	= get_completed_synchronize_rcu,
+	.get_gp_completed_full	= get_completed_synchronize_rcu_full,
 	.start_gp_poll		= start_poll_synchronize_rcu,
 	.poll_gp_state		= poll_state_synchronize_rcu,
+	.poll_gp_state_full	= poll_state_synchronize_rcu_full,
 	.cond_sync		= cond_synchronize_rcu,
 	.get_gp_state_exp	= get_state_synchronize_rcu,
 	.start_gp_poll_exp	= start_poll_synchronize_rcu_expedited,
@@ -1212,6 +1216,7 @@ rcu_torture_writer(void *arg)
 	bool boot_ended;
 	bool can_expedite = !rcu_gp_is_expedited() && !rcu_gp_is_normal();
 	unsigned long cookie;
+	struct rcu_gp_oldstate cookie_full;
 	int expediting = 0;
 	unsigned long gp_snap;
 	int i;
@@ -1277,6 +1282,10 @@ rcu_torture_writer(void *arg)
 				}
 				cur_ops->readunlock(idx);
 			}
+			if (cur_ops->get_gp_completed_full && cur_ops->poll_gp_state_full) {
+				cur_ops->get_gp_completed_full(&cookie_full);
+				WARN_ON_ONCE(!cur_ops->poll_gp_state_full(&cookie_full));
+			}
 			switch (synctype[torture_random(&rand) % nsynctypes]) {
 			case RTWS_DEF_FREE:
 				rcu_torture_writer_state = RTWS_DEF_FREE;
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index f0561ee16b9c2..435edc785412c 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -183,6 +183,16 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
+/*
+ * Store a grace-period-counter "cookie".  For more information,
+ * see the Tree RCU header comment.
+ */
+void get_completed_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
+{
+	rgosp->rgos_norm = RCU_GET_STATE_COMPLETED;
+}
+EXPORT_SYMBOL_GPL(get_completed_synchronize_rcu_full);
+
 /*
  * Return a grace-period-counter "cookie".  For more information,
  * see the Tree RCU header comment.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 79aea7df4345e..d47c9b6d81066 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3522,6 +3522,22 @@ void synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
+/**
+ * get_completed_synchronize_rcu_full - Return a full pre-completed polled state cookie
+ * @rgosp: Place to put state cookie
+ *
+ * Stores into @rgosp a value that will always be treated by functions
+ * like poll_state_synchronize_rcu_full() as a cookie whose grace period
+ * has already completed.
+ */
+void get_completed_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
+{
+	rgosp->rgos_norm = RCU_GET_STATE_COMPLETED;
+	rgosp->rgos_exp = RCU_GET_STATE_COMPLETED;
+	rgosp->rgos_polled = RCU_GET_STATE_COMPLETED;
+}
+EXPORT_SYMBOL_GPL(get_completed_synchronize_rcu_full);
+
 /**
  * get_state_synchronize_rcu - Snapshot current RCU state
  *
@@ -3580,7 +3596,7 @@ unsigned long start_poll_synchronize_rcu(void)
 EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
 
 /**
- * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
+ * poll_state_synchronize_rcu - Has the specified RCU grace period completed?
  *
  * @oldstate: value from get_state_synchronize_rcu() or start_poll_synchronize_rcu()
  *
@@ -3595,9 +3611,10 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
  * But counter wrap is harmless.  If the counter wraps, we have waited for
  * more than a billion grace periods (and way more on a 64-bit system!).
  * Those needing to keep oldstate values for very long time periods
- * (many hours even on 32-bit systems) should check them occasionally
- * and either refresh them or set a flag indicating that the grace period
- * has completed.
+ * (many hours even on 32-bit systems) should check them occasionally and
+ * either refresh them or set a flag indicating that the grace period has
+ * completed.  Alternatively, they can use get_completed_synchronize_rcu()
+ * to get a guaranteed-completed grace-period state.
  *
  * This function provides the same memory-ordering guarantees that
  * would be provided by a synchronize_rcu() that was invoked at the call
@@ -3615,6 +3632,57 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
 
+/**
+ * poll_state_synchronize_rcu_full - Has the specified RCU grace period completed?
+ * @rgosp: value from get_state_synchronize_rcu_full() or start_poll_synchronize_rcu_full()
+ *
+ * If a full RCU grace period has elapsed since the earlier call from
+ * which *rgosp was obtained, return @true, otherwise return @false.
+ * If @false is returned, it is the caller's responsibility to invoke this
+ * function later on until it does return @true.  Alternatively, the caller
+ * can explicitly wait for a grace period, for example, by passing @rgosp
+ * to cond_synchronize_rcu() or by directly invoking synchronize_rcu().
+ *
+ * Yes, this function does not take counter wrap into account.
+ * But counter wrap is harmless.  If the counter wraps, we have waited
+ * for more than a billion grace periods (and way more on a 64-bit
+ * system!).  Those needing to keep rcu_gp_oldstate values for very
+ * long time periods (many hours even on 32-bit systems) should check
+ * them occasionally and either refresh them or set a flag indicating
+ * that the grace period has completed.  Alternatively, they can use
+ * get_completed_synchronize_rcu_full() to get a guaranteed-completed
+ * grace-period state.
+ *
+ * This function provides the same memory-ordering guarantees that would
+ * be provided by a synchronize_rcu() that was invoked at the call to
+ * the function that provided @rgosp, and that returned at the end of this
+ * function.  And this guarantee requires that the root rcu_node structure's
+ * ->gp_seq field be checked instead of that of the rcu_state structure.
+ * The problem is that the just-ending grace-period's callbacks can be
+ * invoked between the time that the root rcu_node structure's ->gp_seq
+ * field is updated and the time that the rcu_state structure's ->gp_seq
+ * field is updated.  Therefore, if a single synchronize_rcu() is to
+ * cause a subsequent poll_state_synchronize_rcu_full() to return @true,
+ * then the root rcu_node structure is the one that needs to be polled.
+ */
+bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
+{
+	struct rcu_node *rnp = rcu_get_root();
+
+	smp_mb(); // Order against root rcu_node structure grace-period cleanup.
+	if (rgosp->rgos_norm == RCU_GET_STATE_COMPLETED ||
+	    rcu_seq_done_exact(&rnp->gp_seq, rgosp->rgos_norm) ||
+	    rgosp->rgos_exp == RCU_GET_STATE_COMPLETED ||
+	    rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp->rgos_exp) ||
+	    rgosp->rgos_polled == RCU_GET_STATE_COMPLETED ||
+	    rcu_seq_done_exact(&rcu_state.gp_seq_polled, rgosp->rgos_polled)) {
+		smp_mb(); /* Ensure GP ends before subsequent accesses. */
+		return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu_full);
+
 /**
  * cond_synchronize_rcu - Conditionally wait for an RCU grace period
  *
-- 
2.31.1.189.g2e36527f23

