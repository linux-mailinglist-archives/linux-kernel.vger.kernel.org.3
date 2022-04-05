Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30254F4CA4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579263AbiDEX0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354812AbiDEPML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:12:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A71109A65
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:25:44 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649165142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B2yzUBrKob8fBHsOxXzklUpPd/Gj/0aKkS2L92trxYY=;
        b=z2MktqKTFwZaAVyXXLoLdnZ3wkFkp1YUMl4TluUenm2Dxbj0W0ugExzlx5jKIupy4FwSqm
        aJoyb8YXAx8X3j9MbXdoZ2rjrB52KRKs8mYDTUPyJ15NEzhWWTh84nw3GpwBu9j83eKmAj
        B7JGgc013mPyTSgOYOgAqPDJc4MREGkOcuFbbA5cATjYsEXY/taGvwN56OHYel2Q3c5wff
        PyUpVvNbXqYj0noXrAQtn8vBssyCalQaKHTjg5PiDqCx3I14CyRj9ORFt9ZOWW+n51XddC
        nC5fPMruyJe/fkNFtCjYZ4JJ0sp/MisZrBBaMLCIsatc0wbrIfCP4VZJnb/FHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649165142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B2yzUBrKob8fBHsOxXzklUpPd/Gj/0aKkS2L92trxYY=;
        b=y2AixWH6nKhuZi9w+bMJdrJGsWb/CJG9MCm5zXWoau6jdJfpqDsuwiUkxleGffCo4OrD/S
        8q7A9xecC2zO/HCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 11/12] printk: extend console_lock for proper kthread support
Date:   Tue,  5 Apr 2022 15:31:34 +0206
Message-Id: <20220405132535.649171-12-john.ogness@linutronix.de>
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

Currently threaded console printers synchronize against each
other using console_lock(). However, different console drivers
are unrelated and do not require any synchronization between
each other. Removing the synchronization between the threaded
console printers will allow each console to print at its own
speed.

But the threaded consoles printers do still need to synchronize
against console_lock() callers. Introduce a per-console mutex
and a new console flag CON_THD_BLOCKED to provide this
synchronization.

console_lock() is modified so that it must acquire the mutex
of each console in order to set the CON_THD_BLOCKED flag.
Console printing threads will acquire their mutex while
printing a record. If CON_THD_BLOCKED was set, the thread will
go back to sleep instead of printing.

The reason for the CON_THD_BLOCKED flag is so that
console_lock() callers do not need to acquire multiple console
mutexes simultaneously, which would introduce unnecessary
complexity due to nested mutex locking.

However, threaded console printers also need to synchronize
against console_trylock() callers. Since console_trylock() may
be called from any context, the per-console mutex cannot be
used for this synchronization. (mutex_trylock() cannot be
called from atomic contexts.) Introduce a global atomic counter
to identify if any threaded printers are active. The threaded
printers will also check the atomic counter to identify if the
console has been locked by another task via console_trylock().

Note that @console_sem is still used to provide synchronization
between console_lock() and console_trylock() callers.

A locking overview for console_lock(), console_trylock(), and the
threaded printers is as follows (pseudo code):

console_lock()
{
        down(&console_sem);
        for_each_console(con) {
                mutex_lock(&con->lock);
                con->flags |= CON_THD_BLOCKED;
                mutex_unlock(&con->lock);
        }
        /* console lock acquired */
}

console_trylock()
{
        if (down_trylock(&console_sem) == 0) {
                if (atomic_cmpxchg(&console_kthreads_active, 0, -1) == 0) {
                        /* console lock acquired */
                }
        }
}

threaded_printer()
{
        mutex_lock(&con->lock);
        if (!(con->flags & CON_THD_BLOCKED)) {
		/* console_lock() callers blocked */

                if (atomic_inc_unless_negative(&console_kthreads_active)) {
                        /* console_trylock() callers blocked */

                        con->write();

                        atomic_dec(&console_lock_count);
                }
        }
        mutex_unlock(&con->lock);
}

The console owner and waiter logic now only applies between contexts
that have taken the console lock. Since threaded printers never take
the console lock, they do not have a console lock to handover to
other contexts.

@panic_console_dropped must change to atomic_t since it is no longer
protected exclusively by the console lock.

Since threaded printers remain asleep if they see that the console
is locked, they now must be explicitly woken in __console_unlock().
This means wake_up_klogd() calls following a console_unlock() are
no longer necessary and are removed.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |  15 +++
 kernel/printk/printk.c  | 243 ++++++++++++++++++++++++++++++----------
 2 files changed, 199 insertions(+), 59 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 9a251e70c090..c1fd4f41c547 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -16,6 +16,7 @@
 
 #include <linux/atomic.h>
 #include <linux/types.h>
+#include <linux/mutex.h>
 
 struct vc_data;
 struct console_font_op;
