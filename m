Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEC2572B71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiGMCsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiGMCsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:48:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E755D4BD6;
        Tue, 12 Jul 2022 19:48:00 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LjMQR5502zVfn4;
        Wed, 13 Jul 2022 10:44:15 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 10:47:35 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Jul
 2022 10:47:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <broonie@kernel.org>
Subject: [PATCH -next v2 3/3] spi: microchip-core: switch to use dev_err_probe()
Date:   Wed, 13 Jul 2022 10:56:57 +0800
Message-ID: <20220713025657.3524506-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713025657.3524506-1-yangyingliang@huawei.com>
References: <20220713025657.3524506-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use dev_err_probe() to simpify error path.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-microchip-core.c | 42 +++++++++++++-------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 1a24e47f8305..ce4385330b19 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -539,48 +539,40 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 		return PTR_ERR(spi->regs);
 
 	spi->irq = platform_get_irq(pdev, 0);
-	if (spi->irq <= 0) {
-		dev_err(&pdev->dev, "invalid IRQ %d for SPI controller\n", spi->irq);
-		return -ENXIO;
-	}
+	if (spi->irq <= 0)
+		return dev_err_probe(&pdev->dev, -ENXIO,
+				     "invalid IRQ %d for SPI controller\n",
+				     spi->irq);
 
 	ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
 			       IRQF_SHARED, dev_name(&pdev->dev), master);
-	if (ret) {
-		dev_err(&pdev->dev, "could not request irq: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not request irq: %d\n", ret);
 
 	spi->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(spi->clk)) {
-		dev_err(&pdev->dev, "could not get clk: %d\n", ret);
-		return PTR_ERR(spi->clk);
-	}
+	if (IS_ERR(spi->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(spi->clk),
+				     "could not get clk: %d\n", ret);
 
 	ret = clk_prepare_enable(spi->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to enable clock\n");
 
 	mchp_corespi_init(master, spi);
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"unable to register master for SPI controller\n");
-		goto error_release_hardware;
+		mchp_corespi_disable(spi);
+		clk_disable_unprepare(spi->clk);
+		return dev_err_probe(&pdev->dev, ret,
+				     "unable to register master for SPI controller\n");
 	}
 
 	dev_info(&pdev->dev, "Registered SPI controller %d\n", master->bus_num);
 
 	return 0;
-
-error_release_hardware:
-	mchp_corespi_disable(spi);
-	clk_disable_unprepare(spi->clk);
-
-	return ret;
 }
 
 static int mchp_corespi_remove(struct platform_device *pdev)
-- 
2.25.1

