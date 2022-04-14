Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B855017A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352671AbiDNPkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354239AbiDNOlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:41:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27935CD658
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:34:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so9486594pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnWHu1h/+5yNTn5DXI0S1gHlkBW/TpHNNelrkm6S6IY=;
        b=Tjwt6pWV2Berqzi+TohydZ73/ifhkoiX3EazgM1uAs8rQ3icJLd0DBI7d0ardo1Zar
         eRzPMt+fy8j2wSBaiHZzfSA0QY3pwybgQQw3jzWIwppHY+q20YZFEIcBB4gbAtzleHhT
         filJCCwaaf/lYeRveT+Km4MLeaNwmFc80ldFPhtE1nm+3kQIxpoW91NCAzMLA58BAcjH
         OoV4jn7Q6n4NSTCpUBJ7CW901yKYggw994z590dVHJzyqDBROlAYwFHMGbxvd8YSJWTI
         Pv97wFSotAHXPU2E28jvwYFcQcHpLBF7w3wSG7Mkm+n4FZVUN8oDjs4wVLCaZyZT0Gao
         kFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnWHu1h/+5yNTn5DXI0S1gHlkBW/TpHNNelrkm6S6IY=;
        b=TbFvHH9sZ+kGPwNZpW5yI1rD1pRKCwUiIzoXySr1vlZh09pZmVOwPIY9YQiHPoTitv
         shsYCLxta5z/DHhMPDrYTHRZa8aTCCTNRv+gktD7HTZptHDqF7HjiOyBEANezNFZwczI
         Kqi/PXcyIx/D+XD7TI9gL1WbluHx3keYuBNGgisWWVk0tEzBPeAPnTLRVymBQfiynUZr
         LPjPTO8OjdnBOsFEyO0gZerU9bMXsCIuOQ8S+mAF9mNtIyfeRiDCOZZ7+w1IxNB4RlQN
         vLpj+/3Pnmypc1Hzcz2kZf07DnzE01BQ+i75v6doYbUnQr+Ikt51vI/oZ8bYQvKOu3i+
         1G4Q==
X-Gm-Message-State: AOAM532oxjXAK4Co0xToejM7xNBAXwBdnj3k2P+xeB61hqLaK+gl7nOs
        jeZYeTvmycus82dVK+vGOsM=
X-Google-Smtp-Source: ABdhPJxHWXLkFulFWfn8EPHtiW5bOru/kn1SXdHqmrI642qlTynapF9/my+DZOX0i3BKZCOmRyHndg==
X-Received: by 2002:a17:902:9b87:b0:156:bf3e:9ab5 with SMTP id y7-20020a1709029b8700b00156bf3e9ab5mr47469427plp.119.1649946880623;
        Thu, 14 Apr 2022 07:34:40 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090ac50500b001cd5ffcca96sm4411017pjt.27.2022.04.14.07.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 07:34:40 -0700 (PDT)
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
Subject: [PATCH 1/2] mtd: spinand: add support for detection with param page
Date:   Thu, 14 Apr 2022 22:34:25 +0800
Message-Id: <20220414143426.723168-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414143426.723168-1-gch981213@gmail.com>
References: <20220414143426.723168-1-gch981213@gmail.com>
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

SPI-NAND detection using chip ID isn't always reliable.
Here are two known cases:
1. ESMT uses JEDEC ID from other vendors. This may collapse with future
   chips.
2. Winbond W25N01KV uses the exact same JEDEC ID as W25N01GV while
   having completely different chip parameters.

Recent SPI-NANDs have a parameter page which is stored in the same
format as raw NAND ONFI data. There are strings for chip manufacturer
and chip model. Chip ECC requirement and memory organization are
available too.
This patch adds support for detecting SPI-NANDs with the parameter page
after ID matching failed. In this detection, memory organization and
ECC requirements are taken from the parameter page, and other SPI-NAND
specific parameters are obtained by matching chip model string with
a separated table.

