Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F1E4E263F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347274AbiCUMXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346028AbiCUMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:23:29 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82070165BAA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:22:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22LCLpq3033322;
        Mon, 21 Mar 2022 07:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647865311;
        bh=ozhqVcGuJggsiVb90dN40qSrmfyXmyscj783uxBzNPI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OUO3/V4aYlEolsV2r+VZlw2vLg/YVhemvPGppsYFPlcTfNa6RDCTSPKoX6TKlTDhU
         WIsglmjuky/qVNYOnTxScoJFHWf5fWE5CNAX4Q92noJfRGS/mf9oI10Z5jFQP86Jcq
         uDQfEqoDBNpb8dzQD6DHRrrfllw2GB8l8Q8pSbZ4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22LCLoLV015284
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Mar 2022 07:21:51 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 21
 Mar 2022 07:21:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 21 Mar 2022 07:21:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22LCLnIL015615;
        Mon, 21 Mar 2022 07:21:50 -0500
Date:   Mon, 21 Mar 2022 17:51:49 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v2 4/8] mtd: spi-nor: core: Introduce method for RDID op
Message-ID: <20220321122149.dvqyml4riqkr3gqi@ti.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-5-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220228111712.111737-5-tudor.ambarus@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/22 01:17PM, Tudor Ambarus wrote:
> RDID is used in the core to auto detect the flash, but also by some
> manufacturer drivers that contain flashes that support Octal DTR mode,
> so that they can read the flash ID after the switch to Octal DTR was made
> to test if the switch was successful. Introduce a core method for RDID op
> to avoid code duplication.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c | 58 ++++++++++++++++++++++++++------------
>  drivers/mtd/spi-nor/core.h |  9 ++++++
>  2 files changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index b1d6fa65417d..281e3d25f74c 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -369,6 +369,41 @@ int spi_nor_write_disable(struct spi_nor *nor)
>  	return ret;
>  }
>  
> +/**
> + * spi_nor_read_id() - Read the JEDEC ID.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @naddr:	number of address bytes to send. Can be zero if the operation
> + *		does not need to send an address.
> + * @ndummy:	number of dummy bytes to send after an opcode or address. Can
> + *		be zero if the operation does not require dummy bytes.
> + * @id:		pointer to a DMA-able buffer where the value of the JEDEC ID
> + *		will be written.
> + * @reg_proto:	the SPI protocol for register operation.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ndummy, u8 *id,
> +		    enum spi_nor_protocol reg_proto)

Nitpick: Could just call it 'proto'.

> +{
> +	int ret;
> +
> +	if (nor->spimem) {
> +		struct spi_mem_op op =
> +			SPI_NOR_READID_OP(naddr, ndummy, id, SPI_NOR_MAX_ID_LEN);
> +
> +		spi_nor_spimem_setup_op(nor, &op, reg_proto);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
> +						    SPI_NOR_MAX_ID_LEN);
> +	}
> +
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);

I think this message should be in spi_nor_detect(). Let octal DTR enable 
methods print their own, more specific error messages.

> +
> +	return ret;
> +}
> +
>  /**
>   * spi_nor_read_sr() - Read the Status Register.
>   * @nor:	pointer to 'struct spi_nor'.
> @@ -1649,28 +1684,15 @@ static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
>  	return NULL;
>  }
>  
> -static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
> +static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
>  {
>  	const struct flash_info *info;
>  	u8 *id = nor->bouncebuf;
>  	int ret;
>  
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, id, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
> -						    SPI_NOR_MAX_ID_LEN);
> -	}
> -	if (ret) {
> -		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
> +	ret = spi_nor_read_id(nor, 0, 0, id, nor->reg_proto);

Hmm, I wonder if it is better to explicitly use SNOR_PROTO_1_1_1 so 
clearly signify that this is intended to use 1S-1S-1S only. What do you 
think?

> +	if (ret)
>  		return ERR_PTR(ret);
> -	}
>  
>  	info = spi_nor_match_id(nor, id);
>  	if (!info) {
> @@ -2900,7 +2922,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
>  		info = spi_nor_match_name(nor, name);
>  	/* Try to auto-detect if chip name wasn't specified or not found */
>  	if (!info) {
> -		detected_info = spi_nor_read_id(nor);
> +		detected_info = spi_nor_detect(nor);
>  		info = detected_info;
>  	}
>  	if (IS_ERR_OR_NULL(info))
> @@ -2913,7 +2935,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
>  	if (name && !detected_info && info->id_len) {
>  		const struct flash_info *jinfo;
>  
> -		jinfo = spi_nor_read_id(nor);
> +		jinfo = spi_nor_detect(nor);
>  		if (IS_ERR(jinfo)) {
>  			return jinfo;
>  		} else if (jinfo != info) {
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index b7fd760e3b47..f952061d5c24 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -11,6 +11,13 @@
>  
>  #define SPI_NOR_MAX_ID_LEN	6
>  
> +/* Standard SPI NOR flash operations. */
> +#define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 0),			\
> +		   SPI_MEM_OP_ADDR(naddr, 0, 0),			\
> +		   SPI_MEM_OP_DUMMY(ndummy, 0),				\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 0))
> +
>  enum spi_nor_option_flags {
>  	SNOR_F_HAS_SR_TB	= BIT(0),
>  	SNOR_F_NO_OP_CHIP_ERASE	= BIT(1),
> @@ -534,6 +541,8 @@ void spi_nor_unlock_and_unprep(struct spi_nor *nor);
>  int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor);
>  int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor);
>  int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor);
> +int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ndummy, u8 *id,
> +		    enum spi_nor_protocol reg_proto);
>  int spi_nor_read_sr(struct spi_nor *nor, u8 *sr);
>  int spi_nor_sr_ready(struct spi_nor *nor);
>  int spi_nor_read_cr(struct spi_nor *nor, u8 *cr);

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
