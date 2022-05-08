Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3851ED52
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiEHMJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiEHMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:09:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4849BE0E6
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:05:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652011521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=z19/ZQYVVrDqcW92E2ztOXJo2nMDXqtDS16m7WC5vCg=;
        b=cCKdoxEaPXMEiJtHrc0lhDLjpUDzTMFriwLIZPmeaplwkuV1rBUGeg3k57BZMVBT+sZ+Pn
        zHP+KxUTPiuyi1+gBl+pJ8f9LS+A6WAZXYNzr4aSWluA4FMxw5xdzedx/NCM0Nyji7Lrwh
        WUNrooZ6+6B1OVKOdCYOmVdcneoFZ1fcZEbFk9aPzHaKPtn40S0cXws8hRJNbQkXoXnJ1t
        hK1v0xIFScGlKiXfaAmUWlfBDv0D7YF6VNuzzsuGANWVT1KjnwwxEJtZjnrTEfXny3Y+1T
        eF1jh6WgYoBq07uEMQWC3akHuR+fo7kj6g3vNU3XdHUfRg8asjgD4qUyZuimWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652011521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=z19/ZQYVVrDqcW92E2ztOXJo2nMDXqtDS16m7WC5vCg=;
        b=8AtpwVFinXxfp4uc2/WhQpbzgkyk37JY9Rr3D7QyTf77n8tFMXhyrXJuPP9fTq9J1VVNmD
        I+fRYRBME/tw0xBw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.18-rc6
References: <165201148069.536527.1960632033331546251.tglx@xen13>
Message-ID: <165201148219.536527.2201418994305067142.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  8 May 2022 14:05:21 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-=
05-08

up to:  8707898e22fd: genirq: Synchronize interrupt thread startup


A fix for the threaded interrupt core. A quick sequence of
request/free_irq() can result in a hang because the interrupt thread did
not reach the thread function and got stopped in the kthread core
already. That leaves a state active counter arround which makes a
invocation of synchronized_irq() on that interrupt hang forever. Ensure
that the thread reached the thread function in request_irq() to prevent
that.

Thanks,

	tglx

------------------>
Thomas Pfaff (1):
      genirq: Synchronize interrupt thread startup


 kernel/irq/internals.h |  2 ++
 kernel/irq/irqdesc.c   |  2 ++
 kernel/irq/manage.c    | 39 +++++++++++++++++++++++++++++----------
 3 files changed, 33 insertions(+), 10 deletions(-)

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
=20
 /*
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 939d21cd55c3..0099b87dd853 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -407,6 +407,7 @@ static struct irq_desc *alloc_desc(int irq, int node, uns=
igned int flags,
 	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
 	mutex_init(&desc->request_mutex);
 	init_rcu_head(&desc->rcu);
+	init_waitqueue_head(&desc->wait_for_threads);
=20
 	desc_set_defaults(irq, desc, node, affinity, owner);
 	irqd_set(&desc->irq_data, flags);
@@ -575,6 +576,7 @@ int __init early_irq_init(void)
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
 		mutex_init(&desc[i].request_mutex);
+		init_waitqueue_head(&desc[i].wait_for_threads);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
 	}
 	return arch_early_irq_init();
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c03f71d5ec10..e3e245a4fd70 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1248,6 +1248,31 @@ static void irq_wake_secondary(struct irq_desc *desc, =
struct irqaction *action)
 	raw_spin_unlock_irq(&desc->lock);
 }
=20
+/*
+ * Internal function to notify that a interrupt thread is ready.
+ */
+static void irq_thread_set_ready(struct irq_desc *desc,
+				 struct irqaction *action)
+{
+	set_bit(IRQTF_READY, &action->thread_flags);
+	wake_up(&desc->wait_for_threads);
+}
+
+/*
+ * Internal function to wake up a interrupt thread and wait until it is
+ * ready.
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
@@ -1259,6 +1284,8 @@ static int irq_thread(void *data)
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
 			struct irqaction *action);
=20
+	irq_thread_set_ready(desc, action);
+
 	sched_set_fifo(current);
=20
 	if (force_irqthreads() && test_bit(IRQTF_FORCED_THREAD,
@@ -1683,8 +1710,6 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, st=
ruct irqaction *new)
 	}
=20
 	if (!shared) {
-		init_waitqueue_head(&desc->wait_for_threads);
-
 		/* Setup the type (level, edge polarity) if configured: */
 		if (new->flags & IRQF_TRIGGER_MASK) {
 			ret =3D __irq_set_trigger(desc,
@@ -1780,14 +1805,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, s=
truct irqaction *new)
=20
 	irq_setup_timings(desc, new);
=20
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
=20
 	register_irq_proc(irq, desc);
 	new->dir =3D NULL;

