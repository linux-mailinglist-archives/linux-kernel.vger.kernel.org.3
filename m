Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845234863BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 12:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbiAFL3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 06:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbiAFL3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 06:29:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF73BC061245;
        Thu,  6 Jan 2022 03:29:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C8BEB8205A;
        Thu,  6 Jan 2022 11:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A615C36AE3;
        Thu,  6 Jan 2022 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641468558;
        bh=FcZua+aNXaFqpp8MaJDMuQfdeTyCogtMbUWO9tRVvvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DG4tyBgxFSfy/+f7xiaSYYi/wDCcX19LqQhsOGDJHA1sdty9U0zMGHt1OQ6pRl4uO
         Lisq6/3jSf+mo+tHSu0D7gjojSD5p6R14Y/iBrxMQahdWVAkY+Ghyc0OCrlq9FMowu
         iVBfuyvybFeob82Ft8E2ULdvB3tUdwDZ/vq+uS8c=
Date:   Thu, 6 Jan 2022 12:29:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Wedson Almeida Filho <wedsonaf@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] misc: open-dice: Add driver to expose DICE data
 to userspace
Message-ID: <YdbSi+ANXw1JRkUj@kroah.com>
References: <20211221174502.63891-1-dbrazdil@google.com>
 <20211221174502.63891-3-dbrazdil@google.com>
 <YdXM44q07C5iQydu@google.com>
 <YdbJgf+IWnlCHQA7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdbJgf+IWnlCHQA7@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:50:41AM +0000, David Brazdil wrote:
