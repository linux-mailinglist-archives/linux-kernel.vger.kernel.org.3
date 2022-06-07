Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECEE53F5DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiFGGJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiFGGJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:09:03 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B0074DCD;
        Mon,  6 Jun 2022 23:09:00 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25768uRF051718;
        Tue, 7 Jun 2022 01:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654582136;
        bh=nidINZIEq4vgj16Es0+Ovr6uytuu8fg2N2dWMhUESEI=;
        h=From:To:CC:Subject:Date;
        b=QVRYI/s1GrlEvV9pUEzmpocKhxSKKEpPDLVoFI9vmYwUEOJFy6U8UlTjyXjWqGqGa
         nMMxinXeeambozj7MbXXUcYfHeQfcbFnEzlN8okaWomRVbamC6FuXZiL6H+0dDWmK8
         ePK3bzPivskMZNwydQepRUM9DiryF4/3ITDdWxwk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25768ugI071354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jun 2022 01:08:56 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Jun 2022 01:08:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Jun 2022 01:08:56 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25768rW4055419;
        Tue, 7 Jun 2022 01:08:53 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Devarsh Thakkar <devarsht@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] gpio: davinci: Add support for system suspend/resume PM
Date:   Tue, 7 Jun 2022 11:38:51 +0530
Message-ID: <20220607060851.10838-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/gpio/gpio-davinci.c | 84 +++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index f960587f86a3..aca352337c46 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -23,6 +23,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/spinlock.h>
 
+#include <linux/pm_runtime.h>
 #include <asm-generic/gpio.h>
 
 #define MAX_REGS_BANKS 5
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
+	struct davinci_gpio_regs __iomem *g = NULL;
+	struct davinci_gpio_regs *context = NULL;
+	u32 bank = 0;
+	void __iomem *base = NULL;
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
+	struct davinci_gpio_regs __iomem *g = NULL;
+	struct davinci_gpio_regs *context = NULL;
+	u32 bank = 0;
+	void __iomem *base = NULL;
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

