Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF79571B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiGLNoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiGLNof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:44:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24BE20BDD;
        Tue, 12 Jul 2022 06:44:33 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lj24x2bHRzlVr3;
        Tue, 12 Jul 2022 21:42:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 21:44:31 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Jul
 2022 21:44:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <broonie@kernel.org>
Subject: [PATCH -next 2/2] spi: microchip-core: switch to use devm_spi_alloc_master()
Date:   Tue, 12 Jul 2022 21:53:57 +0800
Message-ID: <20220712135357.918997-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712135357.918997-1-yangyingliang@huawei.com>
References: <20220712135357.918997-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Switch to use devm_spi_alloc_master() to simpify error path.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-microchip-core.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index c26767343176..1a24e47f8305 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -513,7 +513,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	u32 num_cs;
 	int ret = 0;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*spi));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(*spi));
 	if (!master)
 		return dev_err_probe(&pdev->dev, -ENOMEM,
 				     "unable to allocate master for SPI controller\n");
@@ -535,36 +535,32 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	spi = spi_master_get_devdata(master);
 
 	spi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(spi->regs)) {
-		ret = PTR_ERR(spi->regs);
-		goto error_release_master;
-	}
+	if (IS_ERR(spi->regs))
+		return PTR_ERR(spi->regs);
 
 	spi->irq = platform_get_irq(pdev, 0);
 	if (spi->irq <= 0) {
 		dev_err(&pdev->dev, "invalid IRQ %d for SPI controller\n", spi->irq);
-		ret = -ENXIO;
-		goto error_release_master;
+		return -ENXIO;
 	}
 
 	ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
 			       IRQF_SHARED, dev_name(&pdev->dev), master);
 	if (ret) {
 		dev_err(&pdev->dev, "could not request irq: %d\n", ret);
-		goto error_release_master;
+		return ret;
 	}
 
 	spi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
-		ret = PTR_ERR(spi->clk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", ret);
-		goto error_release_master;
+		return PTR_ERR(spi->clk);
 	}
 
 	ret = clk_prepare_enable(spi->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto error_release_master;
+		return ret;
 	}
 
 	mchp_corespi_init(master, spi);
@@ -583,8 +579,6 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 error_release_hardware:
 	mchp_corespi_disable(spi);
 	clk_disable_unprepare(spi->clk);
-error_release_master:
-	spi_master_put(master);
 
 	return ret;
 }
-- 
2.25.1

