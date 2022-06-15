Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B7F54CFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349664AbiFOR2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349551AbiFOR2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:28:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED88B64C7;
        Wed, 15 Jun 2022 10:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 067BD61AAF;
        Wed, 15 Jun 2022 17:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE10C3411E;
        Wed, 15 Jun 2022 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655314083;
        bh=ilTAICh3FsjTzVc9ME4FcR9Ufoo9UUbjHFBRoZxdStI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hp7X1Voa0A0eOfpO6673a2hnZATJ4nUKhChLwBbJcnFpBuQ7Ms28vSPcJAWMYw20R
         msLl4j2LWIMAlydf9LDlNE9VdtQbZA3y7xGPzSE8dPQS1M3L6rYTz2+wsx3Y/tVwSt
         8M0vnVWykjlW46/4YVJPgOPVIRztmJCwVb8YB487CDgoVVU46L9xOclio6IgCQ5jZY
         pKI6jjuDCOGjBWfWuANSKzswPLDDrWNYWLbn7QVYkYdHv54Dnu34rO0P2SsaYeeBQL
         SR4BxBVaE8+cjd2H8Jt0CeGIOFKNEMjOAliyZLZudsNnM2MfrWbd72PpN46ScKjfvQ
         uVFMs4Zvs8XMw==
Date:   Wed, 15 Jun 2022 22:58:02 +0530
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
Subject: Re: [PATCH v7 2/3] mtd: nand: raw: qcom_nandc: add support for
 unprotected spare data pages
Message-ID: <20220615172802.GB3606@thinkpad>
References: <20220615000612.3119-1-ansuelsmth@gmail.com>
 <20220615000612.3119-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615000612.3119-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 02:06:11AM +0200, Ansuel Smith wrote:
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

Just a few nitpicks below. With those fixed,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 203 +++++++++++++++++++++++++++++-
>  1 file changed, 198 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index f2990d721733..0dbfe32888ff 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c

[...]

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

Missing "*"

> +	 * 1. Checking if the page lies after the last boot partition.
> +	 * 2. Checking from the boot partition end.
> +	 */
> +
> +	/* First check the last boot partition */
> +	boot_partition = &host->boot_partitions[host->nr_boot_partitions - 1];
> +	start = boot_partition->page_offset;
> +	end = start + boot_partition->page_size;
> +
> +	/* Page is after the last boot partition end. This is NOT a boot partition */
> +	if (page > end)
> +		return false;
> +
> +	/* Actually check if it's a boot partition */
> +	if (page < end && page >= start)
> +		return true;
> +
> +	/* Check the other boot partition starting from the second-last partition */

s/boot partition/boot partitions

> +	for (i = host->nr_boot_partitions - 2; i >= 0; i--) {
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

As like other functions, please align the function on the same line

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

[...]

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
> +		if (partitions_count == 0)
> +			return -EINVAL;
> +		else
> +			return partitions_count;

		return partitions_count ? partitions_count : -EINVAL;

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்
