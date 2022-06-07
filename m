Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E013F540F9A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 21:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354997AbiFGTK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 15:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350793AbiFGSXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 14:23:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1445C1EC9;
        Tue,  7 Jun 2022 10:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3EEF6159C;
        Tue,  7 Jun 2022 17:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1C2C34115;
        Tue,  7 Jun 2022 17:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654624450;
        bh=N2HpP649Pyz7gdMBv34La6YNqe/tnO/A22HbdsDKRmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0TmmOfMIINqWF0rAkRbZHsZkJx1YigLEfjzSjHGn6kcqymdymq4uGPvgu6JFWgLO
         l5IIXseMQfFZ4uZUcVqlC2aR8DomxBO6xL3thYv+KnnbjXJig3wgx5QyHAdYWPaoAy
         60+fLZZdAwL0jTCkxxAujO+oHmNyxSoLBon3tcRvxWBfHThAkCcaK9SViqLWI1gmzj
         HZnkDKiGBAnNZ5a8Okvy/kltzMis1rFIbjSZgUSBaZXpxV2RjlRsE69ydqpVfDBT3Q
         1b/Lhv0gj/MYtCYgtDx62TZlzp0sJtGnaMmrwFt/+T8+ULyVrbOX11WA/SDXyKGaPA
         RCZ66vNNPCfpA==
Date:   Tue, 7 Jun 2022 23:23:54 +0530
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_sricharan@quicinc.com, quic_mdalam@quicinc.com
Subject: Re: [PATCH v4 1/2] mtd: nand: raw: qcom_nandc: add support for
 unprotected spare data pages
Message-ID: <20220607175354.GB1882@thinkpad>
References: <20220519190112.6344-1-ansuelsmth@gmail.com>
 <20220519190112.6344-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220519190112.6344-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Sricharan, Alam

On Thu, May 19, 2022 at 09:01:11PM +0200, Ansuel Smith wrote:
> IPQ8064 nand have special pages where the spare data is not protected by
> ECC. These special page are used by boot partition and on reading them
> lots of warning are reported about wrong ECC data and if written to
> results in broken data and not bootable device.
> 

After checking internally I gathered more information on this issue. The
problem is that the boot partitions are using a different layout scheme compared
to other partitions like rootfs. This is because, the boot partitions are
accessed by bootloader like u-boot that uses the modified layout.

And the modified layout uses 512 bytes as the codeword size (even for the last
codeword) while writing to the CFG0 register. This forces the NAND controller
to unprotect the 4 bytes of spare data. So if kernel is unaware of this layout,
it will try to protect the spare data too during read/write to these partitions
and that will result in CRC errors.

So please update the commit message with above info.

> Under the hood these special page are just normal page with the spare
> data not protected by ECC.
> 
> Add support for this by permitting the user to declare these special
> pages in dts by declaring offset and size of the partition. The driver
> internally will convert these value to nand pages.
> 
> On user read/write the page is checked and if it's a boot page the
> correct configuration is applied.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 148 +++++++++++++++++++++++++++++-
>  1 file changed, 143 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 1a77542c6d67..289aef4f191d 100644
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
> + * NAND special boot pages

s/page/partitions everywhere

