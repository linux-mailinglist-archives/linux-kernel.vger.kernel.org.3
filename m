Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2A34EFAAF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348317AbiDAUDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiDAUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:03:33 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72162208C3E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:01:43 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 231K1ZUa081154;
        Fri, 1 Apr 2022 15:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648843295;
        bh=n2jW5V3wpsVqOzq/hH44jtk4+X6+OebV2enCxLcHRrA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=I5f+q+leEnBth17Bpf/h1hFKHKvQbINu+p+c7rj0W+N2S6idsh62VfpBINJlUMl7z
         n3lEQAKNv7iQHx7xN5PHKu9u3zXIInXih6FvuH7R6DbU2lYaDieoxrLBIcVrvIzaOI
         jeDnn74KJH0sODuXKtcBsee4A/X3cWHctAktcBHI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 231K1Z1q027376
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Apr 2022 15:01:35 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 1
 Apr 2022 15:01:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 1 Apr 2022 15:01:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 231K1XEc002171;
        Fri, 1 Apr 2022 15:01:34 -0500
Date:   Sat, 2 Apr 2022 01:31:33 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v2 4/4] mtd: spi-nor: sfdp: Keep SFDP definitions private
Message-ID: <20220401200133.gyyvoe7xdbsww7cv@ti.com>
References: <20220309144215.179449-1-tudor.ambarus@microchip.com>
 <20220309144215.179449-5-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220309144215.179449-5-tudor.ambarus@microchip.com>
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

On 09/03/22 04:42PM, Tudor Ambarus wrote:
> Keep the SFDP definitions private and expose just the definitions that are
> required by the core and manufacturer drivers.

