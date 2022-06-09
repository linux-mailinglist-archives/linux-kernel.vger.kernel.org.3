Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C654462F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbiFIIoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242373AbiFIIlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:41:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BEE381BE;
        Thu,  9 Jun 2022 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654764023; x=1686300023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jg1QYiymxreKsxc+YO5AbvU8CTlNLdTtmlxGp6mj7yU=;
  b=Mij6V1uI5igsKb1ePZgqEVq+n9aFvyAA5b2nUCMWA2DvZzlLAd0+TllZ
   WIvR3H8EnyuRKghNvtlPtExgB7j1ncy9L7HTZBNydk884DVAibm2UYzYt
   29dK8hz9IL0Mc0vfL8mHoQIejNl9nC7UbyIjw6Gt/uuDstLo7TJ11etoc
   /63a299z5cDdou8dGu8splMjdJSTrK71Ug228uQAURkmLKZY7GfFXgaCQ
   zQ9KTbNyvgcLMZDZfCOx1gP5G5zmt8NoGFIPwJW0pUahACxQqXsy+qFyf
   zoGU5G4PQy6Q9t+IRJKy03YuAD6EkkZBX7WJHrZ9XfBsayN1nfO+uUIsy
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="159542994"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:40:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:40:21 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:40:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <tudor.ambarus@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] spi: atmel-quadspi: add runtime pm support
Date:   Thu, 9 Jun 2022 11:42:44 +0300
Message-ID: <20220609084246.1795419-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220609084246.1795419-1-claudiu.beznea@microchip.com>
References: <20220609084246.1795419-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime PM support for atmel-quadspi which will disable/enable
QSPI clocks on proper runtime_suspend/runtime_resume ops.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 100 ++++++++++++++++++++++++++++++++----
 1 file changed, 91 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 480c0c8c18e4..6a9327f3c5b4 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spi/spi-mem.h>
 
 /* QSPI register offsets */
@@ -417,9 +418,13 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (op->addr.val + op->data.nbytes > aq->mmap_size)
 		return -ENOTSUPP;
 
+	err = pm_runtime_resume_and_get(&aq->pdev->dev);
+	if (err < 0)
+		return err;
+
 	err = atmel_qspi_set_cfg(aq, op, &offset);
 	if (err)
-		return err;
+		goto pm_runtime_put;
 
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
@@ -441,7 +446,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	/* Poll INSTRuction End status */
 	sr = atmel_qspi_read(aq, QSPI_SR);
 	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
-		return err;
+		goto pm_runtime_put;
 
 	/* Wait for INSTRuction End interrupt */
 	reinit_completion(&aq->cmd_completion);
@@ -452,6 +457,9 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		err = -ETIMEDOUT;
 	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IDR);
 
+pm_runtime_put:
+	pm_runtime_mark_last_busy(&aq->pdev->dev);
+	pm_runtime_put_autosuspend(&aq->pdev->dev);
 	return err;
 }
 
@@ -472,6 +480,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 	unsigned long src_rate;
 	u32 scbr;
+	int ret;
 
 	if (ctrl->busy)
 		return -EBUSY;
@@ -488,9 +497,16 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	if (scbr > 0)
 		scbr--;
 
+	ret = pm_runtime_resume_and_get(ctrl->dev.parent);
+	if (ret < 0)
+		return ret;
+
 	aq->scr = QSPI_SCR_SCBR(scbr);
 	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
+	pm_runtime_mark_last_busy(ctrl->dev.parent);
+	pm_runtime_put_autosuspend(ctrl->dev.parent);
+
 	return 0;
 }
 
@@ -621,11 +637,24 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	if (err)
 		goto disable_qspick;
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+
 	atmel_qspi_init(aq);
 
 	err = spi_register_controller(ctrl);
-	if (err)
+	if (err) {
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 		goto disable_qspick;
+	}
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
@@ -641,9 +670,18 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl = platform_get_drvdata(pdev);
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
+		return ret;
 
 	spi_unregister_controller(ctrl);
 	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
 	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
 	return 0;
@@ -653,10 +691,19 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
 
 	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
-	clk_disable_unprepare(aq->qspick);
-	clk_disable_unprepare(aq->pclk);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_force_suspend(dev);
+
+	clk_unprepare(aq->qspick);
+	clk_unprepare(aq->pclk);
 
 	return 0;
 }
@@ -665,19 +712,54 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+	int ret;
 
-	clk_prepare_enable(aq->pclk);
-	clk_prepare_enable(aq->qspick);
+	clk_prepare(aq->pclk);
+	clk_prepare(aq->qspick);
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret < 0)
+		return ret;
 
 	atmel_qspi_init(aq);
 
 	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static int __maybe_unused atmel_qspi_runtime_suspend(struct device *dev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+
+	clk_disable(aq->qspick);
+	clk_disable(aq->pclk);
+
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
-			 atmel_qspi_resume);
+static int __maybe_unused atmel_qspi_runtime_resume(struct device *dev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+	int ret;
+
+	ret = clk_enable(aq->pclk);
+	if (ret)
+		return ret;
+
+	return clk_enable(aq->qspick);
+}
+
+static const struct dev_pm_ops __maybe_unused atmel_qspi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(atmel_qspi_suspend, atmel_qspi_resume)
+	SET_RUNTIME_PM_OPS(atmel_qspi_runtime_suspend,
+			   atmel_qspi_runtime_resume, NULL)
+};
 
 static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps = {};
 
-- 
2.34.1

