Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFCE465A9B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354231AbhLBAYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:24:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56360 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbhLBAYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:24:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 180E0B82199;
        Thu,  2 Dec 2021 00:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55E8C53FCD;
        Thu,  2 Dec 2021 00:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404456;
        bh=j/yruGReoUu66uud5qAGKXP7ISE/6BX3PdiqkKSbxJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbm6je0AS+6unmfJ9aIzbIB2aqfsJDG3IKvGxbmDryQiGwKQzdSYRWSgsisSxp/U0
         Qef4Sq31kjXFUr1OGznnuNzC7mS3yzuEuOj1tXaTalarKWkx+Fau66UahOJTsU9GSf
         b4aACKSl0+v8lGjRXRwsjlj224r6hejG8UO9AyNRnTn8bINb5p0YEG4W5JxcuQtrlH
         Mt8QQ7ip2AuiSsVoTTuRxmC0dLACkFev6YZwM05b+HdSZ45h56InmJupx3Yv3uz/9N
         yqSLDhnKHcbBLqDY4a6i1Fy1Y+02O9QfXNopZg+gcRqVTGNeHX5RmmtjuSrRiUim87
         aq1HSgEhFURHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 81E5A5C1108; Wed,  1 Dec 2021 16:20:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Changbin Du <changbin.du@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/6] rcu: in_irq() cleanup
Date:   Wed,  1 Dec 2021 16:20:51 -0800
Message-Id: <20211202002055.3127133-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

This commit replaces the obsolete and ambiguous macro in_irq() with its
shiny new in_hardirq() equivalent.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h  | 2 +-
 kernel/rcu/tree.c        | 2 +-
 kernel/rcu/tree_plugin.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 9be015305f9f9..858f4d429946d 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -85,7 +85,7 @@ static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
 static inline void rcu_irq_exit_check_preempt(void) { }
 #define rcu_is_idle_cpu(cpu) \
-	(is_idle_task(current) && !in_nmi() && !in_irq() && !in_serving_softirq())
+	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ef8d36f580fc3..f0f19dc7f19ec 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1467,7 +1467,7 @@ static void rcu_gp_kthread_wake(void)
 {
 	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
 
-	if ((current == t && !in_irq() && !in_serving_softirq()) ||
+	if ((current == t && !in_hardirq() && !in_serving_softirq()) ||
 	    !READ_ONCE(rcu_state.gp_flags) || !t)
 		return;
 	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5199559fbbf0c..599084c4c21fd 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -642,7 +642,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
 			    t->rcu_blocked_node);
 		// Need to defer quiescent state until everything is enabled.
-		if (use_softirq && (in_irq() || (expboost && !irqs_were_disabled))) {
+		if (use_softirq && (in_hardirq() || (expboost && !irqs_were_disabled))) {
 			// Using softirq, safe to awaken, and either the
 			// wakeup is free or there is either an expedited
 			// GP in flight or a potential need to deboost.
-- 
2.31.1.189.g2e36527f23

