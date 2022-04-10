Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB974FADF2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 14:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbiDJMvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 08:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiDJMvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 08:51:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5C563BD6;
        Sun, 10 Apr 2022 05:49:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649594977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lgNaYQOZDZrYXzopZbAPdhOPlBXFs/fNvReQ9xctjZk=;
        b=HOL3aJ+6jPVAgjwp2KAXHc8AewtgSbf/UBgjnuXMyhTyavjUhWPP2EjjQ7whqONUW9TeYR
        c8NS4rwPvOXlFdT9ab3zfE4m7HWhj8iEc7uhBOzSkLCu658ji/endviGmHULRZz0xwwHRj
        AILf19WdjVa/M3C7AQIRHiXVfj1Yv+dmBtVrDRJZ54TgjUJx0U+VaBDvidwX9k28YJWfgh
        8gp6rVehuOvMZuX7dxSLd322yxjCYxcIi+T/iCiHodwfUvJQXDdjbwDgAM6GRGLYuUDbuB
        bIMA9E0+eB1AO8pUNlj5Pb6XLDPLaYkdDZrlNaUSLKL4q+YrtrzEjwaTS1qSLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649594977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lgNaYQOZDZrYXzopZbAPdhOPlBXFs/fNvReQ9xctjZk=;
        b=txJVi4mQU4gdNFwZ/0mv52AODIpImaCKYYSbk7L3SUBW5SyRI+GfBizOeETt3PMI5UN/Qx
        TfYOabsLucfzc4BA==
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH V2] lib/irq_poll: Add local_bh_disable() in irq_poll_cpu_dead()
In-Reply-To: <87o819glbf.ffs@tglx>
References: <YgJ/XWVxxWDVBBVA@linutronix.de>
 <YgNzsnIE9bwQZ1Zg@infradead.org> <YgUGI9qAKUh4AOUY@linutronix.de>
 <YgYDePJLsVLXKqEP@infradead.org> <87o819glbf.ffs@tglx>
Date:   Sun, 10 Apr 2022 14:49:36 +0200
Message-ID: <87k0bxgl27.ffs@tglx>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

irq_poll_cpu_dead() pulls the blk_cpu_iopoll backlog from the dead CPU and
raises the POLL softirq with __raise_softirq_irqoff() on the CPU it is
running on. That just sets the bit in the pending softirq mask.

This means the handling of the softirq is delayed until the next interrupt
or a local_bh_disable/enable() pair. As a consequence the CPU on which this
code runs can reach idle with the POLL softirq pending, which triggers a
warning in the NOHZ idle code.

Add a local_bh_disable/enable() pair around the interrupts disabled section
in irq_poll_cpu_dead(). local_bh_enable will handle the pending softirq.

[tglx: Massaged changelog and comment]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Updated changelog and comment
---
 lib/irq_poll.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

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
 
 	return 0;
 }
