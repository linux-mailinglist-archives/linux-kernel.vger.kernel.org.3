Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C9F4BE3DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357712AbiBUMLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:11:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357333AbiBUMIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:08:55 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37376205C1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:31 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9ABC02247C;
        Mon, 21 Feb 2022 13:08:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645445309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CHaJ1Kn9aqC7sMskqgvZF6XdFCXYYKaOSB+d24RXhTQ=;
        b=asgYEsGn40VsutVgM7g5KqJTNW+7Vv+GdkQYG+YLkKFmpAcEKn0v+JoNrCI0Bb6doa5rR6
        cgHyiA1BRY4Xno8cTSx92k3I/overFY5S0Hdq/dhPSjvUgHKkHl1t7o9KfnBrnb55Gg/Dx
        zidYenizFsL+ml7llhUMH+VCdjtvDWY=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v4 25/32] mtd: spi-nor: micron-st: convert USE_FSR to a manufacturer flag
Date:   Mon, 21 Feb 2022 13:08:02 +0100
Message-Id: <20220221120809.1531502-26-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221120809.1531502-1-michael@walle.cc>
References: <20220221120809.1531502-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all functions using that flag are local to the micron module,
we can convert the flag to a manufacturer one.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c      |  3 --
 drivers/mtd/spi-nor/core.h      |  3 --
 drivers/mtd/spi-nor/micron-st.c | 93 +++++++++++++++++++++------------
 3 files changed, 60 insertions(+), 39 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 5b56d718692b..ac0faedebafe 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2499,9 +2499,6 @@ static void spi_nor_init_flags(struct spi_nor *nor)
 
 	if (flags & USE_CLSR)
 		nor->flags |= SNOR_F_USE_CLSR;
-
-	if (flags & USE_FSR)
-		nor->flags |= SNOR_F_USE_FSR;
 }
 
 /**
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index fabc01ae9a81..a02bf54289fb 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -12,7 +12,6 @@
 #define SPI_NOR_MAX_ID_LEN	6
 
 enum spi_nor_option_flags {
-	SNOR_F_USE_FSR		= BIT(0),
 	SNOR_F_HAS_SR_TB	= BIT(1),
 	SNOR_F_NO_OP_CHIP_ERASE	= BIT(2),
 	SNOR_F_USE_CLSR		= BIT(4),
@@ -349,7 +348,6 @@ struct spi_nor_fixups {
  *   NO_CHIP_ERASE:           chip does not support chip erase.
  *   SPI_NOR_NO_FR:           can't do fastread.
  *   USE_CLSR:                use CLSR command.
- *   USE_FSR:                 use flag status register
  *
  * @no_sfdp_flags:  flags that indicate support that can be discovered via SFDP.
  *                  Used when SFDP tables are not defined in the flash. These
@@ -401,7 +399,6 @@ struct flash_info {
 #define NO_CHIP_ERASE			BIT(7)
 #define SPI_NOR_NO_FR			BIT(8)
 #define USE_CLSR			BIT(9)
-#define USE_FSR				BIT(10)
 
 	u8 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 8877b122cf42..f693f8720541 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -8,6 +8,9 @@
 
 #include "core.h"
 
+/* flash_info mfr_flag. Used to read proprietary FSR register. */
+#define USE_FSR		BIT(0)
+
 #define SPINOR_OP_RDFSR		0x70	/* Read flag status register */
 #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
 #define SPINOR_OP_MT_DTR_RD	0xfd	/* Fast Read opcode in DTR mode */
@@ -140,15 +143,17 @@ static const struct spi_nor_fixups mt35xu512aba_fixups = {
 
 static const struct flash_info micron_nor_parts[] = {
 	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512)
-		FLAGS(USE_FSR)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_READ |
 			   SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE)
-		.fixups = &mt35xu512aba_fixups},
+		MFR_FLAGS(USE_FSR)
+		.fixups = &mt35xu512aba_fixups
+	},
 	{ "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048)
-		FLAGS(USE_FSR)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		MFR_FLAGS(USE_FSR)
+	},
 };
 
 static const struct flash_info st_nor_parts[] = {
@@ -164,57 +169,79 @@ static const struct flash_info st_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-		      SPI_NOR_BP3_SR_BIT6 | USE_FSR)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
+		      SPI_NOR_BP3_SR_BIT6)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-		      SPI_NOR_BP3_SR_BIT6 | USE_FSR)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
+		      SPI_NOR_BP3_SR_BIT6)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "mt25ql256a",  INFO6(0x20ba19, 0x104400, 64 * 1024,  512)
-		FLAGS(USE_FSR)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512)
-		FLAGS(USE_FSR)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+			      SPI_NOR_QUAD_READ)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512)
-		FLAGS(USE_FSR)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512)
-		FLAGS(USE_FSR)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "mt25ql512a",  INFO6(0x20ba20, 0x104400, 64 * 1024, 1024)
-		FLAGS(USE_FSR)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-		      SPI_NOR_BP3_SR_BIT6 | USE_FSR)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
+		      SPI_NOR_BP3_SR_BIT6)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "mt25qu512a",  INFO6(0x20bb20, 0x104400, 64 * 1024, 1024)
-		FLAGS(USE_FSR)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-		      SPI_NOR_BP3_SR_BIT6 | USE_FSR)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
+		      SPI_NOR_BP3_SR_BIT6)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-		      SPI_NOR_BP3_SR_BIT6 | NO_CHIP_ERASE | USE_FSR)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
+		      SPI_NOR_BP3_SR_BIT6 | NO_CHIP_ERASE)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048)
-		FLAGS(NO_CHIP_ERASE | USE_FSR)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
+		FLAGS(NO_CHIP_ERASE)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096)
-		FLAGS(NO_CHIP_ERASE | USE_FSR)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
+		FLAGS(NO_CHIP_ERASE)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096)
-		FLAGS(NO_CHIP_ERASE | USE_FSR)
+		FLAGS(NO_CHIP_ERASE)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+			      SPI_NOR_QUAD_READ)
+		MFR_FLAGS(USE_FSR)
+	},
 
 	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2) },
 	{ "m25p10",  INFO(0x202011,  0,  32 * 1024,   4) },
@@ -409,7 +436,7 @@ static void micron_st_nor_default_init(struct spi_nor *nor)
 
 static void micron_st_nor_late_init(struct spi_nor *nor)
 {
-	if (nor->flags & SNOR_F_USE_FSR)
+	if (nor->info->mfr_flags & USE_FSR)
 		nor->params->ready = spi_nor_fsr_ready;
 }
 
-- 
2.30.2

