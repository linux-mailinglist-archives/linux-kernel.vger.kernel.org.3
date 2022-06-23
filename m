Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B9D557E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiFWOwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiFWOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:52:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4869146B32;
        Thu, 23 Jun 2022 07:52:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D677621AE1;
        Thu, 23 Jun 2022 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655995923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXW26y9F/2k8qOFy2KwGAmlvmLMXqdLDBAX5Dm10fvI=;
        b=fcBjB79M1/qA5j6jUveHP2HDT3wne+KX7T3Xzm9/++Wb54mhvkQPOJEmZCCi2dgIiSa8+S
        QhJfpa7J/wbaY7/abH5j15AbcIdwLM4T7I+qVnQXClx3bEry6jHQpeyfVq0UjNZknKc+9S
        voL2uMKkd36jd9FxyMrAN0++utkl2kg=
Received: from alley.suse.cz (unknown [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id B2E6F2C142;
        Thu, 23 Jun 2022 14:52:02 +0000 (UTC)
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
Subject: [PATCH 3/6] Revert "printk: remove @console_locked"
Date:   Thu, 23 Jun 2022 16:51:54 +0200
Message-Id: <20220623145157.21938-4-pmladek@suse.com>
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

This reverts commit ab406816fca009349b89cbde885daf68a8c77e33.

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
 kernel/printk/printk.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ea3dd55709e7..dfd1a19b95d6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -340,7 +340,15 @@ static void console_kthreads_unblock(void)
 	console_kthreads_blocked = false;
 }
 
-static int console_suspended;
+/*
+ * This is used for debugging the mess that is the VT code by
+ * keeping track if we have the console semaphore held. It's
+ * definitely not the perfect debug tool (we don't know if _WE_
+ * hold it and are racing, but it helps tracking those weird code
+ * paths in the console code where we end up in places I want
+ * locked without the console semaphore held).
+ */
+static int console_locked, console_suspended;
 
 /*
  *	Array of consoles built from command line options (console=)
@@ -2711,6 +2719,7 @@ void console_lock(void)
 	if (console_suspended)
 		return;
 	console_kthreads_block();
+	console_locked = 1;
 	console_may_schedule = 1;
 }
 EXPORT_SYMBOL(console_lock);
@@ -2735,26 +2744,15 @@ int console_trylock(void)
 		up_console_sem();
 		return 0;
 	}
+	console_locked = 1;
 	console_may_schedule = 0;
 	return 1;
 }
 EXPORT_SYMBOL(console_trylock);
 
-/*
- * This is used to help to make sure that certain paths within the VT code are
- * running with the console lock held. It is definitely not the perfect debug
- * tool (it is not known if the VT code is the task holding the console lock),
- * but it helps tracking those weird code paths in the console code such as
- * when the console is suspended: where the console is not locked but no
- * console printing may occur.
- *
- * Note: This returns true when the console is suspended but is not locked.
- *       This is intentional because the VT code must consider that situation
- *       the same as if the console was locked.
- */
 int is_console_locked(void)
 {
-	return (console_kthreads_blocked || atomic_read(&console_kthreads_active));
+	return (console_locked || atomic_read(&console_kthreads_active));
 }
 EXPORT_SYMBOL(is_console_locked);
 
@@ -2810,6 +2808,8 @@ static inline bool console_is_usable(struct console *con)
 
 static void __console_unlock(void)
 {
+	console_locked = 0;
+
 	/*
 	 * Depending on whether console_lock() or console_trylock() was used,
 	 * appropriately allow the kthread printers to continue.
@@ -3127,6 +3127,7 @@ void console_unblank(void)
 	} else
 		console_lock();
 
+	console_locked = 1;
 	console_may_schedule = 0;
 	for_each_console(c)
 		if ((c->flags & CON_ENABLED) && c->unblank)
-- 
2.35.3

