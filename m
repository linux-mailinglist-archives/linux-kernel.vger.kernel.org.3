Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B29247D5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbhLVRTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:19:42 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:59711 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344250AbhLVRT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:19:29 -0500
X-IronPort-AV: E=Sophos;i="5.88,227,1635174000"; 
   d="scan'208";a="104377837"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Dec 2021 02:19:27 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0AF684001B4B;
        Thu, 23 Dec 2021 02:19:25 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] gpio: ts5500: Use platform_get_irq() to get the interrupt
Date:   Wed, 22 Dec 2021 17:19:14 +0000
Message-Id: <20211222171915.9053-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222171915.9053-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211222171915.9053-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpio/gpio-ts5500.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-ts5500.c b/drivers/gpio/gpio-ts5500.c
index c91890488402..b159e92a3612 100644
--- a/drivers/gpio/gpio-ts5500.c
+++ b/drivers/gpio/gpio-ts5500.c
@@ -317,22 +317,19 @@ static int ts5500_dio_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const char *name = dev_name(dev);
 	struct ts5500_priv *priv;
-	struct resource *res;
 	unsigned long flags;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(dev, "missing IRQ resource\n");
-		return -EINVAL;
-	}
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
 
 	priv = devm_kzalloc(dev, sizeof(struct ts5500_priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, priv);
-	priv->hwirq = res->start;
+	priv->hwirq = ret;
 	spin_lock_init(&priv->lock);
 
 	priv->gpio_chip.owner = THIS_MODULE;
-- 
2.17.1

