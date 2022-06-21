Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BEE552DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348832AbiFUJJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348817AbiFUJJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:09:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5C99FD1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:09:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 657B91F98E;
        Tue, 21 Jun 2022 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655802542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=huBtSo3bdU9whcST8tP7s358GZfCfamKI0DUTwediFM=;
        b=lMxjocMXcc7EEiT967eWwDdsoZAoOdRppzcbCfD5PwGYBctTvYxr4rx9SB7VLYIxEPV87C
        W6FB6uQadT7TXSMqMufwr174ExM9+QzfgzZSfdKt0rPWQndfwCNBu0biUnig7osn1rEHT0
        YjALM+OBRG3250L/L6vnioj5MbnO1GI=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2287B2C141;
        Tue, 21 Jun 2022 09:09:01 +0000 (UTC)
Date:   Tue, 21 Jun 2022 11:09:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] printk/console: Enable console kthreads only when there
 is no boot console left
Message-ID: <20220621090900.GB7891@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Threaded console printing does not take into consideration that boot
consoles may be accessing the same hardware as normal consoles and thus
must not be called in parallel.

Since it is currently not possible to identify which consoles are
accessing the same hardware, delay threaded console printing activation
until it is known that there are no boot consoles registered.

Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
Link: https://lore.kernel.org/r/2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com
Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
Reported-by: Marek Behún <kabel@kernel.org>
[john.ogness@linutronix.de: Better description of the problem.]
Signed-off-by: Petr Mladek <pmladek@suse.com>
Tested-by: Marek Behún <kabel@kernel.org>
---
Changes against v1:

+ Updated comment and commit message [Linus,John]
+ Added Tested-by [Marek]

 kernel/printk/printk.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b095fb5f5f61..157a3e8c01bb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3551,6 +3551,19 @@ void __init console_init(void)
 	}
 }
 
+static int __init printk_activate_kthreads(void)
+{
+	struct console *con;
+
+	console_lock();
+	printk_kthreads_available = true;
+	for_each_console(con)
+		printk_start_kthread(con);
+	console_unlock();
+
+	return 0;
+}
+
 /*
  * Some boot consoles access data that is in the init section and which will
  * be discarded after the initcalls have been run. To make sure that no code
@@ -3567,6 +3580,7 @@ void __init console_init(void)
  */
 static int __init printk_late_init(void)
 {
+	bool no_bootcon = true;
 	struct console *con;
 	int ret;
 
@@ -3588,7 +3602,10 @@ static int __init printk_late_init(void)
 			pr_warn("bootconsole [%s%d] uses init memory and must be disabled even before the real one is ready\n",
 				con->name, con->index);
 			unregister_console(con);
+			continue;
 		}
+
+		no_bootcon = false;
 	}
 	ret = cpuhp_setup_state_nocalls(CPUHP_PRINTK_DEAD, "printk:dead", NULL,
 					console_cpu_notify);
@@ -3597,23 +3614,19 @@ static int __init printk_late_init(void)
 					console_cpu_notify, NULL);
 	WARN_ON(ret < 0);
 	printk_sysctl_init();
-	return 0;
-}
-late_initcall(printk_late_init);
-
-static int __init printk_activate_kthreads(void)
-{
-	struct console *con;
 
-	console_lock();
-	printk_kthreads_available = true;
-	for_each_console(con)
-		printk_start_kthread(con);
-	console_unlock();
+	/*
+	 * Boot consoles may be accessing the same hardware as normal
+	 * consoles and thus must not be called in parallel. Therefore
+	 * only activate threaded console printing if it is known that
+	 * there are no boot consoles registered.
+	 */
+	if (no_bootcon)
+		printk_activate_kthreads();
 
 	return 0;
 }
-early_initcall(printk_activate_kthreads);
+late_initcall(printk_late_init);
 
 #if defined CONFIG_PRINTK
 /* If @con is specified, only wait for that console. Otherwise wait for all. */
-- 
2.35.3

