Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857E8584113
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiG1O1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiG1O1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:27:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C35054661;
        Thu, 28 Jul 2022 07:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBE8BB82325;
        Thu, 28 Jul 2022 14:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16C8C433D7;
        Thu, 28 Jul 2022 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659018426;
        bh=j06HbzUSgAZ3/Eqn9s1zrMihKBDhnjBeQ4BSOCaTRqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+ixU+0k+5qRXW9L1CKCzZrp/gyPMMghsB+VNXkVG8QFGnoQu92902JrmT7+gABp+
         JJLNQ1Y1D4syIvFfmfyCeB0rqdbBbZFzB3LF5+Dc9qrnpDwPbCPesyU6uUnUVDnSRx
         Q+0jiNrMV7Qr4UAlBotOaCDsmtjh8phMkJwwZydY=
Date:   Thu, 28 Jul 2022 16:27:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, appanad@amd.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com, git@xilinx.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: Re: [PATCH v2 2/4] drivers: misc: Add Support for TMR Manager
Message-ID: <YuKctxTbVnb3lUF3@kroah.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
 <20220720060016.1646317-3-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720060016.1646317-3-appana.durga.kedareswara.rao@amd.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 11:30:14AM +0530, Appana Durga Kedareswara rao wrote:
> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> 
> Triple Modular Redundancy(TMR) subsystem contains three microblaze cores,
> subsystem is fault-tolerant and continues to operate nominally after
> encountering an error. Together with the capability to detect and recover
> from errors, the implementation ensures the reliability of the entire
> subsystem.  TMR Manager is responsible for performing recovery of the
> subsystem detects the fault via a break signal it invokes microblaze
> software break handler which calls the tmr manager driver api to
> update the error count and status, added support for fault detection
> feature via sysfs interface.
> 
> Usage:
> To know the hardware status:
> cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/status
> To know the break handler count(Error count):
> cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
> 
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
> Changes for v2:
> --> Added Examples for sysfs entries
> --> Removed uneeded struct dev from the driver private structure
> --> Fixed style issues (Used resource_size_t instead of uintptr_t)
> --> Updated driver to use sysfs_emit() API instead of sprintf() API
> --> Added error checks wherever applicable.
> --> Fixed sysfs registration.
>  .../testing/sysfs-driver-xilinx-tmr-manager   |  27 ++
>  MAINTAINERS                                   |   7 +
>  drivers/misc/Kconfig                          |  10 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/xilinx_tmr_manager.c             | 253 ++++++++++++++++++
>  5 files changed, 298 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>  create mode 100644 drivers/misc/xilinx_tmr_manager.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
> new file mode 100644
> index 000000000000..fc5fe7e22b09
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
> @@ -0,0 +1,27 @@
> +What:		/sys/devices/platform/amba_pl/<dev>/status
> +Date:		June 2022
> +Contact:	appana.durga.rao@xilinx.com
> +Description:	This control file provides the status of the tmr manager
> +		useful for getting the status of fault.
> +		This file cannot be written.
> +		Example:
> +		# cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/status
> +		  Lockstep mismatch between processor 1 and 2
> +		  Lockstep mismatch between processor 2 and 3

Why a whole long string?

And this should only be 1 line, not multiple lines.  If it's multiple
lines, this is NOT ok for a sysfs file.

> +
> +What:		/sys/devices/platform/amba_pl/<dev>/errcnt
> +Date:		June 2022
> +Contact:	appana.durga.rao@xilinx.com
> +Description:	This control file provides the fault detection count.
> +		This file cannot be written.
> +		Example:
> +		# cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
> +		  1
> +
> +What:		/sys/devices/platform/amba_pl/<dev>/dis_block_break
> +Date:		June 2022
> +Contact:	appana.durga.rao@xilinx.com
> +Description:	This control file enables the break signal.
> +		This file is write only.
> +		Example:
> +		# echo 1 > /sys/devices/platform/amba_pl/44a10000.tmr_manager/dis_block_break
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 651616ed8ae2..732fd9ae7d9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13080,6 +13080,13 @@ W:	http://www.monstr.eu/fdt/
>  T:	git git://git.monstr.eu/linux-2.6-microblaze.git
>  F:	arch/microblaze/
>  
> +MICROBLAZE TMR MANAGER
> +M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
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

Not a module?

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
> index 000000000000..dbeca18c409f
> --- /dev/null
> +++ b/drivers/misc/xilinx_tmr_manager.c
> @@ -0,0 +1,253 @@
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
> + * @cr_val: control register value
> + * @magic1: Magic 1 hardware configuration value
> + * @err_cnt: error statistics count
> + * @phys_baseaddr: Physical base address
> + */
> +struct xtmr_manager_dev {
> +	void __iomem *regs;
> +	u32 cr_val;
> +	u32 magic1;
> +	u32 err_cnt;
> +	resource_size_t phys_baseaddr;
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
> +static void xmb_manager_reset_handler(struct xtmr_manager_dev *xtmr_manager)
> +{
> +	/* Clear the FFR Register contents as a part of recovery process. */
> +	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_FFR_OFFSET, 0);
> +}
> +
> +static void xmb_manager_update_errcnt(struct xtmr_manager_dev *xtmr_manager)
> +{
> +	xtmr_manager->err_cnt++;
> +}
> +
> +static ssize_t errcnt_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%x\n", xtmr_manager->err_cnt);
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
> +		len += sysfs_emit_at(buf, len, "Lockstep mismatch between ");
> +		len += sysfs_emit_at(buf, len, "processor 1 and 2\n");

You can write a full string all at once, no need to call this twice.

> +	}
> +
> +	if ((ffr & XTMR_MANAGER_FFR_LM13_MASK) == XTMR_MANAGER_FFR_LM13_MASK) {
> +		len += sysfs_emit_at(buf, len, "Lockstep mismatch between ");
> +		len += sysfs_emit_at(buf, len, "processor 1 and 3\n");
> +	}
> +
> +	if ((ffr & XTMR_MANAGER_FFR_LM23_MASK) == XTMR_MANAGER_FFR_LM23_MASK) {
> +		len += sysfs_emit_at(buf, len, "Lockstep mismatch between ");
> +		len += sysfs_emit_at(buf, len, "processor 2 and 3\n");
> +	}

As said above, multiple lines is not ok, you need to fix up this api.

Perhaps 3 files, one for eacy type of mismatch and a simple 0/1 value
returned in them?


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

Why is 1 magic?

And we have a sysfs function to read a 0/1/Y/N/y/n value, please use
that.

thanks,

greg k-h
