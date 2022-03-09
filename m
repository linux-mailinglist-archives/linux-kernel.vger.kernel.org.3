Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E524D30E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiCIOSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiCIOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:18:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44DF11594A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646835438; x=1678371438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IORGV7QlcA5sohOEM4gfP0Bb40JV3m1t21ODzfp/29o=;
  b=EWnpaNrriBAR+wp0K4hKVWLg7/2JrC06oltUk0IQypNMi+GCuKsTPHdD
   CmJBRzQOQlV0HMbzn5tG6bULRFGBRlkHtU/RIiWsm8oen8bPRe4632PoF
   XWxN/lnjZw4NPQCJHlATdNYMvwQN8wa0Ml3CdLZF/iy7Evx1oGDQXFo/I
   f5V7ocq0NfUouv4Xl6n9ysurELXB6FTiSqkyG6gCImZwnVKPIvNf91TX5
   lkRG3B3I6z7AHp/VqLhelRwkDXXG6Ktmz17Awtfb0Za2QjBlS67oovunE
   jGd2cBjYwuL3DL6yKLK5R/D6tDiiJqPTpNK/lw0fbhzDL5E4vUwuI8qyJ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="165097814"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 07:17:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 07:17:17 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 07:17:15 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 4/5] mtd: spi-nor Favor the BFPT-parsed Quad Enable method
Date:   Wed, 9 Mar 2022 16:17:01 +0200
Message-ID: <20220309141702.173879-5-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309141702.173879-1-tudor.ambarus@microchip.com>
References: <20220309141702.173879-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JESD216 SFDP defines in the BFPT standard methods to enable Quad Mode. The
flash parameters and settings that are retrieved from SFDP have higher
precedence than the static initialized ones, because they should be more
accurate and less error prone than those initialized statically. Favor the
BFPT-parsed Quad Enable method and use the generic core methods where
possible.
This patch may introduce regressions in case BFPT contains wrong data. The
fix is to introduce a post_bfpt() fixup hook and update the wrong BFPT
data.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c     |  5 +++--
 drivers/mtd/spi-nor/issi.c     |  4 ++--
 drivers/mtd/spi-nor/macronix.c | 14 ++++++--------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 5de46a786cc5..9a5299a7b212 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2427,9 +2427,11 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 	if (nor->info->fixups && nor->info->fixups->late_init)
 		nor->info->fixups->late_init(nor);
 
-	/* Default method kept for backward compatibility. */
+	/* Default methods kept for backward compatibility. */
 	if (!params->set_4byte_addr_mode)
 		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
+	if (!params->quad_enable)
+		params->quad_enable = spi_nor_sr2_bit1_quad_enable;
 
 	spi_nor_init_flags(nor);
 	spi_nor_init_fixup_flags(nor);
@@ -2497,7 +2499,6 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	const struct flash_info *info = nor->info;
 	struct device_node *np = spi_nor_get_flash_node(nor);
 
-	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
 	params->otp.org = &info->otp_org;
 
 	/* Default to 16-bit Write Status (01h) Command */
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index c012bc2486e1..0fefda46ccad 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -69,13 +69,13 @@ static const struct flash_info issi_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K) },
 };
 
-static void issi_nor_default_init(struct spi_nor *nor)
+static void issi_nor_late_init(struct spi_nor *nor)
 {
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
 }
 
 static const struct spi_nor_fixups issi_fixups = {
-	.default_init = issi_nor_default_init,
+	.late_init = issi_nor_late_init,
 };
 
 const struct spi_nor_manufacturer spi_nor_issi = {
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index c267cbcc7f1d..4fd65d55388a 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -102,20 +102,18 @@ static const struct flash_info macronix_nor_parts[] = {
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 };
 
-static void macronix_nor_default_init(struct spi_nor *nor)
-{
-	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
-}
-
 static void macronix_nor_late_init(struct spi_nor *nor)
 {
-	if (!nor->params->set_4byte_addr_mode)
-		nor->params->set_4byte_addr_mode =
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	if (!params->set_4byte_addr_mode)
+		params->set_4byte_addr_mode =
 			spi_nor_set_4byte_addr_mode_en4b_ex4b;
+	if (!params->quad_enable)
+		params->quad_enable = spi_nor_sr1_bit6_quad_enable;
 }
 
 static const struct spi_nor_fixups macronix_nor_fixups = {
-	.default_init = macronix_nor_default_init,
 	.late_init = macronix_nor_late_init,
 };
 
-- 
2.25.1

