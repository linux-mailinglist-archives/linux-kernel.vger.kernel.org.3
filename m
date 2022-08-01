Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9894586417
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbiHAGcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiHAGc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:32:28 -0400
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7649CE017;
        Sun, 31 Jul 2022 23:32:27 -0700 (PDT)
Received: from p54bc6cd6.dip0.t-ipconnect.de ([84.188.108.214] helo=[192.168.1.113]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oIOyX-0003Ki-WD; Mon, 01 Aug 2022 08:32:26 +0200
Message-ID: <e1537145-274d-6e9d-c6bd-d0228852b17a@birger-koblitz.de>
Date:   Mon, 1 Aug 2022 08:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, sander@svanheule.net
From:   Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH 3/7] spi: realtek-rtl: allow use of chip-select other than CS0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1659335547;5dadb7f0;
X-HE-SMSGID: 1oIOyX-0003Ki-WD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTL838x and RTL839x SoCs have 4 chip selects, the RTL93xx
SoCs 2. Configure the CS for a given transfer.
The logic of the RTL_SPI_SFCSR_CSBx bits is that if the value
of the bit is 0, then the corresponding CS line is pulled low,
which activates/selects the chip.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
  drivers/spi/spi-realtek-rtl.c | 39 ++++++++++++++++++++++++++++-------
  1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
index 287ecc34e1cc..5979233522f4 100644
--- a/drivers/spi/spi-realtek-rtl.c
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -9,6 +9,7 @@
  struct rtspi {
  	void __iomem *base;
  	u32 dev_flags;
+	u32 cs_all;
  };

  /* SPI Flash Configuration Register */
@@ -20,6 +21,8 @@ struct rtspi {
  #define RTL_SPI_SFCSR			0x08
  #define RTL_SPI_SFCSR_CSB0		BIT(31)
  #define RTL_SPI_SFCSR_CSB1		BIT(30)
+#define RTL_SPI_SFCSR_CSB2		BIT(15)
+#define RTL_SPI_SFCSR_CSB3		BIT(14)
  #define RTL_SPI_SFCSR_RDY		BIT(27)
  #define RTL_SPI_SFCSR_CS		BIT(24)
  #define RTL_SPI_SFCSR_LEN_MASK		~(0x03 << 28)
@@ -38,14 +41,34 @@ struct rtspi {
  static void rt_set_cs(struct spi_device *spi, bool active)
  {
  	struct rtspi *rtspi = spi_controller_get_devdata(spi->controller);
+	int cs = spi->chip_select;
  	u32 value;
+	u32 cs_mask;

-	/* CS0 bit is active low */
  	value = readl(REG(RTL_SPI_SFCSR));
+	value |= rtspi->cs_all | RTL_SPI_SFCSR_CS;
+
+	switch (cs) {
+	case 0:
+		cs_mask = RTL_SPI_SFCSR_CSB0;
+		break;
+	case 1:
+		cs_mask = RTL_SPI_SFCSR_CSB1;
+		break;
+	case 2:
+		cs_mask = RTL_SPI_SFCSR_CSB2;
+		break;
+	case 3:
+		cs_mask = RTL_SPI_SFCSR_CSB3;
+		break;
+	}
+
+	/* CS bits are active low */
  	if (active)
-		value |= RTL_SPI_SFCSR_CSB0;
+		value |= cs_mask;
  	else
-		value &= ~RTL_SPI_SFCSR_CSB0;
+		value &= ~cs_mask;
+
  	writel(value, REG(RTL_SPI_SFCSR));
  }

@@ -144,11 +167,8 @@ static void init_hw(struct rtspi *rtspi)
  	value |= RTL_SPI_SFCR_RBO | RTL_SPI_SFCR_WBO;
  	writel(value, REG(RTL_SPI_SFCR));

-	value = readl(REG(RTL_SPI_SFCSR));
-	/* Permanently disable CS1, since it's never used */
-	value |= RTL_SPI_SFCSR_CSB1;
-	/* Select CS0 for use */
-	value &= RTL_SPI_SFCSR_CS;
+	/* Disable CS0-CS3, enable CS */
+	value = rtspi->cs_all | RTL_SPI_SFCSR_CS;
  	writel(value, REG(RTL_SPI_SFCSR));
  }

@@ -183,6 +203,9 @@ static int realtek_rtl_spi_probe(struct platform_device *pdev)
  	ctrl->set_cs = rt_set_cs;
  	ctrl->transfer_one = transfer_one;
  	ctrl->num_chipselect = rtspi->dev_flags & SPI_CSMAX_3?4:2;
+	rtspi->cs_all = RTL_SPI_SFCSR_CSB0 | RTL_SPI_SFCSR_CSB1;
+	if (rtspi->dev_flags & SPI_CSMAX_3)
+		rtspi->cs_all |= RTL_SPI_SFCSR_CSB2 | RTL_SPI_SFCSR_CSB3;

  	err = devm_spi_register_controller(&pdev->dev, ctrl);
  	if (err) {
-- 
2.25.1

