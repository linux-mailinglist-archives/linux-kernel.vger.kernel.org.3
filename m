Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520F9502BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352510AbiDOOZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354531AbiDOOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:25:02 -0400
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6A942A18;
        Fri, 15 Apr 2022 07:22:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07693846|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00416793-0.000623925-0.995208;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.NRMqfU2_1650032538;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NRMqfU2_1650032538)
          by smtp.aliyun-inc.com(33.32.109.194);
          Fri, 15 Apr 2022 22:22:19 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        paul@crapouillou.net, contact@artur-rojek.eu,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH 1/3] SPI: Ingenic: Add support for use GPIO as chip select line.
Date:   Fri, 15 Apr 2022 22:22:06 +0800
Message-Id: <1650032528-118220-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650032528-118220-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1650032528-118220-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for using GPIOs as chip select lines on Ingenic SoCs.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/spi/spi-ingenic.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
index 03077a7..672e4ed 100644
--- a/drivers/spi/spi-ingenic.c
+++ b/drivers/spi/spi-ingenic.c
@@ -380,7 +380,7 @@ static int spi_ingenic_probe(struct platform_device *pdev)
 	struct spi_controller *ctlr;
 	struct ingenic_spi *priv;
 	void __iomem *base;
-	int ret;
+	int num_cs, ret;
 
 	pdata = of_device_get_match_data(dev);
 	if (!pdata) {
@@ -416,6 +416,11 @@ static int spi_ingenic_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->flen_field))
 		return PTR_ERR(priv->flen_field);
 
+	if (of_property_read_u32(dev->of_node, "num-cs", &num_cs)) {
+		dev_warn(dev, "Number of chip select lines not specified.\n");
+		num_cs = 2;
+	}
+
 	platform_set_drvdata(pdev, ctlr);
 
 	ctlr->prepare_transfer_hardware = spi_ingenic_prepare_hardware;
@@ -429,7 +434,9 @@ static int spi_ingenic_probe(struct platform_device *pdev)
 	ctlr->bits_per_word_mask = pdata->bits_per_word_mask;
 	ctlr->min_speed_hz = 7200;
 	ctlr->max_speed_hz = 54000000;
-	ctlr->num_chipselect = 2;
+	ctlr->use_gpio_descriptors = true;
+	ctlr->max_native_cs = 2;
+	ctlr->num_chipselect = num_cs;
 	ctlr->dev.of_node = pdev->dev.of_node;
 
 	if (spi_ingenic_request_dma(ctlr, dev))
-- 
2.7.4

