Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F25F5863FB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbiHAGUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbiHAGUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:20:02 -0400
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CA513FA8;
        Sun, 31 Jul 2022 23:19:59 -0700 (PDT)
Received: from p54bc6cd6.dip0.t-ipconnect.de ([84.188.108.214] helo=[192.168.1.113]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oIOmU-00051u-26; Mon, 01 Aug 2022 08:19:58 +0200
Message-ID: <a9568128-172a-6693-c059-7b2be2cafb97@birger-koblitz.de>
Date:   Mon, 1 Aug 2022 08:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, sander@svanheule.net
From:   Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH 4/7] spi: realtek-rtl: add parallel IO suppport
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1659334800;60fd91a7;
X-HE-SMSGID: 1oIOmU-00051u-26
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek SoCs are capable of dual and/or quad IO.
Add a function to enable this functionality.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
  drivers/spi/spi-realtek-rtl.c | 22 ++++++++++++++++++++++
  1 file changed, 22 insertions(+)

diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
index 5979233522f4..25a90493bf6e 100644
--- a/drivers/spi/spi-realtek-rtl.c
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -25,6 +25,9 @@ struct rtspi {
  #define RTL_SPI_SFCSR_CSB3		BIT(14)
  #define RTL_SPI_SFCSR_RDY		BIT(27)
  #define RTL_SPI_SFCSR_CS		BIT(24)
+#define RTL_SPI_SFCSR_WIDTH_MASK	~(0x03 << 25)
+#define RTL_SPI_SFCSR_WIDTH_DUAL	(0x01 << 25)
+#define RTL_SPI_SFCSR_WIDTH_QUAD	(0x02 << 25)
  #define RTL_SPI_SFCSR_LEN_MASK		~(0x03 << 28)
  #define RTL_SPI_SFCSR_LEN1		(0x00 << 28)
  #define RTL_SPI_SFCSR_LEN4		(0x03 << 28)
@@ -118,6 +121,25 @@ static void rcv1(struct rtspi *rtspi, u8 *buf)
  	*buf = readl(REG(RTL_SPI_SFDR)) >> 24;
  }

+static void set_mode(struct rtspi *rtspi, unsigned int mode)
+{
+	u32 value;
+
+	value = readl(REG(RTL_SPI_SFCSR));
+	value &= RTL_SPI_SFCSR_WIDTH_MASK;
+	switch (mode) {
+	case SPI_NBITS_QUAD:
+		value |= RTL_SPI_SFCSR_WIDTH_QUAD;
+		break;
+	case SPI_NBITS_DUAL:
+		value |= RTL_SPI_SFCSR_WIDTH_DUAL;
+		break;
+	default:
+		break;
+	}
+	writel(value, REG(RTL_SPI_SFCSR));
+}
+
  static int transfer_one(struct spi_controller *ctrl, struct spi_device *spi,
  			struct spi_transfer *xfer)
  {
-- 
2.25.1

