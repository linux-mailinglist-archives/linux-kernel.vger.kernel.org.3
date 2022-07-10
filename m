Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BCB56CE02
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiGJImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGJImG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 04:42:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D6C18E1E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 01:42:05 -0700 (PDT)
Date:   Sun, 10 Jul 2022 08:42:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657442524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9V2bNa6SzOeLc8wtQ4EVBagb37U/GoAK3ceK1ZOqE0Y=;
        b=Q+bwjPvCIHrffeFTjpCs5C/LF51XdxrcOAvnGDdegsjYBi5aRyOxMAUX8GgJRevCJfOBNx
        TzQJiNzi742vbsDK9QPGDH3jgK8421yn8KZV94crTFitVxMMtcjx8/U7OUmmhEvSWiqegM
        WGybqfG3G8QSe7wmv6SVXa8GVpD+JSe/N7D/sofGhGC3+v8AUo7WEkPAMK/77sYtRv3vnc
        T60B0ILzoTyjSsARF9FGdKTrOUuphL9DZnsG/Y1569U2SEFrXV5j1V7yuIZFgEv3CForqV
        dATQxTRFmeD9jmaFca5G99V4ucs0iYrJE+oRdEQNuyhZ9wVKxpFvNniFLlGRSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657442524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9V2bNa6SzOeLc8wtQ4EVBagb37U/GoAK3ceK1ZOqE0Y=;
        b=2de4WU64V0QR7P8tUq6oIOehQn4GxIvM562OKPSiuYfPxRCTfBw51JmRQqcnRk6yEWN3ZL
        Zn+ZBnHLACO6+VDA==
From:   "irqchip-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: gpiolib: Allow free() callback to
 be overridden
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220707182314.66610-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220707182314.66610-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <165744252336.15455.10210434568702753718.tip-bot2@tip-bot2>
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

Commit-ID:     08f12b4534c274c67245019021961206e7a3eefa
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/08f12b4534c274c67245019021961206e7a3eefa
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 07 Jul 2022 19:23:12 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Jul 2022 09:30:00 +01:00

gpio: gpiolib: Allow free() callback to be overridden

Allow free() callback to be overridden from irq_domain_ops for
hierarchical chips.

This allows drivers to free up resources which are allocated during
child_to_parent_hwirq()/populate_parent_alloc_arg() callbacks.

On Renesas RZ/G2L platform a bitmap is maintained for TINT slots, a slot
is allocated in child_to_parent_hwirq() callback which is freed up in free
callback hence this override.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220707182314.66610-5-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 drivers/gpio/gpiolib.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index bfde942..68d9f95 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1181,15 +1181,18 @@ static void gpiochip_hierarchy_setup_domain_ops(struct irq_domain_ops *ops)
 	ops->activate = gpiochip_irq_domain_activate;
 	ops->deactivate = gpiochip_irq_domain_deactivate;
 	ops->alloc = gpiochip_hierarchy_irq_domain_alloc;
-	ops->free = irq_domain_free_irqs_common;
 
 	/*
-	 * We only allow overriding the translate() function for
+	 * We only allow overriding the translate() and free() functions for
 	 * hierarchical chips, and this should only be done if the user
-	 * really need something other than 1:1 translation.
+	 * really need something other than 1:1 translation for translate()
+	 * callback and free if user wants to free up any resources which
+	 * were allocated during callbacks, for example populate_parent_alloc_arg.
 	 */
 	if (!ops->translate)
 		ops->translate = gpiochip_hierarchy_irq_domain_translate;
+	if (!ops->free)
+		ops->free = irq_domain_free_irqs_common;
 }
 
 static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