> + *
> + * @offset:			offset of the page where spare data is not protected
> + *				by ECC
> + * @size:			size of the page where spare data is not protected
> + *				by ECC
> + */
> +struct qcom_nand_boot_page {
> +	u32 offset;
> +	u32 size;
> +};
> +
>  /*
>   * NAND chip structure
>   *
> @@ -444,6 +460,13 @@ struct qcom_nand_controller {
>   * @cfg0, cfg1, cfg0_raw..:	NANDc register configurations needed for
>   *				ecc/non-ecc mode for the current nand flash
>   *				device
> + *
> + * @unprotect_spare_data:	keep track of the current ecc configuration used by
> + *				the driver for read/write operation.

Unprotected spare data is the effect of using a different codeword size. So use
something like, @codeword_fixup.

> + * @boot_pages_count:		count of the boot pages where spare data is not
> + *				protected by ECC
> + * @boot_pages:			array of boot pages where offset and size of the
> + *				boot pages are stored
>   */
>  struct qcom_nand_host {
>  	struct nand_chip chip;
> @@ -466,6 +489,10 @@ struct qcom_nand_host {
>  	u32 ecc_bch_cfg;
>  	u32 clrflashstatus;
>  	u32 clrreadstatus;
> +
> +	bool unprotect_spare_data;
> +	int boot_pages_count;
> +	struct qcom_nand_boot_page *boot_pages;

Reorganize the members to avoid holes.

>  };
>  
>  /*
> @@ -475,6 +502,7 @@ struct qcom_nand_host {
>   * @is_bam - whether NAND controller is using BAM
>   * @is_qpic - whether NAND CTRL is part of qpic IP
>   * @qpic_v2 - flag to indicate QPIC IP version 2
> + * @has_boot_pages - whether NAND has different ecc settings for boot pages

@use_codeword_fixup?

>   * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
>   */
>  struct qcom_nandc_props {
> @@ -482,6 +510,7 @@ struct qcom_nandc_props {
>  	bool is_bam;
>  	bool is_qpic;
>  	bool qpic_v2;
> +	bool has_boot_pages;
>  	u32 dev_cmd_reg_start;
>  };
>  
> @@ -1701,7 +1730,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
>  	oob_size1 = host->bbm_size;
>  
> -	if (qcom_nandc_is_last_cw(ecc, cw)) {
> +	if (qcom_nandc_is_last_cw(ecc, cw) && !host->unprotect_spare_data) {
>  		data_size2 = ecc->size - data_size1 -
>  			     ((ecc->steps - 1) * 4);
>  		oob_size2 = (ecc->steps * 4) + host->ecc_bytes_hw +
> @@ -1782,7 +1811,7 @@ check_for_erased_page(struct qcom_nand_host *host, u8 *data_buf,
>  	}
>  
>  	for_each_set_bit(cw, &uncorrectable_cws, ecc->steps) {
> -		if (qcom_nandc_is_last_cw(ecc, cw)) {
> +		if (qcom_nandc_is_last_cw(ecc, cw) && !host->unprotect_spare_data) {
>  			data_size = ecc->size - ((ecc->steps - 1) * 4);
>  			oob_size = (ecc->steps * 4) + host->ecc_bytes_hw;
>  		} else {
> @@ -1940,7 +1969,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
>  	for (i = 0; i < ecc->steps; i++) {
>  		int data_size, oob_size;
>  
> -		if (qcom_nandc_is_last_cw(ecc, i)) {
> +		if (qcom_nandc_is_last_cw(ecc, i) && !host->unprotect_spare_data) {
>  			data_size = ecc->size - ((ecc->steps - 1) << 2);
>  			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
>  				   host->spare_bytes;
> @@ -2037,6 +2066,52 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
>  	return ret;
>  }
>  
> +static bool
> +qcom_nandc_is_boot_page(struct qcom_nand_host *host, int page)
> +{
> +	struct qcom_nand_boot_page *boot_page;
> +	u32 start, end;
> +	int i;
> +
> +	for (i = 0; i < host->boot_pages_count; i++) {
> +		boot_page = &host->boot_pages[i];
> +		start = boot_page->offset;
> +		end = start + boot_page->size;
> +		/* Boot page are at the start of the nand.
> +		 * Check the page from the boot page end first
> +		 * to save one extra check.

Is the comment valid still?

> +		 */
> +		if (page < end && page >= start)
> +			return 1;

true?

> +	}
> +
> +	return 0;

false?

> +}
> +
> +static void
> +qcom_nandc_check_boot_pages(struct qcom_nand_host *host, int page)

qcom_nandc_codeword_fixup()?

> +{
> +	bool unprotect_spare_data = qcom_nandc_is_boot_page(host, page);
> +
> +	/* Skip conf write if we are already in the correct mode */
> +	if (unprotect_spare_data == host->unprotect_spare_data)
> +		return;
> +
> +	host->unprotect_spare_data = unprotect_spare_data;
> +
> +	host->cw_data = unprotect_spare_data ? 512 : 516;
> +	host->spare_bytes = host->cw_size - host->ecc_bytes_hw -
> +			    host->bbm_size - host->cw_data;
> +
> +	host->cfg0 &= ~(SPARE_SIZE_BYTES_MASK | UD_SIZE_BYTES_MASK);
> +	host->cfg0 |= host->spare_bytes << SPARE_SIZE_BYTES |
> +		      host->cw_data << UD_SIZE_BYTES;
> +
> +	host->ecc_bch_cfg &= ~ECC_NUM_DATA_BYTES_MASK;
> +	host->ecc_bch_cfg |= host->cw_data << ECC_NUM_DATA_BYTES;
> +	host->ecc_buf_cfg = (unprotect_spare_data ? 0x1ff : 0x203) << NUM_STEPS;
> +}
> +

[...]

> +static int qcom_nand_host_parse_boot_pages(struct qcom_nand_controller *nandc,
> +					   struct qcom_nand_host *host,
> +					   struct device_node *dn)
> +{
> +	struct nand_chip *chip = &host->chip;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct qcom_nand_boot_page *boot_page;
> +	struct device *dev = nandc->dev;
> +	int pages_count, i, ret;
> +
> +	if (!nandc->props->has_boot_pages)
> +		return 0;
> +
> +	pages_count = of_property_count_u32_elems(dn, "qcom,boot-pages");
> +	if (pages_count < 0) {
> +		dev_err(dev, "Error parsing boot_pages. Ignoring.");

I'd first check for the existence of the property first and bail out if it is
not present. If it is present, then this error is a hard error.

This way, we will preserve DT backward compatibility and abort if the DT is
broken.

> +		return 0;
> +	}
> +
> +	host->boot_pages_count = pages_count / 2;
> +	host->boot_pages = devm_kcalloc(dev, host->boot_pages_count,
> +					sizeof(*host->boot_pages), GFP_KERNEL);
> +	if (!host->boot_pages)
> +		return 0;

This should be a hard error since the property is present in DT and it is
broken.

> +
> +	ret = of_property_read_u32_array(dn, "qcom,boot-pages", (u32 *)host->boot_pages,
> +					 pages_count);
> +	if (ret) {
> +		dev_err(dev, "Error reading boot_pages. Ignoring.");
> +		return 0;
> +	}

How about,

        for (i = 0, j = 0; i < host->nr_boot_partitions; i++, j += 2) {
                of_property_read_u32_index(dn, "qcom,boot-partitions", j,
                                           &host->boot_pages[i].offset);
                of_property_read_u32_index(dn, "qcom,boot-partitions", j + 1,
                                           &host->boot_pages[i].size);
        }

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்
