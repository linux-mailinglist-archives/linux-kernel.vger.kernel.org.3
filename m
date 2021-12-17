Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DCD478A25
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhLQLim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:38:42 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52414 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbhLQLii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:38:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BHBcB5J035737;
        Fri, 17 Dec 2021 05:38:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639741091;
        bh=cUa4ryxylabq9HvOVK4F6JdzOWtWjNV2S+ltW8rqNMk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pxjhDF/dFbSAmqfHGcJpQhn6c688RCesYo70fRPdpoROzgCYugB1lkIj5bl1KhZDz
         cxpxfHF8KHEU48J6p5Rga0Fnx55kZHCTfO7yjl4eOkFMWjSwrP7f5KjHa95pyWgz5O
         CMWs/CO3BSLgd6G8ZHkx2d1+qVs8YaAzshMPcPA4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BHBcB2Q059268
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Dec 2021 05:38:11 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Dec 2021 05:38:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Dec 2021 05:38:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BHBcAur125712;
        Fri, 17 Dec 2021 05:38:11 -0600
Date:   Fri, 17 Dec 2021 17:08:10 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <vigneshr@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: macronix: Add support for
 mx66lm1g45g
Message-ID: <20211217113810.mzqrwf6vxfniggn3@ti.com>
References: <20211209190436.401946-1-tudor.ambarus@microchip.com>
 <20211209190436.401946-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211209190436.401946-2-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/21 09:04PM, Tudor Ambarus wrote:
> mx66lm1g45g supports just 1-1-1, 8-8-8 and 8d-8d-8d modes. There are
> versions of mx66lm1g45g which do not support SFDP, thus use
> SPI_NOR_SKIP_SFDP. The RDID command issued through the octal peripheral
> interface outputs data always in STR mode for whatever reason. Since

Huh! I hope this is a mistake from the chip designers, because if it 
isn't they need a stern talking-to ;-)

> 8d-8d-8s is not common, avoid reading the ID when enabling the octal dtr
> mode. Instead, read back the CR2 to check if the switch was successful.
> Tested in 1-1-1 and 8d-8d-8d modes using sama7g5 QSPI IP.

Datasheet?

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v2: SPI_NOR_SOFT_RESET as a FIXUP_FLAG
> 
> # cat /sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/jedec_id
> c2853b
> # cat /sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/manufacturer
> macronix
> # cat /sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/partname
> mx66lm1g45g
> # cat /sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/sfdp
> cat: can't open '/sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/sfdp': No such file or directory
> 
>  drivers/mtd/spi-nor/macronix.c | 113 +++++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 67aaa83038b6..9d71149233e3 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -32,6 +32,112 @@ static struct spi_nor_fixups mx25l25635_fixups = {
>  	.post_bfpt = mx25l25635_post_bfpt_fixups,
>  };
>  
> +#define SPINOR_OP_READ_CR2		0x71
> +#define SPINOR_OP_WRITE_CR2		0x72
> +#define SPINOR_OP_MX_DTR_RD		0xee
> +
> +#define SPINOR_REG_CR2_MODE_ADDR	0
> +#define SPINOR_REG_CR2_DTR_OPI_ENABLE	BIT(1)
> +#define SPINOR_REG_CR2_SPI		0
> +
> +#define SPINOR_REG_CR2_DUMMY_ADDR	0x300
> +#define SPINOR_REG_CR2_DUMMY_20		0
> +
> +static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor, bool enable)
> +{
> +	struct spi_mem_op op;
> +	int ret;
> +
> +	/* Use 20 dummy cycles for memory array reads. */

I just want to point out that if the default dummy cycle value can work 
at the maximum frequency the flash supports, you don't need to do this. 
I did it for S28 and MT35 because this wasn't the case but I remember 
some flashes having sane defaults and not needing this.

> +	if (enable) {
> +		nor->bouncebuf[0] = SPINOR_REG_CR2_DUMMY_20;
> +		op = (struct spi_mem_op)
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRITE_CR2, 1),
> +				   SPI_MEM_OP_ADDR(4, SPINOR_REG_CR2_DUMMY_ADDR,
> +						   1),
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
> +
> +		ret = spi_nor_write_enable(nor);
> +		if (ret)
> +			return ret;
> +
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +		if (ret)
> +			return ret;
> +
> +		ret = spi_nor_wait_till_ready(nor);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Set/unset the octal and DTR enable bits. */
> +	if (enable)
> +		nor->bouncebuf[0] = SPINOR_REG_CR2_DTR_OPI_ENABLE;
> +	else
> +		nor->bouncebuf[0] = SPINOR_REG_CR2_SPI;
> +
> +	op = (struct spi_mem_op)
> +		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRITE_CR2, 1),
> +			   SPI_MEM_OP_ADDR(4, SPINOR_REG_CR2_MODE_ADDR, 1),
> +			   SPI_MEM_OP_NO_DUMMY,
> +			   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));

