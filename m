Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34651508A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378951AbiD2QSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbiD2QSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:18:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE2ECD662;
        Fri, 29 Apr 2022 09:14:47 -0700 (PDT)
Date:   Fri, 29 Apr 2022 18:14:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651248885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yaD0dBmIVg6N44VAeTBZ1Ugl+lZrVnj4dLlWZVYYXhU=;
        b=zgSaY5kvxUKJdo39EGaxzL1jOFEiHjfi8iW9kJgJPdem3kh+63gL5PZeQJ9MNIJKywHS0A
        /4QswSn7u8RsSbU9N2501/1363BZw/aq6bJVlxcnY11+9Vy/34DkJmK5ALWpPDzizPiQEf
        SgAA6MW1ntVDIDg+Wk9uhriX4JU5hchtnsTUaWsnGmAc2+bl5nZT1Kw8+yOqDwO5MQfTxs
        gtlRjmOgO8pvS+IG3h53jVs9rTGvtCN23ul5E1Ir7LvNyTLZcY4N54CYZw3mcg/1qPZM6s
        KEeB4vi7z9uI1H/ea9u8DLh5OJHg4RIbDIyMLzeF7ZVwrLGr/VwokEGSF9HcFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651248885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yaD0dBmIVg6N44VAeTBZ1Ugl+lZrVnj4dLlWZVYYXhU=;
        b=qU8dvp4IErrVio55741xQCITIJrqvYGiICGvmVdM7faL2D1HpDmj9SLllR3T3XtdPOZd/E
        dXcZ37kQOQZGKgBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.18-rc4-rt3
Message-ID: <YmwO9LGfNv+FhwJz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.18-rc4-rt3 patch set. 

Changes since v5.18-rc4-rt2:

  - Update John's printk series to v4.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.18-rc4-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/incr/patch-5.18-rc4-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.18-rc4-rt3

The RT patch against v5.18-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/older/patch-5.18-rc4-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/older/patches-5.18-rc4-rt3.tar.xz

Sebastian
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index cdaba7a333f4d..28d4f011211a0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1224,6 +1224,7 @@ static void autoconfig(struct uart_8250_port *up)
 	unsigned char status1, scratch, scratch2, scratch3;
 	unsigned char save_lcr, save_mcr;
 	struct uart_port *port = &up->port;
+	unsigned long cs_flags;
 	unsigned long flags;
 	unsigned int old_capabilities;
 	bool is_console;
