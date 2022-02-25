Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0544C3F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbiBYHvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiBYHvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:51:20 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FE91AAFCF;
        Thu, 24 Feb 2022 23:50:48 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21P7oArn092127;
        Fri, 25 Feb 2022 01:50:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645775410;
        bh=EE1HknnGs341fweb74p5Qo4hBGv3hC8wo+SMvmEQFYk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=H6LMFX+QWdtSUd9VvRoMYXp26qbIWJ9Tggb5Zbkp7PLFAQKbI0xYk2cEzbkKNE651
         FLs/Vx3F5JAB5l+hTbumoFTuxAYP+T5CQ+rBxUiCsZbNcfpRkib5z9/AQK6mwJdEVG
         qz4KCVtYvxXIQDVkaL8TYT4lfSxkAFQE9h6xF8sk=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21P7o9pQ032657
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Feb 2022 01:50:10 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 25
 Feb 2022 01:50:08 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 25 Feb 2022 01:50:08 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21P7o7Ew043530;
        Fri, 25 Feb 2022 01:50:08 -0600
Date:   Fri, 25 Feb 2022 13:20:07 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
CC:     <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] spi: spi-mem: Add driver for Aspeed SMC controllers
Message-ID: <20220225075007.73xypamm3zbjnkg6@ti.com>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214094231.3753686-4-clg@kaod.org>
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

On 14/02/22 10:42AM, Cédric Le Goater wrote:
> This SPI driver adds support for the Aspeed static memory controllers
> of the AST2600, AST2500 and AST2400 SoCs using the spi-mem interface.
> 
>  * AST2600 Firmware SPI Memory Controller (FMC)
>    . BMC firmware
>    . 3 chip select pins (CE0 ~ CE2)
>    . Only supports SPI type flash memory
>    . different segment register interface
>    . single, dual and quad mode.
> 
>  * AST2600 SPI Flash Controller (SPI1 and SPI2)
>    . host firmware
>    . 2 chip select pins (CE0 ~ CE1)
>    . different segment register interface
>    . single, dual and quad mode.
> 
>  * AST2500 Firmware SPI Memory Controller (FMC)
>    . BMC firmware
>    . 3 chip select pins (CE0 ~ CE2)
>    . supports SPI type flash memory (CE0-CE1)
>    . CE2 can be of NOR type flash but this is not supported by the driver
>    . single, dual mode.
> 
>  * AST2500 SPI Flash Controller (SPI1 and SPI2)
>    . host firmware
>    . 2 chip select pins (CE0 ~ CE1)
>    . single, dual mode.
> 
>  * AST2400 New Static Memory Controller (also referred as FMC)
>    . BMC firmware
>    . New register set
>    . 5 chip select pins (CE0 ∼ CE4)
>    . supports NOR flash, NAND flash and SPI flash memory.
>    . single, dual and quad mode.
> 
> Each controller has a memory range on which flash devices contents are
> mapped. Each device is assigned a window that can be changed at bootime
> with the Segment Address Registers.
> 
> Each SPI flash device can then be accessed in two modes: Command and
> User. When in User mode, SPI transfers are initiated with accesses to
> the memory segment of a device. When in Command mode, memory
> operations on the memory segment of a device generate SPI commands
> automatically using a Control Register for the settings.
> 
> This initial patch adds support for User mode. Command mode needs a little
> more work to check that the memory window on the AHB bus fits the device
> size. It will come later when support for direct mapping is added.
> 
> Single and dual mode RX transfers are supported. Other types than SPI
> are not supported.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  drivers/spi/spi-aspeed-smc.c            | 766 ++++++++++++++++++++++++
>  drivers/mtd/spi-nor/controllers/Kconfig |   2 +-
>  drivers/spi/Kconfig                     |  11 +
>  drivers/spi/Makefile                    |   1 +
>  4 files changed, 779 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/spi/spi-aspeed-smc.c
> 
[...]
> +
> +/* support for 1-1-1, 1-1-2 or 1-1-4 */
> +static bool aspeed_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	if (op->cmd.buswidth > 1)
> +		return false;
> +
> +	if (op->addr.nbytes != 0) {
> +		if (op->addr.buswidth > 1 || op->addr.nbytes > 4)
> +			return false;
> +	}
> +
> +	if (op->dummy.nbytes != 0) {
> +		if (op->dummy.buswidth > 1 || op->dummy.nbytes > 7)
> +			return false;
> +	}
> +
> +	if (op->data.nbytes != 0 && op->data.buswidth > 4)
> +		return false;
> +
> +	if (!spi_mem_default_supports_op(mem, op))
> +		return false;
> +
> +	return true;

Nitpick: You can just do return spi_mem_default_supports_op(mem, op);

> +}
> +
[...]
> +
> +static int aspeed_spi_init_devices(struct platform_device *pdev, struct aspeed_spi *aspi)
> +{
> +	struct device_node *np;
> +	unsigned int cs;
> +	int ret;
> +
> +	for_each_available_child_of_node(aspi->dev->of_node, np) {
> +		struct aspeed_spi_chip *chip;
> +
> +		if (!of_device_is_compatible(np, "jedec,spi-nor"))
> +			continue;
> +
> +		ret = of_property_read_u32(np, "reg", &cs);
> +		if (ret) {
> +			dev_err(aspi->dev, "Couldn't not read chip select.\n");
> +			of_node_put(np);
> +			return ret;
> +		}
> +
> +		if (cs > aspi->data->max_cs) {
> +			dev_err(aspi->dev, "Chip select %d out of range.\n", cs);
> +			of_node_put(np);
> +			return -ERANGE;
> +		}
> +
> +		chip = &aspi->chips[cs];
> +		chip->aspi = aspi;
> +		chip->cs = cs;
> +
> +		ret = aspeed_spi_chip_init(chip);
> +		if (ret) {
> +			of_node_put(np);
> +			return ret;
> +		}
> +
> +		if (of_property_read_u32(np, "spi-max-frequency", &chip->clk_freq))
> +			chip->clk_freq = ASPEED_SPI_DEFAULT_FREQ;
> +
> +		aspi->num_cs++;
> +	}

SPI MEM already gives you all this information. Get it from there, don't 
parse it yourself.

You can get Chip Select via spi_mem->spi->chip_select.
You can get clock frequency via spi_mem->spi->max_speed_hz.

With these comments fixed,

Acked-by: Pratyush Yadav <p.yadav@ti.com>

> +
> +	return 0;
> +}
> +
[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
