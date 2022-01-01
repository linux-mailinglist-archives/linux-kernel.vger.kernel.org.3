Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAED4826E8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiAAHoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:44:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41874 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiAAHoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:44:01 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017hge4103842;
        Sat, 1 Jan 2022 01:43:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641023022;
        bh=yquxRsarefuNtCOPsgOAT135Zpzm75e70KgN2foyKJ8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uFjn8N7mXovyl4B4jBnvWU5LJkgawvRjmPo+cbl8H0fPztTPF6GETgUdj3w73cc0+
         NJGSBeTjiVRufIDDnuERD8GL94QOxX8qP/Rm/eLaosT/EDHCSc6MzpFe7i3IoIlQSc
         YzBd3sEgG7wuG9iGQk2iGlg8f/3Yx1I+WF1CHj1E=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017hg4b039496
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:43:42 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:43:42 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:43:42 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwd033162;
        Sat, 1 Jan 2022 01:43:37 -0600
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
Subject: [PATCH v3 08/17] mtd: spinand: Add support for manufacturer-based ctrl_ops variations
Date:   Sat, 1 Jan 2022 13:12:41 +0530
Message-ID: <20220101074250.14443-9-a-nandan@ti.com>
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

Add ctrl_ops_variants, which can be used by the manufacturers' codes
to define their SPI control operation variants. Add a macro to easily
define ctrl_ops_varinats. This can be used to list out all the
supported ctrl ops with their respective protocols by the vendors.

Add spinand_select_ctrl_ops_variant() helper function to search for
a supported ctrl_ops variant with the required SPI protocol in a given
list of variants.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h | 17 +++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 30e90527ee3c..9688fdfc174e 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1031,6 +1031,42 @@ spinand_select_data_op_variant(struct spinand_device *spinand,
 	return NULL;
 }
 
+static const struct spinand_ctrl_ops *
+spinand_select_ctrl_ops_variant(struct spinand_device *spinand,
+				const struct spinand_ctrl_ops_variants *variants,
+				const enum spinand_protocol protocol)
+{
+	unsigned int i;
+
+	for (i = 0; i < variants->nvariants; i++) {
+		const struct spinand_ctrl_ops *ctrl_ops =
+			&variants->ctrl_ops_list[i];
+
+		if (ctrl_ops->protocol != protocol)
+			continue;
+
+		if (!spi_mem_supports_op(spinand->spimem,
+					 &ctrl_ops->ops.reset) ||
+		    !spi_mem_supports_op(spinand->spimem,
+					 &ctrl_ops->ops.get_feature) ||
+		    !spi_mem_supports_op(spinand->spimem,
+					 &ctrl_ops->ops.set_feature) ||
+		    !spi_mem_supports_op(spinand->spimem,
+					 &ctrl_ops->ops.write_enable) ||
+		    !spi_mem_supports_op(spinand->spimem,
+					 &ctrl_ops->ops.block_erase) ||
+		    !spi_mem_supports_op(spinand->spimem,
+					 &ctrl_ops->ops.page_read) ||
+		    !spi_mem_supports_op(spinand->spimem,
+					 &ctrl_ops->ops.program_execute))
+			continue;
+
+		return ctrl_ops;
+	}
+
+	return NULL;
+}
+
 /**
  * spinand_match_and_init() - Try to find a match between a device ID and an
  *			      entry in a spinand_info table
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index e5df6220ec1e..5dae0649f2fb 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -385,6 +385,18 @@ struct spinand_ctrl_ops {
 		.protocol = __protocol,						\
 	}
 
+struct spinand_ctrl_ops_variants {
+	const struct spinand_ctrl_ops *ctrl_ops_list;
+	unsigned int nvariants;
+};
+
+#define SPINAND_CTRL_OPS_VARIANTS(name, ...)					\
+	const struct spinand_ctrl_ops_variants name = {				\
+		.ctrl_ops_list = (struct spinand_ctrl_ops[]){ __VA_ARGS__ },	\
+		.nvariants = sizeof((struct spinand_ctrl_ops[]){ __VA_ARGS__ })/\
+			     sizeof(struct spinand_ctrl_ops),			\
+	}
+
 /**
  * spinand_ecc_info - description of the on-die ECC implemented by a SPI NAND
  *		      chip
@@ -442,6 +454,8 @@ struct spinand_info {
 		const struct spinand_op_variants *write_cache;
 		const struct spinand_op_variants *update_cache;
 	} data_ops_variants;
+
+	const struct spinand_ctrl_ops_variants *ctrl_ops_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 };
@@ -460,6 +474,9 @@ struct spinand_info {
 		.update_cache = __update,				\
 	}
 
+#define SPINAND_INFO_CTRL_OPS_VARIANTS(__ctrl_ops_variants)		\
+	.ctrl_ops_variants = __ctrl_ops_variants
+
 #define SPINAND_ECCINFO(__ooblayout, __get_status)			\
 	.eccinfo = {							\
 		.ooblayout = __ooblayout,				\
-- 
2.25.1

