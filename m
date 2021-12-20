Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492B547AB07
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhLTOHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhLTOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:07:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8EFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:07:37 -0800 (PST)
Date:   Mon, 20 Dec 2021 14:07:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640009255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ychKao+p9nKXwbipSd/SDeE4GykghfvSjlJKR3vMCE=;
        b=GduzT7DoyY7lrLZ8U7LmZEYGIYX7myd5Ub6pL59GizVH1YucjpYMnrsneTSxsyWGwEfcPk
        A6v98HBH2EFxEmQeHhlC0kJIHkAShThHjntPFdvhjCIsABWvbhlP0Rq+YKL028M7GuH6jt
        08ilJfvgyV+U3qIc4FQoN6Bdqv4+HyNHbHOvxdksUvDol/pG5NKak67EPFBrAqeP+pbJM8
        xGpNCzqQPOJzLz7ftbzk6AcJp6yDkjFA0Jg3UbN//EY4/aDftB6a57GbZlyhS9juv8Gvw8
        ZjzA3HOlAv0Lc1RblkiaNCL1bXSgrGeclD3qotn/CtDn1UMtSFmjvTcIhan+GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640009255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ychKao+p9nKXwbipSd/SDeE4GykghfvSjlJKR3vMCE=;
        b=v3b2f/HcZ0f8zg6eKpyOM0OjJ+zKKE+CsoFWWpk2XGejKpEv/RptQOnRTUdAo5qFD3buYy
        manydn4NtTS05oDA==
From:   "irqchip-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/renesas-intc-irqpin: Use
 platform_get_irq_optional() to get the interrupt
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <164000925462.23020.15204746591968806815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     31bd548f40cd0b754ed80a372bc2019e7c4fa31d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/31bd548f40cd0b754ed80a372bc2019e7c4fa31d
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 16 Dec 2021 18:21:20 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 20 Dec 2021 12:21:50 

irqchip/renesas-intc-irqpin: Use platform_get_irq_optional() to get the interrupt

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_optional().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 drivers/irqchip/irq-renesas-intc-irqpin.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index cb7f60b..37f9a44 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -375,7 +375,6 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	struct intc_irqpin_priv *p;
 	struct intc_irqpin_iomem *i;
 	struct resource *io[INTC_IRQPIN_REG_NR];
-	struct resource *irq;
 	struct irq_chip *irq_chip;
 	void (*enable_fn)(struct irq_data *d);
 	void (*disable_fn)(struct irq_data *d);
@@ -418,12 +417,14 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 
 	/* allow any number of IRQs between 1 and INTC_IRQPIN_MAX */
 	for (k = 0; k < INTC_IRQPIN_MAX; k++) {
-		irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
-		if (!irq)
+		ret = platform_get_irq_optional(pdev, k);
+		if (ret == -ENXIO)
 			break;
+		if (ret < 0)
+			goto err0;
 
 		p->irq[k].p = p;
-		p->irq[k].requested_irq = irq->start;
+		p->irq[k].requested_irq = ret;
 	}
 
 	nirqs = k;
