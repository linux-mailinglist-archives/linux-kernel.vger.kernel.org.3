Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1583A52DD60
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244292AbiESTBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244276AbiESTBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:01:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DBC5253C;
        Thu, 19 May 2022 12:01:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k30so8449097wrd.5;
        Thu, 19 May 2022 12:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f68KFx8ALNZB6j37feZZWw0w08dzwdFXpx63QXr396Y=;
        b=OgK07FDz8Sjdyk9AxxtZmGOVY2ZFToeWFZV5Y63YAu7q20D5LfU385GORXBquE9+eK
         Ki9KiDblDSZbQ/VOdMGf+J6DJ6aj/Z/uemVWDtePVgIJjthWsh7Kg1mAQUmt2tMnmvcb
         0lpct4eCRRX5pKKE5lBilPWmxv5RZJoA1Xx0ViaEW9AA1PzfNAdTWmfFnGRRUsFTqj0T
         4xefvBWhGezynAqKMfp+U1/xk/DFoAlKo0K6/AImlm8zfpNo4ewlwGOv3imQ06Wk2EyG
         AIjc+liD3NzqBxLxZ9lLh9nWPYJIyQLzmGd7+VMnP07HOlzfv7o9accX5El4MnCUcDvt
         zQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f68KFx8ALNZB6j37feZZWw0w08dzwdFXpx63QXr396Y=;
        b=J7/f54wstudenyMZ7ppRrr+P23A+1QDox88MKjpZCgm2Fvuhw9744HNnWat0mJnILk
         GBSF8conJpJRZNo1lLoY7UJw51Fje/IGUxcvFkYZ0ujwlpkBvjonZbK2S8PUpsi9gWPd
         NYWpNz2vf780rJMjVzXrefM959PhpERWZI73qCr6ZTkEeYuFgnQ18z3wOAAMf4iddKye
         oPpke0ESLcusN8uFTekGDkYtVuJapfLOOxe7iiZyJn6Z7FQXI0us4U2EnHt98XnAFO9K
         S748xkunWkwhF5/uHCmwjr1/Hn2R888qPU4UcuOYkn2mvyn6OrHX8CXqJGZF91SF8323
         9c3w==
X-Gm-Message-State: AOAM532B+DoZglCfRY8dXHWow4EqOaroHfzLt1siJ6aB3YVxjd2Z7D9U
        2lgWcqmbaXldvLymPwD54DI=
X-Google-Smtp-Source: ABdhPJwEUhjFa3IOetuutr8i2DWru2xxSEVcPhLC2oTecWKZzsHAH5KH7e4YQdIn+gpGTKj4V4VQkA==
X-Received: by 2002:adf:aa8a:0:b0:20d:130a:c5f6 with SMTP id h10-20020adfaa8a000000b0020d130ac5f6mr5321839wrc.537.1652986886131;
        Thu, 19 May 2022 12:01:26 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id h11-20020a05600c414b00b00395b809dfd3sm333767wmm.12.2022.05.19.12.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:01:25 -0700 (PDT)
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
Subject: [PATCH v4 1/2] mtd: nand: raw: qcom_nandc: add support for unprotected spare data pages
Date:   Thu, 19 May 2022 21:01:11 +0200
Message-Id: <20220519190112.6344-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220519190112.6344-1-ansuelsmth@gmail.com>
References: <20220519190112.6344-1-ansuelsmth@gmail.com>
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

IPQ8064 nand have special pages where the spare data is not protected by
ECC. These special page are used by boot partition and on reading them
lots of warning are reported about wrong ECC data and if written to
results in broken data and not bootable device.

Under the hood these special page are just normal page with the spare
data not protected by ECC.

Add support for this by permitting the user to declare these special
pages in dts by declaring offset and size of the partition. The driver
internally will convert these value to nand pages.

On user read/write the page is checked and if it's a boot page the
correct configuration is applied.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 148 +++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 1a77542c6d67..289aef4f191d 100644
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
@@ -418,6 +421,19 @@ struct qcom_nand_controller {
 	const struct qcom_nandc_props *props;
 };
 