@@ -136,6 +137,7 @@ static inline int con_debug_leave(void)
 #define CON_ANYTIME	(16) /* Safe to call when cpu is offline */
 #define CON_BRL		(32) /* Used for a braille device */
 #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
+#define CON_THD_BLOCKED	(128) /* Thread blocked because console is locked */
 
 struct console {
 	char	name[16];
@@ -155,6 +157,19 @@ struct console {
 	unsigned long dropped;
 	struct task_struct *thread;
 
+	/*
+	 * The per-console lock is used by printing kthreads to synchronize
+	 * this console with callers of console_lock(). This is necessary in
+	 * order to allow printing kthreads to run in parallel to each other,
+	 * while each safely accessing their own @flags and synchronizing
+	 * against direct printing via console_lock/console_unlock.
+	 *
+	 * Note: For synchronizing against direct printing via
+	 *       console_trylock/console_unlock, see the static global
+	 *       variable @console_kthreads_active.
+	 */
+	struct mutex lock;
+
 	void	*data;
 	struct	 console *next;
 };
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a3b8b984c9aa..a5525a7b7bc5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -223,6 +223,33 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 /* Number of registered extended console drivers. */
 static int nr_ext_console_drivers;
 
+/*
+ * Used to synchronize printing kthreads against direct printing via
+ * console_trylock/console_unlock.
+ *
+ * Values:
+ * -1 = console kthreads atomically blocked (via global trylock)
+ *  0 = no kthread printing, console not locked (via trylock)
+ * >0 = kthread(s) actively printing
+ *
+ * Note: For synchronizing against direct printing via
+ *       console_lock/console_unlock, see the @lock variable in
+ *       struct console.
+ */
+static atomic_t console_kthreads_active = ATOMIC_INIT(0);
+
+#define console_kthreads_atomic_tryblock() \
+	(atomic_cmpxchg(&console_kthreads_active, 0, -1) == 0)
+#define console_kthreads_atomic_unblock() \
+	atomic_cmpxchg(&console_kthreads_active, -1, 0)
+#define console_kthreads_atomically_blocked() \
+	(atomic_read(&console_kthreads_active) == -1)
+
+#define console_kthread_printing_tryenter() \
+	atomic_inc_unless_negative(&console_kthreads_active)
+#define console_kthread_printing_exit() \
+	atomic_dec(&console_kthreads_active)
+
 /*
  * Helper macros to handle lockdep when locking/unlocking console_sem. We use
  * macros instead of functions so that _RET_IP_ contains useful information.
@@ -270,6 +297,49 @@ static bool panic_in_progress(void)
 	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
 }
 
+/*
+ * Tracks whether kthread printers are all blocked. A value of true implies
+ * that the console is locked via console_lock() or the console is suspended.
+ * Reading and writing to this variable requires holding @console_sem.
+ */
+static bool console_kthreads_blocked;
+
+/*
+ * Block all kthread printers from a schedulable context.
+ *
+ * Requires the console_lock.
+ */
+static void console_kthreads_block(void)
+{
+	struct console *con;
+
+	for_each_console(con) {
+		mutex_lock(&con->lock);
+		con->flags |= CON_THD_BLOCKED;
+		mutex_unlock(&con->lock);
+	}
+
+	console_kthreads_blocked = true;
+}
+
+/*
+ * Unblock all kthread printers from a schedulable context.
+ *
+ * Requires the console_lock.
+ */
+static void console_kthreads_unblock(void)
+{
+	struct console *con;
+
+	for_each_console(con) {
+		mutex_lock(&con->lock);
+		con->flags &= ~CON_THD_BLOCKED;
+		mutex_unlock(&con->lock);
+	}
+
+	console_kthreads_blocked = false;
+}
+
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
@@ -2563,13 +2633,6 @@ void resume_console(void)
 	down_console_sem();
 	console_suspended = 0;
 	console_unlock();
-
-	/*
-	 * While suspended, new records may have been added to the
-	 * ringbuffer. Wake up the kthread printers to print them.
-	 */
-	wake_up_klogd();
-
 	pr_flush(1000, true);
 }
 
@@ -2588,9 +2651,10 @@ static int console_cpu_notify(unsigned int cpu)
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
-
-		/* Wake kthread printers. Some may have become usable. */
-		wake_up_klogd();
+		else {
+			/* Some kthread printers may have become usable. */
+			wake_up_klogd();
+		}
 	}
 	return 0;
 }
@@ -2610,6 +2674,7 @@ void console_lock(void)
 	down_console_sem();
 	if (console_suspended)
 		return;
+	console_kthreads_block();
 	console_locked = 1;
 	console_may_schedule = 1;
 }
@@ -2631,6 +2696,10 @@ int console_trylock(void)
 		up_console_sem();
 		return 0;
 	}
