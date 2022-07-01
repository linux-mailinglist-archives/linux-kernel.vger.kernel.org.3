Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18834562DA2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiGAITY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiGAITW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:19:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63FB639D;
        Fri,  1 Jul 2022 01:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52A25B82EEF;
        Fri,  1 Jul 2022 08:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D15AC341C6;
        Fri,  1 Jul 2022 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656663557;
        bh=iofprNZZbcI5St/5SQyQ0vF2ht0PL5Tzg5WnoHSo8Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=166y6zHSIY0qwuF/fmsogcBj275v8Wuwv3LJxyEi2IFJvATncJ+5gMTcUAIwKQpdK
         zQoTw8rBZ1x9r+RQEXWFjs8cxp+BO3kx5vZsGmxEPzAgo+5Q+8vnCM07DTXUt0LZda
         kSdna1cuPExLwJi6rFw81luaB5USmo5UlS+XoS9c=
Date:   Fri, 1 Jul 2022 10:19:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, git@amd.com, git@xilinx.com
Subject: Re: [PATCH 2/4] drivers: misc: Add Support for TMR Manager
Message-ID: <Yr6uArBFOIMFpLUt@kroah.com>
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
 <20220628054338.1631516-3-appana.durga.rao@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628054338.1631516-3-appana.durga.rao@xilinx.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:13:36AM +0530, Appana Durga Kedareswara rao wrote:
> The Triple Modular Redundancy(TMR) Manager is responsible for handling
> the TMR subsystem state, including fault detection and error recovery
> provides soft error detection, correction and recovery features.
> 
> This commit adds support for fault detection feature via
> sysfs interface.
> 
> Usage:
> To know the hardware status:
> cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/status
> To know the break handler count(Error count):
> cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
> 
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
>  .../testing/sysfs-driver-xilinx-tmr-manager   |  18 ++
>  MAINTAINERS                                   |   7 +
>  drivers/misc/Kconfig                          |  10 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/xilinx_tmr_manager.c             | 288 ++++++++++++++++++
>  5 files changed, 324 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>  create mode 100644 drivers/misc/xilinx_tmr_manager.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
> new file mode 100644
> index 000000000000..c2f615126201
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
> @@ -0,0 +1,18 @@
> +What:		/sys/devices/platform/amba_pl/<dev>/status
> +Date:		June 2022
> +Contact:	appana.durga.rao@xilinx.com
> +Description:	This control file provides the status of the tmr manager
> +		useful for getting the status of fault.
> +		This file cannot be written.

Examples of what the data in this file will be?

> +
> +What:		/sys/devices/platform/amba_pl/<dev>/errcnt
> +Date:		June 2022
> +Contact:	appana.durga.rao@xilinx.com
> +Description:	This control file provides the fault detection count.
> +		This file cannot be written.

Again, example output?



