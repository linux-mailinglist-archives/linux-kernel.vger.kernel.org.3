Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54D4AC9D1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbiBGTpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbiBGTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:43:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD63C0401E4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:43:28 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644263006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YeoQK9icCZQHqxjTMXztaF3pNjld+IRlJPuqBw66sL4=;
        b=hxkII20lpD34X3CtBuHp0CCV19hqTdEWFnxIE5rW4TLI34jRq/J67CNh5e4+3zDXTBLSKX
        ZGvj+VV6gesck38MmRndRSBkyFNywpPs4q0oJpdExUBfdTKSpOGEdN52XBeRDmehsVKx+A
        n451bPzMFczXFfkN5j4OCPOXRgMJ1xv9CrQMIxejRmtoaMTYIuz+DHiC0wlc5VGxDlC7fs
        nUutZecadPcS0xzYsrZawVhhTontfdlHboTCl6zinMlYZTzb6CkP6iP6zHuRJzs7wfI6Af
        R42Sf06HJt/gS/xMEXFABJGYI7IEUwBBsqxBnfXKmXGxzu4kDpWYofX+kkzcoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644263006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YeoQK9icCZQHqxjTMXztaF3pNjld+IRlJPuqBw66sL4=;
        b=nVSx6zvM/ianRuZFzFAUSAoY9g0kHDH5KgIleQqCyOf3LLx4Zlas+Cwvz+Wb0pPCQkZFHu
        sJpkZzB1vWIqg9CA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 02/13] printk: cpu sync always disable interrupts
Date:   Mon,  7 Feb 2022 20:49:12 +0106
Message-Id: <20220207194323.273637-3-john.ogness@linutronix.de>
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

The CPU sync functions are a NOP for !CONFIG_SMP. But for
!CONFIG_SMP they still need to disable interrupts in order to
preserve context within the CPU sync sections.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 780408b29c13..cd8192e611a1 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -285,9 +285,16 @@ extern int __printk_cpu_sync_try_get(void);
 extern void __printk_cpu_sync_wait(void);
 extern void __printk_cpu_sync_put(void);
 
+#else
+
+#define __printk_cpu_sync_try_get() true
+#define __printk_cpu_sync_wait()
+#define __printk_cpu_sync_put()
+#endif /* CONFIG_SMP */
+
 /**
- * printk_cpu_sync_get_irqsave() - Acquire the printk cpu-reentrant spinning
- *                                 lock and disable interrupts.
+ * printk_cpu_sync_get_irqsave() - Disable interrupts and acquire the printk
+ *                                 cpu-reentrant spinning lock.
  * @flags: Stack-allocated storage for saving local interrupt state,
  *         to be passed to printk_cpu_sync_put_irqrestore().
  *
@@ -314,13 +321,6 @@ extern void __printk_cpu_sync_put(void);
 		local_irq_restore(flags);	\
 	} while (0)
 
-#else
-
-#define printk_cpu_sync_get_irqsave(flags) ((void)flags)
-#define printk_cpu_sync_put_irqrestore(flags) ((void)flags)
-
-#endif /* CONFIG_SMP */
-
 extern int kptr_restrict;
 
 /**
-- 
2.30.2

