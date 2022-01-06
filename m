Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE4486329
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbiAFKuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiAFKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:50:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214B4C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 02:50:51 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h23so4004447wrc.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 02:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XVei9IKgUK16AlGJLZyT1OZS63Fg1eizPWX1XmJTn0M=;
        b=MKNMFu8IoY62W5EuWUB5wL5lTpIMjKQGmm3GMhpIqYWrwhlMms3a41/GbqTMCapjwu
         azPJuzZw5soavGdbneHO5QBjljxfEgKcTjUPbdIT08mty1E2ffgtufGxIznQNJTk+e/j
         4JgWTd4aJlRIhohZ1JNNvFX+6pad+68zNWDgkh8nHYKIwDh6kP9mDq7tgKKf2TizlxMf
         61HKqZRhdnvA1gqhN/kt2G/i6Mx6mUXsz/bFg4BLICKFrPu5tbluAp8+6kio+wbsQYVn
         CeRolOjk3p7HBW49e5R0jyuKL8kJqGB4pxk5wdnPhQRtEaxLQkOi/aqkrK8sEFBVG7oR
         k+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XVei9IKgUK16AlGJLZyT1OZS63Fg1eizPWX1XmJTn0M=;
        b=BLqUJaoLJCnm/6FEf8VX1rgudSVOo4aRj3nJcNoCiCqE9Qmp2w3LiGFsEu2adO9+2K
         EsGJPnt/GQaROtt24DTKSXsK+HWltnaWdnwVD5Ul7pYrA2deb7AaUEUHR2nvdDNfuRNu
         j3UOLxFAOF1+CKAziUB87zem9uZSCU6cGExDBrqLbkRB1Qrkb9sHhBIW6YvYgQaSaaGg
         Iw4W+rQHhbwTWh2u/kJWyh1r26BCNBY0cp+Y+lAC8yPyOvbewsZnkHFm7lf0iAV9kgxY
         B3H6zOS4tSnHar+tE2iPlIHJXKtC/ldYwjpoJ+E6D18DkHVv20fHF2Tq8rMEw87YCdXb
         GjVQ==
X-Gm-Message-State: AOAM531rg9gItQ8IbTTLaIbhFiKQksRHBTpvWYR+Qu6/Pzae2i4c9UUd
        2oVkb5fylye8/5hP7hlBs9EjRg==
X-Google-Smtp-Source: ABdhPJyVBfEz4ZzdudbWMP1+INuDfysqSeLQ+KlmnAPqr+7HevcVc6Kj/kEh/4MoPx2d3ot59agYFA==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr6678273wrp.435.1641466249425;
        Thu, 06 Jan 2022 02:50:49 -0800 (PST)
Received: from google.com ([2a00:79e0:d:209:800e:fc7:4177:c8b2])
        by smtp.gmail.com with ESMTPSA id f8sm1858410wry.16.2022.01.06.02.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 02:50:48 -0800 (PST)
Date:   Thu, 6 Jan 2022 10:50:41 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Wedson Almeida Filho <wedsonaf@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] misc: open-dice: Add driver to expose DICE data
 to userspace
Message-ID: <YdbJgf+IWnlCHQA7@google.com>
References: <20211221174502.63891-1-dbrazdil@google.com>
 <20211221174502.63891-3-dbrazdil@google.com>
 <YdXM44q07C5iQydu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdXM44q07C5iQydu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wedson,