This is not quite right. You can't have a 1-byte data phase in 8D mode 
since then your data phase is only half a cycle. What happens to the 
other half cycle would be undefined behavior for most controllers. I 
sent some patches addressing this some time back [0]. Unfortunately they 
fell off my radar.

> +	if (!enable)
> +		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> +
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +
> +	ret = spi_mem_exec_op(nor->spimem, &op);
> +	if (ret)
> +		return ret;
> +
> +	/* Read back CR2 to make sure the switch was successful. */
> +	op = (struct spi_mem_op)
> +		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_CR2, 1),
> +			   SPI_MEM_OP_ADDR(4, SPINOR_REG_CR2_MODE_ADDR, 1),
> +			   SPI_MEM_OP_DUMMY(enable ? 4 : 0, 1),
> +			   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));

Same as above.

> +	if (enable)
> +		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> +
> +	ret = spi_mem_exec_op(nor->spimem, &op);
> +	if (ret)
> +		return ret;
> +
> +	if (enable) {
> +		if (nor->bouncebuf[0] != SPINOR_REG_CR2_DTR_OPI_ENABLE) {
> +			dev_dbg(nor->dev, "Failed to enable 8d-8d-8d mode.\n");

Nitpick: s/8d-8d-8d/8D-8D-8D/

> +			return -EINVAL;
> +		}
> +	} else if (nor->bouncebuf[0] != SPINOR_REG_CR2_SPI) {
> +		dev_dbg(nor->dev, "Failed to disable 8d-8d-8d mode.\n");

Nitpick: s/8d-8d-8d/8D-8D-8D/

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void mx66lm1g45g_late_init(struct spi_nor *nor)
> +{
> +	nor->params->octal_dtr_enable = spi_nor_macronix_octal_dtr_enable;
> +
> +	/* Set the Fast Read settings. */
> +	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
> +	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
> +				  0, 20, SPINOR_OP_MX_DTR_RD,
> +				  SNOR_PROTO_8_8_8_DTR);
> +
> +	nor->cmd_ext_type = SPI_NOR_EXT_INVERT;
> +	nor->params->rdsr_dummy = 4;
> +	nor->params->rdsr_addr_nbytes = 4;
> +}
> +
> +static struct spi_nor_fixups mx66lm1g45g_fixups = {
> +	.late_init = mx66lm1g45g_late_init,
> +};
> +
>  static const struct flash_info macronix_parts[] = {
>  	/* Macronix */
>  	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1)
> @@ -100,6 +206,13 @@ static const struct flash_info macronix_parts[] = {
>  	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
> +	{ "mx66lm1g45g", INFO(0xc2853b, 0, 64 * 1024, 2048)
> +		NO_SFDP_FLAGS(SPI_NOR_SKIP_SFDP | SECT_4K |
> +			      SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP)
> +		FIXUP_FLAGS(SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE |
> +			    SPI_NOR_SOFT_RESET)
> +		.fixups = &mx66lm1g45g_fixups,
> +	},
>  };
>  
>  static void macronix_default_init(struct spi_nor *nor)
> -- 
> 2.25.1
> 

[0] https://lore.kernel.org/all/20210531181757.19458-1-p.yadav@ti.com/

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
