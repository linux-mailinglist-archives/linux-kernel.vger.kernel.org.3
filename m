Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398F946EB44
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbhLIPff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhLIPfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:35:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03ECC061746;
        Thu,  9 Dec 2021 07:32:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 26920CE263B;
        Thu,  9 Dec 2021 15:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5A4C341C7;
        Thu,  9 Dec 2021 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639063916;
        bh=XJZ9cwEeYKby397oPMzkS4mNndByzjaGPBQj8+qFo0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVc4nepasWXyOe5r5l4I8q0dyJmQkzV7ZNeTpm2VbwRNM+vFQ+zRrfqfIKjFo/Znj
         Xzv+hwRky65m+rMiqHyN3vNuK85kFLD5SlYJXa1KQmT9hL+jCRC35EyQ+4WzTE7QPH
         YShIEsfw8mx67Tobn231iT+gPvDNFfmsUBqjUob0=
Date:   Thu, 9 Dec 2021 16:31:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/2] misc: dice: Add driver to forward secrets to
 userspace
Message-ID: <YbIhaWC8b2DV5C7Y@kroah.com>
References: <20211209151123.3759999-1-dbrazdil@google.com>
 <20211209151123.3759999-3-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209151123.3759999-3-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 03:11:23PM +0000, David Brazdil wrote:
> Open Profile for DICE is a protocol for deriving unique secrets at boot
> used by some Android devices. The firmware/bootloader hands over secrets
> in a reserved memory region, which this driver takes ownership of and
> exposes it to userspace via a misc device.
> 
> Userspace obtains the region's size using an ioctl and mmaps the memory
> to its address space. This mapping cannot be write+shared, giving
> userspace a guarantee that the secrets have not been overwritten by
> another process.
> 
> Userspace can also issue an ioctl requesting that the memory be wiped by
> the driver. Because both the kernel and userspace mappings use
> write-combine semantics, all clients will observe the memory as zeroed
> after the ioctl has returned.
> 
> Cc: Andrew Scull <ascull@google.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  drivers/misc/Kconfig                          |   8 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/dice.c                           | 161 ++++++++++++++++++

Nice, almost 100 lines shorter than before!

Much better, thanks for the changes, but it can be made simpler, see
comments below:

>  include/uapi/linux/dice.h                     |  14 ++
>  5 files changed, 185 insertions(+)
>  create mode 100644 drivers/misc/dice.c
>  create mode 100644 include/uapi/linux/dice.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index cfe6cccf0f44..4b8bee2ffd1e 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -341,6 +341,7 @@ Code  Seq#    Include File                                           Comments
>  0xAE  40-FF  linux/kvm.h                                             Kernel-based Virtual Machine
>                                                                       <mailto:kvm@vger.kernel.org>
>  0xAE  20-3F  linux/nitro_enclaves.h                                  Nitro Enclaves
> +0xAE  40-5F  uapi/linux/dice.h                                       Open Profile for DICE driver

Why the huge range?  You are only really using 40 and 41.  Stick to that
please.

>  0xAF  00-1F  linux/fsl_hypervisor.h                                  Freescale hypervisor
>  0xB0  all                                                            RATIO devices in development:
>                                                                       <mailto:vgo@ratio.de>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 0f5a49fc7c9e..7165f4b6c41b 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -470,6 +470,14 @@ config HISI_HIKEY_USB
>  	  switching between the dual-role USB-C port and the USB-A host ports
>  	  using only one USB controller.
> 
> +config DICE
> +	tristate "Open Profile for DICE driver"
> +	depends on OF_RESERVED_MEM
> +	help
> +	  This driver allows to ownership of a reserved memory region
> +	  containing DICE secrets and expose them to userspace via
> +	  a character device.

What is the module name, please add that here.

And "dice" is a very generic name.  I don't mind, but if you want to
name it a bit more specific, that might be better.

> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index a086197af544..f73c6bb23ccd 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -59,3 +59,4 @@ obj-$(CONFIG_UACCE)		+= uacce/
>  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
> +obj-$(CONFIG_DICE)		+= dice.o
> diff --git a/drivers/misc/dice.c b/drivers/misc/dice.c
> new file mode 100644
> index 000000000000..06f3754feb71
> --- /dev/null
> +++ b/drivers/misc/dice.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 - Google LLC
> + * Author: David Brazdil <dbrazdil@google.com>
> + *
> + * Driver for Open Profile for DICE.
> + *
> + * This driver takes ownership of a reserved memory region containing secrets
> + * derived following the Open Profile for DICE. The contents of the memory
> + * region are not interpreted by the kernel but can be mapped into a userspace
> + * process via a misc device. The memory region can also be wiped, removing
> + * the secrets from memory.
> + *
> + * Userspace can access the data by (w/o error handling):
> + *
> + *     int fd = open("/dev/dice", O_RDONLY | O_CLOEXEC);
> + *     size_t size = ioctl(fd, DICE_GET_SIZE);
> + *     void *data = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
> + *     ioctl(fd, DICE_WIPE);
> + *     close(fd);
> + */
> +
> +#include <linux/dice.h>
> +#include <linux/io.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +
> +static int dice_mmap(struct file *filp, struct vm_area_struct *vma);
> +static long dice_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> +
> +static const struct file_operations dice_fops = {
> +	.mmap = dice_mmap,
> +	.unlocked_ioctl = dice_ioctl,
> +};
> +
> +static struct miscdevice dice_misc = {
> +	.name	= "dice",
> +	.minor	= MISC_DYNAMIC_MINOR,
> +	.fops	= &dice_fops,
> +	.mode	= 0400,
> +};
> +
> +static struct reserved_mem *dice_rmem;
> +static DEFINE_SPINLOCK(dice_lock);

These should be per-device, not global, right?  Please put them in a
local structure that lives off of the platform device.  Then everything
is dynamic and nothing is static making it all much simpler again.

Do that and you can get rid of the pre-definitions of dice_mmap() and
dice_ioctl() above as well.

> +
> +static int dice_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	/* Do not allow userspace to modify the underlying data. */
> +	if ((vma->vm_flags & VM_WRITE) && (vma->vm_flags & VM_SHARED))
> +		return -EPERM;
> +
> +	/* Create write-combine mapping so all clients observe a wipe. */
> +	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> +	vma->vm_flags |= VM_DONTCOPY | VM_DONTDUMP;
> +	return vm_iomap_memory(vma, dice_rmem->base, dice_rmem->size);
> +}
> +
> +static int dice_wipe(void)
> +{
> +	void *kaddr;
> +
> +	spin_lock(&dice_lock);
> +	kaddr = devm_memremap(dice_misc.this_device, dice_rmem->base,
> +			      dice_rmem->size, MEMREMAP_WC);
> +	if (IS_ERR(kaddr)) {
> +		spin_unlock(&dice_lock);
> +		return PTR_ERR(kaddr);
> +	}
> +
> +	memzero_explicit(kaddr, dice_rmem->size);
> +	devm_memunmap(dice_misc.this_device, kaddr);

Do you really need to call memzero_explicit()?  This isn't "local"
memory, if the compiler "optimizes away" a normal call, it would be
_VERY_ broken.

> +	spin_unlock(&dice_lock);
> +	return 0;
> +}
> +
> +static long dice_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case DICE_GET_SIZE:
> +		/* Checked against INT_MAX in dice_probe(). */
> +		return dice_rmem->size;
> +	case DICE_WIPE:
> +		return dice_wipe();
> +	}
> +
> +	return -ENOIOCTLCMD;

-ENOTTY please.

As you only have 2 ioctls, why not just use read/write for this?  Write
would cause dice_wipe() to happen, and read would return the size in the
buffer provided.  Then no ioctl is needed at all.

> +}
> +
> +static int __init dice_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *rmem_np;
> +	struct reserved_mem *rmem;
> +	int ret;
> +
> +	if (dice_rmem) {
> +		dev_err(dev, "only one instance of device allowed\n");

Why?  That's a device-specific thing, not a driver-specific thing.  Make
this all dynamic and you don't need to care about it at all.

Again, simplification :)

thanks,

greg k-h
