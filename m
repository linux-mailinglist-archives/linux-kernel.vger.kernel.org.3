Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56E4826E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiAAHnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:43:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41816 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiAAHnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:43:45 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017h83V103753;
        Sat, 1 Jan 2022 01:43:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641022988;
        bh=nIOqbbIt7Gau3UrolZaEW8N/5x+SGoHIkKJemZiddJU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sTGUybipCgSVTL8nI0aN4K4OCQkMXGsUlhAbLduyKA2aquAj15O+TOj8bHICFH/ZZ
         9xv++ZlHRtwGjCowg1bFgxwexvu/7igv84gLiV4BFb050Qg6taF2iQq/9u7HaJWDX2
         CmTE4Y74YvDPkO1OclGQLBaBubNrDnul0MuKhawA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017h8Dq081054
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:43:08 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:43:07 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:43:07 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwX033162;
        Sat, 1 Jan 2022 01:43:02 -0600
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <p.yadav@ti.com>
Subject: [PATCH v3 02/17] mtd: spinand: Define macros for Octal DTR ops
Date:   Sat, 1 Jan 2022 13:12:35 +0530
Message-ID: <20220101074250.14443-3-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220101074250.14443-1-a-nandan@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new op templates for reset, write enable, set_feature,
get_feature, block_erase, read/write page operations for Octal DTR SPI
mode. These templates will be used in data_ops and ctrl_ops for
performing all flash operations.

Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 include/linux/mtd/spinand.h | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6988956b8492..69e06e741717 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -26,12 +26,24 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
+#define SPINAND_RESET_OP_OCTAL_DTR					\
+	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0xffff, 8),			\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
 #define SPINAND_WR_EN_DIS_OP(enable)					\
 	SPI_MEM_OP(SPI_MEM_OP_CMD((enable) ? 0x06 : 0x04, 1),		\
 		   SPI_MEM_OP_NO_ADDR,					\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
+#define SPINAND_WR_EN_DIS_OP_OCTAL_DTR(enable)				\
+	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, (enable) ? 0x0606 : 0x0404, 8),\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
 #define SPINAND_READID_OP(naddr, ndummy, buf, len)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x9f, 1),				\
 		   SPI_MEM_OP_ADDR(naddr, 0, 1),			\
@@ -44,24 +56,48 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(1, valptr, 1))
 
+#define SPINAND_SET_FEATURE_OP_OCTAL_DTR(reg, valptr)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0x1f1f, 8),			\
+		   SPI_MEM_OP_ADDR_DTR(2, reg, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT_DTR(2, valptr, 8))
+
 #define SPINAND_GET_FEATURE_OP(reg, valptr)				\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0f, 1),				\
 		   SPI_MEM_OP_ADDR(1, reg, 1),				\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_IN(1, valptr, 1))
 
+#define SPINAND_GET_FEATURE_OP_OCTAL_DTR(reg, valptr)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0x0f0f, 8),			\
+		   SPI_MEM_OP_ADDR_DTR(2, reg, 8),			\
+		   SPI_MEM_OP_DUMMY_DTR(14, 8),				\
+		   SPI_MEM_OP_DATA_IN_DTR(2, valptr, 8))
+
 #define SPINAND_BLK_ERASE_OP(addr)					\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xd8, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
+#define SPINAND_BLK_ERASE_OP_OCTAL_DTR(addr)				\
+	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0xd8d8, 8),			\
+		   SPI_MEM_OP_ADDR_DTR(2, addr, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
 #define SPINAND_PAGE_READ_OP(addr)					\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x13, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
+#define SPINAND_PAGE_READ_OP_OCTAL_DTR(addr)				\
+	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0x1313, 8),			\
+		   SPI_MEM_OP_ADDR_DTR(2, addr, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
 #define SPINAND_PAGE_READ_FROM_CACHE_OP(fast, addr, ndummy, buf, len)	\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
@@ -122,12 +158,24 @@
 		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 4))
 
+#define SPINAND_PAGE_READ_FROM_CACHE_OCTALIO_DTR_OP(addr, ndummy, buf, len) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0x9d9d, 8),			\
+		   SPI_MEM_OP_ADDR_DTR(2, addr, 8),			\
+		   SPI_MEM_OP_DUMMY_DTR(ndummy, 8),			\
+		   SPI_MEM_OP_DATA_IN_DTR(len, buf, 8))
+
 #define SPINAND_PROG_EXEC_OP(addr)					\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x10, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
+#define SPINAND_PROG_EXEC_OP_OCTAL_DTR(addr)				\
+	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0x1010, 8),			\
+		   SPI_MEM_OP_ADDR_DTR(2, addr, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
 #define SPINAND_PROG_LOAD(reset, addr, buf, len)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(reset ? 0x02 : 0x84, 1),		\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
@@ -140,6 +188,12 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(len, buf, 4))
 
+#define SPINAND_PROG_LOAD_OCTALIO_DTR(reset, addr, buf, len)		\
+	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, reset ? 0x0202 : 0x8484, 8),	\
+		   SPI_MEM_OP_ADDR_DTR(2, addr, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT_DTR(len, buf, 8))
+
 /**
  * Standard SPI NAND flash commands
  */
-- 
2.25.1

