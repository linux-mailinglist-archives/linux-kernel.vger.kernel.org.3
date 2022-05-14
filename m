Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8F45272C0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiENP4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiENP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:56:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771E4192AB;
        Sat, 14 May 2022 08:56:24 -0700 (PDT)
Date:   Sat, 14 May 2022 15:56:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652543783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xND6KmN6BSQNF8fpie/dnjka5fx8M/s5vRbisDyIKtY=;
        b=x/jBuCeMUokrtjGmLSg52fkW1+3AFLUb0fQagp1RtxpyeqkcLytObN4DEeGPat6XlRnuLa
        aaGvUhMtz1Z5KsMeLGfrVC+h6IUp1MrpldQDFrAg5h+9okPN/FPcwnTtybabgPjOhGrM/e
        Hau2kOrYCRVGcc1Nm3Ungetns4pnJRpsyfE2i/elZngdzAKOnM1bFGMIx8ce4j1/WkRpOp
        c8r9chyGowhW5S5SlFA5dACKJCa3+87JN/xSybKpRfrVeTaemfUeEku2tnFRx78W7Dl70S
        g8/rHb4PynxODIhTa4l7OUSG+PrKo2xaxqJ3WCveqBRQ0eMZ0fMYrX8WNV9hcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652543783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xND6KmN6BSQNF8fpie/dnjka5fx8M/s5vRbisDyIKtY=;
        b=KJT4gwNpmwx3CXAGgvUcld4bpQeahxULUx6nW/TSQaTnjWdqqxUcXJKwwQtf/U40UnjR2v
        lI7Zd8VcZU/LrVCA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irq_sim: Make the irq_work always run in hard
 irq context
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <YnuZBoEVMGwKkLm+@linutronix.de>
References: <YnuZBoEVMGwKkLm+@linutronix.de>
MIME-Version: 1.0
Message-ID: <165254378168.4207.12107565451886363340.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     21673fcb2532dcd189905ff5a5389eb7dcd0e57a
Gitweb:        https://git.kernel.org/tip/21673fcb2532dcd189905ff5a5389eb7dcd0e57a
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 11 May 2022 13:07:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 14 May 2022 17:48:27 +02:00

genirq/irq_sim: Make the irq_work always run in hard irq context

The IRQ simulator uses irq_work to trigger an interrupt. Without the
IRQ_WORK_HARD_IRQ flag the irq_work will be performed in thread context
on PREEMPT_RT. This causes locking errors later in handle_simple_irq()
which expects to be invoked with disabled interrupts.

Triggering individual interrupts in hardirq context should not lead to
unexpected high latencies since this is also what the hardware
controller does. Also it is used as a simulator so...

Use IRQ_WORK_INIT_HARD() to carry out the irq_work in hardirq context on
PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/YnuZBoEVMGwKkLm+@linutronix.de
---
 kernel/irq/irq_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 0cd02ef..dd76323 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -181,7 +181,7 @@ struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 		goto err_free_bitmap;
 
 	work_ctx->irq_count = num_irqs;
-	init_irq_work(&work_ctx->work, irq_sim_handle_irq);
+	work_ctx->work = IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
 
 	return work_ctx->domain;
 
