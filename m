Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CD8569D56
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiGGISW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbiGGIRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:17:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250374D166
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:15:56 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:15:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657181754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5oGUO4fN/BKlwUyPfl+2zvy6oRh+E22TA0yGkEl73d8=;
        b=ALwBBZDLfm+rBF9z0/SN/LocTLJkeFV4/p/yYb3QwOcsiPgiDpYNIVzGfBjfA6rexPfpPW
        G+T90wGHDDl03KoVjmMQD5q7ba+si97JZcI8+vNYVEL9r+xq9q+Z9rhnOY0pv2b+YJTmHp
        K5YfF4PpyP9MdzLAtW6Lfl21ra/JiY0+mbSSWHK5a2KqZ1cQNPuvK7cwOibkB+RQxklZ/R
        /YS+3mMN71fq9tv+k4Le56bPTMqvn4H9WienIE5SVOakKrNWvEoDLsMjD7jYMXIlDklZzM
        mdPjbwWpw3PcI/E7oLWV/05FybWdAtUNnAclvWYMR3WTma/927eA0AJ7ciOdhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657181754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5oGUO4fN/BKlwUyPfl+2zvy6oRh+E22TA0yGkEl73d8=;
        b=7XYON2K2VmjH9+5DsE3CmcHqOzWf25rz69SIgxLQ9IxAhpfZRb3/EaRkzbpSCh52ujISK1
        SkoUL2NZ5cA3MQBQ==
From:   "irqchip-bot for Loic Pallardy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/stm32-exti: Fix
 irq_mask/irq_unmask for direct events
Cc:     Loic Pallardy <loic.pallardy@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220606162757.415354-3-antonio.borneo@foss.st.com>
References: <20220606162757.415354-3-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Message-ID: <165718175310.15455.3631192223036311523.tip-bot2@tip-bot2>
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

Commit-ID:     f8b3eb4245113c8a9156d5db8e80c6134127bcc1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f8b3eb4245113c8a9156d5db8e80c6134127bcc1
Author:        Loic Pallardy <loic.pallardy@foss.st.com>
AuthorDate:    Mon, 06 Jun 2022 18:27:53 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:07:44 +01:00

irqchip/stm32-exti: Fix irq_mask/irq_unmask for direct events

The driver has to mask/unmask the corresponding flag in the
Interrupt Mask Register (IMR).
This is already done for configurable event, while direct events
only forward the mask/unmask request to the parent.

Use the existing stm32_exti_h_mask()/stm32_exti_h_unmask() for
direct events too.

Signed-off-by: Loic Pallardy <loic.pallardy@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220606162757.415354-3-antonio.borneo@foss.st.com
---
 drivers/irqchip/irq-stm32-exti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 10c9c74..1145f06 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -691,8 +691,8 @@ static struct irq_chip stm32_exti_h_chip_direct = {
 	.name			= "stm32-exti-h-direct",
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_ack		= irq_chip_ack_parent,
-	.irq_mask		= irq_chip_mask_parent,
-	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_mask		= stm32_exti_h_mask,
+	.irq_unmask		= stm32_exti_h_unmask,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= irq_chip_set_type_parent,
 	.irq_set_wake		= stm32_exti_h_set_wake,
