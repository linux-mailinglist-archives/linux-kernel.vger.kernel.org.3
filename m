Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAB955272C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiFTWwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344301AbiFTWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939351CFF5;
        Mon, 20 Jun 2022 15:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39FC5B81648;
        Mon, 20 Jun 2022 22:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB24C3411C;
        Mon, 20 Jun 2022 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765490;
        bh=itABiS+6bfg1NTOpoC0+1FdfGW1G9cPkCW8NoD1VfvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNaxXy8bV1X9UCTHYDFHtUuJPod+atNci6hnfCwtNJtRSp8wbq7xzhY4NRA50X6I0
         TX6EZlvlfJtbcLz37hT/gX7fnZk4H/RkGqwxpvdAPGjSDy+D4fNt4ApspfXf2mRldN
         YqjsFH1WxORfIKWXc2qQnCsc3KUmAcTyLIGz7Nh3foSw/31Rk7KTreyeeFZZ8stjrq
         KZg27FfB0mTBxyG9M3X++98wjeEm36sMMWbUlGAn5BHbd9NYKsXVxlA1ygdqD0meZ2
         0J1M7cVAcPojBhKMzsjMqGSk0IsJbwZGhLEKo7JXK0mPRid8ePuGltgXXIJCDg4syq
         lKDkhOift1YjA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 959CF5C0093; Mon, 20 Jun 2022 15:51:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: [PATCH rcu 02/12] rcu: Provide a get_completed_synchronize_rcu() function
Date:   Mon, 20 Jun 2022 15:51:18 -0700
Message-Id: <20220620225128.3842050-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
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

It is currently up to the caller to handle stale return values from
get_state_synchronize_rcu().  If poll_state_synchronize_rcu() returned
true once, a grace period has elapsed, regardless of the fact that counter
wrap might cause some future poll_state_synchronize_rcu() invocation to
return false.  For example, the caller might store a separate flag that
indicates whether some previous call to poll_state_synchronize_rcu()
determined that the relevant grace period had already ended.

This approach works, but it requires extra storage and is easy to get
wrong.  This commit therefore introduces a get_completed_synchronize_rcu()
that returns a cookie that causes poll_state_synchronize_rcu() to always
return true.  This already-completed cookie can be stored in place of the
cookie that previously caused poll_state_synchronize_rcu() to return true.
It can also be used to flag a given structure as not having been exposed
to readers, and thus not requiring a grace period to elapse.

This commit is in preparation for polled expedited grace periods.

Link: https://lore.kernel.org/all/20220121142454.1994916-1-bfoster@redhat.com/
Link: https://docs.google.com/document/d/1RNKWW9jQyfjxw2E8dsXVTdvZYh0HnYeSHDKog9jhdN8/edit?usp=sharing
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  1 +
 kernel/rcu/rcu.h         |  3 +++
 kernel/rcu/tiny.c        |  4 ++--
 kernel/rcu/tree.c        |  3 ++-
 kernel/rcu/update.c      | 13 +++++++++++++
 5 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 1a32036c918cd..7f12daa4708b1 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -41,6 +41,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_barrier_tasks(void);
 void rcu_barrier_tasks_rude(void);
 void synchronize_rcu(void);
+unsigned long get_completed_synchronize_rcu(void);
 
 #ifdef CONFIG_PREEMPT_RCU
 
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 0adb55941aeb3..32291f4eefde9 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -23,6 +23,9 @@
 #define RCU_SEQ_CTR_SHIFT	2
 #define RCU_SEQ_STATE_MASK	((1 << RCU_SEQ_CTR_SHIFT) - 1)
 
+/* Low-order bit definition for polled grace-period APIs. */
+#define RCU_GET_STATE_COMPLETED	0x1
+
 extern int sysctl_sched_rt_runtime;
 
 /*
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 340b3f8b090d4..dbee6bea67269 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -58,7 +58,7 @@ void rcu_qs(void)
 		rcu_ctrlblk.donetail = rcu_ctrlblk.curtail;
 		raise_softirq_irqoff(RCU_SOFTIRQ);
 	}
-	WRITE_ONCE(rcu_ctrlblk.gp_seq, rcu_ctrlblk.gp_seq + 1);
+	WRITE_ONCE(rcu_ctrlblk.gp_seq, rcu_ctrlblk.gp_seq + 2);
 	local_irq_restore(flags);
 }
 
@@ -213,7 +213,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
  */
 bool poll_state_synchronize_rcu(unsigned long oldstate)
 {
-	return READ_ONCE(rcu_ctrlblk.gp_seq) != oldstate;
+	return oldstate == RCU_GET_STATE_COMPLETED || READ_ONCE(rcu_ctrlblk.gp_seq) != oldstate;
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ec28e259774e7..46cfceea87847 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3924,7 +3924,8 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
  */
 bool poll_state_synchronize_rcu(unsigned long oldstate)
 {
-	if (rcu_seq_done_exact(&rcu_state.gp_seq, oldstate)) {
+	if (oldstate == RCU_GET_STATE_COMPLETED ||
+	    rcu_seq_done_exact(&rcu_state.gp_seq, oldstate)) {
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 		return true;
 	}
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index fc7fef5756064..2e93acad1e31f 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -516,6 +516,19 @@ int rcu_cpu_stall_suppress_at_boot __read_mostly; // !0 = suppress boot stalls.
 EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress_at_boot);
 module_param(rcu_cpu_stall_suppress_at_boot, int, 0444);
 
+/**
+ * get_completed_synchronize_rcu - Return a pre-completed polled state cookie
+ *
+ * Returns a value that will always be treated by functions like
+ * poll_state_synchronize_rcu() as a cookie whose grace period has already
+ * completed.
+ */
+unsigned long get_completed_synchronize_rcu(void)
+{
+	return RCU_GET_STATE_COMPLETED;
+}
+EXPORT_SYMBOL_GPL(get_completed_synchronize_rcu);
+
 #ifdef CONFIG_PROVE_RCU
 
 /*
-- 
2.31.1.189.g2e36527f23

