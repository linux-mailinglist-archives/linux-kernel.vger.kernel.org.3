Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3782552751
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345462AbiFTW4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344834AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F451EC67;
        Mon, 20 Jun 2022 15:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 850EE61483;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27199C341F0;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=ZQcJWLIdgwx6oT8P5GOxsn5kfGEH3xvA4D6Bf+j2JpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kTduJzSPgUneTqdbkCUu9devVOMSUUnx81AKOpx1qh9MRZ+9jVZBiFNB/EFB8/3A0
         nAYwZf6PLP16zT7tPfGEWcP6Pw2+q6sD37itjHECjWbi7+gvioGJWY4dSyYte6zy20
         jHCSi1eOr7zR3m6XLWGWhR9hdf2ScJZSxezwc+9Uxxx7wPoGsqwI5UtNAJnoPnaz0M
         1vMXwBxWpKcRbf50KpdD2JvEu0rcdDrHvl/7qrLFdguZH1sOrKbycReu89RjKftuW6
         se+x5kJuOD+Jmn5bPaQppidQFXffaLbnVppuPVpDgk+QQ/0D76GpOh+3F33tiPEjHJ
         5XHXoOd4JgjtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 561C05C147C; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 24/32] rcu-tasks: Pull in tasks blocked within RCU Tasks Trace readers
Date:   Mon, 20 Jun 2022 15:54:03 -0700
Message-Id: <20220620225411.3842519-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
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

This commit scans each CPU's ->rtp_blkd_tasks list, adding them to
the list of holdout tasks.  This will cause the current RCU Tasks Trace
grace period to wait until these tasks exit their RCU Tasks Trace
read-side critical sections.  This commit will enable later work
omitting the scan of the full task list.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a8f95864c921a..d318cdfd2309c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1492,7 +1492,11 @@ static void rcu_tasks_trace_pertask_handler(void *hop_in)
 /* Initialize for a new RCU-tasks-trace grace period. */
 static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 {
+	LIST_HEAD(blkd_tasks);
 	int cpu;
+	unsigned long flags;
+	struct rcu_tasks_percpu *rtpcp;
+	struct task_struct *t;
 
 	// There shouldn't be any old IPIs, but...
 	for_each_possible_cpu(cpu)
@@ -1506,6 +1510,26 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 	// allow safe access to the hop list.
 	for_each_online_cpu(cpu)
 		smp_call_function_single(cpu, rcu_tasks_trace_pertask_handler, hop, 1);
+
+	// Only after all running tasks have been accounted for is it
+	// safe to take care of the tasks that have blocked within their
+	// current RCU tasks trace read-side critical section.
+	for_each_possible_cpu(cpu) {
+		rtpcp = per_cpu_ptr(rcu_tasks_trace.rtpcpu, cpu);
+		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+		list_splice_init(&rtpcp->rtp_blkd_tasks, &blkd_tasks);
+		while (!list_empty(&blkd_tasks)) {
+			rcu_read_lock();
+			t = list_first_entry(&blkd_tasks, struct task_struct, trc_blkd_node);
+			list_del_init(&t->trc_blkd_node);
+			list_add(&t->trc_blkd_node, &rtpcp->rtp_blkd_tasks);
+			raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+			rcu_tasks_trace_pertask(t, hop);
+			rcu_read_unlock();
+			raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+		}
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	}
 }
 
 /*
-- 
2.31.1.189.g2e36527f23

