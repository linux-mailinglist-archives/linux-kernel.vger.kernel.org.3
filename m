Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305AB557E44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiFWOwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiFWOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:52:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596D347544;
        Thu, 23 Jun 2022 07:52:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0E26421D31;
        Thu, 23 Jun 2022 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655995928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34HHikX/AClB8jYcbwvL75WHNaWEIiOYWsDSOA18SjQ=;
        b=s/I4vSF+v/5N0rqed4TEPyF2mDk6ryenf+EV9la+sgN6pKz6RVf0j78i9U7c2WcKP3eFr9
        Uyw4cRIRVlMn3Y5doKvmLfLZ4mEncrREwkQeVIl7vbPtAeybd3Ve4iCiSkYDwUY5+ZhlTK
        DoVdkOcWoSap8fp9hs2jFaxuXDBJdRc=
Received: from alley.suse.cz (unknown [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id F2DDC2C142;
        Thu, 23 Jun 2022 14:52:06 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Marco Elver <elver@google.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, dave@stgolabs.net,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        frederic@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] Revert "printk: add functions to prefer direct printing"
Date:   Thu, 23 Jun 2022 16:51:57 +0200
Message-Id: <20220623145157.21938-7-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220623145157.21938-1-pmladek@suse.com>
References: <20220623145157.21938-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2bb2b7b57f81255c13f4395ea911d6bdc70c9fe2.

The testing of 5.19 release candidates revealed missing synchronization
between early and regular console functionality.

It would be possible to start the console kthreads later as a workaround.
But it is clear that console lock serialized console drivers between
each other. It opens a big area of possible problems that were not
considered by people involved in the development and review.

printk() is crucial for debugging kernel issues and console output is
very important part of it. The number of consoles is huge and a proper
review would take some time. As a result it need to be reverted for 5.19.

Link: https://lore.kernel.org/r/YrBdjVwBOVgLfHyb@alley
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/sysrq.c     |  2 --
 include/linux/printk.h  | 11 -----------
 kernel/hung_task.c      | 11 +----------
 kernel/panic.c          |  4 ----
 kernel/printk/printk.c  | 28 ----------------------------
 kernel/rcu/tree_stall.h |  2 --
 kernel/reboot.c         | 14 +-------------
 kernel/watchdog.c       |  4 ----
 kernel/watchdog_hld.c   |  4 ----
 9 files changed, 2 insertions(+), 78 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 18e623325887..d2b2720db6ca 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -581,7 +581,6 @@ void __handle_sysrq(int key, bool check_mask)
 
 	rcu_sysrq_start();
 	rcu_read_lock();
-	printk_prefer_direct_enter();
 	/*
 	 * Raise the apparent loglevel to maximum so that the sysrq header
 	 * is shown to provide the user with positive feedback.  We do not
@@ -623,7 +622,6 @@ void __handle_sysrq(int key, bool check_mask)
 		pr_cont("\n");
 		console_loglevel = orig_log_level;
 	}
-	printk_prefer_direct_exit();
 	rcu_read_unlock();
 	rcu_sysrq_end();
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 10ec29bc0135..cf7d666ab1f8 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -169,9 +169,6 @@ extern void __printk_safe_exit(void);
 #define printk_deferred_enter __printk_safe_enter
 #define printk_deferred_exit __printk_safe_exit
 
-extern void printk_prefer_direct_enter(void);
-extern void printk_prefer_direct_exit(void);
-
 extern bool pr_flush(int timeout_ms, bool reset_on_progress);
 
 /*
@@ -224,14 +221,6 @@ static inline void printk_deferred_exit(void)
 {
 }
 
-static inline void printk_prefer_direct_enter(void)
-{
-}
-
-static inline void printk_prefer_direct_exit(void)
-{
-}
-
 static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return true;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 80bfea5dd5c4..cff3ae8c818f 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -127,8 +127,6 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 * complain:
 	 */
 	if (sysctl_hung_task_warnings) {
-		printk_prefer_direct_enter();
-
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
@@ -144,8 +142,6 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 
 		if (sysctl_hung_task_all_cpu_backtrace)
 			hung_task_show_all_bt = true;
-
-		printk_prefer_direct_exit();
 	}
 
 	touch_nmi_watchdog();
@@ -208,17 +204,12 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	}
  unlock:
 	rcu_read_unlock();
-	if (hung_task_show_lock) {
-		printk_prefer_direct_enter();
+	if (hung_task_show_lock)
 		debug_show_all_locks();
-		printk_prefer_direct_exit();
-	}
 
 	if (hung_task_show_all_bt) {
 		hung_task_show_all_bt = false;
-		printk_prefer_direct_enter();
 		trigger_all_cpu_backtrace();
-		printk_prefer_direct_exit();
 	}
 
 	if (hung_task_call_panic)
