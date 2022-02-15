Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146204B6BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiBOMUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:20:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbiBOMUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:20:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27C1074F1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:20:04 -0800 (PST)
Date:   Tue, 15 Feb 2022 12:20:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644927603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PcL8WtxwVWy3G088Z/wiC8p67nXD5upUkVgxzTVujg=;
        b=L22s1/qM0Q9CY/RM8TI/ekT+WSajWl+0S7aaoqX7OzKFbxySVy/tV8wVfSyTUguAERd8qo
        2MPSTFQU7ZQmH9mIwP2IcW4yQTS0AHO/QiL/Nkb8zX0WUowKuT15ENS5rptSGyl2iCcIZx
        WM2K4hSv/z7bEJgdASN9ORdaB5PIfISLE+bHH3++a2h0CHMmaZeEVdZPsVzyiAYswnxMld
        TUsqJJsnTDMP828E/lLwndCGN9M39/2S83iJcRWSyOrlGLcbvKnMNq982EsKc2ROuypsBF
        rB85GXwlfI1KWUloM30TcF9qmKl7IcTzf56GTbt2xaysWqQiLHZcFZ9p0/KWFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644927603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PcL8WtxwVWy3G088Z/wiC8p67nXD5upUkVgxzTVujg=;
        b=Ji2hgQonTCest5v8uy5Fo1G1zDzbWD98YQIHmxZoe5+rm/lP/XQVq5VhYwI5j9tTw76r2k
        tX2x3hWdmIWq8HCg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Let
 irq_domain_set_{info,hwirq_and_chip} take a const irq_chip
Cc:     Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, tglx@linutronix.de
In-Reply-To: <20220209162607.1118325-2-maz@kernel.org>
References: <20220209162607.1118325-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164492760230.16921.5204321396031016246.tip-bot2@tip-bot2>
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

Commit-ID:     45ec846c1cd11835a29c85645065115dd791aa45
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/45ec846c1cd11835a29c85645065115dd791aa45
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 09 Feb 2022 16:25:58 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 15 Feb 2022 11:10:21 

irqdomain: Let irq_domain_set_{info,hwirq_and_chip} take a const irq_chip

In order to let a const irqchip be fed to the irqchip layer, adjust
the various prototypes. An extra cast in irq_domain_set_hwirq_and_chip()
is required to avoid a warning.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20220209162607.1118325-2-maz@kernel.org
---
 include/linux/irqdomain.h |  5 +++--
 kernel/irq/irqdomain.c    |  9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index be25a33..00d577f 100644
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
index bf38c54..d5ce965 100644
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
@@ -1853,7 +1854,7 @@ EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
  * @handler_name:	The interrupt handler name
  */
 void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
-			 irq_hw_number_t hwirq, struct irq_chip *chip,
+			 irq_hw_number_t hwirq, const struct irq_chip *chip,
 			 void *chip_data, irq_flow_handler_t handler,
 			 void *handler_data, const char *handler_name)
 {
