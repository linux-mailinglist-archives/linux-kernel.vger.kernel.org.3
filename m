Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E6C5452B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244386AbiFIRMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiFIRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:11:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F41C206121;
        Thu,  9 Jun 2022 10:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E357CB82BCD;
        Thu,  9 Jun 2022 17:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668A0C34114;
        Thu,  9 Jun 2022 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654794713;
        bh=0baujAxOxtu9nlFlWgA3ofK6gmRM2jyD7B9ffXWaQzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IP9Z8uZm4QXHgp51TChdd+OsPx4GO5svd/avqg97vDQdbytSCDg3iOvSEDvdsptM2
         9ji/3JLFftOdq5RS9yh+5paknZpTyV0K+aGbB7u1LhHVqDZhdgxuPyXMVB+EtjNJkM
         rSmOI/e1/TYCWgvz+2yvnn4jEhT512jMuTnv73xeXwXuf3wUt6sV66GVfNME5zJug2
         RY7lc5vjRF7EKO6x/qQ6J+AcMj69fJ53v+44hHXfxy0ppaT6M2IsDMU5ZYKichms0s
         CSlgoJ0AYJWWG1EaMi4IBj5kuCuMVRhUZ/cX2vLmCtWo2f2B+sCi1kY3nKS/VogMDc
         /AfRdtiW58jZw==
Date:   Thu, 9 Jun 2022 22:41:41 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] mtd: nand: raw: qcom_nandc: add support for
 unprotected spare data pages
Message-ID: <20220609171141.GB5081@thinkpad>
References: <20220609132344.17548-1-ansuelsmth@gmail.com>
 <20220609132344.17548-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609132344.17548-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 03:23:43PM +0200, Ansuel Smith wrote:
