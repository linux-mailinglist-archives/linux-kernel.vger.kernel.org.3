Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22995557E47
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiFWOwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiFWOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:52:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B57548888;
        Thu, 23 Jun 2022 07:52:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1FCC921D1D;
        Thu, 23 Jun 2022 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655995925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bLPAGeWGpbjSHRG0xWVSKYgr8aP2pPkDaztOHBRBFPM=;
        b=JE2/FNKvAXajc6pJe9ot9CLUlqNMkOVvKMMxabaL+n6+9S9jbSPCFkIl2wI62+nlB1om6S
        yayGbNPQdiYXIcwQZH9VqxCxaV2CzF/ypZ4O9rBtasFvHJxXgvZfOy+hksafebw7Jg7xck
        9rbdVDTaX6c5xCkRgWsJXjolMm0cm/k=
Received: from alley.suse.cz (unknown [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id E72D32C142;
        Thu, 23 Jun 2022 14:52:03 +0000 (UTC)
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
Subject: [PATCH 4/6] Revert "printk: extend console_lock for per-console locking"
Date:   Thu, 23 Jun 2022 16:51:55 +0200
Message-Id: <20220623145157.21938-5-pmladek@suse.com>
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

This reverts commit 8e274732115f63c1d09136284431b3555bd5cc56.

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
 include/linux/console.h |  15 ---
 kernel/printk/printk.c  | 261 +++++++++-------------------------------
 2 files changed, 56 insertions(+), 220 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 143653090c48..9a251e70c090 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -16,7 +16,6 @@
 
 #include <linux/atomic.h>
 #include <linux/types.h>
-#include <linux/mutex.h>
 
 struct vc_data;
 struct console_font_op;
@@ -155,20 +154,6 @@ struct console {
 	u64	seq;
 	unsigned long dropped;
 	struct task_struct *thread;
-	bool	blocked;
-
-	/*
-	 * The per-console lock is used by printing kthreads to synchronize
-	 * this console with callers of console_lock(). This is necessary in
-	 * order to allow printing kthreads to run in parallel to each other,
-	 * while each safely accessing the @blocked field and synchronizing
-	 * against direct printing via console_lock/console_unlock.
-	 *
-	 * Note: For synchronizing against direct printing via
-	 *       console_trylock/console_unlock, see the static global
-	 *       variable @console_kthreads_active.
-	 */
-	struct mutex lock;
 
 	void	*data;
 	struct	 console *next;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dfd1a19b95d6..ae489dc685a1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -223,33 +223,6 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 /* Number of registered extended console drivers. */
 static int nr_ext_console_drivers;
 
-/*
- * Used to synchronize printing kthreads against direct printing via
- * console_trylock/console_unlock.
- *
- * Values:
- * -1 = console kthreads atomically blocked (via global trylock)
- *  0 = no kthread printing, console not locked (via trylock)
- * >0 = kthread(s) actively printing
- *
- * Note: For synchronizing against direct printing via
- *       console_lock/console_unlock, see the @lock variable in
- *       struct console.
- */
-static atomic_t console_kthreads_active = ATOMIC_INIT(0);
-
-#define console_kthreads_atomic_tryblock() \
-	(atomic_cmpxchg(&console_kthreads_active, 0, -1) == 0)
-#define console_kthreads_atomic_unblock() \
-	atomic_cmpxchg(&console_kthreads_active, -1, 0)
-#define console_kthreads_atomically_blocked() \
-	(atomic_read(&console_kthreads_active) == -1)
-
-#define console_kthread_printing_tryenter() \
-	atomic_inc_unless_negative(&console_kthreads_active)
-#define console_kthread_printing_exit() \
-	atomic_dec(&console_kthreads_active)
-
 /*
  * Helper macros to handle lockdep when locking/unlocking console_sem. We use
  * macros instead of functions so that _RET_IP_ contains useful information.
@@ -297,49 +270,6 @@ static bool panic_in_progress(void)
 	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
 }
 
-/*
- * Tracks whether kthread printers are all blocked. A value of true implies
- * that the console is locked via console_lock() or the console is suspended.
- * Writing to this variable requires holding @console_sem.
- */
-static bool console_kthreads_blocked;
-
-/*
- * Block all kthread printers from a schedulable context.
- *
- * Requires holding @console_sem.
- */
-static void console_kthreads_block(void)
-{
-	struct console *con;
-
-	for_each_console(con) {
-		mutex_lock(&con->lock);
-		con->blocked = true;
-		mutex_unlock(&con->lock);
-	}
-
-	console_kthreads_blocked = true;
-}
-
-/*
- * Unblock all kthread printers from a schedulable context.
- *
- * Requires holding @console_sem.
- */
-static void console_kthreads_unblock(void)
-{
-	struct console *con;
-
-	for_each_console(con) {
-		mutex_lock(&con->lock);
-		con->blocked = false;
-		mutex_unlock(&con->lock);
-	}
-
-	console_kthreads_blocked = false;
-}
-
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
@@ -2673,6 +2603,13 @@ void resume_console(void)
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
 
@@ -2691,14 +2628,9 @@ static int console_cpu_notify(unsigned int cpu)
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
-		else {
-			/*
-			 * If a new CPU comes online, the conditions for
-			 * printer_should_wake() may have changed for some
-			 * kthread printer with !CON_ANYTIME.
-			 */
-			wake_up_klogd();
-		}
+
+		/* Wake kthread printers. Some may have become usable. */
+		wake_up_klogd();
 	}
 	return 0;
 }
@@ -2718,7 +2650,6 @@ void console_lock(void)
 	down_console_sem();
 	if (console_suspended)
 		return;
-	console_kthreads_block();
 	console_locked = 1;
 	console_may_schedule = 1;
 }
