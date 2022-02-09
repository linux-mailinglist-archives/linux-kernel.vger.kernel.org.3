Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B324AF65D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiBIQSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbiBIQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:18:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28774C05CB89
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:18:00 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:17:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423479;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypww1JCXZxV4juqQanEBvrbVLYhupf/9bMzDU8WWl/c=;
        b=eoBUZAIF28uC6Ao9Q/h3stNxt6O8Z59Bpz3n+XC30Knb+0l2EHMfXEQv5wv9MZDI7qPbL6
        pw6x36qbC+pZ2th73n8UEcLTQjO3RjN11meEQY+n3XB43JC/YpgTT7CJpLl5SxWji409wn
        g2gPI0pFZmzjMx173mwckFmpUHFPu4+argW1Qm4fmcEbXSfhKT/XtPeExPuv1lOi0x39B/
        wKleRbM+NDVbZR6bxJvRQqqwjvcHiNK+c8ojSnXUr89r3Yu74+AkJeGsBKZl6FrvtdVfZF
        GNYpS6Dm3A8m6GQS9u2E54+SU5WNQ5sUEoHD3Ouojh8Mr2ye2c1Riwtw+BHqxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423479;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypww1JCXZxV4juqQanEBvrbVLYhupf/9bMzDU8WWl/c=;
        b=wGzLMJY3S4rvM7wDY9IMCRNgiBAnINwESYfcefFAZJ0Lqop/mdwPhh4iAJiDyZXXPpQLi4
        1/XZtyLjjiXR5jBg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/renesas-irqc: Move PM device over
 to irq domain
Cc:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>, tglx@linutronix.de
In-Reply-To: <20220201120310.878267-5-maz@kernel.org>
References: <20220201120310.878267-5-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164442347847.16921.17634566936062737702.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c3ec838e3a390e62cb71a11041db43d0b3b42c99
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c3ec838e3a390e62cb71a11041db43d0b3b42c99
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:03:02 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:36:53 

irqchip/renesas-irqc: Move PM device over to irq domain

Move the reference to the device over to the irq domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Link: https://lore.kernel.org/r/20220201120310.878267-5-maz@kernel.org
---
 drivers/irqchip/irq-renesas-irqc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 909325f..1ee5e99 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -188,13 +188,14 @@ static int irqc_probe(struct platform_device *pdev)
 	p->gc->reg_base = p->cpu_int_base;
 	p->gc->chip_types[0].regs.enable = IRQC_EN_SET;
 	p->gc->chip_types[0].regs.disable = IRQC_EN_STS;
-	p->gc->chip_types[0].chip.parent_device = dev;
 	p->gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
 	p->gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
 	p->gc->chip_types[0].chip.irq_set_type	= irqc_irq_set_type;
 	p->gc->chip_types[0].chip.irq_set_wake	= irqc_irq_set_wake;
 	p->gc->chip_types[0].chip.flags	= IRQCHIP_MASK_ON_SUSPEND;
 
+	irq_domain_set_pm_device(p->irq_domain, dev);
+
 	/* request interrupts one by one */
 	for (k = 0; k < p->number_of_irqs; k++) {
 		if (devm_request_irq(dev, p->irq[k].requested_irq,
