Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F83513221
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345241AbiD1LNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344512AbiD1LNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:13:45 -0400
X-Greylist: delayed 1227 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Apr 2022 04:10:29 PDT
Received: from mail.pcs.gmbh (mail.pcs.gmbh [89.27.162.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C870186D2;
        Thu, 28 Apr 2022 04:10:27 -0700 (PDT)
Received: from mail.csna.de (mail.csna.de [89.27.162.50])
        by mail.pcs.gmbh with ESMTPA
        ; Thu, 28 Apr 2022 12:49:58 +0200
Received: from EXCHANGE2019.pcs.ditec.de (mail.pcs.com [89.27.162.5])
        by mail.csna.de with ESMTPA
        ; Thu, 28 Apr 2022 12:49:59 +0200
Received: from EXCHANGE2019.pcs.ditec.de (192.168.8.214) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 12:49:58 +0200
Received: from lxtpfaff.pcs.ditec.de (192.168.9.96) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22
 via Frontend Transport; Thu, 28 Apr 2022 12:49:58 +0200
Date:   Thu, 28 Apr 2022 12:49:58 +0200
From:   Thomas Pfaff <tpfaff@pcs.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-rt-users@vger.kernel.org>
Subject: [PATCH] irq: synchronize irq_thread startup
Message-ID: <f18798-9e66-66e7-8c9d-cb8eeda364c4@pcs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-KSE-ServerInfo: EXCHANGE2019.pcs.ditec.de, 9
X-KSE-AntiSpam-Interceptor-Info: white sender email list
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 28.04.2022 09:19:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Pfaff <tpfaff@pcs.com>

While running
"while /bin/true; do setserial /dev/ttyS0 uart none;
setserial /dev/ttyS0 uart 16550A; done"
on a kernel with threaded irqs, setserial is hung after some calls.

setserial opens the device, this will install an irq handler if the uart is
not none, followed by TIOCGSERIAL and TIOCSSERIAL ioctls.
Then the device is closed. On close, synchronize_irq() is called by
serial_core.

If the close comes too fast, the irq_thread does not really start,
it is terminated immediately without going into irq_thread().
But an interrupt might already been handled by
irq_default_primary_handler(), going to __irq_wake_thread() and
incrementing threads_active.
If this happens, synchronize_irq() will hang forever, because the
irq_thread is already dead, and threads_active will never be decremented.

The fix is to make sure that the irq_thread is really started
during __setup_irq().

Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
---
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index f40754caaefa..82a16a12d472 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -113,6 +113,8 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
  * @secondary:	pointer to secondary irqaction (force threading)
  * @thread_flags:	flags related to @thread
  * @thread_mask:	bitmask for keeping track of @thread activity
+ * @thread_is_up:	threaded irq handler initializated
+ * @wait_for_thread:	wait queue to wait for thread initialization
  * @dir:	pointer to the proc/irq/NN/name entry
  */
 struct irqaction {
@@ -127,6 +129,8 @@ struct irqaction {
 	unsigned int		flags;
 	unsigned long		thread_flags;
 	unsigned long		thread_mask;
+	atomic_t		thread_is_up;
+	wait_queue_head_t	wait_for_thread;
 	const char		*name;
 	struct proc_dir_entry	*dir;
 } ____cacheline_internodealigned_in_smp;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c03f71d5ec10..345e4f824c58 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1272,6 +1272,9 @@ static int irq_thread(void *data)
 
 	irq_thread_check_affinity(desc, action);
 
+	atomic_set(&action->thread_is_up, 1);
+	wake_up(&action->wait_for_thread);
+
 	while (!irq_wait_for_interrupt(action)) {
 		irqreturn_t action_ret;
 
@@ -1415,6 +1418,8 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 {
 	struct task_struct *t;
 
+	init_waitqueue_head(&new->wait_for_thread);
+
 	if (!secondary) {
 		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
 				   new->name);
@@ -1781,13 +1786,18 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	irq_setup_timings(desc, new);
 
 	/*
-	 * Strictly no need to wake it up, but hung_task complains
-	 * when no hard interrupt wakes the thread up.
+	 * wake thread up, and wait until it is really up
 	 */
-	if (new->thread)
+	if (new->thread) {
 		wake_up_process(new->thread);
-	if (new->secondary)
+		wait_event(new->wait_for_thread,
+			   atomic_read(&new->thread_is_up));
+	}
+	if (new->secondary) {
 		wake_up_process(new->secondary->thread);
+		wait_event(new->secondary->wait_for_thread,
+			   atomic_read(&new->secondary->thread_is_up));
+	}
 
 	register_irq_proc(irq, desc);
 	new->dir = NULL;


