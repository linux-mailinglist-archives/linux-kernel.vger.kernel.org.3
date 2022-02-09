Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923C34AF663
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiBIQSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbiBIQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:18:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B20C05CB88
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:17:59 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:17:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423478;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=stjew1c1sUObQqsDAEroSIu/WUuiCdQqbTu43dIG2Ow=;
        b=ie65Lss64vBqGu3FZ76xd2YC2Kp4CRv7QeF850X0aIBDfUZyPGcW3+E7I6y3aVU4qdKjF1
        4DlH6/WlDCYpAuNoBK9sqbYj5H5ZNh6gWlelOIKgIqvvzl3U513uuqTc9D2EF2KbdmHwOC
        V20wDex5etPRxnn9VdZuAJGpByP1B2JCbMMNYZKJfDbqZ2sEMX3gfvGloJGNNOUdfUtyqb
        UkDF9cIVQoWg72g1AhAvBxT8VRCVPeGXqVoAd9l4xRN0yJQQp22VNof3hWNqJHIV2eqJiU
        hj72UMJzGvkd3dFOQOJySzIIpC1S7T3O0rBIGFLSrknrVp/2gWw7NUo7PRkMuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423478;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=stjew1c1sUObQqsDAEroSIu/WUuiCdQqbTu43dIG2Ow=;
        b=iAJ411k06+X1mkAs8vtSqCIALn9KYNrf/IHA2cyOk8DlGSR0rC6j/JpbljwSXjrgmYLFGc
        NPkzOViFIJWGQIBg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/imx-intmux: Move PM device over
 to irq domain
Cc:     Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        tglx@linutronix.de
In-Reply-To: <20220201120310.878267-6-maz@kernel.org>
References: <20220201120310.878267-6-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164442347752.16921.16997392029622093003.tip-bot2@tip-bot2>
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

Commit-ID:     fb140b9c0fe1109ac2269443216d114751a030c0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fb140b9c0fe1109ac2269443216d114751a030c0
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:03:03 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:36:53 

irqchip/imx-intmux: Move PM device over to irq domain

Move the reference to the device over to the irq domain.
This allows the irq_chip structure to be directly used instead
of taking a copy for each instance.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Link: https://lore.kernel.org/r/20220201120310.878267-6-maz@kernel.org
---
 drivers/irqchip/irq-imx-intmux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index e86ff74..80aaea8 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -61,7 +61,6 @@
 #define CHAN_MAX_NUM		0x8
 
 struct intmux_irqchip_data {
-	struct irq_chip		chip;
 	u32			saved_reg;
 	int			chanidx;
 	int			irq;
@@ -114,7 +113,7 @@ static void imx_intmux_irq_unmask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
-static struct irq_chip imx_intmux_irq_chip = {
+static struct irq_chip imx_intmux_irq_chip __ro_after_init = {
 	.name		= "intmux",
 	.irq_mask	= imx_intmux_irq_mask,
 	.irq_unmask	= imx_intmux_irq_unmask,
@@ -126,7 +125,7 @@ static int imx_intmux_irq_map(struct irq_domain *h, unsigned int irq,
 	struct intmux_irqchip_data *data = h->host_data;
 
 	irq_set_chip_data(irq, data);
-	irq_set_chip_and_handler(irq, &data->chip, handle_level_irq);
+	irq_set_chip_and_handler(irq, &imx_intmux_irq_chip, handle_level_irq);
 
 	return 0;
 }
@@ -241,8 +240,6 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < channum; i++) {
-		data->irqchip_data[i].chip = imx_intmux_irq_chip;
-		data->irqchip_data[i].chip.parent_device = &pdev->dev;
 		data->irqchip_data[i].chanidx = i;
 
 		data->irqchip_data[i].irq = irq_of_parse_and_map(np, i);
@@ -260,6 +257,7 @@ static int imx_intmux_probe(struct platform_device *pdev)
 			goto out;
 		}
 		data->irqchip_data[i].domain = domain;
+		irq_domain_set_pm_device(domain, &pdev->dev);
 
 		/* disable all interrupt sources of this channel firstly */
 		writel_relaxed(0, data->regs + CHANIER(i));
