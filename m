Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD8958278D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiG0NWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiG0NWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:22:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA321E17
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DFFD616F9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E1EC433D6;
        Wed, 27 Jul 2022 13:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658928167;
        bh=F3cV5lPOH1ZiNYSHLYaUKmWDENpqXHCzAQKiSGpp0D0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFubDy2ZQjUD83zYfZRe8qi3I1k9nl4m3lbA5+a3raHq4NGhGxNVHO+xj8XTIpBAZ
         pdE6hlOB4SpLwjV9ymYnonLeKSdBVo7bgM4D2jeAs28mcXyt1fNBAlMRx9z8VbktC/
         +JFB8DplMAGXtJaUR95E67kka9a4hjOkAJG7ZaVc=
Date:   Wed, 27 Jul 2022 15:22:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiho Chu <jiho.chu@samsung.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH 1/9] trinity: Add base driver
Message-ID: <YuE8JNjIBNdg/kkX@kroah.com>
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
 <CGME20220725065309epcas1p4565e7bb0fea1aaf3e5e300de00774c2a@epcas1p4.samsung.com>
 <20220725065308.2457024-2-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725065308.2457024-2-jiho.chu@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 03:53:00PM +0900, Jiho Chu wrote:
> It contains the base codes for trinity driver. Minimal codes to load and
> probe device is provided. The Trinity Family is controlled by the
> Memory-Mapped Registers, the register addresses and offsets are
> described. And user api interfaces are presented to control device under
> ioctl manner.
> 
> Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
> Signed-off-by: yelini-jeong <yelini.jeong@samsung.com>
> Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
> Signed-off-by: Parichay Kapoor <pk.kapoor@samsung.com>
> Signed-off-by: Wook Song <wook16.song@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/misc/Kconfig                        |   1 +
>  drivers/misc/Makefile                       |   1 +
>  drivers/misc/trinity/Kconfig                |  27 ++
>  drivers/misc/trinity/Makefile               |   7 +
>  drivers/misc/trinity/trinity.c              | 369 ++++++++++++++
>  drivers/misc/trinity/trinity_common.h       | 392 +++++++++++++++
>  drivers/misc/trinity/trinity_vision2_drv.c  | 512 ++++++++++++++++++++
>  drivers/misc/trinity/trinity_vision2_regs.h | 210 ++++++++
>  include/uapi/misc/trinity.h                 | 458 +++++++++++++++++
>  9 files changed, 1977 insertions(+)
>  create mode 100644 drivers/misc/trinity/Kconfig
>  create mode 100644 drivers/misc/trinity/Makefile
>  create mode 100644 drivers/misc/trinity/trinity.c
>  create mode 100644 drivers/misc/trinity/trinity_common.h
>  create mode 100644 drivers/misc/trinity/trinity_vision2_drv.c
>  create mode 100644 drivers/misc/trinity/trinity_vision2_regs.h
>  create mode 100644 include/uapi/misc/trinity.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41d2bb0ae23a..ad0d5f6af291 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -500,4 +500,5 @@ source "drivers/misc/cardreader/Kconfig"
>  source "drivers/misc/habanalabs/Kconfig"
>  source "drivers/misc/uacce/Kconfig"
>  source "drivers/misc/pvpanic/Kconfig"
> +source "drivers/misc/trinity/Kconfig"
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 70e800e9127f..c63f3fc89780 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
>  obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> +obj-$(CONFIG_TRINITY)		+= trinity/
> diff --git a/drivers/misc/trinity/Kconfig b/drivers/misc/trinity/Kconfig
> new file mode 100644
> index 000000000000..ad4bab78f7c6
> --- /dev/null
> +++ b/drivers/misc/trinity/Kconfig
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config TRINITY
> +	bool "Samsung Neural Processing Unit"
> +	depends on HAS_IOMEM
> +	depends on HAS_DMA
> +	default n

The default is 'n', no need to ever say it again.

