Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB81450608F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiDSAHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbiDSAGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B29F2496B;
        Mon, 18 Apr 2022 17:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45917612D3;
        Tue, 19 Apr 2022 00:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FC8C385CA;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=OYXi6oMxVVELQzNdo5jYt/IiIWzJKIlnGTPP/z8oSgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLD46zBfqV7QiuOTvLwhMxluOSVA9Nx7TDtqZARGcq8qpjqXyjeCvIaVoBvQnp7KX
         0/QccrXhKAnM+FKnjSZAzfrzBkQNqF28uuH2tK/Vt2FB5p8WlqeKkeUvPXee/abFoC
         hLiXlMfCXtIZsKEzoQxHkm9/8Z/9a6/0q9ll709k6za1CzSCJA/aHLrIErJ9s2hsmq
         8blodPsacCRJ+UFvAausD28U2IJsIXiXmvfegbCKfVpdAfLQ6e2I2KksIXqmqVnJru
         NtAtAUr5TIgzEWRdU+SONh0juvCKGL2tWrfHFyOaSqMyEDMIb5Qeu6C6IvH4CJtyNg
         dgwPbzDbbZWDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 710145C30E3; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Song Liu <song@kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 20/21] srcu: Prevent expedited GPs and blocking readers from consuming CPU
Date:   Mon, 18 Apr 2022 17:03:21 -0700
Message-Id: <20220419000322.3948903-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
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

If an SRCU reader blocks while a synchronize_srcu_expedited() waits for
that same reader, then that grace period will spawn an endless series of
workqueue handlers, consuming a full CPU.  This quickly gets pointless
because consuming more CPU isn't going to make that reader get done
faster, especially if it is blocked waiting for an external event.

This commit therefore spawns at most one pair of back-to-back workqueue
handlers per expedited grace period phase, instead inserting increasing
delays as that grace period phase grows older, but capped at 10 jiffies.
In any case, if there have been at least 100 back-to-back workqueue
handlers within a single jiffy, regardless of grace period or grace-period
phase, then a one-jiffy delay is inserted.

[ paulmck:  Apply feedback from kernel test robot. ]

Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Reported-by: Song Liu <song@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  4 ++++
 kernel/rcu/srcutree.c    | 44 ++++++++++++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 1b9ff4ed37e4..e3014319d1ad 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -71,9 +71,11 @@ struct srcu_struct {
 	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
 	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
+	unsigned long srcu_gp_start;		/* Last GP start timestamp (jiffies) */
 	unsigned long srcu_last_gp_end;		/* Last GP end timestamp (ns) */
 	unsigned long srcu_size_jiffies;	/* Current contention-measurement interval. */
 	unsigned long srcu_n_lock_retries;	/* Contention events in current interval. */
+	unsigned long srcu_n_exp_nodelay;	/* # expedited no-delays in current GP phase. */
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
 	bool sda_is_static;			/* May ->sda be passed to free_percpu()? */
 	unsigned long srcu_barrier_seq;		/* srcu_barrier seq #. */
@@ -83,6 +85,8 @@ struct srcu_struct {
 	atomic_t srcu_barrier_cpu_cnt;		/* # CPUs not yet posting a */
 						/*  callback for the barrier */
 						/*  operation. */
+	unsigned long reschedule_jiffies;
+	unsigned long reschedule_count;
 	struct delayed_work work;
 	struct lockdep_map dep_map;
 };
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 862008c147b0..6dd44e759f12 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -511,7 +511,10 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
 	return sum;
 }
 
