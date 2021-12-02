Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B25465B17
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354715AbhLBAnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354680AbhLBAm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DECC061757;
        Wed,  1 Dec 2021 16:39:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5B52FCE207A;
        Thu,  2 Dec 2021 00:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81539C53FAD;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405540;
        bh=g2AJF18QL/jB1Cgf9DLJpxuqSTHIH94B0ZI5SsV1Oww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVS+MlIXycbc4grrybWOEZPw5eaQSLk54Pa92lZlDlpvZp2xWklFK0czYSZPRpzZ1
         9hARckfTf4+vxnXHC5Di0aQo+1BR03nmDvFE5+hcDy3vgHJ2ktLcrJbsOsTUxWXuS6
         9xEP4tw+V1ouo/6ekzuowpiiFkuCAZUnS0+ZKx6dMts+MsYtmnGArXw02OOZB2TByy
         A0hw564RyjtPOGuCzpGTrSGiIQs6X/uRH0E5pEN4wI2mRQ9vzVqqgf0QjfNmQ3kVAq
         iPagex4pc5y/KVERz7Z2Dr4qomHuJSS2oupO32XVfINGryh/01VCrRGg8Q8fP8yhac
         BZoHzCF5KlazQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4809F5C1010; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
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
Subject: [PATCH rcu 03/18] rcu-tasks: Introduce ->percpu_enqueue_shift for dynamic queue selection
Date:   Wed,  1 Dec 2021 16:38:43 -0800
Message-Id: <20211202003858.3129628-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a ->percpu_enqueue_shift field to the rcu_tasks
structure, and uses it to shift down the CPU number in order to
select a rcu_tasks_percpu structure.  This field is currently set to a
sufficiently large shift count to always select the CPU-0 instance of
the rcu_tasks_percpu structure, and later commits will adjust this.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 30048db7aa49d..2a5fe3e04b363 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -52,6 +52,7 @@ struct rcu_tasks_percpu {
  * @postgp_func: This flavor's post-grace-period function (optional).
  * @call_func: This flavor's call_rcu()-equivalent function.
  * @rtpcpu: This flavor's rcu_tasks_percpu structure.
+ * @percpu_enqueue_shift: Shift down CPU ID this much when enqueuing callbacks.
  * @name: This flavor's textual name.
  * @kname: This flavor's kthread name.
  */
@@ -75,6 +76,7 @@ struct rcu_tasks {
 	postgp_func_t postgp_func;
 	call_rcu_func_t call_func;
 	struct rcu_tasks_percpu __percpu *rtpcpu;
+	int percpu_enqueue_shift;
 	char *name;
 	char *kname;
 };
@@ -91,6 +93,7 @@ static struct rcu_tasks rt_name =							\
 	.call_func = call,								\
 	.rtpcpu = &rt_name ## __percpu,							\
 	.name = n,									\
+	.percpu_enqueue_shift = ilog2(CONFIG_NR_CPUS),					\
 	.kname = #rt_name,								\
 }
 
@@ -169,6 +172,7 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
+	rtp->percpu_enqueue_shift = ilog2(nr_cpu_ids);
 	for_each_possible_cpu(cpu) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
@@ -195,7 +199,8 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	rhp->next = NULL;
 	rhp->func = func;
 	local_irq_save(flags);
-	rtpcp = per_cpu_ptr(rtp->rtpcpu, 0 /* smp_processor_id() */);
+	rtpcp = per_cpu_ptr(rtp->rtpcpu,
+			    smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift));
 	raw_spin_lock(&rtpcp->cbs_pcpu_lock);
 	if (!rtpcp->cbs_tail) {
 		raw_spin_unlock(&rtpcp->cbs_pcpu_lock); // irqs remain disabled.
-- 
2.31.1.189.g2e36527f23

