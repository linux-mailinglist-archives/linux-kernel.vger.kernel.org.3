Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5981D500547
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 07:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiDNFCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 01:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiDNFCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:02:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271371D0F1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 22:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649912424; x=1681448424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yDlalwWnBkcn2d0X1iU/YSTVgPIyzcIKznXpiKQ8Cl8=;
  b=DfhewKbueM0nqBN1Ofnxl63cvxA651i7VjAQThGZI8EI/CKBbvhNEmAH
   ZxNsn3WdWHJYHhUnG5XuWX2bovksPGM7c3J1lKBzV7w2IrzdbGnzAfL6p
   ag35EAV97DCLb7Sfv8aSaadPtl1th/RdD5QVIJsSJI48RaY/4PU1EoMLY
   7PSLvjLNFqK0DSaMcv9ffB/ZCpm9u488+MUoz30JIqhxiXWH4dCdee1w5
   iWWUF0PyjyOqs5NmdZnAOXEA1R1f5d4Bjr0VLdgliNr1vUg/XCWc35hTO
   e7X6xUZO5NQ4Eunl9Nkl7nOWr5/JXJvSHz8VIJh7HspNJBqFdVYFwZtMV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="250138067"
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="250138067"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 22:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="700535052"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2022 22:00:14 -0700
From:   niravkumar.l.rabara@intel.com
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: issi: Add IS25WP512 device
Date:   Thu, 14 Apr 2022 21:00:04 +0800
Message-Id: <20220414130004.945924-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add is25wp512 info to spi_nor_ids[] table entry.

Rename is25lp256_post_bfpt_fixups to is25xx_post_bfpt_fixups
as a common function for all is25xx post_bfpt fixups.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 drivers/mtd/spi-nor/issi.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index c012bc2486e1..14fe07e55f85 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -9,24 +9,27 @@
 #include "core.h"
 
 static int
-is25lp256_post_bfpt_fixups(struct spi_nor *nor,
+is25xx_post_bfpt_fixups(struct spi_nor *nor,
 			   const struct sfdp_parameter_header *bfpt_header,
 			   const struct sfdp_bfpt *bfpt)
 {
 	/*
-	 * IS25LP256 supports 4B opcodes, but the BFPT advertises a
-	 * BFPT_DWORD1_ADDRESS_BYTES_3_ONLY address width.
+	 * IS25XX256 & IS25XX512 supports 4B opcodes,
+	 * but the BFPT advertises BFPT_DWORD1_ADDRESS_BYTES_3_ONLY and
+	 * BFPT_DWORD1_ADDRESS_BYTES_3_OR_4 address width repectively.
 	 * Overwrite the address width advertised by the BFPT.
 	 */
-	if ((bfpt->dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) ==
-		BFPT_DWORD1_ADDRESS_BYTES_3_ONLY)
+	if (((bfpt->dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) ==
+		BFPT_DWORD1_ADDRESS_BYTES_3_ONLY) ||
+		((bfpt->dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) ==
+		BFPT_DWORD1_ADDRESS_BYTES_3_OR_4))
 		nor->addr_width = 4;
 
 	return 0;
 }
 
-static const struct spi_nor_fixups is25lp256_fixups = {
-	.post_bfpt = is25lp256_post_bfpt_fixups,
+static struct spi_nor_fixups is25xx_fixups = {
+	.post_bfpt = is25xx_post_bfpt_fixups,
 };
 
 static const struct flash_info issi_nor_parts[] = {
@@ -48,7 +51,7 @@ static const struct flash_info issi_nor_parts[] = {
 	{ "is25lp256",  INFO(0x9d6019, 0, 64 * 1024, 512)
 		PARSE_SFDP
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
-		.fixups = &is25lp256_fixups },
+		.fixups = &is25xx_fixups },
 	{ "is25wp032",  INFO(0x9d7016, 0, 64 * 1024,  64)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp064",  INFO(0x9d7017, 0, 64 * 1024, 128)
@@ -58,7 +61,11 @@ static const struct flash_info issi_nor_parts[] = {
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
-		.fixups = &is25lp256_fixups },
+		.fixups = &is25xx_fixups },
+	{ "is25wp512", INFO(0x9d701a, 0, 64 * 1024, 1024)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &is25xx_fixups },
 
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2)
-- 
2.25.1

