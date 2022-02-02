Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A8A4A7421
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345336AbiBBO7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:59:10 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:34049 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiBBO7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:59:03 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C0243223EF;
        Wed,  2 Feb 2022 15:59:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643813942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2iTA2jTJkIDM2vZHO2WWE0aewRctWW+RyrRZGyus5CU=;
        b=reHPc19WqarNxL1kXBBxXMfO9y88dz2TiXs0rt5DMooj3A2jv9PKBzPYd/Wj9r4kW8/9co
        yG36ff0nJiEOf0X9P2OXZGVf1yX59XBEasAsdrpQG0jpYPTwwmwCGWyfpTsgajwODG3v8y
        WZBNZnjzORrHH0e63oWGH6FJDnriQck=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 03/14] mtd: spi-nor: allow a flash to define its own ready() function
Date:   Wed,  2 Feb 2022 15:58:42 +0100
Message-Id: <20220202145853.4187726-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202145853.4187726-1-michael@walle.cc>
References: <20220202145853.4187726-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx and Micron flashes have their own implementation of the
spi_nor_ready() function. At the moment, the core will figure out
which one to call according to some flags. Lay the foundation to
make it possible that a flash can register its own ready()
function.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c | 4 ++++
 drivers/mtd/spi-nor/core.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index c8cc906cf771..c181f2680df2 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -794,6 +794,10 @@ static int spi_nor_ready(struct spi_nor *nor)
 {
 	int sr, fsr;
 
+	/* flashes might override our standard routine */
+	if (nor->params->ready)
+		return nor->params->ready(nor);
+
 	if (nor->flags & SNOR_F_READY_XSR_RDY)
 		sr = spi_nor_xsr_ready(nor);
 	else
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 10f478547dc2..446218b0e017 100644
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

