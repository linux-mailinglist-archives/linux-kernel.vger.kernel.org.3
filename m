Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151E250AACB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442112AbiDUV0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442019AbiDUVZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:25:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20204E39F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:22:59 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650576178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOEeoX8Eh2E1ZEWC0TdC9iLPFs9YS4wJqIugmBTmLB8=;
        b=cVWvJtJuMhG9xMfB6cw76N1Gz1EdMD6LX6dsKe8z6kg/VY6YXy858nv2RvEXpmMICvNjZA
        zs3R2d1NZgh00pFKaPv5U8C0AiwknlJpN0XcODB8heEMvlCfRQS5Sy81KS8cBzIroCox9f
        KcZhd9XIm9eJeNtRZOHEDrA0fvDAt937SmLGIYX4sDap+Haz/ooyITuUYuDjeskU34/j2d
        q35HlCWIUeRIumYEURThVUjEIxF7dRbjTWlGJkfW4weMGqNG/2isxa5Lzh3873DY1Xi1LR
        M1JtxXDqbJBgsMkfroidqUtbT3OnAro5sJ22IzjG3/9mhqZlf4Agdx4fqonbSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650576178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOEeoX8Eh2E1ZEWC0TdC9iLPFs9YS4wJqIugmBTmLB8=;
        b=juJ7zKjH5CUvhO6FcBitKKEMjOSopcRYOihD0c38lFVhXXRu3Vy/s+NOOCzk5N38vMlne+
        okDomwf9Ix9qyMBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 14/15] printk: extend console_lock for proper kthread support
Date:   Thu, 21 Apr 2022 23:28:49 +0206
Message-Id: <20220421212250.565456-15-john.ogness@linutronix.de>
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

Threaded console printers also need to synchronize against
console_trylock() callers. Since console_trylock() may be
called from any context, the per-console mutex cannot be used
for this synchronization. (mutex_trylock() cannot be called
from atomic contexts.) Introduce a global atomic counter to
identify if any threaded printers are active. The threaded
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
        /* console_lock acquired */
}

console_trylock()
{
        if (down_trylock(&console_sem) == 0) {
                if (atomic_cmpxchg(&console_kthreads_active, 0, -1) == 0) {
                        /* console_lock acquired */
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
that have taken the console_lock via console_trylock(). Threaded
printers never take the console_lock, so they do not have a
console_lock to handover. Tasks that have used console_lock() will
block the threaded printers using a mutex and if the console_lock
is handed over to an atomic context, it would be unable to unblock
the threaded printers. However, the console_trylock() case is
really the only scenario that is interesting for handovers anyway.

@panic_console_dropped must change to atomic_t since it is no longer
protected exclusively by the console_lock.

Since threaded printers remain asleep if they see that the console
is locked, they now must be explicitly woken in __console_unlock().
This means wake_up_klogd() calls following a console_unlock() are
no longer necessary and are removed.

Also note that threaded printers no longer need to check
@console_suspended. The check for the CON_THD_BLOCKED flag
implicitly covers the suspended console case.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |  15 ++
 kernel/printk/printk.c  | 296 +++++++++++++++++++++++++++++++---------
 2 files changed, 248 insertions(+), 63 deletions(-)

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
index e4cdc424c826..7243a85564ef 100644
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
+ * Requires holding @console_sem.
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
+ * Requires holding @console_sem.
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
@@ -2603,13 +2673,6 @@ void resume_console(void)
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
 
@@ -2628,9 +2691,14 @@ static int console_cpu_notify(unsigned int cpu)
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
-
-		/* Wake kthread printers. Some may have become usable. */
-		wake_up_klogd();
+		else {
+			/*
+			 * If a new CPU comes online, the conditions for
+			 * printer_should_wake() may have changed for some
+			 * kthread printer with !CON_ANYTIME.
+			 */
+			wake_up_klogd();
+		}
 	}
 	return 0;
 }
@@ -2650,6 +2718,7 @@ void console_lock(void)
 	down_console_sem();
 	if (console_suspended)
 		return;
+	console_kthreads_block();
 	console_locked = 1;
 	console_may_schedule = 1;
 }
