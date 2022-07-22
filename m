Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313B957E7D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiGVUDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVUDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:03:39 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A536796BB;
        Fri, 22 Jul 2022 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658520211; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4GUlLQB0aPpv22nxPOF0z62UWHL5GT/zBSnJNV62yLM=;
        b=L5oYvEmgKCcill8Gw3llzkRidYXGlkDxgZrDHgOKCuBbTnQbyCwVpEoAiHrAz0zqm5BOzV
        kvNsGpdv1ZEkleMTqIY+hOXTZC6LIHVI8wh4tKGVQuTHv3ZKgzcPIDDWrdkY3vx7pLV1AE
        zsKODExZfc8vfL5pm0D6xUPO9u+6Ji4=
Date:   Fri, 22 Jul 2022 21:03:19 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/3] SPI: Ingenic: Add SFC support for Ingenic SoCs.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        aidanmacdonald.0x0@gmail.com, tmn505@gmail.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, jinghui.liu@ingenic.com,
        sernia.zhou@foxmail.com, reimu@sudomaker.com
Message-Id: <JDUFFR.8G94WKGRB9G@crapouillou.net>
In-Reply-To: <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
        <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,


Le sam., juil. 23 2022 at 00:48:30 +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou=
 Yanjie)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Add SFC support for the X1000 SoC, the X1600 SoC, and the X2000 SoC
> from Ingenic.
>=20
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>
> ---
>  drivers/spi/Kconfig           |   9 +
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-ingenic-sfc.c | 662=20
> ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 672 insertions(+)
>  create mode 100644 drivers/spi/spi-ingenic-sfc.c
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3b1044e..1077bd3 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -437,6 +437,15 @@ config SPI_INGENIC
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called spi-ingenic.
>=20
> +config SPI_INGENIC_SFC
> +	tristate "Ingenic SoCs SPI Flash Controller"
> +	depends on MACH_INGENIC || COMPILE_TEST
> +	help
> +	  This enables support for the Ingenic SoCs SPI flash controller.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ingenic-sfc.
> +
>  config SPI_INTEL
>  	tristate
>=20
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 0f44eb6..f3e42c0 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_SPI_HISI_SFC_V3XX)		+=3D=20
> spi-hisi-sfc-v3xx.o
>  obj-$(CONFIG_SPI_IMG_SPFI)		+=3D spi-img-spfi.o
>  obj-$(CONFIG_SPI_IMX)			+=3D spi-imx.o
>  obj-$(CONFIG_SPI_INGENIC)		+=3D spi-ingenic.o
> +obj-$(CONFIG_SPI_INGENIC_SFC)	+=3D spi-ingenic-sfc.o
>  obj-$(CONFIG_SPI_INTEL)			+=3D spi-intel.o
>  obj-$(CONFIG_SPI_INTEL_PCI)		+=3D spi-intel-pci.o
>  obj-$(CONFIG_SPI_INTEL_PLATFORM)	+=3D spi-intel-platform.o
> diff --git a/drivers/spi/spi-ingenic-sfc.c=20
> b/drivers/spi/spi-ingenic-sfc.c
> new file mode 100644
> index 00000000..a565546
> --- /dev/null
> +++ b/drivers/spi/spi-ingenic-sfc.c
> @@ -0,0 +1,662 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

Dual-license driver? That's not what MODULE_LICENSE() says.

> +/*
> + * Ingenic SoCs SPI Flash Controller Driver
> + * Copyright (c) 2022 =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)=20
> <zhouyanjie@wanyeetech.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +
> +/* SFC register offsets */
> +#define SFC_REG_GLB						0x0000
> +#define SFC_REG_DEV_CONF				0x0004
> +#define SFC_REG_DEV_STA_EXP				0x0008
> +#define SFC_REG_DEV_STA_RT				0x000c
> +#define SFC_REG_DEV_STA_MSK				0x0010
> +#define SFC_REG_TRAN_CONF(n)			(0x0014 + n * 4)
> +#define SFC_REG_TRAN_CFG0(n)			(0x0014 + n * 4)

You should protect the macro parameter. If you do for instance=20
SFC_REG_TRAN_CONF(x + 1) it would resolve to (0x0014 + x + 1 * 4) which=20
is not what you'd want.

Also - looks like SFC_REG_TRAN_CONF() and SFC_REG_TRAN_CFG0() are the=20
same thing, that's on purpose?

