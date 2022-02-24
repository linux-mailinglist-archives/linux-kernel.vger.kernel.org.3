Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDD14C3638
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiBXTyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiBXTyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:54:11 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E425D6C7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:53:40 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21OJrSIa023966;
        Thu, 24 Feb 2022 13:53:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645732408;
        bh=IAh7XQOCifRrvP10OkjMTkjARuhTTjmkVV69zXQFlTk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bnTvvMzIoUHpx+RbFTTfHZPM66u5EwyAW/5ZGRu8uydIWlmsyQTwECV6iLjVa5WTB
         ULI7fT5W6rfSs5Q6xFtY0LgNGHWbLqEt+6jcKonhITB71vQDr8Yw4g59ifWxdR+r0o
         qlSU/ZO/Ym8vjwDw12Dw4yM/aBmnEZF/sxvW7oZg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21OJrScN024602
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Feb 2022 13:53:28 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 24
 Feb 2022 13:53:27 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 24 Feb 2022 13:53:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21OJrQh4090084;
        Thu, 24 Feb 2022 13:53:27 -0600
Date:   Fri, 25 Feb 2022 01:23:26 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <Takahiro.Kuwano@infineon.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>, <Bacem.Daassi@infineon.com>
Subject: Re: [PATCH 3/3] mtd: spi-nor: spansion: Rework
 spi_nor_cypress_octal_dtr_enable()
Message-ID: <20220224195326.e6atop2vitnl3w4l@ti.com>
References: <20220210023334.408926-1-tudor.ambarus@microchip.com>
 <20220210023334.408926-4-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220210023334.408926-4-tudor.ambarus@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/22 04:33AM, Tudor Ambarus wrote:
> Introduce template operation to remove code duplication.
> Split spi_nor_cypress_octal_dtr_enable() in
> spi_nor_cypress_octal_dtr_ena() spi_nor_cypress_octal_dtr_dis() as it no
> longer made sense to try to keep everything alltogether: too many
> "if (enable)" throughout the code, which made the code difficult to read.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spansion.c | 135 ++++++++++++++++++---------------
>  1 file changed, 72 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index d69a569f31e4..9bb239f1e142 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -19,85 +19,78 @@
>  #define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS	0
>  #define SPINOR_OP_CYPRESS_RD_FAST		0xee
>  
> -/**
> - * spi_nor_cypress_octal_dtr_enable() - Enable octal DTR on Cypress flashes.
> - * @nor:		pointer to a 'struct spi_nor'
> - * @enable:              whether to enable or disable Octal DTR
> - *
> - * This also sets the memory access latency cycles to 24 to allow the flash to
> - * run at up to 200MHz.
> - *
> - * Return: 0 on success, -errno otherwise.
> - */
> -static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
> +/* Spansion/Cypress SPI NOR flash operations. */
> +#define SPI_NOR_SPANSION_WR_ANY_REG_OP(naddr, addr, ndata, buf)		\

Same comments as before for variable and function names.

> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 0),		\
> +		   SPI_MEM_OP_ADDR(naddr, addr, 0),			\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
> +
> +static int spi_nor_cypress_octal_dtr_en(struct spi_nor *nor)
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
> -
> -		*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24;
> -		op = (struct spi_mem_op)
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
> -				   SPI_MEM_OP_ADDR(3, SPINOR_REG_CYPRESS_CFR2V,
> -						   1),
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -		if (ret)
> -			return ret;
> -
> -		ret = spi_nor_wait_till_ready(nor);
> -		if (ret)
> -			return ret;
> -
> -		nor->read_dummy = 24;
> -	}
> -
> -	/* Set/unset the octal and DTR enable bits. */
> -	ret = spi_nor_write_enable(nor);
> +	/* Use 24 dummy cycles for memory array reads. */
> +	*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24;
> +	op = (struct spi_mem_op)
> +		SPI_NOR_SPANSION_WR_ANY_REG_OP(3, SPINOR_REG_CYPRESS_CFR2V,
> +					       1, buf);
> +
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
> -	}
> +	ret = spi_nor_wait_till_ready(nor);
> +	if (ret)
> +		return ret;
> +
> +	nor->read_dummy = 24;
>  
> +	/* Set the octal and DTR enable bits. */
> +	buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
>  	op = (struct spi_mem_op)
> -		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
> -			   SPI_MEM_OP_ADDR(enable ? 3 : 4,
> -					   SPINOR_REG_CYPRESS_CFR5V,
> -					   1),
> -			   SPI_MEM_OP_NO_DUMMY,
> -			   SPI_MEM_OP_DATA_OUT(enable ? 1 : 2, buf, 1));
> +		SPI_NOR_SPANSION_WR_ANY_REG_OP(3, SPINOR_REG_CYPRESS_CFR5V,
> +					       1, buf);
>  
> -	if (!enable)
> -		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> +	ret = spi_nor_write_reg(nor, &op, nor->reg_proto);
> +	if (ret)
> +		return ret;
>  
> -	ret = spi_mem_exec_op(nor->spimem, &op);
> +	/* Read flash ID to make sure the switch was successful. */
> +	ret = spi_nor_read_id(nor, 4, 3, buf, SNOR_PROTO_8_8_8_DTR);
> +	if (ret)
> +		return ret;
> +
> +	if (memcmp(buf, nor->info->id, nor->info->id_len))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int spi_nor_cypress_octal_dtr_dis(struct spi_nor *nor)
> +{
> +	struct spi_mem_op op;
> +	u8 *buf = nor->bouncebuf;
> +	int ret;
> +
> +	/*
> +	 * The register is 1-byte wide, but 1-byte transactions are not allowed
> +	 * in 8D-8D-8D mode. Since there is no register at the next location,
> +	 * just initialize the value to 0 and let the transaction go on.
> +	 */
> +	buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
> +	buf[1] = 0;
> +	op = (struct spi_mem_op)
> +		SPI_NOR_SPANSION_WR_ANY_REG_OP(4, SPINOR_REG_CYPRESS_CFR5V,
> +					       2, buf);
> +	ret = spi_nor_write_reg(nor, &op, SNOR_PROTO_8_8_8_DTR);
>  	if (ret)
>  		return ret;
>  
>  	/* Read flash ID to make sure the switch was successful. */
> -	if (enable)
> -		ret = spi_nor_read_id(nor, 4, 3, buf, SNOR_PROTO_8_8_8_DTR);
> -	else
> -		ret = spi_nor_read_id(nor, 0, 0, buf, nor->reg_proto);
> +	ret = spi_nor_read_id(nor, 0, 0, buf, nor->reg_proto);

As with previous patch, this won't work.

I have not tested on this flash yet. I will wait for a re-roll.

>  	if (ret)
>  		return ret;
>  
> @@ -107,6 +100,22 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
>  	return 0;
>  }
>  
> +/**
> + * spi_nor_cypress_octal_dtr_enable() - Enable octal DTR on Cypress flashes.
> + * @nor:		pointer to a 'struct spi_nor'
> + * @enable:              whether to enable or disable Octal DTR
> + *
> + * This also sets the memory access latency cycles to 24 to allow the flash to
> + * run at up to 200MHz.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
> +{
> +	return enable ? spi_nor_cypress_octal_dtr_en(nor) :
> +			spi_nor_cypress_octal_dtr_dis(nor);
> +}
> +
>  static void s28hs512t_default_init(struct spi_nor *nor)
>  {
>  	nor->params->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
