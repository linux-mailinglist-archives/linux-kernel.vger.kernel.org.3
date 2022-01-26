Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56049D61E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiAZXV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:21:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38040 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiAZXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:21:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 735C7B81CB2;
        Wed, 26 Jan 2022 23:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B928C340E3;
        Wed, 26 Jan 2022 23:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643239286;
        bh=iqapeJgJ5YlsdhFseiX2dCW2b4j4K81Kg2TlrT7VEFU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=t9tVajRKuc+LbsZzptxHnVPQcDtumYEP5XJVL8R5SDmdnHets3l42HSDDf/pMLf0A
         miH4AwpduXA0r9A1AEbnXAJ2mVGzO9/FHgd36Y32CURQ6y3BzAzu0kN9QY8O6ktrqG
         WWXF+tFLtGO6UKdtL5fmFs2n0veDczdXp0PklTwbq3w81Xxqm9PBbVtKw/s3B4SO35
         ZCl771yopIDi7O0u86ifPOVgMeGpAmrpF8W1eJJJFojrR82XQr3F36xzluKYeb3i5h
         qG6FzhppPb49sDHS1A6EGvoQfCWODFl9dEpr8dSzjEFAdm22Tz20+LpK8vqTu207oW
         OK2sr5J3h/tOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C41625C043B; Wed, 26 Jan 2022 15:21:25 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:21:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrii.nakryiko@gmail.com,
        kafai@fb.com, neeraj.iitr10@gmail.com
Subject: [PATCH] rcu-tasks: Fix computation of CPU-to-list shift counts
Message-ID: <20220126232125.GA4087920@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ->percpu_enqueue_shift field is used to map from the running CPU
number to the index of the corresponding callback list.  This mapping
can change at runtime in response to varying callback load, resulting
in varying levels of contention on the callback-list locks.

Unfortunately, the initial value of this field is correct only if the
system happens to have a power-of-two number of CPUs, otherwise the
callbacks from the high-numbered CPUs can be placed into the callback list
indexed by 1 (rather than 0), and those index-1 callbacks will be ignored.
This can result in soft lockups and hangs.

This commit therefore corrects this mapping, adding one to this shift
count as needed for systems having odd numbers of CPUs.

Fixes: 7a30871b6a27 ("rcu-tasks: Introduce ->percpu_enqueue_shift for dynamic queue selection")
Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 84f1d91604cc2..d64f0b1d8cd3b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -123,7 +123,7 @@ static struct rcu_tasks rt_name =							\
 	.call_func = call,								\
 	.rtpcpu = &rt_name ## __percpu,							\
 	.name = n,									\
-	.percpu_enqueue_shift = ilog2(CONFIG_NR_CPUS),					\
+	.percpu_enqueue_shift = ilog2(CONFIG_NR_CPUS) + 1,				\
 	.percpu_enqueue_lim = 1,							\
 	.percpu_dequeue_lim = 1,							\
 	.barrier_q_mutex = __MUTEX_INITIALIZER(rt_name.barrier_q_mutex),		\
@@ -216,6 +216,7 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	int cpu;
 	unsigned long flags;
 	int lim;
+	int shift;
 
 	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 	if (rcu_task_enqueue_lim < 0) {
@@ -229,7 +230,10 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 
 	if (lim > nr_cpu_ids)
 		lim = nr_cpu_ids;
-	WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids / lim));
+	shift = ilog2(nr_cpu_ids / lim);
+	if (((nr_cpu_ids - 1) >> shift) >= lim)
+		shift++;
+	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
 	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
 	smp_store_release(&rtp->percpu_enqueue_lim, lim);
 	for_each_possible_cpu(cpu) {
@@ -298,7 +302,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	if (unlikely(needadjust)) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
-			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids));
+			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids) + 1);
 			WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
 			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
 			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
@@ -413,7 +417,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim > 1) {
-			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids));
+			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids) + 1);
 			smp_store_release(&rtp->percpu_enqueue_lim, 1);
 			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
 			pr_info("Starting switch %s to CPU-0 callback queuing.\n", rtp->name);
