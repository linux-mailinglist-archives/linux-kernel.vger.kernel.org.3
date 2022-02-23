Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14644C1478
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbiBWNok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237859AbiBWNoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:44:34 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E41DAC07E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:44:06 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 798DA223EA;
        Wed, 23 Feb 2022 14:44:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645623844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUUSc2V4sIKBECIOWlD0ga0xPNRCtlhoYSXXlDd1Uzs=;
        b=LQrrOnWhGU/8t3g7Ob4+4IO1KWvxaYAGDGI1j8w4L/A64grqbsFDoBvt8sqAfwDStOFPmh
        /nDmhBRyGBXno3tJIcVAfcubBZC/pt1sGHYczi7VvY/MaDonusSue0S1eSLaQD63/6ia+G
        Bx71qRHwLzMsinx5gqk3ezr0zUwyyig=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v5 01/32] mtd: spi-nor: atmel: unify function names
Date:   Wed, 23 Feb 2022 14:43:27 +0100
Message-Id: <20220223134358.1914798-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220223134358.1914798-1-michael@walle.cc>
References: <20220223134358.1914798-1-michael@walle.cc>
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

To avoid name clashes unify all the function and static object names and
use one of the following prefixes which should be sufficiently unique:
 - <vendor>_nor_
 - <flash_family>_nor_
 - <flash_part>_

There are no functional changes.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/atmel.c | 81 +++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index d6d889ce8876..656dd80a0be7 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -16,12 +16,12 @@
  * is to unlock the whole flash array on startup. Therefore, we have to support
  * exactly this operation.
  */
-static int atmel_at25fs_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+static int at25fs_nor_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
 	return -EOPNOTSUPP;
 }
 
-static int atmel_at25fs_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+static int at25fs_nor_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
 	int ret;
 
@@ -37,28 +37,28 @@ static int atmel_at25fs_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	return ret;
 }
 
-static int atmel_at25fs_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+static int at25fs_nor_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
 	return -EOPNOTSUPP;
 }
 
