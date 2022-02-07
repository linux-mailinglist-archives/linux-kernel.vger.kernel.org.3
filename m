Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41C84AC9CF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbiBGTpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbiBGTnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:43:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F48C0401E6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:43:32 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644263010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wz4b8g7RhPiNelQL/klnUcQZ1lWWUK2rdxPkiBZW57s=;
        b=NkQ9Tzkk+waPE4Lx3hILnB/SEXPjt9O0DPteuf5yohGTXni5i6bt3h6TasqLt56Z0LAEUA
        a/Nq4Fvw53pRhkeAs7CAE5Ps3bkfYxefH4usfEOtyPKYAbrdXfDU8jXF3Si8EnEpmlV06/
        2l73Xi9e5r/VFxS1ad0ZM2weUGslPPyPI/0mTbNPSPGGR1mqEKHJIzUUt8ZJaqPAWlpsaU
        GE6lJ264fWXTvDQ4cepXLe03iSVmRpwiwqwJSQ0wUiQ2ZkwrWKaFoqWeDSSjJGck1Mm22a
        EvKUcI/PD1U5GCKlhMjUZBCxnzvxZc/fWIufOTJ4RA8FUK9N7sACU5xsrc7Hnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644263010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wz4b8g7RhPiNelQL/klnUcQZ1lWWUK2rdxPkiBZW57s=;
        b=VYiRfbKySMkonqCi+iIKU7JtpTkuoiQlT94ayGBwIImidq/e5p6/N8xGM1S8Op0ZZwofyo
        uC6KFmr+iDdetYAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 12/13] printk: remove @console_locked
Date:   Mon,  7 Feb 2022 20:49:22 +0106
Message-Id: <20220207194323.273637-13-john.ogness@linutronix.de>
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

The static global variable @console_locked is used to help debug VT
code to make sure that certain code paths are running with the
console_lock held. However, this information is also available with
the static global variable @consoles_paused (for locking via
console_lock()), and the static global variable @console_lock_count
(for locking via console_trylock()).

Remove @console_locked and update is_console_locked() to use the
alternative variables.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 135fbe647092..086155578f10 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -307,15 +307,7 @@ static void __pause_all_consoles(bool do_pause)
 #define pause_all_consoles() __pause_all_consoles(true)
 #define unpause_all_consoles() __pause_all_consoles(false)
 
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
@@ -2595,7 +2587,6 @@ void console_lock(void)
 	if (console_suspended)
 		return;
 	pause_all_consoles();
-	console_locked = 1;
 	console_may_schedule = 1;
 }
 EXPORT_SYMBOL(console_lock);
@@ -2620,7 +2611,6 @@ int console_trylock(void)
 		up_console_sem();
 		return 0;
 	}
-	console_locked = 1;
 	console_may_schedule = 0;
 	return 1;
 }
@@ -2647,14 +2637,25 @@ static int console_trylock_sched(bool may_schedule)
 		return 0;
 	}
 	pause_all_consoles();
-	console_locked = 1;
 	console_may_schedule = 1;
 	return 1;
 }
 
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
-	return (console_locked || atomic_read(&console_lock_count));
+	return (consoles_paused || atomic_read(&console_lock_count));
 }
 EXPORT_SYMBOL(is_console_locked);
 
@@ -2687,8 +2688,6 @@ static inline bool console_is_usable(struct console *con)
 
 static void __console_unlock(void)
 {
-	console_locked = 0;
-
 	/*
 	 * Depending on whether console_lock() or console_trylock() was used,
 	 * appropriately allow the kthread printers to continue.
@@ -2966,7 +2965,6 @@ void console_unblank(void)
 		console_lock();
 	}
 
-	console_locked = 1;
 	console_may_schedule = 0;
 	for_each_console(c)
 		if ((c->flags & CON_ENABLED) && c->unblank)
-- 
2.30.2