On Wed, Jan 05, 2022 at 04:52:51PM +0000, Wedson Almeida Filho wrote:
> On Tue, Dec 21, 2021 at 05:45:02PM +0000, David Brazdil wrote:
> > Open Profile for DICE is an open protocol for measured boot compatible
> > with the Trusted Computing Group's Device Identifier Composition
> > Engine (DICE) specification. The generated Compound Device Identifier
> > (CDI) certificates represent the hardware/software combination measured
> > by DICE, and can be used for remote attestation and sealing.
> > 
> > Add a driver that exposes reserved memory regions populated by firmware
> > with DICE CDIs and exposes them to userspace via a character device.
> > 
> > Userspace obtains the memory region's size from read() and calls mmap()
> > to create a mapping of the memory region in its address space. The
> > mapping is not allowed to be write+shared, giving userspace a guarantee
> > that the data were not overwritten by another process.
> > 
> > Userspace can also call write(), which triggers a wipe of the DICE data
> > by the driver. Because both the kernel and userspace mappings use
> > write-combine semantics, all clients observe the memory as zeroed after
> > the syscall has returned.
> > 
> > Cc: Andrew Scull <ascull@google.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: David Brazdil <dbrazdil@google.com>
> > ---
> >  drivers/misc/Kconfig     |  12 +++
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/open-dice.c | 188 +++++++++++++++++++++++++++++++++++++++
> >  drivers/of/platform.c    |   1 +
> >  4 files changed, 202 insertions(+)
> >  create mode 100644 drivers/misc/open-dice.c
> > 
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 0f5a49fc7c9e..a2b26426efba 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -470,6 +470,18 @@ config HISI_HIKEY_USB
> >  	  switching between the dual-role USB-C port and the USB-A host ports
> >  	  using only one USB controller.
> >  
> > +config OPEN_DICE
> > +	tristate "Open Profile for DICE driver"
> > +	depends on OF_RESERVED_MEM
> > +	help
> > +	  This driver exposes a DICE reserved memory region to userspace via
> > +	  a character device. The memory region contains Compound Device
> > +	  Identifiers (CDIs) generated by firmware as an output of DICE
> > +	  measured boot flow. Userspace can use CDIs for remote attestation
> > +	  and sealing.
> > +
> > +	  If unsure, say N.
> > +
> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index a086197af544..70e800e9127f 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -59,3 +59,4 @@ obj-$(CONFIG_UACCE)		+= uacce/
> >  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> >  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> >  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
> > +obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> > diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
> > new file mode 100644
> > index 000000000000..f1819f951173
> > --- /dev/null
> > +++ b/drivers/misc/open-dice.c
> > @@ -0,0 +1,188 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2021 - Google LLC
> > + * Author: David Brazdil <dbrazdil@google.com>
> > + *
> > + * Driver for Open Profile for DICE.
> > + *
> > + * This driver takes ownership of a reserved memory region containing data
> > + * generated by the Open Profile for DICE measured boot protocol. The memory
> > + * contents are not interpreted by the kernel but can be mapped into a userspace
> > + * process via a misc device. Userspace can also request a wipe of the memory.
> > + *
> > + * Userspace can access the data with (w/o error handling):
> > + *
> > + *     fd = open("/dev/open-dice0", O_RDWR);
> > + *     read(fd, &size, sizeof(unsigned long));
> > + *     data = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
> > + *     write(fd, NULL, 0); // wipe
> > + *     close(fd);
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/mm.h>
> > +#include <linux/module.h>
> > +#include <linux/of_reserved_mem.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define DRIVER_NAME "open-dice"
> > +
> > +struct open_dice_drvdata {
> > +	spinlock_t lock;
> > +	char name[16];
> > +	struct reserved_mem *rmem;
> > +	struct miscdevice misc;
> > +};
> > +
> > +static inline struct open_dice_drvdata *to_open_dice_drvdata(struct file *filp)
> > +{
> > +	return container_of(filp->private_data, struct open_dice_drvdata, misc);
> > +}
> > +
> > +static int open_dice_wipe(struct open_dice_drvdata *drvdata)
> > +{
> > +	void *kaddr;
> > +
> > +	spin_lock(&drvdata->lock);
> > +	kaddr = devm_memremap(drvdata->misc.this_device, drvdata->rmem->base,
> > +			      drvdata->rmem->size, MEMREMAP_WC);
> > +	if (IS_ERR(kaddr)) {
> > +		spin_unlock(&drvdata->lock);
> > +		return PTR_ERR(kaddr);
> > +	}
> > +
> > +	memset(kaddr, 0, drvdata->rmem->size);
> > +	devm_memunmap(drvdata->misc.this_device, kaddr);
> > +	spin_unlock(&drvdata->lock);
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Copies the size of the reserved memory region to the user-provided buffer.
> > + */
> > +static ssize_t open_dice_read(struct file *filp, char __user *ptr, size_t len,
> > +			      loff_t *off)
> > +{
> > +	unsigned long val = to_open_dice_drvdata(filp)->rmem->size;
> 
> There's a UAF issue here (and in all file operations that call
> to_open_dice_drvdata) when the platform device in unbounded from the driver
> while userspace has an instance of the misc device open: after open_dice_remove
> is called, all managed resources are freed (which includes this
> open_dice_drvdata allocation).
> 
> No new miscdev files can be created, but the existing ones continue to exist
> with a now dangling pointer stored in private_data. So read/write/mmap syscalls
> from userspace will lead to dereferencing this dangling pointer.

Please correct me if I'm wrong, but I don't think this can happen
without tainting the kernel.

To call open_dice_remove, we have to remove the module. And any process
holding an FD of the misc device will increase the module's refcounter,
which is zero-checked in SYS_delete_module. The only way to get past
that check is by compiling the kernel with CONFIG_MODULE_FORCE_UNLOAD,
which changes the implementation of try_force_unload (kernel/module.c)
and adds taint. Otherwise SYS_delete_module returns an error.

Unless there is another way how to trigger this situation, I think the
existing protection is sufficient. The user cannot force the removal of
the module without agreeing to the consequences.

> > +
> > +	return simple_read_from_buffer(ptr, len, off, &val, sizeof(val));
> > +}
> > +
> > +/*
> > + * Triggers a wipe of the reserved memory region. The user-provided pointer
> > + * is never dereferenced.
> > + */
> > +static ssize_t open_dice_write(struct file *filp, const char __user *ptr,
> > +			       size_t len, loff_t *off)
> > +{
> > +	if (open_dice_wipe(to_open_dice_drvdata(filp)))
> > +		return -EIO;
> > +
> > +	/* Consume the input buffer. */
> > +	return len;
> > +}
> > +
> > +/*
> > + * Creates a mapping of the reserved memory region in user address space.
> > + */
> > +static int open_dice_mmap(struct file *filp, struct vm_area_struct *vma)
> > +{
> > +	struct open_dice_drvdata *drvdata = to_open_dice_drvdata(filp);
> > +
> > +	/* Do not allow userspace to modify the underlying data. */
> > +	if ((vma->vm_flags & VM_WRITE) && (vma->vm_flags & VM_SHARED))
> > +		return -EPERM;
> > +
> > +	/* Create write-combine mapping so all clients observe a wipe. */
> > +	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> > +	vma->vm_flags |= VM_DONTCOPY | VM_DONTDUMP;
> > +	return vm_iomap_memory(vma, drvdata->rmem->base, drvdata->rmem->size);
> > +}
> 
> Is there a reason for mapping this memory instead of, say, copying it to
> userspace via read?

