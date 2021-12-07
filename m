Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84646BAE7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhLGMVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:21:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52548 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhLGMVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:21:18 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638879467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXn9q125PhKeaNsrKM96Vvecn9O3By1+ffaZQAaWR5U=;
        b=O7U/Hlj10+uk434Dg5JyC30q3cJPiufzZVMkdyNZHN5GjicX5Q0zpyEKHaVB22MslZhowc
        iha7Wjfj+fhuvWal5kqC3N0dCSGwc0nwgwcrYoeaPPL4UgaxNzS1KNeOe05wm95jBBA3aB
        3ihFiZ1nPlSu0E8gk0ATI1vh0Z7S8MtbxuHRbtm/+PyqyLMXAE0MtFIEMAk//eQyOMkVCw
        Gvv/ZqhCv2csrp8mO4QEtNlDxiGfDhJ1ZEr3+7WXqr5Qse9iAmSy1yLOfmxFx3Zfat4kBt
        7ewG1sf0tZRSECN2Ji+nrMYrIhQepPScIuP1qIlGg+NYAXnB3dmlIpCaYjzgNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638879467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXn9q125PhKeaNsrKM96Vvecn9O3By1+ffaZQAaWR5U=;
        b=MqTJBDO9Qxmo5Kj1R9zHiNdm4IJKBtNytivV6qaeWbUhRMXJkdPRhXuHznEMcKKKZcq5xi
        cLdSBBpMZVhDuzBA==
To:     linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/5] irq: Remove unsued flags argument from __handle_irq_event_percpu().
Date:   Tue,  7 Dec 2021 13:17:34 +0100
Message-Id: <20211207121737.2347312-3-bigeasy@linutronix.de>
In-Reply-To: <20211207121737.2347312-1-bigeasy@linutronix.de>
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __IRQF_TIMER bit from the flags argument was used in
add_interrupt_randomness() to distinguish the timer interrupt from other
interrupts. This is no longer the case.

Remove the flags argument from __handle_irq_event_percpu().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/irq/chip.c      | 4 +---
 kernel/irq/handle.c    | 9 ++-------
 kernel/irq/internals.h | 2 +-
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index f895265d75487..c093246630882 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -575,8 +575,6 @@ EXPORT_SYMBOL_GPL(handle_simple_irq);
  */
 void handle_untracked_irq(struct irq_desc *desc)
 {
-	unsigned int flags =3D 0;
-
 	raw_spin_lock(&desc->lock);
=20
 	if (!irq_may_run(desc))
@@ -593,7 +591,7 @@ void handle_untracked_irq(struct irq_desc *desc)
 	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	raw_spin_unlock(&desc->lock);
=20
-	__handle_irq_event_percpu(desc, &flags);
+	__handle_irq_event_percpu(desc);
=20
 	raw_spin_lock(&desc->lock);
 	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 68c76c3caaf55..9489f93b3db34 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -136,7 +136,7 @@ void __irq_wake_thread(struct irq_desc *desc, struct ir=
qaction *action)
 	wake_up_process(action->thread);
 }
=20
-irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int =
*flags)
+irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 {
 	irqreturn_t retval =3D IRQ_NONE;
 	unsigned int irq =3D desc->irq_data.irq;
@@ -174,10 +174,6 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc =
*desc, unsigned int *flags
 			}
=20
 			__irq_wake_thread(desc, action);
-
-			fallthrough;	/* to add to randomness */
-		case IRQ_HANDLED:
-			*flags |=3D action->flags;
 			break;
=20
 		default:
@@ -193,9 +189,8 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *=
desc, unsigned int *flags
 irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
 {
 	irqreturn_t retval;
-	unsigned int flags =3D 0;
=20
-	retval =3D __handle_irq_event_percpu(desc, &flags);
+	retval =3D __handle_irq_event_percpu(desc);
=20
 	add_interrupt_randomness(desc->irq_data.irq);
=20
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 54363527feea4..99cbdf55a8bda 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -103,7 +103,7 @@ extern int __irq_get_irqchip_state(struct irq_data *dat=
a,
=20
 extern void init_kstat_irqs(struct irq_desc *desc, int node, int nr);
=20
-irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int =
*flags);
+irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event(struct irq_desc *desc);
=20
--=20
2.34.1

