Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6538B4E33F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiCUXH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiCUXHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:07:10 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3116425E91
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:57:46 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 960D022175;
        Mon, 21 Mar 2022 23:56:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647903393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+5AxZS2v0QEhyDGe/oHcf9cHqL61ODkbOB80EmEliM=;
        b=TriGWu9bh10ofU/uWYYLsHC6kUBlIQgOI41JBeXIU9OaZ54ziQ02DYc5yTCtXM5I1dtGjQ
        8q/chhRTxdO95xuz8F+WglTzxEwDukJAata3KF7NxXc9Rh5ehZkR9pm9fZTF348RJ/GvQR
        JmX89bds/wLn0v8vocG9eXPx8GCFAOQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Mar 2022 23:56:33 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 4/8] mtd: spi-nor: core: Introduce method for RDID op
In-Reply-To: <20220228111712.111737-5-tudor.ambarus@microchip.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-5-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0bdbe6ad8f39996df6345bb249e4a2e8@walle.cc>
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

Am 2022-02-28 12:17, schrieb Tudor Ambarus:
> RDID is used in the core to auto detect the flash, but also by some
> manufacturer drivers that contain flashes that support Octal DTR mode,
> so that they can read the flash ID after the switch to Octal DTR was 
> made
> to test if the switch was successful. Introduce a core method for RDID 
> op
> to avoid code duplication.

Some or all? Is that specific to the flash or can we just check that
readid works in spi_nor_octal_dtr_enable()? That way we could also
just get rid of the proto parameter for the read_id because it can
be called after we set the reg_proto.

-michael

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
> + * @naddr:	number of address bytes to send. Can be zero if the 
> operation
> + *		does not need to send an address.
> + * @ndummy:	number of dummy bytes to send after an opcode or address. 
> Can
> + *		be zero if the operation does not require dummy bytes.
> + * @id:		pointer to a DMA-able buffer where the value of the JEDEC ID
> + *		will be written.
> + * @reg_proto:	the SPI protocol for register operation.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ndummy, u8 *id,
> +		    enum spi_nor_protocol reg_proto)
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
> +
> +	return ret;
> +}
> +
>  /**
>   * spi_nor_read_sr() - Read the Status Register.
>   * @nor:	pointer to 'struct spi_nor'.
> @@ -1649,28 +1684,15 @@ static const struct flash_info
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
> -	if (ret) {
> -		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
> +	ret = spi_nor_read_id(nor, 0, 0, id, nor->reg_proto);
> +	if (ret)
>  		return ERR_PTR(ret);
> -	}
> 
>  	info = spi_nor_match_id(nor, id);
>  	if (!info) {
> @@ -2900,7 +2922,7 @@ static const struct flash_info
> *spi_nor_get_flash_info(struct spi_nor *nor,
>  		info = spi_nor_match_name(nor, name);
>  	/* Try to auto-detect if chip name wasn't specified or not found */
>  	if (!info) {
> -		detected_info = spi_nor_read_id(nor);
> +		detected_info = spi_nor_detect(nor);
>  		info = detected_info;
>  	}
>  	if (IS_ERR_OR_NULL(info))
> @@ -2913,7 +2935,7 @@ static const struct flash_info
> *spi_nor_get_flash_info(struct spi_nor *nor,
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
