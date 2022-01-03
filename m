Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD90D482EB8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiACH30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:29:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45596 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiACH3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:29:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DDD560FAC;
        Mon,  3 Jan 2022 07:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE72C36AEE;
        Mon,  3 Jan 2022 07:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641194964;
        bh=D21M/w5mJ32q+5rLheZRjFl9ed881ji9sxo2nEtGT5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sin/9qplWkNAK6ee9lheT9RPnuSym17csm7sAa0EFoFKw2hNrcxyKDBXbg3JsACzN
         pV/dH2dr+yt0mFPZwbQcQHjDhr50l6ZOek5TThmGLrxslDJ3ZOjyiebDemWqbCUfFD
         0Y0tLHRyEPc7KXabJwLXcvLTNJ1tHVi4TrDdPF/A=
Date:   Mon, 3 Jan 2022 08:29:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Huang =?utf-8?B?6buD5oe35Y6a?= <tony.huang@sunplus.com>
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH v6 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <YdKlzmrCSi8N5Uj7@kroah.com>
References: <cover.1640836400.git.tonyhuang.sunplus@gmail.com>
 <ac565aa146b83fdb155ad81eae22bc17fdb8bc51.1640836400.git.tonyhuang.sunplus@gmail.com>
 <Yc2v76Rti2Db3zK3@kroah.com>
 <7c94a768206b48a984c4d269a0e98e50@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c94a768206b48a984c4d269a0e98e50@sphcmbx02.sunplus.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 05:31:27AM +0000, Tony Huang 黃懷厚 wrote:
> Dear Greg:
> 
> > > IOP(8051) embedded inside SP7021 which is used as Processor for I/O
> > > control, monitor RTC interrupt and cooperation with CPU & PMC in power
> > > management purpose.
> > > The IOP core is DQ8051, so also named IOP8051, it supports dedicated
> > > JTAG debug pins which share with SP7021.
> > > In standby mode operation, the power spec reach 400uA.
> > >
> > > Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> > > ---
> > > Changes in v6:
> > >  - Added sysfs read/write description.
> > >  - Modify sysfs read function.
> > >  - Addressed comments from kernel test robot.
> > >
> > >  Documentation/ABI/testing/sysfs-platform-soc@B |  25 ++
> > >  MAINTAINERS                                    |   2 +
> > >  drivers/misc/Kconfig                           |  12 +
> > >  drivers/misc/Makefile                          |   1 +
> > >  drivers/misc/sunplus_iop.c                     | 476
> > +++++++++++++++++++++++++
> > >  5 files changed, 516 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-platform-soc@B
> > >  create mode 100644 drivers/misc/sunplus_iop.c
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-platform-soc@B
> > > b/Documentation/ABI/testing/sysfs-platform-soc@B
> > > new file mode 100644
> > > index 0000000..6272919
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-platform-soc@B
> > > @@ -0,0 +1,25 @@
> > > +What:		/sys/devices/platform/soc@B/9c000400.iop/sp_iop_mailbox
> > > +Date:		December 2021
> > > +KernelVersion:	5.16
> > > +Contact:	Tony Huang <tonyhuang.sunplus@gmail.com>
> > > +Description:
> > > +		Show 8051 mailbox0 data.
> > 
> > What format is the data in?
> > 
> 
> Unsigned short

So you are returning 16 bits, please describe the value as to what it
will contain and what it means.

And what exactly does "8051" mean here?  That is just some random
processor in the system, it needs to be described better please.