> +#define SFC_REG_TRAN_LEN				0x002c
> +#define SFC_REG_DEV_ADDR(n)				(0x0030 + n * 4)
> +#define SFC_REG_DEV_ADDR_PLUS(n)		(0x0048 + n * 4)
> +#define SFC_REG_MEM_ADDR				0x0060
> +#define SFC_REG_TRIG					0x0064
> +#define SFC_REG_SR						0x0068
> +#define SFC_REG_SCR						0x006c
> +#define SFC_REG_INTC					0x0070
> +#define SFC_REG_FSM						0x0074
> +#define SFC_REG_CGE						0x0078
> +#define SFC_REG_TRAN_CFG1(n)			(0x009c + n * 4)
> +#define SFC_REG_DR						0x1000
> +
> +/* bits within the GLB register */
> +#define GLB_TRAN_DIR_MASK				GENMASK(13, 13)
> +#define GLB_TRAN_DIR_WRITE				0x1
> +#define GLB_TRAN_DIR_READ				0x0

When it's a single bit - just use BIT().

> +#define GLB_THRESHOLD_MASK				GENMASK(12, 7)
> +#define GLB_OP_MODE_MASK				GENMASK(6, 6)

Same here, and I see it a few times below as well.

> +#define GLB_OP_MODE_DMA					0x1
> +#define GLB_OP_MODE_SLAVE				0x0
> +#define GLB_PHASE_NUM_MASK				GENMASK(5, 3)
> +#define GLB_WP_EN						BIT(2)
> +#define GLB_BURST_MD_MASK				GENMASK(1, 0)
> +#define GLB_BURST_MD_INCR32				0x3
> +#define GLB_BURST_MD_INCR16				0x2
> +#define GLB_BURST_MD_INCR8				0x1
> +#define GLB_BURST_MD_INCR4				0x0
> +
> +/* bits within the DEV_CONF register */
> +#define DEV_CONF_SMP_DELAY_MASK			GENMASK(20, 16)
> +#define DEV_CONF_SMP_DELAY_180DEG		0x4
> +#define DEV_CONF_SMP_DELAY_HALF_CYCLE	0x1
> +#define DEV_CONF_CMD_TYPE_MASK			GENMASK(15, 15)
> +#define DEV_CONF_CMD_TYPE_16BIT			0x1
> +#define DEV_CONF_CMD_TYPE_8BIT			0x0
> +#define DEV_CONF_STA_TYPE_MASK			GENMASK(14, 13)
> +#define DEV_CONF_THOLD_MASK				GENMASK(12, 11)
> +#define DEV_CONF_TSETUP_MASK			GENMASK(10, 9)
> +#define DEV_CONF_TSH_MASK				GENMASK(8, 5)
> +#define DEV_CONF_CPHA					BIT(4)
> +#define DEV_CONF_CPOL					BIT(3)
> +#define DEV_CONF_CE_DL					BIT(2)
> +#define DEV_CONF_HOLD_DL				BIT(1)
> +#define DEV_CONF_WP_DL					BIT(0)
> +
> +/* bits within the TRAN_CONF(n) register */
> +#define TRAN_CONF_TRAN_MODE_MASK		GENMASK(31, 29)
> +#define TRAN_CONF_ADDR_WIDTH_MASK		GENMASK(28, 26)
> +#define TRAN_CONF_POLL_EN				BIT(25)
> +#define TRAN_CONF_CMD_EN				BIT(24)
> +#define TRAN_CONF_PHASE_FORMAT_MASK		GENMASK(23, 23)
> +#define TRAN_CONF_DMY_BITS_MASK			GENMASK(22, 17)
> +#define TRAN_CONF_DATA_EN				BIT(16)
> +#define TRAN_CONF_CMD_MASK				GENMASK(15, 0)
> +
> +/* bits within the TRIG register */
> +#define TRIG_FLUSH						BIT(2)
> +#define TRIG_STOP						BIT(1)
> +#define TRIG_START						BIT(0)
> +
> +/* bits within the SR register */
> +#define SR_FIFO_NUM_MASK				GENMASK(22, 16)
> +#define SR_END							BIT(4)
> +#define SR_TRAN_REQ						BIT(3)
> +#define SR_RECE_REQ						BIT(2)
> +#define SR_OVER							BIT(1)
> +#define SR_UNDER						BIT(0)
> +
> +/* bits within the SCR register */
> +#define SCR_CLR_END						BIT(4)
> +#define SCR_CLR_TREQ					BIT(3)
> +#define SCR_CLR_RREQ					BIT(2)
> +#define SCR_CLR_OVER					BIT(1)
> +#define SCR_CLR_UNDER					BIT(0)
> +
> +/* bits within the INTC register */
> +#define INTC_MASK_END					BIT(4)
> +#define INTC_MASK_TREQ					BIT(3)
> +#define INTC_MASK_RREQ					BIT(2)
> +#define INTC_MASK_OVER					BIT(1)
> +#define INTC_MASK_UNDER					BIT(0)
> +
> +/* bits within the TRAN_CFG1(n) register */
> +#define TRAN_CFG1_TRAN_MODE_MASK		GENMASK(7, 4)
> +
> +#define TRAN_MODE_STANDARD				0
> +#define TRAN_MODE_DUAL_DATA				1
> +#define TRAN_MODE_DUAL_IO				2
> +#define TRAN_MODE_DUAL_FULL				3
> +#define TRAN_MODE_QUAD_DATA				5
> +#define TRAN_MODE_QUAD_IO				6
> +#define TRAN_MODE_QUAD_FULL				7
> +#define TRAN_MODE_OCTAL_DATA			9
> +#define TRAN_MODE_OCTAL_IO				10
> +#define TRAN_MODE_OCTAL_FULL			11
> +
> +#define INGENIC_SFC_FIFO_SIZE			(64 * 4)
> +
> +#define INGENIC_SFC_TRANSFER_TIMEOUT	1000

