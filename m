Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794A74F5125
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1845008AbiDFBxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354744AbiDEPMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:12:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94423109A72
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:25:44 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649165143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVfL+n5pd7cP1D7iEgDx1sRuang/QKBVMoT4FjG4/yk=;
        b=Z4nVgeULPomW2cxkt6UXVHgmZZsRMtR4IhKYUvX3dM5ab8P35/8nOSw2UPU3Z1oXtFdcsa
        ruMmgDJazjwdxEV9orlxT66kfiVD8ME6ej/Y+L6ugMmgKeVy52hACAmNsxZoA76Kd0Gimj
        qhgKpK2NHrwmgFJk9GVhLymXgYtxDi2NviRzy4tdcV3vxFUY3Zb5vEq4Z1jOAqfr8CE6DR
        OCYf2yPixn+L0+8f0H/1Xx3xyYRfYpvPJET58HWbcDlkop0n+K8/jlvov+ssjQ7PEp/kTi
        K4fW0mqqUNZweAAT4Zw5cPgxWV8+Fgm6NGOmn+xRRzONzYx3ge0d4L1XoqzTRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649165143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVfL+n5pd7cP1D7iEgDx1sRuang/QKBVMoT4FjG4/yk=;
        b=sTMt6t9kqCm7ejmE2CrJp4LikiVOUb/79aOdzF8qg0ReNoJFzExYHeDQ2pMd6RIuFXjvCG
        TL6DYm/M7xZ/6eAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 12/12] printk: remove @console_locked
Date:   Tue,  5 Apr 2022 15:31:35 +0206
Message-Id: <20220405132535.649171-13-john.ogness@linutronix.de>
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
 kernel/printk/printk.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a5525a7b7bc5..2da66adac87e 100644
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
@@ -2675,7 +2667,6 @@ void console_lock(void)
 	if (console_suspended)
 		return;
 	console_kthreads_block();
-	console_locked = 1;
 	console_may_schedule = 1;
 }
 EXPORT_SYMBOL(console_lock);
@@ -2700,15 +2691,26 @@ int console_trylock(void)
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
 
@@ -2759,8 +2761,6 @@ static inline bool console_is_usable(struct console *con)
 
 static void __console_unlock(void)
 {
-	console_locked = 0;
-
 	/*
 	 * Depending on whether console_lock() or console_trylock() was used,
 	 * appropriately allow the kthread printers to continue.
@@ -3058,7 +3058,6 @@ void console_unblank(void)
 	} else
 		console_lock();
 
-	console_locked = 1;
 	console_may_schedule = 0;
 	for_each_console(c)
 		if ((c->flags & CON_ENABLED) && c->unblank)
-- 
2.30.2

