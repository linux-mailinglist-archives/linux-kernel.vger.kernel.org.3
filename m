Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530F74F4F8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389332AbiDFAw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354338AbiDEPL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:11:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F52109A58
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:25:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649165142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9nXW5eDdRswHPPVMdRqznswZ+PeANL457bEvSUO9rY=;
        b=wbUXP3BlFV9pkCs967YQq/HESNZkYjif3wDfX90/TSqxB1i1Bd2zHCilPmBRYTxuYuVZBA
        Pr/vcptSi9SJjkyC4u/+3traDQr3GobNt5pF0U+u5b195NqJHmzvgqQ90liMzRSKNg2KZ8
        6CRUQm8iOLVgmQLcijM8WGt9bmO2poctKB8XRXGWIkGfpZI0VCIV8xdTp7xoTNuu3Ou/On
        r9g9nVyUYWoaCAfwMwmaM5FOriXMWJFHmlKsH7hjQbKUqKorLKPKAvxPrCGzKG79haSec7
        riMZMZp6UXvnaJTpOwodOVr9s0HTjpNQFBPT4VzRaoLBKkRAf+C+LoLU1XK9JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649165142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9nXW5eDdRswHPPVMdRqznswZ+PeANL457bEvSUO9rY=;
        b=Uvu9ZXlswmTEzarCepu12m1/D6Jy6QGJ+0sfmzmsY7Kb8RePRnW4BHJiFAUdainn6dpt8a
        VM+zPfqywWgrdFAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 10/12] printk: add kthread console printers
Date:   Tue,  5 Apr 2022 15:31:33 +0206
Message-Id: <20220405132535.649171-11-john.ogness@linutronix.de>
In-Reply-To: <20220405132535.649171-1-john.ogness@linutronix.de>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
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

Create a kthread for each console to perform console printing. During
normal operation (@system_state == SYSTEM_RUNNING), the kthread
printers are responsible for all printing on their respective
consoles.

During non-normal operation, console printing is done as it has been:
within the context of the printk caller or within irq work triggered
by the printk caller.

Console printers synchronize against each other and against console
lockers by taking the console lock for each message that is printed.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |   2 +
 kernel/printk/printk.c  | 262 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 252 insertions(+), 12 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 8c1686e2c233..9a251e70c090 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -153,6 +153,8 @@ struct console {
 	uint	ospeed;
 	u64	seq;
 	unsigned long dropped;
+	struct task_struct *thread;
+
 	void	*data;
 	struct	 console *next;
 };
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 258d02cff140..a3b8b984c9aa 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -361,6 +361,13 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_MUTEX(syslog_lock);
 
+/*
+ * A flag to signify if printk_activate_kthreads() has already started the
+ * kthread printers. If true, any later registered consoles must start their
+ * own kthread directly. The flag is write protected by the console_lock.
+ */
+static bool printk_kthreads_available;
+
 #ifdef CONFIG_PRINTK
 static atomic_t printk_prefer_direct = ATOMIC_INIT(0);
 
@@ -388,6 +395,21 @@ void printk_prefer_direct_enter(void)
 void printk_prefer_direct_exit(void)
 {
 	WARN_ON(atomic_dec_if_positive(&printk_prefer_direct) < 0);
+
+	/*
+	 * Threaded printers remain asleep while preferred direct printing is
+	 * active. Explicitly wake them in case any new printk records became
+	 * visible after preferred direct printing was deactivated.
+	 */
+	wake_up_klogd();
+}
+
+static inline bool allow_direct_printing(void)
+{
+	return (!printk_kthreads_available ||
+		system_state > SYSTEM_RUNNING ||
+		oops_in_progress ||
+		atomic_read(&printk_prefer_direct));
 }
 
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
@@ -2258,10 +2280,10 @@ asmlinkage int vprintk_emit(int facility, int level,
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
+	if (!in_sched && allow_direct_printing()) {
 		/*
 		 * The caller may be holding system-critical or
-		 * timing-sensitive locks. Disable preemption during
+		 * timing-sensitive locks. Disable preemption during direct
 		 * printing of all remaining records to all consoles so that
 		 * this context can return as soon as possible. Hopefully
 		 * another printk() caller will take over the printing.
@@ -2304,6 +2326,8 @@ EXPORT_SYMBOL(_printk);
 
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
+static void printk_start_kthread(struct console *con);
+
 #else /* CONFIG_PRINTK */
 
 #define CONSOLE_LOG_MAX		0
@@ -2337,6 +2361,8 @@ static void call_console_driver(struct console *con, const char *text, size_t le
 }
 static bool suppress_message_printing(int level) { return false; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
+static void printk_start_kthread(struct console *con) { }
+static bool allow_direct_printing(void) { return true; }
 
 #endif /* CONFIG_PRINTK */
 
@@ -2537,6 +2563,13 @@ void resume_console(void)
 	down_console_sem();
 	console_suspended = 0;
 	console_unlock();
+
+	/*
+	 * While suspended, new records may have been added to the
+	 * ringbuffer. Wake up the kthread printers to print them.
+	 */
+	wake_up_klogd();
+
 	pr_flush(1000, true);
 }
 
@@ -2555,6 +2588,9 @@ static int console_cpu_notify(unsigned int cpu)
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
+
+		/* Wake kthread printers. Some may have become usable. */
+		wake_up_klogd();
 	}
 	return 0;
 }
