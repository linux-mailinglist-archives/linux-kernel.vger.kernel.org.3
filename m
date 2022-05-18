Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281C652C368
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbiERTaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241989AbiERTa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:30:26 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 832F222DA04;
        Wed, 18 May 2022 12:30:24 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,235,1647270000"; 
   d="scan'208";a="121409068"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 May 2022 04:30:23 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B4A394004CF5;
        Thu, 19 May 2022 04:30:16 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 5/7] gpio: gpiolib: Add a check to validate GPIO hwirq
Date:   Wed, 18 May 2022 20:29:22 +0100
Message-Id: <20220518192924.20948-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check to validate GPIO hwirq is always within the range of hwirq_max
set in the GPIO irq domain.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpio/gpiolib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 65e344a23c6a..c1de7bb54c13 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1028,6 +1028,7 @@ static void gpiochip_set_hierarchical_irqchip(struct gpio_chip *gc,
 	 * it is necessary to keep this around.
 	 */
 	if (is_fwnode_irqchip(gc->irq.fwnode)) {
+		struct irq_domain *domain = gc->irq.domain;
 		int i;
 		int ret;
 
@@ -1061,6 +1062,11 @@ static void gpiochip_set_hierarchical_irqchip(struct gpio_chip *gc,
 					 i, ret);
 				continue;
 			}
+			if (WARN(hwirq >= domain->hwirq_max,
+				 "error: hwirq 0x%x is too large for %s\n",
+				 (int)hwirq, domain->name))
+				continue;
+
 			fwspec.fwnode = gc->irq.fwnode;
 			/* This is the hwirq for the GPIO line side of things */
 			fwspec.param[0] = hwirq;
@@ -1436,6 +1442,9 @@ static int gpiochip_to_irq(struct gpio_chip *gc, unsigned int offset)
 		ret = gc->irq.child_offset_to_irq(gc, offset, &hwirq);
 		if (ret)
 			return ret;
+		if (WARN(hwirq >= domain->hwirq_max,
+			 "error: hwirq 0x%x is too large for %s\n", (int)hwirq, domain->name))
+			return -EINVAL;
 		spec.fwnode = domain->fwnode;
 		spec.param_count = 2;
 		spec.param[0] = hwirq;
-- 
2.25.1

