Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9965A53D690
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 13:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbiFDLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 07:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiFDLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 07:31:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13E9B1A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 04:31:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so5510596wmz.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tR+KLmOud8HT/pd+Me16gLGcHM1HDhk7MyzO7aY9pbM=;
        b=W4F0CIlJ8Lmvg7s3KUBlRYMcmGduzASkvLsMJKFgUUMoioRu0oMZ6mMzY/30gRvayn
         m9xsskPDr/Z+ATTHLYpR9w1X0JgGgVE604juKGQ1CM+rwwmO7Du2JP8RabfYSmK+6Spo
         o7bhGCN7JiHVJEgRCxbbFij4WtSounaIsbwgA/O/Mn7LmY8Y50neflXLs9C8/Ohs1WZx
         guGp7h/MQB3SO5q7XplS7n2/8zQty9LGRY/or0lCrkSaJCjPfy3NSuOPEoF9Pfh7CYVi
         WuFUadtZwMjUDru5gd/8l04KqkZdcS8b7zcbi0QGeYZTO52jPCdAAtLg/fe5V9kS9rge
         cPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tR+KLmOud8HT/pd+Me16gLGcHM1HDhk7MyzO7aY9pbM=;
        b=a16C6uNy42AhDLOjyLtWNLqG8jLvwPrCKmr8+TKgihY54jwLrA4LN+lAF0T/7wyL63
         gvUyA1m4zIAwMdSi2odWYdFoBqb97Kpn765TNc8t7Q+Vb+qTDbPasbcMEI8ffUijmyro
         qMpUpSJ8fJbdL3WRajcKS00vteDwu2WTmzqRrvv+/8Hb4tBOIhYHAHfG75pcA4/Ltp9m
         NJnrGLHwKJckvFI3lRKVA9U8CuSvCzxNjzL7d3qcz97Xl0w7fNlBNZSjK0qY3OWYwuVf
         2jBzSAji4NiaCAtAybDMQOuyzt99LItVI7B2mMDZYuRzFPrBf1cb6s0Gp36f5SHE21eh
         WCUw==
X-Gm-Message-State: AOAM530JcHps9oeGDbFg5+/wVjFT1q59LJ0bqh5nl/e9hg8h/QstQjwx
        G9zXK2VyClykrzZLODKfq8Q=
X-Google-Smtp-Source: ABdhPJxmssWbL/3gOaM940vzFKBOAmaYaiRPJ+v+51nZu9fbtZ6zHmySHl6fiVZ4zDGXGqiM4sEIwA==
X-Received: by 2002:a05:600c:190b:b0:394:96d3:5780 with SMTP id j11-20020a05600c190b00b0039496d35780mr42631097wmq.82.1654342310211;
        Sat, 04 Jun 2022 04:31:50 -0700 (PDT)
Received: from localhost (92.40.202.88.threembb.co.uk. [92.40.202.88])
        by smtp.gmail.com with ESMTPSA id e11-20020adffd0b000000b0020e6ce4dabdsm10221095wrr.103.2022.06.04.04.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 04:31:49 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: spinand: Add support for ATO25D1GA
Date:   Sat,  4 Jun 2022 12:32:50 +0100
Message-Id: <20220604113250.4745-1-aidanmacdonald.0x0@gmail.com>
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

Add support for the ATO25D1GA SPI NAND flash.

Datasheet:
- https://atta.szlcsc.com/upload/public/pdf/source/20191212/C469320_04599D67B03B078044EB65FF5AEDDDE9.pdf

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
v2: Put core.o first in Makefile

 drivers/mtd/nand/spi/Makefile |  2 +-
 drivers/mtd/nand/spi/ato.c    | 86 +++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/spi/core.c   |  1 +
 include/linux/mtd/spinand.h   |  1 +
 4 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/ato.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 80dabe6ff0f3..b520fe634041 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o xtx.o
+spinand-objs := core.o ato.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
new file mode 100644
index 000000000000..82b377c06812
--- /dev/null
+++ b/drivers/mtd/nand/spi/ato.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Aidan MacDonald
+ *
+ * Author: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+
+#define SPINAND_MFR_ATO		0x9b
+
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+
+static int ato25d1ga_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 8;
+	region->length = 8;
+	return 0;
+}
+
+static int ato25d1ga_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	if (section) {
+		region->offset = (16 * section);
+		region->length = 8;
+	} else {
+		/* first byte of section 0 is reserved for the BBM */
+		region->offset = 1;
+		region->length = 7;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops ato25d1ga_ooblayout = {
+	.ecc = ato25d1ga_ooblayout_ecc,
+	.free = ato25d1ga_ooblayout_free,
+};
+
+
+static const struct spinand_info ato_spinand_table[] = {
+	SPINAND_INFO("ATO25D1GA",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x12),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&ato25d1ga_ooblayout, NULL)),
+};
+
+static const struct spinand_manufacturer_ops ato_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer ato_spinand_manufacturer = {
+	.id = SPINAND_MFR_ATO,
+	.name = "ATO",
+	.chips = ato_spinand_table,
+	.nchips = ARRAY_SIZE(ato_spinand_table),
+	.ops = &ato_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d5b685d1605e..9d73910a7ae8 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -927,6 +927,7 @@ static const struct nand_ops spinand_ops = {
 };
 
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
+	&ato_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5584d3bb6556..6d3392a7edc6 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -260,6 +260,7 @@ struct spinand_manufacturer {
 };
 
 /* SPI NAND manufacturers */
+extern const struct spinand_manufacturer ato_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
-- 
2.35.1

