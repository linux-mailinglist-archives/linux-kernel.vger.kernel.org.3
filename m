Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374F25448BE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbiFIKYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiFIKYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:24:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D4B4B84C;
        Thu,  9 Jun 2022 03:24:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id m20so46460703ejj.10;
        Thu, 09 Jun 2022 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AHXRznNMpT1hcD9zigcRN0b5yLbWWRhNFM/wcISeAfc=;
        b=jgA9ZNWQMZGD4nEXn5XfUZF9ebuu94ebRP+l0xXpH8nQ0qyJCNHGACZsOJnXLZCOUg
         esYd7wm8pNUd9w2oc6LiOlr1RfC0iYIpJ0TY9+fGFoLLzEeFbEc45jPGawL+iO01EGpy
         D+O6OnkHO8dg6wZkMWg8rpT1IxsBgOLVdo7mY7Q8TMfNdrQrr6/YJCdNU3L7aXpgyrmL
         qVQTLivv/TfZ9qlMXRsAEAc/DKrX/5fUshVvYuHQ8+Spo5PdPljRH9YM6H1slH+Yyy27
         /GrvHQmn8pp/MoQRPLuH1F7+dIxKEzTuOrk8YprD3+ZBRhmhJcCPV0pTyJNdR0fWMgzY
         Yd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AHXRznNMpT1hcD9zigcRN0b5yLbWWRhNFM/wcISeAfc=;
        b=XgH7jhwvvIrZ9SmLqEB05OpIPvUThKPJOrPZHWli6KBo8z4/UyXvs6L3OZpL9dr2Cu
         4cLfQNxgzvPtATYaW4GQfexbG6c1K1JffC8GiPXdb5PI4ayvM17qIhEgeoOcOhNG/+JW
         BlRu3OCwj5M5WNGKmp4oUqUdo3mf6fBQZ1xojbrISXj+0RIuOlLo7P3/HxyEylohI4pN
         K1+LG0VRf+AM4WqJcE+dfRTVmCV/KCAApQ6hiQdDpoOZYJ/VmmnV45fHM0UXG1glRqmm
         gm4JcyQjNwYo1wJ1XEtPKPmZ4CCJGnDtLLg0U7nxGmW4soeCFsPUoXiQgm+ja3PF0PmE
         fg/A==
X-Gm-Message-State: AOAM533myXV9kkaZOdFdBoGgiM14bO3qooKk0aaaLMjz+4hLaTCrxg8H
        ZS4zGLMrdMbnBc3yYhFSM3g=
X-Google-Smtp-Source: ABdhPJz0Ce61R94Dt8Fks4jL1576/U3TAGD94V2FwP7+5QIFRnNyBU5YZjRVDFuacf/jBmxtXQNXvQ==
X-Received: by 2002:a17:906:b048:b0:6fe:be4a:3ecf with SMTP id bj8-20020a170906b04800b006febe4a3ecfmr35598657ejb.104.1654770267147;
        Thu, 09 Jun 2022 03:24:27 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id u15-20020a05640207cf00b0042dd60352d1sm14151130edy.35.2022.06.09.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 03:24:26 -0700 (PDT)
Message-ID: <62a1ca5a.1c69fb81.d403.b325@mx.google.com>
X-Google-Original-Message-ID: <YqHKVtcTzQqFbtA6@Ansuel-xps.>
Date:   Thu, 9 Jun 2022 12:24:22 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] mtd: nand: raw: qcom_nandc: add support for
 unprotected spare data pages
References: <20220608001030.18813-1-ansuelsmth@gmail.com>
 <20220608001030.18813-2-ansuelsmth@gmail.com>
 <20220609075254.GC2758@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609075254.GC2758@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 01:22:54PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 08, 2022 at 02:10:28AM +0200, Ansuel Smith wrote:
