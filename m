Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6CC4C1211
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbiBWMAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiBWMAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:00:03 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93F899EF9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:59:35 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21NBxSQF028094;
        Wed, 23 Feb 2022 05:59:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645617568;
        bh=y0CTifx/SII+A7nZ6Kxf8q8vy5DnXtlySIBCjwQtU1w=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=W+2sa+0+1y/Ia6DVpQBe4lW2nSAduGBmmCBqUhQT4ZpTFFzTBPwSwuW65A2GgykUL
         Yq90GVuSYrH6TAFq9fOg5CbAUcX0o/Mk7JlttNrpcRKzU9DGC66LC/790wO4BPjXXB
         rKQrnCUxIfmN5QyGOAj1FxSb8lze1fAnt6SnaeNA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21NBxRZe027398
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 05:59:27 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 05:59:24 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 05:59:24 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21NBxNAj114579;
        Wed, 23 Feb 2022 05:59:24 -0600
Date:   Wed, 23 Feb 2022 17:29:23 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <yaliang.wang@windriver.com>
Subject: Re: [PATCH v4 28/32] mtd: spi-nor: move all spansion specifics into
 spansion.c
Message-ID: <20220223115923.rxvpuuaj4dkdrxdl@ti.com>
References: <20220221120809.1531502-1-michael@walle.cc>
 <20220221120809.1531502-29-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220221120809.1531502-29-michael@walle.cc>
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

On 21/02/22 01:08PM, Michael Walle wrote:
> The clear status register flags is only available on spansion flashes.
> Move all the functions around that into the spanion module.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/core.c     | 49 ------------------------
>  drivers/mtd/spi-nor/spansion.c | 70 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h    |  1 -
>  3 files changed, 70 insertions(+), 50 deletions(-)
> 
[...]
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index 1a0e7214d9e5..38eeb0913ab2 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -8,6 +8,7 @@
>  
>  #include "core.h"
>  
> +#define SPINOR_OP_CLSR		0x30	/* Clear status register 1 */
>  #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
>  #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
>  #define SPINOR_REG_CYPRESS_CFR2V		0x00800003
> @@ -294,6 +295,72 @@ static const struct flash_info spansion_nor_parts[] = {
>  	},
>  };
>  
> +/**
> + * spi_nor_clear_sr() - Clear the Status Register.
> + * @nor:	pointer to 'struct spi_nor'.
> + */
> +static void spi_nor_clear_sr(struct spi_nor *nor)
> +{
> +	int ret;
> +
> +	if (nor->spimem) {
> +		struct spi_mem_op op =
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 0),
> +				   SPI_MEM_OP_NO_ADDR,
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_NO_DATA);
> +
> +		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> +
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_CLSR,
> +						       NULL, 0);
> +	}
> +
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d clearing SR\n", ret);
> +}
> +
> +/**
> + * spi_nor_sr_ready_and_clear() - Query the Status Register to see if the flash
> + * is ready for new commands and clear it.

Nitpick: "... and clear it if there are any errors."

Looks good otherwise.

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> + * @nor:	pointer to 'struct spi_nor'.
> + *
> + * Return: 1 if ready, 0 if not ready, -errno on errors.
> + */
> +static int spi_nor_sr_ready_and_clear(struct spi_nor *nor)
> +{
> +	int ret;
> +
> +	ret = spi_nor_read_sr(nor, nor->bouncebuf);
> +	if (ret)
> +		return ret;
> +
> +	if (nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
> +		if (nor->bouncebuf[0] & SR_E_ERR)
> +			dev_err(nor->dev, "Erase Error occurred\n");
> +		else
> +			dev_err(nor->dev, "Programming Error occurred\n");
> +
> +		spi_nor_clear_sr(nor);
> +
> +		/*
> +		 * WEL bit remains set to one when an erase or page program
> +		 * error occurs. Issue a Write Disable command to protect
> +		 * against inadvertent writes that can possibly corrupt the
> +		 * contents of the memory.
> +		 */
> +		ret = spi_nor_write_disable(nor);
> +		if (ret)
> +			return ret;
> +
> +		return -EIO;
> +	}
> +
> +	return !(nor->bouncebuf[0] & SR_WIP);
> +}
> +
>  static void spansion_nor_late_init(struct spi_nor *nor)
>  {
>  	if (nor->params->size > SZ_16M) {
> @@ -302,6 +369,9 @@ static void spansion_nor_late_init(struct spi_nor *nor)
>  		nor->erase_opcode = SPINOR_OP_SE;
>  		nor->mtd.erasesize = nor->info->sector_size;
>  	}
> +
> +	if (nor->flags & SNOR_F_USE_CLSR)
> +		nor->params->ready = spi_nor_sr_ready_and_clear;
>  }
>  
>  static const struct spi_nor_fixups spansion_nor_fixups = {
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 4622251a79ff..5e25a7b75ae2 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -90,7 +90,6 @@
>  
>  /* Used for Spansion flashes only. */
>  #define SPINOR_OP_BRWR		0x17	/* Bank register write */
> -#define SPINOR_OP_CLSR		0x30	/* Clear status register 1 */
>  
>  /* Used for Micron flashes only. */
>  #define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
> -- 
> 2.30.2
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
