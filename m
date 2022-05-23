Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0D6530F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiEWNJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiEWNJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:09:26 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A3953E3E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1653311365;
  x=1684847365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WBqPEvxC+WNpyece1fCkfSnAzrYO/AcSOC4/aNue54U=;
  b=fIOUgVLjxXFVDALweOCdqslaj4dyzqzCZqhBRsJZHNfcfvzzVU81XZvr
   m+hF3pat5yYF9hO5OftfkEONBUo2FONrBWPPLbSoJdBo9BPZf6AN0GQJx
   ZTDWAE9iCOq697ZLNYBp8NFcVUm4HK6x6uxR7aSTHfzRpT/EYvQEUbvhF
   OpjcHzuAt0ZJPOojHNCHWoxDb4/0sRQ2w3sUnDnqnVBhGVgTi0rxqiKr5
   Ow7KTu/dImnLO8Q3CorKJV0Pq/0TtTDs5rahcraTxzua/+6oppr5/exlS
   nrZjwMrcsu4ZpjM7LZLHs0CylcFD3KL1rcG36/qEJpPvI6e5bbkHoVay8
   A==;
Date:   Mon, 23 May 2022 15:09:22 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Chris Down <chris@chrisdown.name>
CC:     <linux-kernel@vger.kernel.org>, Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, <kernel-team@fb.com>
Subject: Re: [RFC PATCH v2] printk: console: Allow each console to have its
 own loglevel
Message-ID: <20220523130917.GA21282@axis.com>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YoeQLxhDeIk4VSmx@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 01:57:19PM +0100, Chris Down wrote:
> [Once the goals of this patch are generally agreed upon, it can be split
> out further with more detailed changelogs if desired.]
> 
> Consoles can have vastly different latencies and throughputs. For
> example, writing a message to the serial console can take on the order
> of tens of milliseconds to get the UART to successfully write a message.
> While this might be fine for a single, one-off message, this can cause
> significant application-level stalls in situations where the kernel
> writes large amounts of information to the console.
> 
> This means that while you might want to send at least INFO level
> messages to (for example) netconsole, which is relatively fast, you may
> only want to send at least WARN level messages to the serial console.
> Such an implementation would permit debugging using the serial console
> in cases that netconsole doesn't receive messages during particularly
> bad system issues, while still keeping the noise low enough to avoid
> inducing latency in userspace applications. This patch adds such an
> interface, extending the existing console loglevel controls to allow
> each console to have its own loglevel.

I've had to do something similar for my systems, to allow all messages
to always be logged to the pstore console while still allowing the UART
console loglevel to be adjusted.  I've been carrying the following
pstore-specific hack for a while now.  This patch set looks like it will
be able to solve the problem in a generic way.

8<-------
printk: Add support for "always" consoles for pstore

We normally disable most non-critical messages to the serial console
since it's very slow.  However, when we have a pstore console, speed is
not a problem, and we want to write all messages to the pstore
regardless of the console loglevel.  The console loglevel is currently
shared, so disabling messages from the serial console disables them from
the pstore too.

To allow both these consoles and use cases to co-exist, add a flag to
allow console drivers to ask for output always, and implement support
for this in the printk core.  Mark the pstore console as an Always
console.

We support only one always console for now.

---
 fs/pstore/platform.c    |  2 +-
 include/linux/console.h |  1 +
 kernel/printk/printk.c  | 26 +++++++++++++++++++++-----
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 5aee39aaf1d0..f802b2d1c460 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -591,7 +591,7 @@ static void pstore_console_write(struct console *con, const char *s, unsigned c)
 static struct console pstore_console = {
 	.name	= "pstore",
 	.write	= pstore_console_write,
-	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_ANYTIME,
+	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_ANYTIME | CON_ALWAYS,
 	.index	= -1,
 };
 
diff --git a/include/linux/console.h b/include/linux/console.h
index d530c4627e54..98c13122aee6 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -123,6 +123,7 @@ static inline int con_debug_leave(void)
 #define CON_ANYTIME	(16) /* Safe to call when cpu is offline */
 #define CON_BRL		(32) /* Used for a braille device */
 #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