> > IPQ8064 nand have special pages where a different layout scheme is used.
> > These special page are used by boot partition and on reading them
> > lots of warning are reported about wrong ECC data and if written to
> > results in broken data and not bootable device.
> > 
> > The layout scheme used by these special page consist in using 512 bytes
> > as the codeword size (even for the last codeword) while writing to CFG0
> > register. This forces the NAND controller to unprotect the 4 bytes of
> > spare data.
> > 
> > Since the kernel is unaware of this different layout for these special
> > page, it does try to protect the spare data too during read/write and
> > warn about CRC errors.
> > 
> > Add support for this by permitting the user to declare these special
> > pages in dts by declaring offset and size of the partition. The driver
> > internally will convert these value to nand pages.
> > 
> > On user read/write the page is checked and if it's a boot page the
> > correct layout is used.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/qcom_nandc.c | 174 +++++++++++++++++++++++++++++-
> >  1 file changed, 169 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > index 1a77542c6d67..06ee9a836a3b 100644
> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > @@ -80,8 +80,10 @@
> >  #define	DISABLE_STATUS_AFTER_WRITE	4
> >  #define	CW_PER_PAGE			6
> >  #define	UD_SIZE_BYTES			9
> > +#define	UD_SIZE_BYTES_MASK		GENMASK(18, 9)
> >  #define	ECC_PARITY_SIZE_BYTES_RS	19
> >  #define	SPARE_SIZE_BYTES		23
> > +#define	SPARE_SIZE_BYTES_MASK		GENMASK(26, 23)
> >  #define	NUM_ADDR_CYCLES			27
> >  #define	STATUS_BFR_READ			30
> >  #define	SET_RD_MODE_AFTER_STATUS	31
> > @@ -102,6 +104,7 @@
> >  #define	ECC_MODE			4
> >  #define	ECC_PARITY_SIZE_BYTES_BCH	8
> >  #define	ECC_NUM_DATA_BYTES		16
> > +#define	ECC_NUM_DATA_BYTES_MASK		GENMASK(25, 16)
> >  #define	ECC_FORCE_CLK_OPEN		30
> >  
> >  /* NAND_DEV_CMD1 bits */
> > @@ -418,6 +421,19 @@ struct qcom_nand_controller {
> >  	const struct qcom_nandc_props *props;
> >  };
> >  
> > +/*
> > + * NAND special boot partitions
> > + *
> > + * @page_offset:		offset of the partition where spare data is not protected
> > + *				by ECC (value in pages)
> 
> s/page_offset/offset
>

Mhhh i changed this to page_offset since the struct is called
boot_partition and it can be confusing since internally the values is in
pages. Someone can think that the real partition offset/size is used
instead of the value converted in pages.

> > + * @page_offset:		size of the partition where spare data is not protected
> > + *				by ECC (value in pages)
> 
> s/page_offset/size
> 
> > + */
> > +struct qcom_nand_boot_partition {
> > +	u32 page_offset;
> > +	u32 page_size;
> 
> same here
> 
> > +};
> > +
> >  /*
> >   * NAND chip structure
> >   *
> > @@ -444,6 +460,13 @@ struct qcom_nand_controller {
> >   * @cfg0, cfg1, cfg0_raw..:	NANDc register configurations needed for
> >   *				ecc/non-ecc mode for the current nand flash
> >   *				device
> > + *
> > + * @codeword_fixup:		keep track of the current layout used by
> > + *				the driver for read/write operation.
> > + * @nr_boot_partitions:		count of the boot partitions where spare data is not
> > + *				protected by ECC
> 
> Align the Kdoc comments w.r.t other members.
> 
> > + * @boot_pages:			array of boot partitions where offset and size of the
> > + *				boot partitions are stored
> 
> s/boot_pages/boot_partitions
> 

Sorry.

> >   */
> >  struct qcom_nand_host {
> >  	struct nand_chip chip;
> > @@ -466,6 +489,10 @@ struct qcom_nand_host {
> >  	u32 ecc_bch_cfg;
> >  	u32 clrflashstatus;
> >  	u32 clrreadstatus;
> > +
> > +	bool codeword_fixup;
> > +	int nr_boot_partitions;
> > +	struct qcom_nand_boot_partition *boot_partitions;
> >  };
> >  
> >  /*
> > @@ -475,6 +502,7 @@ struct qcom_nand_host {
> >   * @is_bam - whether NAND controller is using BAM
> >   * @is_qpic - whether NAND CTRL is part of qpic IP
> >   * @qpic_v2 - flag to indicate QPIC IP version 2
> > + * @use_codeword_fixup - whether NAND has different layout for boot partitions
> >   * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
> >   */
> >  struct qcom_nandc_props {
> > @@ -482,6 +510,7 @@ struct qcom_nandc_props {
> >  	bool is_bam;
> >  	bool is_qpic;
> >  	bool qpic_v2;
> > +	bool use_codeword_fixup;
> >  	u32 dev_cmd_reg_start;
> >  };
> >  
> > @@ -1701,7 +1730,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
> >  	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
> >  	oob_size1 = host->bbm_size;
> >  
> > -	if (qcom_nandc_is_last_cw(ecc, cw)) {
> > +	if (qcom_nandc_is_last_cw(ecc, cw) && !host->codeword_fixup) {
> >  		data_size2 = ecc->size - data_size1 -
> >  			     ((ecc->steps - 1) * 4);
> >  		oob_size2 = (ecc->steps * 4) + host->ecc_bytes_hw +
> > @@ -1782,7 +1811,7 @@ check_for_erased_page(struct qcom_nand_host *host, u8 *data_buf,
> >  	}
> >  
> >  	for_each_set_bit(cw, &uncorrectable_cws, ecc->steps) {
> > -		if (qcom_nandc_is_last_cw(ecc, cw)) {
> > +		if (qcom_nandc_is_last_cw(ecc, cw) && !host->codeword_fixup) {
> >  			data_size = ecc->size - ((ecc->steps - 1) * 4);
> >  			oob_size = (ecc->steps * 4) + host->ecc_bytes_hw;
> >  		} else {
> > @@ -1940,7 +1969,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
> >  	for (i = 0; i < ecc->steps; i++) {
> >  		int data_size, oob_size;
> >  
> > -		if (qcom_nandc_is_last_cw(ecc, i)) {
> > +		if (qcom_nandc_is_last_cw(ecc, i) && !host->codeword_fixup) {
> >  			data_size = ecc->size - ((ecc->steps - 1) << 2);
> >  			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
> >  				   host->spare_bytes;
> > @@ -2037,6 +2066,55 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
> >  	return ret;
> >  }
> >  
> > +static bool
> > +qcom_nandc_is_boot_page(struct qcom_nand_host *host, int page)
> 
> Move function name to previous line. If it exceeds 100 lines then wrap
> arguments.
> 
> s/qcom_nandc_is_boot_page/qcom_nandc_is_boot_partition
> 

Again considering the check is done on the page and not on the
partition, wonder what is correct.

> > +{
> > +	struct qcom_nand_boot_partition *boot_partition;
> > +	u32 start, end;
> > +	int i;
> > +
> > +	for (i = 0; i < host->nr_boot_partitions; i++) {
> > +		boot_partition = &host->boot_partitions[i];
> > +		start = boot_partition->page_offset;
> > +		end = start + boot_partition->page_size;
> > +
> > +		/* Boot pages are normally at the start of
> 
> Block comments should start with:
> 
> 	/*
> 	 * ...
> 
> Also, are you sure that only few pages in the partitions have different layout
> and not all pages? If not, then this comment needs to be reworded.
> 

I probably worderd this bad...
Each page of the boot partitions require the codeword fix.
But other may have the normal codeword
For example this is from a Netgear router:
mtd0: 00c80000 00020000 "qcadata" (require codeword fix)
mtd1: 00500000 00020000 "APPSBL"  (require codeword fix)
mtd2: 00080000 00020000 "APPSBLENV" (doesn't require codeword fix)
mtd3: 00140000 00020000 "art"       (doesn't)
mtd4: 00140000 00020000 "artbak"    (doesn't)
mtd5: 00400000 00020000 "kernel"    (doesn't)
mtd6: 06080000 00020000 "ubi"       (doesn't)
mtd7: 00700000 00020000 "reserve"   (doesn't)

This is part of the case tho as there are some partition table with
something like

mtd0: 00c80000 00020000 "qcadata" (require codeword fix)
mtd1: 00500000 00020000 "APPSBL"  (require codeword fix)
mtd2: 00080000 00020000 "APPSBLENV" (doesn't require codeword fix)
mtd3: 00140000 00020000 "APPSBL2"  (require codeword fix)
[...]

In all case 99% of the time in a normal system what you commonly write
are the rootfs partition that are AFTER the boot partition so checking
if the page is after such partition should speed up the check.
Now that I think about it, a good idea is also start checking the
boot_partition table from the end to improve the checking even more.

So tell me if the comments is wronlgy worded.

> > +		 * the nand in various partition.
> > +		 * Check the page from the boot page end first
> > +		 * to save one extra check and optimize this
> > +		 * in case real no-boot partition are used.
> > +		 */
> > +		if (page < end && page >= start)
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static void
> > +qcom_nandc_codeword_fixup(struct qcom_nand_host *host, int page)
> > +{
> > +	bool codeword_fixup = qcom_nandc_is_boot_page(host, page);
> > +
> > +	/* Skip conf write if we are already in the correct mode */
> > +	if (codeword_fixup == host->codeword_fixup)
> > +		return;
> > +
> > +	host->codeword_fixup = codeword_fixup;
> > +
> > +	host->cw_data = codeword_fixup ? 512 : 516;
> > +	host->spare_bytes = host->cw_size - host->ecc_bytes_hw -
> > +			    host->bbm_size - host->cw_data;
> > +
> > +	host->cfg0 &= ~(SPARE_SIZE_BYTES_MASK | UD_SIZE_BYTES_MASK);
> > +	host->cfg0 |= host->spare_bytes << SPARE_SIZE_BYTES |
> > +		      host->cw_data << UD_SIZE_BYTES;
> > +
> > +	host->ecc_bch_cfg &= ~ECC_NUM_DATA_BYTES_MASK;
> > +	host->ecc_bch_cfg |= host->cw_data << ECC_NUM_DATA_BYTES;
> > +	host->ecc_buf_cfg = (codeword_fixup ? 0x1ff : 0x203) << NUM_STEPS;
> 
> s/1ff/(512 - 1)
> s/203/(516 - 1)
> 

ok. I wonder if this can just be reduced to (host->cw_data - 1) and
skipping the check entirely.

> > +}
> > +
> >  /* implements ecc->read_page() */
> >  static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
> >  				int oob_required, int page)
> > @@ -2045,6 +2123,9 @@ static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
> >  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> >  	u8 *data_buf, *oob_buf = NULL;
> >  
> > +	if (host->nr_boot_partitions)
> > +		qcom_nandc_codeword_fixup(host, page);
> > +
> >  	nand_read_page_op(chip, page, 0, NULL, 0);
> >  	data_buf = buf;
> >  	oob_buf = oob_required ? chip->oob_poi : NULL;
> > @@ -2064,6 +2145,9 @@ static int qcom_nandc_read_page_raw(struct nand_chip *chip, uint8_t *buf,
> >  	int cw, ret;
> >  	u8 *data_buf = buf, *oob_buf = chip->oob_poi;
> >  
> > +	if (host->nr_boot_partitions)
> > +		qcom_nandc_codeword_fixup(host, page);
> > +
> >  	for (cw = 0; cw < ecc->steps; cw++) {
> >  		ret = qcom_nandc_read_cw_raw(mtd, chip, data_buf, oob_buf,
> >  					     page, cw);
> > @@ -2084,6 +2168,9 @@ static int qcom_nandc_read_oob(struct nand_chip *chip, int page)
> >  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> >  	struct nand_ecc_ctrl *ecc = &chip->ecc;
> >  
> > +	if (host->nr_boot_partitions)
> > +		qcom_nandc_codeword_fixup(host, page);
> > +
> >  	clear_read_regs(nandc);
> >  	clear_bam_transaction(nandc);
> >  
> > @@ -2104,6 +2191,9 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
> >  	u8 *data_buf, *oob_buf;
> >  	int i, ret;
> >  
> > +	if (host->nr_boot_partitions)
> > +		qcom_nandc_codeword_fixup(host, page);
> > +
> >  	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> >  
> >  	clear_read_regs(nandc);
> > @@ -2119,7 +2209,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
> >  	for (i = 0; i < ecc->steps; i++) {
> >  		int data_size, oob_size;
> >  
> > -		if (qcom_nandc_is_last_cw(ecc, i)) {
> > +		if (qcom_nandc_is_last_cw(ecc, i) && !host->codeword_fixup) {
> >  			data_size = ecc->size - ((ecc->steps - 1) << 2);
> >  			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
> >  				   host->spare_bytes;
> > @@ -2176,6 +2266,9 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
> >  	u8 *data_buf, *oob_buf;
> >  	int i, ret;
> >  
> > +	if (host->nr_boot_partitions)
> > +		qcom_nandc_codeword_fixup(host, page);
> > +
> >  	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> >  	clear_read_regs(nandc);
> >  	clear_bam_transaction(nandc);
> > @@ -2194,7 +2287,7 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
> >  		data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
> >  		oob_size1 = host->bbm_size;
> >  
> > -		if (qcom_nandc_is_last_cw(ecc, i)) {
> > +		if (qcom_nandc_is_last_cw(ecc, i) && !host->codeword_fixup) {
> >  			data_size2 = ecc->size - data_size1 -
> >  				     ((ecc->steps - 1) << 2);
> >  			oob_size2 = (ecc->steps << 2) + host->ecc_bytes_hw +
> > @@ -2254,6 +2347,9 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
> >  	int data_size, oob_size;
> >  	int ret;
> >  
> > +	if (host->nr_boot_partitions)
> > +		qcom_nandc_codeword_fixup(host, page);
> > +
> >  	host->use_ecc = true;
> >  	clear_bam_transaction(nandc);
> >  
> > @@ -2902,6 +2998,71 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
> >  
> >  static const char * const probes[] = { "cmdlinepart", "ofpart", "qcomsmem", NULL };
> >  
> > +static int qcom_nand_host_parse_boot_partitions(struct qcom_nand_controller *nandc,
> > +						struct qcom_nand_host *host,
> > +						struct device_node *dn)
> > +{
> > +	struct nand_chip *chip = &host->chip;
> > +	struct mtd_info *mtd = nand_to_mtd(chip);
> > +	struct qcom_nand_boot_partition *boot_partition;
> > +	struct device *dev = nandc->dev;
> > +	int partitions_count, i, j, ret;
> > +
> > +	if (!nandc->props->use_codeword_fixup)
> > +		return 0;
> 
> Move this check to caller as I suggested previously.
> 

Sorry I missed that.

> > +
> > +	if (!of_find_property(dn, "qcom,boot-partitions", NULL))
> > +		return 0;
> > +
> > +	partitions_count = of_property_count_u32_elems(dn, "qcom,boot-partitions");
> > +	if (partitions_count < 0) {
> 
> partitions_count <= 0
> 
> > +		dev_err(dev, "Error parsing boot partition.");
> 
> Add newline at the end of error message
> 
> > +		return ret;
> > +	}
> > +
> > +	host->nr_boot_partitions = partitions_count / 2;
> > +	host->boot_partitions = devm_kcalloc(dev, host->nr_boot_partitions,
> > +					     sizeof(*host->boot_partitions), GFP_KERNEL);
> > +	if (!host->boot_partitions)
> 
> host->nr_boot_partitions = 0;
> 
> > +		return -ENOMEM;
> > +
> > +	for (i = 0, j = 0; i < host->nr_boot_partitions; i++, j += 2) {
> > +		boot_partition = &host->boot_partitions[i];
> > +
> > +		ret = of_property_read_u32_index(dn, "qcom,boot-partitions", j,
> > +						 &boot_partition->page_offset);
> > +		if (ret) {
> > +			dev_err(dev, "Error parsing boot partition offset at index %d", i);
> 
> Add newline at the end of error message. Do the same for all error prints.
> 
> > +			return ret;
> > +		}
> > +
> > +		if (boot_partition->page_offset % mtd->writesize) {
> > +			dev_err(dev, "Boot partition offset not multiple of writesize at index %i",
> > +				i);
> > +			return -EINVAL;
> > +		}
> > +		/* Convert offset to nand pages */
> 
> s/pages/partitions
> 
> > +		boot_partition->page_offset /= mtd->writesize;
> 
> s/page_offset/offset
> 
> > +
> > +		ret = of_property_read_u32_index(dn, "qcom,boot-partitions", j + 1,
> > +						 &boot_partition->page_size);
> > +		if (ret) {
> > +			dev_err(dev, "Error parsing boot partition size at index %d", i);
> > +			return ret;
> > +		}
> > +
> > +		if (boot_partition->page_size % mtd->writesize) {
> 
> s/page_size/size here and below
> 
> > +			dev_err(dev, "Boot partition size not multiple of writesize at index %i",
> > +				i);
> > +			return -EINVAL;
> > +		}
> > +		/* Convert size to nand pages */
> 
> s/pages/partitions
> 
> Thanks,
> Mani
> 
> > +		boot_partition->page_size /= mtd->writesize;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
> >  					    struct qcom_nand_host *host,
> >  					    struct device_node *dn)
> > @@ -2970,6 +3131,8 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
> >  	if (ret)
> >  		nand_cleanup(chip);
> >  
> > +	qcom_nand_host_parse_boot_partitions(nandc, host, dn);
> > +
> >  	return ret;
> >  }
> >  
> > @@ -3135,6 +3298,7 @@ static int qcom_nandc_remove(struct platform_device *pdev)
> >  static const struct qcom_nandc_props ipq806x_nandc_props = {
> >  	.ecc_modes = (ECC_RS_4BIT | ECC_BCH_8BIT),
> >  	.is_bam = false,
> > +	.use_codeword_fixup = true,
> >  	.dev_cmd_reg_start = 0x0,
> >  };
> >  
> > -- 
> > 2.36.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
	Ansuel
