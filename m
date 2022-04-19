Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799F2506071
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiDSADe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiDSADA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:03:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A9F11C34;
        Mon, 18 Apr 2022 17:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A4A1B81106;
        Tue, 19 Apr 2022 00:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF45C385B5;
        Tue, 19 Apr 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326416;
        bh=hro1DWmXh+gkHoQfRvRaQ76L7LJUd/OIij5/KjJOEbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PONY76fFMgRSlbxeEpKhCEEWAgNfZrIZ0EiH98otJUgWntQxnrYMQWTUkErEDysSG
         NEGHtpJb8SCpy4tV/w6ZvF+RTDM/CxPqHKvug4L1dukt+nlRd8vC/cycVx20dA2tlQ
         HEL6MTbcwlXR+Ps2nRGWnnheMkr32MizHM0GpbaHrsWIKYycO+s7deXzHev9ara/VH
         lsiO4QlFEo8bzYcTE4IzolzYmfZkkfTsNmp4NU+poAP/HpPNePHZFTAI6YOyKbuoOP
         bdras8rBNjtZWMkOUghhWYpGQMbcoCRGC6B4ih/dRIFghjzePRxNTTRRokQm2UywoU
         xO6SysXc8UyEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E4DDD5C121E; Mon, 18 Apr 2022 17:00:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Eric Dumazet <edumazet@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 8/9] rcu-tasks: Handle sparse cpu_possible_mask
Date:   Mon, 18 Apr 2022 17:00:13 -0700
Message-Id: <20220419000014.3948512-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

If the rcupdate.rcu_task_enqueue_lim kernel boot parameter is set to
something greater than 1 and less than nr_cpu_ids, the code attempts to
use a subset of the CPU's RCU Tasks callback lists.  This works, but only
if the cpu_possible_mask is contiguous.  If there are "holes" in this
mask, the callback-enqueue code might attempt to access a non-existent
per-CPU ->rtcpu variable for a non-existent CPU.  For example, if only
CPUs 0, 4, 8, 12, 16 and so on are in cpu_possible_mask, specifying
rcupdate.rcu_task_enqueue_lim=4 would cause the code to attempt to
use callback queues for non-existent CPUs 1, 2, and 3.  Because such
systems have existed in the past and might still exist, the code needs
to gracefully handle this situation.

This commit therefore checks to see whether the desired CPU is present
in cpu_possible_mask, and, if not, searches for the next CPU.  This means
that the systems administrator of a system with a sparse cpu_possible_mask
will need to account for this sparsity when specifying the value of
the rcupdate.rcu_task_enqueue_lim kernel boot parameter.  For example,
setting this parameter to the value 4 will use only CPUs 0 and 4, which
CPU 4 getting three times the callback load of CPU 0.

This commit assumes that bit (nr_cpu_ids - 1) is always set in
cpu_possible_mask.

Link: https://lore.kernel.org/lkml/CANn89iKaNEwyNZ=L_PQnkH0LP_XjLYrr_dpyRKNNoDJaWKdrmg@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 3aad0dfbfaf4..fd70d86eb7cd 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -273,7 +273,9 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
 {
+	int chosen_cpu;
 	unsigned long flags;
+	int ideal_cpu;
 	unsigned long j;
 	bool needadjust = false;
 	bool needwake;
@@ -283,8 +285,9 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	rhp->func = func;
 	local_irq_save(flags);
 	rcu_read_lock();
-	rtpcp = per_cpu_ptr(rtp->rtpcpu,
-			    smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift));
+	ideal_cpu = smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift);
+	chosen_cpu = cpumask_next(ideal_cpu - 1, cpu_possible_mask);
+	rtpcp = per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
 	if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
 		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
 		j = jiffies;
-- 
2.31.1.189.g2e36527f23

