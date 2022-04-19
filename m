Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A075060C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiDSAPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbiDSAPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8803E62E3;
        Mon, 18 Apr 2022 17:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19D766132D;
        Tue, 19 Apr 2022 00:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1E4C385B9;
        Tue, 19 Apr 2022 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327155;
        bh=VklMWT+mv88bfnM3UygqdURL8zzoO8a57bNgatVnHuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbDzbYh7z1qGvyBcXZNWHiOAO+xw+fL9AUgOH+4UpRRNDrIUs7O95mmpf/H/Ims94
         xie35a5QAcMv9af1HEyjoMLJXhVcZyB3t5O88fat1+gpEh/Gx2fp3pUuec0rqRY6j1
         6GntmkL+XNPYJNIkFfS/TbGVbSdloUhdowpFQ3XJibHh+b/CSyx9suaCvJr3cqI/mI
         ZQBZRAXXrhjj6aJo3rsD0iYlokeq+jY91U4/b/xpR1Ca5Pij+dwabk1TqNa9vFFvSn
         Z+Aprd+8TLP7xCg7uUNlAhK4+A2uW1+GqWjNKz1Ct/RKQmShYBFHEslO54mevtN+wZ
         Sg26LnwcWObpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4ECFD5C12AB; Mon, 18 Apr 2022 17:12:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/12] refscale: Allow refscale without RCU Tasks Rude/Trace
Date:   Mon, 18 Apr 2022 17:12:30 -0700
Message-Id: <20220419001233.3950188-9-paulmck@kernel.org>
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
RCU Tasks Rude and RCU Tasks Trace.  Unless that kernel builds refscale,
whether built-in or as a module, in which case these RCU Tasks flavors are
(unnecessarily) built in.  This both increases kernel size and increases
the complexity of certain tracing operations.  This commit therefore
decouples the presence of refscale from the presence of RCU Tasks Rude
and RCU Tasks Trace.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug                             |  2 --
 kernel/rcu/refscale.c                                | 12 +++++++++++-
 .../selftests/rcutorture/configs/refscale/CFcommon   |  2 ++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 454924e03ef3..dceaa3e754e5 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -63,8 +63,6 @@ config RCU_REF_SCALE_TEST
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
 	select SRCU
-	select TASKS_RUDE_RCU
-	select TASKS_TRACE_RCU
 	default n
 	help
 	  This option provides a kernel module that runs performance tests
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 5079e47b3d18..909644abee67 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -242,6 +242,8 @@ static struct ref_scale_ops rcu_tasks_ops = {
 
 #endif // #else // #ifdef CONFIG_TASKS_RCU
 
+#ifdef CONFIG_TASKS_TRACE_RCU
+
 // Definitions for RCU Tasks Trace ref scale testing.
 static void rcu_trace_ref_scale_read_section(const int nloops)
 {
@@ -271,6 +273,14 @@ static struct ref_scale_ops rcu_trace_ops = {
 	.name		= "rcu-trace"
 };
 
+#define RCU_TRACE_OPS &rcu_trace_ops,
+
+#else // #ifdef CONFIG_TASKS_TRACE_RCU
+
+#define RCU_TRACE_OPS
+
+#endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
+
 // Definitions for reference count
 static atomic_t refcnt;
 
@@ -800,7 +810,7 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &rcu_trace_ops, RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
+		&rcu_ops, &srcu_ops, RCU_TRACE_OPS RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
 		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops,
 	};
 
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/CFcommon b/tools/testing/selftests/rcutorture/configs/refscale/CFcommon
index 14fdafc576ce..fbea3b13baba 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/refscale/CFcommon
@@ -2,3 +2,5 @@ CONFIG_RCU_REF_SCALE_TEST=y
 CONFIG_PRINTK_TIME=y
 CONFIG_FORCE_TASKS_RCU=y
 #CHECK#CONFIG_TASKS_RCU=y
+CONFIG_FORCE_TASKS_TRACE_RCU=y
+#CHECK#CONFIG_TASKS_TRACE_RCU=y
-- 
2.31.1.189.g2e36527f23

