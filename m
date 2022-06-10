Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2DB545BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbiFJFqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiFJFqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:46:43 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A661B2CDE0;
        Thu,  9 Jun 2022 22:46:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25A5kcU6076339;
        Fri, 10 Jun 2022 00:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654839998;
        bh=wHqiXhAu2v2mq7YpYI22FqA+jgUuIC19t9HS/+ddvS0=;
        h=From:To:CC:Subject:Date;
        b=MxJgVe2D0508b/XVpVAMgM/Af5WcEv6Oh7n4qWSWL1vewVdTxesSyRmKx4OCCIjGR
         804fnZ2r4Y/dbHdOQm1iOKEjuyBYRc4myUzatenH3PM/rlfLFsrA65kCbLKPkrb7Gc
         Wbfb8VDUmv4uTAxyPlbuZA/Mms+0Lw9ytCUm4ypQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25A5kcEX122664
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jun 2022 00:46:38 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 10
 Jun 2022 00:46:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 10 Jun 2022 00:46:38 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25A5kZlB114767;
        Fri, 10 Jun 2022 00:46:35 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] gpio: davinci: Add support for system suspend/resume PM
Date:   Fri, 10 Jun 2022 11:16:22 +0530
Message-ID: <20220610054622.21281-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Devarsh Thakkar <devarsht@ti.com>

Add support for system suspend/resume PM hooks, save the
register context of all the required gpio registers on suspend
and restore the context on resume.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

Changes since v1:
- Moved header include to group with other similar headers
- Removed unnecessary intializations

 drivers/gpio/gpio-davinci.c | 84 +++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index f960587f86a3..2c472ec21454 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -22,6 +22,7 @@
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/spinlock.h>
+#include <linux/pm_runtime.h>
 
 #include <asm-generic/gpio.h>
 
@@ -62,6 +63,8 @@ struct davinci_gpio_controller {
 	void __iomem		*regs[MAX_REGS_BANKS];
 	int			gpio_unbanked;
 	int			irqs[MAX_INT_PER_BANK];
+	struct davinci_gpio_regs context[MAX_REGS_BANKS];
+	u32			binten_context;
 };
 
 static inline u32 __gpio_mask(unsigned gpio)
@@ -622,6 +625,86 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	return 0;
 }
 
+static void davinci_gpio_save_context(struct davinci_gpio_controller *chips,
+				      u32 nbank)
+{
+	struct davinci_gpio_regs __iomem *g;
+	struct davinci_gpio_regs *context;
+	u32 bank;
+	void __iomem *base;
+
+	base = chips->regs[0] - offset_array[0];
+	chips->binten_context = readl_relaxed(base + BINTEN);
+
+	for (bank = 0; bank < nbank; bank++) {
+		g = chips->regs[bank];
+		context = &chips->context[bank];
+		context->dir = readl_relaxed(&g->dir);
+		context->set_data = readl_relaxed(&g->set_data);
+		context->set_rising = readl_relaxed(&g->set_rising);
+		context->set_falling = readl_relaxed(&g->set_falling);
+	}
+
+	/* Clear Bank interrupt enable bit */
+	writel_relaxed(0, base + BINTEN);
+
+	/* Clear all interrupt status registers */
+	writel_relaxed(0xFFFFFFFF, &g->intstat);
+}
+
+static void davinci_gpio_restore_context(struct davinci_gpio_controller *chips,
+					 u32 nbank)
+{
+	struct davinci_gpio_regs __iomem *g;
+	struct davinci_gpio_regs *context;
+	u32 bank;
+	void __iomem *base;
+
+	base = chips->regs[0] - offset_array[0];
+
+	if (readl_relaxed(base + BINTEN) != chips->binten_context)
+		writel_relaxed(chips->binten_context, base + BINTEN);
+
+	for (bank = 0; bank < nbank; bank++) {
+		g = chips->regs[bank];
+		context = &chips->context[bank];
+		if (readl_relaxed(&g->dir) != context->dir)
+			writel_relaxed(context->dir, &g->dir);
+		if (readl_relaxed(&g->set_data) != context->set_data)
+			writel_relaxed(context->set_data, &g->set_data);
+		if (readl_relaxed(&g->set_rising) != context->set_rising)
+			writel_relaxed(context->set_rising, &g->set_rising);
+		if (readl_relaxed(&g->set_falling) != context->set_falling)
+			writel_relaxed(context->set_falling, &g->set_falling);
+	}
+}
+
+static int __maybe_unused davinci_gpio_suspend(struct device *dev)
+{
+	struct davinci_gpio_controller *chips = dev_get_drvdata(dev);
+	struct davinci_gpio_platform_data *pdata = dev_get_platdata(dev);
+	u32 nbank = DIV_ROUND_UP(pdata->ngpio, 32);
+
+	davinci_gpio_save_context(chips, nbank);
+
+	return 0;
+}
+
+static int __maybe_unused davinci_gpio_resume(struct device *dev)
+{
+	struct davinci_gpio_controller *chips = dev_get_drvdata(dev);
+	struct davinci_gpio_platform_data *pdata = dev_get_platdata(dev);
+	u32 nbank = DIV_ROUND_UP(pdata->ngpio, 32);
+
+	davinci_gpio_restore_context(chips, nbank);
+
+	return 0;
+}
+
+static const struct dev_pm_ops davinci_gpio_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(davinci_gpio_suspend, davinci_gpio_resume)
+};
+
 static const struct of_device_id davinci_gpio_ids[] = {
 	{ .compatible = "ti,keystone-gpio", keystone_gpio_get_irq_chip},
 	{ .compatible = "ti,am654-gpio", keystone_gpio_get_irq_chip},
@@ -634,6 +717,7 @@ static struct platform_driver davinci_gpio_driver = {
 	.probe		= davinci_gpio_probe,
 	.driver		= {
 		.name		= "davinci_gpio",
+		.pm = &davinci_gpio_dev_pm_ops,
 		.of_match_table	= of_match_ptr(davinci_gpio_ids),
 	},
 };
-- 
2.17.1

