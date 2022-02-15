Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72BE4B7634
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbiBOTOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:14:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243490AbiBOTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:14:11 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A25113DAE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:13:57 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21FJDhm7000644;
        Tue, 15 Feb 2022 13:13:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644952423;
        bh=7OwaduZPLkGK401BNbTmi2EmMBOqRw81kM8za35FTxs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rv4c0QqvmEwCfSZaoeiN4VIStihxwhhHTa9VPS1O164dDk1Qr5UPPgNrlQMVqDwdD
         JPhL4cEQWeIwH74ZQzEDEtkI3ek5Jd4SXFt4UFTtj3jwx6T1YyvTtdxyRlT3z3HDDb
         pbNoX70yOI7K1aLwcz8YOpGGSl53taqCJhGPkMuk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21FJDhIu019605
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 13:13:43 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Feb 2022 13:13:19 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Feb 2022 13:13:19 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21FJDJbG017292;
        Tue, 15 Feb 2022 13:13:19 -0600
Date:   Wed, 16 Feb 2022 00:43:18 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 07/14] mtd: spi-nor: move all micron-st specifics into
 micron-st.c
Message-ID: <20220215191318.a3dzc26dazgd6i4k@ti.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-8-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220202145853.4187726-8-michael@walle.cc>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/22 03:58PM, Michael Walle wrote:
> The flag status register is only available on micron flashes. Move all
> the functions around that into the micron module.
> 
> This is almost a mechanical move except for the spi_nor_fsr_ready()
> which now also checks the normal status register. Previously, this was
> done in spi_nor_ready().
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/core.c      | 123 +-----------------------------
>  drivers/mtd/spi-nor/micron-st.c | 129 ++++++++++++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h     |   8 --
>  3 files changed, 130 insertions(+), 130 deletions(-)
> 
[...]
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index bb95b1aabf74..c66580e8aa00 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -8,6 +8,8 @@
>  
>  #include "core.h"
>  
> +#define SPINOR_OP_RDFSR		0x70	/* Read flag status register */
> +#define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
>  #define SPINOR_OP_MT_DTR_RD	0xfd	/* Fast Read opcode in DTR mode */
>  #define SPINOR_OP_MT_RD_ANY_REG	0x85	/* Read volatile register */
>  #define SPINOR_OP_MT_WR_ANY_REG	0x81	/* Write volatile register */
> @@ -17,6 +19,12 @@
>  #define SPINOR_MT_OCT_DTR	0xe7	/* Enable Octal DTR. */
>  #define SPINOR_MT_EXSPI		0xff	/* Enable Extended SPI (default) */
>  
> +/* Flag Status Register bits */
> +#define FSR_READY		BIT(7)	/* Device status, 0 = Busy, 1 = Ready */
> +#define FSR_E_ERR		BIT(5)	/* Erase operation status */
> +#define FSR_P_ERR		BIT(4)	/* Program operation status */
> +#define FSR_PT_ERR		BIT(1)	/* Protection error bit */
> +
>  static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
>  {
>  	struct spi_mem_op op;
> @@ -273,12 +281,133 @@ static int st_micron_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>  	return spi_nor_write_disable(nor);
>  }
>  
> +/**
> + * spi_nor_read_fsr() - Read the Flag Status Register.
> + * @nor:	pointer to 'struct spi_nor'
> + * @fsr:	pointer to a DMA-able buffer where the value of the
> + *              Flag Status Register will be written. Should be at least 2
> + *              bytes.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
> +{
> +	int ret;
> +
> +	if (nor->spimem) {
> +		struct spi_mem_op op =
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDFSR, 0),
> +				   SPI_MEM_OP_NO_ADDR,
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_DATA_IN(1, fsr, 0));
> +
> +		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
> +			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
> +			op.dummy.nbytes = nor->params->rdsr_dummy;
> +			/*
> +			 * We don't want to read only one byte in DTR mode. So,
> +			 * read 2 and then discard the second byte.
> +			 */
> +			op.data.nbytes = 2;
> +		}
> +
> +		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> +
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_RDFSR, fsr,
> +						      1);
> +	}
> +
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d reading FSR\n", ret);
> +
> +	return ret;
> +}
> +
> +/**
> + * spi_nor_clear_fsr() - Clear the Flag Status Register.
> + * @nor:	pointer to 'struct spi_nor'.
> + */
> +static void spi_nor_clear_fsr(struct spi_nor *nor)
> +{
> +	int ret;
> +
> +	if (nor->spimem) {
> +		struct spi_mem_op op =
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 0),
> +				   SPI_MEM_OP_NO_ADDR,
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_NO_DATA);
> +
> +		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> +
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_CLFSR,
> +						       NULL, 0);
> +	}
> +
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d clearing FSR\n", ret);
> +}
> +
> +/**
> + * spi_nor_fsr_ready() - Query the Flag Status Register to see if the flash is
> + * ready for new commands.
> + * @nor:	pointer to 'struct spi_nor'.
> + *
> + * Return: 1 if ready, 0 if not ready, -errno on errors.
> + */
> +static int spi_nor_fsr_ready(struct spi_nor *nor)

Nitpick: At this point this function is not just spi_nor_fsr_ready(). I 
think it should be renamed to something more accurate like 
micron_st_ready() (with whatever prefix scheme that was decided upon).

Looks good otherwise.

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
