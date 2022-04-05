Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF934F50BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843096AbiDFBjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353501AbiDEPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:11:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C0D10854C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:25:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649165140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrrRJ4Jh7sy6m7VY3IsTkhoyDvtmzs9FV+Ir3K5rujQ=;
        b=kCZU11I9RK6wHhqwjYD7RLIKNUpK9tploRzv09+7+nn9zcCiWBJYfyFM9HyX+PNd2Bw0Xl
        I4skEQoHhw42NPbMg05phgNT/Vd+v1VScISIvkBHR0zh/0cYO3VnKP6TLzb+Ui9KrHwvwC
        cBRXXDhckHDW/DOko81E9J6jdoKkMXBKQBkatATQanJad+r7Q1VMOuJl1rjS77/CVK2DMR
        oDoeE84Mev8Smglsts4RlvbHZtEKAJPz/NF4DjUidDKXO9B4t4gQjTWuArw6y9/Gp/MbCt
        NSJk2lcRKtA0sJXia9tgOCqAt4fyvMX1cru6gFflTklLh7oGSwjNb1CsJ/znZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649165140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrrRJ4Jh7sy6m7VY3IsTkhoyDvtmzs9FV+Ir3K5rujQ=;
        b=hl2vwL5Z8M163dSY0siB9a9YRXB51zfhozycbXvOa1v7MniBOc9qGiPgOFDSZm07c3FvNf
        k2KuCWa5wUXdQKCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 06/12] printk: refactor and rework printing logic
Date:   Tue,  5 Apr 2022 15:31:29 +0206
Message-Id: <20220405132535.649171-7-john.ogness@linutronix.de>
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

Refactor/rework printing logic in order to prepare for moving to
threaded console printing.

- Move @console_seq into struct console so that the current
  "position" of each console can be tracked individually.

- Move @console_dropped into struct console so that the current drop
  count of each console can be tracked individually.

- Modify printing logic so that each console independently loads,
  prepares, and prints its next record.

- Remove exclusive_console logic. Since console positions are
  handled independently, replaying past records occurs naturally.

- Update the comments explaining why preemption is disabled while
  printing from printk() context.

With these changes, there is a change in behavior: the console
replaying the log (formerly exclusive console) will no longer block
other consoles. New messages appear on the other consoles while the
newly added console is still replaying.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |   2 +
 kernel/printk/printk.c  | 429 ++++++++++++++++++++--------------------
 2 files changed, 220 insertions(+), 211 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 7cd758a4f44e..8c1686e2c233 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -151,6 +151,8 @@ struct console {
 	int	cflag;
 	uint	ispeed;
 	uint	ospeed;
+	u64	seq;
+	unsigned long dropped;
 	void	*data;
 	struct	 console *next;
 };
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 39ca9d758e52..db9278dba775 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -280,11 +280,6 @@ static bool panic_in_progress(void)
  */
 static int console_locked, console_suspended;
 
-/*
- * If exclusive_console is non-NULL then only this console is to be printed to.
- */
-static struct console *exclusive_console;
-
 /*
  *	Array of consoles built from command line options (console=)
  */
@@ -374,12 +369,6 @@ static u64 syslog_seq;
 static size_t syslog_partial;
 static bool syslog_time;
 
-/* All 3 protected by @console_sem. */
-/* the next printk record to write to the console */
-static u64 console_seq;
-static u64 exclusive_console_stop_seq;
-static unsigned long console_dropped;
-
 struct latched_seq {
 	seqcount_latch_t	latch;
 	u64			val[2];
@@ -1911,47 +1900,26 @@ static int console_trylock_spinning(void)
 }
 
 /*
- * Call the console drivers, asking them to write out
- * log_buf[start] to log_buf[end - 1].
- * The console_lock must be held.
+ * Call the specified console driver, asking it to write out the specified
+ * text and length. For non-extended consoles, if any records have been
+ * dropped, a dropped message will be written out first.
  */
