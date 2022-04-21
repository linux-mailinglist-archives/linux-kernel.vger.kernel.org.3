Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC44350AACD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442058AbiDUV0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441959AbiDUVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:25:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AD54EA35
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:22:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650576175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14DH9D9z/wsVNr1YB0yRgxAkaymy7LahF3OZ0YxbsMU=;
        b=qEHcEde1G39Z96HjK+qY+oc122TuO6hLarUIhkTbmxLbDgzadHM2r+BNvnxjjysyFZ+4V+
        wiERWviABrtE6UQg2xIIpUEO3gTjNJo4JnIseA8Elxy/gjpr0FbwkBlCE3CHP2rFY3AETm
        p3VrMy66LdG3Va5/nYiLw77TuGfDJgCJdGPpVOLKKQnUbaZIupjQo3cNbfuwyWc+ZouXjH
        c62C6u4Ih8H8jqt9ciKjfclrcxmKYGvNunGMrUFxhxFTZtviRarkNcUtCXdCGWLe7OIRCh
        bHP6DeYG/2ntpC8DiNhDug86S2CUryr3MkXi0z5tx+qcdX86wR1iwOD0KuAiiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650576175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14DH9D9z/wsVNr1YB0yRgxAkaymy7LahF3OZ0YxbsMU=;
        b=80lpftAwGXpKnaH2szbwo0RNv0eFwnj0SSyLtxFN1+tEQ1MsEPSXTOeH2TuT0u4q0c8Gmn
        vPO7vqg03UssgyBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 08/15] printk: add con_printk() macro for console details
Date:   Thu, 21 Apr 2022 23:28:43 +0206
Message-Id: <20220421212250.565456-9-john.ogness@linutronix.de>
In-Reply-To: <20220421212250.565456-1-john.ogness@linutronix.de>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
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

