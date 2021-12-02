Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA5D465B15
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354710AbhLBAmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:42:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56530 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354677AbhLBAmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 603F6CE207F;
        Thu,  2 Dec 2021 00:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8385BC53FCF;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405540;
        bh=8OeDS52a6ctoWKw3JYv2z4ftGp7Pzsr8VaUZ67zwcY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X517URQFr+Ay90kdrWM0/WoZamIJWgQ04l3V2dGZqHHNCzdoGBt0l1QvlX+KqY7cC
         7u6kg9IGINFfSJZyty5vJ0XqhRxKlcps+aIWJkjTodjfUMLBCG+ysoD8DPSi+UyOH/
         yY9O0XmXEhoCj33bz08zwsHRjaRE4U8PF0OETv0OhUL1nlCie+OXl4UL//H1hVAxFs
         YKzNYog8b2Hy8ZiTKGOsotNtXP+JTVX4q51WFd8sX98xmuMmgQkgMdYPv+g8M2opbR
         T82K33kGmxx7+Fo0Fb90Vow5NoYA5wRslgK5w8WhggozCH2/6XMwtJB0RyP8ruokMZ
         mWdZdMrfJNCyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4A0A25C1109; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>, Martin Lau <kafai@fb.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 04/18] rcu-tasks: Convert grace-period counter to grace-period sequence number
Date:   Wed,  1 Dec 2021 16:38:44 -0800
Message-Id: <20211202003858.3129628-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit moves the rcu_tasks structure's ->n_gps grace-period-counter
field to a ->task_gp_seq grce-period sequence number in order to enable
use of the rcu_segcblist structure for the callback lists.  This in turn
permits CPUs to lag behind the RCU Tasks grace-period sequence number
without suffering long-term slowdowns in callback invocation.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2a5fe3e04b363..ed84d59b6dbfa 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -42,7 +42,7 @@ struct rcu_tasks_percpu {
  * @init_fract: Initial backoff sleep interval.
  * @gp_jiffies: Time of last @gp_state transition.
  * @gp_start: Most recent grace-period start in jiffies.
- * @n_gps: Number of grace periods completed since boot.
+ * @tasks_gp_seq: Number of grace periods completed since boot.
  * @n_ipis: Number of IPIs sent to encourage grace periods to end.
  * @n_ipis_fails: Number of IPI-send failures.
  * @pregp_func: This flavor's pre-grace-period function (optional).
@@ -64,7 +64,7 @@ struct rcu_tasks {
 	int init_fract;
 	unsigned long gp_jiffies;
 	unsigned long gp_start;
-	unsigned long n_gps;
+	unsigned long tasks_gp_seq;
 	unsigned long n_ipis;
 	unsigned long n_ipis_fails;
 	struct task_struct *kthread_ptr;
@@ -273,8 +273,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		// Wait for one grace period.
 		set_tasks_gp_state(rtp, RTGS_WAIT_GP);
 		rtp->gp_start = jiffies;
+		rcu_seq_start(&rtp->tasks_gp_seq);
 		rtp->gp_func(rtp);
-		rtp->n_gps++;
+		rcu_seq_end(&rtp->tasks_gp_seq);
 
 		/* Invoke the callbacks. */
 		set_tasks_gp_state(rtp, RTGS_INVOKE_CBS);
@@ -335,7 +336,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		rtp->kname,
 		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
 		jiffies - data_race(rtp->gp_jiffies),
-		data_race(rtp->n_gps),
+		data_race(rcu_seq_current(&rtp->tasks_gp_seq)),
 		data_race(rtp->n_ipis_fails), data_race(rtp->n_ipis),
 		".k"[!!data_race(rtp->kthread_ptr)],
 		".C"[!!data_race(rtpcp->cbs_head)],
-- 
2.31.1.189.g2e36527f23