-static void call_console_drivers(const char *ext_text, size_t ext_len,
-				 const char *text, size_t len)
+static void call_console_driver(struct console *con, const char *text, size_t len)
 {
 	static char dropped_text[64];
-	size_t dropped_len = 0;
-	struct console *con;
+	size_t dropped_len;
 
 	trace_console_rcuidle(text, len);
 
-	if (!console_drivers)
-		return;
-
-	if (console_dropped) {
+	if (con->dropped && !(con->flags & CON_EXTENDED)) {
 		dropped_len = snprintf(dropped_text, sizeof(dropped_text),
 				       "** %lu printk messages dropped **\n",
-				       console_dropped);
-		console_dropped = 0;
+				       con->dropped);
+		con->dropped = 0;
+		con->write(con, dropped_text, dropped_len);
 	}
 
-	for_each_console(con) {
-		if (exclusive_console && con != exclusive_console)
-			continue;
-		if (!(con->flags & CON_ENABLED))
-			continue;
-		if (!con->write)
-			continue;
-		if (!cpu_online(smp_processor_id()) &&
-		    !(con->flags & CON_ANYTIME))
-			continue;
-		if (con->flags & CON_EXTENDED)
-			con->write(con, ext_text, ext_len);
-		else {
-			if (dropped_len)
-				con->write(con, dropped_text, dropped_len);
-			con->write(con, text, len);
-		}
-	}
+	con->write(con, text, len);
 }
 
 /*
@@ -2261,15 +2229,18 @@ asmlinkage int vprintk_emit(int facility, int level,
 	/* If called from the scheduler, we can not call up(). */
 	if (!in_sched) {
 		/*
-		 * Disable preemption to avoid being preempted while holding
-		 * console_sem which would prevent anyone from printing to
-		 * console
+		 * The caller may be holding system-critical or
+		 * timing-sensitive locks. Disable preemption during
+		 * printing of all remaining records to all consoles so that
+		 * this context can return as soon as possible. Hopefully
+		 * another printk() caller will take over the printing.
 		 */
 		preempt_disable();
 		/*
 		 * Try to acquire and then immediately release the console
-		 * semaphore.  The release will print out buffers and wake up
-		 * /dev/kmsg and syslog() users.
+		 * semaphore. The release will print out buffers. With the
+		 * spinning variant, this context tries to take over the
+		 * printing from another printing context.
 		 */
 		if (console_trylock_spinning())
 			console_unlock();
@@ -2307,11 +2278,9 @@ EXPORT_SYMBOL(_printk);
 
 #define prb_read_valid(rb, seq, r)	false
 #define prb_first_valid_seq(rb)		0
+#define prb_next_seq(rb)		0
 
 static u64 syslog_seq;
-static u64 console_seq;
-static u64 exclusive_console_stop_seq;
-static unsigned long console_dropped;
 
 static size_t record_print_text(const struct printk_record *r,
 				bool syslog, bool time)
@@ -2328,8 +2297,7 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 				  struct dev_printk_info *dev_info) { return 0; }
 static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
-static void call_console_drivers(const char *ext_text, size_t ext_len,
-				 const char *text, size_t len) {}
+static void call_console_driver(struct console *con, const char *text, size_t len) { }
 static bool suppress_message_printing(int level) { return false; }
 
 #endif /* CONFIG_PRINTK */
@@ -2599,22 +2567,6 @@ int is_console_locked(void)
 }
 EXPORT_SYMBOL(is_console_locked);
 
