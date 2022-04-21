Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FED50AAC0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442029AbiDUVZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441961AbiDUVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:25:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5F94EA31
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:22:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650576174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1YToStOsTzwQuM9NAdLhD8VIOcfrZOzhia7aCNE4qk=;
        b=fhNSANaaTeSUxaziMUZfolNU2TY14c2ODq7zErNl07VaBYYaGVMvLus8KNX8hTDoDM4wSq
        1gVA0v3Zk+1ape9LDHQ0kTvJcnyX9/Hlz/upfrZ1Xp5ES4aK1/K34tbxvKMXfyLSORo8rQ
        LNP4eR4rZVbIFnQGo9cyb/rsbIHeS7BiCi2jQfMts9iU6hi/9nh37bd7At9DFl1Ff1SZ54
        5kGlA3GmoBVzrhV+DxcVSKZ+x3xn2aa37NoopVrk02+84GzLckdQrNfxeLxXUw5gL75Uel
        jhU9gFL/McKpbZlar8AmLCzemLONVILV82Gkzxy6TivN3wzotLdATw8T3g0h+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650576174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1YToStOsTzwQuM9NAdLhD8VIOcfrZOzhia7aCNE4qk=;
        b=kEX2AaWpKrfn8qgNJBfh69rxXxRdsDIPnOh/HM8cg4ilPXj3YA4csXHTBd2smMZdM5KZhP
        xngFVHue/DWCUqCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 05/15] printk: wake waiters for safe and NMI contexts
Date:   Thu, 21 Apr 2022 23:28:40 +0206
Message-Id: <20220421212250.565456-6-john.ogness@linutronix.de>
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

When printk() is called from safe or NMI contexts, it will directly
store the record (vprintk_store()) and then defer the console output.
However, defer_console_output() only causes console printing and does
not wake any waiters of new records.

Wake waiters from defer_console_output() so that they also are aware
of the new records from safe and NMI contexts.

Fixes: 03fc7f9c99c1 ("printk/nmi: Prevent deadlock when accessing the main log buffer in NMI")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e23357002648..7bb148a1debb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -754,7 +754,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		 * prepare_to_wait_event() pairs with the full memory barrier
 		 * within wq_has_sleeper().
 		 *
-		 * This pairs with wake_up_klogd:A.
+		 * This pairs with __wake_up_klogd:A.
 		 */
 		ret = wait_event_interruptible(log_wait,
 				prb_read_valid(prb,
@@ -1532,7 +1532,7 @@ static int syslog_print(char __user *buf, int size)
 		 * prepare_to_wait_event() pairs with the full memory barrier
 		 * within wq_has_sleeper().
 		 *
-		 * This pairs with wake_up_klogd:A.
+		 * This pairs with __wake_up_klogd:A.
 		 */
 		len = wait_event_interruptible(log_wait,
 				prb_read_valid(prb, seq, NULL)); /* LMM(syslog_print:A) */
@@ -3332,7 +3332,7 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =
 	IRQ_WORK_INIT_LAZY(wake_up_klogd_work_func);
 
-void wake_up_klogd(void)
+static void __wake_up_klogd(int val)
 {
 	if (!printk_percpu_data_ready())
 		return;
@@ -3349,22 +3349,26 @@ void wake_up_klogd(void)
 	 *
 	 * This pairs with devkmsg_read:A and syslog_print:A.
 	 */
-	if (wq_has_sleeper(&log_wait)) { /* LMM(wake_up_klogd:A) */
-		this_cpu_or(printk_pending, PRINTK_PENDING_WAKEUP);
+	if (wq_has_sleeper(&log_wait) || /* LMM(__wake_up_klogd:A) */
+	    (val & PRINTK_PENDING_OUTPUT)) {
+		this_cpu_or(printk_pending, val);
 		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	}
 	preempt_enable();
 }
 
-void defer_console_output(void)
+void wake_up_klogd(void)
 {
-	if (!printk_percpu_data_ready())
-		return;
+	__wake_up_klogd(PRINTK_PENDING_WAKEUP);
+}
 
-	preempt_disable();
-	this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
-	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
-	preempt_enable();
+void defer_console_output(void)
+{
+	/*
+	 * New messages may have been added directly to the ringbuffer
+	 * using vprintk_store(), so wake any waiters as well.
+	 */
+	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
 }
 
 void printk_trigger_flush(void)
-- 
2.30.2

