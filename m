Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598F1507D50
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiDSXuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358220AbiDSXt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:49:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381852180E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:46:44 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650412002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRagQMAgyw9E0jyNWG8q2NJavYPyEPvJvS2W52Dx8Yo=;
        b=4efa6aPV+66Ynxr8q52vsFi6wOqKZzPt/5JG6ZZ7NBNQhGI53eaiC9GDeML25BCn7owZxU
        xjVna3LeAj9V9Bu1S6VQ2YHOgmva3Zzj10C74h6xJUUCQHY3h36WfiMb2kIoJ+I90MykOx
        Ybsgo+qM1wJqf2+vkchVDiPNrOZCSXtcjE9kkDTIJwbWZ0/JeCe1hd5yOif1QSv/fgUfsX
        G+WCJr1t0V0S4jKMSg5Z0U7ALkGIJosEMHi9xcxtETtaIchoM0+AJi+M3dj5YyrbEsyWBX
        NJOLUlPFotsBNKjQtMSbL6eg/q53in+k4RzArmMYq2bMU7A6Us/AO5FrL1awlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650412002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRagQMAgyw9E0jyNWG8q2NJavYPyEPvJvS2W52Dx8Yo=;
        b=ADzlDLMxF0LXiw5uHcSNYAdaGIkkOB81Dv3Z7pPhEAGs0Mi0TwBQUZVY5XOOamKa9pav+1
        fLYaZcNxC2kqmADA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 10/15] printk: move buffer definitions into console_emit_next_record() caller
Date:   Wed, 20 Apr 2022 01:52:32 +0206
Message-Id: <20220419234637.357112-11-john.ogness@linutronix.de>
In-Reply-To: <20220419234637.357112-1-john.ogness@linutronix.de>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
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

Extended consoles print extended messages and do not print messages about
dropped records.

Non-extended consoles print "normal" messages as well as extra messages
about dropped records.

Currently the buffers for these various message types are defined within
the functions that might use them and their usage is based upon the
CON_EXTENDED flag. This will be a problem when moving to kthread printers
because each printer must be able to provide its own buffers.

Move all the message buffer definitions outside of
console_emit_next_record(). The caller knows if extended or dropped
messages should be printed and can specify the appropriate buffers to
use. The console_emit_next_record() and call_console_driver() functions
can know what to print based on whether specified buffers are non-NULL.

