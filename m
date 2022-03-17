Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AAD4DBC4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358264AbiCQBZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350066AbiCQBZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:25:40 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5019E1E3CA;
        Wed, 16 Mar 2022 18:24:21 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,188,1643641200"; 
   d="scan'208";a="114675301"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Mar 2022 10:24:21 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 58DFD41A45A3;
        Thu, 17 Mar 2022 10:24:18 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH v4 3/5] gpio: gpiolib: Allow free() callback to be overridden
Date:   Thu, 17 Mar 2022 01:24:02 +0000
Message-Id: <20220317012404.8069-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220317012404.8069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220317012404.8069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow free() callback to be overridden from irq_domain_ops for
hierarchical chips.

This allows drivers to free any resources which are allocated during
populate_parent_alloc_arg().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpio/gpiolib.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index defb7c464b87..aede442f610d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1187,15 +1187,18 @@ static void gpiochip_hierarchy_setup_domain_ops(struct irq_domain_ops *ops)
 	ops->activate = gpiochip_irq_domain_activate;
 	ops->deactivate = gpiochip_irq_domain_deactivate;
 	ops->alloc = gpiochip_hierarchy_irq_domain_alloc;
-	ops->free = irq_domain_free_irqs_common;
 
 	/*
-	 * We only allow overriding the translate() function for
+	 * We only allow overriding the translate() and free() function for
 	 * hierarchical chips, and this should only be done if the user
-	 * really need something other than 1:1 translation.
+	 * really need something other than 1:1 translation for translate()
+	 * callback and free if user wants to free up any resources which
+	 * were allocated during callbacks for example populate_parent_alloc_arg.
 	 */
 	if (!ops->translate)
 		ops->translate = gpiochip_hierarchy_irq_domain_translate;
+	if (!ops->free)
+		ops->free = irq_domain_free_irqs_common;
 }
 
 static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
-- 
2.17.1

