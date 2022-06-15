Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105B154BF05
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbiFOBA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiFOBAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:00:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D253207E;
        Tue, 14 Jun 2022 18:00:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so288170wms.3;
        Tue, 14 Jun 2022 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOdZeYuV7GkVqPupZgAuMtBvoLOoa6tTUb0OkZyxymA=;
        b=Nv0nYBGoq7tegE1ol2SjNki1h5G5Y7jh5Wm73h/8XoqloNBd1OBlUnZwwOhh2zuFZ9
         gBK1eiNsmKpdkfUnlXYrWNjBnyDPbgCgqd+Wiy4aR9qDWNGZXaLsPmySiX4yk165AGHa
         nvflai1vFlZfgIhPOhrW3qCVWowqhL/WB+Ar0Nk34FLKltf+LVRWM58WH+cQu9oIR3OK
         ZkQhm7lQJF5ScILm13ZdNQsgBceE0GxL8fD3Sp1OQHMjuLX1bZn1QygueoGGy57DOpR1
         C0zewGYJQt/ezMe11Bng+jBuKYKwJi64fVvj0RW1rl1qkdErdI0tK+LhJ9YnDocFQLOE
         p90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOdZeYuV7GkVqPupZgAuMtBvoLOoa6tTUb0OkZyxymA=;
        b=blfmiYY9elL7LvH6p4uvB0PQ5rE4A9niWZyJzvZvMUECvSfkSpe+Cczi2dVIRSUNeu
         i27n+iYo+psVVD/qOvhu9k+FLKKJ49xYQsvcAqBbW3TQqv5kaoy3KtIFjm6wYTZrjC0h
         ai8Tbwu5J+LuUlnr74nO+HGWYI+p2y2kLYZLg+pe9akx9iyJ9SQ9yV7l0N5MG8s/TCXX
         LXxE/Ijb3qeFHK/gSoVF6AF30uyHIYMAiPgAhQBOxsXO4a+T9E0j1AkFkAHVrzt+jhJy
         TCGyTrdheA7jsfgubecfjOE4xzk9ggfsvg1Q7WiJWTwY9+j3bC19sssRLr9Lw8SF8IUn
         jnfQ==
X-Gm-Message-State: AOAM530jNBqYhZRP6EoVo2BGXvFt0C9/q5Jwzi+KAeGA5ZeIfJKUdMj0
        NTWKcv9rwVgfZ7D4RVvPvIQ=
X-Google-Smtp-Source: ABdhPJwQP0BoteErIIYKSZXkUAbooYehYXX0N2VWnvyqkgRp/1zdb+MCFFuKXtIxa280F4WF0P6sJw==
X-Received: by 2002:a05:600c:4fcb:b0:39c:64cd:cc89 with SMTP id o11-20020a05600c4fcb00b0039c64cdcc89mr7002797wmq.197.1655254814400;
        Tue, 14 Jun 2022 18:00:14 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id g10-20020a5d698a000000b0021020517639sm12890265wru.102.2022.06.14.18.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 18:00:12 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v7 2/3] mtd: nand: raw: qcom_nandc: add support for unprotected spare data pages
Date:   Wed, 15 Jun 2022 02:06:11 +0200
Message-Id: <20220615000612.3119-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615000612.3119-1-ansuelsmth@gmail.com>
References: <20220615000612.3119-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8064 nand have special pages where a different layout scheme is used.
These special page are used by boot partition and on reading them
lots of warning are reported about wrong ECC data and if written to
results in broken data and not bootable device.

The layout scheme used by these special page consist in using 512 bytes
as the codeword size (even for the last codeword) while writing to CFG0
register. This forces the NAND controller to unprotect the 4 bytes of
spare data.

Since the kernel is unaware of this different layout for these special
page, it does try to protect the spare data too during read/write and
warn about CRC errors.

Add support for this by permitting the user to declare these special
pages in dts by declaring offset and size of the partition. The driver
internally will convert these value to nand pages.

On user read/write the page is checked and if it's a boot page the
correct layout is used.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 203 +++++++++++++++++++++++++++++-
 1 file changed, 198 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index f2990d721733..0dbfe32888ff 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -80,8 +80,10 @@
 #define	DISABLE_STATUS_AFTER_WRITE	4
 #define	CW_PER_PAGE			6
 #define	UD_SIZE_BYTES			9
+#define	UD_SIZE_BYTES_MASK		GENMASK(18, 9)
 #define	ECC_PARITY_SIZE_BYTES_RS	19
 #define	SPARE_SIZE_BYTES		23
