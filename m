Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC994FFF76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbiDMTlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiDMTky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:40:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0274E76E37;
        Wed, 13 Apr 2022 12:38:32 -0700 (PDT)
Date:   Wed, 13 Apr 2022 19:38:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649878710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aE3V7xveAicopZpC1DhUiXEdJ4iVrEwfbvOJY2vnCHM=;
        b=XEE/5JlewE5bE6U+pu2ycR2dFo62N/0Gi/xN08MCLljbtTAig6N0kLpc669XsJFctjUSxN
        /e/ydk32g4gFTzIXw+5yYGlJUyfN7bXZc7sZtEoYoKrQIBNrGLWkYeLPzVoB1l20hU10AQ
        6AGO2njhkMlZCVS4a1oBxraKPomLn5sKKsLr795HlmGoAeDSqXfGGmUsljvVSIumEATavP
        G966CUt/HZPyEdTQZDeQmcAFOSzaq1up0UtvqUC6YtYhw0RDKmRAoY7BrOZualqII3InMm
        zhJHWHrPo6fOJM7za6IzK1khf867uyXjZ7VZubXc0VXvi11H79iTaM2rjc9zjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649878710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aE3V7xveAicopZpC1DhUiXEdJ4iVrEwfbvOJY2vnCHM=;
        b=fCzbG7rhmnqek3JEGN2XJMZwvEtVoBzbL8mQRRZtJnSygMc53M6G5NEQWxpjxNbB+ctLZp
        793CNSCEA3yCmUCA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] lib/irq_poll: Prevent softirq pending leak in
 irq_poll_cpu_dead()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87k0bxgl27.ffs@tglx>
References: <87k0bxgl27.ffs@tglx>
MIME-Version: 1.0
Message-ID: <164987870919.4207.15384286786268525166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/core branch of tip:

Commit-ID:     75d8cce128c516fe6cf4b8683e8fe1a59e919902
Gitweb:        https://git.kernel.org/tip/75d8cce128c516fe6cf4b8683e8fe1a59e919902
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sun, 10 Apr 2022 14:49:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 Apr 2022 21:32:21 +02:00

lib/irq_poll: Prevent softirq pending leak in irq_poll_cpu_dead()

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
Link: https://lore.kernel.org/r/87k0bxgl27.ffs@tglx

---
 lib/irq_poll.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 2f17b48..2d5329a 100644
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