> IPQ8064 nand have special pages where a different layout scheme is used.
> These special page are used by boot partition and on reading them
> lots of warning are reported about wrong ECC data and if written to
> results in broken data and not bootable device.
> 
> The layout scheme used by these special page consist in using 512 bytes
> as the codeword size (even for the last codeword) while writing to CFG0
> register. This forces the NAND controller to unprotect the 4 bytes of
> spare data.
> 
> Since the kernel is unaware of this different layout for these special
> page, it does try to protect the spare data too during read/write and
> warn about CRC errors.
> 
> Add support for this by permitting the user to declare these special
> pages in dts by declaring offset and size of the partition. The driver
> internally will convert these value to nand pages.
> 
> On user read/write the page is checked and if it's a boot page the
> correct layout is used.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 204 +++++++++++++++++++++++++++++-
>  1 file changed, 199 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 7fbbd3e7784c..29a16534bee3 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -80,8 +80,10 @@
>  #define	DISABLE_STATUS_AFTER_WRITE	4
>  #define	CW_PER_PAGE			6
>  #define	UD_SIZE_BYTES			9
> +#define	UD_SIZE_BYTES_MASK		GENMASK(18, 9)
>  #define	ECC_PARITY_SIZE_BYTES_RS	19
>  #define	SPARE_SIZE_BYTES		23
> +#define	SPARE_SIZE_BYTES_MASK		GENMASK(26, 23)
>  #define	NUM_ADDR_CYCLES			27
>  #define	STATUS_BFR_READ			30
>  #define	SET_RD_MODE_AFTER_STATUS	31
> @@ -102,6 +104,7 @@
>  #define	ECC_MODE			4
>  #define	ECC_PARITY_SIZE_BYTES_BCH	8
>  #define	ECC_NUM_DATA_BYTES		16
> +#define	ECC_NUM_DATA_BYTES_MASK		GENMASK(25, 16)
>  #define	ECC_FORCE_CLK_OPEN		30
>  
>  /* NAND_DEV_CMD1 bits */
> @@ -418,6 +421,19 @@ struct qcom_nand_controller {
>  	const struct qcom_nandc_props *props;
>  };
>  
> +/*
> + * NAND special boot partitions
> + *
> + * @page_offset:		offset of the partition where spare data is not protected
> + *				by ECC (value in pages)
> + * @page_offset:		size of the partition where spare data is not protected
> + *				by ECC (value in pages)
> + */
> +struct qcom_nand_boot_partition {
> +	u32 page_offset;
> +	u32 page_size;
> +};
> +
>  /*
>   * NAND chip structure
>   *
> @@ -434,6 +450,8 @@ struct qcom_nand_controller {
>   * @ecc_bytes_hw:		ECC bytes used by controller hardware for this
>   *				chip
>   *
> + * @codeword_fixup:		keep track of the current layout used by
> + *				the driver for read/write operation.
>   * @use_ecc:			request the controller to use ECC for the
>   *				upcoming read/write
>   * @bch_enabled:		flag to tell whether BCH ECC mode is used
> @@ -445,6 +463,11 @@ struct qcom_nand_controller {
>   * @cfg0, cfg1, cfg0_raw..:	NANDc register configurations needed for
>   *				ecc/non-ecc mode for the current nand flash
>   *				device
> + *
> + * @nr_boot_partitions:		count of the boot partitions where spare data is not
> + *				protected by ECC
> + * @boot_partitions:		array of boot partitions where offset and size of the
> + *				boot partitions are stored
>   */
>  struct qcom_nand_host {
>  	struct nand_chip chip;
> @@ -457,6 +480,7 @@ struct qcom_nand_host {
>  	int spare_bytes;
>  	int bbm_size;
>  
> +	bool codeword_fixup;
>  	bool use_ecc;
>  	bool bch_enabled;
>  	u8 status;
> @@ -468,6 +492,9 @@ struct qcom_nand_host {
>  	u32 ecc_bch_cfg;
>  	u32 clrflashstatus;
>  	u32 clrreadstatus;
> +
> +	int nr_boot_partitions;
> +	struct qcom_nand_boot_partition *boot_partitions;
>  };
>  
>  /*
> @@ -477,6 +504,7 @@ struct qcom_nand_host {
>   * @is_bam - whether NAND controller is using BAM
>   * @is_qpic - whether NAND CTRL is part of qpic IP
>   * @qpic_v2 - flag to indicate QPIC IP version 2
> + * @use_codeword_fixup - whether NAND has different layout for boot partitions
>   * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
>   */
>  struct qcom_nandc_props {
> @@ -484,6 +512,7 @@ struct qcom_nandc_props {
>  	bool is_bam;
>  	bool is_qpic;
>  	bool qpic_v2;
> +	bool use_codeword_fixup;
>  	u32 dev_cmd_reg_start;
>  };
>  
> @@ -1703,7 +1732,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
>  	oob_size1 = host->bbm_size;
>  
> -	if (qcom_nandc_is_last_cw(ecc, cw)) {
> +	if (qcom_nandc_is_last_cw(ecc, cw) && !host->codeword_fixup) {
>  		data_size2 = ecc->size - data_size1 -
>  			     ((ecc->steps - 1) * 4);
>  		oob_size2 = (ecc->steps * 4) + host->ecc_bytes_hw +
> @@ -1784,7 +1813,7 @@ check_for_erased_page(struct qcom_nand_host *host, u8 *data_buf,
>  	}
>  
>  	for_each_set_bit(cw, &uncorrectable_cws, ecc->steps) {
> -		if (qcom_nandc_is_last_cw(ecc, cw)) {
> +		if (qcom_nandc_is_last_cw(ecc, cw) && !host->codeword_fixup) {
>  			data_size = ecc->size - ((ecc->steps - 1) * 4);
>  			oob_size = (ecc->steps * 4) + host->ecc_bytes_hw;
>  		} else {
> @@ -1942,7 +1971,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
>  	for (i = 0; i < ecc->steps; i++) {
>  		int data_size, oob_size;
>  
> -		if (qcom_nandc_is_last_cw(ecc, i)) {
> +		if (qcom_nandc_is_last_cw(ecc, i) && !host->codeword_fixup) {
>  			data_size = ecc->size - ((ecc->steps - 1) << 2);
>  			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
>  				   host->spare_bytes;
> @@ -2039,6 +2068,78 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
>  	return ret;
>  }
>  
> +static bool qcom_nandc_is_boot_partition(struct qcom_nand_host *host, int page)
> +{
> +	struct qcom_nand_boot_partition *boot_partition;
> +	u32 start, end;
> +	int i;
> +
> +	/*
> +	 * Since the frequent access will be to the non-boot partitions like rootfs,
> +	 * optimize the page check by:
> +
> +	 * 1. Checking if the page lies after the last boot partition.

This is not implemented in code.

> +	 * 2. Checking from the boot partition end.
> +	 *

I think we can leave the below example part. I just asked to include the actual
usecase and above points suffice.

> +	 * This comes from the fact that an example partition table is:
> +	 * mtd0: 00c80000 00020000 "qcadata"	(require codeword fix)
> +	 * mtd1: 00500000 00020000 "APPSBL"	(require codeword fix)
> +	 * mtd2: 00080000 00020000 "APPSBLENV"	(doesn't require codeword fix)
> +	 * mtd3: 00140000 00020000 "art"	(doesn't require codeword fix)
> +	 * mtd4: 00140000 00020000 "artbak"	(doesn't require codeword fix)
> +	 * mtd5: 00400000 00020000 "kernel"	(doesn't require codeword fix)
> +	 * mtd6: 06080000 00020000 "ubi"	(doesn't require codeword fix)
> +	 * mtd7: 00700000 00020000 "reserve"	(doesn't require codeword fix)
> +	 *
> +	 * where the boot partition are always the first partition and rootfs
> +	 * partition are at the end.
> +	 *
> +	 * Defining a big single boot partition is not possible since some
> +	 * device have the following partition table:
> +	 * mtd0: 00c80000 00020000 "qcadata" (require codeword fix)
> +	 * mtd1: 00500000 00020000 "APPSBL"  (require codeword fix)
> +	 * mtd2: 00080000 00020000 "APPSBLENV" (doesn't require codeword fix)
> +	 * mtd3: 00140000 00020000 "APPSBL2"  (require codeword fix)
> +	 *
> +	 * where a backup partition is placed after a partition where the
> +	 * codeword fix should not be used.
> +	 */
> +	for (i = host->nr_boot_partitions - 1; i >= 0; i--) {
> +		boot_partition = &host->boot_partitions[i];
> +		start = boot_partition->page_offset;
> +		end = start + boot_partition->page_size;
> +
> +		if (page < end && page >= start)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void
> +qcom_nandc_codeword_fixup(struct qcom_nand_host *host, int page)
> +{
> +	bool codeword_fixup = qcom_nandc_is_boot_partition(host, page);
> +
> +	/* Skip conf write if we are already in the correct mode */
> +	if (codeword_fixup == host->codeword_fixup)
> +		return;
> +
> +	host->codeword_fixup = codeword_fixup;
> +
> +	host->cw_data = codeword_fixup ? 512 : 516;
> +	host->spare_bytes = host->cw_size - host->ecc_bytes_hw -
> +			    host->bbm_size - host->cw_data;
> +
> +	host->cfg0 &= ~(SPARE_SIZE_BYTES_MASK | UD_SIZE_BYTES_MASK);
> +	host->cfg0 |= host->spare_bytes << SPARE_SIZE_BYTES |
> +		      host->cw_data << UD_SIZE_BYTES;
> +
> +	host->ecc_bch_cfg &= ~ECC_NUM_DATA_BYTES_MASK;
> +	host->ecc_bch_cfg |= host->cw_data << ECC_NUM_DATA_BYTES;
> +	host->ecc_buf_cfg = (host->cw_data - 1) << NUM_STEPS;
> +}
> +
>  /* implements ecc->read_page() */
>  static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
>  				int oob_required, int page)
> @@ -2047,6 +2148,9 @@ static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>  	u8 *data_buf, *oob_buf = NULL;
>  
> +	if (host->nr_boot_partitions)
> +		qcom_nandc_codeword_fixup(host, page);
> +
>  	nand_read_page_op(chip, page, 0, NULL, 0);
>  	data_buf = buf;
>  	oob_buf = oob_required ? chip->oob_poi : NULL;
> @@ -2066,6 +2170,9 @@ static int qcom_nandc_read_page_raw(struct nand_chip *chip, uint8_t *buf,
>  	int cw, ret;
>  	u8 *data_buf = buf, *oob_buf = chip->oob_poi;
>  
> +	if (host->nr_boot_partitions)
> +		qcom_nandc_codeword_fixup(host, page);
> +
>  	for (cw = 0; cw < ecc->steps; cw++) {
>  		ret = qcom_nandc_read_cw_raw(mtd, chip, data_buf, oob_buf,
>  					     page, cw);
> @@ -2086,6 +2193,9 @@ static int qcom_nandc_read_oob(struct nand_chip *chip, int page)
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
>  
> +	if (host->nr_boot_partitions)
> +		qcom_nandc_codeword_fixup(host, page);
> +
>  	clear_read_regs(nandc);
>  	clear_bam_transaction(nandc);
>  
> @@ -2106,6 +2216,9 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
>  	u8 *data_buf, *oob_buf;
>  	int i, ret;
>  
> +	if (host->nr_boot_partitions)
> +		qcom_nandc_codeword_fixup(host, page);
> +
>  	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>  
>  	clear_read_regs(nandc);
> @@ -2121,7 +2234,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
>  	for (i = 0; i < ecc->steps; i++) {
>  		int data_size, oob_size;
>  
> -		if (qcom_nandc_is_last_cw(ecc, i)) {
> +		if (qcom_nandc_is_last_cw(ecc, i) && !host->codeword_fixup) {
>  			data_size = ecc->size - ((ecc->steps - 1) << 2);
>  			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
>  				   host->spare_bytes;
> @@ -2178,6 +2291,9 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
>  	u8 *data_buf, *oob_buf;
>  	int i, ret;
>  
> +	if (host->nr_boot_partitions)
> +		qcom_nandc_codeword_fixup(host, page);
> +
>  	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>  	clear_read_regs(nandc);
>  	clear_bam_transaction(nandc);
> @@ -2196,7 +2312,7 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
>  		data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
>  		oob_size1 = host->bbm_size;
>  
> -		if (qcom_nandc_is_last_cw(ecc, i)) {
> +		if (qcom_nandc_is_last_cw(ecc, i) && !host->codeword_fixup) {
>  			data_size2 = ecc->size - data_size1 -
>  				     ((ecc->steps - 1) << 2);
>  			oob_size2 = (ecc->steps << 2) + host->ecc_bytes_hw +
> @@ -2256,6 +2372,9 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
>  	int data_size, oob_size;
>  	int ret;
>  
> +	if (host->nr_boot_partitions)
> +		qcom_nandc_codeword_fixup(host, page);
> +
>  	host->use_ecc = true;
>  	clear_bam_transaction(nandc);
>  
> @@ -2904,6 +3023,74 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
>  
>  static const char * const probes[] = { "cmdlinepart", "ofpart", "qcomsmem", NULL };
>  
> +static int qcom_nand_host_parse_boot_partitions(struct qcom_nand_controller *nandc,
> +						struct qcom_nand_host *host,
> +						struct device_node *dn)
> +{
> +	struct nand_chip *chip = &host->chip;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct qcom_nand_boot_partition *boot_partition;
> +	struct device *dev = nandc->dev;
> +	int partitions_count, i, j, ret;
> +
> +	if (!of_find_property(dn, "qcom,boot-partitions", NULL))
> +		return 0;
> +
> +	partitions_count = of_property_count_u32_elems(dn, "qcom,boot-partitions");
> +	if (partitions_count <= 0) {
> +		dev_err(dev, "Error parsing boot partition\n");
> +		return ret;
> +	}
> +
> +	host->nr_boot_partitions = partitions_count / 2;
> +	host->boot_partitions = devm_kcalloc(dev, host->nr_boot_partitions,
> +					     sizeof(*host->boot_partitions), GFP_KERNEL);
> +	if (!host->boot_partitions) {
> +		host->nr_boot_partitions = 0;
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0, j = 0; i < host->nr_boot_partitions; i++, j += 2) {
> +		boot_partition = &host->boot_partitions[i];
> +
> +		ret = of_property_read_u32_index(dn, "qcom,boot-partitions", j,
> +						 &boot_partition->page_offset);
> +		if (ret) {
> +			dev_err(dev, "Error parsing boot partition offset at index %d", i);

Err... You missed adding newline here and below.

> +			host->nr_boot_partitions = 0;
> +			return ret;
> +		}
> +
> +		if (boot_partition->page_offset % mtd->writesize) {
> +			dev_err(dev, "Boot partition offset not multiple of writesize at index %i\n",
> +				i);
> +			host->nr_boot_partitions = 0;
> +			return -EINVAL;
> +		}
> +		/* Convert offset to nand pages */
> +		boot_partition->page_offset /= mtd->writesize;
> +
> +		ret = of_property_read_u32_index(dn, "qcom,boot-partitions", j + 1,
> +						 &boot_partition->page_size);
> +		if (ret) {
> +			dev_err(dev, "Error parsing boot partition size at index %d\n", i);
> +			host->nr_boot_partitions = 0;
> +			return ret;
> +		}
> +
> +		if (boot_partition->page_size % mtd->writesize) {
> +			dev_err(dev, "Boot partition size not multiple of writesize at index %i",
> +				i);
> +			host->nr_boot_partitions = 0;
> +			return -EINVAL;
> +		}
> +		/* Convert size to nand pages */
> +		boot_partition->page_size /= mtd->writesize;
> +	}
> +
> +	return 0;
> +}
> +
>  static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
>  					    struct qcom_nand_host *host,
>  					    struct device_node *dn)
> @@ -2972,6 +3159,12 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
>  	if (ret)
>  		nand_cleanup(chip);
>  
> +	if (nandc->props->use_codeword_fixup) {
> +		ret = qcom_nand_host_parse_boot_partitions(nandc, host, dn);
> +		if (ret)
> +			return ret;

Missed nand_cleanup().

Thanks,
Mani

> +	}
> +
>  	return ret;
>  }
>  
> @@ -3137,6 +3330,7 @@ static int qcom_nandc_remove(struct platform_device *pdev)
>  static const struct qcom_nandc_props ipq806x_nandc_props = {
>  	.ecc_modes = (ECC_RS_4BIT | ECC_BCH_8BIT),
>  	.is_bam = false,
> +	.use_codeword_fixup = true,
>  	.dev_cmd_reg_start = 0x0,
>  };
>  
> -- 
> 2.36.1
> 

-- 
மணிவண்ணன் சதாசிவம்