@@ -1244,8 +1245,6 @@ static void autoconfig(struct uart_8250_port *up)
 	up->bugs = 0;
 
 	if (!(port->flags & UPF_BUGGY_UART)) {
-		unsigned long cs_flags;
-
 		is_console = uart_console(port);
 
 		if (is_console)
diff --git a/include/linux/console.h b/include/linux/console.h
index 5093055bf7904..8a813cbaf9285 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -137,7 +137,6 @@ static inline int con_debug_leave(void)
 #define CON_ANYTIME	(16) /* Safe to call when cpu is offline */
 #define CON_BRL		(32) /* Used for a braille device */
 #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
-#define CON_THD_BLOCKED	(128) /* Thread blocked because console is locked */
 
 #ifdef CONFIG_HAVE_ATOMIC_CONSOLE
 struct console_atomic_data {
@@ -169,12 +168,13 @@ struct console {
 	struct console_atomic_data *atomic_data;
 #endif
 	struct task_struct *thread;
+	bool	blocked;
 
 	/*
 	 * The per-console lock is used by printing kthreads to synchronize
 	 * this console with callers of console_lock(). This is necessary in
 	 * order to allow printing kthreads to run in parallel to each other,
-	 * while each safely accessing their own @flags and synchronizing
+	 * while each safely accessing the @blocked field and synchronizing
 	 * against direct printing via console_lock/console_unlock.
 	 *
 	 * Note: For synchronizing against direct printing via
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index bae7765fe622e..2311a0ad584a0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -301,7 +301,7 @@ static bool panic_in_progress(void)
 /*
  * Tracks whether kthread printers are all blocked. A value of true implies
  * that the console is locked via console_lock() or the console is suspended.
- * Reading and writing to this variable requires holding @console_sem.
+ * Writing to this variable requires holding @console_sem.
  */
 static bool console_kthreads_blocked;
 
@@ -316,7 +316,7 @@ static void console_kthreads_block(void)
 
 	for_each_console(con) {
 		mutex_lock(&con->lock);
-		con->flags |= CON_THD_BLOCKED;
+		con->blocked = true;
 		mutex_unlock(&con->lock);
 	}
 
@@ -334,7 +334,7 @@ static void console_kthreads_unblock(void)
 
 	for_each_console(con) {
 		mutex_lock(&con->lock);
-		con->flags &= ~CON_THD_BLOCKED;
+		con->blocked = false;
 		mutex_unlock(&con->lock);
 	}
 
@@ -2756,7 +2756,11 @@ static int console_cpu_notify(unsigned int cpu)
 		if (console_trylock())
 			console_unlock();
 		else {
-			/* Some kthread printers may have become usable. */
+			/*
+			 * If a new CPU comes online, the conditions for
+			 * printer_should_wake() may have changed for some
+			 * kthread printer with !CON_ANYTIME.
+			 */
 			wake_up_klogd();
 		}
 	}
@@ -2783,25 +2787,6 @@ void console_lock(void)
 }
 EXPORT_SYMBOL(console_lock);
 
-/*
- * Lock the console_lock, but rather than blocking all the kthread printers,
- * lock a specified kthread printer and hold the lock. This is useful if
- * console flags for a particular console need to be updated.
- */
-static void console_lock_single_hold(struct console *con)
-{
-	might_sleep();
-	down_console_sem();
-	mutex_lock(&con->lock);
-	console_may_schedule = 1;
-}
-
-static void console_unlock_single_release(struct console *con)
-{
-	mutex_unlock(&con->lock);
-	up_console_sem();
-}
-
 /**
  * console_trylock - try to lock the console system for exclusive use.
  *
@@ -2885,7 +2870,7 @@ static inline bool __console_is_usable(short flags)
  * Check if the given console is currently capable and allowed to print
  * records.
  *
- * Requires holding the console_lock or con->lock.
+ * Requires holding the console_lock.
  */
 static inline bool console_is_usable(struct console *con, bool atomic_printing)
 {
@@ -3008,6 +2993,7 @@ static void write_console_seq(struct console *con, u64 val, bool atomic_printing
  * true.
  *
  * Requires the console_lock if @handover is non-NULL.
+ * Requires con->lock otherwise.
  */
 static bool __console_emit_next_record(struct console *con, char *text, char *ext_text,
 				       char *dropped_text, bool atomic_printing,
@@ -3197,13 +3183,12 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	return any_usable;
 }
 
-#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+#if defined(CONFIG_HAVE_ATOMIC_CONSOLE) && defined(CONFIG_PRINTK)
 static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
 				     char *dropped_text, bool atomic_printing);
 
 static void atomic_console_flush_all(void)
 {
-	bool any_usable = false;
 	unsigned long flags;
 	struct console *con;
 	bool any_progress;
@@ -3227,7 +3212,6 @@ static void atomic_console_flush_all(void)
 
 			if (!console_is_usable(con, true))
 				continue;
-			any_usable = true;
 
 			if (con->flags & CON_EXTENDED) {
 				/* Extended consoles do not print "dropped messages". */
@@ -3257,7 +3241,7 @@ static void atomic_console_flush_all(void)
 
 	printk_cpu_sync_put_irqrestore(flags);
 }
-#else /* CONFIG_HAVE_ATOMIC_CONSOLE */
+#else /* CONFIG_HAVE_ATOMIC_CONSOLE && CONFIG_PRINTK */
 #define atomic_console_flush_all()
 #endif
 
@@ -3430,20 +3414,17 @@ struct tty_driver *console_device(int *index)
 void console_stop(struct console *console)
 {
 	__pr_flush(console, 1000, true);
-	console_lock_single_hold(console);
+	console_lock();
 	console->flags &= ~CON_ENABLED;
-	console_unlock_single_release(console);
+	console_unlock();
 }
 EXPORT_SYMBOL(console_stop);
 
-
 void console_start(struct console *console)
 {
-	console_lock_single_hold(console);
+	console_lock();
 	console->flags |= CON_ENABLED;
-	console_unlock_single_release(console);
-	/* Wake the newly enabled kthread printer. */
-	wake_up_klogd();
+	console_unlock();
 	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
@@ -3645,7 +3626,7 @@ void register_console(struct console *newcon)
 
 	atomic_long_set(&newcon->dropped, 0);
 	newcon->thread = NULL;
-	newcon->flags |= CON_THD_BLOCKED;
+	newcon->blocked = true;
 	mutex_init(&newcon->lock);
 #ifdef CONFIG_HAVE_ATOMIC_CONSOLE
 	newcon->atomic_data = NULL;
@@ -3703,7 +3684,7 @@ int unregister_console(struct console *console)
 		return 0;
 
 	res = -ENODEV;
-	console_lock_single_hold(console);
+	console_lock();
 	if (console_drivers == console) {
 		console_drivers=console->next;
 		res = 0;
@@ -3733,14 +3714,14 @@ int unregister_console(struct console *console)
 	console->flags &= ~CON_ENABLED;
 
 	/*
-	 * console->thread can only be cleared while holding con->lock. But
-	 * stopping the thread must be done without con->lock. The task that
-	 * clears @thread is the task that stops the kthread.
+	 * console->thread can only be cleared under the console lock. But
+	 * stopping the thread must be done without the console lock. The
+	 * task that clears @thread is the task that stops the kthread.
 	 */
 	thd = console->thread;
 	console->thread = NULL;
 
-	console_unlock_single_release(console);
+	console_unlock();
 
 	if (thd)
 		kthread_stop(thd);
@@ -3758,7 +3739,7 @@ int unregister_console(struct console *console)
 
 out_disable_unlock:
 	console->flags &= ~CON_ENABLED;
-	console_unlock_single_release(console);
+	console_unlock();
 
 	return res;
 }
@@ -3975,6 +3956,11 @@ static bool printer_should_wake(struct console *con, u64 seq)
 	if (kthread_should_stop() || !printk_kthreads_available)
 		return true;
 
+	if (con->blocked ||
+	    console_kthreads_atomically_blocked()) {
+		return false;
+	}
+
 	/*
 	 * This is an unsafe read from con->flags, but a false positive is
 	 * not a problem. Worst case it would allow the printer to wake up
@@ -3986,11 +3972,6 @@ static bool printer_should_wake(struct console *con, u64 seq)
 	if (!__console_is_usable(flags))
 		return false;
 
-	if ((flags & CON_THD_BLOCKED) ||
-	    console_kthreads_atomically_blocked()) {
-		return false;
-	}
-
 	return prb_read_valid(prb, seq, NULL);
 }
 
@@ -4057,13 +4038,22 @@ static int printk_kthread_func(void *data)
 		if (error)
 			continue;
 
-		if (!console_is_usable(con, false)) {
+		if (con->blocked ||
+		    !console_kthread_printing_tryenter()) {
+			/* Another context has locked the console_lock. */
 			mutex_unlock(&con->lock);
 			continue;
 		}
 
-		if ((con->flags & CON_THD_BLOCKED) ||
-		    !console_kthread_printing_tryenter()) {
+		/*
+		 * Although this context has not locked the console_lock, it
+		 * is known that the console_lock is not locked and it is not
+		 * possible for any other context to lock the console_lock.
+		 * Therefore it is safe to read con->flags.
+		 */
+
+		if (!__console_is_usable(con->flags)) {
+			console_kthread_printing_exit();
 			mutex_unlock(&con->lock);
 			continue;
 		}
@@ -4092,14 +4082,14 @@ static int printk_kthread_func(void *data)
 	kfree(ext_text);
 	kfree(text);
 
-	mutex_lock(&con->lock);
+	console_lock();
 	/*
 	 * If this kthread is being stopped by another task, con->thread will
 	 * already be NULL. That is fine. The important thing is that it is
 	 * NULL after the kthread exits.
 	 */
 	con->thread = NULL;
-	mutex_unlock(&con->lock);
+	console_unlock();
 
 	return 0;
 }
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
