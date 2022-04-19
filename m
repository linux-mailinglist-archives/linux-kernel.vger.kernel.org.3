Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC0506B51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351804AbiDSLrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243139AbiDSLrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:47:20 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C1DFB7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:44:38 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5CC672223A;
        Tue, 19 Apr 2022 13:44:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650368676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ytTDMrGXxvlc63LvzCmDIHDUsFbFzDhfNCsM7lyWuZU=;
        b=gZm6tQ14fNWF84bioeUcYfEXII52GMOy3EeMlvNQVja32LCbsYK4b5fs/1lhAMldw301kW
        n3n/nhdi8IUxqdAQ7qBexD4bDwoxEaRw4N1h3K/Cu+Ae5S2z3rwqhq3A5TRNuAF8lFlJs+
        LCsgufcpXMGyuwSwNwa1h+wu1G2x1J8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Apr 2022 13:44:36 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 8/9] mtd: spi-nor: spansion: Rework
 spi_nor_cypress_octal_dtr_enable()
In-Reply-To: <20220411091033.98754-9-tudor.ambarus@microchip.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-9-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <65eb571492d666cd55a08b4ea66beefe@walle.cc>
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
> Introduce template operation to remove code duplication.
> Split spi_nor_cypress_octal_dtr_enable() in
> spi_nor_cypress_octal_dtr_ena() spi_nor_cypress_octal_dtr_dis() as it 
> no
> longer made sense to try to keep everything alltogether: too many
> "if (enable)" throughout the code, which made the code difficult to 
> read.
> Add debug messages in case spi_nor_read_id() fails.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

Reviewed-by: Michael Walle <michael@walle.cc>

