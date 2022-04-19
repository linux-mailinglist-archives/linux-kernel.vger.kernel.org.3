Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAED9507D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358503AbiDSXt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358186AbiDSXt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:49:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89B1EED2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:46:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650412001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBjClnBxEfMeC3p10TB7liIc2QFR/jSaE6F/bJi79Lw=;
        b=Q0ubYu4KLot7D0bHrMIUBn1QhracgRQZTn5w7oxzYkCQkGN7BLtdQ7ELRD72S56qqrxjlI
        OwIifvHU0yR08yF1pnkt4BCzoTMyF6D0/K65HSA2x5sW6E/wAOWKka8nmwHpVvf6i2Nw3s
        OWg2ReBzgvEKdoc7AAmsGTOw3fbAp1vpaMkpAOz3G3UP9j6hKYEKMfMS3vQFPCQxjWRw+0
        57I1Wd0El5KVDtBld2P/7Hq814PSelkIhVPNx36mCBwXThiQDgeg0xFTgjuHvdgTmWDVbL
        Szfp4xTGkkamDbSGcFb1DvCj3fr6Cc24LxtgVNtpfWh5fAUhiLm+xc2G/bNfZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650412001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBjClnBxEfMeC3p10TB7liIc2QFR/jSaE6F/bJi79Lw=;
        b=C5c5z7EXSBJoTSC3m1o3EhPMFXt+YQWeMH9tnRjbGc8g3VOoe7qjygIzvfPt5iim8k1V8p
        YdewW1EN4PnIiRDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 08/15] printk: add con_printk() macro for console details
Date:   Wed, 20 Apr 2022 01:52:30 +0206
Message-Id: <20220419234637.357112-9-john.ogness@linutronix.de>
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

It is useful to generate log messages that include details about
the related console. Rather than duplicate the code to assemble
the details, put that code into a macro con_printk().

Once console printers become threaded, this macro will find more
users.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2f99e0b383b9..e36d3ed41afa 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3015,6 +3015,11 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
+#define con_printk(lvl, con, fmt, ...)			\
+	printk(lvl pr_fmt("%sconsole [%s%d] " fmt),	\
+	       (con->flags & CON_BOOT) ? "boot" : "",	\
+	       con->name, con->index, ##__VA_ARGS__)
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -3153,9 +3158,7 @@ void register_console(struct console *newcon)
 	 * users know there might be something in the kernel's log buffer that
 	 * went to the bootconsole (that they do not see on the real console)
 	 */
-	pr_info("%sconsole [%s%d] enabled\n",
-		(newcon->flags & CON_BOOT) ? "boot" : "" ,
-		newcon->name, newcon->index);
+	con_printk(KERN_INFO, newcon, "enabled\n");
 	if (bootcon_enabled &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
 	    !keep_bootcon) {
@@ -3174,9 +3177,7 @@ int unregister_console(struct console *console)
 	struct console *con;
 	int res;
 
-	pr_info("%sconsole [%s%d] disabled\n",
-		(console->flags & CON_BOOT) ? "boot" : "" ,
-		console->name, console->index);
+	con_printk(KERN_INFO, console, "disabled\n");
 
 	res = _braille_unregister_console(console);
 	if (res < 0)
-- 
2.30.2

