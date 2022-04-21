Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3F550AACC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442105AbiDUV0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377813AbiDUVZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:25:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517A64CD57
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:22:59 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650576178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSTxlLIf5og+Vpzl/+8fyYQv3iHR/RUTw49b+NISiz0=;
        b=bPsrVyGNXbMJ+j2eFOux76fm2I7HiuMOTQu5I9f6L7nBOuun4ZbUT0QVkXzqbnqBdpICyt
        KVMK8Zad7AYEcUnD/Ic8jcNRZQw5y7Wccbmp8/F6wc89VMSQkawxkhEuBCE8pcTbtDGuqP
        u+gsFU+1Di5OTjbW3DtIzoD18NrOX3tyfnp3gsgKM0p1ggjGnmep5b9RU52Fd61WOiANCy
        T4SlMWafKfENgIUE+bgM9D/i/3s+dAVRjJWA0AMoQjZ6c52r2e5AJ4huAmUgudwwoexLX/
        dPzsuOiLqVMuqKhhzsOhCNiqC+FK2TA5IlPn5a8LbKexhds8xfD1hDiCDAXRbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650576178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSTxlLIf5og+Vpzl/+8fyYQv3iHR/RUTw49b+NISiz0=;
        b=gLVIBTOhuQZovMfVMyOPSrc+U7IqQkHCH/cdgQ3jiWLzGGW6NXZkS+MlvANnNVRffZb3k2
        xz7A/JoKl7OO1IBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 13/15] printk: add kthread console printers
Date:   Thu, 21 Apr 2022 23:28:48 +0206
Message-Id: <20220421212250.565456-14-john.ogness@linutronix.de>
In-Reply-To: <20220421212250.565456-1-john.ogness@linutronix.de>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
within the context of the printk caller or within irqwork triggered
by the printk caller, referred to as direct printing.

Since threaded console printers are responsible for all printing
during normal operation, this also includes messages generated via
deferred printk calls. If direct printing is in effect during a
deferred printk call, the queued irqwork will perform the direct
printing. To make it clear that this is the only time that the
irqwork will perform direct printing, rename the flag
PRINTK_PENDING_OUTPUT to PRINTK_PENDING_DIRECT_OUTPUT.

Threaded console printers synchronize against each other and against
console lockers by taking the console lock for each message that is
printed.

Note that the kthread printers do not care about direct printing.
They will always try to print if new records are available. They can
be blocked by direct printing, but will be woken again once direct
printing is finished.

Console unregistration is a bit tricky because the associated
kthread printer cannot be stopped while the console lock is held.
A policy is implemented that states: whichever task clears
con->thread (under the console lock) is responsible for stopping
the kthread. unregister_console() will clear con->thread while
the console lock is held and then stop the kthread after releasing
the console lock.

For consoles that have implemented the exit() callback, the kthread
is stopped before exit() is called.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |   2 +
 kernel/printk/printk.c  | 329 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 309 insertions(+), 22 deletions(-)

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
index ed7f738261cc..e4cdc424c826 100644
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
 
@@ -390,6 +397,39 @@ void printk_prefer_direct_exit(void)
 	WARN_ON(atomic_dec_if_positive(&printk_prefer_direct) < 0);
 }
 
+/*
+ * Calling printk() always wakes kthread printers so that they can
+ * flush the new message to their respective consoles. Also, if direct
+ * printing is allowed, printk() tries to flush the messages directly.
+ *
+ * Direct printing is allowed in situations when the kthreads
+ * are not available or the system is in a problematic state.
+ *
+ * See the implementation about possible races.
+ */
+static inline bool allow_direct_printing(void)
+{
+	/*
+	 * Checking kthread availability is a possible race because the
+	 * kthread printers can become permanently disabled during runtime.
+	 * However, doing that requires holding the console_lock, so any
+	 * pending messages will be direct printed by console_unlock().
+	 */
+	if (!printk_kthreads_available)
+		return true;
+
+	/*
+	 * Prefer direct printing when the system is in a problematic state.
+	 * The context that sets this state will always see the updated value.
+	 * The other contexts do not care. Anyway, direct printing is just a
+	 * best effort. The direct output is only possible when console_lock
+	 * is not already taken and no kthread printers are actively printing.
+	 */
+	return (system_state > SYSTEM_RUNNING ||
+		oops_in_progress ||
+		atomic_read(&printk_prefer_direct));
+}
+
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
@@ -2280,10 +2320,10 @@ asmlinkage int vprintk_emit(int facility, int level,
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
@@ -2326,6 +2366,8 @@ EXPORT_SYMBOL(_printk);
 
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
+static void printk_start_kthread(struct console *con);
+
 #else /* CONFIG_PRINTK */
 
 #define CONSOLE_LOG_MAX		0
@@ -2359,6 +2401,8 @@ static void call_console_driver(struct console *con, const char *text, size_t le
 }
 static bool suppress_message_printing(int level) { return false; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
+static void printk_start_kthread(struct console *con) { }
+static bool allow_direct_printing(void) { return true; }
 
 #endif /* CONFIG_PRINTK */
 
@@ -2559,6 +2603,13 @@ void resume_console(void)
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
 
@@ -2577,6 +2628,9 @@ static int console_cpu_notify(unsigned int cpu)
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
+
+		/* Wake kthread printers. Some may have become usable. */
+		wake_up_klogd();
 	}
 	return 0;
 }