It's common for vendors to release a series of SPI-NANDs with the same
SPI-NAND parameters in different voltages and/or capacities. The chip
table defined in this patch supports multiple model strings in one
entry, and multiple chip models can be covered using only one entry.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---

I'm not brave enough to touch raw nand code without testing, so
sanitize_string, onfi_crc16 and nand_bit_wise_majority are
duplicated from raw/nand_onfi.c into spi/onfi.c

 drivers/mtd/nand/spi/Makefile |   2 +-
 drivers/mtd/nand/spi/core.c   |  23 +--
 drivers/mtd/nand/spi/onfi.c   | 296 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |  50 ++++++
 4 files changed, 359 insertions(+), 12 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/onfi.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 9662b9c1d5a9..a4e057cbdaf7 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
+spinand-objs := core.o gigadevice.o macronix.o micron.o onfi.o paragon.o toshiba.o winbond.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index ff8336870bc0..3b51ca7232d0 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -20,7 +20,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
-static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
+int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
 						      spinand->scratchbuf);
@@ -34,7 +34,7 @@ static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 	return 0;
 }
 
-static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
 {
 	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
 						      spinand->scratchbuf);
@@ -339,7 +339,7 @@ static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
 		engine_conf->status = status;
 }
 
-static int spinand_write_enable_op(struct spinand_device *spinand)
+int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
 
@@ -496,10 +496,8 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand,
-			unsigned long initial_delay_us,
-			unsigned long poll_delay_us,
-			u8 *s)
+int spinand_wait(struct spinand_device *spinand, unsigned long initial_delay_us,
+		 unsigned long poll_delay_us, u8 *s)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(REG_STATUS,
 						      spinand->scratchbuf);
@@ -1006,7 +1004,7 @@ static void spinand_manufacturer_cleanup(struct spinand_device *spinand)
 		return spinand->manufacturer->ops->cleanup(spinand);
 }
 
