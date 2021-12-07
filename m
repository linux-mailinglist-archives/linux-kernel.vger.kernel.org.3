Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3792A46BC2D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbhLGNL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:11:56 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50060 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbhLGNLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:11:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D59CBCE1AA3;
        Tue,  7 Dec 2021 13:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84257C341C1;
        Tue,  7 Dec 2021 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638882500;
        bh=K9zNh0bHKvKySji7UxHLTM/rwJ1vrX1xw1Z10O3pD+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhvalWCgCHWRni0bv3Tp2q3OivrGkVigo0Y/b8pXMb2bkaDHJhBZ789zTqb84jOtK
         UJx3suQZWK713/h+uLGG2qi0uGV8f7aYjNSFfTHUVSv7AQpxqqQNXfYOEzLb2jQcaG
         oi5c8ZjcXKzuYgvWdQbZghflgt0KGcr+LDZ0Xya8=
Date:   Tue, 7 Dec 2021 14:08:17 +0100
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
Subject: Re: [PATCH 2/2] misc: dice: Add driver to forward secrets to
 userspace
Message-ID: <Ya9cwZ94QatewwIc@kroah.com>
References: <20211207123617.3040177-1-dbrazdil@google.com>
 <20211207123617.3040177-3-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207123617.3040177-3-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 12:36:17PM +0000, David Brazdil wrote:
> Open Profile for DICE is a protocol for deriving unique secrets at boot,
> used by some Android devices. The firmware/bootloader hands over secrets
> in a reserved memory region, this driver takes ownership of the memory
> region and exposes it to userspace via a character device that
> lets userspace mmap the memory region into its process.
> 
> The character device can only be opened once at any given time.

Why?  That should not matter.  And your code (correctly), does not check
for that.  So why say that here?

> Userspace can issue an ioctl requesting that the memory be wiped after
> the current FD is released. In that case, the driver will clear
> the buffer and refuse to open any new FDs.
> 
> Cc: Andrew Scull <ascull@google.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: David Brazdil <dbrazdil@google.com>

Some minor comments on the code:

> +#include <linux/cdev.h>
> +#include <linux/dice.h>
> +#include <linux/io.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +
> +#define DICE_MKDEV		MKDEV(MAJOR(dice_devt), 0)
> +#define DICE_MINOR_COUNT	1

Please just use the misc_device api, no need to try to claim a major
number for just one device node.  That will simplify your code a lot as
well.

> +enum dice_state {
> +	DICE_STATE_READY = 0,
> +	DICE_STATE_BUSY,
> +	DICE_STATE_BUSY_WIPE_ON_CLOSE,
> +	DICE_STATE_WIPED,
> +};
> +
> +struct dice_data {
> +	struct device *dev;

What is this for?  The parent?  If so, say parent :)

> +	struct cdev cdev;
> +	atomic_t state;
> +	phys_addr_t base;
> +	size_t size;
> +};
> +
> +static dev_t dice_devt;
> +static struct class *dice_class;
> +
> +static int dice_open(struct inode *inode, struct file *filp)
> +{
> +	struct dice_data *data;
> +
> +	data = container_of(inode->i_cdev, struct dice_data, cdev);
> +
> +	/* Never allow write access. */
> +	if (filp->f_mode & FMODE_WRITE)
> +		return -EROFS;

Why do you care?  Writes just will not work anyway, right?

> +
> +	switch (atomic_cmpxchg(&data->state, DICE_STATE_READY, DICE_STATE_BUSY)) {
> +	case DICE_STATE_READY:
> +		break;
> +	case DICE_STATE_WIPED:
> +		/* Return error to inform caller memory has been wiped. */
> +		return -EACCES;
> +	default:
> +		return -EBUSY;
> +	}
> +
> +	filp->private_data = data;
> +	nonseekable_open(inode, filp);
> +	return 0;
> +}
> +
> +static int dice_release(struct inode *inode, struct file *filp)
> +{
> +	struct dice_data *data = filp->private_data;
> +	void *base;
> +
> +	if (atomic_read(&data->state) == DICE_STATE_BUSY_WIPE_ON_CLOSE) {
> +		base = devm_memremap(data->dev, data->base, data->size, MEMREMAP_WT);
> +		if (!WARN_ON(!base)) {
> +			memzero_explicit(base, data->size);
> +			devm_memunmap(data->dev, base);
> +		}
> +		atomic_set(&data->state, DICE_STATE_WIPED);
> +		return 0;
> +	}
> +
> +	atomic_set(&data->state, DICE_STATE_READY);
> +	return 0;
> +}
> +
> +static int dice_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct dice_data *data = filp->private_data;
> +
> +	vma->vm_flags |= VM_DONTCOPY;
> +	return vm_iomap_memory(vma, data->base, data->size);
> +}
> +
> +static long dice_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	struct dice_data *data = filp->private_data;
> +
> +	switch (cmd) {
> +	case DICE_GET_SIZE:
> +		/* Checked against INT_MAX in dice_probe(). */
> +		return data->size;
> +	case DICE_SET_WIPE_ON_CLOSE:
> +		atomic_set(&data->state, DICE_STATE_BUSY_WIPE_ON_CLOSE);
> +		return 0;
> +	}
> +
> +	return -EINVAL;

