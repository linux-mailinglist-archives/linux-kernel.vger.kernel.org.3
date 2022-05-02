Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E7517190
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383214AbiEBOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiEBOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:32:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C40E006;
        Mon,  2 May 2022 07:28:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651501737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rb63Ilz2a3MgquUItpmidx+dZok0Dnfpw8mB5HBqGls=;
        b=ckiN2f0IxLCVuw+Erz1V1znQt/IkZUGAdYMjorzGJc3Xxhe3eaFPfvKGhPiC4jle12NZZ9
        txy88OLMYijAX/KzrMUnI0ZgVgGRNlon9EXRQNtwT0aROPA0I75oTtMVRYX8zhktk7ku+y
        CKjtRg/hFWUJAw80zrniUVm63unPqJldrF2hWT9aZWDWVxRua+3gRMu9dS4/+URQIw7h8R
        Z9fXiMVCcqsEM42W/CvqaUKtTaQXLi5h5lTXHJTxyipnfsaFp7a0mxHR9mjBDwxu0BNbFX
        K0revuyX2z+P6A13rXvY7dyUcRDaoe8IKR0vZCWhgVIbGQ6l1/sk+ZOxlJiQdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651501737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rb63Ilz2a3MgquUItpmidx+dZok0Dnfpw8mB5HBqGls=;
        b=1ZYLX3rcmTiXjhAHt3j+QVZyYtcQa4TMvCLaAWKAAuqiP6DJgs0z8l78QGxi0OQ+72ehKh
        X5xeJeF8jcThhxCA==
To:     Thomas Pfaff <tpfaff@pcs.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] irq/core: synchronize irq_thread startup
In-Reply-To: <552fe7b4-9224-b183-bb87-a8f36d335690@pcs.com>
References: <552fe7b4-9224-b183-bb87-a8f36d335690@pcs.com>
Date:   Mon, 02 May 2022 16:28:56 +0200
Message-ID: <87mtg0m2jb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02 2022 at 13:28, Thomas Pfaff wrote:
> While running
> "while /bin/true; do setserial /dev/ttyS0 uart none;
> setserial /dev/ttyS0 uart 16550A; done"
> on a kernel with threaded irqs, setserial is hung after some calls.
>
> setserial opens the device, this will install an irq handler if the uart is
> not none, followed by TIOCGSERIAL and TIOCSSERIAL ioctls.
> Then the device is closed. On close, synchronize_irq() is called by
> serial_core.

This comment made me look deeper because I expected that free_irq()
would hang.

But free_irq() stopped issuing synchronize_irq() with commit
519cc8652b3a ("genirq: Synchronize only with single thread on
free_irq()"). And that turns out to be the root cause of the problem.
I should have caught that back then, but in hindsight ....

While the proposed patch works, I think the real solution is to ensure
that both the hardware interrupt _and_ the interrupt threads which are
associated to the removed action are in quiescent state. This should
catch the case you observed.

Something like the untested below.

Thanks,

        tglx
---
Subject: genirq: Quiesce interrupt threads in free_irq()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 02 May 2022 15:40:25 +0200

Fill void...

Fixes: 519cc8652b3a ("genirq: Synchronize only with single thread on free_irq()")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1914,6 +1914,22 @@ static struct irqaction *__free_irq(stru
 	 */
 	__synchronize_hardirq(desc, true);
 
+	/*
+	 * Wait for associated interrupt threads to complete. This cannot
+	 * use synchronize_irq() due to interrupt sharing in the PCIe
+	 * layer. See 519cc8652b3a ("genirq: Synchronize only with single
+	 * thread on free_irq()") for further explanation.
+	 */
+	if (action->thread) {
+		unsigned int thread_mask = action->thread_mask;
+
+		if (action->secondary)
+			thread_mask |= action->secondary->thread_mask;
+
+		wait_event(desc->wait_for_threads,
+			   !(atomic_read(&desc->threads_active) & thread_mask));
+	}
+
 #ifdef CONFIG_DEBUG_SHIRQ
 	/*
 	 * It's a shared IRQ -- the driver ought to be prepared for an IRQ
@@ -1931,10 +1947,11 @@ static struct irqaction *__free_irq(stru
 #endif
 
 	/*
-	 * The action has already been removed above, but the thread writes
-	 * its oneshot mask bit when it completes. Though request_mutex is
-	 * held across this which prevents __setup_irq() from handing out
-	 * the same bit to a newly requested action.
+	 * The action has already been removed above and both the hardware
+	 * interrupt and the associated threads have been synchronized,
+	 * which means they are in quiescent state. request_mutex is still
+	 * held which prevents __setup_irq() from handing out action's
+	 * thread_mask to a newly requested action.
 	 */
 	if (action->thread) {
 		kthread_stop(action->thread);