+#define	SPARE_SIZE_BYTES_MASK		GENMASK(26, 23)
 #define	NUM_ADDR_CYCLES			27
 #define	STATUS_BFR_READ			30
 #define	SET_RD_MODE_AFTER_STATUS	31
@@ -102,6 +104,7 @@
 #define	ECC_MODE			4
 #define	ECC_PARITY_SIZE_BYTES_BCH	8
 #define	ECC_NUM_DATA_BYTES		16
+#define	ECC_NUM_DATA_BYTES_MASK		GENMASK(25, 16)
 #define	ECC_FORCE_CLK_OPEN		30
 
 /* NAND_DEV_CMD1 bits */
@@ -431,13 +434,32 @@ struct qcom_nand_controller {
 	u32 cmd1, vld;
 };
 
+/*
+ * NAND special boot partitions
+ *
+ * @page_offset:		offset of the partition where spare data is not protected
+ *				by ECC (value in pages)
+ * @page_offset:		size of the partition where spare data is not protected
+ *				by ECC (value in pages)
+ */
+struct qcom_nand_boot_partition {
+	u32 page_offset;
+	u32 page_size;
+};
+
 /*
  * NAND chip structure
  *
+ * @boot_partitions:		array of boot partitions where offset and size of the
+ *				boot partitions are stored
+ *
  * @chip:			base NAND chip structure
  * @node:			list node to add itself to host_list in
  *				qcom_nand_controller
  *
+ * @nr_boot_partitions:		count of the boot partitions where spare data is not
+ *				protected by ECC
+ *
  * @cs:				chip select value for this chip
  * @cw_size:			the number of bytes in a single step/codeword
  *				of a page, consisting of all data, ecc, spare
@@ -456,14 +478,20 @@ struct qcom_nand_controller {
  *
  * @status:			value to be returned if NAND_CMD_STATUS command
  *				is executed
+ * @codeword_fixup:		keep track of the current layout used by
+ *				the driver for read/write operation.
  * @use_ecc:			request the controller to use ECC for the
  *				upcoming read/write
  * @bch_enabled:		flag to tell whether BCH ECC mode is used
  */
 struct qcom_nand_host {
+	struct qcom_nand_boot_partition *boot_partitions;
+
 	struct nand_chip chip;
 	struct list_head node;
 
+	int nr_boot_partitions;
+
 	int cs;
 	int cw_size;
 	int cw_data;
@@ -481,6 +509,7 @@ struct qcom_nand_host {
 	u32 clrreadstatus;
 
 	u8 status;
+	bool codeword_fixup;
 	bool use_ecc;
 	bool bch_enabled;
 };
@@ -493,6 +522,7 @@ struct qcom_nand_host {
  * @is_bam - whether NAND controller is using BAM
  * @is_qpic - whether NAND CTRL is part of qpic IP
  * @qpic_v2 - flag to indicate QPIC IP version 2
+ * @use_codeword_fixup - whether NAND has different layout for boot partitions
  */
 struct qcom_nandc_props {
 	u32 ecc_modes;
@@ -500,6 +530,7 @@ struct qcom_nandc_props {
 	bool is_bam;
 	bool is_qpic;
 	bool qpic_v2;
+	bool use_codeword_fixup;
 };
 
 /* Frees the BAM transaction memory */
@@ -1718,7 +1749,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
 	oob_size1 = host->bbm_size;
 
-	if (qcom_nandc_is_last_cw(ecc, cw)) {
+	if (qcom_nandc_is_last_cw(ecc, cw) && !host->codeword_fixup) {
 		data_size2 = ecc->size - data_size1 -
 			     ((ecc->steps - 1) * 4);
 		oob_size2 = (ecc->steps * 4) + host->ecc_bytes_hw +
@@ -1799,7 +1830,7 @@ check_for_erased_page(struct qcom_nand_host *host, u8 *data_buf,
 	}
 
 	for_each_set_bit(cw, &uncorrectable_cws, ecc->steps) {
-		if (qcom_nandc_is_last_cw(ecc, cw)) {
+		if (qcom_nandc_is_last_cw(ecc, cw) && !host->codeword_fixup) {
 			data_size = ecc->size - ((ecc->steps - 1) * 4);
 			oob_size = (ecc->steps * 4) + host->ecc_bytes_hw;
 		} else {
@@ -1957,7 +1988,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 	for (i = 0; i < ecc->steps; i++) {
 		int data_size, oob_size;
 
-		if (qcom_nandc_is_last_cw(ecc, i)) {
+		if (qcom_nandc_is_last_cw(ecc, i) && !host->codeword_fixup) {
 			data_size = ecc->size - ((ecc->steps - 1) << 2);
 			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
 				   host->spare_bytes;
@@ -2054,6 +2085,70 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 	return ret;
 }
 
+static bool qcom_nandc_is_boot_partition(struct qcom_nand_host *host, int page)
+{
+	struct qcom_nand_boot_partition *boot_partition;
+	u32 start, end;
+	int i;
+
+	/*
+	 * Since the frequent access will be to the non-boot partitions like rootfs,
+	 * optimize the page check by:
+
+	 * 1. Checking if the page lies after the last boot partition.
+	 * 2. Checking from the boot partition end.
+	 */
+
+	/* First check the last boot partition */
+	boot_partition = &host->boot_partitions[host->nr_boot_partitions - 1];
+	start = boot_partition->page_offset;
+	end = start + boot_partition->page_size;
+
+	/* Page is after the last boot partition end. This is NOT a boot partition */
+	if (page > end)
+		return false;
+
+	/* Actually check if it's a boot partition */
+	if (page < end && page >= start)
+		return true;
+
+	/* Check the other boot partition starting from the second-last partition */
+	for (i = host->nr_boot_partitions - 2; i >= 0; i--) {
+		boot_partition = &host->boot_partitions[i];
+		start = boot_partition->page_offset;
+		end = start + boot_partition->page_size;
+
+		if (page < end && page >= start)
+			return true;
+	}
+
+	return false;
+}
+
+static void
+qcom_nandc_codeword_fixup(struct qcom_nand_host *host, int page)
+{
+	bool codeword_fixup = qcom_nandc_is_boot_partition(host, page);
+
+	/* Skip conf write if we are already in the correct mode */
+	if (codeword_fixup == host->codeword_fixup)
+		return;
+
+	host->codeword_fixup = codeword_fixup;
+
+	host->cw_data = codeword_fixup ? 512 : 516;
+	host->spare_bytes = host->cw_size - host->ecc_bytes_hw -
+			    host->bbm_size - host->cw_data;
+
+	host->cfg0 &= ~(SPARE_SIZE_BYTES_MASK | UD_SIZE_BYTES_MASK);
+	host->cfg0 |= host->spare_bytes << SPARE_SIZE_BYTES |
+		      host->cw_data << UD_SIZE_BYTES;
+
+	host->ecc_bch_cfg &= ~ECC_NUM_DATA_BYTES_MASK;
+	host->ecc_bch_cfg |= host->cw_data << ECC_NUM_DATA_BYTES;
+	host->ecc_buf_cfg = (host->cw_data - 1) << NUM_STEPS;
+}
+
 /* implements ecc->read_page() */
 static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
 				int oob_required, int page)
@@ -2062,6 +2157,9 @@ static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	u8 *data_buf, *oob_buf = NULL;
 
+	if (host->nr_boot_partitions)
+		qcom_nandc_codeword_fixup(host, page);
+
 	nand_read_page_op(chip, page, 0, NULL, 0);
 	data_buf = buf;
 	oob_buf = oob_required ? chip->oob_poi : NULL;
@@ -2081,6 +2179,9 @@ static int qcom_nandc_read_page_raw(struct nand_chip *chip, uint8_t *buf,
 	int cw, ret;
 	u8 *data_buf = buf, *oob_buf = chip->oob_poi;
 
+	if (host->nr_boot_partitions)
+		qcom_nandc_codeword_fixup(host, page);
+
 	for (cw = 0; cw < ecc->steps; cw++) {
 		ret = qcom_nandc_read_cw_raw(mtd, chip, data_buf, oob_buf,
 					     page, cw);
@@ -2101,6 +2202,9 @@ static int qcom_nandc_read_oob(struct nand_chip *chip, int page)
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 
+	if (host->nr_boot_partitions)
+		qcom_nandc_codeword_fixup(host, page);
+
 	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
 
@@ -2121,6 +2225,9 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 	u8 *data_buf, *oob_buf;
 	int i, ret;
 
+	if (host->nr_boot_partitions)
+		qcom_nandc_codeword_fixup(host, page);
+
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 
 	clear_read_regs(nandc);
@@ -2136,7 +2243,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 	for (i = 0; i < ecc->steps; i++) {
 		int data_size, oob_size;
 
-		if (qcom_nandc_is_last_cw(ecc, i)) {
+		if (qcom_nandc_is_last_cw(ecc, i) && !host->codeword_fixup) {
 			data_size = ecc->size - ((ecc->steps - 1) << 2);
 			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
 				   host->spare_bytes;
@@ -2193,6 +2300,9 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 	u8 *data_buf, *oob_buf;
 	int i, ret;
 
+	if (host->nr_boot_partitions)
+		qcom_nandc_codeword_fixup(host, page);
+
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
@@ -2211,7 +2321,7 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 		data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
 		oob_size1 = host->bbm_size;
 
-		if (qcom_nandc_is_last_cw(ecc, i)) {
+		if (qcom_nandc_is_last_cw(ecc, i) && !host->codeword_fixup) {
 			data_size2 = ecc->size - data_size1 -
 				     ((ecc->steps - 1) << 2);
 			oob_size2 = (ecc->steps << 2) + host->ecc_bytes_hw +
@@ -2271,6 +2381,9 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
 	int data_size, oob_size;
 	int ret;
 
+	if (host->nr_boot_partitions)
+		qcom_nandc_codeword_fixup(host, page);
+
 	host->use_ecc = true;
 	clear_bam_transaction(nandc);
 
@@ -2919,6 +3032,77 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
 
 static const char * const probes[] = { "cmdlinepart", "ofpart", "qcomsmem", NULL };
 
+static int qcom_nand_host_parse_boot_partitions(struct qcom_nand_controller *nandc,
+						struct qcom_nand_host *host,
+						struct device_node *dn)
+{
+	struct nand_chip *chip = &host->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct qcom_nand_boot_partition *boot_partition;
+	struct device *dev = nandc->dev;
+	int partitions_count, i, j, ret;
+
+	if (!of_find_property(dn, "qcom,boot-partitions", NULL))
+		return 0;
+
+	partitions_count = of_property_count_u32_elems(dn, "qcom,boot-partitions");
+	if (partitions_count <= 0) {
+		dev_err(dev, "Error parsing boot partition\n");
+		if (partitions_count == 0)
+			return -EINVAL;
+		else
+			return partitions_count;
+	}
+
+	host->nr_boot_partitions = partitions_count / 2;
+	host->boot_partitions = devm_kcalloc(dev, host->nr_boot_partitions,
+					     sizeof(*host->boot_partitions), GFP_KERNEL);
+	if (!host->boot_partitions) {
+		host->nr_boot_partitions = 0;
+		return -ENOMEM;
+	}
+
+	for (i = 0, j = 0; i < host->nr_boot_partitions; i++, j += 2) {
+		boot_partition = &host->boot_partitions[i];
+
+		ret = of_property_read_u32_index(dn, "qcom,boot-partitions", j,
+						 &boot_partition->page_offset);
+		if (ret) {
+			dev_err(dev, "Error parsing boot partition offset at index %d\n", i);
+			host->nr_boot_partitions = 0;
+			return ret;
+		}
+
+		if (boot_partition->page_offset % mtd->writesize) {
+			dev_err(dev, "Boot partition offset not multiple of writesize at index %i\n",
+				i);
+			host->nr_boot_partitions = 0;
+			return -EINVAL;
+		}
+		/* Convert offset to nand pages */
+		boot_partition->page_offset /= mtd->writesize;
+
+		ret = of_property_read_u32_index(dn, "qcom,boot-partitions", j + 1,
+						 &boot_partition->page_size);
+		if (ret) {
+			dev_err(dev, "Error parsing boot partition size at index %d\n", i);
+			host->nr_boot_partitions = 0;
+			return ret;
+		}
+
+		if (boot_partition->page_size % mtd->writesize) {
+			dev_err(dev, "Boot partition size not multiple of writesize at index %i\n",
+				i);
+			host->nr_boot_partitions = 0;
+			return -EINVAL;
+		}
+		/* Convert size to nand pages */
+		boot_partition->page_size /= mtd->writesize;
+	}
+
+	return 0;
+}
+
 static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 					    struct qcom_nand_host *host,
 					    struct device_node *dn)
@@ -2987,6 +3171,14 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 	if (ret)
 		nand_cleanup(chip);
 
+	if (nandc->props->use_codeword_fixup) {
+		ret = qcom_nand_host_parse_boot_partitions(nandc, host, dn);
+		if (ret) {
+			nand_cleanup(chip);
+			return ret;
+		}
+	}
+
 	return ret;
 }
 
@@ -3152,6 +3344,7 @@ static int qcom_nandc_remove(struct platform_device *pdev)
 static const struct qcom_nandc_props ipq806x_nandc_props = {
 	.ecc_modes = (ECC_RS_4BIT | ECC_BCH_8BIT),
 	.is_bam = false,
+	.use_codeword_fixup = true,
 	.dev_cmd_reg_start = 0x0,
 };
 
-- 
2.36.1

