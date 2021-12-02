Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A6465B1A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354800AbhLBAnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354661AbhLBAms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48126C06175C;
        Wed,  1 Dec 2021 16:39:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 60774CE213A;
        Thu,  2 Dec 2021 00:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF1BC58321;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405540;
        bh=jodB1Ct+g1sN2XlmPcunsbFb5G67/ZwqPjHP2Cj0Iyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAKcIdVKLHHhs0dbFKNzCgTlgCcMlbWldQqJKRJFEIDqslPslC3GnvvcmN6sqLhSv
         uKSPD3bPeHSKxt/5JvkegIxaiD6e7A/OviS84O08vDYXog7w+qOoOP3XD4PhzJLlAQ
         HKWVlh2Vz25QhFPP9kc5E3dwN2qHbkOlO4KTFCdH5RUfw0Jxnu00mbFHiwwJG6qz6V
         LIw7z006gvlJJWxq9/FunavXw6SCnuTaNwUX9reh/Aq6Jock4icAfPvd53aYDh05ah
         8fTFOQHPJhv1sv/uIHTxdYlj89bpednrTDuJJ+ZDC6YcJoFH7P4wBdIg1ICgfPKDsh
         8IbHzOtvfmuMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 527ED5C1184; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
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
Subject: [PATCH rcu 08/18] rcu-tasks: Add a ->percpu_enqueue_lim to the rcu_tasks structure
Date:   Wed,  1 Dec 2021 16:38:48 -0800
Message-Id: <20211202003858.3129628-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a ->percpu_enqueue_lim field to the rcu_tasks structure.
This field contains two to the power of the ->percpu_enqueue_shift
field, easing construction of iterators over the per-CPU queues that
might contain RCU Tasks callbacks.  Such iterators will be introduced
in later commits.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b3d15600f4fe9..1c7cf8e8d65e7 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -52,6 +52,7 @@ struct rcu_tasks_percpu {
  * @call_func: This flavor's call_rcu()-equivalent function.
  * @rtpcpu: This flavor's rcu_tasks_percpu structure.
  * @percpu_enqueue_shift: Shift down CPU ID this much when enqueuing callbacks.
+ * @percpu_enqueue_lim: Number of per-CPU callback queues in use.
  * @name: This flavor's textual name.
  * @kname: This flavor's kthread name.
  */
@@ -76,6 +77,7 @@ struct rcu_tasks {
 	call_rcu_func_t call_func;
 	struct rcu_tasks_percpu __percpu *rtpcpu;
 	int percpu_enqueue_shift;
+	int percpu_enqueue_lim;
 	char *name;
 	char *kname;
 };
@@ -93,6 +95,7 @@ static struct rcu_tasks rt_name =							\
 	.rtpcpu = &rt_name ## __percpu,							\
 	.name = n,									\
 	.percpu_enqueue_shift = ilog2(CONFIG_NR_CPUS),					\
+	.percpu_enqueue_lim = 1,							\
 	.kname = #rt_name,								\
 }
 
@@ -172,6 +175,7 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 
 	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 	rtp->percpu_enqueue_shift = ilog2(nr_cpu_ids);
+	rtp->percpu_enqueue_lim = 1;
 	for_each_possible_cpu(cpu) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
-- 
2.31.1.189.g2e36527f23

