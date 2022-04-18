Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240CE505FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiDRW5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiDRW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB752CE38;
        Mon, 18 Apr 2022 15:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23995B8114A;
        Mon, 18 Apr 2022 22:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E87C385B4;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322441;
        bh=uhiwOIrk44qfnhD7O0vrwgQ+fBsOSHKHX5yQ0StUtJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0PVY37NJ/CMr5qudl02I2FfmOQw4uF6x8q94rBofcV3x8FmqaityrZORWq1kxu8+
         jOGtBQMGqNuKeQLPOTY+cUwNKH4UHv5a8P9QOuXiELinf4ZJNyAg3GKrokIa1+gopJ
         3kmkIFFwyWn2wfod+iV2ODQidTIc1PIUilJLAhFBPUERSGR1rgnLwDlbX4lurfhVMY
         dnrFI2VFnwHzhmtT4uXMJL7wM/IM7Z1jx59xsgLlcOMWpUM080ZWggf4xcujPlnyZZ
         imBYuI3fPMeVzxfZ+7Y4fuqZy+6OewxWqzDboxzhy8GvGnGmM/c8U3f2bGtwkQgOvb
         DknMQAaogHZ+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E8F0A5C0B86; Mon, 18 Apr 2022 15:54:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/11] rcu: Print number of online CPUs in RCU CPU stall-warning messages
Date:   Mon, 18 Apr 2022 15:53:54 -0700
Message-Id: <20220418225359.3945217-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
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

RCU's synchronous grace periods act quite differently when there is
only one online CPU, especially in the no-op case in kernels built with
CONFIG_PREEMPTION=n.  This change in behavior can be important debugging
information, so this commit adds the number of online CPUs to the RCU
CPU stall warning messages.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0c5d8516516a..268dd79c58e7 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -565,9 +565,9 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
-	pr_cont("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
+	pr_cont("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu ncpus=%d)\n",
 	       smp_processor_id(), (long)(jiffies - gps),
-	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
+	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_state.n_online_cpus);
 	if (ndetected) {
 		rcu_dump_cpu_stacks();
 
@@ -626,9 +626,9 @@ static void print_cpu_stall(unsigned long gps)
 	raw_spin_unlock_irqrestore_rcu_node(rdp->mynode, flags);
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
-	pr_cont("\t(t=%lu jiffies g=%ld q=%lu)\n",
+	pr_cont("\t(t=%lu jiffies g=%ld q=%lu ncpus=%d)\n",
 		jiffies - gps,
-		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
+		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_state.n_online_cpus);
 
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
-- 
2.31.1.189.g2e36527f23