@@ -2773,6 +2809,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	*handover = false;
 
 	do {
+		/* Let the kthread printers do the work if they can. */
+		if (!allow_direct_printing())
+			break;
+
 		any_progress = false;
 
 		for_each_console(con) {
@@ -2988,6 +3028,10 @@ void console_start(struct console *console)
 	console_lock();
 	console->flags |= CON_ENABLED;
 	console_unlock();
+
+	/* Wake the newly enabled kthread printer. */
+	wake_up_klogd();
+
 	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
@@ -3196,6 +3240,8 @@ void register_console(struct console *newcon)
 		/* Begin with next message. */
 		newcon->seq = prb_next_seq(prb);
 	}
+	if (printk_kthreads_available)
+		printk_start_kthread(newcon);
 	console_unlock();
 	console_sysfs_notify();
 
@@ -3222,6 +3268,7 @@ EXPORT_SYMBOL(register_console);
 
 int unregister_console(struct console *console)
 {
+	struct task_struct *thd = console->thread;
 	struct console *con;
 	int res;
 
@@ -3233,6 +3280,11 @@ int unregister_console(struct console *console)
 	if (res > 0)
 		return 0;
 
+	if (thd) {
+		console->thread = NULL;
+		kthread_stop(thd);
+	}
+
 	res = -ENODEV;
 	console_lock();
 	if (console_drivers == console) {
@@ -3358,6 +3410,20 @@ static int __init printk_late_init(void)
 }
 late_initcall(printk_late_init);
 
+static int __init printk_activate_kthreads(void)
+{
+	struct console *con;
+
+	console_lock();
+	printk_kthreads_available = true;
+	for_each_console(con)
+		printk_start_kthread(con);
+	console_unlock();
+
+	return 0;
+}
+early_initcall(printk_activate_kthreads);
+
 #if defined CONFIG_PRINTK
 /* If @con is specified, only wait for that console. Otherwise wait for all. */
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)
@@ -3432,6 +3498,154 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 }
 EXPORT_SYMBOL(pr_flush);
 
