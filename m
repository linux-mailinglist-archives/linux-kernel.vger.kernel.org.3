Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2446481C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhL3NLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:11:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45534 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhL3NLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:11:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73F2DB81C1F;
        Thu, 30 Dec 2021 13:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96555C36AE9;
        Thu, 30 Dec 2021 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640869874;
        bh=DYe/Lf/vuVcg1GRqYXng+KXdbjS+ynjYPXgHn3F7eio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xcWJMlARg/yMZQTzw1j/qNX+ED3Uky8cEFfyGe78I8pSjvGQeLqJ7suNnsWSiPqAu
         gRfJwTU3HC/N6zSbq4IOjihC2LaYXWncUzAGYy7m4DHNRishE1U+0LVshw8FDfHcZm
         cDNCCqs9xbKTzeT5vxDsdBqEXrVHk10M/ffPLluo=
Date:   Thu, 30 Dec 2021 14:11:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, tony.huang@sunplus.com,
        wells.lu@sunplus.com
Subject: Re: [PATCH v6 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <Yc2v76Rti2Db3zK3@kroah.com>
References: <cover.1640836400.git.tonyhuang.sunplus@gmail.com>
 <ac565aa146b83fdb155ad81eae22bc17fdb8bc51.1640836400.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac565aa146b83fdb155ad81eae22bc17fdb8bc51.1640836400.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 08:51:45PM +0800, Tony Huang wrote:
> IOP(8051) embedded inside SP7021 which is used as
> Processor for I/O control, monitor RTC interrupt and
> cooperation with CPU & PMC in power management purpose.
> The IOP core is DQ8051, so also named IOP8051,
> it supports dedicated JTAG debug pins which share with SP7021.
> In standby mode operation, the power spec reach 400uA.
> 
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v6:
>  - Added sysfs read/write description.
>  - Modify sysfs read function.
>  - Addressed comments from kernel test robot.
> 
>  Documentation/ABI/testing/sysfs-platform-soc@B |  25 ++
>  MAINTAINERS                                    |   2 +
>  drivers/misc/Kconfig                           |  12 +
>  drivers/misc/Makefile                          |   1 +
>  drivers/misc/sunplus_iop.c                     | 476 +++++++++++++++++++++++++
>  5 files changed, 516 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-soc@B
>  create mode 100644 drivers/misc/sunplus_iop.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-soc@B b/Documentation/ABI/testing/sysfs-platform-soc@B
> new file mode 100644
> index 0000000..6272919
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-soc@B
> @@ -0,0 +1,25 @@
> +What:		/sys/devices/platform/soc@B/9c000400.iop/sp_iop_mailbox
> +Date:		December 2021
> +KernelVersion:	5.16
> +Contact:	Tony Huang <tonyhuang.sunplus@gmail.com>
> +Description:
> +		Show 8051 mailbox0 data.

What format is the data in?



> +
> +What:		/sys/devices/platform/soc@B/9c000400.iop/sp_iop_mode
> +Date:		December 2021
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
> +
> +		Read this file.
> +		Show operation mode of IOP. "0" is normal mode. "1" is standby
> +		mode.
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
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 0f5a49f..45655ea 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -470,6 +470,18 @@ config HISI_HIKEY_USB
>  	  switching between the dual-role USB-C port and the USB-A host ports
>  	  using only one USB controller.
>  
> +config SUNPLUS_IOP
> +	tristate "Sunplus IOP support"
> +	default ARCH_SUNPLUS
> +	help
> +	  Sunplus I/O processor (8051) driver.
> +	  Processor for I/O control, RTC wake-up proceduce management,
> +	  and cooperation with CPU&PMC in power management.
> +	  Need Install DQ8051, The DQ8051 bin file generated by keil C.

I do not understand this sentence, what do you mean by it?  Can you
provide a link to where the files that are required are?  Why not
include them in the linux-firmware project?

> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called sunplus_iop.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index a086197..eafeab6 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_DW_XDATA_PCIE)	+= dw-xdata-pcie.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-$(CONFIG_BCM_VK)		+= bcm-vk/
> +obj-$(CONFIG_SUNPLUS_IOP)	+= sunplus_iop.o
>  obj-y				+= cardreader/
>  obj-$(CONFIG_PVPANIC)   	+= pvpanic/
>  obj-$(CONFIG_HABANA_AI)		+= habanalabs/
> diff --git a/drivers/misc/sunplus_iop.c b/drivers/misc/sunplus_iop.c
> new file mode 100644
> index 0000000..a16d9e6
> --- /dev/null
> +++ b/drivers/misc/sunplus_iop.c
> @@ -0,0 +1,476 @@
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
> +struct regs_moon0 {
> +	u32 stamp;         /* 00 */
> +	u32 clken[10];     /* 01~10 */
> +	u32 gclken[10];    /* 11~20 */
> +	u32 reset[10];     /* 21~30 */
> +	u32 sfg_cfg_mode;  /* 31 */

What are these comments numbering?

> +};
> +
> +struct regs_iop {
> +	u32 iop_control;/* 00 */
> +	u32 iop_reg1;/* 01 */
> +	u32 iop_bp;/* 02 */
> +	u32 iop_regsel;/* 03 */
> +	u32 iop_regout;/* 04 */
> +	u32 iop_reg5;/* 05 */
> +	u32 iop_resume_pcl;/* 06 */
> +	u32 iop_resume_pch;/* 07 */
> +	u32 iop_data0;/* 08 */
> +	u32 iop_data1;/* 09 */
> +	u32 iop_data2;/* 10 */
> +	u32 iop_data3;/* 11 */
> +	u32 iop_data4;/* 12 */
> +	u32 iop_data5;/* 13 */
> +	u32 iop_data6;/* 14 */
> +	u32 iop_data7;/* 15 */
> +	u32 iop_data8;/* 16 */
> +	u32 iop_data9;/* 17 */
> +	u32 iop_data10;/* 18 */
> +	u32 iop_data11;/* 19 */
> +	u32 iop_base_adr_l;/* 20 */
> +	u32 iop_base_adr_h;/* 21 */
> +	u32 memory_bridge_control;/* 22 */
> +	u32 iop_regmap_adr_l;/* 23 */
> +	u32 iop_regmap_adr_h;/* 24 */
> +	u32 iop_direct_adr;/* 25*/
> +	u32 reserved[6];/* 26~31 */

Same here, what are these numbers?

And why are they not lined up like the previous structure?


> +};
> +
> +struct regs_iop_pmc {
> +	u32 PMC_TIMER;/* 00 */
> +	u32 PMC_CTRL;/* 01 */
> +	u32 XTAL27M_PASSWORD_I;/* 02 */
> +	u32 XTAL27M_PASSWORD_II;/* 03 */
> +	u32 XTAL32K_PASSWORD_I;/* 04 */
> +	u32 XTAL32K_PASSWORD_II;/* 05 */
> +	u32 CLK27M_PASSWORD_I;/* 06 */
> +	u32 CLK27M_PASSWORD_II;/* 07 */
> +	u32 PMC_TIMER2;/* 08 */
> +	u32 reserved[23];/* 9~31 */

Same comment question here.

> +};
> +
> +#define NORMAL_CODE_MAX_SIZE 0X1000

