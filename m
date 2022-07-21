Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483D757D0AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiGUQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiGUQEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:04:53 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758C188754
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:04:50 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id EYfNovWJQcdW9EYfNoUATb; Thu, 21 Jul 2022 18:04:48 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 21 Jul 2022 18:04:48 +0200
X-ME-IP: 90.11.190.129
Message-ID: <e75afa5a-a856-7747-cfcf-6dce5121c3af@wanadoo.fr>
Date:   Thu, 21 Jul 2022 18:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 1/5] spi: spi-gxp: Add support for HPE GXP SoCs
Content-Language: en-US
To:     nick.hawkins@hpe.com
Cc:     arnd@arndb.de, broonie@kernel.org, devicetree@vger.kernel.org,
        joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux@armlinux.org.uk,
        robh+dt@kernel.org, verdun@hpe.com
References: <20220720201158.78068-1-nick.hawkins@hpe.com>
 <20220720201158.78068-2-nick.hawkins@hpe.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220720201158.78068-2-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a few nitpicks below, should there be a v2.

Le 20/07/2022 à 22:11, nick.hawkins-ZPxbGqLxI0U@public.gmane.org a écrit :
> From: Nick Hawkins <nick.hawkins-ZPxbGqLxI0U@public.gmane.org>
> 
> The GXP supports 3 separate SPI interfaces to accommodate the system
> flash, core flash, and other functions. The SPI engine supports variable
> clock frequency, selectable 3-byte or 4-byte addressing and a
> configurable x1, x2, and x4 command/address/data modes. The memory
> buffer for reading and writing ranges between 256 bytes and 8KB. This
> driver supports access to the core flash and bios part.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins-ZPxbGqLxI0U@public.gmane.org>
> ---
>   drivers/spi/Kconfig   |   7 +
>   drivers/spi/Makefile  |   1 +
>   drivers/spi/spi-gxp.c | 355 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 363 insertions(+)
>   create mode 100644 drivers/spi/spi-gxp.c
> 

[...]

> diff --git a/drivers/spi/spi-gxp.c b/drivers/spi/spi-gxp.c
> new file mode 100644
> index 000000000000..85e800718d8a
> --- /dev/null
> +++ b/drivers/spi/spi-gxp.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0=or-later
> +/* Copyright (C) 2022 Hewlett-Packard Development Company, L.P. */
> +
> +#include <linux/iopoll.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi.h>

Same include twice.

> +#include <linux/spi/spi-mem.h>
> +

[...]

