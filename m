Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186374775D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhLPPYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:24:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbhLPPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:24:46 -0500
Date:   Thu, 16 Dec 2021 15:24:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639668285;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXpK23GM89Ckoxuom2UdFWBubM5aTHj6Ntz/J/6EPOU=;
        b=l2uJLUlxpSZdnxmHHjWKMWwdKr/1ah8DRJFDwrloLJGjF+OwhO4y4+k7uCky531lFLfOVY
        2UK8E8zyWE+SOX5/SFLCKSpadEJOQQD9Dz9wCvkN7/pSNQYQA9wosXqiJKeOb3Sbp6vDJX
        uAMQZAc2ZGrEYyb0qqzYesrACkRtQI2xXliUGIlh0U2a6guHyYoR2GvItIUV+kLW5rv+MH
        STNNKyKVvU3pyA0k4+5bbDUcCaXlUQ4vt4xDVkYDKzMAEFh9beYQicP0pBbJECyfOr25Ch
        G0PUJ+jbfzKNUR20TFgdaXgQaU9aGTVDB++a3hD9Z+IR2GBHY14cA7W8Y5NnJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639668285;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXpK23GM89Ckoxuom2UdFWBubM5aTHj6Ntz/J/6EPOU=;
        b=nvGs6TB0J4xQ9LGoZz/kagXqMGjax/jDIRiLPS1ljmIz15MPOvMzVnKa3ZMEB27B6GCay9
        AgMa1qZKsxhh3LCg==
From:   "irqchip-bot for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ingenic-tcu: Use correctly sized
 arguments for bit field
Cc:     Kees Cook <keescook@chromium.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20211215232457.2069969-1-keescook@chromium.org>
References: <20211215232457.2069969-1-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <163966828445.23020.15326391211470190643.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     0859bbb07d06d1357734496ff198319f9bfcf1bf
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0859bbb07d06d1357734496ff198319f9bfcf1bf
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Wed, 15 Dec 2021 15:24:57 -08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 16 Dec 2021 15:19:52 

irqchip/ingenic-tcu: Use correctly sized arguments for bit field

The find.h APIs are designed to be used only on unsigned long arguments.
This can technically result in a over-read, but it is harmless in this
case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
which we'd like to enable globally:

In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./include/linux/smp.h:13,
                 from ./include/linux/lockdep.h:14,
                 from ./include/linux/mutex.h:17,
                 from ./include/linux/notifier.h:14,
                 from ./include/linux/clk.h:14,
                 from drivers/irqchip/irq-ingenic-tcu.c:7:
drivers/irqchip/irq-ingenic-tcu.c: In function 'ingenic_tcu_intc_cascade':
./include/linux/find.h:40:23: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'uint32_t[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
   40 |                 val = *addr & GENMASK(size - 1, offset);
      |                       ^~~~~
drivers/irqchip/irq-ingenic-tcu.c:30:18: note: while referencing 'irq_reg'
   30 |         uint32_t irq_reg, irq_mask;
      |                  ^~~~~~~

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211215232457.2069969-1-keescook@chromium.org
---
 drivers/irqchip/irq-ingenic-tcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ingenic-tcu.c b/drivers/irqchip/irq-ingenic-tcu.c
index 34a7d26..3363f83 100644
--- a/drivers/irqchip/irq-ingenic-tcu.c
+++ b/drivers/irqchip/irq-ingenic-tcu.c
@@ -28,6 +28,7 @@ static void ingenic_tcu_intc_cascade(struct irq_desc *desc)
 	struct irq_chip_generic *gc = irq_get_domain_generic_chip(domain, 0);
 	struct regmap *map = gc->private;
 	uint32_t irq_reg, irq_mask;
+	unsigned long bits;
 	unsigned int i;
 
 	regmap_read(map, TCU_REG_TFR, &irq_reg);
@@ -36,8 +37,9 @@ static void ingenic_tcu_intc_cascade(struct irq_desc *desc)
 	chained_irq_enter(irq_chip, desc);
 
 	irq_reg &= ~irq_mask;
+	bits = irq_reg;
 
-	for_each_set_bit(i, (unsigned long *)&irq_reg, 32)
+	for_each_set_bit(i, &bits, 32)
 		generic_handle_domain_irq(domain, i);
 
 	chained_irq_exit(irq_chip, desc);