diff --git a/kernel/panic.c b/kernel/panic.c
index a3c758dba15a..a3308af28a21 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -603,8 +603,6 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 {
 	disable_trace_on_warning();
 
-	printk_prefer_direct_enter();
-
 	if (file)
 		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
 			raw_smp_processor_id(), current->pid, file, line,
@@ -634,8 +632,6 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
-
-	printk_prefer_direct_exit();
 }
 
 #ifndef __WARN_FLAGS
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5a6273e56b4e..b49c6ff6dca0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -362,34 +362,6 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 static DEFINE_MUTEX(syslog_lock);
 
 #ifdef CONFIG_PRINTK
-static atomic_t printk_prefer_direct = ATOMIC_INIT(0);
-
-/**
- * printk_prefer_direct_enter - cause printk() calls to attempt direct
- *                              printing to all enabled consoles
- *
- * Since it is not possible to call into the console printing code from any
- * context, there is no guarantee that direct printing will occur.
- *
- * This globally effects all printk() callers.
- *
- * Context: Any context.
- */
-void printk_prefer_direct_enter(void)
-{
-	atomic_inc(&printk_prefer_direct);
-}
-
-/**
- * printk_prefer_direct_exit - restore printk() behavior
- *
- * Context: Any context.
- */
-void printk_prefer_direct_exit(void)
-{
-	WARN_ON(atomic_dec_if_positive(&printk_prefer_direct) < 0);
-}
-
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4995c078cff9..a001e1e7a992 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -647,7 +647,6 @@ static void print_cpu_stall(unsigned long gps)
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
-	printk_prefer_direct_enter();
 	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
 	pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
 	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
@@ -685,7 +684,6 @@ static void print_cpu_stall(unsigned long gps)
 	 */
 	set_tsk_need_resched(current);
 	set_preempt_need_resched();
-	printk_prefer_direct_exit();
 }
 
 static void check_cpu_stall(struct rcu_data *rdp)
diff --git a/kernel/reboot.c b/kernel/reboot.c
index b5a71d1ff603..3c35445bf5ad 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -819,11 +819,9 @@ static int __orderly_reboot(void)
 	ret = run_cmd(reboot_cmd);
 
 	if (ret) {
-		printk_prefer_direct_enter();
 		pr_warn("Failed to start orderly reboot: forcing the issue\n");
 		emergency_sync();
 		kernel_restart(NULL);
-		printk_prefer_direct_exit();
 	}
 
 	return ret;
@@ -836,7 +834,6 @@ static int __orderly_poweroff(bool force)
 	ret = run_cmd(poweroff_cmd);
 
 	if (ret && force) {
-		printk_prefer_direct_enter();
 		pr_warn("Failed to start orderly shutdown: forcing the issue\n");
 
 		/*
@@ -846,7 +843,6 @@ static int __orderly_poweroff(bool force)
 		 */
 		emergency_sync();
 		kernel_power_off();
-		printk_prefer_direct_exit();
 	}
 
 	return ret;
@@ -904,8 +900,6 @@ EXPORT_SYMBOL_GPL(orderly_reboot);
  */
 static void hw_failure_emergency_poweroff_func(struct work_struct *work)
 {
-	printk_prefer_direct_enter();
-
 	/*
 	 * We have reached here after the emergency shutdown waiting period has
 	 * expired. This means orderly_poweroff has not been able to shut off
@@ -922,8 +916,6 @@ static void hw_failure_emergency_poweroff_func(struct work_struct *work)
 	 */
 	pr_emerg("Hardware protection shutdown failed. Trying emergency restart\n");
 	emergency_restart();
-
-	printk_prefer_direct_exit();
 }
 
 static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
@@ -962,13 +954,11 @@ void hw_protection_shutdown(const char *reason, int ms_until_forced)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
 
-	printk_prefer_direct_enter();
-
 	pr_emerg("HARDWARE PROTECTION shutdown (%s)\n", reason);
 
 	/* Shutdown should be initiated only once. */
 	if (!atomic_dec_and_test(&allow_proceed))
-		goto out;
+		return;
 
 	/*
 	 * Queue a backup emergency shutdown in the event of
@@ -976,8 +966,6 @@ void hw_protection_shutdown(const char *reason, int ms_until_forced)
 	 */
 	hw_failure_emergency_poweroff(ms_until_forced);
 	orderly_poweroff(true);
-out:
-	printk_prefer_direct_exit();
 }
 EXPORT_SYMBOL_GPL(hw_protection_shutdown);
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 20a7a55e62b6..ecb0e8346e65 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -424,8 +424,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		/* Start period for the next softlockup warning. */
 		update_report_ts();
 
-		printk_prefer_direct_enter();
-
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
@@ -444,8 +442,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
-
-		printk_prefer_direct_exit();
 	}
 
 	return HRTIMER_RESTART;
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 701f35f0e2d4..247bf0b1582c 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -135,8 +135,6 @@ static void watchdog_overflow_callback(struct perf_event *event,
 		if (__this_cpu_read(hard_watchdog_warn) == true)
 			return;
 
-		printk_prefer_direct_enter();
-
 		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n",
 			 this_cpu);
 		print_modules();
@@ -157,8 +155,6 @@ static void watchdog_overflow_callback(struct perf_event *event,
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
-		printk_prefer_direct_exit();
-
 		__this_cpu_write(hard_watchdog_warn, true);
 		return;
 	}
-- 
2.35.3

