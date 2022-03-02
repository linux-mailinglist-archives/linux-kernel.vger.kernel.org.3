Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067C04CA4D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbiCBMbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbiCBMbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:31:36 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B87F606EA;
        Wed,  2 Mar 2022 04:30:53 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 222CUdSD008743;
        Wed, 2 Mar 2022 06:30:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646224240;
        bh=rtFipknxeYo1v4cJrenh1bkttKuv3UnZgO67uv1f29A=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ogUHR4vLrj75nCD6UJHB+sbkwKzKm9l3OiDn+6sZyY7MDMJUdQJVprUsD/+7qW2CP
         5EZdRGhQKaaCgt5S9IXusnBchvVlcqn4v0l3AbENai8H+msDSwu3816e5DF8q6zgZM
         pQhomww8w9Hrlr5CugIIvyX+7SmaUH/z4hheu0W4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 222CUd12045049
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Mar 2022 06:30:39 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Mar 2022 06:30:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Mar 2022 06:30:39 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 222CUcPc062807;
        Wed, 2 Mar 2022 06:30:39 -0600
Date:   Wed, 2 Mar 2022 18:00:38 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 4/4] mtd: spi-nor: core: Introduce SPI_NOR_DTR_BSWAP16
 no_sfdp_flag
Message-ID: <20220302123038.fe5bk3akyovihxem@ti.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <20220218145900.1440045-5-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220218145900.1440045-5-tudor.ambarus@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/22 04:59PM, Tudor Ambarus wrote:
> Introduce SPI_NOR_DTR_BSWAP16 flag for flashes that don't define the
> mandatory BFPT table. When set it indicates that the byte order of 16-bit
> words is swapped when read in 8D-8D-8D mode compared to 1-1-1 mode.

Is there any flash that currently needs this flag but does not define 
BFPT? If there is no user, let's not add it. It can always be added 
later.

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c | 5 ++++-
>  drivers/mtd/spi-nor/core.h | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 453d8c54d062..c3128a8e1544 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2572,7 +2572,7 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
>  {
>  	struct spi_nor_flash_parameter *params = nor->params;
>  	struct spi_nor_erase_map *map = &params->erase_map;
> -	const u8 no_sfdp_flags = nor->info->no_sfdp_flags;
> +	const u16 no_sfdp_flags = nor->info->no_sfdp_flags;
>  	u8 i, erase_mask;
>  
>  	if (no_sfdp_flags & SPI_NOR_DUAL_READ) {
> @@ -2613,6 +2613,9 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
>  					SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
>  	}
>  
> +	if (no_sfdp_flags & SPI_NOR_DTR_BSWAP16)
> +		nor->flags |= SNOR_F_DTR_BSWAP16;
> +
>  	/*
>  	 * Sector Erase settings. Sort Erase Types in ascending order, with the
>  	 * smallest erase size starting at BIT(0).
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 7c077d41c335..1cb887437193 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -362,6 +362,8 @@ struct spi_nor_fixups {
>   *   SPI_NOR_OCTAL_READ:      flash supports Octal Read.
>   *   SPI_NOR_OCTAL_DTR_READ:  flash supports octal DTR Read.
>   *   SPI_NOR_OCTAL_DTR_PP:    flash supports Octal DTR Page Program.
> + *   SPI_NOR_DTR_BSWAP16:     the byte order of 16-bit words is swapped when
> + *			      read or written in DTR mode compared to STR mode.
>   *
>   * @fixup_flags:    flags that indicate support that can be discovered via SFDP
>   *                  ideally, but can not be discovered for this particular flash
> @@ -404,7 +406,7 @@ struct flash_info {
>  #define USE_FSR				BIT(10)
>  #define SPI_NOR_XSR_RDY			BIT(11)
>  
> -	u8 no_sfdp_flags;
> +	u16 no_sfdp_flags;
>  #define SPI_NOR_SKIP_SFDP		BIT(0)
>  #define SECT_4K				BIT(1)
>  #define SECT_4K_PMC			BIT(2)
> @@ -413,6 +415,7 @@ struct flash_info {
>  #define SPI_NOR_OCTAL_READ		BIT(5)
>  #define SPI_NOR_OCTAL_DTR_READ		BIT(6)
>  #define SPI_NOR_OCTAL_DTR_PP		BIT(7)
> +#define SPI_NOR_DTR_BSWAP16		BIT(8)
>  
>  	u8 fixup_flags;
>  #define SPI_NOR_4B_OPCODES		BIT(0)
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
