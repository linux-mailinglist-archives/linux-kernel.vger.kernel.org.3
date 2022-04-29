Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4575851422E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354411AbiD2GMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345879AbiD2GMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:12:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAE571A14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:09:12 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23T68sjS061532;
        Fri, 29 Apr 2022 01:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651212534;
        bh=RZgucMwnPVvB+o/MrUBt8zsOyMFS8ZhmghhtAvhsMoo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Nafu+WeqBgkJZLIlDaT0EZQwTS6ed5dyWCw29smBf6mNkwsrD2lobMHIk7cAaZbON
         XcZYWQvaIkR3nqjisWt04WHXCsIBCd3h4W8cnDlDa22Z0mKlbFmXlycHfWOgYL+wY5
         svMYWrm1ULNGPuOZdvVBm21m0Rd/mNXT3EKMtRBw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23T68sGc028429
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Apr 2022 01:08:54 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 29
 Apr 2022 01:08:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 29 Apr 2022 01:08:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23T68rfp035139;
        Fri, 29 Apr 2022 01:08:53 -0500
Date:   Fri, 29 Apr 2022 11:38:53 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: move spi_nor_write_ear() to winbond module
Message-ID: <20220429060852.whf5puyf6nkvm4jn@ti.com>
References: <20220418112404.2790469-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220418112404.2790469-1-michael@walle.cc>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 18/04/22 01:24PM, Michael Walle wrote:
> The "Extended Address Register" is winbond specific. If the flash is
> larger than 16MiB and is used in 3 byte address mode, it is used to set
> the remaining address bits. Move the write_ear() function the winbond
> module and rename it accordingly.

This patch no longer applies due to Tudor's patch c0abb861c5d0 ("mtd: 
spi-nor: Introduce templates for SPI NOR operations") which changes the 
contents of spi_nor_write_ear() to use a template. Please rebase and 
resend so I can apply it.

> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/core.c    | 34 ---------------------------------
>  drivers/mtd/spi-nor/core.h    |  1 -
>  drivers/mtd/spi-nor/winbond.c | 36 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 35 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index b4f141ad9c9c..848836535cdd 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -520,40 +520,6 @@ static int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>  	return ret;
>  }
>  
> -/**
> - * spi_nor_write_ear() - Write Extended Address Register.
> - * @nor:	pointer to 'struct spi_nor'.
> - * @ear:	value to write to the Extended Address Register.
> - *
> - * Return: 0 on success, -errno otherwise.
> - */
> -int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
> -{
> -	int ret;
> -
> -	nor->bouncebuf[0] = ear;
> -
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 0));
> -
> -		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_WREAR,
> -						       nor->bouncebuf, 1);
> -	}
> -
> -	if (ret)
> -		dev_dbg(nor->dev, "error %d writing EAR\n", ret);
> -
> -	return ret;
> -}
> -
>  /**
>   * spi_nor_sr_ready() - Query the Status Register to see if the flash is ready
>   * for new commands.
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index b7fd760e3b47..14bf28473cf3 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -526,7 +526,6 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>  int spi_nor_write_enable(struct spi_nor *nor);
>  int spi_nor_write_disable(struct spi_nor *nor);
>  int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
> -int spi_nor_write_ear(struct spi_nor *nor, u8 ear);
>  int spi_nor_wait_till_ready(struct spi_nor *nor);
>  int spi_nor_global_block_unlock(struct spi_nor *nor);
>  int spi_nor_lock_and_prep(struct spi_nor *nor);
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 1e8fb571680b..0ca96efee5c9 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -130,6 +130,40 @@ static const struct flash_info winbond_nor_parts[] = {
>  			      SPI_NOR_QUAD_READ) },
>  };
>  
> +/**
> + * winbond_nor_write_ear() - Write Extended Address Register.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @ear:	value to write to the Extended Address Register.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int winbond_nor_write_ear(struct spi_nor *nor, u8 ear)
> +{
> +	int ret;
> +
> +	nor->bouncebuf[0] = ear;
> +
> +	if (nor->spimem) {
> +		struct spi_mem_op op =
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 0),
> +				   SPI_MEM_OP_NO_ADDR,
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 0));
> +
> +		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> +
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_WREAR,
> +						       nor->bouncebuf, 1);
> +	}
> +
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d writing EAR\n", ret);
> +
> +	return ret;
> +}
> +
>  /**
>   * winbond_nor_set_4byte_addr_mode() - Set 4-byte address mode for Winbond
>   * flashes.
> @@ -156,7 +190,7 @@ static int winbond_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>  	if (ret)
>  		return ret;
>  
> -	ret = spi_nor_write_ear(nor, 0);
> +	ret = winbond_nor_write_ear(nor, 0);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.30.2
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
