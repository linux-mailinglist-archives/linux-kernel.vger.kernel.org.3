Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E9B47AB08
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhLTOHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:07:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhLTOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:07:37 -0500
Date:   Mon, 20 Dec 2021 14:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640009256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WsyqyxB5lcS5H20DgZdExqUu5Cc9nIuhzFAFq+Dk5tk=;
        b=bvVuK9oFeo9kDQ/A3921E2MBczUYuLr809iwK8pK8zTfhsrPa26EU3dby1aOTbgKq7pPBF
        SPhWxhGV2TEPooKrhYGRhh8dyEkGRaD3PZrp2xAq69fzXtdd95JDc4gZfcb72xYIQtYIe8
        VtG3QO5UWVHAwWpu2Ik4WNENc7s2ZwWJlCs0HOoVQM++pNNB2T+tEL4/Jgc01TGahSogJR
        ShbDzxJ765ZY+7q8czGyiaV16QWBOGyrqdn3hw0cPHP/4y3L3GpB55Ei6MjXBcAstW5YCX
        t7SswsKXsOxzOX8uAVU+SZMQUFTEYPhasmZnd+DpoSrsoKGbLjOyzG0Za50lkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640009256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WsyqyxB5lcS5H20DgZdExqUu5Cc9nIuhzFAFq+Dk5tk=;
        b=wng+ojABF6N9Ks/ghN+W0HfSVaf8sq5ogh708lfKKQoRGN1Fc7omkDnL/PKUyT5VQ0aHTq
        6KSEarBP9t7+o2AQ==
From:   "irqchip-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/renesas-irqc: Use
 platform_get_irq_optional() to get the interrupt
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211216182121.5323-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211216182121.5323-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <164000925542.23020.16758782166921040706.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     befbfe6f8f744acb65c4334cc224b855d31aff1b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/befbfe6f8f744acb65c4334cc224b855d31aff1b
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 16 Dec 2021 18:21:21 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 20 Dec 2021 12:18:46 

irqchip/renesas-irqc: Use platform_get_irq_optional() to get the interrupt

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
Link: https://lore.kernel.org/r/20211216182121.5323-2-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 drivers/irqchip/irq-renesas-irqc.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 07a6d8b..909325f 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -126,7 +126,6 @@ static int irqc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const char *name = dev_name(dev);
 	struct irqc_priv *p;
-	struct resource *irq;
 	int ret;
 	int k;
 
@@ -142,13 +141,15 @@ static int irqc_probe(struct platform_device *pdev)
 
 	/* allow any number of IRQs between 1 and IRQC_IRQ_MAX */
 	for (k = 0; k < IRQC_IRQ_MAX; k++) {
-		irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
-		if (!irq)
+		ret = platform_get_irq_optional(pdev, k);
+		if (ret == -ENXIO)
 			break;
+		if (ret < 0)
+			goto err_runtime_pm_disable;
 
 		p->irq[k].p = p;
 		p->irq[k].hw_irq = k;
-		p->irq[k].requested_irq = irq->start;
+		p->irq[k].requested_irq = ret;
 	}
 
 	p->number_of_irqs = k;