+/*
+ * Enter preferred direct printing, but never exit. Mark console threads as
+ * unavailable. The system is then forever in preferred direct printing and
+ * any printing threads will exit.
+ */
+static void printk_fallback_preferred_direct(void)
+{
+	printk_prefer_direct_enter();
+	pr_err("falling back to preferred direct printing\n");
+	printk_kthreads_available = false;
+}
+
+static bool printer_should_wake(struct console *con, u64 seq)
+{
+	short flags;
+
+	if (kthread_should_stop() || !printk_kthreads_available)
+		return true;
+
+	if (console_suspended)
+		return false;
+
+	if (!con->write)
+		return false;
+
+	/*
+	 * This is an unsafe read to con->flags, but a false positive is not
+	 * a problem. Worst case it would allow the printer to wake up even
+	 * when it is disabled. But the printer will notice that itself when
+	 * attempting to print and instead go back to sleep.
+	 */
+	flags = data_race(READ_ONCE(con->flags));
+	if (!(flags & CON_ENABLED))
+		return false;
+
+	if (atomic_read(&printk_prefer_direct))
+		return false;
+
+	return prb_read_valid(prb, seq, NULL);
+}
+
+static int printk_kthread_func(void *data)
+{
+	struct console *con = data;
+	char *dropped_text = NULL;
+	char *ext_text = NULL;
+	bool handover;
+	u64 seq = 0;
+	char *text;
+	int error;
+
+	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
+	if (!text) {
+		printk_console_msg(con, KERN_ERR, "failed to allocate text buffer");
+		printk_fallback_preferred_direct();
+		goto out;
+	}
+
+	if (con->flags & CON_EXTENDED) {
+		ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
+		if (!ext_text) {
+			printk_console_msg(con, KERN_ERR, "failed to allocate ext_text buffer");
+			printk_fallback_preferred_direct();
+			goto out;
+		}
+	} else {
+		dropped_text = kmalloc(DROPPED_TEXT_MAX, GFP_KERNEL);
+		if (!dropped_text) {
+			printk_console_msg(con, KERN_ERR,
+					   "failed to allocate dropped_text buffer");
+			printk_fallback_preferred_direct();
+			goto out;
+		}
+	}
+
+	printk_console_msg(con, KERN_INFO, "printing thread started");
+
+	for (;;) {
+		/*
+		 * Guarantee this task is visible on the waitqueue before
+		 * checking the wake condition.
+		 *
+		 * The full memory barrier within set_current_state() of
+		 * prepare_to_wait_event() pairs with the full memory barrier
+		 * within wq_has_sleeper().
+		 *
+		 * See __wake_up_klogd:A for the pairing memory barrier.
+		 */
+		error = wait_event_interruptible(log_wait,
+				printer_should_wake(con, seq)); /* LMM(printk_kthread_func:A) */
+
+		if (kthread_should_stop() || !printk_kthreads_available)
+			break;
+
+		if (error)
+			continue;
+
+		console_lock();
+
+		if (console_suspended) {
+			__console_unlock();
+			continue;
+		}
+
+		if (!console_is_usable(con)) {
+			__console_unlock();
+			continue;
+		}
+
+		/*
+		 * Even though the printk kthread is always preemptible, it is
+		 * still not allowed to call cond_resched() from within
+		 * console drivers. The task may become non-preemptible in the
+		 * console driver call chain. For example, vt_console_print()
+		 * takes a spinlock and then can call into fbcon_redraw(),
+		 * which can conditionally invoke cond_resched().
+		 */
+		console_may_schedule = 0;
+		console_emit_next_record(con, text, ext_text, dropped_text, &handover);
+		if (handover)
+			continue;
+
+		seq = con->seq;
+
+		__console_unlock();
+	}
+
+	printk_console_msg(con, KERN_INFO, "printing thread stopped");
+out:
+	kfree(dropped_text);
+	kfree(ext_text);
+	kfree(text);
+	return 0;
+}
+
+/* Must be called within console_lock(). */
+static void printk_start_kthread(struct console *con)
+{
+	con->thread = kthread_run(printk_kthread_func, con,
+				  "pr/%s%d", con->name, con->index);
+	if (IS_ERR(con->thread)) {
+		con->thread = NULL;
+		printk_console_msg(con, KERN_ERR, "unable to start printing thread");
+		printk_fallback_preferred_direct();
+		return;
+	}
+}
+
 /*
  * Delayed printk version, for scheduler-internal messages:
  */
@@ -3445,40 +3659,64 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 	int pending = this_cpu_xchg(printk_pending, 0);
 
 	if (pending & PRINTK_PENDING_OUTPUT) {
+		printk_prefer_direct_enter();
+
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
+
+		printk_prefer_direct_exit();
 	}
 
 	if (pending & PRINTK_PENDING_WAKEUP)
-		wake_up_interruptible(&log_wait);
+		wake_up_interruptible_all(&log_wait);
 }
 
 static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =
 	IRQ_WORK_INIT_LAZY(wake_up_klogd_work_func);
 
-void wake_up_klogd(void)
+static void __wake_up_klogd(int val)
 {
 	if (!printk_percpu_data_ready())
 		return;
 
 	preempt_disable();
-	if (waitqueue_active(&log_wait)) {
-		this_cpu_or(printk_pending, PRINTK_PENDING_WAKEUP);
+	/*
+	 * Guarantee any new records can be seen by printing threads before
+	 * checking if the wait queue is empty.
+	 *
+	 * The full memory barrier within wq_has_sleeper() pairs with the full
+	 * memory barrier within set_current_state() of
+	 * prepare_to_wait_event(), which is called after ___wait_event() adds
+	 * the waiter but before it has checked the wait condition.
+	 *
+	 * See printk_kthread_func:A for the pairing memory barrier.
+	 */
+	if (wq_has_sleeper(&log_wait) || /* LMM(__wake_up_klogd:A) */
+	    (val & PRINTK_PENDING_OUTPUT)) {
+		this_cpu_or(printk_pending, val);
 		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	}
 	preempt_enable();
 }
 
+void wake_up_klogd(void)
+{
+	__wake_up_klogd(PRINTK_PENDING_WAKEUP);
+}
+
 void defer_console_output(void)
 {
-	if (!printk_percpu_data_ready())
-		return;
+	int val = PRINTK_PENDING_WAKEUP;
 
-	preempt_disable();
-	this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
-	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
-	preempt_enable();
+	/*
+	 * If console deferring was called with preferred direct printing,
+	 * make the irqwork perform the direct printing.
+	 */
+	if (atomic_read(&printk_prefer_direct))
+		val |= PRINTK_PENDING_OUTPUT;
+
+	__wake_up_klogd(val);
 }
 
 void printk_trigger_flush(void)
-- 
2.30.2

