Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF34AF68E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbiBIQ00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbiBIQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:26:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D131C0612BE;
        Wed,  9 Feb 2022 08:26:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF1B6173F;
        Wed,  9 Feb 2022 16:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB1EC340F1;
        Wed,  9 Feb 2022 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423978;
        bh=Wvtg7LeNxS554mBjaABOaR6mrMR2r5v7osda1KMnoxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=git6DwPFmFIir7qHN2D/BtS7T5ay6cKuxtTDFu+F1Yv1TMmHLP4Pq05qexSazgRoY
         XOFsBlQHoRU1/MNH9tssEN1n5HnObq5V8B6KlcECTV56bXGj3B0G/JyzNp3gpp6CmG
         RJA//0UcEr4y4qiwKbVqCHfLB1sfVQVaLiFUoMc8vnKmzFoW6vxo/md0xpYFidXO8p
         EZGIX/JZkoeaj9OQ1YaBcql9R7Ia4LmTTJrshrXYp5N4MrFXTFINHGj1f1L+5yYcXF
         hN8WxP+w3uJkeRNw8jGsi1jrcFdTpk+N9soCMhkEisXNESwFLRC89atU6NlBrJQoSW
         AqhKGWjgqCETg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHpnM-006fgT-GD; Wed, 09 Feb 2022 16:26:16 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        kernel-team@android.com
Subject: [PATCH 02/10] genirq: Allow irq_chip registration functions to take a const irq_chip
Date:   Wed,  9 Feb 2022 16:25:59 +0000
Message-Id: <20220209162607.1118325-3-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209162607.1118325-1-maz@kernel.org>
References: <20220209162607.1118325-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, tony@atomide.com, tglx@linutronix.de, vz@mleia.com, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, kernel@esmil.dk, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to let a const irqchip be fed to the irqchip layer, adjust
the various prototypes. An extra cast in irq_set_chip()() is required
to avoid a warning.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h | 7 ++++---
 kernel/irq/chip.c   | 9 +++------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 2cb2e2ac2703..f92788ccdba2 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -710,10 +710,11 @@ extern struct irq_chip no_irq_chip;
 extern struct irq_chip dummy_irq_chip;
 
 extern void
-irq_set_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
+irq_set_chip_and_handler_name(unsigned int irq, const struct irq_chip *chip,
 			      irq_flow_handler_t handle, const char *name);
 
-static inline void irq_set_chip_and_handler(unsigned int irq, struct irq_chip *chip,
+static inline void irq_set_chip_and_handler(unsigned int irq,
+					    const struct irq_chip *chip,
 					    irq_flow_handler_t handle)
 {
 	irq_set_chip_and_handler_name(irq, chip, handle, NULL);
@@ -803,7 +804,7 @@ static inline void irq_set_percpu_devid_flags(unsigned int irq)
 }
 
 /* Set/get chip/data for an IRQ: */
-extern int irq_set_chip(unsigned int irq, struct irq_chip *chip);
+extern int irq_set_chip(unsigned int irq, const struct irq_chip *chip);
 extern int irq_set_handler_data(unsigned int irq, void *data);
 extern int irq_set_chip_data(unsigned int irq, void *data);
 extern int irq_set_irq_type(unsigned int irq, unsigned int type);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 24b6f2b40e5e..54af0deb239b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -38,7 +38,7 @@ struct irqaction chained_action = {
  *	@irq:	irq number
  *	@chip:	pointer to irq chip description structure
  */
-int irq_set_chip(unsigned int irq, struct irq_chip *chip)
+int irq_set_chip(unsigned int irq, const struct irq_chip *chip)
 {
 	unsigned long flags;
 	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
@@ -46,10 +46,7 @@ int irq_set_chip(unsigned int irq, struct irq_chip *chip)
 	if (!desc)
 		return -EINVAL;
 
-	if (!chip)
-		chip = &no_irq_chip;
-
-	desc->irq_data.chip = chip;
+	desc->irq_data.chip = (struct irq_chip *)(chip ?: &no_irq_chip);
 	irq_put_desc_unlock(desc, flags);
 	/*
 	 * For !CONFIG_SPARSE_IRQ make the irq show up in
@@ -1073,7 +1070,7 @@ irq_set_chained_handler_and_data(unsigned int irq, irq_flow_handler_t handle,
 EXPORT_SYMBOL_GPL(irq_set_chained_handler_and_data);
 
 void
-irq_set_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
+irq_set_chip_and_handler_name(unsigned int irq, const struct irq_chip *chip,
 			      irq_flow_handler_t handle, const char *name)
 {
 	irq_set_chip(irq, chip);
-- 
2.30.2

