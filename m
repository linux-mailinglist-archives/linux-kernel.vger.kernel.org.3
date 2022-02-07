Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB644AC9D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbiBGToz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240734AbiBGTne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:43:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C69C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:43:33 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644263010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/+tO1foi0Y2Jl4gBJOBBXHVMgC1lG8mZRnsEtx1+Ms=;
        b=r6aim1QmJwP1Et76JlWvlODj8d9ZgKUCOagNmdgI965rmll3fNNo3Jy69m707YkjmPQbfR
        EvjL3Gx8sO3iHfalDPDUXFq+4kZu7myu3U3yAclfnqa6iKLhFX9ZP8wODzl779WyT7xvxw
        CZw8Qc5ench9WU9DZfS2wVpBTZweaQw99JAU5V3y9iauQPp5AdSUdfbG8Ayoxohu5cG6je
        vtIYfDJU5x4O8y8I37Qv8CQGkRZtwyi/s6KEBXbCx0K43tpVifyiAp1qGpjyCAqYBniEcQ
        m24bfBTotzPulMWFqJBolMSg1WXlZbmlHeFZpXypvBCMnGJsR8JKhXI1jpbWng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644263010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/+tO1foi0Y2Jl4gBJOBBXHVMgC1lG8mZRnsEtx1+Ms=;
        b=+X33JuijHrJU3oQTPQe1lBIS0HXGWwsg10GUeVDlZ19LG333SD6t4gHKBBQtW6st4qwUBD
        zStNmidibGj1zWAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 10/13] printk: add kthread console printers
Date:   Mon,  7 Feb 2022 20:49:20 +0106
Message-Id: <20220207194323.273637-11-john.ogness@linutronix.de>
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
 kernel/printk/printk.c  | 159 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 56a6669471a6..0f94b1771df8 100644
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
index 719b05e6ce3b..e182f31fec58 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -347,6 +347,13 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_MUTEX(syslog_lock);
 
+/*
+ * A flag to signify if printk_late_init() has already started the kthread
+ * printers. If true, any later registered consoles must start their own
+ * kthread directly. The flag is write protected by the console_lock.
+ */
+static bool kthreads_started;
+
 #ifdef CONFIG_PRINTK
 static atomic_t printk_direct = ATOMIC_INIT(0);
 
@@ -373,6 +380,14 @@ void printk_direct_exit(void)
 	atomic_dec(&printk_direct);
 }
 
+static inline bool allow_direct_printing(void)
+{
+	return (!kthreads_started ||
+		system_state != SYSTEM_RUNNING ||
+		oops_in_progress ||
+		atomic_read(&printk_direct));
+}
+
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
@@ -2225,7 +2240,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
+	if (!in_sched && allow_direct_printing()) {
 		/*
 		 * Disable preemption to avoid being preempted while holding
 		 * console_sem which would prevent anyone from printing to
@@ -2266,6 +2281,8 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
+static void start_printk_kthread(struct console *con);
+
 #else /* CONFIG_PRINTK */
 
 #define CONSOLE_LOG_MAX		0
@@ -2299,6 +2316,8 @@ static void call_console_driver(struct console *con, const char *text, size_t le
 }
 static bool suppress_message_printing(int level) { return false; }
 static void printk_delay(int level) {}
+static void start_printk_kthread(struct console *con) {}
+static bool allow_direct_printing(void) { return true; }
 
 #endif /* CONFIG_PRINTK */
 
@@ -2487,6 +2506,10 @@ void resume_console(void)
 	down_console_sem();
 	console_suspended = 0;
 	console_unlock();
+
+	/* Wake the kthread printers. */
+	wake_up_klogd();
+
 	pr_flush(1000, true);
 }
 
@@ -2702,6 +2725,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	*handover = false;
 
 	do {
+		/* Let the kthread printers do the work if they can. */
+		if (!allow_direct_printing())
+			break;
+
 		any_progress = false;
 
 		for_each_console(con) {
@@ -2910,6 +2937,10 @@ void console_start(struct console *console)
 	console_lock();
 	console->flags |= CON_ENABLED;
 	console_unlock();
+
+	/* Wake the kthread printers. */
+	wake_up_klogd();
+
 	pr_flush(1000, true);
 }
 EXPORT_SYMBOL(console_start);
@@ -3114,6 +3145,8 @@ void register_console(struct console *newcon)
 		/* Begin with next message. */
 		newcon->seq = prb_next_seq(prb);
 	}
