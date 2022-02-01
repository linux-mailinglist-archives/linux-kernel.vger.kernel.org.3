Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712224A5BC9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbiBAMEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:04:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52624 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiBAMEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:04:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56305614F3;
        Tue,  1 Feb 2022 12:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1F9C340F1;
        Tue,  1 Feb 2022 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643717011;
        bh=5li6uOCO4gX7ZJ2txGyIkmUBfTDqopiS+pQdRb6NCnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KB2h7AyKsZadfSSMWZQ8FIbuY6JIZXH8OhH7jRWWjdDVzdK8l08E2K2cwgLtc7vDY
         u8Z1Nec+BBZoClrdGxqxe/t+AozvThp3bi6WePVDd6Lkm5jgJwx4c04T0Y+0Sgg3QQ
         IW2YCauOHwKDIlnnyagypdU0vhPKbdih+XKptTVCyszhhafZc83ZK14PmJiTDRa2Bs
         +Dw2bRSmwe2ayMeY8yzvtbSL8NcVO9t7b0grxDtjkr3NDfd12r9ii75HZy6ewU+iav
         S2lgVFGjcxX8coLo+GFRDpClLEIHQVaN0FHqKnjq3uqF1FNlFULavi1ksc2grs4HiI
         n6KqAkxz6Go4Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nErsf-004d46-CV; Tue, 01 Feb 2022 12:03:29 +0000
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
Subject: [PATCH 02/12] irqchip/gic: Move PM device over to irq domain
Date:   Tue,  1 Feb 2022 12:03:00 +0000
Message-Id: <20220201120310.878267-3-maz@kernel.org>
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

Move the reference to the GIC device over to the irq domain.
This allows for some localised cleanup.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b8bb46c65a97..fb741b42ca2d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1127,13 +1127,12 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.unmap = gic_irq_domain_unmap,
 };
 
-static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
-			  const char *name, bool use_eoimode1)
+static void gic_init_chip(struct gic_chip_data *gic, const char *name,
+			  bool use_eoimode1)
 {
 	/* Initialize irq_chip */
 	gic->chip = gic_chip;
 	gic->chip.name = name;
-	gic->chip.parent_device = dev;
 
 	if (use_eoimode1) {
 		gic->chip.irq_mask = gic_eoimode1_mask_irq;
@@ -1268,10 +1267,10 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 
 	if (static_branch_likely(&supports_deactivate_key) && gic == &gic_data[0]) {
 		name = kasprintf(GFP_KERNEL, "GICv2");
-		gic_init_chip(gic, NULL, name, true);
+		gic_init_chip(gic, name, true);
 	} else {
 		name = kasprintf(GFP_KERNEL, "GIC-%d", (int)(gic-&gic_data[0]));
-		gic_init_chip(gic, NULL, name, false);
+		gic_init_chip(gic, name, false);
 	}
 
 	ret = gic_init_bases(gic, handle);
@@ -1460,7 +1459,7 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq)
 	if (!*gic)
 		return -ENOMEM;
 
-	gic_init_chip(*gic, dev, dev->of_node->name, false);
+	gic_init_chip(*gic, dev->of_node->name, false);
 
 	ret = gic_of_setup(*gic, dev->of_node);
 	if (ret)
@@ -1472,6 +1471,7 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq)
 		return ret;
 	}
 
+	irq_domain_set_pm_device((*gic)->domain, dev);
 	irq_set_chained_handler_and_data(irq, gic_handle_cascade_irq, *gic);
 
 	return 0;
-- 
2.30.2

