Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1AD5060CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbiDSAQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbiDSAPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:15:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EA56270;
        Mon, 18 Apr 2022 17:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 231B1B81147;
        Tue, 19 Apr 2022 00:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE153C385BA;
        Tue, 19 Apr 2022 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327155;
        bh=pqVBJLArsUCu6jcB2vZXpYu39RA6AAzwyfONBnpqGeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+a6FyelgvXm4XSTSvvsKNEAISI/hvpvpf6fqb9Ja1vESpQBTNe57Ka4BBsAWm6zp
         W7Wc6T30VL04QpyZCI0r2v4INuk75Cuvuj5U61/qWlDG69TWsrO/06UDdFXUKchsPz
         ttKG07hCGQw4mCfJRvBv/ZDNzER30Hr7ohTNu7BqLAflcITW3+ogiyczXV+cAWZKKR
         z+N+xONAdN2b5o2BOqREltQMxPmU88b8TqhPuIzKRXKLxf8jCXoeZROUof3W5YE7xE
         749KjlDzTPB/rxtGJltU7ZlUfJyU39o0OvKW5h2meRvvOQWROQLQN2cLr7BX3lrs2y
         8Oul2JHF+wEmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 508635C1308; Mon, 18 Apr 2022 17:12:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/12] rcuscale: Allow rcuscale without RCU Tasks
Date:   Mon, 18 Apr 2022 17:12:31 -0700
Message-Id: <20220419001233.3950188-10-paulmck@kernel.org>
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
RCU Tasks.  Unless that kernel builds rcuscale, whether built-in or as
a module, in which case RCU Tasks is (unnecessarily) built.  This both
increases kernel size and increases the complexity of certain tracing
operations.  This commit therefore decouples the presence of rcuscale
from the presence of RCU Tasks.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug                             |  1 -
 kernel/rcu/rcuscale.c                                | 12 +++++++++++-
 .../selftests/rcutorture/configs/rcuscale/CFcommon   |  4 ++--
 .../selftests/rcutorture/configs/rcuscale/TREE       |  2 ++
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index dceaa3e754e5..71e73fceff87 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -28,7 +28,6 @@ config RCU_SCALE_TEST
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
 	select SRCU
-	select TASKS_RCU
 	select TASKS_RUDE_RCU
 	select TASKS_TRACE_RCU
 	default n
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 5e4f1f83d38e..311dbcb064ed 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -268,6 +268,8 @@ static struct rcu_scale_ops srcud_ops = {
 	.name		= "srcud"
 };
 
+#ifdef CONFIG_TASKS_RCU
+
 /*
  * Definitions for RCU-tasks scalability testing.
  */
@@ -295,6 +297,14 @@ static struct rcu_scale_ops tasks_ops = {
 	.name		= "tasks"
 };
 
+#define TASKS_OPS &tasks_ops,
+
+#else // #ifdef CONFIG_TASKS_RCU
+
+#define TASKS_OPS
+
+#endif // #else // #ifdef CONFIG_TASKS_RCU
+
 /*
  * Definitions for RCU-tasks-trace scalability testing.
  */
@@ -797,7 +807,7 @@ rcu_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops, &tasks_tracing_ops
+		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS &tasks_tracing_ops
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
index 90942bb5bebc..2ed3b46a9c37 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
@@ -1,5 +1,5 @@
 CONFIG_RCU_SCALE_TEST=y
 CONFIG_PRINTK_TIME=y
 CONFIG_TASKS_RCU_GENERIC=y
-CONFIG_TASKS_RCU=y
-CONFIG_TASKS_TRACE_RCU=y
+CONFIG_FORCE_TASKS_RCU=y
+#CHECK#CONFIG_TASKS_RCU=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
index f110d9ffbe4c..b10706fd03a4 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
@@ -16,3 +16,5 @@ CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_TRACE=y
+CONFIG_KPROBES=n
+CONFIG_FTRACE=n
-- 
2.31.1.189.g2e36527f23

