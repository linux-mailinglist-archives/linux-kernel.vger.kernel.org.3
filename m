Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2E447A7B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhLTKZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:25:36 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56740 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhLTKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:25:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKAPITL025972;
        Mon, 20 Dec 2021 04:25:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639995918;
        bh=aGM9AiYzRqoOMq7GIZcv0fd39besY69oU8nDd4mgrZw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dsbKd1Dp8BCcgG94jS3xwtozApmsNa1XJfsjGhFuZ085oKfpgBNI2a+O5RO0hunPY
         Yr/ifUpghld4jz5BJ7hH1Nf9HL6OGZEQZxRM30cKympT0M9eDzfeE5M4gllwz2E0e9
         b2QQrsUY0TjIhsnoKkVaV2jlXuCweRzmeG2pMbGg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKAPIkB036564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 04:25:18 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 04:25:18 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 04:25:18 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKAPHDw109552;
        Mon, 20 Dec 2021 04:25:17 -0600
Date:   Mon, 20 Dec 2021 15:55:16 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v5 2/2] mtd: spi-nor: macronix: Add support for
 mx66lm1g45g
Message-ID: <20211220102514.bnws67ks5uia5yfh@ti.com>
References: <20211217180601.585825-1-tudor.ambarus@microchip.com>
 <20211217180601.585825-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211217180601.585825-2-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On 17/12/21 08:06PM, Tudor Ambarus wrote:
> mx66lm1g45g supports just 1-1-1, 8-8-8 and 8D-8D-8D modes. There are
> versions of mx66lm1g45g which do not support SFDP, thus use
> SPI_NOR_SKIP_SFDP. The RDID command issued through the octal peripheral
> interface outputs data always in STR mode for whatever reason. Since
> 8D-8D-8S is not common, avoid reading the ID when enabling the octal dtr
> mode. Instead, read back the CR2 to check if the switch was successful.

I replied to your v2 just now about this.

> Tested in 1-1-1 and 8d-8d-8d modes using sama7g5 QSPI IP.

Link to datasheet in the commit message would be nice.

As discussed on IRC, this flash reverses byte order in 8D-8D-8D mode. So 
the data you write in 1S-1S-1S mode will be have byte order reversed 
when reading in 8D-8D-8D mode. Do you have any plans on doing something 
for this? Or do we just leave it to the user to figure it out?

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v5: drop superfluous "buf" local variable in
> spi_nor_macronix_read/write_cr2. buf was used only once, no need for a
> dedicated local variable.
> 
> v4: macronix requires that undefined register addresses to keep their
> value unchanged. The second byte of CR2 is not defined. Read the second
> byte of CR2 before disabling Octal DTR mode, so that we don't modify its
> value when disabling Octal DTR.
> 
> v3:
> - drop setting of dummy cycles, use the default value
> - avoid odd lengths in octal dtr mode
> - s/8d-8d-8d/8D-8D-8D
> 
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
>  drivers/mtd/spi-nor/macronix.c | 107 +++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 67aaa83038b6..88b1218f19f4 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -32,6 +32,106 @@ static struct spi_nor_fixups mx25l25635_fixups = {
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
> +static int spi_nor_macronix_read_cr2(struct spi_nor *nor, bool octal_dtr)
> +{
> +	struct spi_mem_op op =
> +		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_CR2, 1),
> +			   SPI_MEM_OP_ADDR(4, SPINOR_REG_CR2_MODE_ADDR, 1),
> +			   SPI_MEM_OP_DUMMY(octal_dtr ? 4 : 0, 1),
> +			   SPI_MEM_OP_DATA_IN(octal_dtr ? 2 : 1, nor->bouncebuf, 1));

Set buswidths to 0 and call spi_nor_spimem_setup_op() for both 1S-1S-1S 
and 8D-8D-8D.

> +
> +	if (octal_dtr)
> +		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> +	return spi_mem_exec_op(nor->spimem, &op);
> +}
> +
> +static int spi_nor_macronix_write_cr2(struct spi_nor *nor, bool octal_dtr)
> +{
> +	struct spi_mem_op op =
> +		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRITE_CR2, 1),
> +			   SPI_MEM_OP_ADDR(4, SPINOR_REG_CR2_MODE_ADDR, 1),
> +			   SPI_MEM_OP_NO_DUMMY,
> +			   SPI_MEM_OP_DATA_OUT(octal_dtr ? 2 : 1, nor->bouncebuf, 1));
> +	int ret;
> +
> +	if (octal_dtr)
> +		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);

Same as above.

> +
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +	return spi_mem_exec_op(nor->spimem, &op);
> +}
> +
> +static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor, bool enable)
> +{
> +	u8 *buf = nor->bouncebuf;
> +	int ret;
> +
> +	/* Set/unset the octal and DTR enable bits. */
> +	if (enable) {
> +		buf[0] = SPINOR_REG_CR2_DTR_OPI_ENABLE;
> +	} else {
> +		/*
> +		 * One byte transactions are not allowed in 8D-8D-8D mode.
> +		 * mx66lm1g45g requires that undefined register addresses to
> +		 * keep their value unchanged. Its second CR2 byte value is not
> +		 * defined. Read the second byte value of CR2 so that we can
> +		 * write it back when disabling Octal DTR mode.
> +		 */
> +		ret = spi_nor_macronix_read_cr2(nor, true);
> +		if (ret)
> +			return ret;
> +		buf[0] = SPINOR_REG_CR2_SPI;

The fact that spi_nor_macronix_read_cr2() fills buf[1] is not very 
obvious. Can you pass buf as a argument to make this relationship a bit 
more clear?

> +	}
> +	ret = spi_nor_macronix_write_cr2(nor, !enable);
> +	if (ret)
> +		return ret;
> +
> +	/* Read back CR2 to make sure the switch was successful. */
> +	ret = spi_nor_macronix_read_cr2(nor, enable);
> +	if (ret)
> +		return ret;
> +	if (enable) {
> +		if (buf[0] != SPINOR_REG_CR2_DTR_OPI_ENABLE) {
> +			dev_dbg(nor->dev, "Failed to enable 8D-8D-8D mode.\n");
> +			return -EINVAL;
> +		}
> +	} else if (buf[0] != SPINOR_REG_CR2_SPI) {
> +		dev_dbg(nor->dev, "Failed to disable 8D-8D-8D mode.\n");
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
> @@ -100,6 +200,13 @@ static const struct flash_info macronix_parts[] = {
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

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
