Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE70C4ADEB4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358382AbiBHQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383579AbiBHQyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:54:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE8AC06157A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:54:12 -0800 (PST)
Date:   Tue, 8 Feb 2022 17:54:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644339248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UJc2SLX2D6cRz5yA+A7/ElHCSYMhyOPrKrsCsu+plHY=;
        b=yJNHilKZDIl/sA8KqcUcvrv6bmZJwcKo5c3WBrBHkg4yy2D6EbjS/HW2BYWHxJnV6dvcJs
        HotG5id8C5DsWh0XfCTdKqqXnprP1AMCrfxT20xNgY7wMyVOd3jcZc9n4kU4sx7p9af1wr
        d5QbBxmjGJUJi7Dr0ga8InDR0Owy8en08Bbg+Ps6lHzTRN4eKHrsL/aPXPbMqOI/lpvNIY
        7lem6X/Cd6RXwK0Tmk/pqesQFXzo1QMIKHd9skNn7IcFIhGH9ZHCYnI1DmIZm7KSuGycDj
        I+iddXDV53GYxt/QGEQ9ao8q6AvkFbNOjMxkaIvoEzo4xDAG8oVTKnGHnIgdPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644339248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UJc2SLX2D6cRz5yA+A7/ElHCSYMhyOPrKrsCsu+plHY=;
        b=VauLg6cq6mtx3tHkndb3LOofU2dcyCNoLiKkKXrqpPBuotV0wQkPU5F0b/CmwBFVdIO8J5
        yRtT1fjpLsDFGkBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3] smp: Wake ksoftirqd on PREEMPT_RT instead do_softirq().
Message-ID: <YgKgL6aPj8aBES6G@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The softirq implementation on PREEMPT_RT does not provide do_softirq(). The
softirq can not be handled directly here because migration_cpu_stop() is
invoked with disabled preemption/ interrupts.

A known user of scheduling softirqs from a remote function call is the block
layer. It won't happen on PREEMPT_RT because it doesn't make sense for
latency/ performance reasons and is disabled. Nevertheless this should
be handled in case of a new user pops up rather than simply ignoring it.

Waking ksoftirqd unconditionally can be problematic if softirqs were already
pending but not yet handled. This can happen since the migration thread
is running at a high priority and able to preempt a threaded-interrupt.
The woken-up ksoftirqd would catch-up all pending (and later raised)
softirqs which is not desired on PREEMPT_RT since it is no longer
handled where it has been originally raised. This in turn delays the
actual processing until a SCHED_OTHER task can run.

Wake the softirq thread on PREEMPT_RT if a remote function call raised
softirqs. Add warning in this case since this condition is not desired.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2=E2=80=A6v3:
   - Only wake ksoftirqd if the softirqs were raised wthin
     flush_smp_call_function_queue().
   - Add a warning in the wake case.
v1=E2=80=A6v2: Drop an empty line.

 kernel/smp.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)
---
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -691,10 +691,25 @@ void flush_smp_call_function_from_idle(v
 	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
 		      smp_processor_id(), CFD_SEQ_IDLE);
 	local_irq_save(flags);
-	flush_smp_call_function_queue(true);
-	if (local_softirq_pending())
-		do_softirq();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		flush_smp_call_function_queue(true);
+		if (local_softirq_pending())
+			do_softirq();
+	} else {
+		unsigned int pending_prev;
+		unsigned int pending_post;
=20
+		pending_prev =3D local_softirq_pending();
+		flush_smp_call_function_queue(true);
+		pending_post =3D local_softirq_pending();
+
+		if (WARN_ON_ONCE(!pending_prev && pending_post)) {
+			struct task_struct *ksoftirqd =3D this_cpu_ksoftirqd();
+
+			if (ksoftirqd && !task_is_running(ksoftirqd))
+				wake_up_process(ksoftirqd);
+		}
+	}
 	local_irq_restore(flags);
 }
=20
