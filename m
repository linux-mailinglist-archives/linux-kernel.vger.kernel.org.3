Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43018465A81
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245356AbhLBAPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:15:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51124 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354059AbhLBAOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:14:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87C4EB82197;
        Thu,  2 Dec 2021 00:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327C7C53FCC;
        Thu,  2 Dec 2021 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403842;
        bh=5TYCLAwIABxtbsG9WJfQdwgF+kOkSrUlqTan43tTDj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1xcW2Hfd++8ndDA46n9k/m6pt4DBjQjjzx7/VW/GciC2KeqQjgY0UWi1JdPLenyE
         KiHzuCIdrFpqtcmtJ/wKRh/ns9OA/mqKPOwKZyf8pG0Le9ALGd769UlsU3bE5Zqe5Q
         nIkHyo8zaGM0C5RP1vQ7jL5QzuSJzkWYs7tq2omY73n5/tLAiAWEyYLp0xvyTck9Pw
         lkcfOq7xgM17npJgkHoXygwbE28uR/Rf99pc1Xto4NxkFvNeQLO294OxS1TpuZU2DE
         KU92U/prMufbkm1flRkh7NFyJyxsmRmkF6bc/OpODGU2sASDJ/njASgGtkPTgC++ho
         Vw8dW4VxUiXIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ED2EF5C1107; Wed,  1 Dec 2021 16:10:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/7] rcu: Ignore rdp.cpu_no_qs.b.exp on preemptible RCU's rcu_qs()
Date:   Wed,  1 Dec 2021 16:10:34 -0800
Message-Id: <20211202001040.3126390-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
References: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Preemptible RCU does not use the rcu_data structure's ->cpu_no_qs.b.exp,
instead using a separate ->exp_deferred_qs field to record the need for
an expedited quiescent state.

In fact ->cpu_no_qs.b.exp should never be set in preemptible RCU because
preemptible RCU's expedited grace periods use other mechanisms to record
quiescent states.

This commit therefore removes the implicit rcu_qs() reference to
->cpu_no_qs.b.exp in favor of a direct reference to ->cpu_no_qs.b.norm.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5199559fbbf0c..983619ba86656 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -277,12 +277,16 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
  * current task, there might be any number of other tasks blocked while
  * in an RCU read-side critical section.
  *
+ * Unlike non-preemptible-RCU, quiescent state reports for expedited
+ * grace periods are handled seperately via deferred quiescent states
+ * and context switch events.
+ *
  * Callers to this function must disable preemption.
  */
 static void rcu_qs(void)
 {
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_qs() invoked with preemption enabled!!!\n");
-	if (__this_cpu_read(rcu_data.cpu_no_qs.s)) {
+	if (__this_cpu_read(rcu_data.cpu_no_qs.b.norm)) {
 		trace_rcu_grace_period(TPS("rcu_preempt"),
 				       __this_cpu_read(rcu_data.gp_seq),
 				       TPS("cpuqs"));
-- 
2.31.1.189.g2e36527f23

