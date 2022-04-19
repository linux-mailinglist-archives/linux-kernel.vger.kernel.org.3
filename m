Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12985060BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiDSAPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiDSAPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AD66270;
        Mon, 18 Apr 2022 17:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 236D8612F5;
        Tue, 19 Apr 2022 00:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F23C385A7;
        Tue, 19 Apr 2022 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327154;
        bh=/KGm3woPMKoUdRNINf1MyDA2HggsH7OrZ0tAV7uCwSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XT/2vqa2VhPaXIhKkKkNsaCXxlvLktxWH+gNA7Ymrr7vto8Q2g98KAP+9UMInYX3N
         ivxIm8b+uuyd8hG8wAdOltHhzWZxymRKEC3DA7RpsSrWOBhjqXJkeCZ81XFocNtXIO
         UlFxq6ORJk/tJDjC796nRYmmmj9nvSeXwPOcfHNb2GVRLrP8D16B7/ulVXZzb2ZKxY
         3BxLnj7X8MyotFF3oQvRu4nB0O26l8CwwD/9kvMXXyCf9B1PKOC+QCpsTbwBXf2ppG
         b5SjXjcG/hw0rGl6lSWWlH3f1lDHCWCwJbXs2RPvy7iV5oTsD91K1+ujBAMZEB6d5b
         lFFhEjeZJEWhw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 434FE5C0848; Mon, 18 Apr 2022 17:12:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/12] rcutorture: Allow rcutorture without RCU Tasks Trace
Date:   Mon, 18 Apr 2022 17:12:24 -0700
Message-Id: <20220419001233.3950188-3-paulmck@kernel.org>
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
kernel is also built with CONFIG_TASKS_TRACE_RCU, whether anything else
needs Tasks Trace RCU or not.  This unnecessarily increases kernel size.
This commit therefore decouples the presence of rcutorture from the
presence of RCU Tasks Trace.

However, there is a need to select CONFIG_TASKS_TRACE_RCU for
testing purposes.  Except that casual users must not be bothered with
questions -- for them, this needs to be fully automated.  There is thus
a CONFIG_FORCE_TASKS_TRACE_RCU that selects CONFIG_TASKS_TRACE_RCU,
is user-selectable, but which depends on CONFIG_RCU_EXPERT.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig                            |  22 ++--
 kernel/rcu/Kconfig.debug                      |   1 -
 kernel/rcu/rcutorture.c                       | 101 ++++++++++--------
 .../selftests/rcutorture/configs/rcu/TRACE01  |   2 +
 .../selftests/rcutorture/configs/rcu/TRACE02  |   2 +
 5 files changed, 75 insertions(+), 53 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 4f665ae0cf55..2befd328e6a0 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -95,15 +95,23 @@ config TASKS_RUDE_RCU
 	  switches on all online CPUs, including idle ones, so use
 	  with caution.
 
-config TASKS_TRACE_RCU
-	def_bool 0
-	select IRQ_WORK
+config FORCE_TASKS_TRACE_RCU
+	bool "Force selection of Tasks Trace RCU"
+	depends on RCU_EXPERT
+	select TASKS_TRACE_RCU
+	default n
 	help
 	  This option enables a task-based RCU implementation that uses
 	  explicit rcu_read_lock_trace() read-side markers, and allows
-	  these readers to appear in the idle loop as well as on the CPU
-	  hotplug code paths.  It can force IPIs on online CPUs, including
-	  idle ones, so use with caution.
+	  these readers to appear in the idle loop as well as on the
+	  CPU hotplug code paths.  It can force IPIs on online CPUs,
+	  including idle ones, so use with caution.  Not for manual
+	  selection in most cases.
+
+config TASKS_TRACE_RCU
+	bool
+	default n
+	select IRQ_WORK
 
 config RCU_STALL_COMMON
 	def_bool TREE_RCU
@@ -227,7 +235,7 @@ config RCU_NOCB_CPU
 
 config TASKS_TRACE_RCU_READ_MB
 	bool "Tasks Trace RCU readers use memory barriers in user and idle"
-	depends on RCU_EXPERT
+	depends on RCU_EXPERT && TASKS_TRACE_RCU
 	default PREEMPT_RT || NR_CPUS < 8
 	help
 	  Use this option to further reduce the number of IPIs sent
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 4fd64999300f..d7f4bb1c4979 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -49,7 +49,6 @@ config RCU_TORTURE_TEST
 	select SRCU
 	select TASKS_RCU
 	select TASKS_RUDE_RCU
-	select TASKS_TRACE_RCU
 	default n
 	help
 	  This option provides a kernel module that runs torture tests
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 55d049c39608..7dd3e14ec907 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -737,6 +737,48 @@ static struct rcu_torture_ops busted_srcud_ops = {
 	.name		= "busted_srcud"
 };
 
