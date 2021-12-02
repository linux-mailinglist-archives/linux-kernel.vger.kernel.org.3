Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEBD465B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354892AbhLBAoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354686AbhLBAms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE1BC061761;
        Wed,  1 Dec 2021 16:39:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01BD9B821A8;
        Thu,  2 Dec 2021 00:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01928C5832D;
        Thu,  2 Dec 2021 00:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405541;
        bh=+IFt9OFSW3Ctl8+D1e3VoGj6xA5HF/KHuA7Kpb5z/ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j79KlzmukAs6Xuty5yRcvIFAraxdXB0XwmgFkM5fIQLEQjMyS3udWKTl3Jg/C02iU
         amxZAkhGYDcQidEkKQDjEtw/ygTejdjxsZnzIuHVJHGpg6G9dMHf9iQhf3l3MAkfjM
         474DH/+5nkFT2GybsRkrTZRi8X+Ld0TLuMsIdR3gKZ84HGW6vpOe12NdluXkxyLlNN
         nY8SWDzIB2f2pRjfBEyZ7S/YM2BY8EBokNzvm2XEP8y0O4v1rYT2Z4VAn1hwnkfyKg
         IMtyNke7ellwCFIMb3P8PoOCHQBvqAGJMoA9fXRo0BOq+v3osEr0XYRt7ZoFZwPGSX
         8RtjTTv7u5Q3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D6075C1339; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
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
Subject: [PATCH rcu 14/18] rcu-tasks: Count trylocks to estimate call_rcu_tasks() contention
Date:   Wed,  1 Dec 2021 16:38:54 -0800
Message-Id: <20211202003858.3129628-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit converts the unconditional raw_spin_lock_rcu_node() lock
acquisition in call_rcu_tasks_generic() to a trylock followed by an
unconditional acquisition if the trylock fails.  If the trylock fails,
the failure is counted, but the count is reset to zero on each new jiffy.

This statistic will be used to determine when to move from a single
callback queue to per-CPU callback queues.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2b148f6743150..3f25022a0db9a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -24,6 +24,8 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * struct rcu_tasks_percpu - Per-CPU component of definition for a Tasks-RCU-like mechanism.
  * @cblist: Callback list.
  * @lock: Lock protecting per-CPU callback list.
+ * @rtp_jiffies: Jiffies counter value for statistics.
+ * @rtp_n_lock_retries: Rough lock-contention statistic.
  * @rtp_work: Work queue for invoking callbacks.
  * @barrier_q_head: RCU callback for barrier operation.
  * @cpu: CPU number corresponding to this entry.
@@ -32,6 +34,8 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
 struct rcu_tasks_percpu {
 	struct rcu_segcblist cblist;
 	raw_spinlock_t __private lock;
+	unsigned long rtp_jiffies;
+	unsigned long rtp_n_lock_retries;
 	struct work_struct rtp_work;
 	struct rcu_head barrier_q_head;
 	int cpu;
@@ -231,6 +235,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
 {
 	unsigned long flags;
+	unsigned long j;
 	bool needwake;
 	struct rcu_tasks_percpu *rtpcp;
 
@@ -239,7 +244,15 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	local_irq_save(flags);
 	rtpcp = per_cpu_ptr(rtp->rtpcpu,
 			    smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift));
-	raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
+	if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
+		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
+		j = jiffies;
+		if (rtpcp->rtp_jiffies != j) {
+			rtpcp->rtp_jiffies = j;
+			rtpcp->rtp_n_lock_retries = 0;
+		}
+		rtpcp->rtp_n_lock_retries++;
+	}
 	if (!rcu_segcblist_is_enabled(&rtpcp->cblist)) {
 		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
 		cblist_init_generic(rtp);
-- 
2.31.1.189.g2e36527f23

