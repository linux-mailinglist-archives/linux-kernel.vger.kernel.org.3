Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BD24C6A06
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiB1LSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiB1LSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:18:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BCA9FE5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646047062; x=1677583062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4k8NB06Tt38eO1sMpf6pSXXFWiN02DmgonwSIAOs4U4=;
  b=x3DXgTmyeyKTU4YTEiGdCIYU2rLcg7/S8M3RxR8Q2H+9ZJrXJyXVkcue
   LHjmJSoNOKOha8+aguW52DRz1cu3vqAXY5Y5uXg+nOrv30LkAVvGs54te
   G+4uNah9ihEmBtsRo3viEoDRH59FfUUg95usxbWn2yJq6Ei5r7iVAxDH2
   TCSg/WoZt4dqiJ860U69ejP8nSgIlUSw7JWy7nnY4E127J0awTmCR1LT/
   eU1sbNLKAxgO0hEnFZmgNPE4Q1+0/Zt6EkjuC8zrF9TsG8J0OHNuYLCK/
   YU5Sk6ylMJcbb2+uOt4Xw6cL7w5Y/mj/6GsCRnROI3MkgIM6XOxiMfqzD
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643698800"; 
   d="scan'208";a="150223243"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2022 04:17:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 28 Feb 2022 04:17:39 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 28 Feb 2022 04:17:36 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 6/8] mtd: spi-nor: core: Add helpers to read/write any register
Date:   Mon, 28 Feb 2022 13:17:10 +0200
Message-ID: <20220228111712.111737-7-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228111712.111737-1-tudor.ambarus@microchip.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are manufacturers that use registers indexed by address. Some of
them support "read/write any register" opcodes. Provide core methods that
can be used by all manufacturers. SPI NOR controller ops are intentionally
not supported as we intend to move all the SPI NOR controller drivers
under the SPI subsystem.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Tested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 41 ++++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.h |  4 ++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 281e3d25f74c..f1aa1e2ea7c9 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -307,6 +307,47 @@ ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 	return nor->controller_ops->write(nor, to, len, buf);
 }
 
+/**
+ * spi_nor_read_reg() - read register to flash memory
+ * @nor:        pointer to 'struct spi_nor'.
+ * @op:		SPI memory operation. op->data.buf must be DMA-able.
+ * @proto:	SPI protocol to use for the register operation.
+ *
+ * Return: zero on success, -errno otherwise
+ */
+int spi_nor_read_reg(struct spi_nor *nor, struct spi_mem_op *op,
+		     enum spi_nor_protocol proto)
+{
+	if (!nor->spimem)
+		return -EOPNOTSUPP;
+
+	spi_nor_spimem_setup_op(nor, op, proto);
+	return spi_nor_spimem_exec_op(nor, op);
+}
+
+/**
+ * spi_nor_write_reg() - write register to flash memory
+ * @nor:        pointer to 'struct spi_nor'
+ * @op:		SPI memory operation. op->data.buf must be DMA-able.
+ * @proto:	SPI protocol to use for the register operation.
+ *
+ * Return: zero on success, -errno otherwise
+ */
+int spi_nor_write_reg(struct spi_nor *nor, struct spi_mem_op *op,
+		      enum spi_nor_protocol proto)
+{
+	int ret;
+
+	if (!nor->spimem)
+		return -EOPNOTSUPP;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+	spi_nor_spimem_setup_op(nor, op, proto);
+	return spi_nor_spimem_exec_op(nor, op);
+}
+
 /**
  * spi_nor_write_enable() - Set write enable latch with Write Enable command.
  * @nor:	pointer to 'struct spi_nor'.
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index f952061d5c24..7c704475946d 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -554,6 +554,10 @@ ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
 			  u8 *buf);
 ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 			   const u8 *buf);
+int spi_nor_read_reg(struct spi_nor *nor, struct spi_mem_op *op,
+		     enum spi_nor_protocol proto);
+int spi_nor_write_reg(struct spi_nor *nor, struct spi_mem_op *op,
+		      enum spi_nor_protocol proto);
 int spi_nor_erase_sector(struct spi_nor *nor, u32 addr);
 
 int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
-- 
2.25.1

