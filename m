Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED157C7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiGUJcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiGUJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:32:23 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C96480F50
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:32:21 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,289,1650898800"; 
   d="scan'208";a="128642622"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Jul 2022 18:32:20 +0900
Received: from localhost.localdomain (unknown [10.226.92.81])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9D0CE40078D5;
        Thu, 21 Jul 2022 18:32:17 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     michael@walle.cc
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, p.yadav@ti.com, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH 5/6] mtd: spi-nor: add generic flash driver
Date:   Thu, 21 Jul 2022 10:32:16 +0100
Message-Id: <202205132220.uRTFaqNA-lkp@intel.com> (raw)
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513133520.3945820-6-michael@walle.cc>
References: <20220513133520.3945820-6-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Our SFDP is parsing is everything we need to support all basic operations of
> a flash device. If the flash isn't found in our in-kernel flash database,
> gracefully fall back to a driver described solely by its SFDP tables.
> 
> It is still recommended to add the flash to the in-kernel database.
> First, we get a proper partname and secondly, for all features not described
> by the SFDP like OTP we need the entry anyway.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/core.c | 13 +++++++++++++  drivers/mtd/spi-nor/core.h |
> 1 +  drivers/mtd/spi-nor/sfdp.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c index
> 65cd8e668579..ee193a61310a 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1632,6 +1632,11 @@ static const struct spi_nor_manufacturer
> *manufacturers[] = {
>  	&spi_nor_xmc,
>  };
> 
> +static const struct flash_info spi_nor_generic_flash = {
> +	.name = "spi-nor-generic",
> +	.parse_sfdp = true,
> +};
> +
>  static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
>  						 const u8 *id)
>  {
> @@ -1670,6 +1675,14 @@ static const struct flash_info *spi_nor_detect(struct
> spi_nor *nor)
>  		return ERR_PTR(-ENOMEM);
> 
>  	info = spi_nor_match_id(nor, id);
> +
> +	/* Fallback to a generic flash described only by its SFDP data. */
> +	if (!info) {
> +		ret = spi_nor_check_sfdp_signature(nor);
> +		if (!ret)
> +			info = &spi_nor_generic_flash;
> +	}

May be this can be combined as

 	if (!info && (!spi_nor_check_sfdp_signature(nor)))
		info = &spi_nor_generic_flash;

Cheers,
Biju

>  	if (!info) {
>  		dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
>  			SPI_NOR_MAX_ID_LEN, id);
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h index
> 153cb4b174ee..b084cb6db401 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -703,6 +703,7 @@ int spi_nor_controller_ops_read_reg(struct spi_nor *nor,
> u8 opcode,  int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8
> opcode,
>  				     const u8 *buf, size_t len);
> 
> +int spi_nor_check_sfdp_signature(struct spi_nor *nor);
>  int spi_nor_parse_sfdp(struct spi_nor *nor);
> 
>  static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd) diff --
> git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c index
> a5211543d30d..9bdb3d5dc7e8 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -1247,6 +1247,33 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor
> *nor)
>  		nor->info->fixups->post_sfdp(nor);
>  }
> 
> +/**
> + * spi_nor_check_sfdp_header() - check for a valid SFDP header
> + * @nor:		pointer to a 'struct spi_nor'
> + *
> + * Used to detect if the flash supports the RDSFDP command as well as
> +the
> + * presence of a valid SFDP table.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int spi_nor_check_sfdp_signature(struct spi_nor *nor) {
> +	u32 signature;
> +	int err;
> +
> +	/* Get the SFDP header. */
> +	err = spi_nor_read_sfdp_dma_unsafe(nor, 0, sizeof(signature),
> +					   &signature);
> +	if (err < 0)
> +		return err;
> +
> +	/* Check the SFDP signature. */
> +	if (le32_to_cpu(signature) != SFDP_SIGNATURE)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  /**
>   * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
>   * @nor:		pointer to a 'struct spi_nor'
> --
> 2.25.1