@@ -2648,18 +2702,9 @@ static bool abandon_console_lock_in_panic(void)
 	return atomic_read(&panic_cpu) != raw_smp_processor_id();
 }
 
-/*
- * Check if the given console is currently capable and allowed to print
- * records.
- *
- * Requires the console_lock.
- */
-static inline bool console_is_usable(struct console *con)
+static inline bool __console_is_usable(short flags)
 {
-	if (!(con->flags & CON_ENABLED))
-		return false;
-
-	if (!con->write)
+	if (!(flags & CON_ENABLED))
 		return false;
 
 	/*
@@ -2668,12 +2713,26 @@ static inline bool console_is_usable(struct console *con)
 	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
 	 */
 	if (!cpu_online(raw_smp_processor_id()) &&
-	    !(con->flags & CON_ANYTIME))
+	    !(flags & CON_ANYTIME))
 		return false;
 
 	return true;
 }
 
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records.
+ *
+ * Requires the console_lock.
+ */
+static inline bool console_is_usable(struct console *con)
+{
+	if (!con->write)
+		return false;
+
+	return __console_is_usable(con->flags);
+}
+
 static void __console_unlock(void)
 {
 	console_locked = 0;
@@ -2786,8 +2845,8 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
  * were flushed to all usable consoles. A returned false informs the caller
  * that everything was not flushed (either there were no usable consoles or
  * another context has taken over printing or it is a panic situation and this
- * is not the panic CPU). Regardless the reason, the caller should assume it
- * is not useful to immediately try again.
+ * is not the panic CPU or direct printing is not preferred). Regardless the
+ * reason, the caller should assume it is not useful to immediately try again.
  *
  * Requires the console_lock.
  */
