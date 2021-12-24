Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C44447EFBA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352993AbhLXO6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:58:00 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:57063 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231836AbhLXO6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:58:00 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="105109884"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Dec 2021 23:57:58 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5EA8F42C25A2;
        Fri, 24 Dec 2021 23:57:56 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-gpio@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: samsung: Use platform_get_irq_optional() to get the interrupt
Date:   Fri, 24 Dec 2021 14:57:47 +0000
Message-Id: <20211224145748.18754-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224145748.18754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224145748.18754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_optional().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 8941f658e7f1..0f6e9305fec5 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1095,7 +1095,6 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 	struct samsung_pinctrl_drv_data *drvdata;
 	const struct samsung_pin_ctrl *ctrl;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int ret;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
@@ -1109,9 +1108,11 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 	}
 	drvdata->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res)
-		drvdata->irq = res->start;
+	ret = platform_get_irq_optional(pdev, 0);
+	if (ret < 0 && ret != -ENXIO)
+		return ret;
+	if (ret > 0)
+		drvdata->irq = ret;
 
 	if (ctrl->retention_data) {
 		drvdata->retention_ctrl = ctrl->retention_data->init(drvdata,
-- 
2.17.1

