Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD76C507D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358138AbiDSXt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347036AbiDSXtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:49:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F341D0CC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:46:41 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650411999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6/o/PjZ0Qpg9L4OKIrmGvdcvR+21LH+ujrVsqfiSt0=;
        b=ZH55eHdhqD0hK56pLkFN1875zoAdSildxIT8/cLmkWit8NvyYB/rOAkonzF7zEIzn2u6KP
        j46F1QkFOcj+uJvicJkRyli3urWAxF05xWcMiPAcGybzRnx/j5oG0utmqRAylai7W2Qcna
        oI6SrlJxiJh6BfKf1Zl7u74TFC4/RdPy7WW1JqFyF3jVPCKZmpzUQXelGZhIwXGyV7RnVC
        2bZsVdiOkdoZ1FLZlO/mg/gdLbcuiN5nNQVXtmFVDLl24PrCmQlijTtUQimGpBaaiAEXK1
        EZKVI2oq4kLCoWQibSkgYCMM/LWwTnYZXzQHS+DRywYQEE58qWDlGklE9ISh/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650411999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6/o/PjZ0Qpg9L4OKIrmGvdcvR+21LH+ujrVsqfiSt0=;
        b=7IYbHz3QLMuWIudlG/JSLNZ2HKTfpGLJgfeL3D44mhRhozUa6EZiSuZ+XL/TELOaVN3L0y
        HTvd/eNDxp06sgBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 02/15] printk: cpu sync always disable interrupts
Date:   Wed, 20 Apr 2022 01:52:24 +0206
Message-Id: <20220419234637.357112-3-john.ogness@linutronix.de>
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

The CPU sync functions are a NOP for !CONFIG_SMP. But for
!CONFIG_SMP they still need to disable interrupts in order to
preserve context within the CPU sync sections.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/printk.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 859323a52985..b70a42f94031 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -281,9 +281,16 @@ extern int __printk_cpu_sync_try_get(void);
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
@@ -322,13 +329,6 @@ extern void __printk_cpu_sync_put(void);
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