> +
> +What:		/sys/devices/platform/amba_pl/<dev>/dis_block_break
> +Date:		June 2022
> +Contact:	appana.durga.rao@xilinx.com
> +Description:	This control file enables the break signal.
> +		This file is write only.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6cc825857722..3d29109788ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12962,6 +12962,13 @@ W:	http://www.monstr.eu/fdt/
>  T:	git git://git.monstr.eu/linux-2.6-microblaze.git
>  F:	arch/microblaze/
>  
> +MICROBLAZE TMR MANAGER
> +M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> +S:	Supported
> +F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
> +F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
> +F:	drivers/misc/xilinx_tmr_manager.c
> +
>  MICROCHIP AT91 DMA DRIVERS
>  M:	Ludovic Desroches <ludovic.desroches@microchip.com>
>  M:	Tudor Ambarus <tudor.ambarus@microchip.com>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41d2bb0ae23a..555ae2e33b91 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -483,6 +483,16 @@ config OPEN_DICE
>  
>  	  If unsure, say N.
>  
> +config TMR_MANAGER
> +	bool "Select TMR Manager"
> +	depends on MICROBLAZE && MB_MANAGER
> +	help
> +	  This option enables the driver developed for TMR Manager. The Triple
> +	  Modular Redundancy(TMR) manager provides support for fault detection
> +	  via sysfs interface.
> +
> +	  Say N here unless you know what you are doing.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 70e800e9127f..28b9803f909b 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
>  obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> +obj-$(CONFIG_TMR_MANAGER)	+= xilinx_tmr_manager.o
> diff --git a/drivers/misc/xilinx_tmr_manager.c b/drivers/misc/xilinx_tmr_manager.c
> new file mode 100644
> index 000000000000..5a4562e4a9d4
> --- /dev/null
> +++ b/drivers/misc/xilinx_tmr_manager.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx TMR Subsystem.
> + *
> + * Copyright (C) 2022 Xilinx, Inc.
> + *
> + * Description:
> + * This driver is developed for TMR Manager,The Triple Modular Redundancy(TMR)
> + * Manager is responsible for handling the TMR subsystem state, including
> + * fault detection and error recovery. The core is triplicated in each of
> + * the sub-blocks in the TMR subsystem, and provides majority voting of
> + * its internal state provides soft error detection, correction and
> + * recovery. Error detection feature is provided through sysfs
> + * entries which allow the user to observer the TMR microblaze
> + * status.
> + */
> +
> +#include <asm/xilinx_mb_manager.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +
> +/* TMR Manager Register offsets */
> +#define XTMR_MANAGER_CR_OFFSET		0x0
> +#define XTMR_MANAGER_FFR_OFFSET		0x4
> +#define XTMR_MANAGER_CMR0_OFFSET	0x8
> +#define XTMR_MANAGER_CMR1_OFFSET	0xC
> +#define XTMR_MANAGER_BDIR_OFFSET	0x10
> +#define XTMR_MANAGER_SEMIMR_OFFSET	0x1C
> +
> +/* Register Bitmasks/shifts */
> +#define XTMR_MANAGER_CR_MAGIC1_MASK	GENMASK(7, 0)
> +#define XTMR_MANAGER_CR_MAGIC2_MASK	GENMASK(15, 8)
> +#define XTMR_MANAGER_CR_RIR_MASK	BIT(16)
> +#define XTMR_MANAGER_FFR_LM12_MASK	BIT(0)
> +#define XTMR_MANAGER_FFR_LM13_MASK	BIT(1)
> +#define XTMR_MANAGER_FFR_LM23_MASK	BIT(2)
> +
> +#define XTMR_MANAGER_CR_MAGIC2_SHIFT	4
> +#define XTMR_MANAGER_CR_RIR_SHIFT	16
> +#define XTMR_MANAGER_CR_BB_SHIFT	18
> +
> +#define XTMR_MANAGER_MAGIC1_MAX_VAL	255
> +
> +/**
> + * struct xtmr_manager_dev - Driver data for TMR Manager
> + * @regs: device physical base address
> + * @dev: pointer to device struct
> + * @cr_val: control register value
> + * @magic1: Magic 1 hardware configuration value
> + * @err_cnt: error statistics count
> + * @phys_baseaddr: Physical base address
> + */
> +struct xtmr_manager_dev {
> +	void __iomem *regs;
> +	struct device *dev;

Is this the parent of this device?  Why not make a new device?  The
interaction here isn't well defined, what controls the lifespan of this
structure?

> +	u32 cr_val;
> +	u32 magic1;
> +	u32 err_cnt;
> +	uintptr_t phys_baseaddr;

This should be resource_size_t, not uintptr_t, right?


> +};
> +
> +/* IO accessors */
> +static inline void xtmr_manager_write(struct xtmr_manager_dev *xtmr_manager,
> +				      u32 addr, u32 value)
> +{
> +	iowrite32(value, xtmr_manager->regs + addr);
> +}
> +
> +static inline u32 xtmr_manager_read(struct xtmr_manager_dev *xtmr_manager,
> +				    u32 addr)
> +{
> +	return ioread32(xtmr_manager->regs + addr);
> +}
> +
> +/**
> + * xtmr_manager_unblock_break - unblocks the break signal
> + * @xtmr_manager: Pointer to xtmr_manager_dev structure
> + */
> +static void xtmr_manager_unblock_break(struct xtmr_manager_dev *xtmr_manager)
> +{
> +	xtmr_manager->cr_val &= ~(1 << XTMR_MANAGER_CR_BB_SHIFT);
> +	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_CR_OFFSET,
> +			   xtmr_manager->cr_val);
> +}
> +
> +/**
> + * xmb_manager_reset_handler - clears the ffr register contents
> + * @priv: Private pointer
> + */
> +static void xmb_manager_reset_handler(void *priv)
> +{
> +	struct xtmr_manager_dev *xtmr_manager = (struct xtmr_manager_dev *)priv;
> +	/* Clear the FFR Register contents as a part of recovery process. */
> +	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_FFR_OFFSET, 0);

Did you run checkpatch on this code?  Please do so.

> +}
> +
> +/**

No need for kernel doc formatting for static functions, right?

> + * xmb_manager_update_errcnt - update the error inject count
> + * @priv: Private pointer
> + */
> +static void xmb_manager_update_errcnt(void *priv)

Use a real pointer, not a void one please.  We want type safe functions.

> +{
> +	struct xtmr_manager_dev *xtmr_manager = (struct xtmr_manager_dev *)priv;

And even if you did have a real pointer, you never need to cast from a
void *.

> +
> +	xtmr_manager->err_cnt++;
> +}
> +
> +static ssize_t errcnt_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%x\n", xtmr_manager->err_cnt);

sysfs_emit() here and everywhere please.

