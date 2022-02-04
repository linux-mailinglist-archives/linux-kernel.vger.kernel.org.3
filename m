Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075A04AA473
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378326AbiBDXjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47876 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378227AbiBDXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4363861CA5;
        Fri,  4 Feb 2022 23:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C816C340F7;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=obmVj21+RsUzmU/ireCGRzvyfnAIEu2kyxPtUNQcgrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fiafyUABsd2JMhYSjdMT4N3MAImrf2mwmsXwQ277A6JkUM+N3rIBoI0tUj59mbncL
         ycf+7vfcNr2yFLNKocKX8q9loV2Vibgl/UuXPP9P1aVaO8wEL/37zDoJbENm/j1eqE
         rjgMfFI6EerYy6slvhcyajTUgb2IyVPRDoV4KOw/FE4k84tPqILnNizJuTBwDxEqEn
         lguY+eNABrLSG0jmLgqjDbYiz6sXg2QeI50IESgE9DZP788EFx8DNJoBO507HqXvxK
         AP0BguYIaxseZpKs+FBtj6YSuzU9AadMxvxakGd48x36YUrqp5y1vA0Z3qWhnfgUbM
         tXUWbXKCO2juw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F1BF35C0A0A; Fri,  4 Feb 2022 15:39:03 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/19] srcu: Add size-state transitioning code
Date:   Fri,  4 Feb 2022 15:38:49 -0800
Message-Id: <20220204233902.1902-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just dead code at the moment, but it serves to prevent
spurious compiler warnings about init_srcu_struct_nodes() being unused.
This function will once again be used once the state-transition code
is activated.

Because srcu_barrier() must be aware of transition before call_srcu(), the
state machine waits for an SRCU grace period before callbacks are queued
to the non-CPU-0 queues.  This requres that portions of srcu_barrier()
be enclosed in an SRCU read-side critical section.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2bbe8a5d9ae86..fce041b648ee3 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -202,7 +202,6 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	if (!ssp->sda)
 		return -ENOMEM;
 	init_srcu_struct_data(ssp);
-	WARN_ON_ONCE(!init_srcu_struct_nodes(ssp));
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
@@ -555,6 +554,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	unsigned long mask;
 	struct srcu_data *sdp;
 	struct srcu_node *snp;
+	int ss_state;
 
 	/* Prevent more than one additional grace period. */
 	mutex_lock(&ssp->srcu_cb_mutex);
@@ -622,6 +622,15 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	} else {
 		spin_unlock_irq_rcu_node(ssp);
 	}
+
+	/* Transition to big if needed. */
+	ss_state = smp_load_acquire(&ssp->srcu_size_state);
+	if (ss_state && ss_state != SRCU_SIZE_BIG) {
+		if (ss_state == SRCU_SIZE_ALLOC)
+			init_srcu_struct_nodes(ssp);
+		else
+			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
+	}
 }
 
 /*
@@ -1172,6 +1181,7 @@ static void srcu_barrier_one_cpu(struct srcu_struct *ssp, struct srcu_data *sdp)
 void srcu_barrier(struct srcu_struct *ssp)
 {
 	int cpu;
+	int idx;
 	unsigned long s = rcu_seq_snap(&ssp->srcu_barrier_seq);
 
 	check_init_srcu_struct(ssp);
@@ -1187,11 +1197,13 @@ void srcu_barrier(struct srcu_struct *ssp)
 	/* Initial count prevents reaching zero until all CBs are posted. */
 	atomic_set(&ssp->srcu_barrier_cpu_cnt, 1);
 
+	idx = srcu_read_lock(ssp);
 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
 		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
 	else
 		for_each_possible_cpu(cpu)
 			srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, cpu));
+	srcu_read_unlock(ssp, idx);
 
 	/* Remove the initial count, at which point reaching zero can happen. */
 	if (atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt))
-- 
2.31.1.189.g2e36527f23

