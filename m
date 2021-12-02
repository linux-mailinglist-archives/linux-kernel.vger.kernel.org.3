Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAAD465A7F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354225AbhLBAQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:16:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51148 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354097AbhLBAOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:14:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBEBFB821A0;
        Thu,  2 Dec 2021 00:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C358C53FCF;
        Thu,  2 Dec 2021 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403842;
        bh=3qLLC35EJz1YQ4w4ZQHW14DW8NSsxLzOY338PxueSQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eISd5aVuXeSPveFE8/vOM8QSGr0heZB+wE7W/JubjEbwUIf/61eWF5eC2Q7nQzm3x
         DjMoNf4T+naQuCLmWzSuLb5pUyFnynGW6teRYu/PTpyiE0tGTmTwtSBdlNfrhKRcHA
         zvveNBaSNcFf6O4hgIN5+QWjysWYpM/aQLbGAeYdWskrdpTnfk3bZJj4aSgHRrlY2i
         dS7iR2dp7AlUwXMYZlp3ZskIHUVui7rSJVAzDWsysbLpUmvMrlSrjfQatZB9HVhYOX
         723jlE3SP3pMNyC+FlJDXasGgXSL60AuSre5Uw5vmjSUdTUdx8fBYt+FbGXxVD+Cdz
         eqR47fJWvPdtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F08255C1108; Wed,  1 Dec 2021 16:10:41 -0800 (PST)
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
Subject: [PATCH rcu 2/7] rcu: Move rcu_data.cpu_no_qs.b.exp reset to rcu_export_exp_rdp()
Date:   Wed,  1 Dec 2021 16:10:35 -0800
Message-Id: <20211202001040.3126390-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
References: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

On non-preemptible RCU, move clearing of the rcu_data structure's
->cpu_no_qs.b.exp filed to the actual expedited quiescent state report
function, matching hw preemptible RCU handles the ->exp_deferred_qs field.

This prepares for removing ->exp_deferred_qs in favor of ->cpu_no_qs.b.exp
for both preemptible and non-preemptible RCU.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h    | 1 +
 kernel/rcu/tree_plugin.h | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index f3947c49eee71..6c6eb32203852 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -256,6 +256,7 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
 static void rcu_report_exp_rdp(struct rcu_data *rdp)
 {
 	WRITE_ONCE(rdp->exp_deferred_qs, false);
+	WRITE_ONCE(rdp->cpu_no_qs.b.exp, false);
 	rcu_report_exp_cpu_mult(rdp->mynode, rdp->grpmask, true);
 }
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 983619ba86656..1e4b4e7630735 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -849,10 +849,8 @@ static void rcu_qs(void)
 	trace_rcu_grace_period(TPS("rcu_sched"),
 			       __this_cpu_read(rcu_data.gp_seq), TPS("cpuqs"));
 	__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
-	if (!__this_cpu_read(rcu_data.cpu_no_qs.b.exp))
-		return;
-	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, false);
-	rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
+	if (__this_cpu_read(rcu_data.cpu_no_qs.b.exp))
+		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 }
 
 /*
-- 
2.31.1.189.g2e36527f23

