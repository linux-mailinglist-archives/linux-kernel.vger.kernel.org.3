Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B6354CE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356044AbiFOQ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355717AbiFOQ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:28:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9719C2937D;
        Wed, 15 Jun 2022 09:28:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 52AB41F95C;
        Wed, 15 Jun 2022 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655310518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRVZYO8u+2GaBZDjbgulOQw4vH+xb0fipLd/Fd2y5no=;
        b=X3toKjCDbNw80V+NQoJvX5JRKMX4cFCbyF7og7xPPjMnpeaUfgQKlYedoXL67veGx6ItpT
        HqkMRF2zeZ4TShn7mZ4RuNANXtDLMdXc9OCm7sQ1xuIiRBKQ4mSevfOrKlg63BAFBZG80/
        ekRWqnkUwHrDV9ignxnR0VbrQGzvWXs=
Received: from alley.suse.cz (unknown [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id E517C2C141;
        Wed, 15 Jun 2022 16:28:37 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, frederic@kernel.org,
        Peter Geis <pgwipeout@gmail.com>, zhouzhouyi@gmail.com,
        dave@stgolabs.net, josh@joshtriplett.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rcu@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/2] printk: Wait for the global console lock when the system is going down
Date:   Wed, 15 Jun 2022 18:28:05 +0200
Message-Id: <20220615162805.27962-3-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220615162805.27962-1-pmladek@suse.com>
References: <20220615162805.27962-1-pmladek@suse.com>
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

There are reports that the console kthreads block the global console
lock when the system is going down, for example, reboot, panic.

First part of the solution was to block kthreads in these problematic
system states so they stopped handling newly added messages.

Second part of the solution is to wait when for the kthreads when
they are actively printing. It solves the problem when a message
was printed before the system entered the problematic state and
the kthreads managed to step in.

A busy waiting has to be used because panic() can be called in any
context and in an unknown state of the scheduler.

There must be a timeout because the kthread might get stuck or sleeping
and never release the lock. The timeout 10s is an arbitrary value
inspired by the softlockup timeout.

BugLink: https://lore.kernel.org/r/20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1
BugLink: https://lore.kernel.org/r/CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h      |  5 +++++
 kernel/panic.c              |  2 ++
 kernel/printk/internal.h    |  2 ++
 kernel/printk/printk.c      |  4 ++++
 kernel/printk/printk_safe.c | 32 ++++++++++++++++++++++++++++++++
 kernel/reboot.c             |  2 ++
 6 files changed, 47 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 10ec29bc0135..f88ec15f83dc 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -173,6 +173,7 @@ extern void printk_prefer_direct_enter(void);
 extern void printk_prefer_direct_exit(void);
 
 extern bool pr_flush(int timeout_ms, bool reset_on_progress);
+extern void try_block_console_kthreads(int timeout_ms);
 
 /*
  * Please don't use printk_ratelimit(), because it shares ratelimiting state
@@ -237,6 +238,10 @@ static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
 	return true;
 }
 
+static inline void try_block_console_kthreads(int timeout_ms)
+{
+}
+
 static inline int printk_ratelimit(void)
 {
 	return 0;
diff --git a/kernel/panic.c b/kernel/panic.c
index a3c758dba15a..4cf13c37bd08 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -297,6 +297,7 @@ void panic(const char *fmt, ...)
 		 * unfortunately means it may not be hardened to work in a
 		 * panic situation.
 		 */
+		try_block_console_kthreads(10000);
 		smp_send_stop();
 	} else {
 		/*
@@ -304,6 +305,7 @@ void panic(const char *fmt, ...)
 		 * kmsg_dump, we will need architecture dependent extra
 		 * works in addition to stopping other CPUs.
 		 */
+		try_block_console_kthreads(10000);
 		crash_smp_send_stop();
 	}
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index d947ca6c84f9..e7d8578860ad 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -20,6 +20,8 @@ enum printk_info_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
+extern bool block_console_kthreads;
+
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 45c6c2b0b104..b095fb5f5f61 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -250,6 +250,9 @@ static atomic_t console_kthreads_active = ATOMIC_INIT(0);
 #define console_kthread_printing_exit() \
 	atomic_dec(&console_kthreads_active)
 
+/* Block console kthreads to avoid processing new messages. */
+bool block_console_kthreads;
+
 /*
  * Helper macros to handle lockdep when locking/unlocking console_sem. We use
  * macros instead of functions so that _RET_IP_ contains useful information.
@@ -3730,6 +3733,7 @@ static bool printer_should_wake(struct console *con, u64 seq)
 
 	if (con->blocked ||
 	    console_kthreads_atomically_blocked() ||
+	    block_console_kthreads ||
 	    system_state > SYSTEM_RUNNING ||
 	    oops_in_progress) {
 		return false;
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index ef0f9a2044da..caac4de1ea59 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -8,7 +8,9 @@
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/printk.h>
+#include <linux/console.h>
 #include <linux/kprobes.h>
+#include <linux/delay.h>
 
 #include "internal.h"
 
@@ -50,3 +52,33 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	return vprintk_default(fmt, args);
 }
 EXPORT_SYMBOL(vprintk);
+
+/**
+ * try_block_console_kthreads() - Try to block console kthreads and
+ *	make the global console_lock() avaialble
+ *
+ * @timeout_ms:        The maximum time (in ms) to wait.
+ *
+ * Prevent console kthreads from starting processing new messages. Wait
+ * until the global console_lock() become available.
+ *
+ * Context: Can be called in any context.
+ */
+void try_block_console_kthreads(int timeout_ms)
+{
+	block_console_kthreads = true;
+
+	/* Do not wait when the console lock could not be safely taken. */
+	if (this_cpu_read(printk_context) || in_nmi())
+		return;
+
+	while (timeout_ms > 0) {
+		if (console_trylock()) {
+			console_unlock();
+			return;
+		}
+
+		udelay(1000);
+		timeout_ms -= 1;
+	}
+}
diff --git a/kernel/reboot.c b/kernel/reboot.c
index b5a71d1ff603..80564ffafabf 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -82,6 +82,7 @@ void kernel_restart_prepare(char *cmd)
 {
 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
+	try_block_console_kthreads(10000);
 	usermodehelper_disable();
 	device_shutdown();
 }
@@ -270,6 +271,7 @@ static void kernel_shutdown_prepare(enum system_states state)
 	blocking_notifier_call_chain(&reboot_notifier_list,
 		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
 	system_state = state;
+	try_block_console_kthreads(10000);
 	usermodehelper_disable();
 	device_shutdown();
 }
-- 
2.35.3

