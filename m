Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D274D54CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243019AbiCJWqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiCJWqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:46:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F5E96834
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:45:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B81861BC2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8CBC340E8;
        Thu, 10 Mar 2022 22:45:46 +0000 (UTC)
Date:   Thu, 10 Mar 2022 17:45:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [GIT PULL] tracing: minor fixes
Message-ID: <20220310174545.68e872fc@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Minor tracing fixes:

 - Fix unregistering the same event twice a the user could disable
   the event osnoise will disable on unregistering.

 - Inform RCU of a quiescent state in the osnoise testing thread.

 - Fix some kerneldoc comments.


Please pull the latest trace-v5.17-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.17-rc6

Tag SHA1: c61cf6d2e56a0cd22a9d95f2006e91e895b512a2
Head SHA1: 78cbc6513217b00be6a9904415ef7ff3619eb035


Daniel Bristot de Oliveira (1):
      tracing/osnoise: Do not unregister events twice

Jiapeng Chong (1):
      ftrace: Fix some W=1 warnings in kernel doc comments

Nicolas Saenz Julienne (1):
      tracing/osnoise: Force quiescent states while tracing

----
 kernel/trace/ftrace.c        |  4 ++--
 kernel/trace/trace_osnoise.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)
---------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a4b462b6f944..6105b7036482 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7790,7 +7790,7 @@ int ftrace_is_dead(void)
 
 /**
  * register_ftrace_function - register a function for profiling
- * @ops - ops structure that holds the function for profiling.
+ * @ops:	ops structure that holds the function for profiling.
  *
  * Register a function to be called by all functions in the
  * kernel.
@@ -7817,7 +7817,7 @@ EXPORT_SYMBOL_GPL(register_ftrace_function);
 
 /**
  * unregister_ftrace_function - unregister a function for profiling.
- * @ops - ops structure that holds the function to unregister
+ * @ops:	ops structure that holds the function to unregister
  *
  * Unregister a function that was added to be called by ftrace profiling.
  */
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index cfddb30e65ab..5e3c62a08fc0 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1386,6 +1386,26 @@ static int run_osnoise(void)
 					osnoise_stop_tracing();
 		}
 
+		/*
+		 * In some cases, notably when running on a nohz_full CPU with
+		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
+		 * This will eventually cause unwarranted noise as PREEMPT_RCU
+		 * will force preemption as the means of ending the current
+		 * grace period. We avoid this problem by calling
+		 * rcu_momentary_dyntick_idle(), which performs a zero duration
+		 * EQS allowing PREEMPT_RCU to end the current grace period.
+		 * This call shouldn't be wrapped inside an RCU critical
+		 * section.
+		 *
+		 * Note that in non PREEMPT_RCU kernels QSs are handled through
+		 * cond_resched()
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
+			local_irq_disable();
+			rcu_momentary_dyntick_idle();
+			local_irq_enable();
+		}
+
 		/*
 		 * For the non-preemptive kernel config: let threads runs, if
 		 * they so wish.
@@ -2200,6 +2220,17 @@ static void osnoise_workload_stop(void)
 	if (osnoise_has_registered_instances())
 		return;
 
+	/*
+	 * If callbacks were already disabled in a previous stop
+	 * call, there is no need to disable then again.
+	 *
+	 * For instance, this happens when tracing is stopped via:
+	 * echo 0 > tracing_on
+	 * echo nop > current_tracer.
+	 */
+	if (!trace_osnoise_callback_enabled)
+		return;
+
 	trace_osnoise_callback_enabled = false;
 	/*
 	 * Make sure that ftrace_nmi_enter/exit() see
