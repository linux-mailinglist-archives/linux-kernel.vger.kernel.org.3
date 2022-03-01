Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE84C8905
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiCAKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiCAKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:12:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73EE8C7F7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:11:37 -0800 (PST)
Date:   Tue, 01 Mar 2022 10:11:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646129496;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=viDGU1V+NCYQEs/J6h2xYIQ6pMzZFsZhU6z77bVZY8A=;
        b=SQPVBr5VROgEYxqicrJqcJI6gnIwUU76AeB0OiLmNHpu1FyqfG38VQgPhR1XNZ7V0FcMiq
        yYzsSYFmghi8JPRsv/RTtAkKp+ItAdFE+9r2NoplAaj0LeTG3rQPEp60rJSbH7qveegw/l
        AWxLUCdNH0xarrjBR6UIyJnAky6xiwTLQaPq6bG5oMRlrtyA4z/AmpeDnicsdh9okBiSF9
        GAyzrT4VOpf7KhEKxo/PFmQ2jHG10hshpVaYSGFPle60verhDpeS4uCfKuYGV4Jf8Mw+Ck
        yAA6QYliNSN+cPYE7SzPxkq9Mw0i0pooCIH2IbhAU1VOCJe7Ys3w1Op8kPi0+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646129496;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=viDGU1V+NCYQEs/J6h2xYIQ6pMzZFsZhU6z77bVZY8A=;
        b=I3+JnnHk7cEVAjwXjXHEy+vxpQ87Bz4amzDPp2ceIwqYOoWjwzzw0it/ZhOhIqLxWgMWt4
        u1KGFwcPuUFVrdAw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/qcom-pdc: Fix broken locking
Cc:     Marc Zyngier <maz@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>, tglx@linutronix.de
In-Reply-To: <20220224101226.88373-5-maz@kernel.org>
References: <20220224101226.88373-5-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164612949497.16921.9385966108566005090.tip-bot2@tip-bot2>
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

Commit-ID:     a6aca2f460e203781dc41391913cc5b54f4bc0ce
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a6aca2f460e203781dc41391913cc5b54f4bc0ce
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 24 Feb 2022 10:12:25 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 01 Mar 2022 10:06:25 

irqchip/qcom-pdc: Fix broken locking

pdc_enable_intr() serves as a primitive to qcom_pdc_gic_{en,dis}able,
and has a raw spinlock for mutual exclusion, which is uses with
interruptible primitives.

This means that this critical section can itself be interrupted.
Should the interrupt also be a PDC interrupt, and the endpoint driver
perform an irq_disable() on that interrupt, we end-up in a deadlock.

Fix this by using the irqsave/irqrestore variants of the locking
primitives.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
Link: https://lore.kernel.org/r/20220224101226.88373-5-maz@kernel.org
---
 drivers/irqchip/qcom-pdc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 837ca69..0cd20dd 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -55,17 +55,18 @@ static u32 pdc_reg_read(int reg, u32 i)
 static void pdc_enable_intr(struct irq_data *d, bool on)
 {
 	int pin_out = d->hwirq;
+	unsigned long flags;
 	u32 index, mask;
 	u32 enable;
 
 	index = pin_out / 32;
 	mask = pin_out % 32;
 
-	raw_spin_lock(&pdc_lock);
+	raw_spin_lock_irqsave(&pdc_lock, flags);
 	enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
 	enable = on ? ENABLE_INTR(enable, mask) : CLEAR_INTR(enable, mask);
 	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
-	raw_spin_unlock(&pdc_lock);
+	raw_spin_unlock_irqrestore(&pdc_lock, flags);
 }
 
 static void qcom_pdc_gic_disable(struct irq_data *d)
