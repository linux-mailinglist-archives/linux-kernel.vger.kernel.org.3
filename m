Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C315863F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbiHAGRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiHAGRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:17:12 -0400
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B153BF7E;
        Sun, 31 Jul 2022 23:17:11 -0700 (PDT)
Received: from p54bc6cd6.dip0.t-ipconnect.de ([84.188.108.214] helo=[192.168.1.113]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oIOjl-0003nO-Py; Mon, 01 Aug 2022 08:17:09 +0200
Message-ID: <a436b3f9-8bdd-8999-b033-9b25c9b67d98@birger-koblitz.de>
Date:   Mon, 1 Aug 2022 08:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, Sander Vanheule <sander@svanheule.net>
From:   Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH 1/7] spi: realteak-rtl: Add support for RTL93xx SoCs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1659334631;3eec86fb;
X-HE-SMSGID: 1oIOjl-0003nO-Py
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek RTL930x and RTL931x SoCs are new generations of the
RTL838x and RTL839x Ethernet Router SoCs, providing only 2 instead
of 4 CS lines for SPI, however with quad IO capabilities instead of
merely dual IO.

We introduce device capability flags for the various SoCs stating
their number of CS lines and their multi-IO capabilities and add
compatibles for the RTL9300 and RTL9310 SoC families.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
  drivers/spi/spi-realtek-rtl.c | 16 +++++++++++-----
  1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
index 866b0477dbd7..927bd44744a8 100644
--- a/drivers/spi/spi-realtek-rtl.c
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -29,6 +29,9 @@ struct rtspi {

  #define REG(x)		(rtspi->base + x)

+/* SoC-specific features */
+#define SPI_CSMAX_3			0x1
+#define SPI_QUAD_SUPPORTED		0x2

  static void rt_set_cs(struct spi_device *spi, bool active)
  {
@@ -185,13 +188,16 @@ static int realtek_rtl_spi_probe(struct platform_device *pdev)


  static const struct of_device_id realtek_rtl_spi_of_ids[] = {
-	{ .compatible = "realtek,rtl8380-spi" },
-	{ .compatible = "realtek,rtl8382-spi" },
-	{ .compatible = "realtek,rtl8391-spi" },
-	{ .compatible = "realtek,rtl8392-spi" },
-	{ .compatible = "realtek,rtl8393-spi" },
+	{ .compatible = "realtek,rtl8380-spi", .data = (void *)SPI_CSMAX_3, },
+	{ .compatible = "realtek,rtl8382-spi", .data = (void *)SPI_CSMAX_3, },
+	{ .compatible = "realtek,rtl8391-spi", .data = (void *)SPI_CSMAX_3, },
+	{ .compatible = "realtek,rtl8392-spi", .data = (void *)SPI_CSMAX_3, },
+	{ .compatible = "realtek,rtl8393-spi", .data = (void *)SPI_CSMAX_3, },
+	{ .compatible = "realtek,rtl9300-spi", .data = (void *)SPI_QUAD_SUPPORTED, },
+	{ .compatible = "realtek,rtl9310-spi", .data = (void *)SPI_QUAD_SUPPORTED, },
  	{ /* sentinel */ }
  };
+
  MODULE_DEVICE_TABLE(of, realtek_rtl_spi_of_ids);

  static struct platform_driver realtek_rtl_spi_driver = {
-- 
2.25.1

