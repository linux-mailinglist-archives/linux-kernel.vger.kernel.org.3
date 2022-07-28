Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8F05839DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiG1HyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiG1HyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:54:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264B161B14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6DCC61B57
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0445C433C1;
        Thu, 28 Jul 2022 07:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658994841;
        bh=btrG/stEQP6kjiiiSezM1P0lfOfaD4LakKJmLxAZz8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yuxn4HlVoBO5ff6oVtWCyPxuEzvHEMol48ZK+SRGR7fjh27bkSrJ3RZ1X5H2TQDVN
         Hb1huYB/4y2YgD1mKdnc2n6tn22H4r1QhX9XQzj/OW6jXCf0GMBHTABmp0kFyu51IU
         1RJ8h7S/1b5JUr3EAxUM7LmnkzaBf04OBQqnBI/I=
Date:   Thu, 28 Jul 2022 09:53:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Zhou@kroah.com,
        Furong <furong.zhou@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/3] drivers: misc: intel_sysid: Add sysid from arch
 to drivers
Message-ID: <YuJAll2MEgKF0MVM@kroah.com>
References: <20220721123017.416438-1-kah.jing.lee@intel.com>
 <20220721123149.416618-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721123149.416618-1-kah.jing.lee@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 08:31:50PM +0800, kah.jing.lee@intel.com wrote:
> From: Kah Jing Lee <kah.jing.lee@intel.com>
> 
> Add new sysid driver. The Altera(Intel) Sysid component is generally part
> of an FPGA design. The component can be hotplugged when the FPGA is
> reconfigured. This driver support the component being hotplugged.
> The sysid driver stores unique 32-bit id value which is similar to a
> check-sum value; different components, different configuration options,
> or both, can be configured to produce different id values. Timestamp field
> is the unique 32-bit value that is based on the system generation time.
> 
> There are two basic ways to use the system ID core:
> - Verify the system ID before downloading new software to a system. This
> method can be used by software development tools, before downloading a
> program to a target hardware system, if the program is compiled for
> different hardware.
> 
> - Check system ID after reset. If a program is running on hardware other
> than the expected Platform Designer system, the program may fail to
> function altogether. If the program does not crash, it can behave
> erroneously in subtle ways that are difficult to debug. To protect against
> this case, a program can compare the expected system ID against the system
> ID core, and report an error if they do not match.
> 
> Usage:
>   cat /sys/bus/platform/devices/soc:base_fpga_region/
> 		soc:base_fpga_region:fpga_pr_region0/[addr.sysid]/sysid/id
>   cat /sys/bus/platform/devices/soc:base_fpga_region/
> 		soc:base_fpga_region:fpga_pr_region0/[addr.sysid]/sysid/buildtime
> 
> Based on an initial contribution from Ley Foon Tan at Altera
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> Reviewed-by: Zhou, Furong <furong.zhou@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
> v2:
> - Updated license header, commit message and author since original author
> no longer here
> - Updated driver description
> - Removed redundant word in Kconfig
> - Updated timestamp function, renamed timestamp -> buildtime due to programmed
>   time during design generation instead of real-time timestamp reading
> - Updated Kconfig description
> - Updated sysfs add to devm_add_group
> - Add the Documentation/ABI/testing file
> - Updated header and newline formatting
> ---
> ---
>  drivers/misc/Kconfig       |   9 +++
>  drivers/misc/Makefile      |   1 +
>  drivers/misc/intel_sysid.c | 114 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+)
>  create mode 100644 drivers/misc/intel_sysid.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41d2bb0ae23a..30cf36916593 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -483,6 +483,15 @@ config OPEN_DICE
>  
>  	  If unsure, say N.
>  
> +config INTEL_SYSID
> +	tristate "Intel System ID"
> +	help
> +	  This enables the Intel System ID driver for a soft core.
> +	  Say Y here if you want to build a driver for Intel System ID.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called intel_sysid. If unsure, say N here.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 70e800e9127f..301c854b4cd3 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_PCH_PHUB)		+= pch_phub.o
>  obj-y				+= ti-st/
>  obj-y				+= lis3lv02d/
>  obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
> +obj-$(CONFIG_INTEL_SYSID)	+= intel_sysid.o
>  obj-$(CONFIG_INTEL_MEI)		+= mei/
>  obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
>  obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
> diff --git a/drivers/misc/intel_sysid.c b/drivers/misc/intel_sysid.c
> new file mode 100644
> index 000000000000..b63dbde63347
> --- /dev/null
> +++ b/drivers/misc/intel_sysid.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022, Intel Corporation.
> + * Copyright (C) 2013-2015, Altera Corporation.
> + *
> + * Ley Foon Tan <lftan@altera.com>
> + * Kah Jing Lee <kah.jing.lee@intel.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define DRV_NAME	"intel_sysid"

KBUILD_MODNAME?

> +
> +struct intel_sysid {
> +	void __iomem		*regs;
> +};
> +
> +/* System ID Registers*/
> +#define SYSID_REG_ID		0x0
> +#define SYSID_REG_TIMESTAMP	0x4
> +
> +static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct intel_sysid *sysid = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", readl(sysid->regs + SYSID_REG_ID));

sysfs_emit() please.

> +}
> +
> +static void convert_readable_timestamp(struct tm *buildtime)
> +{
> +	buildtime->tm_year += 1900;
> +	buildtime->tm_mon += 1;
> +}
> +
> +static ssize_t buildtime_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	unsigned int reg;
> +	struct tm buildtime;
> +	struct intel_sysid *sysid = dev_get_drvdata(dev);
> +
> +	reg = readl(sysid->regs + SYSID_REG_TIMESTAMP);
> +	time64_to_tm(reg, 0, &buildtime);
> +	convert_readable_timestamp(&buildtime);
> +
> +	return sprintf(buf, "%u (%u-%u-%u %u:%u:%u UTC)\n", reg,
> +		(unsigned int)(buildtime.tm_year),
> +		buildtime.tm_mon, buildtime.tm_mday, buildtime.tm_hour,
> +		buildtime.tm_min, buildtime.tm_sec);

As said in the documentation review, use a standard format, do not make
up a new one.

> +}
> +
> +static DEVICE_ATTR_RO(id);
> +static DEVICE_ATTR_RO(buildtime);
> +
> +static struct attribute *intel_sysid_attrs[] = {
> +	&dev_attr_id.attr,
> +	&dev_attr_buildtime.attr,
> +	NULL
> +};
> +
> +struct attribute_group intel_sysid_attr_group = {
> +	.name = "sysid",
> +	.attrs = intel_sysid_attrs,
> +};
> +
> +static int intel_sysid_probe(struct platform_device *pdev)
> +{
> +	struct intel_sysid *sysid;
> +	struct resource	*regs;
> +
> +	sysid = devm_kzalloc(&pdev->dev, sizeof(struct intel_sysid),
> +		GFP_KERNEL);
> +	if (!sysid)
> +		return -ENOMEM;
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!regs)
> +		return -ENXIO;
> +
> +	sysid->regs = devm_ioremap_resource(&pdev->dev, regs);
> +	if (IS_ERR(sysid->regs))
> +		return PTR_ERR(sysid->regs);
> +
> +	platform_set_drvdata(pdev, sysid);
> +
> +	return devm_device_add_group(&pdev->dev, &intel_sysid_attr_group);

You just raced with userspace and lost.  Please use the default group
for the platform device.

I need to go remove this function, it should not be used at all as it is
broken.

thanks,

greg k-h