The data should be treated as secret, so the idea is that avoiding
reading it in the kernel means we don't need to worry about it leakage
via the stack, etc. The reason for this is that the DICE derivation
chain may continue in userspace, so we want to minimize the chance of
a child process getting the parent secret from the kernel.

> 
> I ask because there's also a problem here related to unbind. Specifically, after
> the device is unbound (open_dice_remove is called), the driver should stop using
> the device resources. But if userspace has mapped these pages in, the resources
> are still in use despite the unbind.
> 
> So if we really want to map this to userspace, it seems like we need to keep
> track of all mappings and tear them down on remove.

Same as above, don't think this can happen without the user knowingly
shooting themselves in the foot.

> > +
> > +static const struct file_operations open_dice_fops = {
> > +	.owner = THIS_MODULE,
> > +	.read = open_dice_read,
> > +	.write = open_dice_write,
> > +	.mmap = open_dice_mmap,
> > +};
> > +
> > +static int __init open_dice_probe(struct platform_device *pdev)
> > +{
> > +	static unsigned int dev_idx;
> > +	struct device *dev = &pdev->dev;
> > +	struct reserved_mem *rmem;
> > +	struct open_dice_drvdata *drvdata;
> > +	int ret;
> > +
> > +	rmem = of_reserved_mem_lookup(dev->of_node);
> > +	if (!rmem) {
> > +		dev_err(dev, "failed to lookup reserved memory\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!rmem->size || (rmem->size > ULONG_MAX)) {
> > +		dev_err(dev, "invalid memory region size\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!PAGE_ALIGNED(rmem->base) || !PAGE_ALIGNED(rmem->size)) {
> > +		dev_err(dev, "memory region must be page-aligned\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	drvdata = devm_kmalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > +	if (!drvdata)
> > +		return -ENOMEM;
> > +
> > +	*drvdata = (struct open_dice_drvdata){
> > +		.lock = __SPIN_LOCK_UNLOCKED(drvdata->lock),
> > +		.rmem = rmem,
> > +		.misc = (struct miscdevice){
> > +			.parent	= dev,
> > +			.name	= drvdata->name,
> > +			.minor	= MISC_DYNAMIC_MINOR,
> > +			.fops	= &open_dice_fops,
> > +			.mode	= 0600,
> > +		},
> > +	};
> > +
> > +	/* Index overflow check not needed, misc_register() will fail. */
> > +	snprintf(drvdata->name, sizeof(drvdata->name), DRIVER_NAME"%u", dev_idx++);
> > +
> > +	ret = misc_register(&drvdata->misc);
> > +	if (ret) {
> > +		dev_err(dev, "failed to register misc device '%s': %d\n",
> > +			drvdata->name, ret);
> > +		return ret;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, drvdata);
> > +	return 0;
> > +}
> > +
> > +static int open_dice_remove(struct platform_device *pdev)
> > +{
> > +	struct open_dice_drvdata *drvdata = platform_get_drvdata(pdev);
> > +
> > +	misc_deregister(&drvdata->misc);
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id open_dice_of_match[] = {
> > +	{ .compatible = "google,open-dice" },
> > +	{},
> > +};
> > +
> > +static struct platform_driver open_dice_driver = {
> > +	.remove = open_dice_remove,
> > +	.driver = {
> > +		.name = DRIVER_NAME,
> > +		.of_match_table = open_dice_of_match,
> > +	},
> > +};
> > +
> > +module_platform_driver_probe(open_dice_driver, open_dice_probe);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("David Brazdil <dbrazdil@google.com>");
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index b3faf89744aa..d659ed0be342 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -514,6 +514,7 @@ static const struct of_device_id reserved_mem_matches[] = {
> >  	{ .compatible = "qcom,smem" },
> >  	{ .compatible = "ramoops" },
> >  	{ .compatible = "nvmem-rmem" },
> > +	{ .compatible = "google,open-dice" },
> >  	{}
> >  };
> >  
> > -- 
> > 2.34.1.307.g9b7440fafd-goog
> > 
