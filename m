Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD844AF300
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiBINhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiBINh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:37:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED72C05CBAB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644413848; x=1675949848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i1qODm2MF6WXEhTkxHcVbX9Z1DGVGhcI+d5OabViJAk=;
  b=vLFzauNIbNK5hK5gIcKwCi9DM13fHBwabXwf+xKaYTkNR47vgN9neTY9
   lRUYcS1rPQ/m9JZXToosTp7pmrkb96TXD/5sxR4sevz89StDtPgqgDEX9
   FQmp3ItLpww4rQj2NjbeBV6SRRya2aam5KF6fH80TP1MIIDtOgiDBt3Rl
   cTaFrzjLUI4muFlwRfNHu/S8Kmdh5zPUtXuYuBtEbxt/Hg6tWB6Bm9DNI
   krmt/etUa/nDcY/p/tXtSKamvlGoMCqWS2TwxCplJrx1odAFGOfom8uX6
   KW3ishBtCZ6esc0jP27WhKaw6YcBHrW2ERTTa4k9Zs6+uP+JebPImjyC3
   A==;
IronPort-SDR: hGA34IoKYUx2dE7ofkbrXJm5jeZpbi/PXNEV35aXCD1/Y7f6U1PchQvke1Wao1zcqlP9C5N/CM
 QOTvPon5y0H9bmGAPuZ6JGOqg2ZCNdXPjLItAB9FBP+cD/mOJ2gdfItNmFPkUgJp7C+1VPCEt6
 QhGP8+zXXtFc4DYF515Kk2o5PHB15BLGWqR3anUnLuAuSzf5AF7nbMkAINj8C7OnMgwC9YHIDW
 0Qol1vPcrGOrR4orMfu889X/8o5JRo4OjhOEAzH61FCp6CsC90iPxW6iDCmTyOc6/qmszn5gxQ
 391EUjNLGspT2iygkJMAD/FD
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="161630018"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 06:37:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 06:37:27 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 06:37:23 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v6 5/7] mtd: spi-nor: manufacturers: Use spi_nor_read_id() core method
Date:   Wed, 9 Feb 2022 15:36:54 +0200
Message-ID: <20220209133656.374903-6-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209133656.374903-1-tudor.ambarus@microchip.com>
References: <20220209133656.374903-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use spi_nor_read_id() core method to avoid duplication of code. Now the ID
is read on the full SPI_NOR_MAX_ID_LEN instead of
round_up(nor->info->id_len, 2), but it doesn't harm to read more ID bytes,
so the change comes with no secondary effects.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/micron-st.c | 13 +++----------
 drivers/mtd/spi-nor/spansion.c  | 13 +++----------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index bb95b1aabf74..7f66b5943ceb 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -80,17 +80,10 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
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
+		ret = spi_nor_read_id(nor, 0, 0, buf, nor->reg_proto);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 534196b1d3e7..d69a569f31e4 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -94,17 +94,10 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
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
+		ret = spi_nor_read_id(nor, 0, 0, buf, nor->reg_proto);
 	if (ret)
 		return ret;
 
-- 
2.25.1