-static const struct spi_nor_locking_ops atmel_at25fs_locking_ops = {
-	.lock = atmel_at25fs_lock,
-	.unlock = atmel_at25fs_unlock,
-	.is_locked = atmel_at25fs_is_locked,
+static const struct spi_nor_locking_ops at25fs_nor_locking_ops = {
+	.lock = at25fs_nor_lock,
+	.unlock = at25fs_nor_unlock,
+	.is_locked = at25fs_nor_is_locked,
 };
 
-static void atmel_at25fs_late_init(struct spi_nor *nor)
+static void at25fs_nor_late_init(struct spi_nor *nor)
 {
-	nor->params->locking_ops = &atmel_at25fs_locking_ops;
+	nor->params->locking_ops = &at25fs_nor_locking_ops;
 }
 
-static const struct spi_nor_fixups atmel_at25fs_fixups = {
-	.late_init = atmel_at25fs_late_init,
+static const struct spi_nor_fixups at25fs_nor_fixups = {
+	.late_init = at25fs_nor_late_init,
 };
 
 /**
- * atmel_set_global_protection - Do a Global Protect or Unprotect command
+ * atmel_nor_set_global_protection - Do a Global Protect or Unprotect command
  * @nor:	pointer to 'struct spi_nor'
  * @ofs:	offset in bytes
  * @len:	len in bytes
@@ -66,8 +66,8 @@ static const struct spi_nor_fixups atmel_at25fs_fixups = {
  *
  * Return: 0 on success, -error otherwise.
  */
-static int atmel_set_global_protection(struct spi_nor *nor, loff_t ofs,
-				       uint64_t len, bool is_protect)
+static int atmel_nor_set_global_protection(struct spi_nor *nor, loff_t ofs,
+					   uint64_t len, bool is_protect)
 {
 	int ret;
 	u8 sr;
@@ -116,17 +116,20 @@ static int atmel_set_global_protection(struct spi_nor *nor, loff_t ofs,
 	return spi_nor_write_sr(nor, nor->bouncebuf, 1);
 }
 
-static int atmel_global_protect(struct spi_nor *nor, loff_t ofs, uint64_t len)
+static int atmel_nor_global_protect(struct spi_nor *nor, loff_t ofs,
+				    uint64_t len)
 {
-	return atmel_set_global_protection(nor, ofs, len, true);
+	return atmel_nor_set_global_protection(nor, ofs, len, true);
 }
 
-static int atmel_global_unprotect(struct spi_nor *nor, loff_t ofs, uint64_t len)
+static int atmel_nor_global_unprotect(struct spi_nor *nor, loff_t ofs,
+				      uint64_t len)
 {
-	return atmel_set_global_protection(nor, ofs, len, false);
+	return atmel_nor_set_global_protection(nor, ofs, len, false);
 }
 
-static int atmel_is_global_protected(struct spi_nor *nor, loff_t ofs, uint64_t len)
+static int atmel_nor_is_global_protected(struct spi_nor *nor, loff_t ofs,
+					 uint64_t len)
 {
 	int ret;
 
@@ -140,47 +143,47 @@ static int atmel_is_global_protected(struct spi_nor *nor, loff_t ofs, uint64_t l
 	return ((nor->bouncebuf[0] & ATMEL_SR_GLOBAL_PROTECT_MASK) == ATMEL_SR_GLOBAL_PROTECT_MASK);
 }
 
-static const struct spi_nor_locking_ops atmel_global_protection_ops = {
-	.lock = atmel_global_protect,
-	.unlock = atmel_global_unprotect,
-	.is_locked = atmel_is_global_protected,
+static const struct spi_nor_locking_ops atmel_nor_global_protection_ops = {
+	.lock = atmel_nor_global_protect,
+	.unlock = atmel_nor_global_unprotect,
+	.is_locked = atmel_nor_is_global_protected,
 };
 
-static void atmel_global_protection_late_init(struct spi_nor *nor)
+static void atmel_nor_global_protection_late_init(struct spi_nor *nor)
 {
-	nor->params->locking_ops = &atmel_global_protection_ops;
+	nor->params->locking_ops = &atmel_nor_global_protection_ops;
 }
 
-static const struct spi_nor_fixups atmel_global_protection_fixups = {
-	.late_init = atmel_global_protection_late_init,
+static const struct spi_nor_fixups atmel_nor_global_protection_fixups = {
+	.late_init = atmel_nor_global_protection_late_init,
 };
 
-static const struct flash_info atmel_parts[] = {
+static const struct flash_info atmel_nor_parts[] = {
 	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
 	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4)
 		FLAGS(SPI_NOR_HAS_LOCK)
 		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_at25fs_fixups },
+		.fixups = &at25fs_nor_fixups },
 	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8)
 		FLAGS(SPI_NOR_HAS_LOCK)
 		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_at25fs_fixups },
+		.fixups = &at25fs_nor_fixups },
 	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_global_protection_fixups },
+		.fixups = &atmel_nor_global_protection_fixups },
 	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_global_protection_fixups },
+		.fixups = &atmel_nor_global_protection_fixups },
 	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_global_protection_fixups },
+		.fixups = &atmel_nor_global_protection_fixups },
 	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_global_protection_fixups },
+		.fixups = &atmel_nor_global_protection_fixups },
 	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8)
@@ -188,21 +191,21 @@ static const struct flash_info atmel_parts[] = {
 	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_global_protection_fixups },
+		.fixups = &atmel_nor_global_protection_fixups },
 	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_global_protection_fixups },
+		.fixups = &atmel_nor_global_protection_fixups },
 	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_global_protection_fixups },
+		.fixups = &atmel_nor_global_protection_fixups },
 	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16)
 		NO_SFDP_FLAGS(SECT_4K) },
 };
 
 const struct spi_nor_manufacturer spi_nor_atmel = {
 	.name = "atmel",
-	.parts = atmel_parts,
-	.nparts = ARRAY_SIZE(atmel_parts),
+	.parts = atmel_nor_parts,
+	.nparts = ARRAY_SIZE(atmel_nor_parts),
 };
-- 
2.30.2