+/*
+ * NAND special boot pages
+ *
+ * @offset:			offset of the page where spare data is not protected
+ *				by ECC
+ * @size:			size of the page where spare data is not protected
+ *				by ECC
+ */
+struct qcom_nand_boot_page {
+	u32 offset;
+	u32 size;
+};
+
 /*
  * NAND chip structure
  *
@@ -444,6 +460,13 @@ struct qcom_nand_controller {
  * @cfg0, cfg1, cfg0_raw..:	NANDc register configurations needed for
  *				ecc/non-ecc mode for the current nand flash
  *				device
+ *
+ * @unprotect_spare_data:	keep track of the current ecc configuration used by
+ *				the driver for read/write operation.
+ * @boot_pages_count:		count of the boot pages where spare data is not
+ *				protected by ECC
+ * @boot_pages:			array of boot pages where offset and size of the
+ *				boot pages are stored
  */
 struct qcom_nand_host {
 	struct nand_chip chip;
@@ -466,6 +489,10 @@ struct qcom_nand_host {
 	u32 ecc_bch_cfg;
 	u32 clrflashstatus;
 	u32 clrreadstatus;
+
+	bool unprotect_spare_data;
+	int boot_pages_count;
+	struct qcom_nand_boot_page *boot_pages;
 };
 
 /*
@@ -475,6 +502,7 @@ struct qcom_nand_host {
  * @is_bam - whether NAND controller is using BAM
  * @is_qpic - whether NAND CTRL is part of qpic IP
  * @qpic_v2 - flag to indicate QPIC IP version 2
+ * @has_boot_pages - whether NAND has different ecc settings for boot pages
  * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
  */
 struct qcom_nandc_props {
@@ -482,6 +510,7 @@ struct qcom_nandc_props {
 	bool is_bam;
 	bool is_qpic;
 	bool qpic_v2;
+	bool has_boot_pages;
 	u32 dev_cmd_reg_start;
 };
 
@@ -1701,7 +1730,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
 	oob_size1 = host->bbm_size;
 
-	if (qcom_nandc_is_last_cw(ecc, cw)) {
+	if (qcom_nandc_is_last_cw(ecc, cw) && !host->unprotect_spare_data) {
 		data_size2 = ecc->size - data_size1 -
 			     ((ecc->steps - 1) * 4);
 		oob_size2 = (ecc->steps * 4) + host->ecc_bytes_hw +
@@ -1782,7 +1811,7 @@ check_for_erased_page(struct qcom_nand_host *host, u8 *data_buf,
 	}
 
 	for_each_set_bit(cw, &uncorrectable_cws, ecc->steps) {
-		if (qcom_nandc_is_last_cw(ecc, cw)) {
+		if (qcom_nandc_is_last_cw(ecc, cw) && !host->unprotect_spare_data) {
 			data_size = ecc->size - ((ecc->steps - 1) * 4);
 			oob_size = (ecc->steps * 4) + host->ecc_bytes_hw;
 		} else {
@@ -1940,7 +1969,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 	for (i = 0; i < ecc->steps; i++) {
 		int data_size, oob_size;
 
-		if (qcom_nandc_is_last_cw(ecc, i)) {
+		if (qcom_nandc_is_last_cw(ecc, i) && !host->unprotect_spare_data) {
 			data_size = ecc->size - ((ecc->steps - 1) << 2);
 			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
 				   host->spare_bytes;
@@ -2037,6 +2066,52 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 	return ret;
 }
 
+static bool
+qcom_nandc_is_boot_page(struct qcom_nand_host *host, int page)
+{
+	struct qcom_nand_boot_page *boot_page;
+	u32 start, end;
+	int i;
+
+	for (i = 0; i < host->boot_pages_count; i++) {
+		boot_page = &host->boot_pages[i];
+		start = boot_page->offset;
+		end = start + boot_page->size;
+		/* Boot page are at the start of the nand.
+		 * Check the page from the boot page end first
+		 * to save one extra check.
+		 */
+		if (page < end && page >= start)
+			return 1;
+	}
+
+	return 0;
+}
+
+static void
+qcom_nandc_check_boot_pages(struct qcom_nand_host *host, int page)
+{
+	bool unprotect_spare_data = qcom_nandc_is_boot_page(host, page);
+
+	/* Skip conf write if we are already in the correct mode */
+	if (unprotect_spare_data == host->unprotect_spare_data)
+		return;
+
+	host->unprotect_spare_data = unprotect_spare_data;
+
+	host->cw_data = unprotect_spare_data ? 512 : 516;
+	host->spare_bytes = host->cw_size - host->ecc_bytes_hw -
+			    host->bbm_size - host->cw_data;
+
+	host->cfg0 &= ~(SPARE_SIZE_BYTES_MASK | UD_SIZE_BYTES_MASK);
+	host->cfg0 |= host->spare_bytes << SPARE_SIZE_BYTES |
+		      host->cw_data << UD_SIZE_BYTES;
+
+	host->ecc_bch_cfg &= ~ECC_NUM_DATA_BYTES_MASK;
+	host->ecc_bch_cfg |= host->cw_data << ECC_NUM_DATA_BYTES;
+	host->ecc_buf_cfg = (unprotect_spare_data ? 0x1ff : 0x203) << NUM_STEPS;
+}
+
 /* implements ecc->read_page() */
 static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
 				int oob_required, int page)
@@ -2045,6 +2120,9 @@ static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	u8 *data_buf, *oob_buf = NULL;
 
+	if (host->boot_pages_count)
+		qcom_nandc_check_boot_pages(host, page);
+
 	nand_read_page_op(chip, page, 0, NULL, 0);
 	data_buf = buf;
 	oob_buf = oob_required ? chip->oob_poi : NULL;
@@ -2064,6 +2142,9 @@ static int qcom_nandc_read_page_raw(struct nand_chip *chip, uint8_t *buf,
 	int cw, ret;
 	u8 *data_buf = buf, *oob_buf = chip->oob_poi;
 
+	if (host->boot_pages_count)
+		qcom_nandc_check_boot_pages(host, page);
+
 	for (cw = 0; cw < ecc->steps; cw++) {
 		ret = qcom_nandc_read_cw_raw(mtd, chip, data_buf, oob_buf,
 					     page, cw);
@@ -2084,6 +2165,9 @@ static int qcom_nandc_read_oob(struct nand_chip *chip, int page)
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 
+	if (host->boot_pages_count)
+		qcom_nandc_check_boot_pages(host, page);
+
 	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
 
@@ -2104,6 +2188,9 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 	u8 *data_buf, *oob_buf;
 	int i, ret;
 
+	if (host->boot_pages_count)
+		qcom_nandc_check_boot_pages(host, page);
+
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 
 	clear_read_regs(nandc);
@@ -2119,7 +2206,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 	for (i = 0; i < ecc->steps; i++) {
 		int data_size, oob_size;
 
-		if (qcom_nandc_is_last_cw(ecc, i)) {
+		if (qcom_nandc_is_last_cw(ecc, i) && !host->unprotect_spare_data) {
 			data_size = ecc->size - ((ecc->steps - 1) << 2);
 			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
 				   host->spare_bytes;
@@ -2176,6 +2263,9 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 	u8 *data_buf, *oob_buf;
 	int i, ret;
 
+	if (host->boot_pages_count)
+		qcom_nandc_check_boot_pages(host, page);
+
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
@@ -2194,7 +2284,7 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 		data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
 		oob_size1 = host->bbm_size;
 
-		if (qcom_nandc_is_last_cw(ecc, i)) {
+		if (qcom_nandc_is_last_cw(ecc, i) && !host->unprotect_spare_data) {
 			data_size2 = ecc->size - data_size1 -
 				     ((ecc->steps - 1) << 2);
 			oob_size2 = (ecc->steps << 2) + host->ecc_bytes_hw +
@@ -2254,6 +2344,9 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
 	int data_size, oob_size;
 	int ret;
 
+	if (host->boot_pages_count)
+		qcom_nandc_check_boot_pages(host, page);
+
 	host->use_ecc = true;
 	clear_bam_transaction(nandc);
 
@@ -2902,6 +2995,48 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
 
 static const char * const probes[] = { "cmdlinepart", "ofpart", "qcomsmem", NULL };
 
+static int qcom_nand_host_parse_boot_pages(struct qcom_nand_controller *nandc,
+					   struct qcom_nand_host *host,
+					   struct device_node *dn)
+{
+	struct nand_chip *chip = &host->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct qcom_nand_boot_page *boot_page;
+	struct device *dev = nandc->dev;
+	int pages_count, i, ret;
+
+	if (!nandc->props->has_boot_pages)
+		return 0;
+
+	pages_count = of_property_count_u32_elems(dn, "qcom,boot-pages");
+	if (pages_count < 0) {
+		dev_err(dev, "Error parsing boot_pages. Ignoring.");
+		return 0;
+	}
+
+	host->boot_pages_count = pages_count / 2;
+	host->boot_pages = devm_kcalloc(dev, host->boot_pages_count,
+					sizeof(*host->boot_pages), GFP_KERNEL);
+	if (!host->boot_pages)
+		return 0;
+
+	ret = of_property_read_u32_array(dn, "qcom,boot-pages", (u32 *)host->boot_pages,
+					 pages_count);
+	if (ret) {
+		dev_err(dev, "Error reading boot_pages. Ignoring.");
+		return 0;
+	}
+
+	/* Convert offset to nand pages */
+	for (i = 0 ; i < host->boot_pages_count; i++) {
+		boot_page = &host->boot_pages[i];
+		boot_page->offset /= mtd->writesize;
+		boot_page->size /= mtd->writesize;
+	}
+
+	return 0;
+}
+
 static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 					    struct qcom_nand_host *host,
 					    struct device_node *dn)
@@ -2970,6 +3105,8 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 	if (ret)
 		nand_cleanup(chip);
 
+	qcom_nand_host_parse_boot_pages(nandc, host, dn);
+
 	return ret;
 }
 
@@ -3135,6 +3272,7 @@ static int qcom_nandc_remove(struct platform_device *pdev)
 static const struct qcom_nandc_props ipq806x_nandc_props = {
 	.ecc_modes = (ECC_RS_4BIT | ECC_BCH_8BIT),
 	.is_bam = false,
+	.has_boot_pages = true,
 	.dev_cmd_reg_start = 0x0,
 };
 
-- 
2.34.1

