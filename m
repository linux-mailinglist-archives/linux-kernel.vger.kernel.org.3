Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D017C509A49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386448AbiDUIMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiDUIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:12:15 -0400
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1514.securemx.jp [210.130.202.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9DA1DA7D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:09:25 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1514) id 23L7vQrR008151; Thu, 21 Apr 2022 16:57:26 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 23L7vDtg006926; Thu, 21 Apr 2022 16:57:13 +0900
X-Iguazu-Qid: 34trpTYxFGuwSfYizF
X-Iguazu-QSIG: v=2; s=0; t=1650527832; q=34trpTYxFGuwSfYizF; m=wl0m7mr0NeanVsq0+bnV1eY/wx6O5k25nJ2V3BLG9MI=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1512) id 23L7vBWG027250
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Apr 2022 16:57:12 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH] gpio: visconti: Fix fwnode of GPIO IRQ
Date:   Thu, 21 Apr 2022 16:57:07 +0900
X-TSB-HOP2: ON
Message-Id: <20220421075707.2135242-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fwnode of GPIO IRQ must be set to its own fwnode, not the fwnode of the
parent IRQ. Therefore, this sets own fwnode instead of the parent IRQ fwnode to
GPIO IRQ's.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
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


