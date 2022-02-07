Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24444AC9D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239972AbiBGToa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbiBGTnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:43:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34162C0401E4;
        Mon,  7 Feb 2022 11:43:31 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644263009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOR5WbQJrKK+I/SA7qP7nQGJ8obD2pFQ2CzlcnvaYpM=;
        b=oLAXtihwjw5NTCGy6UBmwHk0N4OD7qItM20ufBP6OKE7TM8ipSAWNpGRF7N4ljR8p+5p0p
        DTtaFUJzjgrEITlidqxpEvEbxDmY1uHZXshwJr/DKl1efthMM6hrbEsIDB5f0YteiwuWCT
        yILCLoXaVIm7jnNUBB2O67+8G1Wd5DL3peSac3bz+/7a1uW7eLInWBMp9SEqi+YDh5L9vA
        BlSXWRUUT05Pr4c/z/PCn8lf0J8KGcQEr2xr7mgwGVDNj5OtSK8kWwyq9aUpMTYcKKedqO
        W04ZK8c4CV7eIuKLpdobpP1Yj7Qk5SfUxPLuz8teKbW48WYrrjo7hhxCwXo+Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644263009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOR5WbQJrKK+I/SA7qP7nQGJ8obD2pFQ2CzlcnvaYpM=;
        b=NFEyFRFN1R95oj98NXvw4e9vVBpYcdZOhVckpRFgjcguUzktJwy67jB4w3UOsG8aQrES9m
        rffhgvIhlH9GJ2BQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Corey Minyard <cminyard@mvista.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>, Tejun Heo <tj@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, rcu@vger.kernel.org
Subject: [PATCH printk v1 09/13] printk: add functions to allow direct printing
Date:   Mon,  7 Feb 2022 20:49:19 +0106
Message-Id: <20220207194323.273637-10-john.ogness@linutronix.de>
In-Reply-To: <20220207194323.273637-1-john.ogness@linutronix.de>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once kthread printing is introduced, console printing will no longer
occur in the context of the printk caller. However, there are some
special contexts where it is desirable for the printk caller to
directly print out kernel messages. Using pr_flush() to wait for
threaded printers is only possible if the caller is in a sleepable
context and the kthreads are active. That is not always the case.

Introduce printk_direct_enter() and printk_direct_exit() functions
to explicitly (and globally) activate/deactivate direct console
printing.

Activate direct printing for:
 - sysrq
 - emergency reboot/shutdown
 - cpu and rcu stalls
 - hard and soft lockups
 - hung tasks
 - stack dumps

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/sysrq.c     |  2 ++
 include/linux/printk.h  | 11 +++++++++++
 kernel/hung_task.c      | 11 ++++++++++-
 kernel/printk/printk.c  | 39 ++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/tree_stall.h |  2 ++
 kernel/reboot.c         | 14 +++++++++++++-
 kernel/watchdog.c       |  4 ++++
 kernel/watchdog_hld.c   |  4 ++++
 lib/dump_stack.c        |  2 ++
 lib/nmi_backtrace.c     |  2 ++
 10 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index bbfd004449b5..a809f56c392f 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -594,9 +594,11 @@ void __handle_sysrq(int key, bool check_mask)
 		 * should not) and is the invoked operation enabled?
 		 */
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
+			printk_direct_enter();
 			pr_info("%s\n", op_p->action_msg);
 			console_loglevel = orig_log_level;
 			op_p->handler(key);
