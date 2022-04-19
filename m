Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206DF5060C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbiDSAPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiDSAPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF9562C8;
        Mon, 18 Apr 2022 17:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A61561324;
        Tue, 19 Apr 2022 00:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90780C385AB;
        Tue, 19 Apr 2022 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327154;
        bh=zt6bmVLyKYLFyGb7VqvGpBkVhR2fKUoDb3crLDBSYcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYkUPc5JXAxaIFRHAO7ssBTiQLCZvcYOyjqMt/a+XpNoceZps5boOIqugKQQHGHUe
         ZLuU3MGquMFXxHjsemSDB5xOju/y4Xek0sKR46hGiVGahJlXnySSJhQVZxm7fa+ggf
         XxDhQBHRdnWl4eN8w65xtc8khlPILpwiBB9l3BiBV2chbiZGdl3ZkwEsuH7DNQcECb
         PmO2M/VhLJw6yYDV3dA675g8yW+UBC7pwy8jrtqrIcNNzNumrXt7n2KnzoKheJZaQ+
         eY5pUk96AXsnuzgDWKnMQi3a4g55dFDHpy6LRYUi2Q+kdXMwxq4LyxCb42Sb3yUraS
         aFXDFhJSbKufA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 455645C0A0D; Mon, 18 Apr 2022 17:12:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/12] rcutorture: Allow rcutorture without RCU Tasks
Date:   Mon, 18 Apr 2022 17:12:25 -0700
Message-Id: <20220419001233.3950188-4-paulmck@kernel.org>
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
RCU Tasks.  Unless that kernel builds rcutorture, whether built-in or as
a module, in which case RCU Tasks is (unnecessarily) used.  This both
increases kernel size and increases the complexity of certain tracing
operations.  This commit therefore decouples the presence of rcutorture
from the presence of RCU Tasks.

However, there is a need to select CONFIG_TASKS_RCU for testing purposes.
Except that casual users must not be bothered with questions -- for them,
this needs to be fully automated.  There is thus a CONFIG_FORCE_TASKS_RCU
that selects CONFIG_TASKS_RCU, is user-selectable, but which depends
on CONFIG_RCU_EXPERT.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig                             | 18 +++++++++++++-----
 kernel/rcu/Kconfig.debug                       |  1 -
 kernel/rcu/rcutorture.c                        | 13 ++++++++++++-
 .../selftests/rcutorture/configs/rcu/TASKS01   |  1 +
 .../selftests/rcutorture/configs/rcu/TASKS02   |  3 +++
 .../selftests/rcutorture/configs/rcu/TASKS03   |  2 ++
 6 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 2befd328e6a0..8eac165db09f 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -77,13 +77,21 @@ config TASKS_RCU_GENERIC
 	  This option enables generic infrastructure code supporting
 	  task-based RCU implementations.  Not for manual selection.
 
+config FORCE_TASKS_RCU
+	bool "Force selection of TASKS_RCU"
+	depends on RCU_EXPERT
+	select TASKS_RCU
+	default n
+	help
+	  This option force-enables a task-based RCU implementation
+	  that uses only voluntary context switch (not preemption!),
+	  idle, and user-mode execution as quiescent states.  Not for
+	  manual selection in most cases.
+
 config TASKS_RCU
-	def_bool 0
+	bool
+	default n
 	select IRQ_WORK
-	help
-	  This option enables a task-based RCU implementation that uses
-	  only voluntary context switch (not preemption!), idle, and
-	  user-mode execution as quiescent states.  Not for manual selection.
 
 config TASKS_RUDE_RCU
 	def_bool 0
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index d7f4bb1c4979..c217a5e655a4 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -47,7 +47,6 @@ config RCU_TORTURE_TEST
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
 	select SRCU
-	select TASKS_RCU
 	select TASKS_RUDE_RCU
 	default n
 	help
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7dd3e14ec907..65d045ff9766 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -779,6 +779,8 @@ static struct rcu_torture_ops trivial_ops = {
 	.name		= "trivial"
 };
 
+#ifdef CONFIG_TASKS_RCU
+
 /*
  * Definitions for RCU-tasks torture testing.
  */
@@ -822,6 +824,15 @@ static struct rcu_torture_ops tasks_ops = {
 	.name		= "tasks"
 };
 
+#define TASKS_OPS &tasks_ops,
+
+#else // #ifdef CONFIG_TASKS_RCU
+
+#define TASKS_OPS
+
+#endif // #else #ifdef CONFIG_TASKS_RCU
+
+
 /*
  * Definitions for rude RCU-tasks torture testing.
  */
@@ -3108,7 +3119,7 @@ rcu_torture_init(void)
 	unsigned long gp_seq = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops, &busted_srcud_ops,
-		&tasks_ops, &tasks_rude_ops, TASKS_TRACING_OPS
+		TASKS_OPS &tasks_rude_ops, TASKS_TRACING_OPS
 		&trivial_ops,
 	};
 
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS01 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01
index 3ca112444ce7..d84801b9a7ae 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01
@@ -7,4 +7,5 @@ CONFIG_PREEMPT=y
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 #CHECK#CONFIG_PROVE_RCU=y
+CONFIG_TASKS_RCU=y
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS02 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
index ad2be91e5ee7..d333b69bc831 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
@@ -2,3 +2,6 @@ CONFIG_SMP=n
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+#CHECK#CONFIG_TASKS_RCU=y
+CONFIG_FORCE_TASKS_RCU=y
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS03 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
index dc02083803ce..dea26c568678 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
@@ -7,3 +7,5 @@ CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=n
 CONFIG_NO_HZ_FULL=y
 #CHECK#CONFIG_RCU_EXPERT=n
+CONFIG_TASKS_RCU=y
+CONFIG_RCU_EXPERT=y
-- 
2.31.1.189.g2e36527f23