-#define SRCU_INTERVAL		1
+#define SRCU_INTERVAL		1	// Base delay if no expedited GPs pending.
+#define SRCU_MAX_INTERVAL	10	// Maximum incremental delay from slow readers.
+#define SRCU_MAX_NODELAY_PHASE	1	// Maximum per-GP-phase consecutive no-delay instances.
+#define SRCU_MAX_NODELAY	100	// Maximum consecutive no-delay instances.
 
 /*
  * Return grace-period delay, zero if there are expedited grace
@@ -519,9 +522,18 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
  */
 static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 {
+	unsigned long jbase = SRCU_INTERVAL;
+
 	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
-		return 0;
-	return SRCU_INTERVAL;
+		jbase = 0;
+	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)))
+		jbase += jiffies - READ_ONCE(ssp->srcu_gp_start);
+	if (!jbase) {
+		WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
+		if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
+			jbase = 1;
+	}
+	return jbase > SRCU_MAX_INTERVAL ? SRCU_MAX_INTERVAL : jbase;
 }
 
 /**
@@ -623,6 +635,8 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
 				       rcu_seq_snap(&ssp->srcu_gp_seq));
 	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
+	WRITE_ONCE(ssp->srcu_gp_start, jiffies);
+	WRITE_ONCE(ssp->srcu_n_exp_nodelay, 0);
 	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
 	rcu_seq_start(&ssp->srcu_gp_seq);
 	state = rcu_seq_state(ssp->srcu_gp_seq);
@@ -706,7 +720,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	spin_lock_irq_rcu_node(ssp);
 	idx = rcu_seq_state(ssp->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
-	cbdelay = srcu_get_delay(ssp);
+	cbdelay = !!srcu_get_delay(ssp);
 	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
 	rcu_seq_end(&ssp->srcu_gp_seq);
 	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
@@ -893,7 +907,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		// the one boot CPU running with interrupts still disabled.
 		if (likely(srcu_init_done))
 			queue_delayed_work(rcu_gp_wq, &ssp->work,
-					   srcu_get_delay(ssp));
+					   !!srcu_get_delay(ssp));
 		else if (list_empty(&ssp->work.work.entry))
 			list_add(&ssp->work.work.entry, &srcu_boot_list);
 	}
@@ -1448,6 +1462,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		srcu_flip(ssp);
 		spin_lock_irq_rcu_node(ssp);
 		rcu_seq_set_state(&ssp->srcu_gp_seq, SRCU_STATE_SCAN2);
+		ssp->srcu_n_exp_nodelay = 0;
 		spin_unlock_irq_rcu_node(ssp);
 	}
 
@@ -1462,6 +1477,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 			mutex_unlock(&ssp->srcu_gp_mutex);
 			return; /* readers present, retry later. */
 		}
+		ssp->srcu_n_exp_nodelay = 0;
 		srcu_gp_end(ssp);  /* Releases ->srcu_gp_mutex. */
 	}
 }
@@ -1552,12 +1568,28 @@ static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay)
  */
 static void process_srcu(struct work_struct *work)
 {
+	unsigned long curdelay;
+	unsigned long j;
 	struct srcu_struct *ssp;
 
 	ssp = container_of(work, struct srcu_struct, work.work);
 
 	srcu_advance_state(ssp);
-	srcu_reschedule(ssp, srcu_get_delay(ssp));
+	curdelay = srcu_get_delay(ssp);
+	if (curdelay) {
+		WRITE_ONCE(ssp->reschedule_count, 0);
+	} else {
+		j = jiffies;
+		if (READ_ONCE(ssp->reschedule_jiffies) == j) {
+			WRITE_ONCE(ssp->reschedule_count, READ_ONCE(ssp->reschedule_count) + 1);
+			if (READ_ONCE(ssp->reschedule_count) > SRCU_MAX_NODELAY)
+				curdelay = 1;
+		} else {
+			WRITE_ONCE(ssp->reschedule_count, 1);
+			WRITE_ONCE(ssp->reschedule_jiffies, j);
+		}
+	}
+	srcu_reschedule(ssp, curdelay);
 }
 
 void srcutorture_get_gp_data(enum rcutorture_type test_type,
-- 
2.31.1.189.g2e36527f23

