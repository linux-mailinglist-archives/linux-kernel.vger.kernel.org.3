Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A34C3632
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiBXTwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiBXTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:52:40 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D518E1B8BD3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:52:08 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21OJpfE6023425;
        Thu, 24 Feb 2022 13:51:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645732301;
        bh=/Yco3sZhqGHYG24zZDa8hoqr6CjPjhi6uAaQBygzIN0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=wUzqL0siiBF6IFywVllx+1rK1oFxL2s7nREVGHGuXSB43zq8cMjr1w7S9oFy7f5y1
         nfFvF5gTB9M/HBDnxkTDLESb6foNoWx/oeZO15cqOBbDAvpXo949CJC3BEwIb8Q88g
         MWiUwomBRnQI8ZBSThJplDhjRZx5bMkq4quea44U=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21OJpenP099894
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Feb 2022 13:51:40 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 24
 Feb 2022 13:51:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 24 Feb 2022 13:51:40 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21OJpdWI045062;
        Thu, 24 Feb 2022 13:51:40 -0600
Date:   Fri, 25 Feb 2022 01:21:39 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <Takahiro.Kuwano@infineon.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>, <Bacem.Daassi@infineon.com>
Subject: Re: [PATCH 2/3] mtd: spi-nor: micron-st: Rework
 spi_nor_micron_octal_dtr_enable()
Message-ID: <20220224195139.i4kjbnhgthwtcaet@ti.com>
References: <20220210023334.408926-1-tudor.ambarus@microchip.com>
 <20220210023334.408926-3-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220210023334.408926-3-tudor.ambarus@microchip.com>
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

Hi Tudor,

On 10/02/22 04:33AM, Tudor Ambarus wrote:
> Introduce template operation to remove code duplication.
> Split spi_nor_micron_octal_dtr_enable() in spi_nor_micron_octal_dtr_en()
> and spi_nor_micron_octal_dtr_dis() as it no longer made sense to try to
> keep everything alltogether: too many "if (enable)" throughout the code,
> which made the code difficult to follow.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 105 +++++++++++++++++---------------
>  1 file changed, 55 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index 7f66b5943ceb..013aa6a52737 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -17,73 +17,72 @@
>  #define SPINOR_MT_OCT_DTR	0xe7	/* Enable Octal DTR. */
>  #define SPINOR_MT_EXSPI		0xff	/* Enable Extended SPI (default) */
>  
> -static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
> +/* Micron ST SPI NOR flash operations. */
> +#define SPI_NOR_MICRON_WR_ANY_REG_OP(naddr, addr, ndata, buf)		\

Should change function and variable names based on mwalle's patches 
(assuming you agree with that scheme). MICRON_NOR_WR_ANY_REG_OP?

> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 0),		\
> +		   SPI_MEM_OP_ADDR(naddr, addr, 0),			\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
> +
> +static int spi_nor_micron_octal_dtr_en(struct spi_nor *nor)

micron_nor_octal_dtr_en(). Same for other functions.

