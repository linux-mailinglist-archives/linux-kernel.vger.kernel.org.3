Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181B24FB708
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbiDKJNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344232AbiDKJNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:13:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DC73F8A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649668252; x=1681204252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jVLs0VMdy87pwdYOVp23Oa29PG2nVUXRK6hmPmk2eqs=;
  b=bIBZde8gRszyv50+LukS7+tjeCjr4E+od6niH60QkmT9C8TL24FyCw7F
   v456uNHJAEopnb0Ka3auXE60x5/DRtVgmy/c2Cb8PYKPLcRqknMmbkdQo
   Pyi2XcZ1hl5G0gC1Z0vnNVoVUbIo38qFwpIZh/YgNTHi8U2NX+QvCF7Ss
   iWjstBlvD0fPTYP7syiThGwWk48jo0j9ZMA2rsxrmwQHoLtXRQLosWbBL
   a+FTPm93WItOSb3lGFXjM03Ri7GPSTWsHzExgDHSNf/xLc/N5kGRWYaFf
   Tg9rI13oW8MzIB6x05kmAuWgPWJei8NLM5PdqZ3U5fMyl8kXyGxIrJaug
   A==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="159624253"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2022 02:10:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Apr 2022 02:10:51 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Apr 2022 02:10:49 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 5/9] mtd: spi-nor: manufacturers: Use spi_nor_read_id() core method
Date:   Mon, 11 Apr 2022 12:10:29 +0300
Message-ID: <20220411091033.98754-6-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411091033.98754-1-tudor.ambarus@microchip.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use spi_nor_read_id() core method to avoid duplication of code. Now the ID
is read on the full SPI_NOR_MAX_ID_LEN instead of
round_up(nor->info->id_len, 2), but it doesn't harm to read more ID bytes,
so the change comes with no secondary effects. dev_dbg messages in case
spi_nor_read_id() fails, will be added in a further patch after we split
the octal DTR enable/disable methods.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
v3: collect R-b, update commit message

 drivers/mtd/spi-nor/micron-st.c | 13 +++----------
 drivers/mtd/spi-nor/spansion.c  | 13 +++----------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 8a20475ce77a..41b87868ecf9 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -91,17 +91,10 @@ static int micron_st_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 		return ret;
 
 	/* Read flash ID to make sure the switch was successful. */
-	op = (struct spi_mem_op)
-		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
-			   SPI_MEM_OP_NO_ADDR,
-			   SPI_MEM_OP_DUMMY(enable ? 8 : 0, 1),
-			   SPI_MEM_OP_DATA_IN(round_up(nor->info->id_len, 2),
-					      buf, 1));
-
 	if (enable)
-		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
-
-	ret = spi_mem_exec_op(nor->spimem, &op);
+		ret = spi_nor_read_id(nor, 0, 8, buf, SNOR_PROTO_8_8_8_DTR);
+	else
+		ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index f24e546e04a5..c5988312cc91 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -98,17 +98,10 @@ static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 		return ret;
 
 	/* Read flash ID to make sure the switch was successful. */
-	op = (struct spi_mem_op)
-		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
-			   SPI_MEM_OP_ADDR(enable ? 4 : 0, 0, 1),
-			   SPI_MEM_OP_DUMMY(enable ? 3 : 0, 1),
-			   SPI_MEM_OP_DATA_IN(round_up(nor->info->id_len, 2),
-					      buf, 1));
-
 	if (enable)
-		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
-
-	ret = spi_mem_exec_op(nor->spimem, &op);
+		ret = spi_nor_read_id(nor, 4, 3, buf, SNOR_PROTO_8_8_8_DTR);
+	else
+		ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
 	if (ret)
 		return ret;
 
-- 
2.25.1

