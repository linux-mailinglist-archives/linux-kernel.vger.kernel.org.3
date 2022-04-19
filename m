Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09E4506977
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbiDSLNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiDSLNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:13:16 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C713FA5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:10:34 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 435A42223A;
        Tue, 19 Apr 2022 13:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650366632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cfPpEjaOUS/pYpwo8vqM6KxbOl5fAswZopmIejMpqYs=;
        b=a/lFR+XiRuP4D0KZT0I2wV3hArcQFZqoZCAtmrboMp3RAw4thlnSZT8iQ0a19N3v9CyF0E
        16OhbLs4QxnAi5jiBnAfzxRuANxRs2j6NGTN8P+Sy55OkwK/vc3FbY6pAzRUKHzeZ0x49y
        QVhfhsDkw4azrXYgL3xoY0I8SAbiUB8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Apr 2022 13:10:32 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 4/9] mtd: spi-nor: core: Introduce method for RDID op
In-Reply-To: <20220411091033.98754-5-tudor.ambarus@microchip.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-5-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1812e033c1fd0c779b34166ebe796d32@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-11 11:10, schrieb Tudor Ambarus:
> RDID is used in the core to auto detect the flash, but also by some
> manufacturer drivers that contain flashes that support Octal DTR mode,
> so that they can read the flash ID after the switch to Octal DTR was 
> made
> to test if the switch was successful. Introduce a core method for RDID 
> op
> to avoid code duplication.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v3: s/reg_proto/proto
> 
>  drivers/mtd/spi-nor/core.c | 50 ++++++++++++++++++++++++++------------
>  drivers/mtd/spi-nor/core.h |  9 +++++++
>  2 files changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index b55d922d46dd..6165dc7bfd17 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -369,6 +369,37 @@ int spi_nor_write_disable(struct spi_nor *nor)
>  	return ret;
>  }
> 
> +/**
> + * spi_nor_read_id() - Read the JEDEC ID.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @naddr:	number of address bytes to send. Can be zero if the 
> operation
> + *		does not need to send an address.
> + * @ndummy:	number of dummy bytes to send after an opcode or address. 
> Can
> + *		be zero if the operation does not require dummy bytes.
> + * @id:		pointer to a DMA-able buffer where the value of the JEDEC ID
> + *		will be written.
> + * @proto:	the SPI protocol for register operation.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ndummy, u8 *id,
> +		    enum spi_nor_protocol proto)

I'm unsure on the last parameter, no other call have it.
The usual pattern is

old_proto = nor->reg_proto;
spi_nor_read_id();
nor->reg_proto = old_proto;

But I don't care too much.

Reviewed-by: Michael Walle <michael@walle.cc>

> +{
> +	int ret;
> +
> +	if (nor->spimem) {
> +		struct spi_mem_op op =
> +			SPI_NOR_READID_OP(naddr, ndummy, id, SPI_NOR_MAX_ID_LEN);
> +
> +		spi_nor_spimem_setup_op(nor, &op, proto);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
> +						    SPI_NOR_MAX_ID_LEN);
> +	}
> +	return ret;
> +}
> +
>  /**
>   * spi_nor_read_sr() - Read the Status Register.
>   * @nor:	pointer to 'struct spi_nor'.
> @@ -1649,24 +1680,13 @@ static const struct flash_info
> *spi_nor_match_id(struct spi_nor *nor,
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
> +	ret = spi_nor_read_id(nor, 0, 0, id, nor->reg_proto);
>  	if (ret) {
>  		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
>  		return ERR_PTR(ret);
> @@ -2903,7 +2923,7 @@ static const struct flash_info
> *spi_nor_get_flash_info(struct spi_nor *nor,
>  	}
>  	/* Try to auto-detect if chip name wasn't specified or not found */
>  	if (!info)
> -		return spi_nor_read_id(nor);
> +		return spi_nor_detect(nor);
> 
>  	/*
>  	 * If caller has specified name of flash model that can normally be
> @@ -2912,7 +2932,7 @@ static const struct flash_info
> *spi_nor_get_flash_info(struct spi_nor *nor,
>  	if (name && info->id_len) {
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
> @@ -534,6 +541,8 @@ void spi_nor_unlock_and_unprep(struct spi_nor 
> *nor);
>  int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor);
>  int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor);
>  int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor);
> +int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ndummy, u8 *id,
> +		    enum spi_nor_protocol reg_proto);
>  int spi_nor_read_sr(struct spi_nor *nor, u8 *sr);
>  int spi_nor_sr_ready(struct spi_nor *nor);
>  int spi_nor_read_cr(struct spi_nor *nor, u8 *cr);

-- 
-michael