Maybe add the unit name in the macro as well -=20
INGENIC_SFC_TRANSFER_TIMEOUT_MS.

> +
> +enum ingenic_sfc_version {
> +	ID_X1000,
> +	ID_X1600,
> +	ID_X2000,
> +};
> +
> +struct ingenic_soc_info {
> +	enum ingenic_sfc_version version;
> +
> +	unsigned int max_bus_width;
> +
> +	const u32 tran_mode_mask;
> +};
> +
> +struct ingenic_sfc {
> +	const struct ingenic_soc_info *soc_info;
> +
> +	void __iomem *base;
> +	struct device *dev;
> +	struct clk *clk;
> +	int irq;
> +
> +	struct completion completion;
> +};
> +
> +static irqreturn_t ingenic_sfc_irq_handler(int irq, void *data)
> +{
> +	struct ingenic_sfc *sfc =3D data;
> +
> +	writel(0x1f, sfc->base + SFC_REG_INTC);
> +
> +	complete(&sfc->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ingenic_sfc_adjust_op_size(struct spi_mem *mem, struct=20
> spi_mem_op *op)
> +{
> +	uintptr_t addr =3D (uintptr_t)op->data.buf.in;
> +
> +	if (op->data.nbytes > INGENIC_SFC_FIFO_SIZE && !IS_ALIGNED(addr, 4))
> +		op->data.nbytes =3D INGENIC_SFC_FIFO_SIZE;
> +
> +	return 0;
> +}
> +
> +static bool ingenic_sfc_supports_op(struct spi_mem *mem, const=20
> struct spi_mem_op *op)
> +{
> +	struct spi_device *spi =3D mem->spi;
> +	struct ingenic_sfc *sfc =3D spi_controller_get_devdata(spi->master);
> +	uintptr_t addr =3D (uintptr_t)op->data.buf.in;
> +
> +	/* The controller only supports Standard SPI mode, Duall mode, Quad=20
> mode and Octal mode. */

Dual*

> +	if (op->cmd.buswidth > sfc->soc_info->max_bus_width ||
> +		op->addr.buswidth > sfc->soc_info->max_bus_width ||
> +		op->dummy.buswidth > sfc->soc_info->max_bus_width ||
> +		op->data.buswidth > sfc->soc_info->max_bus_width)
> +		return false;
> +
> +	/* Max 32 dummy clock cycles supported */
> +	if (op->dummy.nbytes && op->dummy.nbytes * 8 / op->dummy.buswidth >=20
> 32)
> +		return false;
> +
> +	/* Max rx data length, check controller limits and alignment */
> +	if (op->data.dir =3D=3D SPI_MEM_DATA_IN &&
> +		op->data.nbytes > INGENIC_SFC_FIFO_SIZE && !IS_ALIGNED(addr, 4))

This does the same check than in ingenic_sfc_adjust_op_size(), maybe=20
move it to a new inline function?

> +		return false;
> +
> +	/* Max 6 bytes address width supported */
> +	if (op->addr.nbytes > 6)
> +		return false;
> +
> +	return spi_mem_default_supports_op(mem, op);
> +}
> +
> +static void ingenic_sfc_set_transfer_mode(struct ingenic_sfc *sfc,=20
> const struct spi_mem_op *op)
> +{
> +	int val;
> +
> +	val =3D readl(sfc->base + (sfc->soc_info->version >=3D ID_X1600 ?
> +			SFC_REG_TRAN_CFG1(0) : SFC_REG_TRAN_CONF(0)));

As Krzysztof said - ugh.

Also, instead of having a "version" enum in your soc_info, why not just=20
have a "reg_conf" field that gives you directly the right register?


> +	val &=3D ~sfc->soc_info->tran_mode_mask;
> +	if (op->cmd.buswidth =3D=3D 8)
> +		val |=3D (TRAN_MODE_OCTAL_FULL <<=20
> (ffs(sfc->soc_info->tran_mode_mask) - 1)) &
> +				sfc->soc_info->tran_mode_mask;

Looks like you're really trying to reinvent the wheel.

val |=3D FIELD_PREP(sfc->soc_info->tran_mode_mask, TRAN_MODE_OCTAL_FULL);

using <linux/bitfield.h>.

Also, just define a 'mode' variable and set it in your if/else blocks,=20
that would look much better. Then you can set val |=3D FIELD_PREP(...,=20
mode) at the end.

> +	else if (op->cmd.buswidth =3D=3D 4)
> +		val |=3D (TRAN_MODE_QUAD_FULL << (ffs(sfc->soc_info->tran_mode_mask)=20
> - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->cmd.buswidth =3D=3D 2)
> +		val |=3D (TRAN_MODE_DUAL_FULL << (ffs(sfc->soc_info->tran_mode_mask)=20
> - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->addr.buswidth =3D=3D 8)
> +		val |=3D (TRAN_MODE_OCTAL_IO << (ffs(sfc->soc_info->tran_mode_mask)=20
> - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->addr.buswidth =3D=3D 4)
> +		val |=3D (TRAN_MODE_QUAD_IO << (ffs(sfc->soc_info->tran_mode_mask) -=20
> 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->addr.buswidth =3D=3D 2)
> +		val |=3D (TRAN_MODE_DUAL_IO << (ffs(sfc->soc_info->tran_mode_mask) -=20
> 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->data.buswidth =3D=3D 8)
> +		val |=3D (TRAN_MODE_OCTAL_DATA <<=20
> (ffs(sfc->soc_info->tran_mode_mask) - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->data.buswidth =3D=3D 4)
> +		val |=3D (TRAN_MODE_QUAD_DATA << (ffs(sfc->soc_info->tran_mode_mask)=20
> - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->data.buswidth =3D=3D 2)
> +		val |=3D (TRAN_MODE_DUAL_DATA << (ffs(sfc->soc_info->tran_mode_mask)=20
> - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else
> +		val |=3D (TRAN_MODE_STANDARD << (ffs(sfc->soc_info->tran_mode_mask)=20
> - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	writel(val, sfc->base + (sfc->soc_info->version >=3D ID_X1600 ?
> +			SFC_REG_TRAN_CFG1(0) : SFC_REG_TRAN_CONF(0)));
> +}
> +
> +/*
> + * We only need PIO mode to handle the SPI_MEM_NO_DATA transfers,
> + * and the unaligned accesses in SPI_MEM_DATA_IN transfers.
> + */
> +static void ingenic_sfc_read_rxfifo(struct ingenic_sfc *sfc, u8 *to,=20
> unsigned int len)
> +{
> +	void __iomem *from;
> +
> +	from =3D sfc->base + SFC_REG_DR;
> +
> +	for (; len >=3D 4; len -=3D 4, to +=3D 4) {
> +		u32 val =3D __raw_readl(from);
> +		memcpy(to, &val, 4);

No need to use memcpy for 4 bytes. You can do: put_unaligned(val, (u32=20
*)to);

> +	}
> +
> +	if (len) {
> +		u32 val =3D __raw_readl(from);
> +		memcpy(to, &val, len);

Hmm, I'm not sure that is endian-safe. I would prefer if you copied=20
byte by byte.

> +	}
> +}
> +
> +static int ingenic_sfc_exec_op_pio(struct ingenic_sfc *sfc, const=20
> struct spi_mem_op *op)
> +{
> +	int ret, val;
> +
> +	val =3D readl(sfc->base + SFC_REG_GLB);
> +	u32p_replace_bits(&val, GLB_TRAN_DIR_READ, GLB_TRAN_DIR_MASK);
> +	u32p_replace_bits(&val, GLB_OP_MODE_SLAVE, GLB_OP_MODE_MASK);
> +	writel(val, sfc->base + SFC_REG_GLB);

By the way, have you considered using regmap?

It would give you things like regmap_update_bits() for this kind of=20
things, and regmap_field() to handle your conf register being at a=20
different address across SoCs.

> +
> +	val =3D TRAN_CONF_CMD_EN | op->cmd.opcode;
> +
> +	if (op->addr.nbytes > 0) {
> +		val |=3D FIELD_PREP(TRAN_CONF_ADDR_WIDTH_MASK, op->addr.nbytes);
> +
> +		writel(op->addr.val & 0xffffffff, sfc->base + SFC_REG_DEV_ADDR(0));
> +		writel(op->addr.val >> 32, sfc->base + SFC_REG_DEV_ADDR_PLUS(0));
> +	}
> +
> +	if (op->dummy.nbytes > 0)
> +		val |=3D FIELD_PREP(TRAN_CONF_DMY_BITS_MASK,
> +				op->dummy.nbytes * 8 / op->dummy.buswidth);
> +
> +	if (op->data.nbytes > 0)
> +		val |=3D TRAN_CONF_DATA_EN;
> +
> +	writel(val, sfc->base + SFC_REG_TRAN_CONF(0));
> +	writel(op->data.nbytes, sfc->base + SFC_REG_TRAN_LEN);
> +
> +	ingenic_sfc_set_transfer_mode(sfc, op);
> +
> +	writel(0x1f, sfc->base + SFC_REG_SCR);

Random 0x1f value here, maybe use a macro?

> +	writel(~(INTC_MASK_END | INTC_MASK_RREQ), sfc->base + SFC_REG_INTC);
> +
> +	writel(0, sfc->base + SFC_REG_MEM_ADDR);
> +
> +	writel(TRIG_FLUSH, sfc->base + SFC_REG_TRIG);
> +	writel(TRIG_START, sfc->base + SFC_REG_TRIG);
> +
> +	ret =3D wait_for_completion_timeout(&sfc->completion,
> +			msecs_to_jiffies(INGENIC_SFC_TRANSFER_TIMEOUT));
> +	if (!ret) {
> +		writel(0x1f, sfc->base + SFC_REG_INTC);
> +		writel(0x1f, sfc->base + SFC_REG_SCR);
> +		dev_err(sfc->dev, "line:%d Timeout for ACK from SFC device\n",=20
> __LINE__);
> +		return -ETIMEDOUT;
> +	}
> +
> +	ingenic_sfc_read_rxfifo(sfc, op->data.buf.in, op->data.nbytes);
> +	readl_poll_timeout(sfc->base + SFC_REG_SR, val, val & SR_END, 10,=20
> 0);

Infinite timeout? Is that very wise?

> +
> +	writel(INTC_MASK_END | INTC_MASK_RREQ, sfc->base + SFC_REG_SCR);
> +	writel(TRIG_STOP, sfc->base + SFC_REG_TRIG);
> +
> +	return 0;
> +}
> +
> +static int ingenic_sfc_exec_op_dma(struct ingenic_sfc *sfc, const=20
> struct spi_mem_op *op)
> +{
> +	dma_addr_t addr;
> +	int ret, val;
> +
> +	val =3D readl(sfc->base + SFC_REG_GLB);
> +	u32p_replace_bits(&val, op->data.dir =3D=3D SPI_MEM_DATA_IN ?
> +			GLB_TRAN_DIR_READ : GLB_TRAN_DIR_WRITE, GLB_TRAN_DIR_MASK);
> +	u32p_replace_bits(&val, GLB_OP_MODE_DMA, GLB_OP_MODE_MASK);
> +	writel(val, sfc->base + SFC_REG_GLB);
> +
> +	val =3D TRAN_CONF_CMD_EN | op->cmd.opcode;
> +
> +	if (op->addr.nbytes > 0) {
> +		val |=3D FIELD_PREP(TRAN_CONF_ADDR_WIDTH_MASK, op->addr.nbytes);
> +		writel(op->addr.val & 0xffffffff, sfc->base + SFC_REG_DEV_ADDR(0));
> +		writel(op->addr.val >> 32, sfc->base + SFC_REG_DEV_ADDR_PLUS(0));
> +	}
> +
> +	if (op->dummy.nbytes > 0)
> +		val |=3D FIELD_PREP(TRAN_CONF_DMY_BITS_MASK,
> +				op->dummy.nbytes * 8 / op->dummy.buswidth);
> +
> +	if (op->data.nbytes > 0)
> +		val |=3D TRAN_CONF_DATA_EN;

There's a lot of code duplication here with ingenic_sfc_exec_op_pio().=20
A lot can be factorized.

> +
> +	writel(val, sfc->base + SFC_REG_TRAN_CONF(0));
> +	writel(op->data.nbytes, sfc->base + SFC_REG_TRAN_LEN);
> +
> +	ingenic_sfc_set_transfer_mode(sfc, op);
> +
> +	writel(0x1f, sfc->base + SFC_REG_SCR);
> +	writel(~INTC_MASK_END, sfc->base + SFC_REG_INTC);
> +
> +	switch (op->data.dir) {
> +	case SPI_MEM_DATA_IN:
> +		addr =3D dma_map_single(sfc->dev, op->data.buf.in, op->data.nbytes,=20
> DMA_FROM_DEVICE);
> +		if (dma_mapping_error(sfc->dev, addr)) {
> +			dev_err(sfc->dev, "RX DMA=E3=80=80memory not mapped\n");
> +			return -ENOMEM;
> +		}
> +
> +		writel(addr, sfc->base + SFC_REG_MEM_ADDR);
> +		break;
> +
> +	case SPI_MEM_DATA_OUT:
> +		addr =3D dma_map_single(sfc->dev, (void *)op->data.buf.out,
> +				op->data.nbytes, DMA_TO_DEVICE);
> +		if (dma_mapping_error(sfc->dev, addr)) {
> +			dev_err(sfc->dev, "TX DMA=E3=80=80memory not mapped\n");
> +			return -ENOMEM;
> +		}
> +
> +		writel(addr, sfc->base + SFC_REG_MEM_ADDR);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	writel(TRIG_START, sfc->base + SFC_REG_TRIG);
> +
> +	ret =3D wait_for_completion_timeout(&sfc->completion,
> +			msecs_to_jiffies(INGENIC_SFC_TRANSFER_TIMEOUT));
> +	if (!ret) {
> +		writel(0x1f, sfc->base + SFC_REG_INTC);
> +		writel(0x1f, sfc->base + SFC_REG_SCR);
> +		dev_err(sfc->dev, "line:%d Timeout for ACK from SFC device\n",=20
> __LINE__);
> +		return -ETIMEDOUT;
> +	}
> +
> +	dma_unmap_single(sfc->dev, addr, op->data.nbytes,
> +			op->data.dir =3D=3D SPI_MEM_DATA_IN ? DMA_FROM_DEVICE :=20
> DMA_TO_DEVICE);

Use a small inline function for that too. My personal rule is that ?:=20
is fine if the line fits in 80 characters, but if you have to break,=20
then you really need to move it somewhere else.

> +
> +	writel(INTC_MASK_END, sfc->base + SFC_REG_SCR);
> +	writel(TRIG_STOP, sfc->base + SFC_REG_TRIG);
> +
> +	return 0;
> +}
> +
> +static int ingenic_sfc_exec_op(struct spi_mem *mem, const struct=20
> spi_mem_op *op)
> +{
> +	struct spi_device *spi =3D mem->spi;
> +	struct ingenic_sfc *sfc =3D spi_controller_get_devdata(spi->master);
> +	uintptr_t addr =3D (uintptr_t)op->data.buf.in;
> +
> +	init_completion(&sfc->completion);
> +
> +	switch (op->data.dir) {
> +	case SPI_MEM_DATA_IN:
> +		if (sfc->soc_info->version >=3D ID_X1600 || IS_ALIGNED(addr, 4))
> +			break;
> +
> +		fallthrough;
> +
> +	case SPI_MEM_NO_DATA:
> +		return ingenic_sfc_exec_op_pio(sfc, op);
> +
> +	default:
> +		break;
> +	}
> +
> +	return ingenic_sfc_exec_op_dma(sfc, op);
> +}
> +
> +static int ingenic_sfc_poll_status(struct spi_mem *mem, const struct=20
> spi_mem_op *op,
> +			u16 mask, u16 match, unsigned long initial_delay_us,
> +			unsigned long polling_delay_us, unsigned long timeout_ms)
> +{
> +	struct spi_device *spi =3D mem->spi;
> +	struct ingenic_sfc *sfc =3D spi_controller_get_devdata(spi->master);
> +	int ret, val;
> +
> +	init_completion(&sfc->completion);
> +
> +	val =3D readl(sfc->base + SFC_REG_GLB);
> +	u32p_replace_bits(&val, GLB_TRAN_DIR_READ, GLB_TRAN_DIR_MASK);
> +	u32p_replace_bits(&val, GLB_OP_MODE_SLAVE, GLB_OP_MODE_MASK);
> +	writel(val, sfc->base + SFC_REG_GLB);
> +
> +	writel(match, sfc->base + SFC_REG_DEV_STA_EXP);
> +	writel(mask, sfc->base + SFC_REG_DEV_STA_MSK);
> +
> +	val =3D TRAN_CONF_POLL_EN | TRAN_CONF_CMD_EN | op->cmd.opcode;
> +
> +	if (op->addr.nbytes > 0) {
> +		val |=3D FIELD_PREP(TRAN_CONF_ADDR_WIDTH_MASK, op->addr.nbytes);
> +
> +		writel(op->addr.val & 0xffffffff, sfc->base + SFC_REG_DEV_ADDR(0));
> +		writel(op->addr.val >> 32, sfc->base + SFC_REG_DEV_ADDR_PLUS(0));
> +	}
> +
> +	if (op->dummy.nbytes > 0)
> +		val |=3D FIELD_PREP(TRAN_CONF_DMY_BITS_MASK,
> +				op->dummy.nbytes * 8 / op->dummy.buswidth);
> +
> +	if (op->data.nbytes > 0)
> +		val |=3D TRAN_CONF_DATA_EN;
> +
> +	writel(val, sfc->base + SFC_REG_TRAN_CONF(0));
> +	writel(op->data.nbytes, sfc->base + SFC_REG_TRAN_LEN);
> +
> +	ingenic_sfc_set_transfer_mode(sfc, op);
> +
> +	writel(0x1f, sfc->base + SFC_REG_SCR);
> +	writel(~INTC_MASK_END, sfc->base + SFC_REG_INTC);
> +
> +	writel(0, sfc->base + SFC_REG_MEM_ADDR);
> +
> +	writel(TRIG_START, sfc->base + SFC_REG_TRIG);
> +
> +	ret =3D wait_for_completion_timeout(&sfc->completion,
> +			msecs_to_jiffies(INGENIC_SFC_TRANSFER_TIMEOUT));
> +	if (!ret) {
> +		writel(0x1f, sfc->base + SFC_REG_INTC);
> +		writel(0x1f, sfc->base + SFC_REG_SCR);
> +		dev_err(sfc->dev, "line:%d Timeout for ACK from SFC device\n",=20
> __LINE__);
> +		return -ETIMEDOUT;
> +	}
> +
> +	writel(SCR_CLR_END, sfc->base + SFC_REG_SCR);
> +	writel(TRIG_STOP, sfc->base + SFC_REG_TRIG);
> +
> +	return 0;
> +}
> +
> +static const struct spi_controller_mem_ops ingenic_sfc_mem_ops =3D {
> +	.adjust_op_size =3D ingenic_sfc_adjust_op_size,
> +	.supports_op =3D ingenic_sfc_supports_op,
> +	.exec_op =3D ingenic_sfc_exec_op,
> +	.poll_status =3D ingenic_sfc_poll_status,
> +};
> +
> +static int ingenic_sfc_setup(struct spi_device *spi)
> +{
> +	struct ingenic_sfc *sfc =3D spi_controller_get_devdata(spi->master);
> +	unsigned long rate;
> +	int ret, val;
> +
> +	if (!spi->max_speed_hz)
> +		return -EINVAL;

Maybe set a sane default?

> +
> +	ret =3D clk_set_rate(sfc->clk, spi->max_speed_hz * 2);
> +	if (ret)
> +		return -EINVAL;
> +
> +	writel(TRIG_STOP, sfc->base + SFC_REG_TRIG);
> +	writel(0, sfc->base + SFC_REG_DEV_CONF);
> +	writel(0, sfc->base + SFC_REG_CGE);
> +
> +	val =3D readl(sfc->base + SFC_REG_GLB);
> +	u32p_replace_bits(&val, 64 - 1, GLB_THRESHOLD_MASK);
> +	writel(val, sfc->base + SFC_REG_GLB);
> +
> +	val =3D readl(sfc->base + SFC_REG_DEV_CONF);
> +
> +	/* cpha bit:0 , cpol bit:0 */
> +	val &=3D ~(DEV_CONF_CPHA | DEV_CONF_CPOL);
> +	val |=3D spi->mode & SPI_CPHA ? DEV_CONF_CPHA : 0;
> +	val |=3D spi->mode & SPI_CPOL ? DEV_CONF_CPOL : 0;
> +
> +	/* ce_dl bit:1, hold bit:1, wp bit:1 */
> +	val |=3D (DEV_CONF_CE_DL | DEV_CONF_HOLD_DL | DEV_CONF_WP_DL);
> +
> +	writel(val, sfc->base + SFC_REG_DEV_CONF);
> +
> +	val =3D readl(sfc->base + SFC_REG_GLB);
> +	u32p_replace_bits(&val, GLB_OP_MODE_SLAVE, GLB_OP_MODE_MASK);
> +	writel(val, sfc->base + SFC_REG_GLB);
> +
> +	rate =3D clk_get_rate(sfc->clk);

I'd suggest using clk_round_rate() before clk_set_rate() because then=20
you know what frequency it's going to be, and you don't have to call=20
clk_get_rate() afterwards.

Cheers,
-Paul

> +	val =3D readl(sfc->base + SFC_REG_DEV_CONF);
> +	if (sfc->soc_info->version >=3D ID_X1600 && rate >=3D 200000000)
> +		u32p_replace_bits(&val, DEV_CONF_SMP_DELAY_180DEG,=20
> DEV_CONF_SMP_DELAY_MASK);
> +	else if (sfc->soc_info->version =3D=3D ID_X1000 && rate >=3D 100000000)
> +		u32p_replace_bits(&val, DEV_CONF_SMP_DELAY_HALF_CYCLE,=20
> DEV_CONF_SMP_DELAY_MASK);
> +	writel(val, sfc->base + SFC_REG_DEV_CONF);
> +
> +	return 0;
> +}
> +
> +static int ingenic_sfc_probe(struct platform_device *pdev)
> +{
> +	struct ingenic_sfc *sfc;
> +	struct spi_controller *ctlr;
> +	int ret;
> +
> +	ctlr =3D spi_alloc_master(&pdev->dev, sizeof(*sfc));
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	sfc =3D spi_controller_get_devdata(ctlr);
> +
> +	sfc->soc_info =3D of_device_get_match_data(&pdev->dev);
> +	if (!sfc->soc_info) {
> +		dev_err(&pdev->dev, "No of match data provided\n");
> +		ret =3D -ENODEV;
> +		goto err_put_master;
> +	}
> +
> +	sfc->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sfc->base)) {
> +		ret =3D PTR_ERR(sfc->base);
> +		goto err_put_master;
> +	}
> +
> +	sfc->clk =3D devm_clk_get(&pdev->dev, "sfc");
> +	if (IS_ERR(sfc->clk)) {
> +		ret =3D IS_ERR(sfc->clk);
> +		goto err_put_master;
> +	}
> +
> +	ret =3D clk_prepare_enable(sfc->clk);
> +	if (ret)
> +		goto err_put_master;
> +
> +	sfc->irq =3D platform_get_irq(pdev, 0);
> +	if (sfc->irq < 0) {
> +		ret =3D sfc->irq;
> +		goto err_put_master;
> +	}
> +
> +	sfc->dev =3D &pdev->dev;
> +
> +	platform_set_drvdata(pdev, sfc);
> +
> +	ret =3D devm_request_irq(&pdev->dev, sfc->irq,=20
> ingenic_sfc_irq_handler, 0,
> +			dev_name(&pdev->dev), sfc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request irq%d, ret =3D %d\n",=20
> sfc->irq, ret);
> +		goto err_put_master;
> +	}
> +
> +	ctlr->bus_num =3D -1;
> +	ctlr->num_chipselect =3D 1;
> +	ctlr->mem_ops =3D &ingenic_sfc_mem_ops;
> +	ctlr->dev.of_node =3D pdev->dev.of_node;
> +	ctlr->setup =3D ingenic_sfc_setup;
> +	ctlr->mode_bits =3D SPI_CPHA | SPI_CPOL |
> +			SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
> +	if (sfc->soc_info->version >=3D ID_X2000)
> +		ctlr->mode_bits |=3D SPI_RX_OCTAL | SPI_TX_OCTAL;
> +
> +	ret =3D devm_spi_register_controller(&pdev->dev, ctlr);
> +	if (ret)
> +		goto err_put_master;
> +
> +	return 0;
> +
> +err_put_master:
> +	spi_master_put(ctlr);
> +
> +	return ret;
> +}
> +
> +static const struct ingenic_soc_info x1000_soc_info =3D {
> +	.version =3D ID_X1000,
> +
> +	.max_bus_width =3D 4,
> +
> +	.tran_mode_mask =3D TRAN_CONF_TRAN_MODE_MASK,
> +};
> +
> +static const struct ingenic_soc_info x1600_soc_info =3D {
> +	.version =3D ID_X1600,
> +
> +	.max_bus_width =3D 4,
> +
> +	.tran_mode_mask =3D TRAN_CONF_TRAN_MODE_MASK,
> +};
> +
> +static const struct ingenic_soc_info x2000_soc_info =3D {
> +	.version =3D ID_X2000,
> +
> +	.max_bus_width =3D 8,
> +
> +	.tran_mode_mask =3D TRAN_CFG1_TRAN_MODE_MASK,
> +};
> +
> +static const struct of_device_id ingenic_sfc_of_matches[] =3D {
> +	{ .compatible =3D "ingenic,x1000-sfc", .data =3D &x1000_soc_info },
> +	{ .compatible =3D "ingenic,x1600-sfc", .data =3D &x1600_soc_info },
> +	{ .compatible =3D "ingenic,x2000-sfc", .data =3D &x2000_soc_info },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ingenic_sfc_of_matches);
> +
> +static struct platform_driver ingenic_sfc_driver =3D {
> +	.driver =3D {
> +		.name =3D "ingenic-sfc",
> +		.of_match_table =3D ingenic_sfc_of_matches,
> +	},
> +	.probe =3D ingenic_sfc_probe,
> +};
> +module_platform_driver(ingenic_sfc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wan=
yeetech.com>");
> +MODULE_DESCRIPTION("Ingenic SoCs SPI Flash Controller Driver");
> --
> 2.7.4
>=20


