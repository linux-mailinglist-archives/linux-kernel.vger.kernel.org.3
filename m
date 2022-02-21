Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DFC4BDF37
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357481AbiBUMKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:10:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357323AbiBUMIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:08:51 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E7201AC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:28 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0226422175;
        Mon, 21 Feb 2022 13:08:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645445307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXOPL5cPITB5pX8C9uT9seIIQT64+6BMqwNdfPuDNQU=;
        b=A5RFjC4eo4vKA9GBsk18cxsudbn2bZYuPC+WGiVcojDgTLLeaDa/aUZ/y0IessM4bYkPeE
        iUrZr1JwuZihrn1YIdx2/dyw/E62JQIPjeexx1MzBNej/i/ThYf26/JwcFmUD2ga+5kCQs
        CTWl4DsjU2UUv5dE0IuTrdcHeiw+S14=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v4 18/32] mtd: spi-nor: allow a flash to define its own ready() function
Date:   Mon, 21 Feb 2022 13:07:55 +0100
Message-Id: <20220221120809.1531502-19-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221120809.1531502-1-michael@walle.cc>
References: <20220221120809.1531502-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx and Micron flashes have their own implementation of the
spi_nor_ready() function. At the moment, the core will figure out
which one to call according to some flags. Lay the foundation to
make it possible that a flash can register its own ready()
function.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 4 ++++
 drivers/mtd/spi-nor/core.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4d2036cdce42..390a9ab413b7 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -794,6 +794,10 @@ static int spi_nor_ready(struct spi_nor *nor)
 {
 	int sr, fsr;
 
+	/* Flashes might override the standard routine. */
+	if (nor->params->ready)
+		return nor->params->ready(nor);
+
 	if (nor->flags & SNOR_F_READY_XSR_RDY)
 		sr = spi_nor_xsr_ready(nor);
 	else
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 4fe16b5aa3f5..fdc8c0f31f5c 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -261,6 +261,9 @@ struct spi_nor_otp {
  *			SPI NOR flashes that have peculiarities to the SPI NOR
  *			standard e.g. different opcodes, specific address
  *			calculation, page size, etc.
+ * @ready:		(optional) flashes might use a different mechanism
+ *			than reading the status register to indicate they
+ *			are ready for a new command
  * @locking_ops:	SPI NOR locking methods.
  */
 struct spi_nor_flash_parameter {
@@ -282,6 +285,7 @@ struct spi_nor_flash_parameter {
 	int (*set_4byte_addr_mode)(struct spi_nor *nor, bool enable);
 	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
 	int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
+	int (*ready)(struct spi_nor *nor);
 
 	const struct spi_nor_locking_ops *locking_ops;
 };
-- 
2.30.2

