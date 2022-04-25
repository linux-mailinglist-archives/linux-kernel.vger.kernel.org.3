Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3659450EAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245264AbiDYVBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiDYVBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:01:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D77D1E3C8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:58:31 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650920308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UY5RJ+Zyy6ce4bfXgS6yXi9gS6dLltwewrlRAT19XNE=;
        b=gSVXveJQ/X++zOl8TLlzKhJeYaqhu12ZpqNJ4IHQlGCasii9i47gDqToY3CkRVnSq93sH/
        FnRLKCfLWFnHApprLwm2Dh/lrs5uAsQ3O+WYmGuyWFg2SSbRFU5v55UqfkPwhTRsMwFWNA
        TmC8jdqzrQL+k9B0EOTPqXoqOdYFe0il3nkJ1K9lSWcAx4RejshuHOBY5If/razotfojPO
        /tEK6ToynKc6CspU/mHuFRJv6LtwuohPFAV929rvMeIvn7w/hT+yNPbN/XQ7sDkk9G68Il
        MlX6HkYmhrW9GvRePHHzFZg3pialYKmNzVkCdx2HuyJqpEdnqBuWHxR6eSdf5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650920308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UY5RJ+Zyy6ce4bfXgS6yXi9gS6dLltwewrlRAT19XNE=;
        b=eKMoQ9Jo1wN6ygxuIuqp/BxwjvnmhtBGg7Xb7imxklHhtjZ14JH17D782LpHlfO6eUsU0P
        gbM9i7MqDJLtBAAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 1/1] printk: extend console_lock for per-console
 locking
In-Reply-To: <20220421212250.565456-15-john.ogness@linutronix.de>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de>
Date:   Mon, 25 Apr 2022 23:04:28 +0206
Message-ID: <878rrs6ft7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
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
and a new console boolean field @blocked to provide this
synchronization.

console_lock() is modified so that it must acquire the mutex
of each console in order to set the @blocked field. Console
printing threads will acquire their mutex while printing a
record. If @blocked was set, the thread will go back to sleep
instead of printing.

The reason for the @blocked boolean field is so that
console_lock() callers do not need to acquire multiple console
mutexes simultaneously, which would introduce unnecessary
complexity due to nested mutex locking. Also, a new field
was chosen instead of adding a new @flags value so that the
blocked status could be checked without concern of reading
inconsistent values due to @flags updates from other contexts.

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
                con->blocked = true;
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
        if (!con->blocked) {
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
@console_suspended. The check for the @blocked field implicitly
covers the suspended console case.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---

 Changes since v4 of this patch:

 - Use new @blocked field instead of CON_THD_BLOCKED flag.

 - Remove console_flags_set()/console_flags_clear() macros for
   updating @flags (and remove their race comments).

 - For printer_should_wake() and printk_kthread_func(), check
   @blocked before checking @flags.

 - Update commit message and comments appropriately.

 include/linux/console.h |  15 +++
 kernel/printk/printk.c  | 261 +++++++++++++++++++++++++++++++---------
 2 files changed, 220 insertions(+), 56 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 9a251e70c090..143653090c48 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -16,6 +16,7 @@
 
 #include <linux/atomic.h>
 #include <linux/types.h>
+#include <linux/mutex.h>
 
 struct vc_data;
 struct console_font_op;
@@ -154,6 +155,20 @@ struct console {
 	u64	seq;
 	unsigned long dropped;
 	struct task_struct *thread;
+	bool	blocked;
+
+	/*
+	 * The per-console lock is used by printing kthreads to synchronize
+	 * this console with callers of console_lock(). This is necessary in
+	 * order to allow printing kthreads to run in parallel to each other,
+	 * while each safely accessing the @blocked field and synchronizing
+	 * against direct printing via console_lock/console_unlock.
+	 *
+	 * Note: For synchronizing against direct printing via
+	 *       console_trylock/console_unlock, see the static global
+	 *       variable @console_kthreads_active.
+	 */
+	struct mutex lock;
 
 	void	*data;
 	struct	 console *next;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e4cdc424c826..750d1229cc11 100644
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
+ * Writing to this variable requires holding @console_sem.
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
+		con->blocked = true;
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
+		con->blocked = false;
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
+ * Requires holding the console_lock.
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
 
@@ -3081,10 +3206,6 @@ void console_start(struct console *console)
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
@@ -3286,6 +3407,8 @@ void register_console(struct console *newcon)
 
 	newcon->dropped = 0;
 	newcon->thread = NULL;
+	newcon->blocked = true;
+	mutex_init(&newcon->lock);
 
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/* Get a consistent copy of @syslog_seq. */
@@ -3586,6 +3709,19 @@ static void printk_fallback_preferred_direct(void)
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
@@ -3593,8 +3729,10 @@ static bool printer_should_wake(struct console *con, u64 seq)
 	if (kthread_should_stop() || !printk_kthreads_available)
 		return true;
 
-	if (console_suspended)
+	if (con->blocked ||
+	    console_kthreads_atomically_blocked()) {
 		return false;
+	}
 
 	/*
 	 * This is an unsafe read from con->flags, but a false positive is
@@ -3615,7 +3753,6 @@ static int printk_kthread_func(void *data)
 	struct console *con = data;
 	char *dropped_text = NULL;
 	char *ext_text = NULL;
-	bool handover;
 	u64 seq = 0;
 	char *text;
 	int error;
@@ -3665,15 +3802,27 @@ static int printk_kthread_func(void *data)
 		if (error)
 			continue;
 
-		console_lock();
+		error = mutex_lock_interruptible(&con->lock);
+		if (error)
+			continue;
 
-		if (console_suspended) {
-			up_console_sem();
+		if (con->blocked ||
+		    !console_kthread_printing_tryenter()) {
+			/* Another context has locked the console_lock. */
+			mutex_unlock(&con->lock);
 			continue;
 		}
 
-		if (!console_is_usable(con)) {
-			__console_unlock();
+		/*
+		 * Although this context has not locked the console_lock, it
+		 * is known that the console_lock is not locked and it is not
+		 * possible for any other context to lock the console_lock.
+		 * Therefore it is safe to read con->flags.
+		 */
+
+		if (!__console_is_usable(con->flags)) {
+			console_kthread_printing_exit();
+			mutex_unlock(&con->lock);
 			continue;
 		}
 
@@ -3686,13 +3835,13 @@ static int printk_kthread_func(void *data)
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

base-commit: 09c5ba0aa2fcfdadb17d045c3ee6f86d69270df7
-- 
2.30.2
