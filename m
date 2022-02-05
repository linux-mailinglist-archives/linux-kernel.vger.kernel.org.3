Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E214C4AA500
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378762AbiBEAVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:21:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44278 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbiBEAVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:21:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B8BA61D25;
        Sat,  5 Feb 2022 00:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC7DC004E1;
        Sat,  5 Feb 2022 00:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644020508;
        bh=2h6+8txphk+PUkZRFHMP6b25H+QGMpukyMaM/xbMT5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouDB1lETMTAyOG6n11U6BZe4cHPj0nj/58hI4FxhN/hShzB6wdgB/6/aWlJDELrqB
         SvyA1W1H3g7T3bkYOEWXO6prR0O/Rjzg5MLo3r+aU4rqpuvhd5AhMv4Kr4HbNDlo2p
         pH4yu2/x1eJZ2xYIBrz+dAFJqWfysQl7e8L02sdeGXoxMWGU3HhlIGVh+50r+NPKJM
         ooIFZzJ5jebK7uERBPbAotEoPqJhbLehsvQfKwDRgILRZ5LN8/MfCGBlMDoyYyJxw8
         5XccrW/71sFU4n2RRbugB6o3uT0ses+4f1oA26kz+Bzl2WNu6/aBYyMOQZ3yOgdBpf
         qbi1UmU0BivTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B13CC5C0418; Fri,  4 Feb 2022 16:21:48 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 1/2] rcu-tasks: Use order_base_2() instead of ilog2()
Date:   Fri,  4 Feb 2022 16:21:46 -0800
Message-Id: <20220205002147.4828-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220205002113.GA4693@paulmck-ThinkPad-P17-Gen-1>
References: <20220205002113.GA4693@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ilog2() function can be used to generate a shift count, but it will
generate the same count for a power of two as for one greater than a power
of two.  This results in shift counts that are larger than necessary for
systems with a power-of-two number of CPUs because the CPUs are numbered
from zero, so that the maximum CPU number is one less than that power
of two.

This commit therefore substitutes order_base_2(), which appears to have
been designed for exactly this use case.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fb8c57fd70b8f..c0fc3641ef13a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -123,7 +123,7 @@ static struct rcu_tasks rt_name =							\
 	.call_func = call,								\
 	.rtpcpu = &rt_name ## __percpu,							\
 	.name = n,									\
-	.percpu_enqueue_shift = ilog2(CONFIG_NR_CPUS) + 1,				\
+	.percpu_enqueue_shift = order_base_2(CONFIG_NR_CPUS),				\
 	.percpu_enqueue_lim = 1,							\
 	.percpu_dequeue_lim = 1,							\
 	.barrier_q_mutex = __MUTEX_INITIALIZER(rt_name.barrier_q_mutex),		\
@@ -302,7 +302,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	if (unlikely(needadjust)) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
-			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids) + 1);
+			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(nr_cpu_ids));
 			WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
 			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
 			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
@@ -417,7 +417,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim > 1) {
-			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids) + 1);
+			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(nr_cpu_ids));
 			smp_store_release(&rtp->percpu_enqueue_lim, 1);
 			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
 			pr_info("Starting switch %s to CPU-0 callback queuing.\n", rtp->name);
-- 
2.31.1.189.g2e36527f23

