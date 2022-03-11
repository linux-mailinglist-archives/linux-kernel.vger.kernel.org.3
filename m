Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6544D5CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347285AbiCKIDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347165AbiCKIDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:03:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512AF1B757A;
        Fri, 11 Mar 2022 00:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646985721; x=1678521721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3sOq6yDNcZ9Qx9sU/cp+hGbBR/ZmOqDydd2NJVD+Elo=;
  b=GTZveDOi9SO1kVkrCePJl1rxHqZEN5Bs6wX8IbD9SaX6mIfE2nF+t5Ix
   bXutN88vkZFIzOwD1bKUOq0fsGJwyETd/O9KyGOMe4JijpkHzcPqzqm0E
   15YDBO9/LjR/nnmFo0lEnoHGt2LGBYW20ka02XEDCPGi1WlEAT8Zm8Pzz
   eT8OaqWkCyglndgMkoCZ6bGfRFAhfTSjG6l0ZhJJweVgu9elGjETgqeza
   3wLnWGTVXoU9NTd3GHDhy0+JZF7nzYRv/p93UMG4UBmisb6p8cGSb4bmN
   nBVskNAYTb+rNC2BU8Q33x6qWeyq7W5G4ODjiSgzrPD+QeNMBrkaEG+yE
   A==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643698800"; 
   d="scan'208";a="148864925"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Mar 2022 01:02:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Mar 2022 01:01:59 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 11 Mar 2022 01:01:56 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <broonie@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 2/6] mtd: spi-nor: core: Allow specifying the byte order in DTR mode
Date:   Fri, 11 Mar 2022 10:01:43 +0200
Message-ID: <20220311080147.453483-3-tudor.ambarus@microchip.com>
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

Macronix swaps bytes on a 16-bit boundary when configured in Octal DTR.
The byte order of 16-bit words is swapped when read or written in 8D-8D-8D
mode compared to STR modes. Allow operations to specify the byte order in
DTR mode, so that controllers can swap the bytes back at run-time to
address the flash's endianness requirements, if they are capable. If the
controllers are not capable of swapping the bytes, the protocol is
downgraded via spi_nor_spimem_adjust_hwcaps(). When available, the swapping
of the bytes is always done regardless if it's a data or register access,
so that we comply with the JESD216 requirements: "Byte order of 16-bit
words is swapped when read in 8D-8D-8D mode compared to 1-1-1".

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 8 ++++++++
 drivers/mtd/spi-nor/core.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 5de46a786cc5..a69c2813f6fc 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -70,6 +70,13 @@ static u8 spi_nor_get_cmd_ext(const struct spi_nor *nor,
 	}
 }
 
+static inline bool spi_nor_is_octal_dtr_swab16(const struct spi_nor *nor,
+					       enum spi_nor_protocol proto)
+{
+	return (proto == SNOR_PROTO_8_8_8_DTR) &&
+		(nor->flags & SNOR_F_DTR_SWAB16);
+}
+
 /**
  * spi_nor_spimem_setup_op() - Set up common properties of a spi-mem op.
  * @nor:		pointer to a 'struct spi_nor'
@@ -105,6 +112,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 		op->addr.dtr = true;
 		op->dummy.dtr = true;
 		op->data.dtr = true;
+		op->data.dtr_swab16 = spi_nor_is_octal_dtr_swab16(nor, proto);
 
 		/* 2 bytes per clock cycle in DTR mode. */
 		op->dummy.nbytes *= 2;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index c83d5e75c563..0dcbc7a81e64 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -135,6 +135,7 @@ enum spi_nor_option_flags {
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(11),
 	SNOR_F_SOFT_RESET	= BIT(12),
 	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
+	SNOR_F_DTR_SWAB16	= BIT(14),
 };
 
 struct spi_nor_read_command {
-- 
2.25.1

