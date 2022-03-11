Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CFC4D5CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347340AbiCKIDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347323AbiCKIDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:03:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A831B8BC6;
        Fri, 11 Mar 2022 00:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646985726; x=1678521726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bBuc0dSqEp0ceWg5YLI6l7Ab+hpyxnlOuGo10RXDtBQ=;
  b=YnBQAyngojXlJHbNktxb3GwKYZxXnmJNsbHadmjGL0vVmtSMGJgsowgd
   9zSrR601dOAnMm0oc2dQD4PSM6QtFpASbLbrgG07BGlAYHesDaNlGm5cy
   JqO9yBeB9D0quN1o0uN9KUqO73idTmFqKwKR5DwnwkpJb20i1D8VVcnyr
   CUEb5z5iqQhIUL2RdLJYfw7JrGzS44Z7R136X4haHHr/WszaFEfStXKoc
   mswXnXznhnbUfWYirRjflmFLp4aDwSZh5Dm1tFZ+RmGpFiDqLfeiS5vqW
   8ImLQPA8nOl+p9sNSPr4VJC2HOLHr5hT/8dgts8EWDN2zNzyn3b+WqHLd
   w==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643698800"; 
   d="scan'208";a="156090487"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Mar 2022 01:02:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Mar 2022 01:02:05 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 11 Mar 2022 01:02:02 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <broonie@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 4/6] mtd: spi-nor: core: Introduce SPI_NOR_DTR_BSWAP16 no_sfdp_flag
Date:   Fri, 11 Mar 2022 10:01:45 +0200
Message-ID: <20220311080147.453483-5-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311080147.453483-1-tudor.ambarus@microchip.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
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

Introduce SPI_NOR_DTR_BSWAP16 flag for flashes that don't define the
mandatory BFPT table. When set it indicates that the byte order of 16-bit
words is swapped when read in 8D-8D-8D mode compared to 1-1-1 mode.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c | 5 ++++-
 drivers/mtd/spi-nor/core.h | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index a69c2813f6fc..d7eebbd01122 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2298,7 +2298,7 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 	struct spi_nor_erase_map *map = &params->erase_map;
-	const u8 no_sfdp_flags = nor->info->no_sfdp_flags;
+	const u16 no_sfdp_flags = nor->info->no_sfdp_flags;
 	u8 i, erase_mask;
 
 	if (no_sfdp_flags & SPI_NOR_DUAL_READ) {
@@ -2339,6 +2339,9 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 					SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
 	}
 
+	if (no_sfdp_flags & SPI_NOR_DTR_SWAB16)
+		nor->flags |= SNOR_F_DTR_SWAB16;
+
 	/*
 	 * Sector Erase settings. Sort Erase Types in ascending order, with the
 	 * smallest erase size starting at BIT(0).
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 0dcbc7a81e64..4508bbea5df1 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -468,6 +468,9 @@ struct spi_nor_fixups {
  *   SPI_NOR_OCTAL_READ:      flash supports Octal Read.
  *   SPI_NOR_OCTAL_DTR_READ:  flash supports octal DTR Read.
  *   SPI_NOR_OCTAL_DTR_PP:    flash supports Octal DTR Page Program.
+ *   SPI_NOR_DTR_SWAB16:      the byte order of 16-bit words is swapped when
+ *			      read or written in Octal DTR mode compared to STR
+ *                            mode.
  *
  * @fixup_flags:    flags that indicate support that can be discovered via SFDP
  *                  ideally, but can not be discovered for this particular flash
@@ -507,7 +510,7 @@ struct flash_info {
 #define NO_CHIP_ERASE			BIT(7)
 #define SPI_NOR_NO_FR			BIT(8)
 
-	u8 no_sfdp_flags;
+	u16 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
 #define SECT_4K				BIT(1)
 #define SECT_4K_PMC			BIT(2)
@@ -516,6 +519,7 @@ struct flash_info {
 #define SPI_NOR_OCTAL_READ		BIT(5)
 #define SPI_NOR_OCTAL_DTR_READ		BIT(6)
 #define SPI_NOR_OCTAL_DTR_PP		BIT(7)
+#define SPI_NOR_DTR_SWAB16		BIT(8)
 
 	u8 fixup_flags;
 #define SPI_NOR_4B_OPCODES		BIT(0)
-- 
2.25.1

