Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E601258F429
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiHJWHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiHJWHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:07:15 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB4A81B2F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:07:14 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 32CE622255;
        Thu, 11 Aug 2022 00:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1660169231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwUBCKmQEvGZoCu8didadShDv+CFSRJAtBpbc4Le0yw=;
        b=DUOel0cpsLAie3JZ7tdkiFqmZVcAO4RAw+185Z4FY+GlPX6VGeCNOsDlxtytKAIeWc+Opa
        gAJ+sxYo1EZkFwLpxffsblXJu7P0gwgpQ4LPwNmVc8ah/JF8qIsfEuv/2B6dqr6dOQ5Onq
        ya7pwDi6n/6ly4U6/rdkMDwLsI/bvUk=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <michael@walle.cc>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 6/7] mtd: spi-nor: add generic flash driver
Date:   Thu, 11 Aug 2022 00:06:53 +0200
Message-Id: <20220810220654.1297699-7-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220810220654.1297699-1-michael@walle.cc>
References: <20220810220654.1297699-1-michael@walle.cc>
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

Our SFDP parsing is everything we need to support all basic operations
of a flash device. If the flash isn't found in our in-kernel flash
database, gracefully fall back to a driver described solely by its SFDP
tables.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/core.c | 26 ++++++++++++++++++++++++--
 drivers/mtd/spi-nor/core.h |  1 +
 drivers/mtd/spi-nor/sfdp.c | 27 +++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 42f9bb63919c..f10fca5730b8 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1632,6 +1632,16 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_xmc,
 };
 
+static const struct flash_info spi_nor_generic_flash = {
+	.name = "spi-nor-generic",
+	/*
+	 * JESD216 rev A doesn't specify the page size, therefore we need a
+	 * sane default.
+	 */
+	.page_size = 256,
+	.parse_sfdp = true,
+};
+
 static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
 						 const u8 *id)
 {
@@ -1670,6 +1680,14 @@ static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
 		return ERR_PTR(-ENOMEM);
 
 	info = spi_nor_match_id(nor, id);
+
+	/* Fallback to a generic flash described only by its SFDP data. */
+	if (!info) {
+		ret = spi_nor_check_sfdp_signature(nor);
+		if (!ret)
+			info = &spi_nor_generic_flash;
+	}
+
 	if (!info) {
 		dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
 			SPI_NOR_MAX_ID_LEN, id);
@@ -2096,8 +2114,12 @@ static int spi_nor_select_pp(struct spi_nor *nor,
  * spi_nor_select_uniform_erase() - select optimum uniform erase type
  * @map:		the erase map of the SPI NOR
  * @wanted_size:	the erase type size to search for. Contains the value of
- *			info->sector_size or of the "small sector" size in case
- *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined.
+ *			info->sector_size, the "small sector" size in case
+ *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined or 0 if
+ *			there is no information about the sector size. The
+ *			latter is the case if the flash parameters are parsed
+ *			solely by SFDP, then the largest supported erase type
+ *			is selected.
  *
  * Once the optimum uniform sector erase command is found, disable all the
  * other.
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 68aaccaa12d8..ef0a73dbf348 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -701,6 +701,7 @@ int spi_nor_controller_ops_read_reg(struct spi_nor *nor, u8 opcode,
 int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
 				     const u8 *buf, size_t len);
 
+int spi_nor_check_sfdp_signature(struct spi_nor *nor);
 int spi_nor_parse_sfdp(struct spi_nor *nor);
 
 static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 2257f1b4c2e2..0a77f50a2691 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1249,6 +1249,33 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *nor)
 		nor->info->fixups->post_sfdp(nor);
 }
 
+/**
+ * spi_nor_check_sfdp_signature() - check for a valid SFDP signature
+ * @nor:	pointer to a 'struct spi_nor'
+ *
+ * Used to detect if the flash supports the RDSFDP command as well as the
+ * presence of a valid SFDP table.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_check_sfdp_signature(struct spi_nor *nor)
+{
+	u32 signature;
+	int err;
+
+	/* Get the SFDP header. */
+	err = spi_nor_read_sfdp_dma_unsafe(nor, 0, sizeof(signature),
+					   &signature);
+	if (err < 0)
+		return err;
+
+	/* Check the SFDP signature. */
+	if (le32_to_cpu(signature) != SFDP_SIGNATURE)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
-- 
2.30.2