"0x"?

> +#define STANDBY_CODE_MAX_SIZE 0x4000

What are these for?

> +struct sp_iop {
> +	struct miscdevice dev;			// iop device

Why the comment?

> +	struct mutex write_lock;
> +	void *iop_regs;
> +	void *pmc_regs;
> +	void *moon0_regs;

Why void pointers?  You created structures above, use them!

This is not Windows programming :)


> +	int irq;
> +	int gpio_wakeup;
> +	unsigned char iop_normal_code[NORMAL_CODE_MAX_SIZE];
> +	unsigned char iop_standby_code[STANDBY_CODE_MAX_SIZE];
> +	resource_size_t iop_mem_start;
> +	resource_size_t iop_mem_size;
> +	bool mode;

How can a "mode" be boolean?  Perhaps a better name?

> +};
> +
> +static void sp_iop_normal_mode(struct sp_iop *iop)
> +{
> +	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;

See, don't use a void pointer, use the real structure please.

> +	struct regs_moon0 *p_moon0_reg = (struct regs_moon0 *)iop->moon0_regs;
> +	void *iop_kernel_base;

Why void?  Isn't this a structure too?

> +	unsigned int reg;
> +
> +	iop_kernel_base = ioremap(iop->iop_mem_start, NORMAL_CODE_MAX_SIZE);
> +	memset(iop_kernel_base, 0, NORMAL_CODE_MAX_SIZE);
> +	memcpy(iop_kernel_base, iop->iop_normal_code, NORMAL_CODE_MAX_SIZE);
> +
> +	writel(0x00100010, &p_moon0_reg->clken[0]);
> +
> +	reg = readl(&p_iop_reg->iop_control);
> +	reg |= 0x01;
> +	writel(reg, &p_iop_reg->iop_control);
> +
> +	reg = readl(&p_iop_reg->iop_control);
> +	reg &= ~(0x8000);
> +	writel(reg, &p_iop_reg->iop_control);
> +
> +	reg = readl(&p_iop_reg->iop_control);
> +	reg |= 0x0200;//disable watchdog event reset IOP
> +	writel(reg, &p_iop_reg->iop_control);
> +
> +	reg = (iop->iop_mem_start & 0xFFFF);
> +	writel(reg, &p_iop_reg->iop_base_adr_l);
> +	reg	= (iop->iop_mem_start >> 16);
> +	writel(reg, &p_iop_reg->iop_base_adr_h);
> +
> +	reg = readl(&p_iop_reg->iop_control);
> +	reg &= ~(0x01);
> +	writel(reg, &p_iop_reg->iop_control);
> +	iop->mode = 0;
> +}
> +
> +static void sp_iop_standby_mode(struct sp_iop *iop)
> +{
> +	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
> +	struct regs_moon0 *p_moon0_reg = (struct regs_moon0 *)iop->moon0_regs;
> +	void *iop_kernel_base;
> +	unsigned long reg;
> +
> +	iop_kernel_base = ioremap(iop->iop_mem_start, STANDBY_CODE_MAX_SIZE);
> +	memset(iop_kernel_base, 0, STANDBY_CODE_MAX_SIZE);
> +	memcpy(iop_kernel_base, iop->iop_standby_code, STANDBY_CODE_MAX_SIZE);
> +
> +	writel(0x00100010, &p_moon0_reg->clken[0]);
> +
> +	reg = readl(&p_iop_reg->iop_control);
> +	reg |= 0x01;
> +	writel(reg, &p_iop_reg->iop_control);
> +
> +	reg = readl(&p_iop_reg->iop_control);
> +	reg &= ~(0x8000);
> +	writel(reg, &p_iop_reg->iop_control);
> +
> +	reg = readl(&p_iop_reg->iop_control);
> +	reg |= 0x0200;//disable watchdog event reset IOP
> +	writel(reg, &p_iop_reg->iop_control);
> +
> +	reg = (iop->iop_mem_start & 0xFFFF);
> +	writel(reg, &p_iop_reg->iop_base_adr_l);
> +	reg = (iop->iop_mem_start >> 16);
> +	writel(reg, &p_iop_reg->iop_base_adr_h);
> +
> +	reg = readl(&p_iop_reg->iop_control);
> +	reg &= ~(0x01);
> +	writel(reg, &p_iop_reg->iop_control);
> +	iop->mode = 1;
> +}
> +
> +#define IOP_READY	0x4
> +#define RISC_READY	0x8
> +#define WAKEUP_PIN	0xFE02
> +#define S1	0x5331
> +#define S3	0x5333


