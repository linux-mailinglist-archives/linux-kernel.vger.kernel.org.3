Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A636509C94
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387793AbiDUJpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387774AbiDUJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:45:41 -0400
Received: from mo-csw.securemx.jp (mo-csw1514.securemx.jp [210.130.202.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25B824BD7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:42:51 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 23L9gb8O004596; Thu, 21 Apr 2022 18:42:37 +0900
X-Iguazu-Qid: 34trQigfsM9AOe1oBN
X-Iguazu-QSIG: v=2; s=0; t=1650534157; q=34trQigfsM9AOe1oBN; m=Ut1SpkpRGkVEB/JCPVblskph/aglZB/76Gj0Mthtm54=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1512) id 23L9gaNb039362
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Apr 2022 18:42:36 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v2] gpio: visconti: Fix fwnode of GPIO IRQ
Date:   Thu, 21 Apr 2022 18:42:28 +0900
X-TSB-HOP2: ON
Message-Id: <20220421094228.2141569-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fwnode of GPIO IRQ must be set to its own fwnode, not the fwnode of the
parent IRQ. Therefore, this sets own fwnode instead of the parent IRQ fwnode to
GPIO IRQ's.

Fixes: 2ad74f40dacc ("gpio: visconti: Add Toshiba Visconti GPIO support")
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---

 v2: Add Fixes tag.

 drivers/gpio/gpio-visconti.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-visconti.c b/drivers/gpio/gpio-visconti.c
index 47455810bdb9..e6534ea1eaa7 100644
--- a/drivers/gpio/gpio-visconti.c
+++ b/drivers/gpio/gpio-visconti.c
@@ -130,7 +130,6 @@ static int visconti_gpio_probe(struct platform_device *pdev)
 	struct gpio_irq_chip *girq;
 	struct irq_domain *parent;
 	struct device_node *irq_parent;
-	struct fwnode_handle *fwnode;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -150,14 +149,12 @@ static int visconti_gpio_probe(struct platform_device *pdev)
 	}
 
 	parent = irq_find_host(irq_parent);
+	of_node_put(irq_parent);
 	if (!parent) {
 		dev_err(dev, "No IRQ parent domain\n");
 		return -ENODEV;
 	}
 
-	fwnode = of_node_to_fwnode(irq_parent);
-	of_node_put(irq_parent);
-
 	ret = bgpio_init(&priv->gpio_chip, dev, 4,
 			 priv->base + GPIO_IDATA,
 			 priv->base + GPIO_OSET,
@@ -180,7 +177,7 @@ static int visconti_gpio_probe(struct platform_device *pdev)
 
 	girq = &priv->gpio_chip.irq;
 	girq->chip = irq_chip;
-	girq->fwnode = fwnode;
+	girq->fwnode = of_node_to_fwnode(dev->of_node);
 	girq->parent_domain = parent;
 	girq->child_to_parent_hwirq = visconti_gpio_child_to_parent_hwirq;
 	girq->populate_parent_alloc_arg = visconti_gpio_populate_parent_fwspec;
-- 
2.34.1