-/*
- * Check if we have any console that is capable of printing while cpu is
- * booting or shutting down. Requires console_sem.
- */
-static int have_callable_console(void)
-{
-	struct console *con;
-
-	for_each_console(con)
-		if ((con->flags & CON_ENABLED) &&
-				(con->flags & CON_ANYTIME))
-			return 1;
-
-	return 0;
-}
-
 /*
  * Return true when this CPU should unlock console_sem without pushing all
  * messages to the console. This reduces the chance that the console is
@@ -2635,15 +2587,173 @@ static bool abandon_console_lock_in_panic(void)
 }
 
 /*
- * Can we actually use the console at this time on this cpu?
+ * Check if the given console is currently capable and allowed to print
+ * records.
+ *
+ * Requires the console_lock.
+ */
+static inline bool console_is_usable(struct console *con)
+{
+	if (!(con->flags & CON_ENABLED))
+		return false;
+
+	if (!con->write)
+		return false;
+
+	/*
+	 * Console drivers may assume that per-cpu resources have been
+	 * allocated. So unless they're explicitly marked as being able to
+	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
+	 */
+	if (!cpu_online(raw_smp_processor_id()) &&
+	    !(con->flags & CON_ANYTIME))
+		return false;
+
+	return true;
+}
+
+static void __console_unlock(void)
+{
+	console_locked = 0;
+	up_console_sem();
+}
+
+/*
+ * Print one record for the given console. The record printed is whatever
+ * record is the next available record for the given console.
+ *
+ * Requires the console_lock.
+ *
+ * Returns false if the given console has no next record to print, otherwise
+ * true.
  *
- * Console drivers may assume that per-cpu resources have been allocated. So
- * unless they're explicitly marked as being able to cope (CON_ANYTIME) don't
- * call them until this CPU is officially up.
+ * @handover will be set to true if a printk waiter has taken over the
+ * console_lock, in which case the caller is no longer holding the
+ * console_lock. Otherwise it is set to false.
  */
