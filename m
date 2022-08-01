Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E495863F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbiHAGSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiHAGSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:18:13 -0400
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9FBF7E;
        Sun, 31 Jul 2022 23:18:11 -0700 (PDT)
Received: from p54bc6cd6.dip0.t-ipconnect.de ([84.188.108.214] helo=[192.168.1.113]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oIOkk-0004BO-46; Mon, 01 Aug 2022 08:18:10 +0200
Message-ID: <4d10e375-7342-6c1b-9886-e49974b1620b@birger-koblitz.de>
Date:   Mon, 1 Aug 2022 08:18:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, sander@svanheule.net
From:   Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH 2/7] spi: realtek-rtl: set device capability flags
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1659334692;cb8995e6;
X-HE-SMSGID: 1oIOkk-0004BO-46
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read out the number of chip selects supported by the SoC and
whether the device supports Quad-IO and set the spi_controller
flags accordingly.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
  drivers/spi/spi-realtek-rtl.c | 7 +++++++
  1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
index 927bd44744a8..287ecc34e1cc 100644
--- a/drivers/spi/spi-realtek-rtl.c
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -4,9 +4,11 @@
  #include <linux/platform_device.h>
  #include <linux/mod_devicetable.h>
  #include <linux/spi/spi.h>
+#include <linux/property.h>

  struct rtspi {
  	void __iomem *base;
+	u32 dev_flags;
  };

  /* SPI Flash Configuration Register */
@@ -163,6 +165,7 @@ static int realtek_rtl_spi_probe(struct platform_device *pdev)
  	}
  	platform_set_drvdata(pdev, ctrl);
  	rtspi = spi_controller_get_devdata(ctrl);
+	rtspi->dev_flags = (u32) device_get_match_data(&pdev->dev);

  	rtspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
  	if (IS_ERR(rtspi->base)) {
@@ -174,8 +177,12 @@ static int realtek_rtl_spi_probe(struct platform_device *pdev)

  	ctrl->dev.of_node = pdev->dev.of_node;
  	ctrl->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	ctrl->flags |= SPI_TX_DUAL | SPI_RX_DUAL;
+	if (rtspi->dev_flags & SPI_QUAD_SUPPORTED)
+		ctrl->flags |= SPI_TX_QUAD | SPI_RX_QUAD;
  	ctrl->set_cs = rt_set_cs;
  	ctrl->transfer_one = transfer_one;
+	ctrl->num_chipselect = rtspi->dev_flags & SPI_CSMAX_3?4:2;

  	err = devm_spi_register_controller(&pdev->dev, ctrl);
  	if (err) {
-- 
2.25.1

