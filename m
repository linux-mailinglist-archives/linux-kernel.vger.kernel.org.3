Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4B506089
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiDSAG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbiDSAGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B24B24587;
        Mon, 18 Apr 2022 17:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7748F612CD;
        Tue, 19 Apr 2022 00:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077CFC385B8;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=Psh5an79Q919sHkZgWjtHptebmVck+c5jxmqmY+1jEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OoVe53oh1QG0zEnTs+2z83AKFY/CKJUBnttE74hz5WBbB4NMI9xfYGEXJaTOvzgxN
         04lt9i+xg/wCS9BLvPhnR47CSmjHXCSEJNgJw359HbCeWROH0Iz1oCjCzXb09jiTsv
         8P7EQPPsc0Vk4gHgmITtWkC4iW43eGycKZkbO6ldcuLFb3fhFjNAos3UZAutpTo3DD
         Y6dVq4C1G9yTNiX2mcPpRYANY1I13IrAG9C6YnRIa8brfVi1gvT/deIZK9YqB1DvN0
         DyMzPmMDl8fLUuDBXzkgLu8eWxZKL+kEYeyRVpY9AvZdYJlIsU7IdiOyKowQcAomRU
         k33O7K+hja5qQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 60E685C1355; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 11/21] srcu: Add boot-time control over srcu_node array allocation
Date:   Mon, 18 Apr 2022 17:03:12 -0700
Message-Id: <20220419000322.3948903-11-paulmck@kernel.org>
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

This commit adds an srcu_tree.convert_to_big kernel parameter that either
refuses to convert at all (0), converts immediately at init_srcu_struct()
time (1), or lets rcutorture convert it (2).  An addition contention-based
dynamic conversion choice will be added, along with documentation.

[ paulmck: Apply callback-scanning feedback from Neeraj Upadhyay. ]

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 13 +++++
 kernel/rcu/srcutree.c                         | 48 ++++++++++++-------
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..1f1fcac7777d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5608,6 +5608,19 @@
 			off:    Disable mitigation and remove
 				performance impact to RDRAND and RDSEED
 
+	srcutree.convert_to_big [KNL]
+			Specifies under what conditions an SRCU tree
+			srcu_struct structure will be converted to big
+			form, that is, with an rcu_node tree:
+
+				   0:  Never.
+				   1:  At init_srcu_struct() time.
+				   2:  When rcutorture decides to.
+
+			Either way, the srcu_node tree will be sized based
+			on the actual runtime number of CPUs (nr_cpu_ids)
+			instead of the compile-time CONFIG_NR_CPUS.
+
 	srcutree.counter_wrap_check [KNL]
 			Specifies how frequently to check for
 			grace-period sequence counter wrap for the
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2e7ed67646db..9dd048989027 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -39,6 +39,15 @@ module_param(exp_holdoff, ulong, 0444);
 static ulong counter_wrap_check = (ULONG_MAX >> 2);
 module_param(counter_wrap_check, ulong, 0444);
 
+/*
+ * Control conversion to SRCU_SIZE_BIG:
+ * 0: Don't convert at all (default).
+ * 1: Convert at init_srcu_struct() time.
+ * 2: Convert when rcutorture invokes srcu_torture_stats_print().
+ */
+static int convert_to_big;
+module_param(convert_to_big, int, 0444);
+
 /* Early-boot callback-management, so early that no lock is required! */
 static LIST_HEAD(srcu_boot_list);
 static bool __read_mostly srcu_init_done;
@@ -123,7 +132,7 @@ static inline bool srcu_invl_snp_seq(unsigned long s)
  * Allocated and initialize SRCU combining tree.  Returns @true if
  * allocation succeeded and @false otherwise.
  */
-static bool init_srcu_struct_nodes(struct srcu_struct *ssp)
+static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 {
 	int cpu;
 	int i;
@@ -135,7 +144,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp)
 
 	/* Initialize geometry if it has not already been initialized. */
 	rcu_init_geometry();
-	ssp->node = kcalloc(rcu_num_nodes, sizeof(*ssp->node), GFP_ATOMIC);
+	ssp->node = kcalloc(rcu_num_nodes, sizeof(*ssp->node), gfp_flags);
 	if (!ssp->node)
 		return false;
 
@@ -213,17 +222,19 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	if (!ssp->sda)
 		return -ENOMEM;
 	init_srcu_struct_data(ssp);
-	if (!init_srcu_struct_nodes(ssp)) {
-		if (!is_static) {
-			free_percpu(ssp->sda);
-			ssp->sda = NULL;
-			return -ENOMEM;
-		}
-	} else {
-		ssp->srcu_size_state = SRCU_SIZE_BIG;
-	}
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
+	if (READ_ONCE(ssp->srcu_size_state) == SRCU_SIZE_SMALL && convert_to_big == 1) {
+		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
+			if (!is_static) {
+				free_percpu(ssp->sda);
+				ssp->sda = NULL;
+				return -ENOMEM;
+			}
+		} else {
+			WRITE_ONCE(ssp->srcu_size_state, SRCU_SIZE_BIG);
+		}
+	}
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
 	return 0;
 }
@@ -594,7 +605,8 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	/* A new grace period can start at this point.  But only one. */
 
 	/* Initiate callback invocation as needed. */
-	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER) {
+	ss_state = smp_load_acquire(&ssp->srcu_size_state);
+	if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, 0), cbdelay);
 	} else {
 		idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
@@ -603,13 +615,16 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 			cbs = false;
 			last_lvl = snp >= ssp->level[rcu_num_lvls - 1];
 			if (last_lvl)
-				cbs = snp->srcu_have_cbs[idx] == gpseq;
+				cbs = ss_state < SRCU_SIZE_BIG || snp->srcu_have_cbs[idx] == gpseq;
 			snp->srcu_have_cbs[idx] = gpseq;
 			rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
 			sgsne = snp->srcu_gp_seq_needed_exp;
 			if (srcu_invl_snp_seq(sgsne) || ULONG_CMP_LT(sgsne, gpseq))
 				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
-			mask = snp->srcu_data_have_cbs[idx];
+			if (ss_state < SRCU_SIZE_BIG)
+				mask = ~0;
+			else
+				mask = snp->srcu_data_have_cbs[idx];
 			snp->srcu_data_have_cbs[idx] = 0;
 			spin_unlock_irq_rcu_node(snp);
 			if (cbs)
@@ -645,10 +660,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	}
 
 	/* Transition to big if needed. */
-	ss_state = smp_load_acquire(&ssp->srcu_size_state);
 	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
 		if (ss_state == SRCU_SIZE_ALLOC)
-			init_srcu_struct_nodes(ssp);
+			init_srcu_struct_nodes(ssp, GFP_KERNEL);
 		else
 			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
 	}
@@ -1494,6 +1508,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		s1 += c1;
 	}
 	pr_cont(" T(%ld,%ld)\n", s0, s1);
+	if (READ_ONCE(ssp->srcu_size_state) == SRCU_SIZE_SMALL && convert_to_big == 2)
+		WRITE_ONCE(ssp->srcu_size_state, SRCU_SIZE_ALLOC);
 }
 EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
 
-- 
2.31.1.189.g2e36527f23