@@ -2804,6 +2863,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	*handover = false;
 
 	do {
+		/* Let the kthread printers do the work if they can. */
+		if (!allow_direct_printing())
+			return false;
+
 		any_progress = false;
 
 		for_each_console(con) {
@@ -3018,6 +3081,10 @@ void console_start(struct console *console)
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
@@ -3218,6 +3285,8 @@ void register_console(struct console *newcon)
 		nr_ext_console_drivers++;
 
 	newcon->dropped = 0;
+	newcon->thread = NULL;
+
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/* Get a consistent copy of @syslog_seq. */
 		mutex_lock(&syslog_lock);
@@ -3227,6 +3296,10 @@ void register_console(struct console *newcon)
 		/* Begin with next message. */
 		newcon->seq = prb_next_seq(prb);
 	}
+
+	if (printk_kthreads_available)
+		printk_start_kthread(newcon);
+
 	console_unlock();
 	console_sysfs_notify();
 
@@ -3253,6 +3326,7 @@ EXPORT_SYMBOL(register_console);
 
 int unregister_console(struct console *console)
 {
+	struct task_struct *thd;
 	struct console *con;
 	int res;
 
@@ -3293,7 +3367,20 @@ int unregister_console(struct console *console)
 		console_drivers->flags |= CON_CONSDEV;
 
 	console->flags &= ~CON_ENABLED;
+
+	/*
+	 * console->thread can only be cleared under the console lock. But
+	 * stopping the thread must be done without the console lock. The
+	 * task that clears @thread is the task that stops the kthread.
+	 */
+	thd = console->thread;
+	console->thread = NULL;
+
 	console_unlock();
+
+	if (thd)
+		kthread_stop(thd);
+
 	console_sysfs_notify();
 
 	if (console->exit)
@@ -3389,6 +3476,20 @@ static int __init printk_late_init(void)
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
@@ -3463,11 +3564,180 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 }
 EXPORT_SYMBOL(pr_flush);
 
+static void __printk_fallback_preferred_direct(void)
+{
+	printk_prefer_direct_enter();
+	pr_err("falling back to preferred direct printing\n");
+	printk_kthreads_available = false;
+}
+
+/*
+ * Enter preferred direct printing, but never exit. Mark console threads as
+ * unavailable. The system is then forever in preferred direct printing and
+ * any printing threads will exit.
+ *
+ * Must *not* be called under console_lock. Use
+ * __printk_fallback_preferred_direct() if already holding console_lock.
+ */
+static void printk_fallback_preferred_direct(void)
+{
+	console_lock();
+	__printk_fallback_preferred_direct();
+	console_unlock();
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
+	/*
+	 * This is an unsafe read from con->flags, but a false positive is
+	 * not a problem. Worst case it would allow the printer to wake up
+	 * although it is disabled. But the printer will notice that when
+	 * attempting to print and instead go back to sleep.
+	 */
+	flags = data_race(READ_ONCE(con->flags));
+
+	if (!__console_is_usable(flags))
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
+		con_printk(KERN_ERR, con, "failed to allocate text buffer\n");
+		printk_fallback_preferred_direct();
+		goto out;
+	}
+
+	if (con->flags & CON_EXTENDED) {
+		ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
+		if (!ext_text) {
+			con_printk(KERN_ERR, con, "failed to allocate ext_text buffer\n");
+			printk_fallback_preferred_direct();
+			goto out;
+		}
+	} else {
+		dropped_text = kmalloc(DROPPED_TEXT_MAX, GFP_KERNEL);
+		if (!dropped_text) {
+			con_printk(KERN_ERR, con, "failed to allocate dropped_text buffer\n");
+			printk_fallback_preferred_direct();
+			goto out;
+		}
+	}
+
+	con_printk(KERN_INFO, con, "printing thread started\n");
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
+		 * This pairs with __wake_up_klogd:A.
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
+			up_console_sem();
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
+	con_printk(KERN_INFO, con, "printing thread stopped\n");
+out:
+	kfree(dropped_text);
+	kfree(ext_text);
+	kfree(text);
+
+	console_lock();
+	/*
+	 * If this kthread is being stopped by another task, con->thread will
+	 * already be NULL. That is fine. The important thing is that it is
+	 * NULL after the kthread exits.
+	 */
+	con->thread = NULL;
+	console_unlock();
+
+	return 0;
+}
+
+/* Must be called under console_lock. */
+static void printk_start_kthread(struct console *con)
+{
+	/*
+	 * Do not start a kthread if there is no write() callback. The
+	 * kthreads assume the write() callback exists.
+	 */
+	if (!con->write)
+		return;
+
+	con->thread = kthread_run(printk_kthread_func, con,
+				  "pr/%s%d", con->name, con->index);
+	if (IS_ERR(con->thread)) {
+		con->thread = NULL;
+		con_printk(KERN_ERR, con, "unable to start printing thread\n");
+		__printk_fallback_preferred_direct();
+		return;
+	}
+}
+
 /*
  * Delayed printk version, for scheduler-internal messages:
  */
-#define PRINTK_PENDING_WAKEUP	0x01
-#define PRINTK_PENDING_OUTPUT	0x02
+#define PRINTK_PENDING_WAKEUP		0x01
+#define PRINTK_PENDING_DIRECT_OUTPUT	0x02
 
 static DEFINE_PER_CPU(int, printk_pending);
 
@@ -3475,10 +3745,14 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 {
 	int pending = this_cpu_xchg(printk_pending, 0);
 
-	if (pending & PRINTK_PENDING_OUTPUT) {
+	if (pending & PRINTK_PENDING_DIRECT_OUTPUT) {
+		printk_prefer_direct_enter();
+
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
+
+		printk_prefer_direct_exit();
 	}
 
 	if (pending & PRINTK_PENDING_WAKEUP)
@@ -3503,10 +3777,11 @@ static void __wake_up_klogd(int val)
 	 * prepare_to_wait_event(), which is called after ___wait_event() adds
 	 * the waiter but before it has checked the wait condition.
 	 *
-	 * This pairs with devkmsg_read:A and syslog_print:A.
+	 * This pairs with devkmsg_read:A, syslog_print:A, and
+	 * printk_kthread_func:A.
 	 */
 	if (wq_has_sleeper(&log_wait) || /* LMM(__wake_up_klogd:A) */
-	    (val & PRINTK_PENDING_OUTPUT)) {
+	    (val & PRINTK_PENDING_DIRECT_OUTPUT)) {
 		this_cpu_or(printk_pending, val);
 		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	}
@@ -3524,7 +3799,17 @@ void defer_console_output(void)
 	 * New messages may have been added directly to the ringbuffer
 	 * using vprintk_store(), so wake any waiters as well.
 	 */
-	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
+	int val = PRINTK_PENDING_WAKEUP;
+
+	/*
+	 * Make sure that some context will print the messages when direct
+	 * printing is allowed. This happens in situations when the kthreads
+	 * may not be as reliable or perhaps unusable.
+	 */
+	if (allow_direct_printing())
+		val |= PRINTK_PENDING_DIRECT_OUTPUT;
+
+	__wake_up_klogd(val);
 }
 
 void printk_trigger_flush(void)
-- 
2.30.2

