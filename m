Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01834AA47D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378507AbiBDXjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378259AbiBDXjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC101E025B38;
        Fri,  4 Feb 2022 15:39:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 609EEB83907;
        Fri,  4 Feb 2022 23:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6A9C340EF;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=221MY6qzRj/ZNQOo8A/J8gIIMZFreoPNXKFxD592S9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jYLUlJ/hVFOcHTJMUyYKrPMXjifFCArym2p/WIl6HUltxLWc1jDx7KP8fqG9uYao0
         qAV3EQmZchihYALL5wXdBG1Q9LAn6Lo242o2jEDIvRGd5RS2eBIo8xJWtJEfO0Y1w9
         iUPWYhokK178NcmyWOKoK6kK6gVpAr+ll3544kqBM/si1cRDQUqeEjo2VVQRvSosG8
         Jhw8qDaf8V8fzOLXPyZ3YGSDe4jNFhzQw7PnmiUbYGHXlqYYX/U6Yk52JBov23W9YD
         vy5MERi1LmqmZIckYPo9QqV0Qk7aWDemNHhhLZijBE8imaXr/y7/72NwpoFj8PQ6nR
         Q1H/XjWuBbp/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EDB1E5C08DD; Fri,  4 Feb 2022 15:39:03 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/19] srcu: Dynamically allocate srcu_node array
Date:   Fri,  4 Feb 2022 15:38:47 -0800
Message-Id: <20220204233902.1902-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit shrinks the srcu_struct structure by converting its ->node
field from a fixed-size compile-time array to a pointer to a dynamically
allocated array.  In kernels built with large values of NR_CPUS that boot
on systems with smaller numbers of CPUs, this can save significant memory.

[ paulmck: Apply kernel test robot feedback. ]

Reported-by: A cast of thousands
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  2 +-
 kernel/rcu/srcutree.c    | 58 ++++++++++++++++++++++++++++++----------
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 4025840ba9a38..f7190058fb8ab 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -60,7 +60,7 @@ struct srcu_node {
  * Per-SRCU-domain structure, similar in function to rcu_state.
  */
 struct srcu_struct {
-	struct srcu_node node[NUM_RCU_NODES];	/* Combining tree. */
+	struct srcu_node *node;			/* Combining tree. */
 	struct srcu_node *level[RCU_NUM_LVLS + 1];
 						/* First node at each level. */
 	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7d13e35e5d277..eaf00c354a631 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -24,6 +24,7 @@
 #include <linux/smp.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/srcu.h>
 
 #include "rcu.h"
@@ -75,12 +76,44 @@ do {									\
 	spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags)	\
 
 /*
- * Initialize SRCU combining tree.  Note that statically allocated
+ * Initialize SRCU per-CPU data.  Note that statically allocated
  * srcu_struct structures might already have srcu_read_lock() and
  * srcu_read_unlock() running against them.  So if the is_static parameter
  * is set, don't initialize ->srcu_lock_count[] and ->srcu_unlock_count[].
+ *
+ * Returns @true if allocation succeeded and @false otherwise.
+ */
+static void init_srcu_struct_data(struct srcu_struct *ssp)
+{
+	int cpu;
+	struct srcu_data *sdp;
+
+	/*
+	 * Initialize the per-CPU srcu_data array, which feeds into the
+	 * leaves of the srcu_node tree.
+	 */
+	WARN_ON_ONCE(ARRAY_SIZE(sdp->srcu_lock_count) !=
+		     ARRAY_SIZE(sdp->srcu_unlock_count));
+	for_each_possible_cpu(cpu) {
+		sdp = per_cpu_ptr(ssp->sda, cpu);
+		spin_lock_init(&ACCESS_PRIVATE(sdp, lock));
+		rcu_segcblist_init(&sdp->srcu_cblist);
+		sdp->srcu_cblist_invoking = false;
+		sdp->srcu_gp_seq_needed = ssp->srcu_gp_seq;
+		sdp->srcu_gp_seq_needed_exp = ssp->srcu_gp_seq;
+		sdp->mynode = NULL;
+		sdp->cpu = cpu;
+		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
+		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
+		sdp->ssp = ssp;
+	}
+}
+
+/*
+ * Allocated and initialize SRCU combining tree.  Returns @true if
+ * allocation succeeded and @false otherwise.
  */
-static void init_srcu_struct_nodes(struct srcu_struct *ssp)
+static bool init_srcu_struct_nodes(struct srcu_struct *ssp)
 {
 	int cpu;
 	int i;
@@ -92,6 +125,9 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp)
 
 	/* Initialize geometry if it has not already been initialized. */
 	rcu_init_geometry();
+	ssp->node = kcalloc(rcu_num_nodes, sizeof(*ssp->node), GFP_ATOMIC);
+	if (!ssp->node)
+		return false;
 
 	/* Work out the overall tree geometry. */
 	ssp->level[0] = &ssp->node[0];
@@ -129,29 +165,19 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp)
 	 * Initialize the per-CPU srcu_data array, which feeds into the
 	 * leaves of the srcu_node tree.
 	 */
-	WARN_ON_ONCE(ARRAY_SIZE(sdp->srcu_lock_count) !=
-		     ARRAY_SIZE(sdp->srcu_unlock_count));
 	level = rcu_num_lvls - 1;
 	snp_first = ssp->level[level];
 	for_each_possible_cpu(cpu) {
 		sdp = per_cpu_ptr(ssp->sda, cpu);
-		spin_lock_init(&ACCESS_PRIVATE(sdp, lock));
-		rcu_segcblist_init(&sdp->srcu_cblist);
-		sdp->srcu_cblist_invoking = false;
-		sdp->srcu_gp_seq_needed = ssp->srcu_gp_seq;
-		sdp->srcu_gp_seq_needed_exp = ssp->srcu_gp_seq;
 		sdp->mynode = &snp_first[cpu / levelspread[level]];
 		for (snp = sdp->mynode; snp != NULL; snp = snp->srcu_parent) {
 			if (snp->grplo < 0)
 				snp->grplo = cpu;
 			snp->grphi = cpu;
 		}
-		sdp->cpu = cpu;
-		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
-		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
-		sdp->ssp = ssp;
 		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
 	}
+	return true;
 }
 
 /*
@@ -162,6 +188,7 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp)
  */
 static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 {
+	ssp->node = NULL;
 	mutex_init(&ssp->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_gp_mutex);
 	ssp->srcu_idx = 0;
@@ -174,7 +201,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
 	if (!ssp->sda)
 		return -ENOMEM;
-	init_srcu_struct_nodes(ssp);
+	init_srcu_struct_data(ssp);
+	WARN_ON_ONCE(!init_srcu_struct_nodes(ssp));
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
@@ -391,6 +419,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	}
 	free_percpu(ssp->sda);
 	ssp->sda = NULL;
+	kfree(ssp->node);
+	ssp->node = NULL;
 }
 EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
 
-- 
2.31.1.189.g2e36527f23

