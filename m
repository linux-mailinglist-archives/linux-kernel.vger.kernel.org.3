Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED7F4FF22F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiDMIl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiDMIlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:41:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FD34F9F2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:38:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id be5so1332045plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bva40hCaLIr1ELmfegrLbKYUXjrya+QMIfJXoLptDZI=;
        b=jn1H2G9sQRsFHuUbkWKDzp3rUKyRZFL8LjPfrbX7OybYyveACo8Xvz4oLMOAwfeR7x
         79RVwbzhxpXAaXfuiN45aswMQWM1WNheQOZlXYoVDuBvo9ge/hsoH1ekLaxy8ym2Hge6
         wGinY+Nw6s83uNwl+WQxEtpS5Wmn1RdO5fyahxh7SQ4+RdiRtGqTV6EMqVF0Ww/03Msk
         sPrS4gz8lNs8d0ko3lCRlHoaz8yPr6aSJ9dWX+zHuCt3U80BD9gBmycXJl01PMksY1go
         jdp7hDpfU9cyIWWaVtyTBbMOWhMdBd1Bhg8PlD46xEbcjs/O8usO+tQ6LU8kpYef5REN
         fUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bva40hCaLIr1ELmfegrLbKYUXjrya+QMIfJXoLptDZI=;
        b=pIrLNOPUSo1DypfV4xOCKV7CYJCPvNGn13a+qxPwnsXdlBBdPh/UtyTRRT9PxNdEhf
         sYkxMxaE4fv/evIARnd1n2EkUDvnYtzN5q8pz8GZ9dXjBSvwzZ4BmKu+rsI8jhuI+QAe
         Ni2O1Cp2Uo+wK5w/C6MTG4YoITRBWBHX5Dle3MAAo5ExALfNQkkrfkU9xF9SdhTTed3T
         zt+GHLgGcLLiOhYYeaGVJIB3PulTcGXJAWqPc6/C6SfAKLSQng1AVj4iX/ujK1FT4/5W
         hEdkQgfI1bmpOldbS85PiXWMNpNfmLyOipZlEKpGloQBfhVtiRT7vgtJj3NR6Gp8ZC48
         TBTQ==
X-Gm-Message-State: AOAM532yytqax/3NiSMlcqyVQSKuwXB2Ho2z8+Q/lUIrYUv33vqoz8DD
        gsiaD6SWMFi3r2btE7gvEX8=
X-Google-Smtp-Source: ABdhPJygofRLBPQWqf/xEplmXkc3AZ+4Noe2MlSvLi9WIlCn0DN5W6rn2iR1hT4EygX5R1aiMPR4VQ==
X-Received: by 2002:a17:902:e9d3:b0:158:8521:1e8f with SMTP id 19-20020a170902e9d300b0015885211e8fmr8071136plk.82.1649839114331;
        Wed, 13 Apr 2022 01:38:34 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id j6-20020aa79286000000b004fdf02851eesm33776264pfa.4.2022.04.13.01.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 01:38:33 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] mtd: spinand: add support for ESMT F50x1G41LB
Date:   Wed, 13 Apr 2022 16:38:19 +0800
Message-Id: <20220413083824.247136-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for ESMT F50L1G41LB and F50D1G41LB.
It seems that ESMT likes to use random JEDEC ID from other vendors.
Their 1G chips uses 0xc8 from GigaDevice and 2G/4G chips uses 0x2c from
Micron. For this reason, the ESMT entry is named esmt_c8 with explicit
JEDEC ID in variable name.

Datasheets:
https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50L1G41LB(2M).pdf
https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50D1G41LB(2M).pdf

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
This patch is made purely based on datasheet info without testing
on any actual chips.

Change since v1: drop 0x7f padding from SPINAND_ID.

 drivers/mtd/nand/spi/Makefile |  2 +-
 drivers/mtd/nand/spi/core.c   |  1 +
 drivers/mtd/nand/spi/esmt.c   | 94 +++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |  1 +
 4 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/esmt.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 9662b9c1d5a9..7e3ab8a9aec7 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
+spinand-objs := core.o esmt.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index ff8336870bc0..6c5d79ec3501 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -927,6 +927,7 @@ static const struct nand_ops spinand_ops = {
 };
 
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
+	&esmt_c8_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
new file mode 100644
index 000000000000..f86716332893
--- /dev/null
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author:
+ *	Chuanhong Guo <gch981213@gmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+/* ESMT uses GigaDevice 0xc8 JECDEC ID on some SPI NANDs */
+#define SPINAND_MFR_ESMT_C8			0xc8
+
+#define F50L2G41XA_ECC_STATUS_MASK		GENMASK(6, 4)
+#define F50L2G41XA_STATUS_ECC_1_3_BITFLIPS	(1 << 4)
+#define F50L2G41XA_STATUS_ECC_4_6_BITFLIPS	(3 << 4)
+#define F50L2G41XA_STATUS_ECC_7_8_BITFLIPS	(5 << 4)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+			   SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int f50l1g41lb_ooblayout_ecc(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = 16 * section + 8;
+	region->length = 8;
+
+	return 0;
+}
+
+static int f50l1g41lb_ooblayout_free(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = 16 * section + 2;
+	region->length = 6;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
+	.ecc = f50l1g41lb_ooblayout_ecc,
+	.free = f50l1g41lb_ooblayout_free,
+};
+
+static const struct spinand_info esmt_c8_spinand_table[] = {
+	SPINAND_INFO("F50L1G41LB",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+	SPINAND_INFO("F50D1G41LB",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+};
+
+static const struct spinand_manufacturer_ops esmt_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer esmt_c8_spinand_manufacturer = {
+	.id = SPINAND_MFR_ESMT_C8,
+	.name = "ESMT",
+	.chips = esmt_c8_spinand_table,
+	.nchips = ARRAY_SIZE(esmt_c8_spinand_table),
+	.ops = &esmt_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 3aa28240a77f..e19a1554a1e9 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -260,6 +260,7 @@ struct spinand_manufacturer {
 };
 
 /* SPI NAND manufacturers */
+extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
-- 
2.35.1

