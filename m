Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E1557E49
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiFWOwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiFWOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:52:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D6447AFF;
        Thu, 23 Jun 2022 07:52:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7C0F21F8F2;
        Thu, 23 Jun 2022 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655995921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7G9MJYfM0eMUxdCh7WFX9W8FoSmkWZU21GXQD1kYDwE=;
        b=CRwj1KV9N/D4mZHENYv2UDEdoyvam975IrizkhRTpeXi6MKy01NkRFKVCa5PNbnQa64nfz
        C2S7taBTeQxHF5Z645gTsBIk8o1gAkwnfSYCzs5sKDSXrGfjohs0+t3LmwDQ4Vm1nyQfEp
        GhbIviRvEfSbC9VsxXb65UaJkLHthCE=
Received: from alley.suse.cz (unknown [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id 749092C142;
        Thu, 23 Jun 2022 14:52:00 +0000 (UTC)
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
Subject: [PATCH 1/6] Revert "printk: Wait for the global console lock when the system is going down"
Date:   Thu, 23 Jun 2022 16:51:52 +0200
Message-Id: <20220623145157.21938-2-pmladek@suse.com>
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

This reverts commit b87f02307d3cfbda768520f0687c51ca77e14fc3.

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
 include/linux/printk.h      |  5 -----
 kernel/panic.c              |  2 --
 kernel/printk/internal.h    |  2 --
 kernel/printk/printk.c      |  4 ----
 kernel/printk/printk_safe.c | 32 --------------------------------
 kernel/reboot.c             |  2 --
 6 files changed, 47 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index f88ec15f83dc..10ec29bc0135 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -173,7 +173,6 @@ extern void printk_prefer_direct_enter(void);
 extern void printk_prefer_direct_exit(void);
 
 extern bool pr_flush(int timeout_ms, bool reset_on_progress);
-extern void try_block_console_kthreads(int timeout_ms);
 
 /*
  * Please don't use printk_ratelimit(), because it shares ratelimiting state
@@ -238,10 +237,6 @@ static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
 	return true;
 }
 
-static inline void try_block_console_kthreads(int timeout_ms)
-{
-}
-
 static inline int printk_ratelimit(void)
 {
 	return 0;
diff --git a/kernel/panic.c b/kernel/panic.c
index 4cf13c37bd08..a3c758dba15a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -297,7 +297,6 @@ void panic(const char *fmt, ...)
 		 * unfortunately means it may not be hardened to work in a
 		 * panic situation.
 		 */
-		try_block_console_kthreads(10000);
 		smp_send_stop();
 	} else {
 		/*
@@ -305,7 +304,6 @@ void panic(const char *fmt, ...)
 		 * kmsg_dump, we will need architecture dependent extra
 		 * works in addition to stopping other CPUs.
 		 */
-		try_block_console_kthreads(10000);
 		crash_smp_send_stop();
 	}
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index e7d8578860ad..d947ca6c84f9 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -20,8 +20,6 @@ enum printk_info_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
-extern bool block_console_kthreads;
-
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b095fb5f5f61..45c6c2b0b104 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -250,9 +250,6 @@ static atomic_t console_kthreads_active = ATOMIC_INIT(0);
 #define console_kthread_printing_exit() \
 	atomic_dec(&console_kthreads_active)
 
-/* Block console kthreads to avoid processing new messages. */
-bool block_console_kthreads;
-
 /*
  * Helper macros to handle lockdep when locking/unlocking console_sem. We use
  * macros instead of functions so that _RET_IP_ contains useful information.
@@ -3733,7 +3730,6 @@ static bool printer_should_wake(struct console *con, u64 seq)
 
 	if (con->blocked ||
 	    console_kthreads_atomically_blocked() ||
-	    block_console_kthreads ||
 	    system_state > SYSTEM_RUNNING ||
 	    oops_in_progress) {
 		return false;
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index caac4de1ea59..ef0f9a2044da 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -8,9 +8,7 @@
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/printk.h>
-#include <linux/console.h>
 #include <linux/kprobes.h>
-#include <linux/delay.h>
 
 #include "internal.h"
 
@@ -52,33 +50,3 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	return vprintk_default(fmt, args);
 }
 EXPORT_SYMBOL(vprintk);
-
-/**
- * try_block_console_kthreads() - Try to block console kthreads and
- *	make the global console_lock() avaialble
- *
- * @timeout_ms:        The maximum time (in ms) to wait.
- *
- * Prevent console kthreads from starting processing new messages. Wait
- * until the global console_lock() become available.
- *
- * Context: Can be called in any context.
- */
-void try_block_console_kthreads(int timeout_ms)
-{
-	block_console_kthreads = true;
-
-	/* Do not wait when the console lock could not be safely taken. */
-	if (this_cpu_read(printk_context) || in_nmi())
-		return;
-
-	while (timeout_ms > 0) {
-		if (console_trylock()) {
-			console_unlock();
-			return;
-		}
-
-		udelay(1000);
-		timeout_ms -= 1;
-	}
-}
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 80564ffafabf..b5a71d1ff603 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -82,7 +82,6 @@ void kernel_restart_prepare(char *cmd)
 {
 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
-	try_block_console_kthreads(10000);
 	usermodehelper_disable();
 	device_shutdown();
 }
@@ -271,7 +270,6 @@ static void kernel_shutdown_prepare(enum system_states state)
 	blocking_notifier_call_chain(&reboot_notifier_list,
 		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
 	system_state = state;
-	try_block_console_kthreads(10000);
 	usermodehelper_disable();
 	device_shutdown();
 }
-- 
2.35.3