> > > +config SUNPLUS_IOP
> > > +	tristate "Sunplus IOP support"
> > > +	default ARCH_SUNPLUS
> > > +	help
> > > +	  Sunplus I/O processor (8051) driver.
> > > +	  Processor for I/O control, RTC wake-up proceduce management,
> > > +	  and cooperation with CPU&PMC in power management.
> > > +	  Need Install DQ8051, The DQ8051 bin file generated by keil C.
> > 
> > I do not understand this sentence, what do you mean by it?  Can you provide a
> > link to where the files that are required are?  Why not include them in the
> > linux-firmware project?
> > 
> 
> 1.We will provide users with 8051 normal and standby source code.			
>   Path: https://sunplus.atlassian.net/wiki/spaces/doc/pages/610172933/How+to+use+I+O+processor+8051+of+SP7021#5.-Write-C-or-assembly-source-files-for-IOP			
> 2.Users can follow the operation steps to generate normal.bin and standby.bin.			
>   Path: https://sunplus.atlassian.net/wiki/spaces/doc/pages/466190338/26.+IOP8051			
>   26.5 How To Create 8051 bin file			

Please include stuff like this in the help text to make it more obvious.

> > > +struct regs_moon0 {
> > > +	u32 stamp;         /* 00 */
> > > +	u32 clken[10];     /* 01~10 */
> > > +	u32 gclken[10];    /* 11~20 */
> > > +	u32 reset[10];     /* 21~30 */
> > > +	u32 sfg_cfg_mode;  /* 31 */
> > 
> > What are these comments numbering?
> > 
> 
> regs_moon0 is Group 0 moon register.					
> The Group0 moon register range is 0x9c00000~0x9c00007F					
> /*00*/: 0x9c000000~0x9c000003					
> /*01~10*/:0x9c000004~0x9c00002b					
> /*11~20*/:0x9c00002c~0x9c000053					
> /*21~30*/:0x9c000054~0x9c00007b					
> /*31*/:0x9c00007c~0x9c00007f					

Ok, so the number is just the offset into a memory location?  Please be
specific.


> 
> > > +};
> > > +
> > > +struct regs_iop {
> > > +	u32 iop_control;/* 00 */
> > > +	u32 iop_reg1;/* 01 */
> > > +	u32 iop_bp;/* 02 */
> > > +	u32 iop_regsel;/* 03 */
> > > +	u32 iop_regout;/* 04 */
> > > +	u32 iop_reg5;/* 05 */
> > > +	u32 iop_resume_pcl;/* 06 */
> > > +	u32 iop_resume_pch;/* 07 */
> > > +	u32 iop_data0;/* 08 */
> > > +	u32 iop_data1;/* 09 */
> > > +	u32 iop_data2;/* 10 */
> > > +	u32 iop_data3;/* 11 */
> > > +	u32 iop_data4;/* 12 */
> > > +	u32 iop_data5;/* 13 */
> > > +	u32 iop_data6;/* 14 */
> > > +	u32 iop_data7;/* 15 */
> > > +	u32 iop_data8;/* 16 */
> > > +	u32 iop_data9;/* 17 */
> > > +	u32 iop_data10;/* 18 */
> > > +	u32 iop_data11;/* 19 */
> > > +	u32 iop_base_adr_l;/* 20 */
> > > +	u32 iop_base_adr_h;/* 21 */
> > > +	u32 memory_bridge_control;/* 22 */
> > > +	u32 iop_regmap_adr_l;/* 23 */
> > > +	u32 iop_regmap_adr_h;/* 24 */
> > > +	u32 iop_direct_adr;/* 25*/
> > > +	u32 reserved[6];/* 26~31 */
> > 
> > Same here, what are these numbers?
> > 
> > And why are they not lined up like the previous structure?
> > 
> 
> Sorry, I don't understand what you mean. Isn't this a struct?					

Your comments are not lined up the same way the structure above has
them.

> > > +	struct mutex write_lock;
> > > +	void *iop_regs;
> > > +	void *pmc_regs;
> > > +	void *moon0_regs;
> > 
> > Why void pointers?  You created structures above, use them!
> > 
> 
> Because I received "Reported-by: kernel test robot <lkp@intel.com>", warmming message. As follows:										
> sparse warnings: (new ones prefixed by >>)										
>    drivers/misc/sunplus_iop.c:94:39: sparse: sparse: cast removes address space '__iomem' of expression										
>    drivers/misc/sunplus_iop.c:95:43: sparse: sparse: cast removes address space '__iomem' of expression										
> >> drivers/misc/sunplus_iop.c:100:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *[assigned] iop_kernel_base @@										
>    drivers/misc/sunplus_iop.c:100:16: sparse:     expected void *p										
>    drivers/misc/sunplus_iop.c:100:16: sparse:     got void [noderef] __iomem *[assigned] iop_kernel_base										

Ah, so these are actual pointers to the iomem memory?  Or pointers to
the structures you have copied out?  It is not obvious.

> > > +	reg = readl(&p_moon0_reg->reset[0]);
> > > +	reg |= 0x10;
> > > +	writel(reg, (&p_moon0_reg->reset[0]));
> > > +	reg &= ~(0x10);
> > > +	writel(reg, (&p_moon0_reg->reset[0]));
> > > +
> > > +	writel(0x00ff0085, (iop->moon0_regs + 32 * 4 * 1 + 4 * 1));
> > > +
> > > +	reg = readl(iop->moon0_regs + 32 * 4 * 1 + 4 * 2);
> > > +	reg |= 0x08000800;
> > > +	writel(reg, (iop->moon0_regs + 32 * 4 * 1 + 4 * 2));
> > > +
> > > +	reg = readl(&p_iop_reg->iop_control);
> > > +	reg |= 0x0200;//disable watchdog event reset IOP
> > > +	writel(reg, &p_iop_reg->iop_control);
> > > +
> > > +	reg = (iop->iop_mem_start & 0xFFFF);
> > > +	writel(reg, &p_iop_reg->iop_base_adr_l);
> > > +	reg = (iop->iop_mem_start >> 16);
> > > +	writel(reg, &p_iop_reg->iop_base_adr_h);
> > > +
> > > +	reg = readl(&p_iop_reg->iop_control);
> > > +	reg &= ~(0x01);
> > > +	writel(reg, &p_iop_reg->iop_control);
> > > +
> > > +	writel(WAKEUP_PIN, &p_iop_reg->iop_data0);
> > > +	writel(iop->gpio_wakeup, &p_iop_reg->iop_data1);
> > > +
> > > +	ret = readl_poll_timeout(&p_iop_reg->iop_data2, value,
> > > +				 (value & IOP_READY) == IOP_READY, 1000, 10000);
> > > +	if (ret) {
> > > +		dev_err(dev, "timed out\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	writel(RISC_READY, &p_iop_reg->iop_data2);
> > > +	writel(0x00, &p_iop_reg->iop_data5);
> > > +	writel(0x60, &p_iop_reg->iop_data6);
> > > +
> > > +	ret = readl_poll_timeout(&p_iop_reg->iop_data7, value,
> > > +				 value == 0xaaaa, 1000, 10000);
> > > +	if (ret) {
> > > +		dev_err(dev, "timed out\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	writel(0xdd, &p_iop_reg->iop_data1);//8051 bin file call Ultra low
> > function.
> > > +	mdelay(10);
> > 
> > Where did 10 come from?  How do you know that is correct?
> > 
> 
> I need time to move stanby.bin code 16K data from SDRAM to 8051's icache.		
> 10msec should be enough		

Please document it, as it looks like the data was already sent so there
should not be any need for a delay on the Linux side.

Or do a read which will ensure that the data is there, right?

> > > +static void sp_iop_platform_driver_shutdown(struct platform_device
> > > +*pdev) {
> > > +	struct sp_iop *iop = platform_get_drvdata(pdev);
> > > +	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
> > > +	unsigned int value;
> > > +
> > > +	sp_iop_standby_mode(iop);
> > > +	mdelay(10);
> > 
> > Why sleep on shutdown?
> > 
> 
> I need time to switch from normal.bin code to standby.bin code.				

Then why does the function call not wait until that happens?  Why wait
here?

thanks,

greg k-h