What are these values for?

> +static int sp_iop_s3mode(struct device *dev, struct sp_iop *iop)
> +{
> +	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
> +	struct regs_moon0 *p_moon0_reg = (struct regs_moon0 *)iop->moon0_regs;
> +	struct regs_iop_pmc *p_iop_pmc_reg = (struct regs_iop_pmc *)iop->pmc_regs;
> +	unsigned int reg;
> +	int ret, value;
> +
> +	writel(0x00100010, &p_moon0_reg->clken[0]);
> +
> +	reg = readl(&p_iop_reg->iop_control);
> +	reg &= ~(0x8000);
> +	writel(reg, &p_iop_reg->iop_control);
> +
> +	reg = readl(&p_iop_reg->iop_control);
> +	reg |= 0x1;
> +	writel(reg, &p_iop_reg->iop_control);
> +
> +	//PMC set
> +	writel(0x00010001, &p_iop_pmc_reg->PMC_TIMER);
> +	reg = readl(&p_iop_pmc_reg->PMC_CTRL);
> +	reg |= 0x23;// disable system reset PMC, enalbe power down 27M, enable gating 27M

What is "27M"?

> +	writel(reg, &p_iop_pmc_reg->PMC_CTRL);
> +
> +	writel(0x55aa00ff, &p_iop_pmc_reg->XTAL27M_PASSWORD_I);
> +	writel(0x00ff55aa, &p_iop_pmc_reg->XTAL27M_PASSWORD_II);
> +	writel(0xaa00ff55, &p_iop_pmc_reg->XTAL32K_PASSWORD_I);
> +	writel(0xff55aa00, &p_iop_pmc_reg->XTAL32K_PASSWORD_II);
> +	writel(0xaaff0055, &p_iop_pmc_reg->CLK27M_PASSWORD_I);
> +	writel(0x5500aaff, &p_iop_pmc_reg->CLK27M_PASSWORD_II);
> +	writel(0x01000100, &p_iop_pmc_reg->PMC_TIMER2);
> +
> +	//IOP Hardware IP reset

Always put a ' ' after '//'


> +	reg = readl(&p_moon0_reg->reset[0]);
> +	reg |= 0x10;
> +	writel(reg, (&p_moon0_reg->reset[0]));
> +	reg &= ~(0x10);
> +	writel(reg, (&p_moon0_reg->reset[0]));
> +
> +	writel(0x00ff0085, (iop->moon0_regs + 32 * 4 * 1 + 4 * 1));
> +
> +	reg = readl(iop->moon0_regs + 32 * 4 * 1 + 4 * 2);
> +	reg |= 0x08000800;
> +	writel(reg, (iop->moon0_regs + 32 * 4 * 1 + 4 * 2));
> +
> +	reg = readl(&p_iop_reg->iop_control);
> +	reg |= 0x0200;//disable watchdog event reset IOP
> +	writel(reg, &p_iop_reg->iop_control);
> +
> +	reg = (iop->iop_mem_start & 0xFFFF);
> +	writel(reg, &p_iop_reg->iop_base_adr_l);
> +	reg = (iop->iop_mem_start >> 16);
> +	writel(reg, &p_iop_reg->iop_base_adr_h);
> +
> +	reg = readl(&p_iop_reg->iop_control);
> +	reg &= ~(0x01);
> +	writel(reg, &p_iop_reg->iop_control);
> +
> +	writel(WAKEUP_PIN, &p_iop_reg->iop_data0);
> +	writel(iop->gpio_wakeup, &p_iop_reg->iop_data1);
> +
> +	ret = readl_poll_timeout(&p_iop_reg->iop_data2, value,
> +				 (value & IOP_READY) == IOP_READY, 1000, 10000);
> +	if (ret) {
> +		dev_err(dev, "timed out\n");
> +		return ret;
> +	}
> +
> +	writel(RISC_READY, &p_iop_reg->iop_data2);
> +	writel(0x00, &p_iop_reg->iop_data5);
> +	writel(0x60, &p_iop_reg->iop_data6);
> +
> +	ret = readl_poll_timeout(&p_iop_reg->iop_data7, value,
> +				 value == 0xaaaa, 1000, 10000);
> +	if (ret) {
> +		dev_err(dev, "timed out\n");
> +		return ret;
> +	}
> +
> +	writel(0xdd, &p_iop_reg->iop_data1);//8051 bin file call Ultra low function.
> +	mdelay(10);

Where did 10 come from?  How do you know that is correct?

Same comment for your other delay calls in the driver.

> +	return 0;
> +}
> +
> +static int sp_iop_s1mode(struct device *dev, struct sp_iop *iop)
> +{
> +	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
> +	int ret, value;
> +
> +	ret = readl_poll_timeout(&p_iop_reg->iop_data2, value,
> +				 (value & IOP_READY) == IOP_READY, 1000, 10000);
> +	if (ret) {
> +		dev_err(dev, "timed out\n");
> +		return ret;
> +	}
> +
> +	writel(RISC_READY, &p_iop_reg->iop_data2);
> +	writel(0x00, &p_iop_reg->iop_data5);
> +	writel(0x60, &p_iop_reg->iop_data6);
> +
> +	ret = readl_poll_timeout(&p_iop_reg->iop_data7, value,
> +				 value == 0xaaaa, 1000, 10000);
> +	if (ret) {
> +		dev_err(dev, "timed out\n");
> +		return ret;
> +	}
> +
> +	writel(0xee, &p_iop_reg->iop_data1);//8051 bin file call S1_mode function.
> +	mdelay(10);
> +	return 0;
> +}
> +
> +static ssize_t sp_iop_mailbox_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sp_iop *iop = dev_get_drvdata(dev);
> +	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
> +	unsigned int mailbox;
> +
> +	mailbox = readl(&p_iop_reg->iop_data0);
> +	return sysfs_emit(buf, "mailbox = 0x%x\n", mailbox);
> +}
> +
> +static ssize_t sp_iop_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sp_iop *iop = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "bin code mode = 0x%x\n", iop->mode);