@@ -2671,6 +2740,10 @@ int console_trylock(void)
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
@@ -2679,7 +2752,7 @@ EXPORT_SYMBOL(console_trylock);
 
 int is_console_locked(void)
 {
-	return console_locked;
+	return (console_locked || atomic_read(&console_kthreads_active));
 }
 EXPORT_SYMBOL(is_console_locked);
 
@@ -2723,7 +2796,7 @@ static inline bool __console_is_usable(short flags)
  * Check if the given console is currently capable and allowed to print
  * records.
  *
- * Requires the console_lock.
+ * Requires holding the console_lock or con->lock.
  */
 static inline bool console_is_usable(struct console *con)
 {
@@ -2736,6 +2809,22 @@ static inline bool console_is_usable(struct console *con)
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
 
@@ -2753,17 +2842,19 @@ static void __console_unlock(void)
  *
  * @handover will be set to true if a printk waiter has taken over the
  * console_lock, in which case the caller is no longer holding the
- * console_lock. Otherwise it is set to false.
+ * console_lock. Otherwise it is set to false. A NULL pointer may be provided
+ * to disable allowing the console_lock to be taken over by a printk waiter.
  *
  * Returns false if the given console has no next record to print, otherwise
  * true.
  *
- * Requires the console_lock.
+ * Requires the console_lock if @handover is non-NULL.
+ * Requires con->lock otherwise.
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
@@ -2772,7 +2863,8 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 
 	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
-	*handover = false;
+	if (handover)
+		*handover = false;
 
 	if (!prb_read_valid(prb, con->seq, &r))
 		return false;
@@ -2780,7 +2872,8 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 	if (con->seq != r.info->seq) {
 		con->dropped += r.info->seq - con->seq;
 		con->seq = r.info->seq;
-		if (panic_in_progress() && panic_console_dropped++ > 10) {
+		if (panic_in_progress() &&
+		    atomic_fetch_inc_relaxed(&panic_console_dropped) > 10) {
 			suppress_panic_printk = 1;
 			pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
 		}
@@ -2802,31 +2895,61 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
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
+ * See __console_emit_next_record() for argument and return details.
+ */
+static bool console_emit_next_record_transferable(struct console *con, char *text, char *ext_text,
+						  char *dropped_text, bool *handover)
+{
+	/*
+	 * Handovers are only supported if threaded printers are atomically
+	 * blocked. The context taking over the console_lock may be atomic.
+	 */
+	if (!console_kthreads_atomically_blocked()) {
+		*handover = false;
+		handover = NULL;
+	}
+
+	return __console_emit_next_record(con, text, ext_text, dropped_text, handover);
+}
+
 /*
  * Print out all remaining records to all consoles.
  *
@@ -2878,13 +3001,11 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
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
 				return false;
@@ -2999,6 +3120,10 @@ void console_unblank(void)
 	if (oops_in_progress) {
 		if (down_trylock_console_sem() != 0)
 			return;
+		if (!console_kthreads_atomic_tryblock()) {
+			up_console_sem();
+			return;
+		}
 	} else
 		console_lock();
 
@@ -3062,6 +3187,16 @@ struct tty_driver *console_device(int *index)
 	return driver;
 }
 
+/*
+ * Since the kthread printers do not acquire the console_lock but do need to
+ * access @flags, they could experience races because other tasks
+ * (synchronizing using the console_lock) can modify @flags. These macros are
+ * available to at least provide atomic variable updates so that the kthread
+ * printers can see consistent values.
+ */
+#define console_flags_set(var, flag)	WRITE_ONCE(var, READ_ONCE(var) | flag)
+#define console_flags_clear(var, flag)	WRITE_ONCE(var, READ_ONCE(var) & ~flag)
+
 /*
  * Prevent further output on the passed console device so that (for example)
  * serial drivers can disable console output before suspending a port, and can
@@ -3071,20 +3206,23 @@ void console_stop(struct console *console)
 {
 	__pr_flush(console, 1000, true);
 	console_lock();
-	console->flags &= ~CON_ENABLED;
+
+	/* Can cause races for printk_kthread_func(). */
+	console_flags_clear(console->flags, CON_ENABLED);
+
 	console_unlock();
 }
 EXPORT_SYMBOL(console_stop);
 
+
 void console_start(struct console *console)
 {
 	console_lock();
-	console->flags |= CON_ENABLED;
-	console_unlock();
 
-	/* Wake the newly enabled kthread printer. */
-	wake_up_klogd();
+	/* Can cause races for printk_kthread_func(). */
+	console_flags_set(console->flags, CON_ENABLED);
 
+	console_unlock();
 	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
@@ -3286,6 +3424,8 @@ void register_console(struct console *newcon)
 
 	newcon->dropped = 0;
 	newcon->thread = NULL;
+	newcon->flags |= CON_THD_BLOCKED;
+	mutex_init(&newcon->lock);
 
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/* Get a consistent copy of @syslog_seq. */
@@ -3363,10 +3503,13 @@ int unregister_console(struct console *console)
 	 * If this isn't the last console and it has CON_CONSDEV set, we
 	 * need to set it on the next preferred console.
 	 */
-	if (console_drivers != NULL && console->flags & CON_CONSDEV)
-		console_drivers->flags |= CON_CONSDEV;
+	if (console_drivers != NULL && console->flags & CON_CONSDEV) {
+		/* Can cause races for printk_kthread_func(). */
+		console_flags_set(console_drivers->flags, CON_CONSDEV);
+	}
 
-	console->flags &= ~CON_ENABLED;
+	/* Can cause races for printk_kthread_func(). */
+	console_flags_clear(console->flags, CON_ENABLED);
 
 	/*
 	 * console->thread can only be cleared under the console lock. But
@@ -3389,7 +3532,9 @@ int unregister_console(struct console *console)
 	return res;
 
 out_disable_unlock:
-	console->flags &= ~CON_ENABLED;
+	/* Can cause races for printk_kthread_func(). */
+	console_flags_clear(console->flags, CON_ENABLED);
+
 	console_unlock();
 
 	return res;
@@ -3586,6 +3731,19 @@ static void printk_fallback_preferred_direct(void)
 	console_unlock();
 }
 
+/*
+ * Print a record for a given console, not allowing another printk() caller
+ * to take over. This is appropriate for contexts that do not have the
+ * console_lock.
+ *
+ * See __console_emit_next_record() for argument and return details.
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
@@ -3593,9 +3751,6 @@ static bool printer_should_wake(struct console *con, u64 seq)
 	if (kthread_should_stop() || !printk_kthreads_available)
 		return true;
 
-	if (console_suspended)
-		return false;
-
 	/*
 	 * This is an unsafe read from con->flags, but a false positive is
 	 * not a problem. Worst case it would allow the printer to wake up
@@ -3607,6 +3762,11 @@ static bool printer_should_wake(struct console *con, u64 seq)
 	if (!__console_is_usable(flags))
 		return false;
 
+	if ((flags & CON_THD_BLOCKED) ||
+	    console_kthreads_atomically_blocked()) {
+		return false;
+	}
+
 	return prb_read_valid(prb, seq, NULL);
 }
 
@@ -3615,7 +3775,7 @@ static int printk_kthread_func(void *data)
 	struct console *con = data;
 	char *dropped_text = NULL;
 	char *ext_text = NULL;
-	bool handover;
+	short flags;
 	u64 seq = 0;
 	char *text;
 	int error;
@@ -3665,15 +3825,25 @@ static int printk_kthread_func(void *data)
 		if (error)
 			continue;
 
-		console_lock();
+		error = mutex_lock_interruptible(&con->lock);
+		if (error)
+			continue;
 
-		if (console_suspended) {
-			up_console_sem();
+		/*
+		 * Reading @flags could race with console_stop(),
+		 * console_start(), or console_unregister(). READ_ONCE() is
+		 * used so that there will be a consistent value.
+		 */
+		flags = data_race(READ_ONCE(con->flags));
+
+		if (!__console_is_usable(flags)) {
+			mutex_unlock(&con->lock);
 			continue;
 		}
 
-		if (!console_is_usable(con)) {
-			__console_unlock();
+		if ((flags & CON_THD_BLOCKED) ||
+		    !console_kthread_printing_tryenter()) {
+			mutex_unlock(&con->lock);
 			continue;
 		}
 
@@ -3686,13 +3856,13 @@ static int printk_kthread_func(void *data)
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
 
 	con_printk(KERN_INFO, con, "printing thread stopped\n");
-- 
2.30.2

