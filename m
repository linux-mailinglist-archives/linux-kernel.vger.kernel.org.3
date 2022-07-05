Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ADC566608
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiGEJ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiGEJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:26:49 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AE5CEA;
        Tue,  5 Jul 2022 02:26:48 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BA32C1A0AE9;
        Tue,  5 Jul 2022 11:26:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 57A301A08BC;
        Tue,  5 Jul 2022 11:26:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E9385180222D;
        Tue,  5 Jul 2022 17:26:43 +0800 (+08)
From:   haibo.chen@nxp.com
To:     ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        han.xu@nxp.com, singh.kuldeep87k@gmail.com,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com,
        zhengxunli@mxic.com.tw
Subject: [PATCH 01/11] spi: spi-nxp-fspi: enable runtime pm for fspi
Date:   Tue,  5 Jul 2022 17:11:33 +0800
Message-Id: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Enable the runtime PM in fspi driver.
Also for system PM, On some board like i.MX8ULP-EVK board,
after system suspend, IOMUX module will lost power, so all
the pinctrl setting will lost when system resume back, need
driver to save/restore the pinctrl setting.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 111 ++++++++++++++++++++++++++++++++-----
 1 file changed, 97 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 2b0301fc971c..b2cd8e06f374 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -49,6 +49,8 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/regmap.h>
 #include <linux/sizes.h>
@@ -58,6 +60,8 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
+/* runtime pm timeout */
+#define FSPI_RPM_TIMEOUT 50	/* 50ms */
 /*
  * The driver only uses one single LUT entry, that is updated on
  * each call of exec_op(). Index 0 is preset at boot with a basic
@@ -375,6 +379,8 @@ struct nxp_fspi {
 	struct mutex lock;
 	struct pm_qos_request pm_qos_req;
 	int selected;
+#define FSPI_INITILIZED		(1 << 0)
+	int flags;
 };
 
 static inline int needs_ip_only(struct nxp_fspi *f)
@@ -866,6 +872,12 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	mutex_lock(&f->lock);
 
+	err = pm_runtime_get_sync(f->dev);
+	if (err < 0) {
+		dev_err(f->dev, "Failed to enable clock %d\n", __LINE__);
+		goto err_mutex;
+	}
+
 	/* Wait for controller being ready. */
 	err = fspi_readl_poll_tout(f, f->iobase + FSPI_STS0,
 				   FSPI_STS0_ARB_IDLE, 1, POLL_TOUT, true);
@@ -894,8 +906,14 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	/* Invalidate the data in the AHB buffer. */
 	nxp_fspi_invalid(f);
 
+	pm_runtime_mark_last_busy(f->dev);
+	pm_runtime_put_autosuspend(f->dev);
+
 	mutex_unlock(&f->lock);
+	return err;
 
+err_mutex:
+	mutex_unlock(&f->lock);
 	return err;
 }
 
@@ -1141,12 +1159,17 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 			ret = PTR_ERR(f->clk);
 			goto err_put_ctrl;
 		}
+	}
 
-		ret = nxp_fspi_clk_prep_enable(f);
-		if (ret) {
-			dev_err(dev, "can not enable the clock\n");
-			goto err_put_ctrl;
-		}
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, FSPI_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+
+	/* enable clock */
+	ret = pm_runtime_get_sync(f->dev);
+	if (ret < 0) {
+		dev_err(f->dev, "Failed to enable clock %d\n", __LINE__);
+		goto err_put_ctrl;
 	}
 
 	/* Clear potential interrupts */
@@ -1180,13 +1203,19 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_destroy_mutex;
 
+	pm_runtime_mark_last_busy(f->dev);
+	pm_runtime_put_autosuspend(f->dev);
+
+	/* indicate the controller has been initialized */
+	f->flags |= FSPI_INITILIZED;
+
 	return 0;
 
 err_destroy_mutex:
 	mutex_destroy(&f->lock);
 
 err_disable_clk:
-	nxp_fspi_clk_disable_unprep(f);
+	pm_runtime_disable(dev);
 
 err_put_ctrl:
 	spi_controller_put(ctlr);
@@ -1212,20 +1241,79 @@ static int nxp_fspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int nxp_fspi_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int nxp_fspi_initialized(struct nxp_fspi *f)
+{
+	return f->flags & FSPI_INITILIZED;
+}
+
+static int nxp_fspi_need_reinit(struct nxp_fspi *f)
+{
+	/*
+	 * we always use the controller in combination mode, so we check
+	 * this register bit to determine if the controller once lost power,
+	 * such as suspend/resume, and need to be re-init.
+	 */
+
+	return !(readl(f->iobase + FSPI_MCR0) & FSPI_MCR0_OCTCOMB_EN);
+}
+
+static int nxp_fspi_runtime_suspend(struct device *dev)
 {
+	struct nxp_fspi *f = dev_get_drvdata(dev);
+
+	nxp_fspi_clk_disable_unprep(f);
+
 	return 0;
 }
 
-static int nxp_fspi_resume(struct device *dev)
+static int nxp_fspi_runtime_resume(struct device *dev)
 {
 	struct nxp_fspi *f = dev_get_drvdata(dev);
 
-	nxp_fspi_default_setup(f);
+	nxp_fspi_clk_prep_enable(f);
+
+	if (nxp_fspi_initialized(f) && nxp_fspi_need_reinit(f))
+		nxp_fspi_default_setup(f);
 
 	return 0;
 }
 
+static int nxp_fspi_suspend(struct device *dev)
+{
+	int ret;
+
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret) {
+		dev_err(dev, "select flexspi sleep pinctrl failed!\n");
+		return ret;
+	}
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int nxp_fspi_resume(struct device *dev)
+{
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		dev_err(dev, "select flexspi default pinctrl failed!\n");
+
+	return ret;
+}
+
+
+static const struct dev_pm_ops nxp_fspi_pm_ops = {
+	SET_RUNTIME_PM_OPS(nxp_fspi_runtime_suspend, nxp_fspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(nxp_fspi_suspend, nxp_fspi_resume)
+};
+#endif	/* CONFIG_PM */
+
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
@@ -1244,11 +1332,6 @@ static const struct acpi_device_id nxp_fspi_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, nxp_fspi_acpi_ids);
 #endif
 
-static const struct dev_pm_ops nxp_fspi_pm_ops = {
-	.suspend	= nxp_fspi_suspend,
-	.resume		= nxp_fspi_resume,
-};
-
 static struct platform_driver nxp_fspi_driver = {
 	.driver = {
 		.name	= "nxp-fspi",
-- 
2.25.1