> ---
> v3: collect R-b, update commit message, add dev_dbg message in case
> spi_nor_read_id() fails.
> 
>  drivers/mtd/spi-nor/spansion.c | 128 ++++++++++++++++++---------------
>  1 file changed, 69 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c 
> b/drivers/mtd/spi-nor/spansion.c
> index c5988312cc91..35d8edb515a3 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -23,87 +23,81 @@
>  #define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS	0
>  #define SPINOR_OP_CYPRESS_RD_FAST		0xee
> 
> -/**
> - * cypress_nor_octal_dtr_enable() - Enable octal DTR on Cypress 
> flashes.
> - * @nor:		pointer to a 'struct spi_nor'
> - * @enable:              whether to enable or disable Octal DTR
> - *
> - * This also sets the memory access latency cycles to 24 to allow the 
> flash to
> - * run at up to 200MHz.
> - *
> - * Return: 0 on success, -errno otherwise.
> - */
> -static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool 
> enable)
> +/* Cypress SPI NOR flash operations. */
> +#define CYPRESS_NOR_WR_ANY_REG_OP(naddr, addr, ndata, buf)		\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 0),		\
> +		   SPI_MEM_OP_ADDR(naddr, addr, 0),			\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
> +
> +static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
>  {
>  	struct spi_mem_op op;
>  	u8 *buf = nor->bouncebuf;
>  	int ret;
> 
> -	if (enable) {
> -		/* Use 24 dummy cycles for memory array reads. */
> -		ret = spi_nor_write_enable(nor);
> -		if (ret)
> -			return ret;
> +	/* Use 24 dummy cycles for memory array reads. */
> +	*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24;
> +	op = (struct spi_mem_op)
> +		CYPRESS_NOR_WR_ANY_REG_OP(3, SPINOR_REG_CYPRESS_CFR2V, 1, buf);
> 
> -		*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24;
> -		op = (struct spi_mem_op)
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
> -				   SPI_MEM_OP_ADDR(3, SPINOR_REG_CYPRESS_CFR2V,
> -						   1),
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
> +	ret = spi_nor_write_reg(nor, &op, nor->reg_proto);
> +	if (ret)
> +		return ret;
> 
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -		if (ret)
> -			return ret;
> +	ret = spi_nor_wait_till_ready(nor);
> +	if (ret)
> +		return ret;
> 
> -		ret = spi_nor_wait_till_ready(nor);
> -		if (ret)
> -			return ret;
> +	nor->read_dummy = 24;
> 
> -		nor->read_dummy = 24;
> -	}
> +	/* Set the octal and DTR enable bits. */
> +	buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
> +	op = (struct spi_mem_op)
> +		CYPRESS_NOR_WR_ANY_REG_OP(3, SPINOR_REG_CYPRESS_CFR5V, 1, buf);
> 
> -	/* Set/unset the octal and DTR enable bits. */
> -	ret = spi_nor_write_enable(nor);
> +	ret = spi_nor_write_reg(nor, &op, nor->reg_proto);
>  	if (ret)
>  		return ret;
> 
> -	if (enable) {
> -		buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
> -	} else {
> -		/*
> -		 * The register is 1-byte wide, but 1-byte transactions are not
> -		 * allowed in 8D-8D-8D mode. Since there is no register at the
> -		 * next location, just initialize the value to 0 and let the
> -		 * transaction go on.
> -		 */
> -		buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
> -		buf[1] = 0;
> +	/* Read flash ID to make sure the switch was successful. */
> +	ret = spi_nor_read_id(nor, 4, 3, buf, SNOR_PROTO_8_8_8_DTR);
> +	if (ret) {
> +		dev_dbg(nor->dev, "error %d reading JEDEC ID after enabling
> 8D-8D-8D mode\n", ret);
> +		return ret;
>  	}
> 
> -	op = (struct spi_mem_op)
> -		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
> -			   SPI_MEM_OP_ADDR(enable ? 3 : 4,
> -					   SPINOR_REG_CYPRESS_CFR5V,
> -					   1),
> -			   SPI_MEM_OP_NO_DUMMY,
> -			   SPI_MEM_OP_DATA_OUT(enable ? 1 : 2, buf, 1));
> +	if (memcmp(buf, nor->info->id, nor->info->id_len))
> +		return -EINVAL;
> 
> -	if (!enable)
> -		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> +	return 0;
> +}
> 
> -	ret = spi_mem_exec_op(nor->spimem, &op);
> +static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
> +{
> +	struct spi_mem_op op;
> +	u8 *buf = nor->bouncebuf;
> +	int ret;
> +
> +	/*
> +	 * The register is 1-byte wide, but 1-byte transactions are not 
> allowed
> +	 * in 8D-8D-8D mode. Since there is no register at the next location,
> +	 * just initialize the value to 0 and let the transaction go on.
> +	 */
> +	buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
> +	buf[1] = 0;
> +	op = (struct spi_mem_op)
> +		CYPRESS_NOR_WR_ANY_REG_OP(4, SPINOR_REG_CYPRESS_CFR5V, 2, buf);
> +	ret = spi_nor_write_reg(nor, &op, SNOR_PROTO_8_8_8_DTR);
>  	if (ret)
>  		return ret;
> 
>  	/* Read flash ID to make sure the switch was successful. */
> -	if (enable)
> -		ret = spi_nor_read_id(nor, 4, 3, buf, SNOR_PROTO_8_8_8_DTR);
> -	else
> -		ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
> -	if (ret)
> +	ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
> +	if (ret) {
> +		dev_dbg(nor->dev, "error %d reading JEDEC ID after disabling
> 8D-8D-8D mode\n", ret);
>  		return ret;
> +	}
> 
>  	if (memcmp(buf, nor->info->id, nor->info->id_len))
>  		return -EINVAL;
> @@ -111,6 +105,22 @@ static int cypress_nor_octal_dtr_enable(struct
> spi_nor *nor, bool enable)
>  	return 0;
>  }
> 
> +/**
> + * cypress_nor_octal_dtr_enable() - Enable octal DTR on Cypress 
> flashes.
> + * @nor:		pointer to a 'struct spi_nor'
> + * @enable:              whether to enable or disable Octal DTR
> + *
> + * This also sets the memory access latency cycles to 24 to allow the 
> flash to
> + * run at up to 200MHz.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool 
> enable)
> +{
> +	return enable ? cypress_nor_octal_dtr_en(nor) :
> +			cypress_nor_octal_dtr_dis(nor);
> +}
> +
>  static void s28hs512t_default_init(struct spi_nor *nor)
>  {
>  	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;

-- 
-michael
