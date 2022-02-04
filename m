Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940004A9BFB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359725AbiBDPcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbiBDPcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:32:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CDBC061714;
        Fri,  4 Feb 2022 07:32:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A36E8B837C5;
        Fri,  4 Feb 2022 15:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9851CC004E1;
        Fri,  4 Feb 2022 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643988723;
        bh=BaSOpd9SEh24KIMsyl1M/eH4rDF0SNVx0057QVu+P4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yFQnEd+8tq/UHmoa4dMvdDo5vQX1YtiIUbiKGZ18cqUXq7DE/8gmBarFfDSlsGNm7
         2PRGqC8GXqu7S/+U/HrMZwOqaCB3BIGvK39EkXZSOEXm5ezj3pXZcG8GSKXPMw7toc
         NgWDS/KVxnUgcX1s/y2LKGIQE6/wqcYiAXFriEDs=
Date:   Fri, 4 Feb 2022 16:32:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     robh+dt@kerenl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, wells.lu@sunplus.com,
        tony.huang@sunplus.com
Subject: Re: [PATCH v7 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <Yf1G8HPfRf7aUgZz@kroah.com>
References: <cover.1641794532.git.tonyhuang.sunplus@gmail.com>
 <ab7c7da8210aa1ab2d50276b231b33d6510b5185.1641794532.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7c7da8210aa1ab2d50276b231b33d6510b5185.1641794532.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 02:37:54PM +0800, Tony Huang wrote:
> IOP(8051) embedded inside SP7021 which is used as
> Processor for I/O control, monitor RTC interrupt and
> cooperation with CPU & PMC in power management purpose.
> The IOP core is DQ8051, so also named IOP8051,
> it supports dedicated JTAG debug pins which share with SP7021.
> In standby mode operation, the power spec reach 400uA.
> 
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v7:
>  - Addressed comments from Greg KH.
> 
>  Documentation/ABI/testing/sysfs-platform-soc@B |  28 ++
>  MAINTAINERS                                    |   2 +
>  drivers/misc/sunplus_iop.c                     | 455 +++++++++++++++++++++++++
>  3 files changed, 485 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-soc@B
>  create mode 100644 drivers/misc/sunplus_iop.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-soc@B b/Documentation/ABI/testing/sysfs-platform-soc@B
> new file mode 100644
> index 0000000..1946a6f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-soc@B
> @@ -0,0 +1,28 @@
> +What:		/sys/devices/platform/soc@B/9c000400.iop/sp_iop_mailbox
> +Date:		January 2022
> +KernelVersion:	5.16
> +Contact:	Tony Huang <tonyhuang.sunplus@gmail.com>
> +Description:
> +		Show IOP's mailbox0 register data.
> +		Format: %x
> +
> +What:		/sys/devices/platform/soc@B/9c000400.iop/sp_iop_mode
> +Date:		January 2022
> +KernelVersion:	5.16
> +Contact:	Tony Huang <tonyhuang.sunplus@gmail.com>
> +Description:
> +		Read-Write.
> +
> +		Write this file.
> +		Operation mode of IOP is switched to standby mode by writing
> +		"1" to sysfs.
> +		Operation mode of IOP is switched to normal mode by writing
> +		"0" to sysfs.
> +		Writing of other values is invalid.
> +
> +		Read this file.
> +		Show operation mode of IOP. "0" is normal mode. "1" is standby
> +		mode.
> +		Format: %x
> +
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f336c9..cbc8dff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18245,7 +18245,9 @@ F:	drivers/net/ethernet/dlink/sundance.c
>  SUNPLUS IOP DRIVER
>  M:	Tony Huang <tonyhuang.sunplus@gmail.com>
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-platform-soc@B
>  F:	Documentation/devicetree/bindings/misc/sunplu-iop.yaml
> +F:	drivers/misc/sunplus_iop.c
>  
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
> diff --git a/drivers/misc/sunplus_iop.c b/drivers/misc/sunplus_iop.c
> new file mode 100644
> index 0000000..c27875d
> --- /dev/null
> +++ b/drivers/misc/sunplus_iop.c
> @@ -0,0 +1,455 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The IOP driver for Sunplus SP7021
> + *
> + * Copyright (C) 2021 Sunplus Technology Inc.
> + *
> + * All Rights Reserved.
> + */
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/firmware.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/of_gpio.h>
> +
> +enum IOP_Status_e {
> +	IOP_SUCCESS,                /* successful */
> +	IOP_ERR_IOP_BUSY,           /* IOP is busy */
> +};
> +
> +/* moon0 register offset */
> +#define IOP_CLKEN0	0x04
> +#define IOP_RESET0	0x54
> +
> +/* IOP register offset */
> +#define IOP_CONTROL	0x00
> +#define IOP_DATA0	0x20
> +#define IOP_DATA1	0x24
> +#define IOP_DATA2	0x28
> +#define IOP_DATA3	0x2c
> +#define IOP_DATA4	0x30
> +#define IOP_DATA5	0x34
> +#define IOP_DATA6	0x38
> +#define IOP_DATA7	0x3c
> +#define IOP_DATA8	0x40
> +#define IOP_DATA9	0x44
> +#define IOP_DATA10	0x48
> +#define IOP_DATA11	0x4c
> +#define IOP_BASE_ADR_L	0x50
> +#define IOP_BASE_ADR_H	0x54
> +
> +/* PMC register offset */
> +#define IOP_PMC_TIMER		0x00
> +#define IOP_PMC_CTRL		0x04
> +#define IOP_XTAL27M_PASSWORD_I	0x08
> +#define IOP_XTAL27M_PASSWORD_II	0x0c
> +#define IOP_XTAL32K_PASSWORD_I	0x10
> +#define IOP_XTAL32K_PASSWORD_II	0x14
> +#define IOP_CLK27M_PASSWORD_I	0x18
> +#define IOP_CLK27M_PASSWORD_II	0x1c
> +#define IOP_PMC_TIMER2		0x20
> +
> +#define NORMAL_CODE_MAX_SIZE 0X1000	/* Max size of normal.bin that can be received */
> +#define STANDBY_CODE_MAX_SIZE 0x4000	/* Max size of standby.bin that can be received */
> +struct sp_iop {
> +	struct miscdevice dev;
> +	struct mutex write_lock;	/* avoid parallel access */
> +	void __iomem *iop_regs;
> +	void __iomem *pmc_regs;
> +	void __iomem *moon0_regs;
> +	int irq;
> +	int gpio_wakeup;
> +	unsigned char iop_normal_code[NORMAL_CODE_MAX_SIZE];
> +	unsigned char iop_standby_code[STANDBY_CODE_MAX_SIZE];
> +	resource_size_t iop_mem_start;
> +	resource_size_t iop_mem_size;
> +	unsigned char bin_code_mode;
> +};
> +
> +static void sp_iop_normal_mode(struct sp_iop *iop)
> +{
> +	void __iomem *iop_kernel_base;
> +	unsigned int reg;
> +
> +	iop_kernel_base = ioremap(iop->iop_mem_start, NORMAL_CODE_MAX_SIZE);
> +	memset(iop_kernel_base, 0, NORMAL_CODE_MAX_SIZE);
> +	memcpy(iop_kernel_base, iop->iop_normal_code, NORMAL_CODE_MAX_SIZE);
> +
> +	writel(0x00100010, iop->moon0_regs + IOP_CLKEN0);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg |= 0x01;
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg &= ~(0x8000);
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg |= 0x0200;// disable watchdog event reset IOP
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +
> +	reg = (iop->iop_mem_start & 0xFFFF);
> +	writel(reg, iop->iop_regs + IOP_BASE_ADR_L);
> +	reg	= (iop->iop_mem_start >> 16);
> +	writel(reg, iop->iop_regs + IOP_BASE_ADR_H);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg &= ~(0x01);
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +	iop->bin_code_mode = 0;
> +}
> +
> +static void sp_iop_standby_mode(struct sp_iop *iop)
> +{
> +	void __iomem *iop_kernel_base;
> +	unsigned long reg;
> +
> +	iop_kernel_base = ioremap(iop->iop_mem_start, STANDBY_CODE_MAX_SIZE);
> +	memset(iop_kernel_base, 0, STANDBY_CODE_MAX_SIZE);
> +	memcpy(iop_kernel_base, iop->iop_standby_code, STANDBY_CODE_MAX_SIZE);
> +
> +	writel(0x00100010, iop->moon0_regs + IOP_CLKEN0);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg |= 0x01;
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg &= ~(0x8000);
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg |= 0x0200;// disable watchdog event reset IOP
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +
> +	reg = (iop->iop_mem_start & 0xFFFF);
> +	writel(reg, iop->iop_regs + IOP_BASE_ADR_L);
> +	reg = (iop->iop_mem_start >> 16);
> +	writel(reg, iop->iop_regs + IOP_BASE_ADR_H);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg &= ~(0x01);
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +	iop->bin_code_mode = 1;
> +}
> +
> +/* 8051 informs linux kerenl. 8051 has been switched to standby.bin code. */
> +#define IOP_READY	0x0004
> +#define RISC_READY	0x0008
> +
> +/* System linux kernel tells 8051 which  gpio pin to wake-up through. */
> +#define WAKEUP_PIN	0xFE02
> +
> +/* System linux kernel tells 8051 to execute S1 or S3 mode. */
> +#define S1	0x5331
> +#define S3	0x5333
> +
> +static int sp_iop_s3mode(struct device *dev, struct sp_iop *iop)
> +{
> +	unsigned int reg;
> +	int ret, value;
> +
> +	/* PMC set */
> +	writel(0x00010001, iop->pmc_regs + IOP_PMC_TIMER);
> +	reg = readl(iop->pmc_regs + IOP_PMC_CTRL);
> +	/* disable system reset PMC, enalbe power down IOP Domain, enable gating clock 27Mhz */
> +	reg |= 0x23;
> +	writel(reg, iop->pmc_regs + IOP_PMC_CTRL);
> +
> +	writel(0x55aa00ff, iop->pmc_regs + IOP_XTAL27M_PASSWORD_I);
> +	writel(0x00ff55aa, iop->pmc_regs + IOP_XTAL27M_PASSWORD_II);
> +	writel(0xaa00ff55, iop->pmc_regs + IOP_XTAL32K_PASSWORD_I);
> +	writel(0xff55aa00, iop->pmc_regs + IOP_XTAL32K_PASSWORD_II);
> +	writel(0xaaff0055, iop->pmc_regs + IOP_CLK27M_PASSWORD_I);
> +	writel(0x5500aaff, iop->pmc_regs + IOP_CLK27M_PASSWORD_II);
> +	writel(0x01000100, iop->pmc_regs + IOP_PMC_TIMER2);
> +
> +	/* IOP Hardware IP reset */
> +	reg = readl(iop->moon0_regs + IOP_RESET0);
> +	reg |= 0x10;
> +	writel(reg, (iop->moon0_regs + IOP_RESET0));
> +	reg &= ~(0x10);
> +	writel(reg, (iop->moon0_regs + IOP_RESET0));
> +
> +	writel(0x00ff0085, (iop->moon0_regs + 32 * 4 * 1 + 4 * 1));
> +
> +	reg = readl(iop->moon0_regs + 32 * 4 * 1 + 4 * 2);
> +	reg |= 0x08000800;
> +	writel(reg, (iop->moon0_regs + 32 * 4 * 1 + 4 * 2));
> +
> +	writel(WAKEUP_PIN, iop->iop_regs + IOP_DATA0);
> +	writel(iop->gpio_wakeup, iop->iop_regs + IOP_DATA1);
> +
> +	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA2, value,
> +				 (value & IOP_READY) == IOP_READY, 1000, 10000);
> +	if (ret) {
> +		dev_err(dev, "timed out\n");
> +		return ret;
> +	}
> +
> +	reg = RISC_READY;
> +	writel(reg, iop->iop_regs + IOP_DATA2);
> +	reg = 0x0000;
> +	writel(reg, iop->iop_regs + IOP_DATA5);
> +	reg = 0x0060;
> +	writel(reg, iop->iop_regs + IOP_DATA6);
> +
> +	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA7, value,
> +				 value == 0xaaaa, 1000, 10000);
> +	if (ret) {
> +		dev_err(dev, "timed out\n");
> +		return ret;
> +	}
> +
> +	/* 8051 bin file call Ultra low function. */
> +	writel(0xdd, iop->iop_regs + IOP_DATA1);
> +	/*
> +	 * When the execution is here, the system linux kernel
> +	 * is about to be powered off
> +	 * The purpose of mdelay(10): Do not let the system linux
> +	 * kernel continue to run other programs.
> +	 */
> +	mdelay(10);
> +	return 0;
> +}
> +
> +static int sp_iop_s1mode(struct device *dev, struct sp_iop *iop)
> +{
> +	int ret, value;
> +
> +	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA2, value,
> +				 (value & IOP_READY) == IOP_READY, 1000, 10000);
> +	if (ret) {
> +		dev_err(dev, "timed out\n");
> +		return ret;
> +	}
> +
> +	writel(RISC_READY, iop->iop_regs + IOP_DATA2);
> +	writel(0x0000, iop->iop_regs + IOP_DATA5);
> +	writel(0x0060, iop->iop_regs + IOP_DATA6);
> +
> +	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA7, value,
> +				 value == 0xaaaa, 1000, 10000);
> +	if (ret) {
> +		dev_err(dev, "timed out\n");
> +		return ret;
> +	}
> +
> +	/* 8051 bin file call S1_mode function. */
> +	writel(0xee, iop->iop_regs + IOP_DATA1);
> +	/*
> +	 * When the execution is here, the system linux kernel
> +	 * is about to be powered off
> +	 * The purpose of mdelay(10): Do not let the system linux
> +	 * kernel continue to run other programs.
> +	 */
> +	mdelay(10);
> +	return 0;
> +}
> +
> +static ssize_t sp_iop_mailbox_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sp_iop *iop = dev_get_drvdata(dev);
> +	unsigned int mailbox;
> +
> +	mailbox = readl(iop->iop_regs + IOP_DATA0);
> +	return sysfs_emit(buf, "%x\n", mailbox);
> +}
> +
> +static ssize_t sp_iop_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sp_iop *iop = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%x\n", iop->bin_code_mode);
> +}
> +
> +static ssize_t sp_iop_mode_store(struct device *dev, struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct sp_iop *iop = dev_get_drvdata(dev);
> +
> +	if (sysfs_streq(buf, "0"))
> +		sp_iop_normal_mode(iop);
> +	else if (sysfs_streq(buf, "1"))
> +		sp_iop_standby_mode(iop);
> +	else
> +		return -EINVAL;
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RO(sp_iop_mailbox);
> +static DEVICE_ATTR_RW(sp_iop_mode);

Please do not manually create the sysfs files.  You race with userspace
and loose.  Use the default_groups pointer of the platform driver and
then the driver core will handle that all for you automatically.

thanks,

greg k-h