-static inline int can_use_console(void)
+static bool console_emit_next_record(struct console *con, bool *handover)
 {
-	return cpu_online(raw_smp_processor_id()) || have_callable_console();
+	static char ext_text[CONSOLE_EXT_LOG_MAX];
+	static char text[CONSOLE_LOG_MAX];
+	static int panic_console_dropped;
+	struct printk_info info;
+	struct printk_record r;
+	unsigned long flags;
+	char *write_text;
+	size_t len;
+
+	prb_rec_init_rd(&r, &info, text, sizeof(text));
+
+	*handover = false;
+
+	if (!prb_read_valid(prb, con->seq, &r))
+		return false;
+
+	if (con->seq != r.info->seq) {
+		con->dropped += r.info->seq - con->seq;
+		con->seq = r.info->seq;
+		if (panic_in_progress() && panic_console_dropped++ > 10) {
+			suppress_panic_printk = 1;
+			pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
+		}
+	}
+
+	/* Skip record that has level above the console loglevel. */
+	if (suppress_message_printing(r.info->level)) {
+		con->seq++;
+		goto skip;
+	}
+
+	if (con->flags & CON_EXTENDED) {
+		write_text = &ext_text[0];
+		len = info_print_ext_header(ext_text, sizeof(ext_text), r.info);
+		len += msg_print_ext_body(ext_text + len, sizeof(ext_text) - len,
+					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
+	} else {
+		write_text = &text[0];
+		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
+	}
+
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
+
+	stop_critical_timings();	/* don't trace print latency */
+	call_console_driver(con, write_text, len);
+	start_critical_timings();
+
+	con->seq++;
+
+	*handover = console_lock_spinning_disable_and_check();
+	printk_safe_exit_irqrestore(flags);
+skip:
+	return true;
+}
+
+/*
+ * Print out all remaining records to all consoles.
+ *
+ * Requires the console_lock.
+ *
+ * Returns true if a console was available for flushing, otherwise false.
+ *
+ * @next_seq is set to the highest sequence number of all of the consoles that
+ * were flushed.
+ *
+ * @handover will be set to true if a printk waiter has taken over the
+ * console_lock, in which case the caller is no longer holding the
+ * console_lock. Otherwise it is set to false.
+ */
+static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
+{
+	bool any_usable = false;
+	struct console *con;
+	bool any_progress;
+
+	*next_seq = 0;
+	*handover = false;
+
+	do {
+		any_progress = false;
+
+		for_each_console(con) {
+			bool progress;
+
+			if (!console_is_usable(con))
+				continue;
+			any_usable = true;
+
+			progress = console_emit_next_record(con, handover);
+			if (*handover)
+				return true;
+
+			/* Track the highest seq flushed. */
+			if (con->seq > *next_seq)
+				*next_seq = con->seq;
+
+			if (!progress)
+				continue;
+			any_progress = true;
+
+			/* Allow panic_cpu to take over the consoles safely */
+			if (abandon_console_lock_in_panic())
+				return false;
+
+			if (do_cond_resched)
+				cond_resched();
+		}
+	} while (any_progress);
+
+	return any_usable;
 }
 
 /**
@@ -2662,22 +2772,16 @@ static inline int can_use_console(void)
  */
 void console_unlock(void)
 {
-	static char ext_text[CONSOLE_EXT_LOG_MAX];
-	static char text[CONSOLE_LOG_MAX];
-	static int panic_console_dropped;
-	unsigned long flags;
-	bool do_cond_resched, retry;
-	struct printk_info info;
-	struct printk_record r;
-	u64 __maybe_unused next_seq;
+	bool do_cond_resched;
+	bool handover;
+	bool flushed;
+	u64 next_seq;
 
 	if (console_suspended) {
 		up_console_sem();
 		return;
 	}
 
-	prb_rec_init_rd(&r, &info, text, sizeof(text));
-
 	/*
 	 * Console drivers are called with interrupts disabled, so
 	 * @console_may_schedule should be cleared before; however, we may
@@ -2686,125 +2790,33 @@ void console_unlock(void)
 	 * between lines if allowable.  Not doing so can cause a very long
 	 * scheduling stall on a slow console leading to RCU stall and
 	 * softlockup warnings which exacerbate the issue with more
-	 * messages practically incapacitating the system.
-	 *
-	 * console_trylock() is not able to detect the preemptive
-	 * context reliably. Therefore the value must be stored before
-	 * and cleared after the "again" goto label.
+	 * messages practically incapacitating the system. Therefore, create
+	 * a local to use for the printing loop.
 	 */
 	do_cond_resched = console_may_schedule;
-again:
-	console_may_schedule = 0;
-
-	/*
-	 * We released the console_sem lock, so we need to recheck if
-	 * cpu is online and (if not) is there at least one CON_ANYTIME
-	 * console.
-	 */
-	if (!can_use_console()) {
-		console_locked = 0;
-		up_console_sem();
-		return;
-	}
 
-	for (;;) {
-		size_t ext_len = 0;
-		int handover;
-		size_t len;
+	do {
+		console_may_schedule = 0;
 
-skip:
-		if (!prb_read_valid(prb, console_seq, &r))
+		flushed = console_flush_all(do_cond_resched, &next_seq, &handover);
+		if (handover)
 			break;
 
-		if (console_seq != r.info->seq) {
-			console_dropped += r.info->seq - console_seq;
-			console_seq = r.info->seq;
-			if (panic_in_progress() && panic_console_dropped++ > 10) {
-				suppress_panic_printk = 1;
-				pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
-			}
-		}
-
-		if (suppress_message_printing(r.info->level)) {
-			/*
-			 * Skip record we have buffered and already printed
-			 * directly to the console when we received it, and
-			 * record that has level above the console loglevel.
-			 */
-			console_seq++;
-			goto skip;
-		}
-
-		/* Output to all consoles once old messages replayed. */
-		if (unlikely(exclusive_console &&
-			     console_seq >= exclusive_console_stop_seq)) {
-			exclusive_console = NULL;
-		}
+		__console_unlock();
 
-		/*
-		 * Handle extended console text first because later
-		 * record_print_text() will modify the record buffer in-place.
-		 */
-		if (nr_ext_console_drivers) {
-			ext_len = info_print_ext_header(ext_text,
-						sizeof(ext_text),
-						r.info);
-			ext_len += msg_print_ext_body(ext_text + ext_len,
-						sizeof(ext_text) - ext_len,
-						&r.text_buf[0],
-						r.info->text_len,
-						&r.info->dev_info);
-		}
-		len = record_print_text(&r,
-				console_msg_format & MSG_FORMAT_SYSLOG,
-				printk_time);
-		console_seq++;
+		/* Were there any consoles available for flushing? */
+		if (!flushed)
+			break;
 
 		/*
-		 * While actively printing out messages, if another printk()
-		 * were to occur on another CPU, it may wait for this one to
-		 * finish. This task can not be preempted if there is a
-		 * waiter waiting to take over.
-		 *
-		 * Interrupts are disabled because the hand over to a waiter
-		 * must not be interrupted until the hand over is completed
-		 * (@console_waiter is cleared).
+		 * Some context may have added new records after
+		 * console_flush_all() but before unlocking the console.
+		 * Re-check if there is a new record to flush. If the trylock
+		 * fails, another context is already handling the printing.
 		 */
-		printk_safe_enter_irqsave(flags);
-		console_lock_spinning_enable();
-
-		stop_critical_timings();	/* don't trace print latency */
-		call_console_drivers(ext_text, ext_len, text, len);
-		start_critical_timings();
-
-		handover = console_lock_spinning_disable_and_check();
-		printk_safe_exit_irqrestore(flags);
-		if (handover)
-			return;
-
-		/* Allow panic_cpu to take over the consoles safely */
-		if (abandon_console_lock_in_panic())
-			break;
-
-		if (do_cond_resched)
-			cond_resched();
-	}
-
-	/* Get consistent value of the next-to-be-used sequence number. */
-	next_seq = console_seq;
-
-	console_locked = 0;
-	up_console_sem();
-
-	/*
-	 * Someone could have filled up the buffer again, so re-check if there's
-	 * something to flush. In case we cannot trylock the console_sem again,
-	 * there's a new owner and the console_unlock() from them will do the
-	 * flush, no worries.
-	 */
-	retry = prb_read_valid(prb, next_seq, NULL);
-	if (retry && !abandon_console_lock_in_panic() && console_trylock())
-		goto again;
+	} while (prb_read_valid(prb, next_seq, NULL) &&
+		 !abandon_console_lock_in_panic() &&
+		 console_trylock());
 }
 EXPORT_SYMBOL(console_unlock);
 
@@ -2864,8 +2876,14 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	console_trylock();
 	console_may_schedule = 0;
 
-	if (mode == CONSOLE_REPLAY_ALL)
-		console_seq = prb_first_valid_seq(prb);
+	if (mode == CONSOLE_REPLAY_ALL) {
+		struct console *c;
+		u64 seq;
+
+		seq = prb_first_valid_seq(prb);
+		for_each_console(c)
+			c->seq = seq;
+	}
 	console_unlock();
 }
 
@@ -3104,26 +3122,15 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_EXTENDED)
 		nr_ext_console_drivers++;
 
+	newcon->dropped = 0;
 	if (newcon->flags & CON_PRINTBUFFER) {
-		/*
-		 * console_unlock(); will print out the buffered messages
-		 * for us.
-		 *
-		 * We're about to replay the log buffer.  Only do this to the
-		 * just-registered console to avoid excessive message spam to
-		 * the already-registered consoles.
-		 *
-		 * Set exclusive_console with disabled interrupts to reduce
-		 * race window with eventual console_flush_on_panic() that
-		 * ignores console_lock.
-		 */
-		exclusive_console = newcon;
-		exclusive_console_stop_seq = console_seq;
-
 		/* Get a consistent copy of @syslog_seq. */
 		mutex_lock(&syslog_lock);
-		console_seq = syslog_seq;
+		newcon->seq = syslog_seq;
 		mutex_unlock(&syslog_lock);
+	} else {
+		/* Begin with next message. */
+		newcon->seq = prb_next_seq(prb);
 	}
 	console_unlock();
 	console_sysfs_notify();
-- 
2.30.2