+			printk_direct_exit();
 		} else {
 			pr_info("This sysrq operation is disabled.\n");
 			console_loglevel = orig_log_level;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6596f02d1f05..eedf7546ff89 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -170,6 +170,9 @@ extern void __printk_safe_exit(void);
 #define printk_deferred_enter __printk_safe_enter
 #define printk_deferred_exit __printk_safe_exit
 
+extern void printk_direct_enter(void);
+extern void printk_direct_exit(void);
+
 extern bool pr_flush(int timeout_ms, bool reset_on_progress);
 
 /*
@@ -226,6 +229,14 @@ static inline void printk_deferred_exit(void)
 {
 }
 
+static inline void printk_direct_enter(void)
+{
+}
+
+static inline void printk_direct_exit(void)
+{
+}
+
 static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return true;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 9888e2bc8c76..6de7cec90c3b 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -125,6 +125,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 * complain:
 	 */
 	if (sysctl_hung_task_warnings) {
+		printk_direct_enter();
+
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
@@ -140,6 +142,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 
 		if (sysctl_hung_task_all_cpu_backtrace)
 			hung_task_show_all_bt = true;
+
+		printk_direct_exit();
 	}
 
 	touch_nmi_watchdog();
@@ -202,12 +206,17 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	}
  unlock:
 	rcu_read_unlock();
-	if (hung_task_show_lock)
+	if (hung_task_show_lock) {
+		printk_direct_enter();
 		debug_show_all_locks();
+		printk_direct_exit();
+	}
 
 	if (hung_task_show_all_bt) {
 		hung_task_show_all_bt = false;
+		printk_direct_enter();
 		trigger_all_cpu_backtrace();
+		printk_direct_exit();
 	}
 
 	if (hung_task_call_panic)
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1e80fd052bd5..719b05e6ce3b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -348,6 +348,31 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 static DEFINE_MUTEX(syslog_lock);
 
 #ifdef CONFIG_PRINTK
+static atomic_t printk_direct = ATOMIC_INIT(0);
+
+/**
+ * printk_direct_enter - cause console printing to occur in the context of
+ *                       printk() callers
+ *
+ * This globally effects all printk() callers.
+ *
+ * Context: Any context.
+ */
+void printk_direct_enter(void)
+{
+	atomic_inc(&printk_direct);
+}
+
+/**
+ * printk_direct_exit - restore console printing behavior from direct
+ *
+ * Context: Any context.
+ */
+void printk_direct_exit(void)
+{
+	atomic_dec(&printk_direct);
+}
+
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
@@ -3325,6 +3350,7 @@ EXPORT_SYMBOL(pr_flush);
  */
 #define PRINTK_PENDING_WAKEUP	0x01
 #define PRINTK_PENDING_OUTPUT	0x02
+#define PRINTK_DIRECT_OUTPUT	0x04
 
 static DEFINE_PER_CPU(int, printk_pending);
 
@@ -3333,9 +3359,15 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 	int pending = __this_cpu_xchg(printk_pending, 0);
 
 	if (pending & PRINTK_PENDING_OUTPUT) {
+		if (pending & PRINTK_DIRECT_OUTPUT)
+			printk_direct_enter();
+
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
+
+		if (pending & PRINTK_DIRECT_OUTPUT)
+			printk_direct_exit();
 	}
 
 	if (pending & PRINTK_PENDING_WAKEUP)
@@ -3360,11 +3392,16 @@ void wake_up_klogd(void)
 
 void defer_console_output(void)
 {
+	int val = PRINTK_PENDING_OUTPUT;
+
 	if (!printk_percpu_data_ready())
 		return;
 
+	if (atomic_read(&printk_direct))
+		val |= PRINTK_DIRECT_OUTPUT;
+
 	preempt_disable();
-	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
+	__this_cpu_or(printk_pending, val);
 	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	preempt_enable();
 }
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5e2fa6fd97f1..26953f9b2ab2 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -610,6 +610,7 @@ static void print_cpu_stall(unsigned long gps)
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
+	printk_direct_enter();
 	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
 	pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
 	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
@@ -644,6 +645,7 @@ static void print_cpu_stall(unsigned long gps)
 	 */
 	set_tsk_need_resched(current);
 	set_preempt_need_resched();
