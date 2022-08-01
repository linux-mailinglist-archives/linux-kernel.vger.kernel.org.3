Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B95586403
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbiHAGVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiHAGVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:21:51 -0400
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813A13FB4;
        Sun, 31 Jul 2022 23:21:50 -0700 (PDT)
Received: from p54bc6cd6.dip0.t-ipconnect.de ([84.188.108.214] helo=[192.168.1.113]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oIOoH-0006Bs-11; Mon, 01 Aug 2022 08:21:49 +0200
Message-ID: <e5cd2b5b-3ca5-b135-d34c-0fb7af3d8480@birger-koblitz.de>
Date:   Mon, 1 Aug 2022 08:21:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, sander@svanheule.net
From:   Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH 6/7] spi: realtek-rtl: add support to configure bus speed
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1659334910;3afd5195;
X-HE-SMSGID: 1oIOoH-0006Bs-11
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The available datasheets for the RTL8381M and RTL9301 state
that the SPI frequency is 50MHz. Set this maximum spi frequency
unless specified otherwise in the device node.

The SPI device on the RTL83xx and RTL93xx SoCs is also accessed
independently by dedicated SPI-NOR (RTL83xx/RTL93xx) and
SPI-NAND (RTL93xx) hardware, which can perform DMA transfers via
the SPI device.
While these devices can set chip selects, they cannot configure
the SPI frequency for a transfer. The clock divider is therefore
configured once during device probe and not changed for individual
transfers as the SPI frequency is a bus property on this platform.

The clock divider setting can take values 0-7, the actual divider
then is:
clock_divider = 2 * (divider_setting + 1)
allowing for clock dividers with values 2-16. The clock used to
derive the SPI clock on the Realtek SoCs is the Lexra bus clock.
When a clock is provided in the SPI device node, we set a clock
divider corresponding to the maximum spi frequency.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
  drivers/spi/spi-realtek-rtl.c | 28 +++++++++++++++++++++++++++-
  1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
index 21c0dc16c8cc..91aa7a0348a2 100644
--- a/drivers/spi/spi-realtek-rtl.c
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -5,15 +5,21 @@
  #include <linux/mod_devicetable.h>
  #include <linux/spi/spi.h>
  #include <linux/property.h>
+#include <linux/of.h>
+#include <linux/clk.h>

  struct rtspi {
  	void __iomem *base;
  	u32 dev_flags;
  	u32 cs_all;
+	struct clk *clk;
+	int frequency_div;
  };

  /* SPI Flash Configuration Register */
  #define RTL_SPI_SFCR			0x00
+#define RTL_SPI_SFCR_CLK_DIV_BIT	29
+#define RTL_SPI_SFCR_CLK_DIV_MASK	~(0x7 << RTL_SPI_SFCR_CLK_DIV_BIT)
  #define RTL_SPI_SFCR_RBO		BIT(28)
  #define RTL_SPI_SFCR_WBO		BIT(27)

@@ -208,9 +214,14 @@ static void init_hw(struct rtspi *rtspi)
  {
  	u32 value;

-	/* Turn on big-endian byte ordering */
+	/* Turn on big-endian byte ordering and set clock divider */
  	value = readl(REG(RTL_SPI_SFCR));
  	value |= RTL_SPI_SFCR_RBO | RTL_SPI_SFCR_WBO;
+	if (rtspi->frequency_div >= 0) {
+		value &= RTL_SPI_SFCR_CLK_DIV_MASK;
+		value |= rtspi->frequency_div << RTL_SPI_SFCR_CLK_DIV_BIT;
+	}
+
  	writel(value, REG(RTL_SPI_SFCR));

  	/* Disable CS0-CS3, enable CS */
@@ -222,6 +233,7 @@ static int realtek_rtl_spi_probe(struct platform_device *pdev)
  {
  	struct spi_controller *ctrl;
  	struct rtspi *rtspi;
+	u32 spi_clk;
  	int err;

  	ctrl = devm_spi_alloc_master(&pdev->dev, sizeof(*rtspi));
@@ -239,6 +251,20 @@ static int realtek_rtl_spi_probe(struct platform_device *pdev)
  		return -ENOMEM;
  	}

+	if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
+				 &ctrl->max_speed_hz))
+		ctrl->max_speed_hz = 50000000; /* 50MHz */
+
+	rtspi->frequency_div = -1;
+	rtspi->clk = devm_clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(rtspi->clk)) {
+		spi_clk = clk_get_rate(rtspi->clk);
+		rtspi->frequency_div = DIV_ROUND_UP(spi_clk, ctrl->max_speed_hz);
+		rtspi->frequency_div = (rtspi->frequency_div / 2) - 1;
+		if (rtspi->frequency_div > 0x7)
+			rtspi->frequency_div = 0x7;
+	}
+
  	init_hw(rtspi);

  	ctrl->dev.of_node = pdev->dev.of_node;
-- 
2.25.1

