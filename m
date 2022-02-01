Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4594A5BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiBAMDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiBAMDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:03:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117D9C06173B;
        Tue,  1 Feb 2022 04:03:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1982B82D91;
        Tue,  1 Feb 2022 12:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5548C340EF;
        Tue,  1 Feb 2022 12:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643717012;
        bh=CfmjmYw5XzvPnzCve4rcfKvXvJFCfoKFdwf7VlQImFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHqhUoIKbM6ivfR9/ud7wD+8gBQE6Kus1wyXyTUml1eZNAivgGLlXLYAzmkajryZx
         jlWCFSKRsV4BGoCOOX4Y8R5qWB849RtEc4L94GIpjEf2jO6YhmupTvVRpYzbE0pQDJ
         edywvEfVcoTP/RpJHIuvZWs8g4+gr+vZm9tmW5QJT/0OTVYQUUGNIpzH8TUFvIZKk2
         DkMtCJvw699Ednr5SBuFEbUh2gzveeaqnJNQNzu3xg3pcV686ng0gZlJtJsjr4SfzY
         /U2sOEQTNN8r7rKSI9N0ZWj0SnNOP+QegaSvG2bxWBuHsuNUQaz5TrHd+8OeTJ7xE5
         Ye6hApizgQn7Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nErsg-004d46-R9; Tue, 01 Feb 2022 12:03:30 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH 05/12] irqchip/imx-intmux: Move PM device over to irq domain
Date:   Tue,  1 Feb 2022 12:03:03 +0000
Message-Id: <20220201120310.878267-6-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201120310.878267-1-maz@kernel.org>
References: <20220201120310.878267-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, tglx@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, kernel@esmil.dk
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the reference to the device over to the irq domain.
This allows the irq_chip structure to be directly used instead
of taking a copy for each instance.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-imx-intmux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index e86ff743e98c..80aaea82468a 100644
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
-- 
2.30.2

