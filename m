Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D5B4B0363
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiBJCdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:33:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiBJCds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:33:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDAC237D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644460429; x=1675996429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OWnYMkE7rv7BP25MrUGzKPIKcqXSEAtS5doI11hP+Y0=;
  b=cEu7lWnjVc+6zt9E15Zqd+401qUuQpP+v383M1prJDZR7tZXjEvfrHIU
   V86yYCzSJFR7f54oroe5RgbeWUHDAiRfnNAZKr/4L65IWW393bahmsd4o
   yXjynhBwrBBzWv19DJmVAg6e7gjCGEkGEnclngYc3G/ikaYNZ/u/qR6yb
   jUwqE+g/5FFqoEzUfnX+Hs/BfkJNb0AKnhXF1bJnviFvdmjJoH5cAUQoK
   9UY4P/cGqIzURS4OFYDESkc134AMddnU8xiYD0ffsw676TXQqf+cQmLJc
   YLXPuhSlPQLWn0UnrwR/EZJ4RnmuQpybRyjJYX/UgWXLkzl7a9uoH7FLe
   w==;
IronPort-SDR: eYLmNNkfGEeTrLV0GHhqboKWtUmQqQltTsdFidEkzGqh62JoZiYJgr/qR+/l8AimU4PgsTB+j9
 CRI+EY6n7r5sZdLJyBYxoHzxHHjMedd0v0WMvxmqB4ZTwK2oSUgzWw1zmNQbC0rBDnz8oUVKX0
 /SSdoapEL5u24R+Ri1Y+5tYYRMY+tV4BMTZMZ2ldX4eBVqBh7kLxDhGTWGQ2Zo6NKCuIvQfTWv
 UuqzTRr5sLzQEmPcAqSTPTiFzxkcOf7EDGqjNtT+f8ubNGUBArfHWUFuODlpmU6lpDwJgLeiDk
 i0rJYlHvVG8g+D3Zo3SEU32u
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="148216716"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 19:33:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 19:33:45 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 19:33:41 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>,
        <Takahiro.Kuwano@infineon.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>, <Bacem.Daassi@infineon.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 1/3] mtd: spi-nor: core: Add helpers to read/write any register
Date:   Thu, 10 Feb 2022 04:33:32 +0200
Message-ID: <20220210023334.408926-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210023334.408926-1-tudor.ambarus@microchip.com>
References: <20220210023334.408926-1-tudor.ambarus@microchip.com>
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

There are manufacturers that use registers indexed by address. Some of
them support "read/write any register" opcodes. Provide core methods that
can be used by all manufacturers. SPI NOR controller ops are intentionally
not supported as we intend to move all the SPI NOR controller drivers
under the SPI subsystem.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 41 ++++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.h |  4 ++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 7d5e3acb0ae7..d394179689e6 100644
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
index cbfb4fa7647f..c728454b5424 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -578,6 +578,10 @@ ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
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