> +	help
> +	  Select this option to enable driver support for Samsung
> +	  Neural Processing Unit (NPU).
> +
> +	  This driver works as a base driver of the other drivers
> +	  for Trinity device family.
> +
> +	  This option should be enabled to support Trinity
> +	  Vision 2 (TRIV2), and Trinity Audio (TRIA).
> +
> +config TRINITY_VISION2
> +	tristate "Samsung NPU Trinity Vision 2"

What happened to "vision 1"?

> +	depends on TRINITY
> +	default n
> +	help
> +	  Select this option to enable driver support for a Samsung
> +	  Neural Processing Unit (NPU), Tinity Vision 2.
> +
> +	  This driver enables userspace system library to access the
> +	  device via /dev/triv2-N.

What is the module name?

Where is the userspace library code that talks to this?  Any
documentation for this interface anywhere?

> +#define BASE_DEV_NAME "trinity"

KBUILD_MODNAME?

> +/* A global lock for shared static variables such as dev_bitmap */
> +static DEFINE_SPINLOCK(trinity_lock);

That's a sign something is wrong, you should not need any module-wide
code variables.

> +/* A bitmap to keep track of active Trinity devices */
> +static unsigned long dev_bitmap[TRINITY_DEV_END];

Should not be needed, use a simple ida structure if you really want to
name things cleanly.