>  {
>  	struct spi_mem_op op;
>  	u8 *buf = nor->bouncebuf;
>  	int ret;
>  
> -	if (enable) {
> -		/* Use 20 dummy cycles for memory array reads. */
> -		ret = spi_nor_write_enable(nor);
> -		if (ret)
> -			return ret;
> -
> -		*buf = 20;
> -		op = (struct spi_mem_op)
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
> -				   SPI_MEM_OP_ADDR(3, SPINOR_REG_MT_CFR1V, 1),
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -		if (ret)
> -			return ret;
> +	/* Use 20 dummy cycles for memory array reads. */
> +	*buf = 20;
> +	op = (struct spi_mem_op)
> +		SPI_NOR_MICRON_WR_ANY_REG_OP(3, SPINOR_REG_MT_CFR1V, 1, buf);
> +	ret = spi_nor_write_reg(nor, &op, nor->reg_proto);
> +	if (ret)
> +		return ret;
> +	ret = spi_nor_wait_till_ready(nor);
> +	if (ret)
> +		return ret;
>  
> -		ret = spi_nor_wait_till_ready(nor);
> -		if (ret)
> -			return ret;
> -	}
> +	buf[0] = SPINOR_MT_OCT_DTR;
> +	op = (struct spi_mem_op)
> +		SPI_NOR_MICRON_WR_ANY_REG_OP(3, SPINOR_REG_MT_CFR0V, 1, buf);
> +	ret = spi_nor_write_reg(nor, &op, nor->reg_proto);
> +	if (ret)
> +		return ret;
>  
> -	ret = spi_nor_write_enable(nor);
> +	/* Read flash ID to make sure the switch was successful. */
> +	ret = spi_nor_read_id(nor, 0, 8, buf, SNOR_PROTO_8_8_8_DTR);
>  	if (ret)
>  		return ret;
>  
> -	if (enable) {
> -		buf[0] = SPINOR_MT_OCT_DTR;
> -	} else {
> -		/*
> -		 * The register is 1-byte wide, but 1-byte transactions are not
> -		 * allowed in 8D-8D-8D mode. The next register is the dummy
> -		 * cycle configuration register. Since the transaction needs to
> -		 * be at least 2 bytes wide, set the next register to its
> -		 * default value. This also makes sense because the value was
> -		 * changed when enabling 8D-8D-8D mode, it should be reset when
> -		 * disabling.
> -		 */
> -		buf[0] = SPINOR_MT_EXSPI;
> -		buf[1] = SPINOR_REG_MT_CFR1V_DEF;
> -	}
> +	if (memcmp(buf, nor->info->id, nor->info->id_len))
> +		return -EINVAL;
>  
> -	op = (struct spi_mem_op)
> -		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
> -			   SPI_MEM_OP_ADDR(enable ? 3 : 4,
> -					   SPINOR_REG_MT_CFR0V, 1),
> -			   SPI_MEM_OP_NO_DUMMY,
> -			   SPI_MEM_OP_DATA_OUT(enable ? 1 : 2, buf, 1));
> +	return 0;
> +}
>  
> -	if (!enable)
> -		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> +static int spi_nor_micron_octal_dtr_dis(struct spi_nor *nor)
> +{
> +	struct spi_mem_op op;
> +	u8 *buf = nor->bouncebuf;
> +	int ret;
>  
> -	ret = spi_mem_exec_op(nor->spimem, &op);
> +	/*
> +	 * The register is 1-byte wide, but 1-byte transactions are not allowed
> +	 * in 8D-8D-8D mode. The next register is the dummy cycle configuration
> +	 * register. Since the transaction needs to be at least 2 bytes wide,
> +	 * set the next register to its default value. This also makes sense
> +	 * because the value was changed when enabling 8D-8D-8D mode, it should
> +	 * be reset when disabling.
> +	 */
> +	buf[0] = SPINOR_MT_EXSPI;
> +	buf[1] = SPINOR_REG_MT_CFR1V_DEF;
> +	op = (struct spi_mem_op)
> +		SPI_NOR_MICRON_WR_ANY_REG_OP(4, SPINOR_REG_MT_CFR0V, 2, buf);
> +	ret = spi_nor_write_reg(nor, &op, SNOR_PROTO_8_8_8_DTR);
>  	if (ret)
>  		return ret;
>  
>  	/* Read flash ID to make sure the switch was successful. */
> -	if (enable)
> -		ret = spi_nor_read_id(nor, 0, 8, buf, SNOR_PROTO_8_8_8_DTR);
> -	else
> -		ret = spi_nor_read_id(nor, 0, 0, buf, nor->reg_proto);
> +	ret = spi_nor_read_id(nor, 0, 0, buf, nor->reg_proto);

nor->reg_proto is not updated yet. It will be updated _after_ this 
function completes. So you would end up calling read ID in 8D-8D-8D 
mode, which would be bogus.

I tried with Micron MT35XU512ABA. Enable works fine, but disable fails 
(it succeeds in reality but the function is unable to verify that) 
because of this. Changing nor->reg_proto to SNOR_PROTO_1_1_1 fixes it.

Looks like the problem is not introduced by this patch though. It seems 
to come from patch 5 of your mx66 series. I see the same with the 
Cypress flash too but I have not tested it yet.

>  	if (ret)
>  		return ret;
>  
> @@ -93,6 +92,12 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
>  	return 0;
>  }
>  
> +static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
> +{
> +	return enable ? spi_nor_micron_octal_dtr_en(nor) :
> +			spi_nor_micron_octal_dtr_dis(nor);
> +}
> +
>  static void mt35xu512aba_default_init(struct spi_nor *nor)
>  {
>  	nor->params->octal_dtr_enable = spi_nor_micron_octal_dtr_enable;
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
