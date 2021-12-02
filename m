Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92818465A7A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354204AbhLBAP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354111AbhLBAOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:14:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5FC06174A;
        Wed,  1 Dec 2021 16:10:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7C553CE213E;
        Thu,  2 Dec 2021 00:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A1BC5674A;
        Thu,  2 Dec 2021 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403842;
        bh=9ToAU9/gJ63ssCOkJ8sGtuUntHaNH6UWBD+7VoQ7avM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TPs4E3D3CXCiL3cVfE5xj44n3My7SgDojc3QTSH9Ghi/DsswHnU6dczQDWG7YhBQy
         hBTJf0u7ngQ+FY3PihqiKf3yCbYWColF5lCxgpI0NXrnviG2FKFkxLkDk8tkTJWycW
         PV6xZOolRpnf+BGP9W1pQuVR2tBt21riCEpi9wQ+KJIl2VUq+a7KJpnW++3MAIRXRj
         VvEQ+IFF5Wpr0s3BRATO+CReD1sHtf8SJAEoP9ZCoxs6WqK2LzuihzjsTxhFl7Mim2
         Ao4r/4fUcAniwo/B4CILEQ5C6w5kZ0+K80wJMIpoauc7XzZmmOVfG1lzjv/uWIVEut
         VDyVj3lBqFEVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 048605C1184; Wed,  1 Dec 2021 16:10:42 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH rcu 6/7] rcu: Make idle entry report expedited quiescent states
Date:   Wed,  1 Dec 2021 16:10:39 -0800
Message-Id: <20211202001040.3126390-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
References: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In non-preemptible kernels, an unfortunately timed expedited grace period
can result in the rcu_exp_handler() IPI handler setting the rcu_data
structure's cpu_no_qs.b.exp field just as the target CPU enters idle.
There are situations in which this field will not be checked until after
that CPU exits idle.  The resulting grace-period latency does not qualify
as "expedited".

This commit therefore checks this field upon non-preemptible idle entry in
the rcu_preempt_deferred_qs() function.  It also qualifies the rcu_core()
preempt_count() check with IS_ENABLED(CONFIG_PREEMPT_COUNT) to prevent
false-positive quiescent states from count-free kernels.

Reported-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        |  2 +-
 kernel/rcu/tree_plugin.h | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ef8d36f580fc3..a8d1fe35f4820 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2714,7 +2714,7 @@ static __latent_entropy void rcu_core(void)
 	WARN_ON_ONCE(!rdp->beenonline);
 
 	/* Report any deferred quiescent states if preemption enabled. */
-	if (!(preempt_count() & PREEMPT_MASK)) {
+	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK))) {
 		rcu_preempt_deferred_qs(current);
 	} else if (rcu_preempt_need_deferred_qs(current)) {
 		set_tsk_need_resched(current);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 972acb114ce3c..6d715575226f0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -927,7 +927,18 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return false;
 }
-static void rcu_preempt_deferred_qs(struct task_struct *t) { }
+
+// Except that we do need to respond to a request by an expedited grace
+// period for a quiescent state from this CPU.  Note that requests from
+// tasks are handled when removing the task from the blocked-tasks list
+// below.
+static void rcu_preempt_deferred_qs(struct task_struct *t)
+{
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+
+	if (rdp->cpu_no_qs.b.exp)
+		rcu_report_exp_rdp(rdp);
+}
 
 /*
  * Because there is no preemptible RCU, there can be no readers blocked,
-- 
2.31.1.189.g2e36527f23

