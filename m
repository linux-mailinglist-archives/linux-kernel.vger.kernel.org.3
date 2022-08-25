Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488395A0A50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiHYHcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbiHYHcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:32:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8E79F741
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F9EE61A69
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A01EC433D7;
        Thu, 25 Aug 2022 07:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661412724;
        bh=FiL60/86mac5VMwiHDVcDqr+ZIb2k7YFNfNtPTmkyGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rb+jpJUaK1umjno+0aOqKPbZZConW+ljAxOfNDCoNzcRUuNj92q1uNiuwj0PziXhF
         FyfuyQLzRovMzK0Fp3uamdDcVyBouxpMYCZyH4EA7G1V4qolLdcj4VRr2c61gvwGza
         ry6rFpqlflZIPMgJOhv2KkNMNj4jWspd2hydl7cU=
Date:   Thu, 25 Aug 2022 09:32:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Czerwacki, Eial" <eial.czerwacki@sap.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Message-ID: <YwclcEJDf/POuHw5@kroah.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 06:24:02AM +0000, Czerwacki, Eial wrote:
> Introducing the vSMP guest driver which allows interaction with the
> vSMP control device when running a Linux OS atop of the vSMP hypervisor.
> vSMP is a resource aggregation hypervisor from SAP.
> 
> The driver comprises of api part which facilitates communication with
> the hypervisor and version which displays the hypervisor's version.
> 
> This patch s based on previous patches sent to the staging tree mailing
> lists
> 
> Signed-off-by: Eial Czerwacki <eial.czerwacki@sap.com>
> Acked-by: Leonid Arsh <leonid.arsh@sap.com>
> Acked-by: Oren Twaig <oren.twaig@sap.com>
> CC: SAP vSMP Linux Maintainer <linux.vsmp@sap.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Dan Carpenter <dan.carpenter@oracle.com>
> CC: Andra Paraschiv <andraprs@amazon.com>
> CC: Borislav Petkov <bp@suse.de>
> CC: Brijesh Singh <brijesh.singh@amd.com>
> CC: Eric Biggers <ebiggers@google.com>
> CC: Fei Li <fei1.li@intel.com>
> CC: Hans de Goede <hdegoede@redhat.com>
> CC: Jens Axboe <axboe@kernel.dk>
> CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> v1 -> v2:
> 	- fix -0 var init in add_sysfs_entries (pointed out by Dan Carpenter)
> ---
>  Documentation/ABI/stable/sysfs-driver-vsmp |   5 +
>  MAINTAINERS                                |   6 +
>  drivers/virt/Kconfig                       |   2 +
>  drivers/virt/Makefile                      |   2 +
>  drivers/virt/vsmp/Kconfig                  |  11 +
>  drivers/virt/vsmp/Makefile                 |   7 +
>  drivers/virt/vsmp/api/api.c                | 249 +++++++++++++++++++++
>  drivers/virt/vsmp/api/api.h                |  69 ++++++
>  drivers/virt/vsmp/include/registers.h      |  12 +
>  drivers/virt/vsmp/version/version.c        | 118 ++++++++++
>  drivers/virt/vsmp/version/version.h        |  14 ++
>  drivers/virt/vsmp/vsmp_main.c              | 110 +++++++++
>  12 files changed, 605 insertions(+)

Why do you have all of these different .c and .h files for only 600
lines of code?  Shouldn't this all just be in a single .c file?  Why
have a subdir for just 300 lines?

Please mush this all into a single .c file going forward, speading it
out like this makes no sense.

