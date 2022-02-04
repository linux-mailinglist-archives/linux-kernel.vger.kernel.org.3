Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821224AA47C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378493AbiBDXjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39388 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378244AbiBDXjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E157FB83975;
        Fri,  4 Feb 2022 23:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613EBC340FA;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=nCSQipMnQYydZIPhraT+nyb+OMvwqOwj8Ix07rY+kdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4kMvhyl60zgrjHY7bYaZtCXznXyENURYnxdfo4Er+bbyIqpdDzOkXxfeI4JpwQPW
         KJl4ENf/51ixYVgXIZTplwD/9BHycOcQyaDOuC5dB/4XNsiTZQ+WI7Oaper4Txa5IM
         k3ey1mAC8ScItixP4B8b2+qzEHeFt7bUD+Go3mycKbZFIm3UFhmdIzJbeBy+JvIdvr
         YkXLYLP9TcXFOyBg/rXxLyisuEuIh5Bne1e9EbUYDhwnxwX3Ms3lhnmeoYGFA3/Kli
         Mrro8Ve7XfLNlHo8R1t5LuzxPuPh9trnzqVq2v+ZAXCsS2Z1H92A+J6o3a4buiforZ
         ivT/3RDF/96FQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0166B5C0A6A; Fri,  4 Feb 2022 15:39:03 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/19] srcu: Add boot-time control over srcu_node array allocation
Date:   Fri,  4 Feb 2022 15:38:51 -0800
Message-Id: <20220204233902.1902-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds an srcu_tree.convert_to_big kernel parameter that either
refuses to convert at all (0), converts immediately at init_srcu_struct()
time (1), or lets rcutorture convert it (2).  An addition contention-based
dynamic convertion choice will be added, along with documentation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 550991cc213d3..d1f1ff930acf5 100644
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
@@ -113,7 +122,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
  * Allocated and initialize SRCU combining tree.  Returns @true if
  * allocation succeeded and @false otherwise.
  */
-static bool init_srcu_struct_nodes(struct srcu_struct *ssp)
+static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 {
 	int cpu;
 	int i;
@@ -125,7 +134,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp)
 
 	/* Initialize geometry if it has not already been initialized. */
 	rcu_init_geometry();
-	ssp->node = kcalloc(rcu_num_nodes, sizeof(*ssp->node), GFP_ATOMIC);
+	ssp->node = kcalloc(rcu_num_nodes, sizeof(*ssp->node), gfp_flags);
 	if (!ssp->node)
 		return false;
 
@@ -204,6 +213,16 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	init_srcu_struct_data(ssp);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
+	if (READ_ONCE(ssp->srcu_size_state) == SRCU_SIZE_SMALL && convert_to_big == 1) {
+		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
+			if (!is_static) {
+				free_percpu(ssp->sda);
+				ssp->sda = NULL;
+			}
+			return -ENOMEM;
+		}
+		WRITE_ONCE(ssp->srcu_size_state, SRCU_SIZE_BIG);
+	}
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
 	return 0;
 }
@@ -627,7 +646,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
 	if (ss_state && ss_state != SRCU_SIZE_BIG) {
 		if (ss_state == SRCU_SIZE_ALLOC)
-			init_srcu_struct_nodes(ssp);
+			init_srcu_struct_nodes(ssp, GFP_KERNEL);
 		else
 			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
 	}
@@ -1456,6 +1475,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		s1 += c1;
 	}
 	pr_cont(" T(%ld,%ld)\n", s0, s1);
+	if (READ_ONCE(ssp->srcu_size_state) == SRCU_SIZE_SMALL && convert_to_big == 2)
+		WRITE_ONCE(ssp->srcu_size_state, SRCU_SIZE_ALLOC);
 }
 EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
 
-- 
2.31.1.189.g2e36527f23

