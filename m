Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC3B4AF68D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiBIQ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbiBIQ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:26:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16109C061355;
        Wed,  9 Feb 2022 08:26:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6AE661646;
        Wed,  9 Feb 2022 16:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13562C340E7;
        Wed,  9 Feb 2022 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423978;
        bh=IbKlzzfUm0Hi1oeEGCrh1Ryrimz2DXihVgaBj1ARG2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKOVWKm3XCa/ZYd6CjHUW55DG6Iad1FX96t254zS/Daa93KF2/5SI+LGu1ljuT5zn
         HDKc1Fw9W8QkAk3Wn14AUZlhn1JmowHNa4mTtFLJwSdwMXCpC7R0nyPZae89dOkkgy
         R1jZCs6yMKIV2DQiLZE4/Ru+ud29WsiQJ/d3ATXGAt1MOFJjG+XpARPY+8CXfibUc7
         WmdJdvFEB/ZpL/q1qMlstVWWnrEokQ6waAEFFJRXPblt5fE7FjyNzMFvvabB1R4LJI
         SA4SQD4+Cuuy84SHlKzV5VPEbnatoJARLEaGXNemqbMzRpyNR+YxjPcgScVJJyGogj
         6x07cJT/I0lrg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHpnM-006fgT-79; Wed, 09 Feb 2022 16:26:16 +0000
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
Subject: [PATCH 01/10] irqdomain: Let irq_domain_set_{info,hwirq_and_chip} take a const irq_chip
Date:   Wed,  9 Feb 2022 16:25:58 +0000
Message-Id: <20220209162607.1118325-2-maz@kernel.org>
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
the various prototypes. An extra cast in irq_domain_set_hwirq_and_chip()
is required to avoid a warning.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 5 +++--
 kernel/irq/irqdomain.c    | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index be25a33293e5..00d577f90883 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -479,7 +479,8 @@ int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest);
 extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 						unsigned int virq);
 extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
-				irq_hw_number_t hwirq, struct irq_chip *chip,
+				irq_hw_number_t hwirq,
+				const struct irq_chip *chip,
 				void *chip_data, irq_flow_handler_t handler,
 				void *handler_data, const char *handler_name);
 extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
@@ -522,7 +523,7 @@ extern int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
 extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
 					 unsigned int virq,
 					 irq_hw_number_t hwirq,
-					 struct irq_chip *chip,
+					 const struct irq_chip *chip,
 					 void *chip_data);
 extern void irq_domain_free_irqs_common(struct irq_domain *domain,
 					unsigned int virq,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index bf38c546aa25..14cf52708890 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1319,7 +1319,8 @@ EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
  * @chip_data:	The associated chip data
  */
 int irq_domain_set_hwirq_and_chip(struct irq_domain *domain, unsigned int virq,
-				  irq_hw_number_t hwirq, struct irq_chip *chip,
+				  irq_hw_number_t hwirq,
+				  const struct irq_chip *chip,
 				  void *chip_data)
 {
 	struct irq_data *irq_data = irq_domain_get_irq_data(domain, virq);
@@ -1328,7 +1329,7 @@ int irq_domain_set_hwirq_and_chip(struct irq_domain *domain, unsigned int virq,
 		return -ENOENT;
 
 	irq_data->hwirq = hwirq;
-	irq_data->chip = chip ? chip : &no_irq_chip;
+	irq_data->chip = (struct irq_chip *)(chip ? chip : &no_irq_chip);
 	irq_data->chip_data = chip_data;
 
 	return 0;
@@ -1347,7 +1348,7 @@ EXPORT_SYMBOL_GPL(irq_domain_set_hwirq_and_chip);
  * @handler_name:	The interrupt handler name
  */
 void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
-			 irq_hw_number_t hwirq, struct irq_chip *chip,
+			 irq_hw_number_t hwirq, const struct irq_chip *chip,
 			 void *chip_data, irq_flow_handler_t handler,
 			 void *handler_data, const char *handler_name)
 {
-- 
2.30.2