> +static int gxp_spi_read_reg(struct gxp_spi_chip *chip, const struct spi_mem_op *op)
> +{
> +	int ret = 0;

Useless initialization.

> +	struct gxp_spi *spifi = chip->spifi;
> +	void __iomem *reg_base = spifi->reg_base;
> +	u32 value;
> +	int cs;
> +
> +	cs = chip->cs;

Could be set in the initialization, as for the 2 other variables.
(if it makes sense)

> +
> +	value = readl(reg_base + OFFSET_SPIMCFG);
> +	value &= ~(1 << 24);
> +	value |= (cs << 24);
> +	value &= ~(0x07 << 16);
> +	value &= ~(0x1f << 19);
> +	writel(value, reg_base + OFFSET_SPIMCFG);
> +
> +	writel(0, reg_base + OFFSET_SPIADDR);
> +
> +	writeb(op->cmd.opcode, reg_base + OFFSET_SPICMD);
> +
> +	writew(op->data.nbytes, reg_base + OFFSET_SPIDCNT);
> +
> +	value = readb(reg_base + OFFSET_SPIMCTRL);
> +	value &= ~SPIMCTRL_DIR;
> +	value |= SPIMCTRL_START;
> +
> +	writeb(value, reg_base + OFFSET_SPIMCTRL);
> +
> +	ret = readb_poll_timeout(reg_base + OFFSET_SPIMCTRL, value,
> +				 !(value & SPIMCTRL_BUSY),
> +				 GXP_SPI_SLEEP_TIME, GXP_SPI_TIMEOUT);
> +	if (ret) {
> +		dev_warn(spifi->dev, "read reg busy time out\n");
> +		return ret;
> +	}
> +
> +	memcpy_fromio(op->data.buf.in, spifi->dat_base, op->data.nbytes);
> +	return ret;
> +}
> +
> +static int gxp_spi_write_reg(struct gxp_spi_chip *chip, const struct spi_mem_op *op)
> +{
> +	int ret = 0;

Useless initialization.

> +	struct gxp_spi *spifi = chip->spifi;
> +	void __iomem *reg_base = spifi->reg_base;
> +	u32 value;
> +	int cs;
> +
> +	cs = chip->cs;

Could be set in the initialization, as for the 2 other variables.
(if it makes sense)

> +
> +	value = readl(reg_base + OFFSET_SPIMCFG);
> +	value &= ~(1 << 24);
> +	value |= (cs << 24);
> +	value &= ~(0x07 << 16);
> +	value &= ~(0x1f << 19);
> +	writel(value, reg_base + OFFSET_SPIMCFG);
> +
> +	writel(0, reg_base + OFFSET_SPIADDR);
> +
> +	writeb(op->cmd.opcode, reg_base + OFFSET_SPICMD);
> +
> +	memcpy_toio(spifi->dat_base, op->data.buf.in, op->data.nbytes);
> +
> +	writew(op->data.nbytes, reg_base + OFFSET_SPIDCNT);
> +
> +	value = readb(reg_base + OFFSET_SPIMCTRL);
> +	value |= SPIMCTRL_DIR;
> +	value |= SPIMCTRL_START;
> +
> +	writeb(value, reg_base + OFFSET_SPIMCTRL);
> +
> +	ret = readb_poll_timeout(reg_base + OFFSET_SPIMCTRL, value,
> +				 !(value & SPIMCTRL_BUSY),
> +				 GXP_SPI_SLEEP_TIME, GXP_SPI_TIMEOUT);
> +	if (ret)
> +		dev_warn(spifi->dev, "write reg busy time out\n");
> +
> +	return ret;
> +}
> +
> +static ssize_t gxp_spi_read(struct gxp_spi_chip *chip, const struct spi_mem_op *op)
> +{
> +	int cs;
> +	struct gxp_spi *spifi = chip->spifi;
> +	u32 offset = op->addr.val;
> +
> +	cs = chip->cs;

Could be set in the initialization, as for the 2 other variables.
(if it makes sense)

> +
> +	if (cs == 0)
> +		offset += 0x4000000;
> +
> +	memcpy_fromio(op->data.buf.in, spifi->dir_base + offset, op->data.nbytes);
> +
> +	return 0;
> +}
> +
> +static ssize_t gxp_spi_write(struct gxp_spi_chip *chip, const struct spi_mem_op *op)
> +{
> +	struct gxp_spi *spifi = chip->spifi;
> +	void __iomem *reg_base = spifi->reg_base;
> +	u32 write_len;
> +	u32 value;
> +	int cs;
> +	int ret = 0;

Useless initialization.

> +
> +	cs = chip->cs;

Could be set in the initialization, as for the 2 other variables.
(if it makes sense)

> +
> +	write_len = op->data.nbytes;
> +	if (write_len > SPILDAT_LEN)
> +		write_len = SPILDAT_LEN;
> +
> +	value = readl(reg_base + OFFSET_SPIMCFG);
> +	value &= ~(1 << 24);
> +	value |= (cs << 24);
> +	value &= ~(0x07 << 16);
> +	value |= (op->addr.nbytes << 16);
> +	value &= ~(0x1f << 19);
> +	writel(value, reg_base + OFFSET_SPIMCFG);
> +
> +	writel(op->addr.val, reg_base + OFFSET_SPIADDR);
> +
> +	writeb(op->cmd.opcode, reg_base + OFFSET_SPICMD);
> +
> +	writew(write_len, reg_base + OFFSET_SPIDCNT);
> +
> +	memcpy_toio(spifi->dat_base, op->data.buf.in, write_len);
> +
> +	value = readb(reg_base + OFFSET_SPIMCTRL);
> +	value |= SPIMCTRL_DIR;
> +	value |= SPIMCTRL_START;
> +
> +	writeb(value, reg_base + OFFSET_SPIMCTRL);
> +
> +	ret = readb_poll_timeout(reg_base + OFFSET_SPIMCTRL, value,
> +				 !(value & SPIMCTRL_BUSY),
> +				 GXP_SPI_SLEEP_TIME, GXP_SPI_TIMEOUT);
> +	if (ret) {
> +		dev_warn(spifi->dev, "write busy time out\n");
> +		return ret;
> +	}
> +
> +	return write_len;
> +}
> +
> +static int do_gxp_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct gxp_spi *spifi = spi_controller_get_devdata(mem->spi->master);
> +	struct gxp_spi_chip *chip = &spifi->chips[mem->spi->chip_select];

Useless empty line.

> +
> +	int ret = 0;

Useless initialization. (But I'm not sure the compiler is smart enough 
to see it)

> +
> +	if (op->data.dir == SPI_MEM_DATA_IN) {
> +		if (!op->addr.nbytes)
> +			ret = gxp_spi_read_reg(chip, op);
> +		else
> +			ret = gxp_spi_read(chip, op);
> +	} else {
> +		if (!op->addr.nbytes)
> +			ret = gxp_spi_write_reg(chip, op);
> +		else
> +			ret = gxp_spi_write(chip, op);
> +	}
> +
> +	return ret;
> +}

[...]

> +static int gxp_spifi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct gxp_spi_data *data;
> +	struct spi_controller *ctlr;
> +	struct gxp_spi *spifi;
> +	struct resource *res;
> +	int ret;
> +
> +	data = of_device_get_match_data(&pdev->dev);
> +	if (!data) {
> +		dev_err(&pdev->dev, "of_dev_get_match_data failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	ctlr = devm_spi_alloc_master(dev, sizeof(*spifi));
> +	if (!ctlr) {
> +		dev_err(&pdev->dev, "spi_alloc_master failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	spifi = spi_controller_get_devdata(ctlr);
> +	if (!spifi) {
> +		dev_err(&pdev->dev, "spi_controller_get_data failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, spifi);
> +	spifi->data = data;
> +	spifi->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	spifi->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(spifi->reg_base))
> +		return PTR_ERR(spifi->reg_base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	spifi->dat_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(spifi->dat_base))
> +		return PTR_ERR(spifi->dat_base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	spifi->dir_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(spifi->dir_base))
> +		return PTR_ERR(spifi->dir_base);
> +
> +	ctlr->mode_bits = data->mode_bits;
> +	ctlr->bus_num = pdev->id;
> +	ctlr->mem_ops = &gxp_spi_mem_ops;
> +	ctlr->setup = gxp_spi_setup;
> +	ctlr->num_chipselect = data->max_cs;
> +	ctlr->dev.of_node = dev->of_node;
> +
> +	ret = devm_spi_register_controller(dev, ctlr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_controller failed\n");
> +		return ret;

Could be return dev_err_probe(), but it is mostly a matter of taste, I 
guess.

CJ
