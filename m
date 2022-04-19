Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055C65060C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiDSAQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbiDSAPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:15:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8364162C8;
        Mon, 18 Apr 2022 17:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84F42B81142;
        Tue, 19 Apr 2022 00:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2413C385B5;
        Tue, 19 Apr 2022 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327154;
        bh=rOmY886vFXfAoWPa5wrvJiC006w6SDIbYNHbDT8v048=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2ocCyTUlhnNb9mhjZVeIueQTwPdrg+Z5+PDPlF85MWbNwIPRbsZttHYWBDjKpVC5
         Bqj7Ele6s1bBKxxvoi8Yq9v2WIs5JfYSEHPhvtq5v0TWLGqcIkRIHGvwlwAVBRvuMg
         CnOVuYYpvR8uLBqJa9qCAC+gTXg7Yfru8yeP5+ALn1owdtIsGsCrk+rLX7ImIO7+AZ
         DmSWG1GrnV+t39W3tWknF2eiVuq5wqSJPQwz7W3arNII5OKpEh4gICItqXpe8Nglm7
         aZC+Z67AfJY9gS6JdGR9H/b/7bNH/rR6119kq8CnJu1OWi2uVS3TBXslBfIGy+AlfK
         HaCK8pXlUj8Pg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 524B85C1355; Mon, 18 Apr 2022 17:12:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/12] rcuscale: Allow rcuscale without RCU Tasks Rude/Trace
Date:   Mon, 18 Apr 2022 17:12:32 -0700
Message-Id: <20220419001233.3950188-11-paulmck@kernel.org>
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
RCU Tasks Rude and RCU Tasks Trace.  Unless that kernel builds rcuscale,
whether built-in or as a module, in which case these RCU Tasks flavors are
(unnecessarily) built in.  This both increases kernel size and increases
the complexity of certain tracing operations.  This commit therefore
decouples the presence of rcuscale from the presence of RCU Tasks Rude
and RCU Tasks Trace.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug                             |  2 --
 kernel/rcu/rcuscale.c                                | 12 +++++++++++-
 .../selftests/rcutorture/configs/rcuscale/CFcommon   |  3 ++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 71e73fceff87..68092e1db64b 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -28,8 +28,6 @@ config RCU_SCALE_TEST
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
 	select SRCU
-	select TASKS_RUDE_RCU
-	select TASKS_TRACE_RCU
 	default n
 	help
 	  This option provides a kernel module that runs performance
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 311dbcb064ed..277a5bfb37d4 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -305,6 +305,8 @@ static struct rcu_scale_ops tasks_ops = {
 
 #endif // #else // #ifdef CONFIG_TASKS_RCU
 
+#ifdef CONFIG_TASKS_TRACE_RCU
+
 /*
  * Definitions for RCU-tasks-trace scalability testing.
  */
@@ -334,6 +336,14 @@ static struct rcu_scale_ops tasks_tracing_ops = {
 	.name		= "tasks-tracing"
 };
 
+#define TASKS_TRACING_OPS &tasks_tracing_ops,
+
+#else // #ifdef CONFIG_TASKS_TRACE_RCU
+
+#define TASKS_TRACING_OPS
+
+#endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
+
 static unsigned long rcuscale_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -807,7 +817,7 @@ rcu_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS &tasks_tracing_ops
+		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_TRACING_OPS
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
index 2ed3b46a9c37..6a00157bee5b 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
@@ -1,5 +1,6 @@
 CONFIG_RCU_SCALE_TEST=y
 CONFIG_PRINTK_TIME=y
-CONFIG_TASKS_RCU_GENERIC=y
 CONFIG_FORCE_TASKS_RCU=y
 #CHECK#CONFIG_TASKS_RCU=y
+CONFIG_FORCE_TASKS_TRACE_RCU=y
+#CHECK#CONFIG_TASKS_TRACE_RCU=y
-- 
2.31.1.189.g2e36527f23