> +
> +/**
> + * trinity_release() - A common callback for close() in file_operations for a
> + *		Trinity	device node. If there are device-specific data to be
> + *		cleaned-up, it is required to clean them up before invoke this
> + *		callback.
> + *
> + * @inode: Inode to be closed
> + * @file: File to be closed
> + *
> + * Returns 0 on success. Otherwise, returns negative error.
> + */
> +int trinity_release(struct inode *inode, struct file *file)
> +{
> +	struct trinity_driver *drv;
> +
> +	drv = file->private_data;
> +
> +	if (drv->verbose)
> +		dev_info(drv_to_dev_ptr(drv), "%s\n", "Device closed");
> +
> +	mutex_lock(&drv->lock);
> +	drv->opened = drv->opened - 1;

That will never work, you can't keep track of open/close calls.

> +	if (drv->opened == 0) {
> +		/* wait already submitted requests */
> +		if (drv->desc->drain_reqs)
> +			drv->desc->drain_reqs(drv);
> +
> +		drv->desc->set_state(drv, TRINITY_STATE_PAUSE);
> +	}
> +	mutex_unlock(&drv->lock);
> +
> +	return 0;
> +}
> +
> +static bool trinity_is_empty(void)
> +{
> +	enum trinity_dev_type type;
> +	bool empty = true;
> +
> +	spin_lock(&trinity_lock);
> +	for (type = TRINITY_DEV_UNKNOWN, type++; type < TRINITY_DEV_END;
> +	     type++) {
> +		if (find_first_bit(&dev_bitmap[type], TRINITY_DEV_EACH_MAX) !=
> +		    TRINITY_DEV_EACH_MAX) {
> +			empty = false;
> +			break;
> +		}
> +	}
> +	spin_unlock(&trinity_lock);
> +
> +	return empty;
> +}
> +
> +/**
> + * trinity_wait_ready() - Wait until trinity is ready state
> + *
> + * @drv: an instance of trinity driver
> + *
> + * Returns 0 on success. Otherwise, returns negative error.
> + */
> +int trinity_wait_ready(struct trinity_driver *drv)
> +{
> +	const unsigned long time_out = HZ / 100UL; /* 1/100 seconds*/
> +	const unsigned int max_retry = 10;
> +	unsigned int retry = 0;
> +	wait_queue_head_t wq;
> +
> +	drv->desc->set_state(drv, TRINITY_STATE_READY);
> +
> +	init_waitqueue_head(&wq);
> +	/* try to ensure that NPU is in the ready state */
> +	while (wait_event_timeout(
> +		       wq, drv->desc->get_state(drv) == TRINITY_STATE_READY,
> +		       time_out) == 0) {
> +		/* regarded as failure */
> +		if (retry == max_retry)
> +			return -ETIMEDOUT;
> +		retry++;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * trinity_open() - A common callback for open() in file_operations for a Trinity
> + *		device node. If device-specific open() is required, this
> + *		callback should be invoked by that open().
> + *
> + * @inode: inode to be opened
> + * @f: file to be opened
> + *
> + * Returns 0 on success. Otherwise, returns negative error.
> + */
> +int trinity_open(struct inode *inode, struct file *f)
> +{
> +	struct miscdevice *miscdev;
> +	struct trinity_driver *drv;
> +	int ret = 0;
> +
> +	miscdev = (struct miscdevice *)f->private_data;

Why the cast?

> +	drv = container_of(miscdev, struct trinity_driver, mdev);
> +	f->private_data = drv;
> +
> +	mutex_lock(&drv->lock);
> +	/** remove PAUSE set on the CP of the NPU */
> +	if (drv->opened == 0) {
> +		ret = trinity_wait_ready(drv);
> +		if (ret != 0)
> +			goto out;
> +	}
> +	drv->opened = drv->opened + 1;

Again, trying to keep track of open/close calls will never work.  Just
let the vfs handle that for you (you will note it does that already).
Your driver should never need to worry about it.


> +
> +	if (drv->verbose)
> +		dev_info(drv_to_dev_ptr(drv), "%s\n", "Device opened");
> +
> +out:
> +	mutex_unlock(&drv->lock);
> +
> +	return 0;
> +}
> +
> +static void trinity_common_init(struct device *dev)
> +{
> +	if (!trinity_is_empty())
> +		return;
> +
> +	/* Common init codes */
> +}

Missing something?


> +
> +static void trinity_common_exit(void)
> +{
> +	if (!trinity_is_empty())
> +		return;
> +
> +	/* Common deinit codes */
> +}
> +

Don't provide empty functions that do nothing please.

> +static int trinity_set_device_id(struct trinity_driver *drv)
> +{
> +	const struct trinity_desc *desc = drv->desc;
> +	struct device *dev = drv_to_dev_ptr(drv);
> +	int err = -EEXIST;
> +
> +	spin_lock(&trinity_lock);
> +	drv->dev_id =
> +		find_first_zero_bit(&dev_bitmap[dev->id], TRINITY_DEV_EACH_MAX);

Again, use an ida structure please.

> +	if (drv->dev_id < TRINITY_DEV_EACH_MAX) {
> +		set_bit(drv->dev_id, &dev_bitmap[dev->id]);
> +		err = 0;
> +	}
> +	spin_unlock(&trinity_lock);
> +
> +	if (err == 0) {
> +		drv->name = devm_kasprintf(dev, GFP_KERNEL, "%s-%u", desc->type,
> +					   drv->dev_id);
> +		err = IS_ERR_OR_NULL(drv->name) ? -ENOMEM : 0;

Spell out if statements, this just makes things hard to read.  And you
just leaked a "bit" if this failed, so are you sure this was ever
tested?



> +	}
> +
> +	return err;
> +}
> +
> +int trinity_create_node(struct trinity_driver *drv)
> +{
> +	struct device *dev = drv_to_dev_ptr(drv);
> +	int err;
> +
> +	/** register as a misc device */
> +	drv->mdev.minor = MISC_DYNAMIC_MINOR;
> +	drv->mdev.parent = NULL;

No parent device?  Why not?  What bus does this device live on?  This is
a platform device lower on in this code, please use that, don't just
hang out there at the top of the device tree.


> +	drv->mdev.name = drv->name;
> +
> +	err = misc_register(&drv->mdev);
> +	if (err < 0)
> +		dev_err(dev, "failed to register as a misc device");
> +	else
> +		dev_info(dev, "misc device created!");

Again, drivers are quiet if all goes well.

I stopped here.

Also, please remove the layers of abstraction you have in your
structures that you never use, but yet still define in this patch for
some reason...

thanks,

greg k-h
