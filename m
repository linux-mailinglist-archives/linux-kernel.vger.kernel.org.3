Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E8C575B38
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiGOGK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiGOGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:10:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59017735BF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:10:45 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657865443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34AfcYpevfLpsDQXx/FrfkJftZBZGpSvDOrexHkg1Ig=;
        b=pt1XvMFaFcgmDP+bDSKk87KCLSwA9Vwnmvss/Ga7S2kJPU4FdC5p5otm5tnKzA93gLfaBM
        2sqv1+BQ3ZE4FS2N844tja4oiFUieKjhCIz23HjvEBD14JNdNKHEM9USJ3J3js2R1muLkR
        c0t2YSwBNBuNDU115qFOydbpJ74WJsPyCk+KRXBdxPXTwZaSSkL8U0I6Cvi2CfN+T+DfQ1
        ZxeMrEuCeBx1eK4EoBIgcgTl71rwCi13v2Zs/s/fSjDTSxj/zaRxZRuc9WXrFqbkp9YnTU
        UJzEY6tdLva6wE3goE7njDeVJthkKUahGKEysV5GRPZRJG6hXbfhYxVv7fP91w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657865443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34AfcYpevfLpsDQXx/FrfkJftZBZGpSvDOrexHkg1Ig=;
        b=s8p4KjZQTCDnVdlw0A8f3hsaM1Am+lI8UlfF0y7SwE35QRP0d0Z54Ij668d/viwRBSr0uR
        Ux7SvrXmnTPXSyAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH v3] printk: do not wait for consoles when suspended
Date:   Fri, 15 Jul 2022 08:16:42 +0206
Message-Id: <20220715061042.373640-2-john.ogness@linutronix.de>
In-Reply-To: <20220715061042.373640-1-john.ogness@linutronix.de>
References: <20220715061042.373640-1-john.ogness@linutronix.de>
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

The console_stop() and console_start() functions call pr_flush().
When suspending, these functions are called by the serial subsystem
while the serial port is suspended. In this scenario, if there are
any pending messages, a call to pr_flush() will always result in a
timeout because the serial port cannot make forward progress. This
causes longer suspend and resume times.

Add a check in pr_flush() so that it will immediately timeout if
the consoles are suspended.

Fixes: 3b604ca81202 ("printk: add pr_flush()")
Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 v3: add more details to commit message and comment

 v2: only avoid wait if suspended

 kernel/printk/printk.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b49c6ff6dca0..a1a81fd9889b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3380,6 +3380,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		diff = 0;
 
 		console_lock();
+
 		for_each_console(c) {
 			if (con && con != c)
 				continue;
@@ -3389,11 +3390,19 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (printk_seq < seq)
 				diff += seq - printk_seq;
 		}
-		console_unlock();
 
-		if (diff != last_diff && reset_on_progress)
+		/*
+		 * If consoles are suspended, it cannot be expected that they
+		 * make forward progress, so timeout immediately. @diff is
+		 * still used to return a valid flush status.
+		 */
+		if (console_suspended)
+			remaining = 0;
+		else if (diff != last_diff && reset_on_progress)
 			remaining = timeout_ms;
 
+		console_unlock();
+
 		if (diff == 0 || remaining == 0)
 			break;
 
-- 
2.30.2

