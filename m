Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AA851489B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356404AbiD2L4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239331AbiD2L42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:56:28 -0400
Received: from mail.pcs.gmbh (mail.pcs.gmbh [89.27.162.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09390C6ECD;
        Fri, 29 Apr 2022 04:53:08 -0700 (PDT)
Received: from mail.csna.de (mail.csna.de [89.27.162.50])
        by mail.pcs.gmbh with ESMTPA
        ; Fri, 29 Apr 2022 13:52:48 +0200
Received: from EXCHANGE2019.pcs.ditec.de (mail.pcs.com [89.27.162.5])
        by mail.csna.de with ESMTPA
        ; Fri, 29 Apr 2022 13:52:48 +0200
Received: from EXCHANGE2019.pcs.ditec.de (192.168.8.214) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 13:52:48 +0200
Received: from lxtpfaff.pcs.ditec.de (192.168.9.96) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22
 via Frontend Transport; Fri, 29 Apr 2022 13:52:48 +0200
Date:   Fri, 29 Apr 2022 13:52:48 +0200
From:   Thomas Pfaff <tpfaff@pcs.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>, Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2] irq/core: synchronize irq_thread startup
Message-ID: <1e3f96b7-9294-1534-e83b-efe3602f876f@pcs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-KSE-ServerInfo: EXCHANGE2019.pcs.ditec.de, 9
X-KSE-AntiSpam-Interceptor-Info: white sender email list
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 29.04.2022 09:07:00
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
v1-v2:
  - use already existing resources
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 99cbdf55a8bd..dca57bed0d96 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -29,12 +29,14 @@ extern struct irqaction chained_action;
  * IRQTF_WARNED    - warning "IRQ_WAKE_THREAD w/o thread_fn" has been printed
  * IRQTF_AFFINITY  - irq thread is requested to adjust affinity
  * IRQTF_FORCED_THREAD  - irq action is force threaded
+ * IRQTF_UP        - signals that irq thread is ready
  */
 enum {
 	IRQTF_RUNTHREAD,
 	IRQTF_WARNED,
 	IRQTF_AFFINITY,
 	IRQTF_FORCED_THREAD,
+	IRQTF_UP,
 };
 
 /*
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f1d5a94c6c9f..7efa24629694 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1263,6 +1263,30 @@ static void irq_wake_secondary(struct irq_desc *desc, struct irqaction *action)
 	raw_spin_unlock_irq(&desc->lock);
 }
 
+/*
+ * Internal function to notify that irq_thread is ready
+ */
+static void irq_thread_is_up(struct irq_desc *desc,
+		struct irqaction *action)
+{
+	set_bit(IRQTF_UP, &action->thread_flags);
+	wake_up(&desc->wait_for_threads);
+}
+
+/*
+ * Internal function to wake up irq_thread
+ * and wait until it is really up
+ */
+static void wait_for_irq_thread_startup(struct irq_desc *desc,
+		struct irqaction *action)
+{
+	if (action && action->thread) {
+		wake_up_process(action->thread);
+		wait_event(desc->wait_for_threads,
+			test_bit(IRQTF_UP, &action->thread_flags));
+	}
+}
+
 /*
  * Interrupt handler thread
  */
@@ -1287,6 +1311,8 @@ static int irq_thread(void *data)
 
 	irq_thread_check_affinity(desc, action);
 
+	irq_thread_is_up (desc, action);
+
 	while (!irq_wait_for_interrupt(action)) {
 		irqreturn_t action_ret;
 
@@ -1522,6 +1548,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		}
 	}
 
+	init_waitqueue_head(&desc->wait_for_threads);
+
 	/*
 	 * Create a handler thread when a thread function is supplied
 	 * and the interrupt does not nest into another interrupt
@@ -1698,8 +1726,6 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	}
 
 	if (!shared) {
-		init_waitqueue_head(&desc->wait_for_threads);
-
 		/* Setup the type (level, edge polarity) if configured: */
 		if (new->flags & IRQF_TRIGGER_MASK) {
 			ret = __irq_set_trigger(desc,
@@ -1795,14 +1821,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 
 	irq_setup_timings(desc, new);
 
-	/*
-	 * Strictly no need to wake it up, but hung_task complains
-	 * when no hard interrupt wakes the thread up.
-	 */
-	if (new->thread)
-		wake_up_process(new->thread);
-	if (new->secondary)
-		wake_up_process(new->secondary->thread);
+	wait_for_irq_thread_startup(desc, new);
+	wait_for_irq_thread_startup(desc, new->secondary);
 
 	register_irq_proc(irq, desc);
 	new->dir = NULL;