@@ -2740,10 +2671,6 @@ int console_trylock(void)
 		up_console_sem();
 		return 0;
 	}
-	if (!console_kthreads_atomic_tryblock()) {
-		up_console_sem();
-		return 0;
-	}
 	console_locked = 1;
 	console_may_schedule = 0;
 	return 1;
@@ -2752,7 +2679,7 @@ EXPORT_SYMBOL(console_trylock);
 
 int is_console_locked(void)
 {
-	return (console_locked || atomic_read(&console_kthreads_active));
+	return console_locked;
 }
 EXPORT_SYMBOL(is_console_locked);
 
@@ -2796,7 +2723,7 @@ static inline bool __console_is_usable(short flags)
  * Check if the given console is currently capable and allowed to print
  * records.
  *
- * Requires holding the console_lock.
+ * Requires the console_lock.
  */
 static inline bool console_is_usable(struct console *con)
 {
@@ -2809,22 +2736,6 @@ static inline bool console_is_usable(struct console *con)
 static void __console_unlock(void)
 {
 	console_locked = 0;
-
-	/*
-	 * Depending on whether console_lock() or console_trylock() was used,
-	 * appropriately allow the kthread printers to continue.
-	 */
-	if (console_kthreads_blocked)
-		console_kthreads_unblock();
-	else
-		console_kthreads_atomic_unblock();
-
-	/*
-	 * New records may have arrived while the console was locked.
-	 * Wake the kthread printers to print them.
-	 */
-	wake_up_klogd();
-
 	up_console_sem();
 }
 
@@ -2842,19 +2753,17 @@ static void __console_unlock(void)
  *
  * @handover will be set to true if a printk waiter has taken over the
  * console_lock, in which case the caller is no longer holding the
- * console_lock. Otherwise it is set to false. A NULL pointer may be provided
- * to disable allowing the console_lock to be taken over by a printk waiter.
+ * console_lock. Otherwise it is set to false.
  *
  * Returns false if the given console has no next record to print, otherwise
  * true.
  *
- * Requires the console_lock if @handover is non-NULL.
- * Requires con->lock otherwise.
+ * Requires the console_lock.
  */
-static bool __console_emit_next_record(struct console *con, char *text, char *ext_text,
-				       char *dropped_text, bool *handover)
+static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
+				     char *dropped_text, bool *handover)
 {
-	static atomic_t panic_console_dropped = ATOMIC_INIT(0);
+	static int panic_console_dropped;
 	struct printk_info info;
 	struct printk_record r;
 	unsigned long flags;
@@ -2863,8 +2772,7 @@ static bool __console_emit_next_record(struct console *con, char *text, char *ex
 
 	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
-	if (handover)
-		*handover = false;
+	*handover = false;
 
 	if (!prb_read_valid(prb, con->seq, &r))
 		return false;
@@ -2872,8 +2780,7 @@ static bool __console_emit_next_record(struct console *con, char *text, char *ex
 	if (con->seq != r.info->seq) {
 		con->dropped += r.info->seq - con->seq;
 		con->seq = r.info->seq;
-		if (panic_in_progress() &&
-		    atomic_fetch_inc_relaxed(&panic_console_dropped) > 10) {
+		if (panic_in_progress() && panic_console_dropped++ > 10) {
 			suppress_panic_printk = 1;
 			pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
 		}
@@ -2895,61 +2802,31 @@ static bool __console_emit_next_record(struct console *con, char *text, char *ex
 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
 	}
 
-	if (handover) {
-		/*
-		 * While actively printing out messages, if another printk()
-		 * were to occur on another CPU, it may wait for this one to
-		 * finish. This task can not be preempted if there is a
-		 * waiter waiting to take over.
-		 *
-		 * Interrupts are disabled because the hand over to a waiter
-		 * must not be interrupted until the hand over is completed
-		 * (@console_waiter is cleared).
-		 */
-		printk_safe_enter_irqsave(flags);
-		console_lock_spinning_enable();
-
-		/* don't trace irqsoff print latency */
-		stop_critical_timings();
-	}
+	/*
+	 * While actively printing out messages, if another printk()
+	 * were to occur on another CPU, it may wait for this one to
+	 * finish. This task can not be preempted if there is a
+	 * waiter waiting to take over.
+	 *
+	 * Interrupts are disabled because the hand over to a waiter
+	 * must not be interrupted until the hand over is completed
+	 * (@console_waiter is cleared).
+	 */
+	printk_safe_enter_irqsave(flags);
+	console_lock_spinning_enable();
 
+	stop_critical_timings();	/* don't trace print latency */
 	call_console_driver(con, write_text, len, dropped_text);
+	start_critical_timings();
 
 	con->seq++;
 
-	if (handover) {
-		start_critical_timings();
-		*handover = console_lock_spinning_disable_and_check();
-		printk_safe_exit_irqrestore(flags);
-	}
+	*handover = console_lock_spinning_disable_and_check();
+	printk_safe_exit_irqrestore(flags);
 skip:
 	return true;
 }
 
-/*
- * Print a record for a given console, but allow another printk() caller to
- * take over the console_lock and continue printing.
- *
- * Requires the console_lock, but depending on @handover after the call, the
- * caller may no longer have the console_lock.
- *
- * See __console_emit_next_record() for argument and return details.
- */
-static bool console_emit_next_record_transferable(struct console *con, char *text, char *ext_text,
-						  char *dropped_text, bool *handover)
-{
-	/*
-	 * Handovers are only supported if threaded printers are atomically
-	 * blocked. The context taking over the console_lock may be atomic.
-	 */
-	if (!console_kthreads_atomically_blocked()) {
-		*handover = false;
-		handover = NULL;
-	}
-
-	return __console_emit_next_record(con, text, ext_text, dropped_text, handover);
-}
-
 /*
  * Print out all remaining records to all consoles.
  *
@@ -3001,11 +2878,13 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 			if (con->flags & CON_EXTENDED) {
 				/* Extended consoles do not print "dropped messages". */
-				progress = console_emit_next_record_transferable(con, &text[0],
-								&ext_text[0], NULL, handover);
+				progress = console_emit_next_record(con, &text[0],
+								    &ext_text[0], NULL,
+								    handover);
 			} else {
-				progress = console_emit_next_record_transferable(con, &text[0],
-								NULL, &dropped_text[0], handover);
+				progress = console_emit_next_record(con, &text[0],
+								    NULL, &dropped_text[0],
+								    handover);
 			}
 			if (*handover)
 				return false;
@@ -3120,10 +2999,6 @@ void console_unblank(void)
 	if (oops_in_progress) {
 		if (down_trylock_console_sem() != 0)
 			return;
-		if (!console_kthreads_atomic_tryblock()) {
-			up_console_sem();
-			return;
-		}
 	} else
 		console_lock();
 
@@ -3206,6 +3081,10 @@ void console_start(struct console *console)
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
@@ -3407,8 +3286,6 @@ void register_console(struct console *newcon)
 
 	newcon->dropped = 0;
 	newcon->thread = NULL;
-	newcon->blocked = true;
-	mutex_init(&newcon->lock);
 
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/* Get a consistent copy of @syslog_seq. */
@@ -3709,19 +3586,6 @@ static void printk_fallback_preferred_direct(void)
 	console_unlock();
 }
 
-/*
- * Print a record for a given console, not allowing another printk() caller
- * to take over. This is appropriate for contexts that do not have the
- * console_lock.
- *
- * See __console_emit_next_record() for argument and return details.
- */
-static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
-				     char *dropped_text)
-{
-	return __console_emit_next_record(con, text, ext_text, dropped_text, NULL);
-}
-
 static bool printer_should_wake(struct console *con, u64 seq)
 {
 	short flags;
@@ -3729,10 +3593,8 @@ static bool printer_should_wake(struct console *con, u64 seq)
 	if (kthread_should_stop() || !printk_kthreads_available)
 		return true;
 
-	if (con->blocked ||
-	    console_kthreads_atomically_blocked()) {
+	if (console_suspended)
 		return false;
-	}
 
 	/*
 	 * This is an unsafe read from con->flags, but a false positive is
@@ -3753,6 +3615,7 @@ static int printk_kthread_func(void *data)
 	struct console *con = data;
 	char *dropped_text = NULL;
 	char *ext_text = NULL;
+	bool handover;
 	u64 seq = 0;
 	char *text;
 	int error;
@@ -3802,27 +3665,15 @@ static int printk_kthread_func(void *data)
 		if (error)
 			continue;
 
-		error = mutex_lock_interruptible(&con->lock);
-		if (error)
-			continue;
+		console_lock();
 
-		if (con->blocked ||
-		    !console_kthread_printing_tryenter()) {
-			/* Another context has locked the console_lock. */
-			mutex_unlock(&con->lock);
+		if (console_suspended) {
+			up_console_sem();
 			continue;
 		}
 
-		/*
-		 * Although this context has not locked the console_lock, it
-		 * is known that the console_lock is not locked and it is not
-		 * possible for any other context to lock the console_lock.
-		 * Therefore it is safe to read con->flags.
-		 */
-
-		if (!__console_is_usable(con->flags)) {
-			console_kthread_printing_exit();
-			mutex_unlock(&con->lock);
+		if (!console_is_usable(con)) {
+			__console_unlock();
 			continue;
 		}
 
@@ -3835,13 +3686,13 @@ static int printk_kthread_func(void *data)
 		 * which can conditionally invoke cond_resched().
 		 */
 		console_may_schedule = 0;
-		console_emit_next_record(con, text, ext_text, dropped_text);
+		console_emit_next_record(con, text, ext_text, dropped_text, &handover);
+		if (handover)
+			continue;
 
 		seq = con->seq;
 
-		console_kthread_printing_exit();
-
-		mutex_unlock(&con->lock);
+		__console_unlock();
 	}
 
 	con_printk(KERN_INFO, con, "printing thread stopped\n");
-- 
2.35.3

