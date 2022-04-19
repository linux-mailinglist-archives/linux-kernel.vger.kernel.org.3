Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2BF50708B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353431AbiDSOcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353347AbiDSObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E6C35A86
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:08 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:29:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650378547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmdYZG57UDB3nKmKGQneikiRzLQywHmdFzppNpNTQLM=;
        b=afZaWc3ZCCuzTZrKEr1aVWbY2FBIq0H/gYfOUd2cdq2uBVB3rKTvYL69+wicoOJY/5ihLr
        O1fMzQjrEEZfQWr/bWrtGDc+UtCq0w1sMOBoZxUxFcGw33r8lbh8alQUCFpMALw3F+jcvP
        p/ImS4QS2oHw2Ym7kF1Yi+iRbZvy1Hl/5uqSt2gK7veZfTSpeo2Gky1esJef02iC5miwqr
        So7aqUdS/oqy7ncB7sXYMc/Cc0D8Pi8tEo3Hhcoq+C7A4k16XdT1cz48bR0IPnOEpqpfG7
        52m8bHUzPmlVUl10Y3UenAVuFiAyJK9TdAosNGDUhBup9Tdd4H5ol6oPsclYSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650378547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmdYZG57UDB3nKmKGQneikiRzLQywHmdFzppNpNTQLM=;
        b=38ipGL4B3CCkqcmeBktKFlq2VAqmpLS2y02aEUhgJ9R7dwQCLIpqa6RHFlafzS8k/g0Lci
        LyrcweihDnZ6MGCQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: Don't fiddle with irqchips marked
 as immutable
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220419141846.598305-2-maz@kernel.org>
References: <20220419141846.598305-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165037854631.4207.10307653212413379012.tip-bot2@tip-bot2>
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

Commit-ID:     6c846d026d490b2383d395bc8e7b06336219667b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/6c846d026d490b2383d395bc8e7b06336219667b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 19 Apr 2022 15:18:37 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Apr 2022 15:22:25 +01:00

gpio: Don't fiddle with irqchips marked as immutable

In order to move away from gpiolib messing with the internals of
unsuspecting irqchips, add a flag by which irqchips advertise
that they are not to be messed with, and do solemnly swear that
they correctly call into the gpiolib helpers when required.

Also nudge the users into converting their drivers to the
new model.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220419141846.598305-2-maz@kernel.org
---
 drivers/gpio/gpiolib.c | 7 ++++++-
 include/linux/irq.h    | 2 ++
 kernel/irq/debugfs.c   | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e59884c..48191e6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1475,6 +1475,11 @@ static void gpiochip_set_irq_hooks(struct gpio_chip *gc)
 {
 	struct irq_chip *irqchip = gc->irq.chip;
 
+	if (irqchip->flags & IRQCHIP_IMMUTABLE)
+		return;
+
+	chip_warn(gc, "not an immutable chip, please consider fixing it!\n");
+
 	if (!irqchip->irq_request_resources &&
 	    !irqchip->irq_release_resources) {
 		irqchip->irq_request_resources = gpiochip_irq_reqres;
@@ -1633,7 +1638,7 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
 		irq_domain_remove(gc->irq.domain);
 	}
 
-	if (irqchip) {
+	if (irqchip && !(irqchip->flags & IRQCHIP_IMMUTABLE)) {
 		if (irqchip->irq_request_resources == gpiochip_irq_reqres) {
 			irqchip->irq_request_resources = NULL;
 			irqchip->irq_release_resources = NULL;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f92788c..5053082 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -569,6 +569,7 @@ struct irq_chip {
  * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq() for wake irqs
  *                                    in the suspend path if they are in disabled state
  * IRQCHIP_AFFINITY_PRE_STARTUP:      Default affinity update before startup
+ * IRQCHIP_IMMUTABLE:		      Don't ever change anything in this chip
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
@@ -582,6 +583,7 @@ enum {
 	IRQCHIP_SUPPORTS_NMI			= (1 <<  8),
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
 	IRQCHIP_AFFINITY_PRE_STARTUP		= (1 << 10),
+	IRQCHIP_IMMUTABLE			= (1 << 11),
 };
 
 #include <linux/irqdesc.h>
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 2b43f5f..bc8e40c 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -58,6 +58,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
 	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
+	BIT_MASK_DESCR(IRQCHIP_IMMUTABLE),
 };
 
 static void
