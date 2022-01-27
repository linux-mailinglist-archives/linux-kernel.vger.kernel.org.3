Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C0E49E521
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbiA0Ovw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiA0Ovv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:51:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5B5C061714;
        Thu, 27 Jan 2022 06:51:51 -0800 (PST)
Date:   Thu, 27 Jan 2022 15:51:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643295108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=EFUY3d9V/DhmW0e3d/BOZXjCGxChHXYxSYqI6yl6mmA=;
        b=TzEuH6rnlNeBGZs0oTYrPiUkIUiqcEOy2myRCX3hL92Iw4Ko+lijdMyycsKHUBtNumJ7H5
        iGfwOhjQsTpgmu6i2OgRrx/x3k2Eb/6/JgGJQ2m1qgsblsbquh5VzCVjRWq/8JkECYQ1hN
        k1Glzjj5S69ad215gyLObYTcQgdbs3ydc6dtkvlZC3c8FgLF4jDeBEITJGrOghT4yK/q44
        iwC2i0tGgGEHC4ZDFA8Ppz4aGQ4D53aXZwyWQo7eLUepzOJrGuxpzGTZ4YXJGMvfO3RxK3
        bQIKGaslgqQodN3JK4ZCdiRFDt4CEfiTt8dpK2AwrESTua4ZXZGPCGGdaLmrpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643295108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=EFUY3d9V/DhmW0e3d/BOZXjCGxChHXYxSYqI6yl6mmA=;
        b=0SCuzXnzyxt/EbPUtuXNrr0wLPF3O5NQwtdvbnyI42P6GlQbhIvTLACb4ICq8elF8xvfK3
        AEb6aXV/9Nqag5AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.17-rc1-rt2
Message-ID: <YfKxg112mYzXBXib@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.17-rc1-rt2 patch set. 

Changes since v5.17-rc1-rt1:

  - Update the printk to the latest version. Patch by John Ogness.

Known issues
     - netconsole triggers WARN.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.17-rc1-rt1 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/incr/patch-5.17-rc1-rt1-rt2.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.17-rc1-rt2

The RT patch against v5.17-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patch-5.17-rc1-rt2.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patches-5.17-rc1-rt2.tar.xz

Sebastian

diff --git a/kernel/panic.c b/kernel/panic.c
index 0939c67bfb48c..ee7e26d93b410 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -232,6 +232,11 @@ void panic(const char *fmt, ...)
 		dump_stack();
 #endif
 
+	/* If atomic consoles are available, flush the kernel log. */
+	console_flush_on_panic(CONSOLE_ATOMIC_FLUSH_PENDING);
+
+	bust_spinlocks(1);
+
 	/*
 	 * If kgdb is enabled, give it a chance to run before we stop all
 	 * the other CPUs or else we won't be able to debug processes left
@@ -239,11 +244,6 @@ void panic(const char *fmt, ...)
 	 */
 	kgdb_panic(buf);
 
-	/* Use atomic consoles to dump the kernel log. */
-	console_flush_on_panic(CONSOLE_ATOMIC_FLUSH_PENDING);
-
-	bust_spinlocks(1);
-
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6621a4633c2d8..cc04e94c320c4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2043,8 +2043,10 @@ static u8 *__printk_recursion_counter(void)
 
 int printk_delay_msec __read_mostly;
 
-static inline void printk_delay(void)
+static inline void printk_delay(int level)
 {
+	boot_delay_msec(level);
+
 	if (unlikely(printk_delay_msec)) {
 		int m = printk_delay_msec;
 
@@ -2423,11 +2425,10 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
 static void call_console_driver(struct console *con, const char *text, size_t len,
-				char *dropped_text, bool atomic_printing) { }
+				char *dropped_text, bool atomic_printing) {}
 static bool suppress_message_printing(int level) { return false; }
-static void start_printk_kthread(struct console *con) { }
-static inline void boot_delay_msec(int level) { }
-static inline void printk_delay(void) { }
+static void printk_delay(int level) {}
+static void start_printk_kthread(struct console *con) {}
 
 #endif /* CONFIG_PRINTK */
 
@@ -2683,6 +2684,31 @@ int console_trylock(void)
 }
 EXPORT_SYMBOL(console_trylock);
 
+/*
+ * A variant of console_trylock() that allows specifying if the context may
+ * sleep. If yes, a trylock on @console_sem is attempted and if successful,
+ * the threaded printers are paused. This is important to ensure that
+ * sleepable contexts do not become involved in console_lock handovers and
+ * will call cond_resched() during the printing loop.
+ */
+static int console_trylock_sched(bool may_schedule)
+{
+	if (!may_schedule)
+		return console_trylock();
+
+	might_sleep();
+
+	if (down_trylock_console_sem())
+		return 0;
+	if (console_suspended) {
+		up_console_sem();
+		return 0;
+	}
+	pause_all_consoles();
+	console_may_schedule = 1;
+	return 1;
+}
+
 /*
  * This is used to help to make sure that certain paths within the VT code are
  * running with the console lock held. It is definitely not the perfect debug
@@ -2836,8 +2862,8 @@ static void write_console_seq(struct console *con, u64 val, bool atomic_printing
  *
  * @handover will be set to true if a printk waiter has taken over the
  * console_lock, in which case the caller is no longer holding the
- * console_lock. A NULL pointer may be provided to disable allowing
- * the console_lock to be taken over by a printk waiter.
+ * console_lock. Otherwise it is set to false. A NULL pointer may be provided
+ * to disable allowing the console_lock to be taken over by a printk waiter.
  */
 static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
 				     char *dropped_text, bool atomic_printing,
@@ -2917,8 +2943,7 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 		printk_safe_exit_irqrestore(flags);
 	}
 
-	boot_delay_msec(r.info->level);
-	printk_delay();
+	printk_delay(r.info->level);
 skip:
 	return true;
 }
@@ -2935,7 +2960,7 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
  *
  * @handover will be set to true if a printk waiter has taken over the
  * console_lock, in which case the caller is no longer holding the
- * console_lock.
+ * console_lock. Otherwise it is set to false.
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
@@ -3089,11 +3114,8 @@ void console_unlock(void)
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
 
@@ -3116,7 +3138,7 @@ void console_unlock(void)
 		 * Re-check if there is a new record to flush. If the trylock
 		 * fails, another context is already handling the printing.
 		 */
-	} while (prb_read_valid(prb, next_seq, NULL) && console_trylock());
+	} while (prb_read_valid(prb, next_seq, NULL) && console_trylock_sched(do_cond_resched));
 }
 EXPORT_SYMBOL(console_unlock);
 
@@ -3626,6 +3648,7 @@ static int __init printk_late_init(void)
 		start_printk_kthread(con);
 	kthreads_started = true;
 	console_unlock();
+
 	return 0;
 }
 late_initcall(printk_late_init);
diff --git a/localversion-rt b/localversion-rt
index 6f206be67cd28..c3054d08a1129 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt1
+-rt2
