Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CD64F470E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbiDEU6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353517AbiDEPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:11:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E221109A49
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:25:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649165140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCqmcIsjQhjlsizLtSjuYMGPoSNu/EUhYwTtgU6s6Kw=;
        b=1hzmEMqB9EKNoE5JBFRlA4eMbd3igRAH45cAXctFrViaWY0hFB6V86q6tgCcEJToO+DN+7
        sxo7S+yfITRySa7SwcGDeZk/X1V5BmRfNLcsHawn68tMynTVnZj9K8EsvrKlN9j5yA84kH
        VVWTYRE0XBSdopR31SKrZn9TDMHImZqpi6FC4bnT4WN7F2jrFiBL3Edr31ihIt0wrzpx+z
        WmYe+v9nH0RQmd0wAKETve5e+6Atv24gGp1JnnveM4AM+qqeeE+pgJD6B4Tq9pGzydyVW6
        yixlyRzFE1lDKNouGMtQJmjA5oqUd9xAyRZ3h4NTLBdt2E5OFYBTfpAyUXV05g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649165140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCqmcIsjQhjlsizLtSjuYMGPoSNu/EUhYwTtgU6s6Kw=;
        b=T7Y31PyF+fAnDahO6XXYuCQ0QKZg6HgmMFwrcy91vF9YPPLG4HDkYvVNsjBBn/UOogOLi/
        MEimoKCOil/FKEAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 08/12] printk: add pr_flush()
Date:   Tue,  5 Apr 2022 15:31:31 +0206
Message-Id: <20220405132535.649171-9-john.ogness@linutronix.de>
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

Provide a might-sleep function to allow waiting for console printers
to catch up to the latest logged message.

Use pr_flush() whenever it is desirable to get buffered messages
printed before continuing: suspend_console(), resume_console(),
console_stop(), console_start(), console_unblank().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h |  7 ++++
 kernel/printk/printk.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index b70a42f94031..091fba7283e1 100644
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
@@ -220,6 +222,11 @@ static inline void printk_deferred_exit(void)
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
index 06f0b29d909d..d0369afaf365 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2274,6 +2274,8 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
+static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
+
 #else /* CONFIG_PRINTK */
 
 #define CONSOLE_LOG_MAX		0
@@ -2306,6 +2308,7 @@ static void call_console_driver(struct console *con, const char *text, size_t le
 {
 }
 static bool suppress_message_printing(int level) { return false; }
+static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
 #endif /* CONFIG_PRINTK */
 
@@ -2493,6 +2496,7 @@ void suspend_console(void)
 	if (!console_suspend_enabled)
 		return;
 	pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
+	pr_flush(1000, true);
 	console_lock();
 	console_suspended = 1;
 	up_console_sem();
@@ -2505,6 +2509,7 @@ void resume_console(void)
 	down_console_sem();
 	console_suspended = 0;
 	console_unlock();
+	pr_flush(1000, true);
 }
 
 /**
@@ -2882,6 +2887,9 @@ void console_unblank(void)
 		if ((c->flags & CON_ENABLED) && c->unblank)
 			c->unblank();
 	console_unlock();
+
+	if (!oops_in_progress)
+		pr_flush(1000, true);
 }
 
 /**
@@ -2940,6 +2948,7 @@ struct tty_driver *console_device(int *index)
  */
 void console_stop(struct console *console)
 {
+	__pr_flush(console, 1000, true);
 	console_lock();
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
@@ -2951,6 +2960,7 @@ void console_start(struct console *console)
 	console_lock();
 	console->flags |= CON_ENABLED;
 	console_unlock();
+	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
 
@@ -3321,6 +3331,79 @@ static int __init printk_late_init(void)
 late_initcall(printk_late_init);
 
 #if defined CONFIG_PRINTK
+/* If @con is specified, only wait for that console. Otherwise wait for all. */
+static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)
+{
+	int remaining = timeout_ms;
+	struct console *c;
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
+		for_each_console(c) {
+			if (con && con != c)
+				continue;
+			if (!console_is_usable(c))
+				continue;
+			printk_seq = c->seq;
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
+
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
+	return __pr_flush(NULL, timeout_ms, reset_on_progress);
+}
+EXPORT_SYMBOL(pr_flush);
+
 /*
  * Delayed printk version, for scheduler-internal messages:
  */
-- 
2.30.2

