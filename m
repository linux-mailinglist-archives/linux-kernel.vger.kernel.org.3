Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A6E552750
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbiFTW4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344933AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41DE1F61E;
        Mon, 20 Jun 2022 15:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F1B2B81664;
        Mon, 20 Jun 2022 22:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E27C36AFC;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=UyE131rL2xaE5oTVS8u8RNE3yToEqA7bVrXlW/PwrqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlgpPFm7xnx4PJ8fe3bnvDX5IYOlzWyKl7VQgdcDV/GQNrmT+H5DGyPgAclL7u/tU
         QwGe6atXGTrzNWfPWqq0L97o068bbzFAUexnlLTKlwKKoby7GO+uKCiGl9zM3FQ20q
         ci+fjeA37+DXB35W2li776VI/7zLmmy7mYc4KG500yjVcnnOTFEQhU20TfnipcsNH/
         /OHLTFZJzqGxY2lrmLUAAk8Bbe+UH92uXLj75LaPPyHPUEPgBiJbxltPL0/tgEeyz6
         kIm41hwv16LO3qkcsE1WWnmkmP5rHWEGfs6mQmmXt4C2HyI7c0c6HokGCBhQEcXTMT
         Aih0grS4fkTlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4C6E15C11DB; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 19/32] rcu-tasks: Untrack blocked RCU Tasks Trace at reader end
Date:   Mon, 20 Jun 2022 15:53:58 -0700
Message-Id: <20220620225411.3842519-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
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

This commit causes rcu_read_unlock_trace() to check for the current
task being on a per-CPU list within the rcu_tasks_percpu structure,
and removes it from that list if so.  This has the effect of curtailing
tracking of a task that blocked within an RCU Tasks Trace read-side
critical section once it exits that critical section.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bab75ec26bdbb..eb87a759ef0b0 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1245,17 +1245,29 @@ EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
 /* If we are the last reader, wake up the grace-period kthread. */
 void rcu_read_unlock_trace_special(struct task_struct *t)
 {
-	int nqs = (rcu_ld_need_qs(t) == (TRC_NEED_QS_CHECKED | TRC_NEED_QS));
+	unsigned long flags;
+	struct rcu_tasks_percpu *rtpcp;
+	union rcu_special trs;
+
+	// Open-coded full-word version of rcu_ld_need_qs().
+	smp_mb(); // Enforce full grace-period ordering.
+	trs = smp_load_acquire(&t->trc_reader_special);
 
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) && t->trc_reader_special.b.need_mb)
 		smp_mb(); // Pairs with update-side barriers.
 	// Update .need_qs before ->trc_reader_nesting for irq/NMI handlers.
-	if (nqs) {
+	if (trs.b.need_qs == (TRC_NEED_QS_CHECKED | TRC_NEED_QS)) {
 		u8 result = rcu_trc_cmpxchg_need_qs(t, TRC_NEED_QS_CHECKED | TRC_NEED_QS,
 						       TRC_NEED_QS_CHECKED);
 
-		WARN_ONCE(result != (TRC_NEED_QS_CHECKED | TRC_NEED_QS),
-			  "%s: result = %d", __func__, result);
+		WARN_ONCE(result != trs.b.need_qs, "%s: result = %d", __func__, result);
+	}
+	if (trs.b.blocked) {
+		rtpcp = per_cpu_ptr(rcu_tasks_trace.rtpcpu, t->trc_blkd_cpu);
+		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+		list_del_init(&t->trc_blkd_node);
+		WRITE_ONCE(t->trc_reader_special.b.blocked, false);
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	}
 	WRITE_ONCE(t->trc_reader_nesting, 0);
 }
@@ -1274,7 +1286,7 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t)
 	if (!rtpcp->rtp_blkd_tasks.next)
 		INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
 	list_add(&t->trc_blkd_node, &rtpcp->rtp_blkd_tasks);
-	t->trc_reader_special.b.blocked = true;
+	WRITE_ONCE(t->trc_reader_special.b.blocked, true);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 }
 EXPORT_SYMBOL_GPL(rcu_tasks_trace_qs_blkd);
@@ -1608,7 +1620,7 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
 
 	rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
 	WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
-	if (WARN_ON_ONCE(rcu_ld_need_qs(t) & TRC_NEED_QS) || trs.b.blocked)
+	if (WARN_ON_ONCE(rcu_ld_need_qs(t) & TRC_NEED_QS || trs.b.blocked))
 		rcu_read_unlock_trace_special(t);
 	else
 		WRITE_ONCE(t->trc_reader_nesting, 0);
-- 
2.31.1.189.g2e36527f23

