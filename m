Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BD05060C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbiDSAPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiDSAPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:15:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2857C62FC;
        Mon, 18 Apr 2022 17:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DED64B81135;
        Tue, 19 Apr 2022 00:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B6FC385A9;
        Tue, 19 Apr 2022 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327154;
        bh=WZmVN7GeHqfeQOk38ep5RPyTvpafwXCMcALoe+PH4zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WH9H+jMVUBE1sq5R7EFXfqt0MN+i0B7aU1rCCnw3zeOaHI9QRSzeV9EQd14S0Owhd
         Xw9mtumwT18d7e5FKvlQw9w3aGkQE1f4G6FSyv723yCGMb2ELdsIXBglFvUt7jwj/B
         qdwV1YqaGkeey7wSEkpkJ1EHbYQH9z4pNIiGd0AnroEPYQVN4WKKOZQAGxwhf+sqQe
         YZuCjKfScrkRpj2hGMDinjSkstfbmTLvJDDpoE5VM0XSG5Pv471HjisFl5xVVMnhE0
         AFV1MsHxKb8JV1xS8ygbyVODlW3Kf/dCTrQeeToCW+Z69Wl4JykvvCroUQ3AWfr9io
         I+o/T3zDAoKYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 477625C0A23; Mon, 18 Apr 2022 17:12:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/12] rcutorture: Allow rcutorture without RCU Tasks Rude
Date:   Mon, 18 Apr 2022 17:12:26 -0700
Message-Id: <20220419001233.3950188-5-paulmck@kernel.org>
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

Unless a kernel builds rcutorture, whether built-in or as a module, that
kernel is also built with CONFIG_TASKS_RUDE_RCU, whether anything else
needs Tasks Rude RCU or not.  This unnecessarily increases kernel size.
This commit therefore decouples the presence of rcutorture from the
presence of RCU Tasks Rude.

However, there is a need to select CONFIG_TASKS_RUDE_RCU for testing
purposes.  Except that casual users must not be bothered with
questions -- for them, this needs to be fully automated.  There is
thus a CONFIG_FORCE_TASKS_RUDE_RCU that selects CONFIG_TASKS_RUDE_RCU,
is user-selectable, but which depends on CONFIG_RCU_EXPERT.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig                            | 21 ++++++++++++-------
 kernel/rcu/Kconfig.debug                      |  1 -
 kernel/rcu/rcutorture.c                       | 13 +++++++++++-
 .../selftests/rcutorture/configs/rcu/RUDE01   |  2 ++
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 8eac165db09f..65d45c00fd1b 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -93,15 +93,22 @@ config TASKS_RCU
 	default n
 	select IRQ_WORK
 
+config FORCE_TASKS_RUDE_RCU
+	bool "Force selection of Tasks Rude RCU"
+	depends on RCU_EXPERT
+	select TASKS_RUDE_RCU
+	default n
+	help
+	  This option force-enables a task-based RCU implementation
+	  that uses only context switch (including preemption) and
+	  user-mode execution as quiescent states.  It forces IPIs and
+	  context switches on all online CPUs, including idle ones,
+	  so use with caution.	Not for manual selection in most cases.
+
 config TASKS_RUDE_RCU
-	def_bool 0
+	bool
+	default n
 	select IRQ_WORK
-	help
-	  This option enables a task-based RCU implementation that uses
-	  only context switch (including preemption) and user-mode
-	  execution as quiescent states.  It forces IPIs and context
-	  switches on all online CPUs, including idle ones, so use
-	  with caution.
 
 config FORCE_TASKS_TRACE_RCU
 	bool "Force selection of Tasks Trace RCU"
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index c217a5e655a4..f4a4468cbf03 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -47,7 +47,6 @@ config RCU_TORTURE_TEST
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
 	select SRCU
-	select TASKS_RUDE_RCU
 	default n
 	help
 	  This option provides a kernel module that runs torture tests
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 65d045ff9766..d528245108c2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -833,6 +833,8 @@ static struct rcu_torture_ops tasks_ops = {
 #endif // #else #ifdef CONFIG_TASKS_RCU
 
 
+#ifdef CONFIG_TASKS_RUDE_RCU
+
 /*
  * Definitions for rude RCU-tasks torture testing.
  */
@@ -862,6 +864,15 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.name		= "tasks-rude"
 };
 
+#define TASKS_RUDE_OPS &tasks_rude_ops,
+
+#else // #ifdef CONFIG_TASKS_RUDE_RCU
+
+#define TASKS_RUDE_OPS
+
+#endif // #else #ifdef CONFIG_TASKS_RUDE_RCU
+
+
 #ifdef CONFIG_TASKS_TRACE_RCU
 
 /*
@@ -3119,7 +3130,7 @@ rcu_torture_init(void)
 	unsigned long gp_seq = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops, &busted_srcud_ops,
-		TASKS_OPS &tasks_rude_ops, TASKS_TRACING_OPS
+		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
 		&trivial_ops,
 	};
 
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01 b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
index 7093422050f6..6fd6acb94518 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
@@ -8,3 +8,5 @@ CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 #CHECK#CONFIG_PROVE_RCU=y
 CONFIG_RCU_EXPERT=y
+CONFIG_FORCE_TASKS_RUDE_RCU=y
+#CHECK#CONFIG_TASKS_RUDE_RCU=y
-- 
2.31.1.189.g2e36527f23