+	if (!console_kthreads_atomic_tryblock()) {
+		up_console_sem();
+		return 0;
+	}
 	console_locked = 1;
 	console_may_schedule = 0;
 	return 1;
@@ -2639,7 +2708,7 @@ EXPORT_SYMBOL(console_trylock);
 
 int is_console_locked(void)
 {
-	return console_locked;
+	return (console_locked || atomic_read(&console_kthreads_active));
 }
 EXPORT_SYMBOL(is_console_locked);
 
@@ -2691,6 +2760,22 @@ static inline bool console_is_usable(struct console *con)
 static void __console_unlock(void)
 {
 	console_locked = 0;
+
+	/*
+	 * Depending on whether console_lock() or console_trylock() was used,
+	 * appropriately allow the kthread printers to continue.
+	 */
+	if (console_kthreads_blocked)
+		console_kthreads_unblock();
+	else
+		console_kthreads_atomic_unblock();
+
+	/*
+	 * New records may have arrived while the console was locked.
+	 * Wake the kthread printers to print them.
+	 */
+	wake_up_klogd();
+
 	up_console_sem();
 }
 
@@ -2706,19 +2791,18 @@ static void __console_unlock(void)
  * If dropped messages should be printed, @dropped_text is a buffer of size
  * DROPPED_TEXT_MAX. Otherwise @dropped_text must be NULL.
  *
- * Requires the console_lock.
- *
  * Returns false if the given console has no next record to print, otherwise
  * true.
  *
  * @handover will be set to true if a printk waiter has taken over the
  * console_lock, in which case the caller is no longer holding the
- * console_lock. Otherwise it is set to false.
+ * console_lock. Otherwise it is set to false. A NULL pointer may be provided
+ * to disable allowing the console_lock to be taken over by a printk waiter.
  */
-static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
-				     char *dropped_text, bool *handover)
+static bool __console_emit_next_record(struct console *con, char *text, char *ext_text,
+				       char *dropped_text, bool *handover)
 {
-	static int panic_console_dropped;
+	static atomic_t panic_console_dropped = ATOMIC_INIT(0);
 	struct printk_info info;
 	struct printk_record r;
 	unsigned long flags;
@@ -2727,7 +2811,8 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 
 	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
-	*handover = false;
+	if (handover)
+		*handover = false;
 
 	if (!prb_read_valid(prb, con->seq, &r))
 		return false;
@@ -2735,7 +2820,8 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 	if (con->seq != r.info->seq) {
 		con->dropped += r.info->seq - con->seq;
 		con->seq = r.info->seq;
-		if (panic_in_progress() && panic_console_dropped++ > 10) {
+		if (panic_in_progress() &&
+		    atomic_fetch_inc_relaxed(&panic_console_dropped) > 10) {
 			suppress_panic_printk = 1;
 			pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
 		}
@@ -2757,31 +2843,52 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
 	}
 
-	/*
-	 * While actively printing out messages, if another printk()
-	 * were to occur on another CPU, it may wait for this one to
-	 * finish. This task can not be preempted if there is a
-	 * waiter waiting to take over.
-	 *
-	 * Interrupts are disabled because the hand over to a waiter
-	 * must not be interrupted until the hand over is completed
-	 * (@console_waiter is cleared).
-	 */
-	printk_safe_enter_irqsave(flags);
-	console_lock_spinning_enable();
+	if (handover) {
+		/*
+		 * While actively printing out messages, if another printk()
+		 * were to occur on another CPU, it may wait for this one to
+		 * finish. This task can not be preempted if there is a
+		 * waiter waiting to take over.
+		 *
+		 * Interrupts are disabled because the hand over to a waiter
+		 * must not be interrupted until the hand over is completed
+		 * (@console_waiter is cleared).
+		 */
+		printk_safe_enter_irqsave(flags);
+		console_lock_spinning_enable();
+
+		/* don't trace irqsoff print latency */
+		stop_critical_timings();
+	}
 
-	stop_critical_timings();	/* don't trace print latency */
 	call_console_driver(con, write_text, len, dropped_text);
-	start_critical_timings();
 
 	con->seq++;
 
-	*handover = console_lock_spinning_disable_and_check();
-	printk_safe_exit_irqrestore(flags);
+	if (handover) {
+		start_critical_timings();
+		*handover = console_lock_spinning_disable_and_check();
+		printk_safe_exit_irqrestore(flags);
+	}
 skip:
 	return true;
 }
 
+/*
+ * Print a record for a given console, but allow another printk() caller to
+ * take over the console_lock and continue printing.
+ *
+ * Requires the console_lock, but depending on @handover after the call, the
+ * caller may no longer have the console_lock.
+ *
+ * See __console_emit_next_record() for argument details.
+ */
+static bool console_emit_next_record_transferable(struct console *con, char *text, char *ext_text,
+						  char *dropped_text, bool *handover)
+{
+	return __console_emit_next_record(con, text, ext_text, dropped_text, handover);
+}
+
 /*
  * Print out all remaining records to all consoles.
  *
@@ -2824,13 +2931,11 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 			if (con->flags & CON_EXTENDED) {
 				/* Extended consoles do not print "dropped messages". */
-				progress = console_emit_next_record(con, &text[0],
-								    &ext_text[0], NULL,
-								    handover);
+				progress = console_emit_next_record_transferable(con, &text[0],
+								&ext_text[0], NULL, handover);
 			} else {
-				progress = console_emit_next_record(con, &text[0],
-								    NULL, &dropped_text[0],
-								    handover);
+				progress = console_emit_next_record_transferable(con, &text[0],
+								NULL, &dropped_text[0], handover);
 			}
 			if (*handover)
 				return true;
