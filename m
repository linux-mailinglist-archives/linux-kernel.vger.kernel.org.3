Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9544D552073
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244618AbiFTPUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244576AbiFTPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:20:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22527E08
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:14:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D0AD221B35;
        Mon, 20 Jun 2022 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655738070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SoFB2BpxllfCrWxzKxJln9/E/pmAquuEKo7NBfk0/mo=;
        b=c64UCUWf/Klbv+y9ypZTy/eWydJDMS8GuKHin38bDkrx44v9oomVEIkxStGW/AmCJUYuSO
        AEEaLs/+r2fFlSlzXtnB/y4D/Y0zTpRceFppRtyEAPjwv7Z6pG7VatJT7e0AvP7ejaPR5D
        Y41Ez1RsG0vSMmyanZPOdnyQl1U4OAw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 712852C141;
        Mon, 20 Jun 2022 15:14:29 +0000 (UTC)
Date:   Mon, 20 Jun 2022 17:14:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] printk/console: Enable console kthreads only when there is
 no boot console left
Message-ID: <YrCO04oNncE1xF5K@alley>
References: <20220619204949.50d9154d@thinkpad>
 <87r13kwawb.fsf@jogness.linutronix.de>
 <20220620112936.48fcb2a4@thinkpad>
 <YrBdjVwBOVgLfHyb@alley>
 <CAHk-=wgdquXVVE37CZooVK4X+YdSa7XoGtjr71CEYh8UsdKUow@mail.gmail.com>
 <YrCDNqsPrY+Hs9ju@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrCDNqsPrY+Hs9ju@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The console kthreads uncovered several races in console drivers.
All problems were in situation when a console was being properly
initialized and registered while an early console, using the same
port, was being used.

These problems are pretty hard to debug because they often result
into silent boot crashes. It would be nice to fix them but it
looks like a can of worms.

Prevent these problems by delaying the use of console kthreads
after all early consoles are gone. It might later be optimized.
But let's close this can of worms with a big hammer for now
so that they do not break first impression on the kthreads
that solve other real problems.

Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
Link: https://lore.kernel.org/r/2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com
Reported=by: Marek Behún <kabel@kernel.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b095fb5f5f61..c0c5e2b6b91d 100644
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
@@ -3597,23 +3614,18 @@ static int __init printk_late_init(void)
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
+	 * Some console drivers are not ready to use the same port with
+	 * boot (early) and normal console in parallel. Stay on the safe
+	 * side and enable kthreads only when there is no boot console.
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

