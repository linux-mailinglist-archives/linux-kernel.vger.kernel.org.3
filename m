Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4D507D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358292AbiDSXtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352297AbiDSXtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:49:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870471EED2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:46:41 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650412000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dz1VIM0uOb4OFT5vjsJmvFN5uJS7lSMD11xUufLa4SE=;
        b=OZCGW8R3rDrfoeJVcFtn9I3/oLnd92vxhRSesXB28UUHsW5tEb0skqxclQAjj1xIVHk/Jt
        LLb2u/SkuQPOMLDKG8EwYovwZTLQKOUVuBjqhyReZmcjjJYE1VndLJo9ZEQvBDIXdCEm2y
        6CFWd3NVImL2t7PhQ133ZwBvEZLwX4Vv0sTdZsQzzidAVJBsaIcpRSalJe3xA7Bi8WwX3H
        cT9D/iBBvwmYaal9AOJJOZt/8OqTGRLBDSCrDljDChsOTvlC4oYnJk6vZRY228DZu0LTd7
        8DtIiWoWL9ekOOP9X+KFr4fjvSifUJsxzKhc0eS1+HB2wYE/y5OPapfnJ/bkMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650412000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dz1VIM0uOb4OFT5vjsJmvFN5uJS7lSMD11xUufLa4SE=;
        b=WVBX/41uM/GPuFFdEt0BZ77NL828pAS2Z6koZCHhKakxzjVYPC7M6+d+RUV3sqL1hDMFrD
        KZJAiyHto31wn3CQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 03/15] printk: add missing memory barrier to wake_up_klogd()
Date:   Wed, 20 Apr 2022 01:52:25 +0206
Message-Id: <20220419234637.357112-4-john.ogness@linutronix.de>
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

It is important that any new records are visible to preparing
waiters before the waker checks if the wait queue is empty.
Otherwise it is possible that:

- there are new records available
- the waker sees an empty wait queue and does not wake
- the preparing waiter sees no new records and begins to wait

This is exactly the problem that the function description of
waitqueue_active() warns about.

Use wq_has_sleeper() instead of waitqueue_active() because it
includes the necessary full memory barrier.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 13a1eebe72af..f817dfb4852d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -746,8 +746,19 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 			goto out;
 		}
 
+		/*
+		 * Guarantee this task is visible on the waitqueue before
+		 * checking the wake condition.
+		 *
+		 * The full memory barrier within set_current_state() of
+		 * prepare_to_wait_event() pairs with the full memory barrier
+		 * within wq_has_sleeper().
+		 *
+		 * This pairs with wake_up_klogd:A.
+		 */
 		ret = wait_event_interruptible(log_wait,
-				prb_read_valid(prb, atomic64_read(&user->seq), r));
+				prb_read_valid(prb,
+					atomic64_read(&user->seq), r)); /* LMM(devkmsg_read:A) */
 		if (ret)
 			goto out;
 	}
@@ -1513,7 +1524,18 @@ static int syslog_print(char __user *buf, int size)
 		seq = syslog_seq;
 
 		mutex_unlock(&syslog_lock);
-		len = wait_event_interruptible(log_wait, prb_read_valid(prb, seq, NULL));
+		/*
+		 * Guarantee this task is visible on the waitqueue before
+		 * checking the wake condition.
+		 *
+		 * The full memory barrier within set_current_state() of
+		 * prepare_to_wait_event() pairs with the full memory barrier
+		 * within wq_has_sleeper().
+		 *
+		 * This pairs with wake_up_klogd:A.
+		 */
+		len = wait_event_interruptible(log_wait,
+				prb_read_valid(prb, seq, NULL)); /* LMM(syslog_print:A) */
 		mutex_lock(&syslog_lock);
 
 		if (len)
@@ -3316,7 +3338,18 @@ void wake_up_klogd(void)
 		return;
 
 	preempt_disable();
-	if (waitqueue_active(&log_wait)) {
+	/*
+	 * Guarantee any new records can be seen by tasks preparing to wait
+	 * before this context checks if the wait queue is empty.
+	 *
+	 * The full memory barrier within wq_has_sleeper() pairs with the full
+	 * memory barrier within set_current_state() of
+	 * prepare_to_wait_event(), which is called after ___wait_event() adds
+	 * the waiter but before it has checked the wait condition.
+	 *
+	 * This pairs with devkmsg_read:A and syslog_print:A.
+	 */
+	if (wq_has_sleeper(&log_wait)) { /* LMM(wake_up_klogd:A) */
 		this_cpu_or(printk_pending, PRINTK_PENDING_WAKEUP);
 		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	}
-- 
2.30.2

