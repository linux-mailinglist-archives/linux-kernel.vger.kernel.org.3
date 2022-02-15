Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7234B755B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbiBOS5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:57:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiBOS5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:57:49 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D723AA2F2D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:57:38 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21FIvMbR052255;
        Tue, 15 Feb 2022 12:57:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644951442;
        bh=5U/fmKhkScupajpvEnznWL+J0dy7eQ02Tzjl/NPjDpA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LMKQcf8cdOPVCrlWvE15B0ft3gjNkw/AEcLF2QHobhUIB/YBHBa0MahF4NUduuF/3
         XPTYZU7xkAQ24LJChF+ORz8lc3mm5T8u9CKbSc/C53Uxtud3AERlEtcx58uK7LaQFK
         7Uq0xZeIprwxuDDcbVGTQJiv5PlmS2IG4m9BZAW4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21FIvMkH020922
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 12:57:22 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Feb 2022 12:57:17 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Feb 2022 12:57:17 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21FIvHG9002914;
        Tue, 15 Feb 2022 12:57:17 -0600
Date:   Wed, 16 Feb 2022 00:27:16 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 04/14] mtd: spi-nor: move all xilinx specifics into
 xilinx.c
Message-ID: <20220215185716.ccjthc4a4merlmxw@ti.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220202145853.4187726-5-michael@walle.cc>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/22 03:58PM, Michael Walle wrote:
> Mechanically move all the xilinx functions to its own module.

If you do some code changes mechanically you should also paste the 
semantic patch for future reference.

> 
> Then register the new flash specific ready() function.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/core.c   | 64 +------------------------------
>  drivers/mtd/spi-nor/core.h   | 18 ---------
>  drivers/mtd/spi-nor/xilinx.c | 73 ++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h  |  9 -----
>  4 files changed, 74 insertions(+), 90 deletions(-)
> 
[...]
>  
> +/**
> + * spi_nor_xread_sr() - Read the Status Register on S3AN flashes.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @sr:		pointer to a DMA-able buffer where the value of the
> + *              Status Register will be written.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)

Nitpick: rename to xilinx_read_sr()?

> +{
> +	int ret;
> +
> +	if (nor->spimem) {
> +		struct spi_mem_op op =
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 0),
> +				   SPI_MEM_OP_NO_ADDR,
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_DATA_IN(1, sr, 0));
> +
> +		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> +
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_XRDSR, sr,
> +						      1);
> +	}
> +
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
> +
> +	return ret;
> +}
> +
> +/**
> + * spi_nor_xsr_ready() - Query the Status Register of the S3AN flash to see if
> + * the flash is ready for new commands.
> + * @nor:	pointer to 'struct spi_nor'.
> + *
> + * Return: 1 if ready, 0 if not ready, -errno on errors.
> + */
> +static int spi_nor_xsr_ready(struct spi_nor *nor)

Nitpick: rename to xilinx_sr_ready()?

Either way,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>


-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
