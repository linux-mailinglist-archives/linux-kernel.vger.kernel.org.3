Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2486507D51
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358529AbiDSXu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358335AbiDSXth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:49:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B098A1EED2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:46:46 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650412005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvf0BV4Ni+mczHt9baaeB5m6ipa/oq8Oc6dpDCVj3Sc=;
        b=SkqQP/3wbrDpAKj/a7QFZh6X42SDPg7xhg1SH2xliH0FCJxTaKTO0v7ZU3SAxxsycyaFFn
        1YU4eWA/BzvzvYrk31f7RuwjeT7tO/XLluIg9E4TIwTvc0Y3bfflOqvvihwYjDyw2p8HI8
        a39TFt9JpN2bBKtkJvb/sQ0iNu+9GlstssgvOFAlWUA6sJB1j91yrbM632Xp2zbEV68FLL
        V/dSDt8sn4M4iq9sxV0KJ8BXL3uDpg11QyCbEDIz1YTohGXkXLp1KFF0nLk8bXrMfPzN+N
        dcYHC+5VdEGZv/HwT6Rn8ro1aQH1gbqkfm6MOEA4qU495ljt3t094THb1TUHtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650412005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvf0BV4Ni+mczHt9baaeB5m6ipa/oq8Oc6dpDCVj3Sc=;
        b=x3OFtYqEG4qu8CjB02pSp8Cq/XE8yziaDEM9U/2UDI7A4kZn0rrwBwCwOWXETyFgtHy8VW
        cNowL9uPE8ldd+Dg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 15/15] printk: remove @console_locked
Date:   Wed, 20 Apr 2022 01:52:37 +0206
Message-Id: <20220419234637.357112-16-john.ogness@linutronix.de>
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

The static global variable @console_locked is used to help debug
VT code to make sure that certain code paths are running with
the console_lock held. However, this information is also available
with the static global variable @console_kthreads_blocked (for
locking via console_lock()), and the static global variable
@console_kthreads_active (for locking via console_trylock()).

Remove @console_locked and update is_console_locked() to use the
alternative variables.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6d5f57142cd9..c9e0b0abbedd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -340,15 +340,7 @@ static void console_kthreads_unblock(void)
 	console_kthreads_blocked = false;
 }
 
-/*
- * This is used for debugging the mess that is the VT code by
- * keeping track if we have the console semaphore held. It's
- * definitely not the perfect debug tool (we don't know if _WE_
- * hold it and are racing, but it helps tracking those weird code
- * paths in the console code where we end up in places I want
- * locked without the console semaphore held).
- */
-static int console_locked, console_suspended;
+static int console_suspended;
 
 /*
  *	Array of consoles built from command line options (console=)
@@ -2690,7 +2682,6 @@ void console_lock(void)
 	if (console_suspended)
 		return;
 	console_kthreads_block();
-	console_locked = 1;
 	console_may_schedule = 1;
 }
 EXPORT_SYMBOL(console_lock);
@@ -2705,13 +2696,11 @@ void console_lock_single_hold(struct console *con)
 	might_sleep();
 	down_console_sem();
 	mutex_lock(&con->lock);
-	console_locked = 1;
 	console_may_schedule = 1;
 }
 
 static void console_unlock_single_release(struct console *con)
 {
-	console_locked = 0;
 	mutex_unlock(&con->lock);
 	up_console_sem();
 }
@@ -2736,15 +2725,26 @@ int console_trylock(void)
 		up_console_sem();
 		return 0;
 	}
-	console_locked = 1;
 	console_may_schedule = 0;
 	return 1;
 }
 EXPORT_SYMBOL(console_trylock);
 
+/*
+ * This is used to help to make sure that certain paths within the VT code are
+ * running with the console lock held. It is definitely not the perfect debug
+ * tool (it is not known if the VT code is the task holding the console lock),
+ * but it helps tracking those weird code paths in the console code such as
+ * when the console is suspended: where the console is not locked but no
+ * console printing may occur.
+ *
+ * Note: This returns true when the console is suspended but is not locked.
+ *       This is intentional because the VT code must consider that situation
+ *       the same as if the console was locked.
+ */
 int is_console_locked(void)
 {
-	return (console_locked || atomic_read(&console_kthreads_active));
+	return (console_kthreads_blocked || atomic_read(&console_kthreads_active));
 }
 EXPORT_SYMBOL(is_console_locked);
 
@@ -2800,8 +2800,6 @@ static inline bool console_is_usable(struct console *con)
 
 static void __console_unlock(void)
 {
-	console_locked = 0;
-
 	/*
 	 * Depending on whether console_lock() or console_trylock() was used,
 	 * appropriately allow the kthread printers to continue.
@@ -3118,7 +3116,6 @@ void console_unblank(void)
 	} else
 		console_lock();
 
-	console_locked = 1;
 	console_may_schedule = 0;
 	for_each_console(c)
 		if ((c->flags & CON_ENABLED) && c->unblank)
-- 
2.30.2

