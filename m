Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169ED49D314
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiAZUFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiAZUFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:05:08 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC73AC06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:05:07 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e8so1038198wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=49Y/BwljJk3zAIQY3zADcttK6Pe5laeFXW+1JrDhUBo=;
        b=TyFtTjet79Ryk4WRM5B6H1tUy6GxHp3F2nsoMKNMzc/fWsoaESJQCVPjJ6cD+8ri56
         JB4sxRRX0O5ICtEmj3Xj43Seh/QV1fi+VA0BZipicfhbbOjfOS75Iva7W6WoHUFCZu+y
         vWILFSChFZUubQt5SZ488ayeFyxTUfbU/VVI0KQrSUBffeC/s2DhirCo2vWkBIaosuTs
         T5Vecorg/H6v7fZ2A2cPFpbSLhpzPKquLvVj3bHBE4ZK1xfbMnRX25W4+d1XR8HEsUhO
         CnXCvNAaxsCKzVVgGxD0FZMw3qtcb1LdzXr/zVCiK9FXUPlttGWOUkxvy75rNZYduVfO
         LlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=49Y/BwljJk3zAIQY3zADcttK6Pe5laeFXW+1JrDhUBo=;
        b=4Q5t5VmJDNx+nQgPtvwkPqI44jpcAiukQXj/MGqfzL8kNBt2aA/CQwgIC0t5mjbkpt
         UFAAmRW0q/LNytwr4IGIKaY7UAxvn8W9qRVh4Ft5b8hfCm45+rJJBRAMkaYGUirWi+FK
         4BH3BlT8RVKr3T9dba96sgjj4/qzVtWaewdlHXJzwhuzqUn2FXyBV+/bAWFlX8N8jP+o
         S2P8t7YGKfhiA8ZY/crUXKHU3mPTzwxYtBZAHyFSygbOVTzsFy9iWoCufVquPYVKBvGK
         6iwf6TNb7riq6kdVg1Ap9llE1xa/de8xpxwpPtwcvs93BfLjaySxRujVXPchuWa5iIkS
         FRdQ==
X-Gm-Message-State: AOAM531ehAGWGDqOi0FHQcCKbaZ61pZ1IzoxcxK2qlIGrDw5yNbVNzMC
        Wg7rari/Z0UYH3nrcWa0UopsIQ==
X-Google-Smtp-Source: ABdhPJxghGk4MNb4t/OtmOqgPuI5Xu5THHwbuGrG4knSH/m2e7LyDj+VTTcAc8Upb9K7lSiImw2FLA==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr214115wrv.44.1643227506130;
        Wed, 26 Jan 2022 12:05:06 -0800 (PST)
Received: from google.com ([2a00:79e0:d:209:bd2e:4d3b:b065:fa46])
        by smtp.gmail.com with ESMTPSA id u7sm173104wmc.11.2022.01.26.12.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:05:05 -0800 (PST)
Date:   Wed, 26 Jan 2022 20:05:00 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Wedson Almeida Filho <wedsonaf@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 2/2] misc: open-dice: Add driver to expose DICE data
 to userspace
Message-ID: <YfGpbADWzIZXuyJL@google.com>
References: <20220104100645.1810028-1-dbrazdil@google.com>
 <20220104100645.1810028-3-dbrazdil@google.com>
 <Yd4Tl2FoKnwziN8K@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd4Tl2FoKnwziN8K@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wedson,
Sorry for the late reply, and thanks for the in-depth review.

On Tue, Jan 11, 2022 at 11:32:39PM +0000, Wedson Almeida Filho wrote:
> Hey David,
> 
> Following up here on v6.
> 
> On Tue, Jan 04, 2022 at 10:06:45AM +0000, David Brazdil wrote:
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
> > Acked-by: Rob Herring <robh@kernel.org>
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
> 
> What's the plan here if devm_memremap sleeps while you're holding the spinlock?

Good catch. devm_memremap can indeed sleep. I'll convert the lock to a mutex.

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
> 
> I think we need to clear VM_MAYWRITE here too, otherwise what prevents a user
> (that opened the file for write as well) from later adding VM_WRITE to the vma
> by calling mprotect?

Indeed. WRITE^SHARED is not an issue, but we need to make sure they are
never combined. And as you point out, mprotect or mremap can change the
flags later. I'll address this in v7. Thanks.

> > +	return vm_iomap_memory(vma, drvdata->rmem->base, drvdata->rmem->size);
> > +}
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
> 
> As we discussed before, this should never be called, right? If it does, users
> can trigger UAF. Should we call BUG or WARN here?

Not quite. This can be legitimately called when the refcount drops to
zero (ie. all FDs are closed). There is a config that allows this to be
called even with active FDs but that operation will taint the kernel.
So no BUG or WARN here.

David