+/*
+ * Definitions for trivial CONFIG_PREEMPT=n-only torture testing.
+ * This implementation does not necessarily work well with CPU hotplug.
+ */
+
+static void synchronize_rcu_trivial(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		rcutorture_sched_setaffinity(current->pid, cpumask_of(cpu));
+		WARN_ON_ONCE(raw_smp_processor_id() != cpu);
+	}
+}
+
+static int rcu_torture_read_lock_trivial(void) __acquires(RCU)
+{
+	preempt_disable();
+	return 0;
+}
+
+static void rcu_torture_read_unlock_trivial(int idx) __releases(RCU)
+{
+	preempt_enable();
+}
+
+static struct rcu_torture_ops trivial_ops = {
+	.ttype		= RCU_TRIVIAL_FLAVOR,
+	.init		= rcu_sync_torture_init,
+	.readlock	= rcu_torture_read_lock_trivial,
+	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
+	.readunlock	= rcu_torture_read_unlock_trivial,
+	.readlock_held	= torture_readlock_not_held,
+	.get_gp_seq	= rcu_no_completed,
+	.sync		= synchronize_rcu_trivial,
+	.exp_sync	= synchronize_rcu_trivial,
+	.fqs		= NULL,
+	.stats		= NULL,
+	.irq_capable	= 1,
+	.name		= "trivial"
+};
+
 /*
  * Definitions for RCU-tasks torture testing.
  */
@@ -780,48 +822,6 @@ static struct rcu_torture_ops tasks_ops = {
 	.name		= "tasks"
 };
 
-/*
- * Definitions for trivial CONFIG_PREEMPT=n-only torture testing.
- * This implementation does not necessarily work well with CPU hotplug.
- */
-
-static void synchronize_rcu_trivial(void)
-{
-	int cpu;
-
-	for_each_online_cpu(cpu) {
-		rcutorture_sched_setaffinity(current->pid, cpumask_of(cpu));
-		WARN_ON_ONCE(raw_smp_processor_id() != cpu);
-	}
-}
-
-static int rcu_torture_read_lock_trivial(void) __acquires(RCU)
-{
-	preempt_disable();
-	return 0;
-}
-
-static void rcu_torture_read_unlock_trivial(int idx) __releases(RCU)
-{
-	preempt_enable();
-}
-
-static struct rcu_torture_ops trivial_ops = {
-	.ttype		= RCU_TRIVIAL_FLAVOR,
-	.init		= rcu_sync_torture_init,
-	.readlock	= rcu_torture_read_lock_trivial,
-	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
-	.readunlock	= rcu_torture_read_unlock_trivial,
-	.readlock_held	= torture_readlock_not_held,
-	.get_gp_seq	= rcu_no_completed,
-	.sync		= synchronize_rcu_trivial,
-	.exp_sync	= synchronize_rcu_trivial,
-	.fqs		= NULL,
-	.stats		= NULL,
-	.irq_capable	= 1,
-	.name		= "trivial"
-};
-
 /*
  * Definitions for rude RCU-tasks torture testing.
  */
@@ -851,6 +851,8 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.name		= "tasks-rude"
 };
 
+#ifdef CONFIG_TASKS_TRACE_RCU
+
 /*
  * Definitions for tracing RCU-tasks torture testing.
  */
@@ -893,6 +895,15 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.name		= "tasks-tracing"
 };
 
+#define TASKS_TRACING_OPS &tasks_tracing_ops,
+
+#else // #ifdef CONFIG_TASKS_TRACE_RCU
+
+#define TASKS_TRACING_OPS
+
+#endif // #else #ifdef CONFIG_TASKS_TRACE_RCU
+
+
 static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -3096,9 +3107,9 @@ rcu_torture_init(void)
 	int flags = 0;
 	unsigned long gp_seq = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
-		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
-		&busted_srcud_ops, &tasks_ops, &tasks_rude_ops,
-		&tasks_tracing_ops, &trivial_ops,
+		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops, &busted_srcud_ops,
+		&tasks_ops, &tasks_rude_ops, TASKS_TRACING_OPS
+		&trivial_ops,
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
index e4d74e5fc1d0..0f5605ed1e48 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -7,5 +7,7 @@ CONFIG_PREEMPT=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
 #CHECK#CONFIG_PROVE_RCU=n
+CONFIG_FORCE_TASKS_TRACE_RCU=y
+#CHECK#CONFIG_TASKS_TRACE_RCU=y
 CONFIG_TASKS_TRACE_RCU_READ_MB=y
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
index 77541eeb4e9f..093ea6e8e65c 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
@@ -7,5 +7,7 @@ CONFIG_PREEMPT=y
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 #CHECK#CONFIG_PROVE_RCU=y
+CONFIG_FORCE_TASKS_TRACE_RCU=y
+#CHECK#CONFIG_TASKS_TRACE_RCU=y
 CONFIG_TASKS_TRACE_RCU_READ_MB=n
 CONFIG_RCU_EXPERT=y
-- 
2.31.1.189.g2e36527f23