@@ -2946,6 +3051,10 @@ void console_unblank(void)
 	if (oops_in_progress) {
 		if (down_trylock_console_sem() != 0)
 			return;
+		if (!console_kthreads_atomic_tryblock()) {
+			up_console_sem();
+			return;
+		}
 	} else
 		console_lock();
 
@@ -3028,10 +3137,6 @@ void console_start(struct console *console)
 	console_lock();
 	console->flags |= CON_ENABLED;
 	console_unlock();
-
-	/* Wake the newly enabled kthread printer. */
-	wake_up_klogd();
-
 	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
@@ -3230,7 +3335,11 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_EXTENDED)
 		nr_ext_console_drivers++;
 
+	if (console_kthreads_blocked)
+		newcon->flags |= CON_THD_BLOCKED;
+
 	newcon->dropped = 0;
+	mutex_init(&newcon->lock);
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/* Get a consistent copy of @syslog_seq. */
 		mutex_lock(&syslog_lock);
@@ -3510,6 +3619,19 @@ static void printk_fallback_preferred_direct(void)
 	printk_kthreads_available = false;
 }
 
+/*
+ * Print a record for a given console, not allowing another printk() caller
+ * to take over. This is appropriate for contexts that do not have the
+ * console_lock.
+ *
+ * See __console_emit_next_record() for argument details.
+ */
+static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
+				     char *dropped_text)
+{
+	return __console_emit_next_record(con, text, ext_text, dropped_text, NULL);
+}
+
 static bool printer_should_wake(struct console *con, u64 seq)
 {
 	short flags;
@@ -3517,9 +3639,6 @@ static bool printer_should_wake(struct console *con, u64 seq)
 	if (kthread_should_stop() || !printk_kthreads_available)
 		return true;
 
-	if (console_suspended)
-		return false;
-
 	if (!con->write)
 		return false;
 
@@ -3530,8 +3649,12 @@ static bool printer_should_wake(struct console *con, u64 seq)
 	 * attempting to print and instead go back to sleep.
 	 */
 	flags = data_race(READ_ONCE(con->flags));
-	if (!(flags & CON_ENABLED))
+
+	if (!(flags & CON_ENABLED) ||
+	    (flags & CON_THD_BLOCKED) ||
+	    console_kthreads_atomically_blocked()) {
 		return false;
+	}
 
 	if (atomic_read(&printk_prefer_direct))
 		return false;
@@ -3544,7 +3667,6 @@ static int printk_kthread_func(void *data)
 	struct console *con = data;
 	char *dropped_text = NULL;
 	char *ext_text = NULL;
-	bool handover;
 	u64 seq = 0;
 	char *text;
 	int error;
@@ -3595,15 +3717,18 @@ static int printk_kthread_func(void *data)
 		if (error)
 			continue;
 
-		console_lock();
+		error = mutex_lock_interruptible(&con->lock);
+		if (error)
+			continue;
 
-		if (console_suspended) {
-			__console_unlock();
+		if (!console_is_usable(con)) {
+			mutex_unlock(&con->lock);
 			continue;
 		}
 
-		if (!console_is_usable(con)) {
-			__console_unlock();
+		if ((con->flags & CON_THD_BLOCKED) ||
+		    !console_kthread_printing_tryenter()) {
+			mutex_unlock(&con->lock);
 			continue;
 		}
 
@@ -3616,13 +3741,13 @@ static int printk_kthread_func(void *data)
 		 * which can conditionally invoke cond_resched().
 		 */
 		console_may_schedule = 0;
-		console_emit_next_record(con, text, ext_text, dropped_text, &handover);
-		if (handover)
-			continue;
+		console_emit_next_record(con, text, ext_text, dropped_text);
 
 		seq = con->seq;
 
-		__console_unlock();
+		console_kthread_printing_exit();
+
+		mutex_unlock(&con->lock);
 	}
 
 	printk_console_msg(con, KERN_INFO, "printing thread stopped");
-- 
2.30.2