+	if (kthreads_started)
+		start_printk_kthread(newcon);
 	console_unlock();
 	console_sysfs_notify();
 
@@ -3170,6 +3203,11 @@ int unregister_console(struct console *console)
 		}
 	}
 
+	if (console->thread) {
+		kthread_stop(console->thread);
+		console->thread = NULL;
+	}
+
 	if (res)
 		goto out_disable_unlock;
 
@@ -3275,6 +3313,13 @@ static int __init printk_late_init(void)
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "printk:online",
 					console_cpu_notify, NULL);
 	WARN_ON(ret < 0);
+
+	console_lock();
+	for_each_console(con)
+		start_printk_kthread(con);
+	kthreads_started = true;
+	console_unlock();
+
 	return 0;
 }
 late_initcall(printk_late_init);
@@ -3345,6 +3390,116 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 }
 EXPORT_SYMBOL(pr_flush);
 
+static bool printer_should_wake(struct console *con, u64 seq)
+{
+	short flags;
+
+	if (kthread_should_stop())
+		return true;
+
+	if (console_suspended)
+		return false;
+
+	/*
+	 * This is an unsafe read to con->flags, but false positives
+	 * are not an issue as long as they are rare.
+	 */
+	flags = data_race(READ_ONCE(con->flags));
+	if (!(flags & CON_ENABLED))
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
+	bool progress;
+	bool handover;
+	u64 seq = 0;
+	char *text;
+	int error;
+
+	pr_info("%sconsole [%s%d]: printing thread started\n",
+		(con->flags & CON_BOOT) ? "boot" : "",
+		con->name, con->index);
+
+	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
+	if (!text)
+		goto out;
+
+	if (con->flags & CON_EXTENDED) {
+		ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
+		if (!ext_text)
+			goto out;
+	} else {
+		dropped_text = kmalloc(DROPPED_TEXT_MAX, GFP_KERNEL);
+		if (!dropped_text)
+			goto out;
+	}
+
+	for (;;) {
+		error = wait_event_interruptible(log_wait, printer_should_wake(con, seq));
+
+		if (kthread_should_stop())
+			break;
+
+		if (error)
+			continue;
+
+		do {
+			console_lock();
+			if (console_suspended) {
+				console_unlock();
+				break;
+			}
+
+			/*
+			 * Even though the printk kthread is always preemptible, it is
+			 * still not allowed to call cond_resched() from within
+			 * console drivers. The task may become non-preemptible in the
+			 * console driver call chain. For example, vt_console_print()
+			 * takes a spinlock and then can call into fbcon_redraw(),
+			 * which can conditionally invoke cond_resched().
+			 */
+			console_may_schedule = 0;
+			progress = console_emit_next_record(con, text, ext_text,
+							    dropped_text, &handover);
+			if (handover)
+				break;
+
+			seq = con->seq;
+
+			/* Unlock console without invoking direct printing. */
+			__console_unlock();
+		} while (progress);
+	}
+out:
+	kfree(dropped_text);
+	kfree(ext_text);
+	kfree(text);
+	pr_info("%sconsole [%s%d]: printing thread stopped\n",
+		(con->flags & CON_BOOT) ? "boot" : "",
+		con->name, con->index);
+	return 0;
+}
+
+/* Must be called within console_lock(). */
+static void start_printk_kthread(struct console *con)
+{
+	con->thread = kthread_run(printk_kthread_func, con,
+				  "pr/%s%d", con->name, con->index);
+	if (IS_ERR(con->thread)) {
+		con->thread = NULL;
+		pr_err("%sconsole [%s%d]: unable to start printing thread\n",
+			(con->flags & CON_BOOT) ? "boot" : "",
+			con->name, con->index);
+		return;
+	}
+}
+
 /*
  * Delayed printk version, for scheduler-internal messages:
  */
@@ -3371,7 +3526,7 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 	}
 
 	if (pending & PRINTK_PENDING_WAKEUP)
-		wake_up_interruptible(&log_wait);
+		wake_up_interruptible_all(&log_wait);
 }
 
 static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =
-- 
2.30.2

