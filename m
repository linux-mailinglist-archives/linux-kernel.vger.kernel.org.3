Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45854F50A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842674AbiDFBeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352955AbiDEPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:11:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF1108BF8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:25:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649165139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FB2Z6hYDK+Vgm7eUKCCLcgZ+HVauZdnVGbPABY+Y1k=;
        b=icB3EMpOJuf8texvfCSBnBqyOgoXH4jrA/rn3q+E7sG/yby41Mh5RJVHaEJI7dpCiYFw1h
        u8sMcgI+zzoeJ/2gSxNfpASvWFjAk+zceA9Yjq5Q5aTLMea/YVGUcS3VV7CV34e8IN9UZs
        u2aETwfQJwYFp6HBLkb6exE9JqEDNJBOVgf3gWG78kmRu2QqJ89FQIWzh7M4uSooYh+eoJ
        10F0fFOZdMWVreNSqjvbvq/tkEr0xQiR3hWt8S25/fhLxoLk0IVDORAKlB7IHU1bykGZ1V
        3Swttqj/DbI/eff1+04GM9MaFcj4xrBatdY6MjCj5AWClOAEfOKEI3Xlp22Mpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649165139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FB2Z6hYDK+Vgm7eUKCCLcgZ+HVauZdnVGbPABY+Y1k=;
        b=2M0/eko3SPx6uw1glcr44L6P/SRq4cDR4eI8PzhDrRh6QpnASTNBIx2YwRQp4QzShOodSt
        243RTUjuY6GI0rBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 05/12] printk: add macro for console detail messages
Date:   Tue,  5 Apr 2022 15:31:28 +0206
Message-Id: <20220405132535.649171-6-john.ogness@linutronix.de>
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

It is useful to generate log messages that include details about
the related console. Rather than duplicate the logic to assemble
the details, put that logic into a macro printk_console_msg().

Once console printers become threaded, this macro will find many
users.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fb9a6eaf54fd..39ca9d758e52 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2993,6 +2993,10 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
+#define printk_console_msg(c, lvl, msg) \
+	printk(lvl pr_fmt("%sconsole [%s%d] " msg "\n"), \
+	       (c->flags & CON_BOOT) ? "boot" : "", c->name, c->index)
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -3131,9 +3135,7 @@ void register_console(struct console *newcon)
 	 * users know there might be something in the kernel's log buffer that
 	 * went to the bootconsole (that they do not see on the real console)
 	 */
-	pr_info("%sconsole [%s%d] enabled\n",
-		(newcon->flags & CON_BOOT) ? "boot" : "" ,
-		newcon->name, newcon->index);
+	printk_console_msg(newcon, KERN_INFO, "enabled");
 	if (bootcon_enabled &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
 	    !keep_bootcon) {
@@ -3152,9 +3154,7 @@ int unregister_console(struct console *console)
 	struct console *con;
 	int res;
 
-	pr_info("%sconsole [%s%d] disabled\n",
-		(console->flags & CON_BOOT) ? "boot" : "" ,
-		console->name, console->index);
+	printk_console_msg(console, KERN_INFO, "disabled");
 
 	res = _braille_unregister_console(console);
 	if (res < 0)
-- 
2.30.2

