Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1FA54CFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349614AbiFOR3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352759AbiFOR3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:29:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5512434BB3;
        Wed, 15 Jun 2022 10:29:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso1502450wml.1;
        Wed, 15 Jun 2022 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0mmtAiGES9hy6GbZr6mj1I/9d7FHTjal/1dcnEoMib4=;
        b=d/ZM+qkibzc1FPpQIVKOPEDkTrF02xlafmgh2XMchXaJDbGefaV7FPRiq9MMt1jujY
         6nuFUGuuXLbLBgp76pCx/O2r4cIN+CtcNgwKZwpVdzekFdRFqDd7O32A7p8UVj/A62n2
         Xs6cMKvcbN5gyfoMnqEqagWnM3EnMXZvedk5xE7YpROhUtP/QqXRbL8czsAjvcFJvXuX
         QANMtQIxUbMg9ZIuPF5DMRMVZ1WQzcr+DX0meZ2TE8KHPIMPWE1d0RQxcFL/aheiGAh7
         jGGq9WheLGjRcC8FMRMWntkV4+X+jwEX9ITHj/a+kk694HVt/sU0fLCfSXmpuPfrVLhf
         7FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0mmtAiGES9hy6GbZr6mj1I/9d7FHTjal/1dcnEoMib4=;
        b=nwHdYC9/mIhD8FirHKHPj4c4nnd0+B559Q/4QxUD3ssj3nZnA31QB02jbujUemqvcD
         ULfVZYORrLdeXf2C+VHDGOOCd8Ga18XNPMlct5u8yU9I62v5hDNTyHNe8U5KTPT/64aH
         +TcrLCq1AQXiKKm+eXA+O1Pa6RPiQiyJdb0srQJxWLEX5a0/fB9CFbS0u6Y3chnIJBFJ
         wzElidQzFGwDxuAOAX1+AM1/qfFZFeCl87cknVMT1g1lQTTkD2UdlMZG73HnT5UyYnU6
         mQ31hiH0hXpN2fIwyknlGSQjBDHaPxp1nkw9k5HRTJYZ2AZM8eYOxO3MZXsaVjZdL4L5
         qLTw==
X-Gm-Message-State: AJIora81U/mcQVvemJKY+BrB54JzsIMGORzf1zzRALDsi/bxQfNlCOhJ
        9cqlXgbhuOwEMg9OCXuXfEa44yix9yk=
X-Google-Smtp-Source: AGRyM1u6SrzeH7qCFw4qlFWwaZs3p9N6OsL/H2wxtO516NhvYU71hXSl0/p2IYSj34r7su/3P5K8qA==
X-Received: by 2002:a05:600c:4e51:b0:39c:4f18:4c29 with SMTP id e17-20020a05600c4e5100b0039c4f184c29mr537734wmq.101.1655314166756;
        Wed, 15 Jun 2022 10:29:26 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d6a41000000b00218468314d7sm15298550wrw.62.2022.06.15.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:29:26 -0700 (PDT)
Message-ID: <62aa16f6.1c69fb81.816fc.be7a@mx.google.com>
X-Google-Original-Message-ID: <YqoKTt3G5+hXj2ET@Ansuel-xps.>
Date:   Wed, 15 Jun 2022 18:35:26 +0200
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
Subject: Re: [PATCH v7 2/3] mtd: nand: raw: qcom_nandc: add support for
 unprotected spare data pages
References: <20220615000612.3119-1-ansuelsmth@gmail.com>
 <20220615000612.3119-3-ansuelsmth@gmail.com>
 <20220615172802.GB3606@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615172802.GB3606@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:58:02PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 15, 2022 at 02:06:11AM +0200, Ansuel Smith wrote:
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
> 
> Just a few nitpicks below. With those fixed,
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Thanks,
> Mani
>

Sure! Thanks a lot for the various review. Will send v8 that should be
the final version.

> > ---
> >  drivers/mtd/nand/raw/qcom_nandc.c | 203 +++++++++++++++++++++++++++++-
> >  1 file changed, 198 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > index f2990d721733..0dbfe32888ff 100644
> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> 
> [...]
> 
> > +static bool qcom_nandc_is_boot_partition(struct qcom_nand_host *host, int page)
> > +{
> > +	struct qcom_nand_boot_partition *boot_partition;
> > +	u32 start, end;
> > +	int i;
> > +
> > +	/*
> > +	 * Since the frequent access will be to the non-boot partitions like rootfs,
> > +	 * optimize the page check by:
> > +
> 
> Missing "*"
> 
> > +	 * 1. Checking if the page lies after the last boot partition.
> > +	 * 2. Checking from the boot partition end.
> > +	 */
> > +
> > +	/* First check the last boot partition */
> > +	boot_partition = &host->boot_partitions[host->nr_boot_partitions - 1];
> > +	start = boot_partition->page_offset;
> > +	end = start + boot_partition->page_size;
> > +
> > +	/* Page is after the last boot partition end. This is NOT a boot partition */
> > +	if (page > end)
> > +		return false;
> > +
> > +	/* Actually check if it's a boot partition */
> > +	if (page < end && page >= start)
> > +		return true;
> > +
> > +	/* Check the other boot partition starting from the second-last partition */
> 
> s/boot partition/boot partitions
> 
> > +	for (i = host->nr_boot_partitions - 2; i >= 0; i--) {
> > +		boot_partition = &host->boot_partitions[i];
> > +		start = boot_partition->page_offset;
> > +		end = start + boot_partition->page_size;
> > +
> > +		if (page < end && page >= start)
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static void
> > +qcom_nandc_codeword_fixup(struct qcom_nand_host *host, int page)
> 
> As like other functions, please align the function on the same line
> 
> > +{
> > +	bool codeword_fixup = qcom_nandc_is_boot_partition(host, page);
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
> > +	host->ecc_buf_cfg = (host->cw_data - 1) << NUM_STEPS;
> > +}
> 
> [...]
> 
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
> > +	if (!of_find_property(dn, "qcom,boot-partitions", NULL))
> > +		return 0;
> > +
> > +	partitions_count = of_property_count_u32_elems(dn, "qcom,boot-partitions");
> > +	if (partitions_count <= 0) {
> > +		dev_err(dev, "Error parsing boot partition\n");
> > +		if (partitions_count == 0)
> > +			return -EINVAL;
> > +		else
> > +			return partitions_count;
> 
> 		return partitions_count ? partitions_count : -EINVAL;
> 
> Thanks,
> Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
	Ansuel