-static const struct spi_mem_op *
+const struct spi_mem_op *
 spinand_select_op_variant(struct spinand_device *spinand,
 			  const struct spinand_op_variants *variants)
 {
@@ -1117,9 +1115,12 @@ static int spinand_detect(struct spinand_device *spinand)
 
 	ret = spinand_id_detect(spinand);
 	if (ret) {
-		dev_err(dev, "unknown raw ID %*phN\n", SPINAND_MAX_ID_LEN,
-			spinand->id.data);
-		return ret;
+		ret = spinand_onfi_detect(spinand);
+		if (ret) {
+			dev_err(dev, "unknown raw ID %*phN\n",
+				SPINAND_MAX_ID_LEN, spinand->id.data);
+			return ret;
+		}
 	}
 
 	if (nand->memorg.ntargets > 1 && !spinand->select_target) {
diff --git a/drivers/mtd/nand/spi/onfi.c b/drivers/mtd/nand/spi/onfi.c
new file mode 100644
index 000000000000..5cc888e3d038
--- /dev/null
+++ b/drivers/mtd/nand/spi/onfi.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Detect and match SPI-NAND info using ONFI parameter page
+ *
+ * Author:
+ *	Chuanhong Guo <gch981213@gmail.com>
+ *
+ * Part of this code comes from nand_onfi.c in raw nand support.
+ *
+ */
+#include <linux/crc16.h>
+#include <linux/mtd/onfi.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_IDR_EN BIT(6)
+#define SPINAND_PARAM_PAGE 1
+#define ONFI_PARAM_PAGES 3
+
+/* Sanitize ONFI strings so we can safely print them */
+static void sanitize_string(uint8_t *s, size_t len)
+{
+	ssize_t i;
+
+	/* Null terminate */
+	s[len - 1] = 0;
+
+	/* Remove non printable chars */
+	for (i = 0; i < len - 1; i++) {
+		if (s[i] < ' ' || s[i] > 127)
+			s[i] = '?';
+	}
+
+	/* Remove trailing spaces */
+	strim(s);
+}
+
+static u16 onfi_crc16(u16 crc, u8 const *p, size_t len)
+{
+	int i;
+
+	while (len--) {
+		crc ^= *p++ << 8;
+		for (i = 0; i < 8; i++)
+			crc = (crc << 1) ^ ((crc & 0x8000) ? 0x8005 : 0);
+	}
+
+	return crc;
+}
+
+static int spinand_onfi_read(struct spinand_device *spinand, void *buf,
+			     size_t len)
+{
+	const struct spi_mem_op load_page =
+		SPINAND_PAGE_READ_OP(SPINAND_PARAM_PAGE);
+	struct spi_mem_op read_cache =
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, buf, len);
+	int ret;
+	u8 cfg;
+
+	ret = spinand_read_reg_op(spinand, REG_CFG, &cfg);
+	if (ret)
+		return ret;
+
+	ret = spinand_write_enable_op(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_write_reg_op(spinand, REG_CFG, cfg | SPINAND_IDR_EN);
+	if (ret)
+		return ret;
+
+	ret = spinand_read_reg_op(spinand, REG_CFG, &cfg);
+	if (ret)
+		return ret;
+
+	if (!(cfg & SPINAND_IDR_EN))
+		return -EINVAL;
+
+	ret = spi_mem_exec_op(spinand->spimem, &load_page);
+	if (ret)
+		goto cleanup;
+
+	ret = spinand_wait(spinand, SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US, NULL);
+	if (ret)
+		goto cleanup;
+
+	while (len) {
+		ret = spi_mem_adjust_op_size(spinand->spimem, &read_cache);
+		if (ret)
+			goto cleanup;
+		ret = spi_mem_exec_op(spinand->spimem, &read_cache);
+		if (ret)
+			goto cleanup;
+		read_cache.addr.val += read_cache.data.nbytes;
+		read_cache.data.buf.in += read_cache.data.nbytes;
+		len -= read_cache.data.nbytes;
+		read_cache.data.nbytes = len;
+	}
+cleanup:
+	spinand_write_reg_op(spinand, REG_CFG, cfg & ~SPINAND_IDR_EN);
+	return ret;
+}
+
+static bool spinand_onfi_validate(const struct nand_onfi_params *p)
+{
+	u16 crc;
+
+	if (strncmp("ONFI", p->sig, 4))
+		return false;
+	crc = onfi_crc16(ONFI_CRC_BASE, (u8 *)p, sizeof(*p) - 2);
+	return crc == le16_to_cpu(p->crc);
+}
+
+/*
+ * Recover data with bit-wise majority
+ */
+static void nand_bit_wise_majority(const void **srcbufs, unsigned int nsrcbufs,
+				   void *dstbuf, unsigned int bufsize)
+{
+	int i, j, k;
+
+	for (i = 0; i < bufsize; i++) {
+		u8 val = 0;
+
+		for (j = 0; j < 8; j++) {
+			unsigned int cnt = 0;
+
+			for (k = 0; k < nsrcbufs; k++) {
+				const u8 *srcbuf = srcbufs[k];
+
+				if (srcbuf[i] & BIT(j))
+					cnt++;
+			}
+
+			if (cnt > nsrcbufs / 2)
+				val |= BIT(j);
+		}
+
+		((u8 *)dstbuf)[i] = val;
+	}
+}
+
+static const struct spinand_manufacturer *spinand_onfi_manufacturers[] = {};
+
+static const struct spinand_onfi_info *
+spinand_onfi_chip_match(struct nand_onfi_params *p,
+			const struct spinand_manufacturer *m)
+{
+	size_t i, j;
+
+	for (i = 0; i < m->nchips; i++)
+		for (j = 0; m->onfi_chips[i].models[j]; j++)
+			if (!strcasecmp(m->onfi_chips[i].models[j], p->model))
+				return &m->onfi_chips[i];
+	return NULL;
+}
+
+static const struct spinand_onfi_info *
+spinand_onfi_manufacturer_match(struct spinand_device *spinand,
+				struct nand_onfi_params *p)
+{
+	const struct spinand_onfi_info *ret;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(spinand_onfi_manufacturers); i++) {
+		if (strcasecmp(spinand_onfi_manufacturers[i]->name,
+			       p->manufacturer))
+			continue;
+		spinand->manufacturer = spinand_onfi_manufacturers[i];
+		ret = spinand_onfi_chip_match(p, spinand_onfi_manufacturers[i]);
+		if (ret)
+			return ret;
+	}
+	return NULL;
+}
+
+/**
+ * spinand_onfi_detect() - match SPI-NAND using ONFI parameter page
+ * @spinand: spinand private structure
+ *
+ * Return:
+ *  0: Success
+ *  -EINVAL: failed to read a valid parameter page
+ *  -EOPNOTSUPP: chip isn't supported
+ */
+int spinand_onfi_detect(struct spinand_device *spinand)
+{
+	struct nand_onfi_params *p = NULL, *pbuf;
+	size_t params_len = sizeof(*pbuf) * ONFI_PARAM_PAGES;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct nand_memory_organization *memorg = nanddev_get_memorg(nand);
+	const struct spi_mem_op *op;
+	const struct spinand_onfi_info *info;
+	int i, ret;
+
+	pbuf = kzalloc(params_len, GFP_KERNEL);
+	if (!pbuf)
+		return -ENOMEM;
+
+	ret = spinand_onfi_read(spinand, pbuf, params_len);
+	if (ret)
+		goto cleanup;
+
+	for (i = 0; i < ONFI_PARAM_PAGES; i++) {
+		if (spinand_onfi_validate(&pbuf[i])) {
+			p = &pbuf[i];
+			break;
+		}
+	}
+
+	if (!p) {
+		const void *srcbufs[ONFI_PARAM_PAGES];
+		unsigned int j;
+
+		for (j = 0; j < ONFI_PARAM_PAGES; j++)
+			srcbufs[j] = pbuf + j;
+		nand_bit_wise_majority(srcbufs, ONFI_PARAM_PAGES, pbuf,
+				       sizeof(*pbuf));
+		if (spinand_onfi_validate(pbuf))
+			p = pbuf;
+	}
+
+	if (!p) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
+	sanitize_string(p->model, sizeof(p->model));
+
+	info = spinand_onfi_manufacturer_match(spinand, p);
+	if (!info) {
+		dev_err(&spinand->spimem->spi->dev, "unknown chip: %s %s",
+			p->manufacturer, p->model);
+		ret = -EOPNOTSUPP;
+		goto cleanup;
+	}
+
+	/* setup memory organization using info from parameter page */
+	memorg->pagesize = le32_to_cpu(p->byte_per_page);
+
+	/*
+	 * pages_per_block and blocks_per_lun may not be a power-of-2 size
+	 * (don't ask me who thought of this...). MTD assumes that these
+	 * dimensions will be power-of-2, so just truncate the remaining area.
+	 */
+	memorg->pages_per_eraseblock =
+		1 << (fls(le32_to_cpu(p->pages_per_block)) - 1);
+	memorg->oobsize = le16_to_cpu(p->spare_bytes_per_page);
+	memorg->luns_per_target = p->lun_count;
+	memorg->planes_per_lun = 1 << p->interleaved_bits;
+	memorg->ntargets = 1;
+
+	/* See erasesize comment */
+	memorg->eraseblocks_per_lun =
+		1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
+	memorg->max_bad_eraseblocks_per_lun = le32_to_cpu(p->blocks_per_lun);
+	memorg->bits_per_cell = p->bits_per_cell;
+
+	if (p->ecc_bits != 0xff) {
+		struct nand_ecc_props requirements = {
+			.strength = p->ecc_bits,
+			.step_size = p->data_bytes_per_ppage,
+		};
+
+		nanddev_set_ecc_requirements(nand, &requirements);
+	} else {
+		ret = -EINVAL;
+	}
+
+	/* setup spi-nand specific ops */
+	spinand->eccinfo = info->eccinfo;
+	spinand->flags = info->flags;
+	spinand->id.len = 0;
+	spinand->select_target = info->select_target;
+
+	op = spinand_select_op_variant(spinand, info->op_variants.read_cache);
+	if (!op)
+		return -EOPNOTSUPP;
+
+	spinand->op_templates.read_cache = op;
+
+	op = spinand_select_op_variant(spinand, info->op_variants.write_cache);
+	if (!op)
+		return -EOPNOTSUPP;
+
+	spinand->op_templates.write_cache = op;
+
+	op = spinand_select_op_variant(spinand, info->op_variants.update_cache);
+	spinand->op_templates.update_cache = op;
+
+cleanup:
+	kfree(pbuf);
+	return ret;
+}
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 3aa28240a77f..dc218082d773 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -255,6 +255,7 @@ struct spinand_manufacturer {
 	u8 id;
 	char *name;
 	const struct spinand_info *chips;
+	const struct spinand_onfi_info *onfi_chips;
 	const size_t nchips;
 	const struct spinand_manufacturer_ops *ops;
 };
@@ -386,6 +387,46 @@ struct spinand_info {
 		__VA_ARGS__						\
 	}
 
+/**
+ * struct spinand_onfi_info - Structure used to describe SPI NAND with ONFI
+ *			      parameter page
+ * @models: Model name array. Null terminated.
+ * @flags: OR-ing of the SPINAND_XXX flags
+ * @eccinfo: on-die ECC info
+ * @op_variants: operations variants
+ * @op_variants.read_cache: variants of the read-cache operation
+ * @op_variants.write_cache: variants of the write-cache operation
+ * @op_variants.update_cache: variants of the update-cache operation
+ * @select_target: function used to select a target/die. Required only for
+ *		   multi-die chips
+ *
+ * Each SPI NAND manufacturer driver should have a spinand_onfi_info table
+ * describing all the chips supported by the driver.
+ */
+struct spinand_onfi_info {
+	const char **const models;
+	u32 flags;
+	struct spinand_ecc_info eccinfo;
+	struct {
+		const struct spinand_op_variants *read_cache;
+		const struct spinand_op_variants *write_cache;
+		const struct spinand_op_variants *update_cache;
+	} op_variants;
+	int (*select_target)(struct spinand_device *spinand,
+			     unsigned int target);
+};
+
+#define SPINAND_ONFI_MODELS(...)					\
+	.models = (const char *[]){ __VA_ARGS__, NULL }
+
+#define SPINAND_ONFI_INFO(__models, __op_variants, __flags, ...)	\
+	{								\
+		__models,						\
+		.op_variants = __op_variants,				\
+		.flags = __flags,					\
+		__VA_ARGS__						\
+	}
+
 struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *wdesc;
 	struct spi_mem_dirmap_desc *rdesc;
@@ -511,7 +552,16 @@ int spinand_match_and_init(struct spinand_device *spinand,
 			   unsigned int table_size,
 			   enum spinand_readid_method rdid_method);
 
+int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val);
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
+int spinand_write_enable_op(struct spinand_device *spinand);
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
+int spinand_onfi_detect(struct spinand_device *spinand);
+const struct spi_mem_op *
+spinand_select_op_variant(struct spinand_device *spinand,
+			  const struct spinand_op_variants *variants);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
+int spinand_wait(struct spinand_device *spinand, unsigned long initial_delay_us,
+		 unsigned long poll_delay_us, u8 *s);
 
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.35.1

