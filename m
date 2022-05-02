Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B317F516EE2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384733AbiEBLcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384723AbiEBLcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:32:21 -0400
Received: from mail.pcs.gmbh (mail.pcs.gmbh [89.27.162.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C9FD;
        Mon,  2 May 2022 04:28:52 -0700 (PDT)
Received: from mail.csna.de (mail.csna.de [89.27.162.50])
        by mail.pcs.gmbh with ESMTPA
        ; Mon, 2 May 2022 13:28:28 +0200
Received: from EXCHANGE2019.pcs.ditec.de (mail.pcs.com [89.27.162.5])
        by mail.csna.de with ESMTPA
        ; Mon, 2 May 2022 13:28:28 +0200
Received: from EXCHANGE2019.pcs.ditec.de (192.168.8.214) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 13:28:29 +0200
Received: from lxtpfaff.pcs.ditec.de (192.168.9.96) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22
 via Frontend Transport; Mon, 2 May 2022 13:28:29 +0200
Date:   Mon, 2 May 2022 13:28:29 +0200
From:   Thomas Pfaff <tpfaff@pcs.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v3] irq/core: synchronize irq_thread startup
Message-ID: <552fe7b4-9224-b183-bb87-a8f36d335690@pcs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-KSE-ServerInfo: EXCHANGE2019.pcs.ditec.de, 9
X-KSE-AntiSpam-Interceptor-Info: white sender email list
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 02.05.2022 09:21:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
v2-v3:
  - initialize wait_for_threads waitqueue early
  - be more precise about flag and function names
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 99cbdf55a8bd..f09c60393e55 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -29,12 +29,14 @@ extern struct irqaction chained_action;
  * IRQTF_WARNED    - warning "IRQ_WAKE_THREAD w/o thread_fn" has been printed
  * IRQTF_AFFINITY  - irq thread is requested to adjust affinity
  * IRQTF_FORCED_THREAD  - irq action is force threaded
+ * IRQTF_READY     - signals that irq thread is ready
  */
 enum {
 	IRQTF_RUNTHREAD,
 	IRQTF_WARNED,
 	IRQTF_AFFINITY,
 	IRQTF_FORCED_THREAD,
+	IRQTF_READY,
 };
 
 /*
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 939d21cd55c3..02f3b5bf5145 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -407,6 +407,7 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
 	mutex_init(&desc->request_mutex);
 	init_rcu_head(&desc->rcu);
+	init_waitqueue_head(&desc->wait_for_threads);
 
 	desc_set_defaults(irq, desc, node, affinity, owner);
 	irqd_set(&desc->irq_data, flags);
@@ -575,6 +576,7 @@ int __init early_irq_init(void)
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
 		mutex_init(&desc[i].request_mutex);
+		init_waitqueue_head(&desc->wait_for_threads);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
 	}
 	return arch_early_irq_init();
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f1d5a94c6c9f..4dca48506d38 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1263,6 +1263,31 @@ static void irq_wake_secondary(struct irq_desc *desc, struct irqaction *action)
 	raw_spin_unlock_irq(&desc->lock);
 }
 
+/*
+ * Internal function to notify that irq_thread is ready
+ */
+static void irq_thread_set_ready(struct irq_desc *desc,
+				 struct irqaction *action)
+{
+	set_bit(IRQTF_READY, &action->thread_flags);
+	wake_up(&desc->wait_for_threads);
+}
+
+/*
+ * Internal function to wake up irq_thread
+ * and wait until it is ready
+ */
+static void wake_up_and_wait_for_irq_thread_ready(struct irq_desc *desc,
+						  struct irqaction *action)
+{
+	if (!action || !action->thread)
+		return;
+
+	wake_up_process(action->thread);
+	wait_event(desc->wait_for_threads,
+		   test_bit(IRQTF_READY, &action->thread_flags));
+}
+
 /*
  * Interrupt handler thread
  */
@@ -1287,6 +1312,8 @@ static int irq_thread(void *data)
 
 	irq_thread_check_affinity(desc, action);
 
+	irq_thread_set_ready(desc, action);
+
 	while (!irq_wait_for_interrupt(action)) {
 		irqreturn_t action_ret;
 
@@ -1698,8 +1725,6 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	}
 
 	if (!shared) {
-		init_waitqueue_head(&desc->wait_for_threads);
-
 		/* Setup the type (level, edge polarity) if configured: */
 		if (new->flags & IRQF_TRIGGER_MASK) {
 			ret = __irq_set_trigger(desc,
@@ -1795,14 +1820,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 
 	irq_setup_timings(desc, new);
 
-	/*
-	 * Strictly no need to wake it up, but hung_task complains
-	 * when no hard interrupt wakes the thread up.
-	 */
-	if (new->thread)
-		wake_up_process(new->thread);
-	if (new->secondary)
-		wake_up_process(new->secondary->thread);
+	wake_up_and_wait_for_irq_thread_ready(desc, new);
+	wake_up_and_wait_for_irq_thread_ready(desc, new->secondary);
 
 	register_irq_proc(irq, desc);
 	new->dir = NULL;


