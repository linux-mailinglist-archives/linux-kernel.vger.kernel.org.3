Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D784826E3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiAAHnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:43:53 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57966 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiAAHnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:43:47 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017hQ88034590;
        Sat, 1 Jan 2022 01:43:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641023006;
        bh=M/hFvcCbNKAmlrRAliBKWD7s8bUkf78uts3ifMYQRhc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iuudt2MTu69BOKUjtRh53ltYS2Le+1QMPYNMrtCd1Yu0ejhsX/yklfqHj8n2HY0dq
         FjP2Iawj7FBlhBKGGn0TjJjuhzwDGaDEubXFBwXfXK39RJF662/xvF8AQQiu7sS/Hc
         mOoYbJjTHAnymTk2cn3Q+B+gKCk8jMPwtMXzcRVk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017hPqf081333
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:43:25 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:43:25 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:43:25 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwa033162;
        Sat, 1 Jan 2022 01:43:20 -0600
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
Subject: [PATCH v3 05/17] mtd: spinand: Define ctrl_ops for non-page read/write op templates
Date:   Sat, 1 Jan 2022 13:12:38 +0530
Message-ID: <20220101074250.14443-6-a-nandan@ti.com>
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

'ctrl_ops' are op templates for non-page read/write operations,
which are: reset, get_feature, set_feature, write_enable, block_erase,
page_read and program_execute ops. The 'ctrl_ops' struct contains in it
op templates for each of this op, as well as enum spinand_protocol
denoting protocol of all these ops.

We require these new op templates because of deviation in standard
SPINAND ops by manufacturers and also due to changes when there is a
change in SPI protocol/mode. This prevents the core from live-patching
and vendor-specific adjustments in ops.

Define 'ctrl_ops', add macros to initialize it and add it in
spinand_device.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 include/linux/mtd/spinand.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 439d8ce40e1d..e5df6220ec1e 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -356,6 +356,35 @@ struct spinand_op_variants {
 			sizeof(struct spi_mem_op),			\
 	}
 
+struct spinand_ctrl_ops {
+	const struct {
+		struct spi_mem_op reset;
+		struct spi_mem_op get_feature;
+		struct spi_mem_op set_feature;
+		struct spi_mem_op write_enable;
+		struct spi_mem_op block_erase;
+		struct spi_mem_op page_read;
+		struct spi_mem_op program_execute;
+	} ops;
+	const enum spinand_protocol protocol;
+};
+
+#define SPINAND_CTRL_OPS(__protocol, __reset, __get_feature, __set_feature,	\
+			 __write_enable, __block_erase, __page_read,		\
+			 __program_execute)					\
+	{									\
+		.ops = {							\
+			.reset = __reset,					\
+			.get_feature = __get_feature,				\
+			.set_feature = __set_feature,				\
+			.write_enable = __write_enable,				\
+			.block_erase = __block_erase,				\
+			.page_read = __page_read,				\
+			.program_execute = __program_execute,			\
+		},								\
+		.protocol = __protocol,						\
+	}
+
 /**
  * spinand_ecc_info - description of the on-die ECC implemented by a SPI NAND
  *		      chip
@@ -468,6 +497,8 @@ struct spinand_dirmap {
  * @data_ops.read_cache: read cache op template
  * @data_ops.write_cache: write cache op template
  * @data_ops.update_cache: update cache op template
+ * @ctrl_ops: various SPI mem op templates for handling the flash device, i.e.
+ *	      non page-read/write ops.
  * @select_target: select a specific target/die. Usually called before sending
  *		   a command addressing a page or an eraseblock embedded in
  *		   this die. Only required if your chip exposes several dies
@@ -498,6 +529,8 @@ struct spinand_device {
 		const struct spi_mem_op *update_cache;
 	} data_ops;
 
+	const struct spinand_ctrl_ops *ctrl_ops;
+
 	struct spinand_dirmap *dirmaps;
 
 	int (*select_target)(struct spinand_device *spinand,
-- 
2.25.1

