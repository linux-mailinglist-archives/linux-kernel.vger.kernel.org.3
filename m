Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4AD4C765F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbiB1SD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbiB1RxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:53:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5BCAA2C0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:40:44 -0800 (PST)
Date:   Mon, 28 Feb 2022 17:40:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646070039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01kkECkLBdLpXhA0pZjXjbhMW1oUQ+BkgGkDZR5N+a8=;
        b=Tx4Mx0t8IRibpFqaPGjq2/6EvYEe8BQjeU1qknraDT91JaYBZUswNee76XQyXwRKxFQEdA
        dClKPGs5gmzkqUitR49Vg1b0Rup1254k9OpsRfPkX503ZxRpbkWdB/ATbohLk2sX6Nhf7P
        rvXJR4bmTQoCsaF3eDaRGnV+m8xoRTRm9dbP2jd289OVsyyDmMHsaHVzTHIHB1sU2Go8Hf
        Wt7Ze38Ripn4uoHODdAP8jmOHR7uVa5/mLUzBjnfTX+4Ai3VxLkTDUmYN8jtU+2nUErzxP
        bW6E+xJOMi/IbuvpD/cHmqA0RmtBkP4btWHplo6cXjdQsqzTtRbwwhFr42OOwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646070039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01kkECkLBdLpXhA0pZjXjbhMW1oUQ+BkgGkDZR5N+a8=;
        b=1UfS2ahIRyEyuzZqZZ9quK1m6YURjoo5yhv7I8GGaHH5ryzEfh5dbyvpkRvajapvVNxR9W
        Hsd1L0hpuSOhiRAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/qcom-pdc: Drop open coded version
 of __assign_bit()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220224101226.88373-6-maz@kernel.org>
References: <20220224101226.88373-6-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164607003826.16921.7381437841996310939.tip-bot2@tip-bot2>
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

Commit-ID:     024e9a021eb7baff3935d8c76fc2d668384398f7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/024e9a021eb7baff3935d8c76fc2d668384398f7
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 24 Feb 2022 10:12:26 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 28 Feb 2022 17:32:26 

irqchip/qcom-pdc: Drop open coded version of __assign_bit()

The driver uses what looks like an open-coded version of __assign_bit().
Replace it with the real thing.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220224101226.88373-6-maz@kernel.org
---
 drivers/irqchip/qcom-pdc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 0cd20dd..d96916c 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -23,9 +23,6 @@
 
 #define PDC_MAX_GPIO_IRQS	256
 
-#define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
-#define ENABLE_INTR(reg, intr)	(reg | (1 << intr))
-
 #define IRQ_ENABLE_BANK		0x10
 #define IRQ_i_CFG		0x110
 
@@ -55,16 +52,16 @@ static u32 pdc_reg_read(int reg, u32 i)
 static void pdc_enable_intr(struct irq_data *d, bool on)
 {
 	int pin_out = d->hwirq;
+	unsigned long enable;
 	unsigned long flags;
 	u32 index, mask;
-	u32 enable;
 
 	index = pin_out / 32;
 	mask = pin_out % 32;
 
 	raw_spin_lock_irqsave(&pdc_lock, flags);
 	enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
-	enable = on ? ENABLE_INTR(enable, mask) : CLEAR_INTR(enable, mask);
+	__assign_bit(mask, &enable, on);
 	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
 	raw_spin_unlock_irqrestore(&pdc_lock, flags);
 }