That is not a valid sysfs file output.  Again "ONE VALUE PER FILE", you
should never have to parse the output like this.

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
> +	return count;

So no matter what you write here, it will not return an error?

That is not correct.

> +}
> +
> +static DEVICE_ATTR_RO(sp_iop_mailbox);
> +static DEVICE_ATTR_RW(sp_iop_mode);
> +
> +static int  sp_iop_get_normal_code(struct device *dev, struct sp_iop *iop)
> +{
> +	const struct firmware *fw;
> +	static const char file[] = "normal.bin";
> +	unsigned int err, i;
> +
> +	err = request_firmware(&fw, file, dev);
> +	if (err) {
> +		dev_err(dev, "get bin file error\n");
> +		return err;
> +	}
> +
> +	for (i = 0; i < NORMAL_CODE_MAX_SIZE; i++) {
> +		char temp;
> +
> +		temp = fw->data[i];
> +		iop->iop_normal_code[i] = temp;
> +	}
> +	release_firmware(fw);
> +	return err;
> +}
> +
> +static int  sp_iop_get_standby_code(struct device *dev, struct sp_iop *iop)
> +{
> +	const struct firmware *fw;
> +	static const char file[] = "standby.bin";
> +	unsigned int err, i;
> +
> +	err = request_firmware(&fw, file, dev);
> +	if (err) {
> +		dev_err(dev, "get bin file error\n");
> +		return err;
> +	}
> +
> +	for (i = 0; i < STANDBY_CODE_MAX_SIZE; i++) {
> +		char temp;
> +
> +		temp = fw->data[i];
> +		iop->iop_standby_code[i] = temp;
> +	}
> +	release_firmware(fw);
> +	return err;
> +}
> +
> +static int sp_iop_get_resources(struct platform_device *pdev, struct sp_iop *p_sp_iop_info)
> +{
> +	struct resource *r;
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "iop");
> +	p_sp_iop_info->iop_regs = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(p_sp_iop_info->iop_regs)) {
> +		dev_err(&pdev->dev, "ioremap fail\n");
> +		return PTR_ERR(p_sp_iop_info->iop_regs);
> +	}
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "iop_pmc");
> +	p_sp_iop_info->pmc_regs = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(p_sp_iop_info->pmc_regs)) {
> +		dev_err(&pdev->dev, "ioremap fail\n");
> +		return PTR_ERR(p_sp_iop_info->pmc_regs);
> +	}
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "moon0");
> +	p_sp_iop_info->moon0_regs = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(p_sp_iop_info->moon0_regs)) {
> +		dev_err(&pdev->dev, "ioremap fail\n");
> +		return PTR_ERR(p_sp_iop_info->moon0_regs);
> +	}
> +	return IOP_SUCCESS;
> +}
> +
> +static int sp_iop_platform_driver_probe(struct platform_device *pdev)
> +{
> +	int ret = -ENXIO;
> +	int rc;
> +	struct sp_iop *iop;
> +	struct device_node *memnp;
> +	struct resource mem_res;
> +
> +	iop = devm_kzalloc(&pdev->dev, sizeof(struct sp_iop), GFP_KERNEL);
> +	if (!iop) {
> +		ret	= -ENOMEM;
> +		goto fail_kmalloc;
> +	}
> +	/* init */
> +	mutex_init(&iop->write_lock);
> +	ret = sp_iop_get_resources(pdev, iop);
> +
> +	//Get reserve address
> +	memnp = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
> +	if (!memnp) {
> +		dev_err(&pdev->dev, "no memory-region node\n");
> +		return -EINVAL;
> +	}
> +
> +	rc = of_address_to_resource(memnp, 0, &mem_res);
> +	of_node_put(memnp);
> +	if (rc) {
> +		dev_err(&pdev->dev, "failed to translate memory-region to a resource\n");
> +		return -EINVAL;
> +	}
> +
> +	iop->iop_mem_start = mem_res.start;
> +	iop->iop_mem_size = resource_size(&mem_res);
> +
> +	ret = sp_iop_get_normal_code(&pdev->dev, iop);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "get normal code err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = sp_iop_get_standby_code(&pdev->dev, iop);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "get standby code err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	sp_iop_normal_mode(iop);
> +	platform_set_drvdata(pdev, iop);
> +	device_create_file(&pdev->dev, &dev_attr_sp_iop_mailbox);
> +	device_create_file(&pdev->dev, &dev_attr_sp_iop_mode);

You just raced with userspace and lost.  Set the default groups pointer
of the misc device to your attribute group and then they will be
automatically created for you.




> +	iop->gpio_wakeup = of_get_named_gpio(pdev->dev.of_node, "iop-wakeup", 0);
> +	return 0;
> +
> +fail_kmalloc:
> +	return ret;
> +}
> +
> +static void sp_iop_platform_driver_shutdown(struct platform_device *pdev)
> +{
> +	struct sp_iop *iop = platform_get_drvdata(pdev);
> +	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
> +	unsigned int value;
> +
> +	sp_iop_standby_mode(iop);
> +	mdelay(10);

Why sleep on shutdown?

thanks,

greg k-h
