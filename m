Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40AD50607C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbiDSAG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbiDSAGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB6A23143;
        Mon, 18 Apr 2022 17:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11B4D612C6;
        Tue, 19 Apr 2022 00:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC98C385B1;
        Tue, 19 Apr 2022 00:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=2XAXZJ/M66oAiuzE8T3AY4xy86cvdJePw2OQPWXK+IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSrS2cqngvWALkLX5H8LTSfabjuqNIUZu3pLzaRndMucty2ZdP88wywHFBLsp1BJO
         NpkPBMPKM1y2aomWWkAoPCK0fG2lGqB9ScwWodg9Lrb7llhahhV1rVkIEKxLZirUEC
         qYrlkbcnIYzaIXXrmfBYJwp75IdOWdWfVVApxk/L2Y5uQNWMQhfUTEOiLv+r8Yi/gz
         bwI2weiBxMRvDt7YNdsqR9D2k4WCqoyW/84q83+rhlzMt3H9xZ/J+tEm1mTseoGJ7S
         rejOqKvKHCIp3RQNyWIVLDyZig95Un/tH5eXPb3I5KgIjUlaJUe52U+weyOK6yGSET
         aUOk6GMzZYN1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 57F665C0B86; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 06/21] srcu: Add size-state transitioning code
Date:   Mon, 18 Apr 2022 17:03:07 -0700
Message-Id: <20220419000322.3948903-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
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

This is just dead code at the moment, and will be used once
the state-transition code is activated.

Because srcu_barrier() must be aware of transition before call_srcu(), the
state machine waits for an SRCU grace period before callbacks are queued
to the non-CPU-0 queues.  This requres that portions of srcu_barrier()
be enclosed in an SRCU read-side critical section.

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e98cc218e42b..00f9aed6f7b9 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -562,6 +562,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	unsigned long mask;
 	struct srcu_data *sdp;
 	struct srcu_node *snp;
+	int ss_state;
 
 	/* Prevent more than one additional grace period. */
 	mutex_lock(&ssp->srcu_cb_mutex);
@@ -629,6 +630,15 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	} else {
 		spin_unlock_irq_rcu_node(ssp);
 	}
+
+	/* Transition to big if needed. */
+	ss_state = smp_load_acquire(&ssp->srcu_size_state);
+	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
+		if (ss_state == SRCU_SIZE_ALLOC)
+			init_srcu_struct_nodes(ssp);
+		else
+			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
+	}
 }
 
 /*
@@ -1178,6 +1188,7 @@ static void srcu_barrier_one_cpu(struct srcu_struct *ssp, struct srcu_data *sdp)
 void srcu_barrier(struct srcu_struct *ssp)
 {
 	int cpu;
+	int idx;
 	unsigned long s = rcu_seq_snap(&ssp->srcu_barrier_seq);
 
 	check_init_srcu_struct(ssp);
@@ -1193,11 +1204,13 @@ void srcu_barrier(struct srcu_struct *ssp)
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