I am not so sure about this. Since the post_bfpt hook passes in the bfpt 
table to flash drivers, they might end up wanting to use these for some 
checks like issi.c does for DWORD 1. They would have to move them back 
to sfdp.h for that, which just causes extra churn, and also puts some 
BFPT related defines in sfdp.h and some in sfdp.c.

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/sfdp.c | 52 +++++++++++++++++++++++++++++++++++++
>  drivers/mtd/spi-nor/sfdp.h | 53 --------------------------------------
>  2 files changed, 52 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 01e35354db3e..f5432cbd3daf 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -494,6 +494,50 @@ int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor, bool enable)
>  	return spi_nor_write_disable(nor);
>  }
>  
> +/* 11th DWORD. */
> +#define BFPT_DWORD11_PAGE_SIZE_SHIFT		4
> +#define BFPT_DWORD11_PAGE_SIZE_MASK		GENMASK(7, 4)
> +
> +/* 15th DWORD. */
> +/*
> + * (from JESD216 rev B)
> + * Quad Enable Requirements (QER):
> + * - 000b: Device does not have a QE bit. Device detects 1-1-4 and 1-4-4
> + *         reads based on instruction. DQ3/HOLD# functions are hold during
> + *         instruction phase.
> + * - 001b: QE is bit 1 of status register 2. It is set via Write Status with
> + *         two data bytes where bit 1 of the second byte is one.
> + *         [...]
> + *         Writing only one byte to the status register has the side-effect of
> + *         clearing status register 2, including the QE bit. The 100b code is
> + *         used if writing one byte to the status register does not modify
> + *         status register 2.
> + * - 010b: QE is bit 6 of status register 1. It is set via Write Status with
> + *         one data byte where bit 6 is one.
> + *         [...]
> + * - 011b: QE is bit 7 of status register 2. It is set via Write status
> + *         register 2 instruction 3Eh with one data byte where bit 7 is one.
> + *         [...]
> + *         The status register 2 is read using instruction 3Fh.
> + * - 100b: QE is bit 1 of status register 2. It is set via Write Status with
> + *         two data bytes where bit 1 of the second byte is one.
> + *         [...]
> + *         In contrast to the 001b code, writing one byte to the status
> + *         register does not modify status register 2.
> + * - 101b: QE is bit 1 of status register 2. Status register 1 is read using
> + *         Read Status instruction 05h. Status register2 is read using
> + *         instruction 35h. QE is set via Write Status instruction 01h with
> + *         two data bytes where bit 1 of the second byte is one.
> + *         [...]
> + */
> +#define BFPT_DWORD15_QER_MASK			GENMASK(22, 20)
> +#define BFPT_DWORD15_QER_NONE			(0x0UL << 20) /* Micron */
> +#define BFPT_DWORD15_QER_SR2_BIT1_BUGGY		(0x1UL << 20)
> +#define BFPT_DWORD15_QER_SR1_BIT6		(0x2UL << 20) /* Macronix */
> +#define BFPT_DWORD15_QER_SR2_BIT7		(0x3UL << 20)
> +#define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
> +#define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
> +
>  #define BFPT_DWORD16_EN4B_MASK			GENMASK(31, 24)
>  #define BFPT_DWORD16_EN4B_ALWAYS_4B		BIT(30)
>  #define BFPT_DWORD16_EN4B_4B_OPCODES		BIT(29)
> @@ -528,6 +572,14 @@ int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor, bool enable)
>  #define BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B		\
>  	(BFPT_DWORD16_EN4B_EN4B | BFPT_DWORD16_EX4B_EX4B)
>  
> +#define BFPT_DWORD16_SWRST_EN_RST		BIT(12)
> +
> +#define BFPT_DWORD18_CMD_EXT_MASK		GENMASK(30, 29)
> +#define BFPT_DWORD18_CMD_EXT_REP		(0x0UL << 29) /* Repeat */
> +#define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
> +#define BFPT_DWORD18_CMD_EXT_RES		(0x2UL << 29) /* Reserved */
> +#define BFPT_DWORD18_CMD_EXT_16B		(0x3UL << 29) /* 16-bit opcode */
> +
>  /**
>   * spi_nor_parse_bfpt() - read and parse the Basic Flash Parameter Table.
>   * @nor:		pointer to a 'struct spi_nor'
> diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
> index da2d7ec2e0aa..fd7e3c935960 100644
> --- a/drivers/mtd/spi-nor/sfdp.h
> +++ b/drivers/mtd/spi-nor/sfdp.h
> @@ -45,59 +45,6 @@ struct sfdp_bfpt {
>  #define BFPT_DWORD5_FAST_READ_2_2_2		BIT(0)
>  #define BFPT_DWORD5_FAST_READ_4_4_4		BIT(4)
>  
> -/* 11th DWORD. */
> -#define BFPT_DWORD11_PAGE_SIZE_SHIFT		4
> -#define BFPT_DWORD11_PAGE_SIZE_MASK		GENMASK(7, 4)
> -
> -/* 15th DWORD. */
> -
> -/*
> - * (from JESD216 rev B)
> - * Quad Enable Requirements (QER):
> - * - 000b: Device does not have a QE bit. Device detects 1-1-4 and 1-4-4
> - *         reads based on instruction. DQ3/HOLD# functions are hold during
> - *         instruction phase.
> - * - 001b: QE is bit 1 of status register 2. It is set via Write Status with
> - *         two data bytes where bit 1 of the second byte is one.
> - *         [...]
> - *         Writing only one byte to the status register has the side-effect of
> - *         clearing status register 2, including the QE bit. The 100b code is
> - *         used if writing one byte to the status register does not modify
> - *         status register 2.
> - * - 010b: QE is bit 6 of status register 1. It is set via Write Status with
> - *         one data byte where bit 6 is one.
> - *         [...]
> - * - 011b: QE is bit 7 of status register 2. It is set via Write status
> - *         register 2 instruction 3Eh with one data byte where bit 7 is one.
> - *         [...]
> - *         The status register 2 is read using instruction 3Fh.
> - * - 100b: QE is bit 1 of status register 2. It is set via Write Status with
> - *         two data bytes where bit 1 of the second byte is one.
> - *         [...]
> - *         In contrast to the 001b code, writing one byte to the status
> - *         register does not modify status register 2.
> - * - 101b: QE is bit 1 of status register 2. Status register 1 is read using
> - *         Read Status instruction 05h. Status register2 is read using
> - *         instruction 35h. QE is set via Write Status instruction 01h with
> - *         two data bytes where bit 1 of the second byte is one.
> - *         [...]
> - */
> -#define BFPT_DWORD15_QER_MASK			GENMASK(22, 20)
> -#define BFPT_DWORD15_QER_NONE			(0x0UL << 20) /* Micron */
> -#define BFPT_DWORD15_QER_SR2_BIT1_BUGGY		(0x1UL << 20)
> -#define BFPT_DWORD15_QER_SR1_BIT6		(0x2UL << 20) /* Macronix */
> -#define BFPT_DWORD15_QER_SR2_BIT7		(0x3UL << 20)
> -#define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
> -#define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
> -
> -#define BFPT_DWORD16_SWRST_EN_RST		BIT(12)
> -
> -#define BFPT_DWORD18_CMD_EXT_MASK		GENMASK(30, 29)
> -#define BFPT_DWORD18_CMD_EXT_REP		(0x0UL << 29) /* Repeat */
> -#define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
> -#define BFPT_DWORD18_CMD_EXT_RES		(0x2UL << 29) /* Reserved */
> -#define BFPT_DWORD18_CMD_EXT_16B		(0x3UL << 29) /* 16-bit opcode */
> -
>  struct sfdp_parameter_header {
>  	u8		id_lsb;
>  	u8		minor;
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
