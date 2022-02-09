Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415A94AF655
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiBIQSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbiBIQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:18:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D388EC05CB8F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:18:01 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:17:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riI5VstS4kmxsTMIf3D27orHCGPuBVog3ko/c1Ew9bU=;
        b=x4y3baFHt6Ib2FDn3iCbqFlxwvlt2RjhlAUC1SCjrjBRRbQcLtp7IWAhqyYJ1wubhJ8CP6
        8o5nMYdpGKtIp8IAiVFJOujX0gY5gIeGfQrUGe1tsX+NJy2Qjpnzxk+PyZBW4xtqbp1LBH
        8BeEkhRyTWS8f4HiUfaDr2kT96uMacj3wyhC0QH826EvPV6IYEzf4Bj1oHA1cJ2SyJusP+
        dwO4Rgut2iw+x75Ek6zFAo+DmKdDaampt1A9tFG1jFaDGS/Q4jkGKAV+JXmmb6FuUJj/1d
        4B3e0dO7C14w6Hy+BOkWkbdM0Ezm/ji1BgyChzpS9ywrp9y77zAqsHURc5lb4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riI5VstS4kmxsTMIf3D27orHCGPuBVog3ko/c1Ew9bU=;
        b=D0KvUoqdlDt1YLTbjX4oUsw6R1Hag8fUct49L7YwmRcAtp65ScA5ui4kDQ7sBekfHXWM1J
        TKsUuSUVY08NRiDw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/renesas-intc-irqpin: Move PM
 device over to irq domain
Cc:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>, tglx@linutronix.de
In-Reply-To: <20220201120310.878267-4-maz@kernel.org>
References: <20220201120310.878267-4-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164442347952.16921.14052233432761090248.tip-bot2@tip-bot2>
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

Commit-ID:     c2ea6b9b03c1acde89c6100aff894e64386e72cc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c2ea6b9b03c1acde89c6100aff894e64386e72cc
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:03:01 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:36:44 

irqchip/renesas-intc-irqpin: Move PM device over to irq domain

Move the reference to the device over to the irq domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Link: https://lore.kernel.org/r/20220201120310.878267-4-maz@kernel.org
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 37f9a44..e83756a 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -508,7 +508,6 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 
 	irq_chip = &p->irq_chip;
 	irq_chip->name = "intc-irqpin";
-	irq_chip->parent_device = dev;
 	irq_chip->irq_mask = disable_fn;
 	irq_chip->irq_unmask = enable_fn;
 	irq_chip->irq_set_type = intc_irqpin_irq_set_type;
@@ -523,6 +522,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
+	irq_domain_set_pm_device(p->irq_domain, dev);
+
 	if (p->shared_irqs) {
 		/* request one shared interrupt */
 		if (devm_request_irq(dev, p->irq[0].requested_irq,
