Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD57D530BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiEWICS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiEWICK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:02:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FB913F8B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:02:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653292924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=i4zfVgtUhZh9/+iQyGs2d3Sy2r4CkZY4YqWoCB++8kY=;
        b=vUvjksqprEKLrVPHEYFEezrxcLJD4Z3RsLY2JubE2FRNCdlB475iX8LcwCMfkPdTYlFgDM
        tq8M2k8tPNRR4qWiD6Bck3SKqSEInBaqPCQB9L1pN3Pd12w0cpImwRO+PXADPHyNuE/XDU
        YOm3yJFR1h4MPY4znOKAM92E9tDnbv0D/AWO3IH3Bnuj6KE3E9KZUh+ggoDcJbDf+YzZSd
        Mw5ik2nPKxRtSqVycoV6UpzN22mdv12Lc9FSxWle7ERAwpNgWvzoWdsEMxybKckqXlBD1x
        NaX19Ft88kQjQyDRo/JOJk4fCHtik14mbL9WghJiE6rB90oHsUipE2QVz1Pf1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653292924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=i4zfVgtUhZh9/+iQyGs2d3Sy2r4CkZY4YqWoCB++8kY=;
        b=QPzbhaWJvvaFk/2Bm75iY/CxZqfNomlP3dyVEdGRR4FCZEQbN/eAHF+3ELJTJ3XJv641A4
        nObFyYx24J9GagAg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/core for 5.19-rc1
Message-ID: <165329267741.3801280.534077656528571075.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 23 May 2022 10:02:03 +0200 (CEST)
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

please pull the latest core/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2022-0=
5-23

up to:  75d8cce128c5: lib/irq_poll: Prevent softirq pending leak in irq_poll_=
cpu_dead()


A single update for irqpoll:

  - Ensure that a raised soft interrupt is handled after pulling the
    blk_cpu_iopoll backlog from a unplugged CPU. This prevents that the CPU
    which runs that code reaches idle with soft interrupts pending.

Thanks,

	tglx

------------------>
Sebastian Andrzej Siewior (1):
      lib/irq_poll: Prevent softirq pending leak in irq_poll_cpu_dead()


 lib/irq_poll.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 2f17b488d58e..2d5329a42105 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -188,14 +188,18 @@ EXPORT_SYMBOL(irq_poll_init);
 static int irq_poll_cpu_dead(unsigned int cpu)
 {
 	/*
-	 * If a CPU goes away, splice its entries to the current CPU
-	 * and trigger a run of the softirq
+	 * If a CPU goes away, splice its entries to the current CPU and
+	 * set the POLL softirq bit. The local_bh_disable()/enable() pair
+	 * ensures that it is handled. Otherwise the current CPU could
+	 * reach idle with the POLL softirq pending.
 	 */
+	local_bh_disable();
 	local_irq_disable();
 	list_splice_init(&per_cpu(blk_cpu_iopoll, cpu),
 			 this_cpu_ptr(&blk_cpu_iopoll));
 	__raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);
 	local_irq_enable();
+	local_bh_enable();
=20
 	return 0;
 }