Wrong error value for invalid ioctl.

And why do these have to be ioctls at all?  I guess sysfs could be used,
but if you are comfortable with ioctls, that's fine.

> +}
> +
> +static const struct file_operations dice_fops = {
> +	.open = dice_open,
> +	.release = dice_release,
> +	.mmap = dice_mmap,
> +	.unlocked_ioctl = dice_ioctl,
> +	.llseek = no_llseek,
> +};
> +
> +static int __init dice_probe(struct platform_device *pdev)
> +{
> +	struct device *chr_dev, *dev = &pdev->dev;
> +	struct device_node *rmem_np;
> +	struct reserved_mem *rmem;
> +	struct dice_data *data;
> +	int ret;
> +
> +	rmem_np = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (!rmem_np) {
> +		dev_err(dev, "missing 'memory-region' property\n");
> +		return -EINVAL;
> +	}
> +
> +	rmem = of_reserved_mem_lookup(rmem_np);
> +	of_node_put(rmem_np);
> +	if (!rmem) {
> +		dev_err(dev, "failed to lookup reserved memory\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!PAGE_ALIGNED(rmem->base) || !PAGE_ALIGNED(rmem->size)) {
> +		dev_err(dev, "memory region must be page-aligned\n");
> +		return -EINVAL;
> +	}
> +
> +	if (rmem->size > INT_MAX) {
> +		dev_err(dev, "memory region too large\n");
> +		return -EINVAL;
> +	}
> +
> +	data = devm_kmalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	*data = (struct dice_data){
> +		.dev = dev,
> +		.base = rmem->base,
> +		.size = rmem->size,
> +		.state = ATOMIC_INIT(DICE_STATE_READY),
> +	};
> +
> +	cdev_init(&data->cdev, &dice_fops);

Again a misc device will make this much simpler.

> +	data->cdev.owner = THIS_MODULE;
> +	ret = cdev_add(&data->cdev, DICE_MKDEV, 1);
> +	if (ret)
> +		return ret;
> +
> +	chr_dev = device_create(dice_class, dev, DICE_MKDEV, NULL, "dice");
> +	if (IS_ERR(chr_dev)) {
> +		cdev_del(&data->cdev);
> +		return PTR_ERR(chr_dev);
> +	}
> +
> +	platform_set_drvdata(pdev, data);
> +	return 0;
> +}
> +
> +static int dice_remove(struct platform_device *pdev)
> +{
> +	struct dice_data *data = platform_get_drvdata(pdev);
> +
> +	cdev_del(&data->cdev);
> +	device_destroy(dice_class, DICE_MKDEV);
> +	return 0;
> +}
> +
> +static char *dice_devnode(struct device *dev, umode_t *mode)
> +{
> +	/* Initial permissions: read-only by owner */
> +	if (mode)
> +		*mode = 0400;
> +	return NULL;

Put the mode in the misc device structure please.

> +}
> +
> +static const struct of_device_id dice_of_match[] = {
> +	{ .compatible = "google,dice" },
> +	{},
> +};
> +
> +static struct platform_driver dice_driver = {
> +	.remove = dice_remove,
> +	.driver = {
> +		.name = "dice",
> +		.of_match_table = dice_of_match,
> +	},
> +};
> +
> +static int __init dice_init(void)
> +{
> +	int ret;
> +
> +	ret = alloc_chrdev_region(&dice_devt, 0, DICE_MINOR_COUNT, "dice");
> +	if (ret)
> +		return ret;
> +
> +	dice_class = class_create(THIS_MODULE, "dice");
> +	if (IS_ERR(dice_class)) {
> +		ret = PTR_ERR(dice_class);
> +		goto fail;
> +	}
> +	dice_class->devnode = dice_devnode;

Never create a class and reserve things like this, if you do not even
know if your hardware is present or not.  That just wastes resources.
Only allocate it if your device probes properly.

And again, moving to a misc_device makes this all much simpler and your
whole init function can go away.

thanks,

greg k-h