> +}
> +static DEVICE_ATTR_RO(errcnt);
> +
> +static ssize_t status_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
> +	size_t ffr;
> +	int len = 0;
> +
> +	ffr = xtmr_manager_read(xtmr_manager, XTMR_MANAGER_FFR_OFFSET);
> +	if ((ffr & XTMR_MANAGER_FFR_LM12_MASK) == XTMR_MANAGER_FFR_LM12_MASK) {
> +		len += sprintf(buf + len,
> +			       "Lockstep mismatch between processor 1 and 2\n");
> +	}
> +
> +	if ((ffr & XTMR_MANAGER_FFR_LM13_MASK) == XTMR_MANAGER_FFR_LM13_MASK) {
> +		len += sprintf(buf + len,
> +			       "Lockstep mismatch between processor 1 and 3\n");
> +	}
> +
> +	if ((ffr & XTMR_MANAGER_FFR_LM23_MASK) == XTMR_MANAGER_FFR_LM23_MASK) {
> +		len += sprintf(buf + len,
> +			       "Lockstep mismatch between processor 2 and 3\n");

That feels like a lot more than "one bit of information", who is going
to parse this and do something with this information?


> +	}
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RO(status);
> +
> +static ssize_t dis_block_break_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t size)
> +{
> +	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
> +	int ret;
> +	long value;
> +
> +	ret = kstrtoul(buf, 16, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value > 1)
> +		return -EINVAL;
> +
> +	xtmr_manager_unblock_break(xtmr_manager);

No error checking?

> +	return size;
> +}
> +static DEVICE_ATTR_WO(dis_block_break);
> +
> +static struct attribute *xtmr_manager_attrs[] = {
> +	&dev_attr_dis_block_break.attr,
> +	&dev_attr_status.attr,
> +	&dev_attr_errcnt.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(xtmr_manager);
> +
> +static void xtmr_manager_init(struct xtmr_manager_dev *xtmr_manager)
> +{
> +	/* Clear the SEM interrupt mask register to disable the interrupt */
> +	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_SEMIMR_OFFSET, 0);
> +
> +	/* Allow recovery reset by default */
> +	xtmr_manager->cr_val = (1 << XTMR_MANAGER_CR_RIR_SHIFT) |
> +				xtmr_manager->magic1;
> +	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_CR_OFFSET,
> +			   xtmr_manager->cr_val);
> +	/*
> +	 * Configure Break Delay Initialization Register to zero so that
> +	 * break occurs immediately
> +	 */
> +	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_BDIR_OFFSET, 0);
> +
> +	/*
> +	 * To come out of break handler need to block the break signal
> +	 * in the tmr manager, update the xtmr_manager cr_val for the same
> +	 */
> +	xtmr_manager->cr_val |= (1 << XTMR_MANAGER_CR_BB_SHIFT);
> +
> +	/*
> +	 * When the break vector gets asserted because of error injection,
> +	 * the break signal must be blocked before exiting from the
> +	 * break handler, Below api updates the TMR manager address and
> +	 * control register and error counter callback arguments,
> +	 * which will be used by the break handler to block the
> +	 * break and call the callback function.
> +	 */
> +	xmb_manager_register(xtmr_manager->phys_baseaddr, xtmr_manager->cr_val,
> +			     xmb_manager_update_errcnt,
> +			     xtmr_manager, xmb_manager_reset_handler);

No error handling?

> +}
> +
> +/**
> + * xtmr_manager_probe - Driver probe function
> + * @pdev: Pointer to the platform_device structure
> + *
> + * This is the driver probe routine. It does all the memory
> + * allocation and creates sysfs entries for the device.
> + *
> + * Return: 0 on success and failure value on error
> + */
> +static int xtmr_manager_probe(struct platform_device *pdev)
> +{
> +	struct xtmr_manager_dev *xtmr_manager;
> +	struct resource *res;
> +	int err;
> +
> +	xtmr_manager = devm_kzalloc(&pdev->dev, sizeof(*xtmr_manager),
> +				    GFP_KERNEL);
> +	if (!xtmr_manager)
> +		return -ENOMEM;
> +
> +	xtmr_manager->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	xtmr_manager->regs =  devm_ioremap_resource(xtmr_manager->dev, res);
> +	if (IS_ERR(xtmr_manager->regs))
> +		return PTR_ERR(xtmr_manager->regs);
> +
> +	xtmr_manager->phys_baseaddr = res->start;
> +
> +	err = of_property_read_u32(pdev->dev.of_node, "xlnx,magic1",
> +				   &xtmr_manager->magic1);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "unable to read xlnx,magic1 property");
> +		return err;
> +	} else if (xtmr_manager->magic1 > XTMR_MANAGER_MAGIC1_MAX_VAL) {

No need for else.

> +		dev_err(&pdev->dev, "invalid xlnx,magic1 property value");
> +		return err;

but err is not an error value here, right?

> +	}
> +
> +	/* Initialize TMR Manager */
> +	xtmr_manager_init(xtmr_manager);
> +
> +	err = sysfs_create_groups(&xtmr_manager->dev->kobj,
> +				  xtmr_manager_groups);

You just raced with userspace and lost.  NEVER deal with raw kobjects,
that's a huge sign that you are doing something wrong in a driver.

Please use the proper default groups pointer for your driver to do this
correctly so that the driver core will handle this for you.

> +	if (err < 0) {
> +		dev_err(&pdev->dev, "unable to create sysfs entries\n");
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, xtmr_manager);
> +
> +	return 0;
> +}
> +
> +static int xtmr_manager_remove(struct platform_device *pdev)
> +{
> +	sysfs_remove_groups(&pdev->dev.kobj, xtmr_manager_groups);

Again, never touch a kobject in a driver.

thanks,

greg k-h
