Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB9B505FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiDRW5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiDRW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88A82CC9D;
        Mon, 18 Apr 2022 15:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77511B81135;
        Mon, 18 Apr 2022 22:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3588FC385A8;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322441;
        bh=3/4SJxZl7LRSsaEhih4xR7lzgf/M6pQIEs1EAdF+8Xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/MDb//Dx1aVAuwdSFZUrhtpeY5xRFXWDcqAFKG9dd54tI2v/+dDd+iUaG9JUUqLj
         gpUM8xB2YJpklamaW8j7k0VXsAFV3QePxlcNb9YMlZnWZb1jnuRXS3rVdv8TFL00zO
         KQaTFfBLM5xOOOtVUXVxSx/uWcgrv82TDyDTZKJ8GGjO7EPBxHIs7HCd3Ss5tw/Lcw
         KQ3kPD9x+7xMUG5ETaT/FVVVOEyLxJdV9Owk1LmBjyQ00cAmFHa4/N0siDX5fMtVYV
         yfsqpDZD+m+DJESF1aIRlwpQqQCtxx/rBYK2rNp6vQF5bfHKoxMDgKelyezv2VKCBI
         045K4+Yqen8fA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E36075C0848; Mon, 18 Apr 2022 15:54:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Saravanan D <sarvanand@fb.com>
Subject: [PATCH rcu 03/11] rcu: Check for jiffies going backwards
Date:   Mon, 18 Apr 2022 15:53:51 -0700
Message-Id: <20220418225359.3945217-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
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

A report of a 12-jiffy normal RCU CPU stall warning raises interesting
questions about the nature of time on the offending system.  This commit
instruments rcu_sched_clock_irq(), which is RCU's hook into the
scheduling-clock interrupt, checking for the jiffies counter going
backwards.

Reported-by: Saravanan D <sarvanand@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 10 ++++++++++
 kernel/rcu/tree.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4b8189455d5..a5ea67454640 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1679,6 +1679,8 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
 	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || rdp->gpwrap)
 		WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
+	if (IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(rdp->gpwrap))
+		WRITE_ONCE(rdp->last_sched_clock, jiffies);
 	WRITE_ONCE(rdp->gpwrap, false);
 	rcu_gpnum_ovf(rnp, rdp);
 	return ret;
@@ -2609,6 +2611,13 @@ static void rcu_do_batch(struct rcu_data *rdp)
  */
 void rcu_sched_clock_irq(int user)
 {
+	unsigned long j;
+
+	if (IS_ENABLED(CONFIG_PROVE_RCU)) {
+		j = jiffies;
+		WARN_ON_ONCE(time_before(j, __this_cpu_read(rcu_data.last_sched_clock)));
+		__this_cpu_write(rcu_data.last_sched_clock, j);
+	}
 	trace_rcu_utilization(TPS("Start scheduler-tick"));
 	lockdep_assert_irqs_disabled();
 	raw_cpu_inc(rcu_data.ticks_this_gp);
@@ -4179,6 +4188,7 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->rcu_ofl_gp_flags = RCU_GP_CLEANED;
 	rdp->rcu_onl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_onl_gp_flags = RCU_GP_CLEANED;
+	rdp->last_sched_clock = jiffies;
 	rdp->cpu = cpu;
 	rcu_boot_init_nocb_percpu_data(rdp);
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 926673ebe355..94b55f669915 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -254,6 +254,7 @@ struct rcu_data {
 	unsigned long rcu_onl_gp_seq;	/* ->gp_seq at last online. */
 	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
 	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
+	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
 
 	int cpu;
 };
-- 
2.31.1.189.g2e36527f23

