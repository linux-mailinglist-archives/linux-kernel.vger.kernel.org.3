Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF42520409
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbiEISBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbiEISBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:01:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D2C1F7E35;
        Mon,  9 May 2022 10:57:38 -0700 (PDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4KxpmK07cmz4xcY;
        Tue, 10 May 2022 03:57:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxpmC2sCwz4xVP;
        Tue, 10 May 2022 03:57:31 +1000 (AEST)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v7 11/11] mtd: spi-nor: aspeed: set the decoding size to at least 2MB for AST2600
Date:   Mon,  9 May 2022 19:56:16 +0200
Message-Id: <20220509175616.1089346-12-clg@kaod.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509175616.1089346-1-clg@kaod.org>
References: <20220509175616.1089346-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Potin Lai <potin.lai@quantatw.com>

In AST2600, the unit of SPI CEx decoding range register is 1MB, and end
address offset is set to the acctual offset - 1MB. If the flash only has
1MB, the end address will has same value as start address, which will
causing unexpected errors.

This patch set the decoding size to at least 2MB to avoid decoding errors.

Tested:
root@bletchley:~# dmesg | grep "aspeed-smc 1e631000.spi: CE0 window"
[   59.328134] aspeed-smc 1e631000.spi: CE0 window resized to 2MB (AST2600 Decoding)
[   59.343001] aspeed-smc 1e631000.spi: CE0 window [ 0x50000000 - 0x50200000 ] 2MB
root@bletchley:~# devmem 0x1e631030
0x00100000

Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: Potin Lai <potin.lai@quantatw.com>
[ clg : Ported on new spi-mem driver ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 35f6934847b7..496f3e1e9079 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -474,6 +474,8 @@ static int aspeed_spi_set_window(struct aspeed_spi *aspi,
  *   is correct.
  */
 static const struct aspeed_spi_data ast2500_spi_data;
+static const struct aspeed_spi_data ast2600_spi_data;
+static const struct aspeed_spi_data ast2600_fmc_data;
 
 static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
 					 u32 local_offset, u32 size)
@@ -497,6 +499,17 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
 			 chip->cs, size >> 20);
 	}
 
+	/*
+	 * The decoding size of AST2600 SPI controller should set at
+	 * least 2MB.
+	 */
+	if ((aspi->data == &ast2600_spi_data || aspi->data == &ast2600_fmc_data) &&
+	    size < SZ_2M) {
+		size = SZ_2M;
+		dev_info(aspi->dev, "CE%d window resized to %dMB (AST2600 Decoding)",
+			 chip->cs, size >> 20);
+	}
+
 	aspeed_spi_get_windows(aspi, windows);
 
 	/* Adjust this chip window */
-- 
2.35.1

