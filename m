Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053214AC9D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbiBGTpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbiBGTnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:43:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D5C0401E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:43:30 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644263008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xh+B+R8a+dMM5UjgQTfTZzdQRiBRIrfEWMgEQ7PqZr4=;
        b=oxU66eRg65n32p2KUIctY1A+KzyV5RB9AU0O+WYXGbTgVw7BAhR7iDmj/AksDLex4cUs4a
        QaVaO7ffQkhRCekj/ijMWwWb7PG53opfFkiiBLv5IcNOvod1hmGLn2reGRmjqcN/lu2kDd
        KNiWvVt2izzohNp2QN9I9Fspg8dbtyel9kR62iSmUgfTWUbMxfh+YRUMFsT1aCMTSiKqX3
        6hMy81izOCGnowK6w2daIF8fkBNRzltpqw+Y49gE07NVFJe+AeSUJlsq5l4reiDHaruSVn
        iKZUWEnf1tk49RsKzBDhf+WYsWd10oqeJ5nyg+KEF3AuuDKcgp0vvv3+4tyebg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644263008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xh+B+R8a+dMM5UjgQTfTZzdQRiBRIrfEWMgEQ7PqZr4=;
        b=dhHckI5TD0w/WJOQt8dcmU5LVT3Gx6FAcGu6DFRs2yTgc5/WrBWsgDnx8jF+HxjIUQtFwz
        WaClvWVYAqcf1ICw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 08/13] printk: add pr_flush()
Date:   Mon,  7 Feb 2022 20:49:18 +0106
Message-Id: <20220207194323.273637-9-john.ogness@linutronix.de>
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

Provide a might-sleep function to allow waiting for threaded console
printers to catch up to the latest logged message.

Use pr_flush() whenever it is desirable to get buffered messages
printed before continuing: suspend_console(), resume_console(),
console_stop(), console_start(), console_unblank().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h |  7 ++++
 kernel/printk/printk.c | 73 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cd8192e611a1..6596f02d1f05 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -170,6 +170,8 @@ extern void __printk_safe_exit(void);
 #define printk_deferred_enter __printk_safe_enter
 #define printk_deferred_exit __printk_safe_exit
 
+extern bool pr_flush(int timeout_ms, bool reset_on_progress);
+
 /*
  * Please don't use printk_ratelimit(), because it shares ratelimiting state
  * with all other unrelated printk_ratelimit() callsites.  Instead use
@@ -224,6 +226,11 @@ static inline void printk_deferred_exit(void)
 {
 }
 
+static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
+{
+	return true;
+}
+
 static inline int printk_ratelimit(void)
 {
 	return 0;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 02bde45c1149..1e80fd052bd5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2449,6 +2449,7 @@ void suspend_console(void)
 	if (!console_suspend_enabled)
 		return;
 	pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
+	pr_flush(1000, true);
 	console_lock();
 	console_suspended = 1;
 	up_console_sem();
@@ -2461,6 +2462,7 @@ void resume_console(void)
 	down_console_sem();
 	console_suspended = 0;
 	console_unlock();
+	pr_flush(1000, true);
 }
 
 /**
@@ -2802,8 +2804,10 @@ void console_unblank(void)
 	if (oops_in_progress) {
 		if (down_trylock_console_sem() != 0)
 			return;
-	} else
+	} else {
+		pr_flush(1000, true);
 		console_lock();
+	}
 
 	console_locked = 1;
 	console_may_schedule = 0;
@@ -2869,6 +2873,7 @@ struct tty_driver *console_device(int *index)
  */
 void console_stop(struct console *console)
 {
+	pr_flush(1000, true);
 	console_lock();
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
@@ -2880,6 +2885,7 @@ void console_start(struct console *console)
 	console_lock();
 	console->flags |= CON_ENABLED;
 	console_unlock();
+	pr_flush(1000, true);
 }
 EXPORT_SYMBOL(console_start);
 
@@ -3249,6 +3255,71 @@ static int __init printk_late_init(void)
 late_initcall(printk_late_init);
 
 #if defined CONFIG_PRINTK
+/**
+ * pr_flush() - Wait for printing threads to catch up.
+ *
+ * @timeout_ms:        The maximum time (in ms) to wait.
+ * @reset_on_progress: Reset the timeout if forward progress is seen.
+ *
+ * A value of 0 for @timeout_ms means no waiting will occur. A value of -1
+ * represents infinite waiting.
+ *
+ * If @reset_on_progress is true, the timeout will be reset whenever any
+ * printer has been seen to make some forward progress.
+ *
+ * Context: Process context. May sleep while acquiring console lock.
+ * Return: true if all enabled printers are caught up.
+ */
+bool pr_flush(int timeout_ms, bool reset_on_progress)
+{
+	int remaining = timeout_ms;
+	struct console *con;
+	u64 last_diff = 0;
+	u64 printk_seq;
+	u64 diff;
+	u64 seq;
+
+	might_sleep();
+
+	seq = prb_next_seq(prb);
+
+	for (;;) {
+		diff = 0;
+
+		console_lock();
+		for_each_console(con) {
+			if (!console_is_usable(con))
+				continue;
+			printk_seq = con->seq;
+			if (printk_seq < seq)
+				diff += seq - printk_seq;
+		}
+		console_unlock();
+
+		if (diff != last_diff && reset_on_progress)
+			remaining = timeout_ms;
+
+		if (diff == 0 || remaining == 0)
+			break;
+
+		if (remaining < 0) {
+			/* no timeout limit */
+			msleep(100);
+		} else if (remaining < 100) {
+			msleep(remaining);
+			remaining = 0;
+		} else {
+			msleep(100);
+			remaining -= 100;
+		}
+
+		last_diff = diff;
+	}
+
+	return (diff == 0);
+}
+EXPORT_SYMBOL(pr_flush);
+
 /*
  * Delayed printk version, for scheduler-internal messages:
  */
-- 
2.30.2