> Hi Wedson,
> 
> On Wed, Jan 05, 2022 at 04:52:51PM +0000, Wedson Almeida Filho wrote:
> > On Tue, Dec 21, 2021 at 05:45:02PM +0000, David Brazdil wrote:
> > > Open Profile for DICE is an open protocol for measured boot compatible
> > > with the Trusted Computing Group's Device Identifier Composition
> > > Engine (DICE) specification. The generated Compound Device Identifier
> > > (CDI) certificates represent the hardware/software combination measured
> > > by DICE, and can be used for remote attestation and sealing.
> > > 
> > > Add a driver that exposes reserved memory regions populated by firmware
> > > with DICE CDIs and exposes them to userspace via a character device.
> > > 
> > > Userspace obtains the memory region's size from read() and calls mmap()
> > > to create a mapping of the memory region in its address space. The
> > > mapping is not allowed to be write+shared, giving userspace a guarantee
> > > that the data were not overwritten by another process.
> > > 
> > > Userspace can also call write(), which triggers a wipe of the DICE data
> > > by the driver. Because both the kernel and userspace mappings use
> > > write-combine semantics, all clients observe the memory as zeroed after
> > > the syscall has returned.
> > > 
> > > Cc: Andrew Scull <ascull@google.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Signed-off-by: David Brazdil <dbrazdil@google.com>
> > > ---
> > >  drivers/misc/Kconfig     |  12 +++
> > >  drivers/misc/Makefile    |   1 +
> > >  drivers/misc/open-dice.c | 188 +++++++++++++++++++++++++++++++++++++++
> > >  drivers/of/platform.c    |   1 +
> > >  4 files changed, 202 insertions(+)
> > >  create mode 100644 drivers/misc/open-dice.c
> > > 
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index 0f5a49fc7c9e..a2b26426efba 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -470,6 +470,18 @@ config HISI_HIKEY_USB
> > >  	  switching between the dual-role USB-C port and the USB-A host ports
> > >  	  using only one USB controller.
> > >  
> > > +config OPEN_DICE
> > > +	tristate "Open Profile for DICE driver"
> > > +	depends on OF_RESERVED_MEM
> > > +	help
> > > +	  This driver exposes a DICE reserved memory region to userspace via
> > > +	  a character device. The memory region contains Compound Device
> > > +	  Identifiers (CDIs) generated by firmware as an output of DICE
> > > +	  measured boot flow. Userspace can use CDIs for remote attestation
> > > +	  and sealing.
> > > +
> > > +	  If unsure, say N.
> > > +
> > >  source "drivers/misc/c2port/Kconfig"
> > >  source "drivers/misc/eeprom/Kconfig"
> > >  source "drivers/misc/cb710/Kconfig"
> > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > > index a086197af544..70e800e9127f 100644
> > > --- a/drivers/misc/Makefile
> > > +++ b/drivers/misc/Makefile
> > > @@ -59,3 +59,4 @@ obj-$(CONFIG_UACCE)		+= uacce/
> > >  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> > >  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> > >  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
> > > +obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> > > diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
> > > new file mode 100644
> > > index 000000000000..f1819f951173
> > > --- /dev/null
> > > +++ b/drivers/misc/open-dice.c
> > > @@ -0,0 +1,188 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2021 - Google LLC
> > > + * Author: David Brazdil <dbrazdil@google.com>
> > > + *
> > > + * Driver for Open Profile for DICE.
> > > + *
> > > + * This driver takes ownership of a reserved memory region containing data
> > > + * generated by the Open Profile for DICE measured boot protocol. The memory
> > > + * contents are not interpreted by the kernel but can be mapped into a userspace
> > > + * process via a misc device. Userspace can also request a wipe of the memory.
> > > + *
> > > + * Userspace can access the data with (w/o error handling):
> > > + *
> > > + *     fd = open("/dev/open-dice0", O_RDWR);
> > > + *     read(fd, &size, sizeof(unsigned long));
> > > + *     data = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
> > > + *     write(fd, NULL, 0); // wipe
> > > + *     close(fd);
> > > + */
> > > +
> > > +#include <linux/io.h>
> > > +#include <linux/miscdevice.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_reserved_mem.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#define DRIVER_NAME "open-dice"
> > > +
> > > +struct open_dice_drvdata {
> > > +	spinlock_t lock;
> > > +	char name[16];
> > > +	struct reserved_mem *rmem;
> > > +	struct miscdevice misc;
> > > +};
> > > +
> > > +static inline struct open_dice_drvdata *to_open_dice_drvdata(struct file *filp)
> > > +{
> > > +	return container_of(filp->private_data, struct open_dice_drvdata, misc);
> > > +}
> > > +
> > > +static int open_dice_wipe(struct open_dice_drvdata *drvdata)
> > > +{
> > > +	void *kaddr;
> > > +
> > > +	spin_lock(&drvdata->lock);
> > > +	kaddr = devm_memremap(drvdata->misc.this_device, drvdata->rmem->base,
> > > +			      drvdata->rmem->size, MEMREMAP_WC);
> > > +	if (IS_ERR(kaddr)) {
> > > +		spin_unlock(&drvdata->lock);
> > > +		return PTR_ERR(kaddr);
> > > +	}
> > > +
> > > +	memset(kaddr, 0, drvdata->rmem->size);
> > > +	devm_memunmap(drvdata->misc.this_device, kaddr);
> > > +	spin_unlock(&drvdata->lock);
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * Copies the size of the reserved memory region to the user-provided buffer.
> > > + */
> > > +static ssize_t open_dice_read(struct file *filp, char __user *ptr, size_t len,
> > > +			      loff_t *off)
> > > +{
> > > +	unsigned long val = to_open_dice_drvdata(filp)->rmem->size;
> > 
> > There's a UAF issue here (and in all file operations that call
> > to_open_dice_drvdata) when the platform device in unbounded from the driver
> > while userspace has an instance of the misc device open: after open_dice_remove
> > is called, all managed resources are freed (which includes this
> > open_dice_drvdata allocation).
> > 
> > No new miscdev files can be created, but the existing ones continue to exist
> > with a now dangling pointer stored in private_data. So read/write/mmap syscalls
> > from userspace will lead to dereferencing this dangling pointer.
> 
> Please correct me if I'm wrong, but I don't think this can happen
> without tainting the kernel.
> 
> To call open_dice_remove, we have to remove the module. And any process
> holding an FD of the misc device will increase the module's refcounter,
> which is zero-checked in SYS_delete_module. The only way to get past
> that check is by compiling the kernel with CONFIG_MODULE_FORCE_UNLOAD,
> which changes the implementation of try_force_unload (kernel/module.c)
> and adds taint. Otherwise SYS_delete_module returns an error.
> 
> Unless there is another way how to trigger this situation, I think the
> existing protection is sufficient. The user cannot force the removal of
> the module without agreeing to the consequences.

You can remove the driver from the device by writing to the "unbind"
file in sysfs for this driver.

Otherwise, yes, you are correct, you can not remove the module from the
system if the file is open, but that does not prevent the driver from
being unbound from the device.

Yes, it is rare, and only able to be done by root, and even then is
something that many drivers fail at.  But for new ones, when we notice
it, it should be fixed up before merging just to prevent any future
problems.

> > > +	/* Create write-combine mapping so all clients observe a wipe. */
> > > +	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> > > +	vma->vm_flags |= VM_DONTCOPY | VM_DONTDUMP;
> > > +	return vm_iomap_memory(vma, drvdata->rmem->base, drvdata->rmem->size);
> > > +}
> > 
> > Is there a reason for mapping this memory instead of, say, copying it to
> > userspace via read?
> 
> The data should be treated as secret, so the idea is that avoiding
> reading it in the kernel means we don't need to worry about it leakage
> via the stack, etc. The reason for this is that the DICE derivation
> chain may continue in userspace, so we want to minimize the chance of
> a child process getting the parent secret from the kernel.

The kernel stack is already secret, this should not be an issue.  And
even then, you can always erase it before the call returns to ensure
that it does not stick around, like many crypto functions do.

thanks,

greg k-h