+#define CON_ALWAYS	(128)	/* Always print to this console */
 
 struct console {
 	char	name[16];
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5b628c2d7281..476eaec250f7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -240,6 +240,9 @@ static int console_locked, console_suspended;
  */
 static struct console *exclusive_console;
 
+/* Always print to this console, regardless of loglevel */
+static struct console *always_console;
+
 /*
  *	Array of consoles built from command line options (console=)
  */
@@ -1537,7 +1540,7 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
  */
 static void call_console_drivers(int level,
 				 const char *ext_text, size_t ext_len,
-				 const char *text, size_t len)
+				 const char *text, size_t len, bool suppress)
 {
 	struct console *con;
 
@@ -1547,6 +1550,8 @@ static void call_console_drivers(int level,
 		return;
 
 	for_each_console(con) {
+		if (suppress && con != always_console)
+			continue;
 		if (exclusive_console && con != exclusive_console)
 			continue;
 		if (!(con->flags & CON_ENABLED))
@@ -2265,6 +2270,7 @@ static inline int can_use_console(void)
 static void console_cont_flush(char *text, size_t size)
 {
 	unsigned long flags;
+	bool suppress;
 	size_t len;
 
 	raw_spin_lock_irqsave(&logbuf_lock, flags);
@@ -2272,7 +2278,8 @@ static void console_cont_flush(char *text, size_t size)
 	if (!cont.len)
 		goto out;
 
-	if (suppress_message_printing(cont.level)) {
+	suppress = suppress_message_printing(cont.level);
+	if (suppress && !always_console) {
 		cont.cons = cont.len;
 		if (cont.flushed)
 			cont.len = 0;
@@ -2290,7 +2297,7 @@ static void console_cont_flush(char *text, size_t size)
 	len = cont_print_text(text, size);
 	raw_spin_unlock(&logbuf_lock);
 	stop_critical_timings();
-	call_console_drivers(cont.level, NULL, 0, text, len);
+	call_console_drivers(cont.level, NULL, 0, text, len, suppress);
 	start_critical_timings();
 	local_irq_restore(flags);
 	return;
@@ -2361,6 +2368,7 @@ void console_unlock(void)
 	for (;;) {
 		struct printk_log *msg;
 		size_t ext_len = 0;
+		bool suppress;
 		size_t len;
 		int level;
 
@@ -2386,8 +2394,9 @@ void console_unlock(void)
 
 		msg = log_from_idx(console_idx);
 		level = msg->level;
+		suppress = suppress_message_printing(level);
 		if ((msg->flags & LOG_NOCONS) ||
-				suppress_message_printing(level)) {
+				(suppress && !always_console)) {
 			/*
 			 * Skip record we have buffered and already printed
 			 * directly to the console when we received it, and
@@ -2419,7 +2428,7 @@ void console_unlock(void)
 		raw_spin_unlock(&logbuf_lock);
 
 		stop_critical_timings();	/* don't trace print latency */
-		call_console_drivers(level, ext_text, ext_len, text, len);
+		call_console_drivers(level, ext_text, ext_len, text, len, suppress);
 		start_critical_timings();
 		local_irq_restore(flags);
 
@@ -2718,6 +2727,10 @@ void register_console(struct console *newcon)
 		 */
 		exclusive_console = newcon;
 	}
+
+	if (!always_console && (newcon->flags & CON_ALWAYS))
+		always_console = newcon;
+
 	console_unlock();
 	console_sysfs_notify();
 
@@ -2783,6 +2796,9 @@ int unregister_console(struct console *console)
 	if (console_drivers != NULL && console->flags & CON_CONSDEV)
 		console_drivers->flags |= CON_CONSDEV;
 
+	if (always_console == console)
+		always_console = NULL;
+
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
 	console_sysfs_notify();
-- 
2.28.0