>  create mode 100644 Documentation/ABI/stable/sysfs-driver-vsmp
>  create mode 100644 drivers/virt/vsmp/Kconfig
>  create mode 100644 drivers/virt/vsmp/Makefile
>  create mode 100644 drivers/virt/vsmp/api/api.c
>  create mode 100644 drivers/virt/vsmp/api/api.h
>  create mode 100644 drivers/virt/vsmp/include/registers.h
>  create mode 100644 drivers/virt/vsmp/version/version.c
>  create mode 100644 drivers/virt/vsmp/version/version.h
>  create mode 100644 drivers/virt/vsmp/vsmp_main.c
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-vsmp b/Documentation/ABI/stable/sysfs-driver-vsmp
> new file mode 100644
> index 000000000000..18a0a62f40ed
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-driver-vsmp
> @@ -0,0 +1,5 @@
> +What:           /sys/hypervisor/vsmp/version
> +Date:           Aug 2022

August is almost over :(

> +Contact:        Eial Czerwacki <eial.czerwacki@sap.com>
> +		linux-vsmp@sap.com

No need for an alias here.

> +Description:    Shows the full version of the vSMP hypervisor

That's not very descriptive, what is this supposed to look like?


> diff --git a/MAINTAINERS b/MAINTAINERS
> index f512b430c7cb..cf74089c4d19 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21783,6 +21783,12 @@ F:	lib/test_printf.c
>  F:	lib/test_scanf.c
>  F:	lib/vsprintf.c
> 
> +VSMP GUEST DRIVER
> +M:	Eial Czerwacki <eial.czerwacki@sap.com>
> +M:	linux-vsmp@sap.com

Again, no random aliases please, stick to a person as a contact.

> +S:	Maintained
> +F:	drivers/virt/vsmp
> +
>  VT1211 HARDWARE MONITOR DRIVER
>  M:	Juerg Haefliger <juergh@gmail.com>
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 87ef258cec64..9f283f476674 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -52,4 +52,6 @@ source "drivers/virt/coco/efi_secret/Kconfig"
> 
>  source "drivers/virt/coco/sev-guest/Kconfig"
> 
> +source "drivers/virt/vsmp/Kconfig"
> +
>  endif
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index 093674e05c40..159ba37cb471 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -11,3 +11,5 @@ obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
>  obj-$(CONFIG_ACRN_HSM)		+= acrn/
>  obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
>  obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
> +
> +obj-$(CONFIG_VSMP)             += vsmp/

Why a blank line?

> diff --git a/drivers/virt/vsmp/Kconfig b/drivers/virt/vsmp/Kconfig
> new file mode 100644
> index 000000000000..4e1d7e0dc746
> --- /dev/null
> +++ b/drivers/virt/vsmp/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config VSMP
> +	tristate "vSMP Guest Support"
> +	depends on SYS_HYPERVISOR && X86_64 && PCI
> +	help
> +	  Support for vSMP Guest Driver.
> +
> +	  This driver allows information gathering of data from the vSMP hypervisor when
> +	  running on top of a vSMP-based hypervisor.
> +
> +	  If unsure, say no.

No module name information?


> diff --git a/drivers/virt/vsmp/Makefile b/drivers/virt/vsmp/Makefile
> new file mode 100644
> index 000000000000..f637097e19f2
> --- /dev/null
> +++ b/drivers/virt/vsmp/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for vSMP Guest drivers
> +#
> +
> +obj-$(CONFIG_VSMP) = vsmp.o
> +vsmp-y := vsmp_main.o api/api.o version/version.o
> diff --git a/drivers/virt/vsmp/api/api.c b/drivers/virt/vsmp/api/api.c
> new file mode 100644
> index 000000000000..6e40935907bc
> --- /dev/null
> +++ b/drivers/virt/vsmp/api/api.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * vSMP driver api

"driver api?"  What is that?

> + * (C) Copyright 2022 SAP SE
> + */
> +
> +#include "api.h"
> +
> +static void __iomem *cfg_addr;
> +static struct kobject *vsmp_sysfs_kobj;
> +static struct pci_dev *vsmp_dev_obj;

Do not make it so that you can only have one device in the system like
this.  Make it dynamic and properly tie into the driver model and then
you will have no such restrictions at all.

> +
> +/* R/W ops handlers */

I do not understand this comment at all, which is not a good sign...

> +
> +/*
> + * Init a vsmp firmware operation object
> + */
> +int vsmp_init_op(struct fw_ops *op, ssize_t max_size,
> +		 enum vsmp_fw_action action)
> +{
> +	op->hwi_block_size = max_size;
> +	op->action = action;
> +	op->buff_offset = op->hwi_block_size;
> +
> +	op->buff = kzalloc(op->hwi_block_size, GFP_KERNEL);
> +	if (!op->buff)
> +		return -ENOMEM;
> +
> +	vsmp_reset_op(op);
> +
> +	return 0;
> +}
> +
> +/*
> + * Release an vsmp firmware operation object
> + */
> +void vsmp_release_op(struct fw_ops *op)

Why are all of these global symbols?

If you put it all into one .c file, it's much easier.

> +{
> +	if (!op) {
> +		WARN_ON(!op);
> +		return;
> +	}
> +
> +	if (!op->buff) {
> +		WARN_ON(!op->buff);
> +		return;
> +	}
> +
> +	kfree(op->buff);
> +	memset(op, 0, sizeof(*op));
> +}
> +
> +/*
> + * Reset a vsmp firmware operation object
> + */
> +void vsmp_reset_op(struct fw_ops *op)
> +{
> +	memset(op->buff, 0, op->hwi_block_size);
> +	op->buff_offset = op->hwi_block_size;
> +}
> +
> +/* Regs/Buffs R/W handlers */
> +
> +/*
> + * Read a value from a specific register in the vSMP's device config space
> + */
> +u64 vsmp_read_reg_from_cfg(u64 reg, enum reg_size_type type)
> +{
> +	u64 ret_val;
> +
> +	switch (type) {
> +	case VSMP_CTL_REG_SIZE_8BIT:
> +		ret_val = readb(cfg_addr + reg);
> +		break;
> +
> +	case VSMP_CTL_REG_SIZE_16BIT:
> +		ret_val = readw(cfg_addr + reg);
> +		break;
> +
> +	case VSMP_CTL_REG_SIZE_32BIT:
> +		ret_val = readl(cfg_addr + reg);
> +		break;
> +
> +	case VSMP_CTL_REG_SIZE_64BIT:
> +		ret_val = readq(cfg_addr + reg);
> +		break;
> +
> +	default:
> +		dev_err(get_dev(), "Unsupported reg size type %d.\n", type);
> +		ret_val = (u64) -EINVAL;
> +	}
> +
> +	dev_dbg(get_dev(), "%s: read 0x%llx from reg 0x%llx of %d bits\n",
> +		__func__, ret_val, reg, (type + 1) * 8);
> +	return ret_val;
> +}
> +
> +/*
> + * Read a buffer from the bar byte by byte for halt on
> + * null termination.
> + * Expected buffs are strings.
> + */
> +static ssize_t read_buff_from_bar_in_bytes(char *out, u8 __iomem *buff, ssize_t len)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < len; i++) {
> +		out[i] = ioread8(&buff[i]);
> +		if (!out[i])
> +			break;

So even if there is a failure here (0?), you return success?

> +	}
> +
> +	return i;
> +}
> +
> +/*
> + * Read a buffer from a specific offset in a specific bar,
> + * maxed to a predefined len size-wise from the vSMP device
> + */
> +int vsmp_read_buff_from_bar(u8 bar, u32 offset, char *out, ssize_t len,
> +			    bool halt_on_null)
> +{
> +	u8 __iomem *buff;
> +	u64 bar_start = pci_resource_start(vsmp_dev_obj, bar);
> +	u32 bar_len = pci_resource_len(vsmp_dev_obj, bar);
> +	ssize_t actual_len = len;
> +
> +	/* incase of overflow, warn and use max len possible */
> +	if ((offset + len) > bar_len) {
> +		WARN_ON((offset + len) > actual_len);

Please no new WARN_ON, just handl the error properly and recover from
it.

> +		actual_len = bar_len - offset;
> +		dev_dbg(get_dev(), "%lu overflows bar len, using %ld len instead\n",

get_dev() is not a good function name for the global symbol space at
all.  Just pass in your device (hint, you have it here already), and use
that.

> +			len, actual_len);
> +	}
> +
> +	buff = ioremap(bar_start + offset, actual_len);
> +	if (!buff)
> +		return -ENOMEM;
> +
> +	if (halt_on_null)
> +		read_buff_from_bar_in_bytes(out, buff, len);
> +	else
> +		memcpy_fromio(out, buff, len);
> +
> +	iounmap(buff);
> +
> +	return 0;
> +}
> +
> +/*
> + * Generic function to read from the bar
> + */
> +ssize_t vsmp_generic_buff_read(struct fw_ops *op, u8 bar, u64 reg,
> +			       char *buf, loff_t off, ssize_t count)
> +{
> +	ssize_t ret_val = 0;
> +
> +	if (op->buff_offset >= op->hwi_block_size) {	/* perform H/W op */
> +		vsmp_reset_op(op);
> +
> +		ret_val = vsmp_read_buff_from_bar(bar, reg, op->buff, op->hwi_block_size, false);
> +		if (ret_val) {
> +			dev_err(get_dev(), "%s operation failed\n",
> +				(op->action == FW_READ) ? "read" : "write");
> +		}
> +		op->buff_offset = 0;
> +	}
> +
> +	if (ret_val)
> +		return ret_val;
> +
> +	return memory_read_from_buffer(buf, count, &op->buff_offset, op->buff, op->hwi_block_size);
> +}
> +
> +/* sysfs handlers */
> +
> +/*
> + * Register the vSMP sysfs object for user space interaction
> + */
> +int vsmp_register_sysfs_group(const struct bin_attribute *bin_attr)
> +{
> +	int error = -EINVAL;
> +
> +	if (vsmp_sysfs_kobj && bin_attr) {
> +		error = sysfs_create_bin_file(vsmp_sysfs_kobj, bin_attr);

You raced userspace and lost :(

And why is your version file a binary file?  It should just be a small
text string, right?

> +		if (error)
> +			dev_err(get_dev(), "Failed to register sysfs entry (%d)\n", error);
> +	}
> +
> +	return error;
> +}
> +
> +/*
> + * Deregister the vSMP sysfs object for user space interaction
> + */
> +void vsmp_deregister_sysfs_group(const struct bin_attribute *bin_attr)
> +{
> +	if (vsmp_sysfs_kobj && bin_attr)
> +		sysfs_remove_bin_file(vsmp_sysfs_kobj, bin_attr);
> +}

Why all the indirection here?  Once you clean this up to be in one file,
it will be much smaller as you will not need this middle layer at all.

> +
> +/* Generic functions */
> +
> +/*
> + * Open the cfg address space of the vSDP device
> + */
> +int open_cfg_addr(struct pci_dev *pdev)
> +{
> +	u64 cfg_start;
> +	u32 cfg_len;
> +
> +	vsmp_dev_obj = pdev;
> +	cfg_start = pci_resource_start(vsmp_dev_obj, 0);
> +	cfg_len = pci_resource_len(vsmp_dev_obj, 0);
> +
> +	dev_dbg(get_dev(), "Mapping bar 0: [0x%llx,0x%llx]\n",
> +		cfg_start, cfg_start + cfg_len);

Again, you have a device, use that.  Goes for the whole driver.

> +#define FILE_PREM 0444

File permission of what?  And shouldn't it be "PERM", not "PREM"?  And
why do you need it at all?  Just use the proper sysfs macros and you
never need it.  See below.

> +
> +/* Regs/Buffs R/W handlers */
> +#define vsmp_read_reg32_from_cfg(_reg_) \
> +	((u32) vsmp_read_reg_from_cfg((_reg_), VSMP_CTL_REG_SIZE_32BIT))
> +
> +u64 vsmp_read_reg_from_cfg(u64 reg, enum reg_size_type type);
> +ssize_t vsmp_generic_buff_read(struct fw_ops *op, u8 bar, u64 reg,
> +			       char *buf, loff_t off, ssize_t count);
> +int vsmp_read_buff_from_bar(u8 bar, u32 offset, char *out, ssize_t len,
> +			    bool halt_on_null);
> +
> +typedef int (*sysfs_register_cb)(void);
> +typedef void (*sysfs_deregister_cb)(void);
> +
> +struct sysfs_entry_cbs {
> +	sysfs_register_cb reg_cb;
> +	sysfs_deregister_cb dereg_cb;
> +};
> +
> +int vsmp_register_sysfs_group(const struct bin_attribute *bin_attr);
> +void vsmp_deregister_sysfs_group(const struct bin_attribute *bin_attr);
> +
> +int open_cfg_addr(struct pci_dev *pdev);
> +int init_sysfs(void);
> +void cleanup(void);
> +const struct device *get_dev(void);
> +#endif /* VSMP_API_H */
> diff --git a/drivers/virt/vsmp/include/registers.h b/drivers/virt/vsmp/include/registers.h
> new file mode 100644
> index 000000000000..b6458d25e3b7
> --- /dev/null
> +++ b/drivers/virt/vsmp/include/registers.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * vSMP driver registers
> + * (C) Copyright 2022 SAP SE
> + */
> +
> +#ifndef VSMP_REGSITERS_H
> +#define VSMP_REGSITERS_H
> +
> +#define VSMP_VERSION_REG 0x0c
> +
> +#endif /* VSMP_REGSITERS_H */

Smallest .h file ever.   12 lines for a single #define, please don't do
that.


> diff --git a/drivers/virt/vsmp/version/version.c b/drivers/virt/vsmp/version/version.c
> new file mode 100644
> index 000000000000..d8ad771daf28
> --- /dev/null
> +++ b/drivers/virt/vsmp/version/version.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * vSMP driver version module
> + * (C) Copyright 2022 SAP SE
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/kobject.h>
> +
> +#include "../api/api.h"
> +#include "../include/registers.h"
> +
> +/*
> + * This is the maximal possible length of the version which is a text string
> + * the real len is usually much smaller, thus the driver uses this once to read
> + * the version string and record it's actual len.
> + * From that point and on, the actual len will be used in each call.
> + */
> +#define VERSION_MAX_LEN (1 << 19)
> +
> +static struct fw_ops op;
> +
> +static ssize_t version_read(struct file *filp, struct kobject *kobj,
> +			    struct bin_attribute *bin_attr,
> +			    char *buf, loff_t off, size_t count)
> +{
> +	u64 reg_val = vsmp_read_reg32_from_cfg(VSMP_VERSION_REG);
> +	ssize_t ret_val;
> +
> +	if (reg_val < 0) {
> +		dev_err(get_dev(), "Failed to value of reg 0x%x\n", VSMP_VERSION_REG);
> +		return 0;
> +	}
> +
> +	ret_val = vsmp_generic_buff_read(&op, 0, reg_val, buf, off, count);
> +	if (ret_val < 0) {
> +		dev_err(get_dev(), "Failed to read version (%ld)\n", ret_val);
> +		return 0;
> +	}
> +
> +	buf[ret_val++] = '\n';
> +
> +	return ret_val;
> +}
> +
> +struct bin_attribute version_raw_attr = __BIN_ATTR(version, FILE_PREM,
> +						   version_read, NULL, VERSION_MAX_LEN);

__BIN_ATTR_RO()?

But again, why is this a binary file?

I stopped reviewing here.  Please clean up all of the above first, and
then the rest of the file will be smaller and easier to review.

thanks,

greg k-h
