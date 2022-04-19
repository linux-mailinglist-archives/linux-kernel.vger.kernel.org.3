Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC23F5060C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbiDSAQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbiDSAPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:15:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB8D635E;
        Mon, 18 Apr 2022 17:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83A3BB81141;
        Tue, 19 Apr 2022 00:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E211AC385B6;
        Tue, 19 Apr 2022 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327154;
        bh=qC/8biKRDyHkszmI/BmXVyaSO1zhCekOg4OHImxLUkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEquUf0TxJHlL9AY5plQdOlJJAeY1K/0EVhkwLxoYfvL91gP5e2AespyAdSO016Ox
         6k2YTbDd7hSmoNIGuB18MIaFyEdy37mbxLrN0+CI56SDv0p3Vtd0extH9gFiLxW+z5
         wNavYmx0rqQwX5ybtLzkmiL/rQZq9CLFU4qMQOK8gjs+fZ7yTUBelcR8+Lf/y+xw/4
         oODjkRtnIRIKxUCSEmUe5gAADnswhhWv0lwElLwooNcH2LV9QDDU8wQcQgp7Zg83o9
         cxwSu0WE9d/uucY3lPJt4DDr8rK9cX0wpjof3vZqZ7ABXvVsY3Mp0R8k8s1HQP0YRW
         bXJDPsxDzOJrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4D15D5C121E; Mon, 18 Apr 2022 17:12:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/12] refscale: Allow refscale without RCU Tasks
Date:   Mon, 18 Apr 2022 17:12:29 -0700
Message-Id: <20220419001233.3950188-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
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

Currently, a CONFIG_PREEMPT_NONE=y kernel substitutes normal RCU for
RCU Tasks.  Unless that kernel builds refscale, whether built-in or as a
module, in which case RCU Tasks is (unnecessarily) built in.  This both
increases kernel size and increases the complexity of certain tracing
operations.  This commit therefore decouples the presence of refscale
from the presence of RCU Tasks.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug                             |  1 -
 kernel/rcu/refscale.c                                | 12 +++++++++++-
 .../selftests/rcutorture/configs/refscale/CFcommon   |  2 ++
 .../selftests/rcutorture/configs/refscale/NOPREEMPT  |  2 ++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index f4a4468cbf03..454924e03ef3 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -63,7 +63,6 @@ config RCU_REF_SCALE_TEST
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
 	select SRCU
-	select TASKS_RCU
 	select TASKS_RUDE_RCU
 	select TASKS_TRACE_RCU
 	default n
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 5489ff7f478e..5079e47b3d18 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -207,6 +207,8 @@ static struct ref_scale_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+#ifdef CONFIG_TASKS_RCU
+
 // Definitions for RCU Tasks ref scale testing: Empty read markers.
 // These definitions also work for RCU Rude readers.
 static void rcu_tasks_ref_scale_read_section(const int nloops)
@@ -232,6 +234,14 @@ static struct ref_scale_ops rcu_tasks_ops = {
 	.name		= "rcu-tasks"
 };
 
+#define RCU_TASKS_OPS &rcu_tasks_ops,
+
+#else // #ifdef CONFIG_TASKS_RCU
+
+#define RCU_TASKS_OPS
+
+#endif // #else // #ifdef CONFIG_TASKS_RCU
+
 // Definitions for RCU Tasks Trace ref scale testing.
 static void rcu_trace_ref_scale_read_section(const int nloops)
 {
@@ -790,7 +800,7 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops, &refcnt_ops, &rwlock_ops,
+		&rcu_ops, &srcu_ops, &rcu_trace_ops, RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
 		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops,
 	};
 
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/CFcommon b/tools/testing/selftests/rcutorture/configs/refscale/CFcommon
index a98b58b54bb1..14fdafc576ce 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/refscale/CFcommon
@@ -1,2 +1,4 @@
 CONFIG_RCU_REF_SCALE_TEST=y
 CONFIG_PRINTK_TIME=y
+CONFIG_FORCE_TASKS_RCU=y
+#CHECK#CONFIG_TASKS_RCU=y
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
index 7f06838a91e6..ef2b501a6971 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
@@ -15,3 +15,5 @@ CONFIG_PROVE_LOCKING=n
 CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
+CONFIG_KPROBES=n
+CONFIG_FTRACE=n
-- 
2.31.1.189.g2e36527f23

