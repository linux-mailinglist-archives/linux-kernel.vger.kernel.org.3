Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF765449D3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbiFILRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiFILRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:17:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF97A1B8;
        Thu,  9 Jun 2022 04:17:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03215B81DB1;
        Thu,  9 Jun 2022 11:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73055C34114;
        Thu,  9 Jun 2022 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654773429;
        bh=i4y+kKhqo1/9kIpy8Z3cfCpottSPUqX6cuBdqT/GrnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEgxX+jBfkAeTo6kIoJKSN17TsXJGqeHXB5ZtYkTMY9pdkHRri0dsaTnX0m/A/lGR
         FTLsLhP9F1cY9sSVTY/N496hByTpN6AYYX/eCelvEE01odmXC0nacjhOjiTyUXxLLR
         vmZ+5H9qoAEAPcZRWDWXFqSY6nLssuT5GgOAondT7fOv/o/s6eC+Q1lto5C87o3lVr
         IY3T/wHFplAlRg+Nfp7Msa/o4FKfBP7KQ1qwcJUsBj9Eu2WcyAbsLsdE5OcJzH2b/F
         EAVUmwPAqRdqtyEXp64t/DLFmiYCzct8BTwE9DJzcZOUfkdp5SdClYbN9MyfNHwnmm
         IA9i5Y66xKMrA==
Date:   Thu, 9 Jun 2022 16:46:55 +0530
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
Subject: Re: [PATCH v5 1/3] mtd: nand: raw: qcom_nandc: add support for
 unprotected spare data pages
Message-ID: <20220609111655.GF2758@thinkpad>
References: <20220608001030.18813-1-ansuelsmth@gmail.com>
 <20220608001030.18813-2-ansuelsmth@gmail.com>
 <20220609075254.GC2758@thinkpad>
 <62a1ca5a.1c69fb81.d403.b325@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62a1ca5a.1c69fb81.d403.b325@mx.google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:24:22PM +0200, Ansuel Smith wrote:
> On Thu, Jun 09, 2022 at 01:22:54PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jun 08, 2022 at 02:10:28AM +0200, Ansuel Smith wrote:
> > > IPQ8064 nand have special pages where a different layout scheme is used.
> > > These special page are used by boot partition and on reading them
> > > lots of warning are reported about wrong ECC data and if written to
> > > results in broken data and not bootable device.
> > > 
> > > The layout scheme used by these special page consist in using 512 bytes
> > > as the codeword size (even for the last codeword) while writing to CFG0
> > > register. This forces the NAND controller to unprotect the 4 bytes of
> > > spare data.
> > > 
> > > Since the kernel is unaware of this different layout for these special
> > > page, it does try to protect the spare data too during read/write and
> > > warn about CRC errors.
> > > 
> > > Add support for this by permitting the user to declare these special
> > > pages in dts by declaring offset and size of the partition. The driver
> > > internally will convert these value to nand pages.
> > > 
> > > On user read/write the page is checked and if it's a boot page the
> > > correct layout is used.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/mtd/nand/raw/qcom_nandc.c | 174 +++++++++++++++++++++++++++++-
> > >  1 file changed, 169 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > > index 1a77542c6d67..06ee9a836a3b 100644
> > > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > > @@ -80,8 +80,10 @@
> > >  #define	DISABLE_STATUS_AFTER_WRITE	4
> > >  #define	CW_PER_PAGE			6
> > >  #define	UD_SIZE_BYTES			9
> > > +#define	UD_SIZE_BYTES_MASK		GENMASK(18, 9)
> > >  #define	ECC_PARITY_SIZE_BYTES_RS	19
> > >  #define	SPARE_SIZE_BYTES		23
> > > +#define	SPARE_SIZE_BYTES_MASK		GENMASK(26, 23)
> > >  #define	NUM_ADDR_CYCLES			27
> > >  #define	STATUS_BFR_READ			30
> > >  #define	SET_RD_MODE_AFTER_STATUS	31
> > > @@ -102,6 +104,7 @@
> > >  #define	ECC_MODE			4
> > >  #define	ECC_PARITY_SIZE_BYTES_BCH	8
> > >  #define	ECC_NUM_DATA_BYTES		16
> > > +#define	ECC_NUM_DATA_BYTES_MASK		GENMASK(25, 16)
> > >  #define	ECC_FORCE_CLK_OPEN		30
> > >  
> > >  /* NAND_DEV_CMD1 bits */
> > > @@ -418,6 +421,19 @@ struct qcom_nand_controller {
> > >  	const struct qcom_nandc_props *props;
> > >  };
> > >  
> > > +/*
> > > + * NAND special boot partitions
> > > + *
> > > + * @page_offset:		offset of the partition where spare data is not protected
> > > + *				by ECC (value in pages)
> > 
> > s/page_offset/offset
> >
> 
> Mhhh i changed this to page_offset since the struct is called
> boot_partition and it can be confusing since internally the values is in
> pages. Someone can think that the real partition offset/size is used
> instead of the value converted in pages.

Hmm, okay.

> 
> > > + * @page_offset:		size of the partition where spare data is not protected
> > > + *				by ECC (value in pages)
> > 

[...]

> > > +static bool
> > > +qcom_nandc_is_boot_page(struct qcom_nand_host *host, int page)
> > 
> > Move function name to previous line. If it exceeds 100 lines then wrap
> > arguments.
> > 
> > s/qcom_nandc_is_boot_page/qcom_nandc_is_boot_partition
> > 
> 
> Again considering the check is done on the page and not on the
> partition, wonder what is correct.
> 

But the end goal is to detect if the page belongs to boot partitionis, right?

Also, mixing up boot_pages and boot_partitions is confusing. Let's stick to the
fact that this patch checks for pages belonging to the boot partition.

> > > +{
> > > +	struct qcom_nand_boot_partition *boot_partition;
> > > +	u32 start, end;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < host->nr_boot_partitions; i++) {
> > > +		boot_partition = &host->boot_partitions[i];
> > > +		start = boot_partition->page_offset;
> > > +		end = start + boot_partition->page_size;
> > > +
> > > +		/* Boot pages are normally at the start of
> > 
> > Block comments should start with:
> > 
> > 	/*
> > 	 * ...
> > 
> > Also, are you sure that only few pages in the partitions have different layout
> > and not all pages? If not, then this comment needs to be reworded.
> > 
> 
> I probably worderd this bad...
> Each page of the boot partitions require the codeword fix.
> But other may have the normal codeword
> For example this is from a Netgear router:
> mtd0: 00c80000 00020000 "qcadata" (require codeword fix)
> mtd1: 00500000 00020000 "APPSBL"  (require codeword fix)
> mtd2: 00080000 00020000 "APPSBLENV" (doesn't require codeword fix)
> mtd3: 00140000 00020000 "art"       (doesn't)
> mtd4: 00140000 00020000 "artbak"    (doesn't)
> mtd5: 00400000 00020000 "kernel"    (doesn't)
> mtd6: 06080000 00020000 "ubi"       (doesn't)
> mtd7: 00700000 00020000 "reserve"   (doesn't)
> 
> This is part of the case tho as there are some partition table with
> something like
> 
> mtd0: 00c80000 00020000 "qcadata" (require codeword fix)
> mtd1: 00500000 00020000 "APPSBL"  (require codeword fix)
> mtd2: 00080000 00020000 "APPSBLENV" (doesn't require codeword fix)
> mtd3: 00140000 00020000 "APPSBL2"  (require codeword fix)
> [...]
> 
> In all case 99% of the time in a normal system what you commonly write
> are the rootfs partition that are AFTER the boot partition so checking
> if the page is after such partition should speed up the check.

This should be included in the comment.

> Now that I think about it, a good idea is also start checking the
> boot_partition table from the end to improve the checking even more.
> 

Yes and if the page lies after last boot partition then we can bail out in the
first iteration itself. But the binding should make it clear that the offset
should be specified in ascending order.

> So tell me if the comments is wronlgy worded.
> 

Based on the above algorithm:

/*
 * Since the frequent access will be to the non-boot partitions like rootfs,
 * optimize the page check by:

 * 1. Checking if the page lies after the last boot partition.
 * 2. Checking from the boot partition end.
 */

> > > +		 * the nand in various partition.
> > > +		 * Check the page from the boot page end first
> > > +		 * to save one extra check and optimize this
> > > +		 * in case real no-boot partition are used.
> > > +		 */
> > > +		if (page < end && page >= start)
> > > +			return true;
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +static void
> > > +qcom_nandc_codeword_fixup(struct qcom_nand_host *host, int page)
> > > +{
> > > +	bool codeword_fixup = qcom_nandc_is_boot_page(host, page);
> > > +
> > > +	/* Skip conf write if we are already in the correct mode */
> > > +	if (codeword_fixup == host->codeword_fixup)
> > > +		return;
> > > +
> > > +	host->codeword_fixup = codeword_fixup;
> > > +
> > > +	host->cw_data = codeword_fixup ? 512 : 516;
> > > +	host->spare_bytes = host->cw_size - host->ecc_bytes_hw -
> > > +			    host->bbm_size - host->cw_data;
> > > +
> > > +	host->cfg0 &= ~(SPARE_SIZE_BYTES_MASK | UD_SIZE_BYTES_MASK);
> > > +	host->cfg0 |= host->spare_bytes << SPARE_SIZE_BYTES |
> > > +		      host->cw_data << UD_SIZE_BYTES;
> > > +
> > > +	host->ecc_bch_cfg &= ~ECC_NUM_DATA_BYTES_MASK;
> > > +	host->ecc_bch_cfg |= host->cw_data << ECC_NUM_DATA_BYTES;
> > > +	host->ecc_buf_cfg = (codeword_fixup ? 0x1ff : 0x203) << NUM_STEPS;
> > 
> > s/1ff/(512 - 1)
> > s/203/(516 - 1)
> > 
> 
> ok. I wonder if this can just be reduced to (host->cw_data - 1) and
> skipping the check entirely.
> 

Yeah, that sounds even good.

Thanks,
Mani
