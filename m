Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C654BB850
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiBRLib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:38:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiBRLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:36:45 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEE32B1A82
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:36:24 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A336F22464;
        Fri, 18 Feb 2022 12:36:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645184179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FPwyUqw9bIye7MTeMw3+l2+GgFM/jhis7VAg9kKcJLA=;
        b=NdIFY1SGhV7/QHm0YYYlEYKStd9HQqm5kPFHGSqFeHrHITc1FJbs36XKePRZFgz7/N0b0W
        y4jsjfaahFhT7QeEeVNEc25YzWt/s0IYNqjThwRAD9LczXh/LMPQgEW4sBLttwp1uNgq7v
        lKv+esYpPk9oUsP5l+yb3PkJTTq2GMI=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 17/32] mtd: spi-nor: slightly refactor the spi_nor_setup()
Date:   Fri, 18 Feb 2022 12:35:52 +0100
Message-Id: <20220218113607.1360020-18-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218113607.1360020-1-michael@walle.cc>
References: <20220218113607.1360020-1-michael@walle.cc>
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

Instead of always using a function pointer (and initializing it to our
default), just call the default function if the flash didn't set its own
one. That will make the call flow easier to follow.

Also mark the parameter as optional now.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 10 +++++-----
 drivers/mtd/spi-nor/core.h |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 04ea180118e3..4d2036cdce42 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2532,11 +2532,12 @@ static int spi_nor_setup(struct spi_nor *nor,
 {
 	int ret;
 
-	if (nor->params->setup) {
+	if (nor->params->setup)
 		ret = nor->params->setup(nor, hwcaps);
-		if (ret)
-			return ret;
-	}
+	else
+		ret = spi_nor_default_setup(nor, hwcaps);
+	if (ret)
+		return ret;
 
 	return spi_nor_set_addr_width(nor);
 }
@@ -2786,7 +2787,6 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 
 	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
 	params->set_4byte_addr_mode = spansion_set_4byte_addr_mode;
-	params->setup = spi_nor_default_setup;
 	params->otp.org = &info->otp_org;
 
 	/* Default to 16-bit Write Status (01h) Command */
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 2afb610853a9..4fe16b5aa3f5 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -257,10 +257,10 @@ struct spi_nor_otp {
  * @convert_addr:	converts an absolute address into something the flash
  *                      will understand. Particularly useful when pagesize is
  *                      not a power-of-2.
- * @setup:              configures the SPI NOR memory. Useful for SPI NOR
- *                      flashes that have peculiarities to the SPI NOR standard
- *                      e.g. different opcodes, specific address calculation,
- *                      page size, etc.
+ * @setup:		(optional) configures the SPI NOR memory. Useful for
+ *			SPI NOR flashes that have peculiarities to the SPI NOR
+ *			standard e.g. different opcodes, specific address
+ *			calculation, page size, etc.
  * @locking_ops:	SPI NOR locking methods.
  */
 struct spi_nor_flash_parameter {
-- 
2.30.2