+	printk_direct_exit();
 }
 
 static void check_cpu_stall(struct rcu_data *rdp)
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 6bcc5d6a6572..0f219ce610fc 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -447,9 +447,11 @@ static int __orderly_reboot(void)
 	ret = run_cmd(reboot_cmd);
 
 	if (ret) {
+		printk_direct_enter();
 		pr_warn("Failed to start orderly reboot: forcing the issue\n");
 		emergency_sync();
 		kernel_restart(NULL);
+		printk_direct_exit();
 	}
 
 	return ret;
@@ -462,6 +464,7 @@ static int __orderly_poweroff(bool force)
 	ret = run_cmd(poweroff_cmd);
 
 	if (ret && force) {
+		printk_direct_enter();
 		pr_warn("Failed to start orderly shutdown: forcing the issue\n");
 
 		/*
@@ -471,6 +474,7 @@ static int __orderly_poweroff(bool force)
 		 */
 		emergency_sync();
 		kernel_power_off();
+		printk_direct_exit();
 	}
 
 	return ret;
@@ -528,6 +532,8 @@ EXPORT_SYMBOL_GPL(orderly_reboot);
  */
 static void hw_failure_emergency_poweroff_func(struct work_struct *work)
 {
+	printk_direct_enter();
+
 	/*
 	 * We have reached here after the emergency shutdown waiting period has
 	 * expired. This means orderly_poweroff has not been able to shut off
@@ -544,6 +550,8 @@ static void hw_failure_emergency_poweroff_func(struct work_struct *work)
 	 */
 	pr_emerg("Hardware protection shutdown failed. Trying emergency restart\n");
 	emergency_restart();
+
+	printk_direct_exit();
 }
 
 static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
@@ -582,11 +590,13 @@ void hw_protection_shutdown(const char *reason, int ms_until_forced)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
 
+	printk_direct_enter();
+
 	pr_emerg("HARDWARE PROTECTION shutdown (%s)\n", reason);
 
 	/* Shutdown should be initiated only once. */
 	if (!atomic_dec_and_test(&allow_proceed))
-		return;
+		goto out;
 
 	/*
 	 * Queue a backup emergency shutdown in the event of
@@ -594,6 +604,8 @@ void hw_protection_shutdown(const char *reason, int ms_until_forced)
 	 */
 	hw_failure_emergency_poweroff(ms_until_forced);
 	orderly_poweroff(true);
+out:
+	printk_direct_exit();
 }
 EXPORT_SYMBOL_GPL(hw_protection_shutdown);
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index ad912511a0c0..930563f155ee 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -424,6 +424,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		/* Start period for the next softlockup warning. */
 		update_report_ts();
 
+		printk_direct_enter();
+
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
@@ -442,6 +444,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
+
+		printk_direct_exit();
 	}
 
 	return HRTIMER_RESTART;
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..56cfbae94c42 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -135,6 +135,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
 		if (__this_cpu_read(hard_watchdog_warn) == true)
 			return;
 
+		printk_direct_enter();
+
 		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n",
 			 this_cpu);
 		print_modules();
@@ -155,6 +157,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
+		printk_direct_exit();
+
 		__this_cpu_write(hard_watchdog_warn, true);
 		return;
 	}
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 83471e81501a..e3b4eeb1dcb4 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -102,9 +102,11 @@ asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 	 * Permit this cpu to perform nested stack dumps while serialising
 	 * against other CPUs
 	 */
+	printk_direct_enter();
 	printk_cpu_sync_get_irqsave(flags);
 	__dump_stack(log_lvl);
 	printk_cpu_sync_put_irqrestore(flags);
+	printk_direct_exit();
 }
 EXPORT_SYMBOL(dump_stack_lvl);
 
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index d01aec6ae15c..dabeb35bc8dc 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -99,6 +99,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 		 * Allow nested NMI backtraces while serializing
 		 * against other CPUs.
 		 */
+		printk_direct_enter();
 		printk_cpu_sync_get_irqsave(flags);
 		if (!READ_ONCE(backtrace_idle) && regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
@@ -111,6 +112,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 				dump_stack();
 		}
 		printk_cpu_sync_put_irqrestore(flags);
+		printk_direct_exit();
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
-- 
2.30.2