With this change, buffer definition/allocation/specification is separated
from the code that does the various types of string printing.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 60 ++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3dea8bbaf402..dec5355c5b5b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -394,6 +394,9 @@ static struct latched_seq clear_seq = {
 /* the maximum size of a formatted record (i.e. with prefix added per line) */
 #define CONSOLE_LOG_MAX		1024
 
+/* the maximum size for a dropped text message */
+#define DROPPED_TEXT_MAX	64
+
 /* the maximum size allowed to be reserved for a record */
 #define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
 
@@ -1923,18 +1926,18 @@ static int console_trylock_spinning(void)
 
 /*
  * Call the specified console driver, asking it to write out the specified
- * text and length. For non-extended consoles, if any records have been
+ * text and length. If @dropped_text is non-NULL and any records have been
  * dropped, a dropped message will be written out first.
  */
-static void call_console_driver(struct console *con, const char *text, size_t len)
+static void call_console_driver(struct console *con, const char *text, size_t len,
+				char *dropped_text)
 {
-	static char dropped_text[64];
 	size_t dropped_len;
 
 	trace_console_rcuidle(text, len);
 
-	if (con->dropped && !(con->flags & CON_EXTENDED)) {
-		dropped_len = snprintf(dropped_text, sizeof(dropped_text),
+	if (con->dropped && dropped_text) {
+		dropped_len = snprintf(dropped_text, DROPPED_TEXT_MAX,
 				       "** %lu printk messages dropped **\n",
 				       con->dropped);
 		con->dropped = 0;
@@ -2296,6 +2299,7 @@ EXPORT_SYMBOL(_printk);
 #else /* CONFIG_PRINTK */
 
 #define CONSOLE_LOG_MAX		0
+#define DROPPED_TEXT_MAX	0
 #define printk_time		false
 
 #define prb_read_valid(rb, seq, r)	false
@@ -2319,7 +2323,10 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 				  struct dev_printk_info *dev_info) { return 0; }
 static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
-static void call_console_driver(struct console *con, const char *text, size_t len) { }
+static void call_console_driver(struct console *con, const char *text, size_t len,
+				char *dropped_text)
+{
+}
 static bool suppress_message_printing(int level) { return false; }
 
 #endif /* CONFIG_PRINTK */
@@ -2644,6 +2651,14 @@ static void __console_unlock(void)
  * Print one record for the given console. The record printed is whatever
  * record is the next available record for the given console.
  *
+ * @text is a buffer of size CONSOLE_LOG_MAX.
+ *
+ * If extended messages should be printed, @ext_text is a buffer of size
+ * CONSOLE_EXT_LOG_MAX. Otherwise @ext_text must be NULL.
+ *
+ * If dropped messages should be printed, @dropped_text is a buffer of size
+ * DROPPED_TEXT_MAX. Otherwise @dropped_text must be NULL.
+ *
  * @handover will be set to true if a printk waiter has taken over the
  * console_lock, in which case the caller is no longer holding the
  * console_lock. Otherwise it is set to false.
@@ -2653,10 +2668,9 @@ static void __console_unlock(void)
  *
  * Requires the console_lock.
  */
-static bool console_emit_next_record(struct console *con, bool *handover)
+static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
+				     char *dropped_text, bool *handover)
 {
-	static char ext_text[CONSOLE_EXT_LOG_MAX];
-	static char text[CONSOLE_LOG_MAX];
 	static int panic_console_dropped;
 	struct printk_info info;
 	struct printk_record r;
@@ -2664,7 +2678,7 @@ static bool console_emit_next_record(struct console *con, bool *handover)
 	char *write_text;
 	size_t len;
 
-	prb_rec_init_rd(&r, &info, text, sizeof(text));
+	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
 	*handover = false;
 
@@ -2686,13 +2700,13 @@ static bool console_emit_next_record(struct console *con, bool *handover)
 		goto skip;
 	}
 
-	if (con->flags & CON_EXTENDED) {
-		write_text = &ext_text[0];
-		len = info_print_ext_header(ext_text, sizeof(ext_text), r.info);
-		len += msg_print_ext_body(ext_text + len, sizeof(ext_text) - len,
+	if (ext_text) {
+		write_text = ext_text;
+		len = info_print_ext_header(ext_text, CONSOLE_EXT_LOG_MAX, r.info);
+		len += msg_print_ext_body(ext_text + len, CONSOLE_EXT_LOG_MAX - len,
 					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
 	} else {
-		write_text = &text[0];
+		write_text = text;
 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
 	}
 
@@ -2710,7 +2724,7 @@ static bool console_emit_next_record(struct console *con, bool *handover)
 	console_lock_spinning_enable();
 
 	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, write_text, len);
+	call_console_driver(con, write_text, len, dropped_text);
 	start_critical_timings();
 
 	con->seq++;
@@ -2746,6 +2760,9 @@ static bool console_emit_next_record(struct console *con, bool *handover)
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
+	static char dropped_text[DROPPED_TEXT_MAX];
+	static char ext_text[CONSOLE_EXT_LOG_MAX];
+	static char text[CONSOLE_LOG_MAX];
 	bool any_usable = false;
 	struct console *con;
 	bool any_progress;
@@ -2763,7 +2780,16 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 				continue;
 			any_usable = true;
 
-			progress = console_emit_next_record(con, handover);
+			if (con->flags & CON_EXTENDED) {
+				/* Extended consoles do not print "dropped messages". */
+				progress = console_emit_next_record(con, &text[0],
+								    &ext_text[0], NULL,
+								    handover);
+			} else {
+				progress = console_emit_next_record(con, &text[0],
+								    NULL, &dropped_text[0],
+								    handover);
+			}
 			if (*handover)
 				return false;
 
-- 
2.30.2

