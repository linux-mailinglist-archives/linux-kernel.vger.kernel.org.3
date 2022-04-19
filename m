Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922AB507094
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353425AbiDSOcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353341AbiDSObt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB96632ED7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:06 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:29:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650378545;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8LVyMyl69zR1ZKXc9yYCBmiEE6hBFrp1p3Ewpg/sfE=;
        b=anRS9Ap2byBwjYJ0L8oWWwXxEGHlZZe8K5yNHEnSrTfhmN4MZFffGb5ow1BbuV5bmx2H23
        V/LziwgkYM3EjUkPot+NUmI/P6jrYVvO+0Ja9gcmU+kVgH3Lm7IOaHIb935VF0M8yat3mV
        E/6hWM4wXkaX+u0yZ0X+mN/jKlfNE7iPsTqlGI4dtFNpsv73xYOMC1hWlD1o741xJLG9iE
        c0bDDSip7dsCNjy5s0KkSVEcyRVC3SI3454r3kTmFz+5K7Rwsxv7r/8SUq7FzGTSmiRv3/
        ADnib2K4zvvWFat+tsPU+5rHK/xxJK59KLh1u3pSEaw1JL3EbYrk1Cl0bP016A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650378545;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8LVyMyl69zR1ZKXc9yYCBmiEE6hBFrp1p3Ewpg/sfE=;
        b=DhlXr4QBqM2co3Akk//KLYEpSOid893zUYBD4vT2xBDUaCnWWMhfeWSeGvQIl8XhliIlSy
        LC67LH7kOF6Vi0Dw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: Add helpers to ease the transition
 towards immutable irq_chip
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220419141846.598305-4-maz@kernel.org>
References: <20220419141846.598305-4-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165037854449.4207.5465768707727542198.tip-bot2@tip-bot2>
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

Commit-ID:     36b78aae4bfee749bbde73be570796bfd0f56bec
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/36b78aae4bfee749bbde73be570796bfd0f56bec
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 19 Apr 2022 15:18:39 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Apr 2022 15:22:25 +01:00

gpio: Add helpers to ease the transition towards immutable irq_chip

Add a couple of new helpers to make it slightly simpler to convert
drivers to immutable irq_chip structures:

- GPIOCHIP_IRQ_RESOURCE_HELPERS populates the irq_chip structure
  with the resource management callbacks

- gpio_irq_chip_set_chip() populates the gpio_irq_chip.chip
  structure, avoiding the proliferation of ugly casts

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220419141846.598305-4-maz@kernel.org
---
 include/linux/gpio/driver.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 066bcfd..8329900 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -583,6 +583,18 @@ void gpiochip_enable_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_irq_reqres(struct irq_data *data);
 void gpiochip_irq_relres(struct irq_data *data);
 
+/* Paste this in your irq_chip structure  */
+#define	GPIOCHIP_IRQ_RESOURCE_HELPERS					\
+		.irq_request_resources  = gpiochip_irq_reqres,		\
+		.irq_release_resources  = gpiochip_irq_relres
+
+static inline void gpio_irq_chip_set_chip(struct gpio_irq_chip *girq,
+					  const struct irq_chip *chip)
+{
+	/* Yes, dropping const is ugly, but it isn't like we have a choice */
+	girq->chip = (struct irq_chip *)chip;
+}
+
 /* Line status inquiry for drivers */
 bool gpiochip_line_is_open_drain(struct gpio_chip *gc, unsigned int offset);
 bool gpiochip_line_is_open_source(struct gpio_chip *gc, unsigned int offset);
