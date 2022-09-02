Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA135AA74F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiIBFkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbiIBFkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:40:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490541054A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4AF3B829DB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05510C433D6;
        Fri,  2 Sep 2022 05:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662097197;
        bh=+/6bMo6MZ6HQeomRdoMkT9tL2tvliyapBilN0i6IwjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HB6gJvKFliXXws4pLxzOctf5p+DqKAy8lKOjKbLX9KHCG4E9pl55E5K+gVydJpef2
         QdkehK9q4423p06fxqnOgF/ydrkPcLTwklunPe01ifE9qjPEeocoKorvEP1De8M93q
         jgtnNctz8oA4hkSQopFF2UYXF4YtO95+ql10xhi8=
Date:   Fri, 2 Sep 2022 07:39:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dafna Hirschfeld <dafna@fastmail.com>
Cc:     Jiho Chu <jiho.chu@samsung.com>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com
Subject: Re: [PATCH 1/9] trinity: Add base driver
Message-ID: <YxGXKkRqsJJ0c624@kroah.com>
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
 <CGME20220725065309epcas1p4565e7bb0fea1aaf3e5e300de00774c2a@epcas1p4.samsung.com>
 <20220725065308.2457024-2-jiho.chu@samsung.com>
 <YuE8JNjIBNdg/kkX@kroah.com>
 <20220901190443.d6b42mtmzju354b5@guri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901190443.d6b42mtmzju354b5@guri>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:04:43PM +0300, Dafna Hirschfeld wrote:
> On 27.07.2022 15:22, Greg KH wrote:
> > On Mon, Jul 25, 2022 at 03:53:00PM +0900, Jiho Chu wrote:
> > > It contains the base codes for trinity driver. Minimal codes to load and
> > > probe device is provided. The Trinity Family is controlled by the
> > > Memory-Mapped Registers, the register addresses and offsets are
> > > described. And user api interfaces are presented to control device under
> > > ioctl manner.
> > > 
> > > Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
> > > Signed-off-by: yelini-jeong <yelini.jeong@samsung.com>
> > > Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
> > > Signed-off-by: Parichay Kapoor <pk.kapoor@samsung.com>
> > > Signed-off-by: Wook Song <wook16.song@samsung.com>
> > > Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> > > ---
> > >  drivers/misc/Kconfig                        |   1 +
> > >  drivers/misc/Makefile                       |   1 +
> > >  drivers/misc/trinity/Kconfig                |  27 ++
> > >  drivers/misc/trinity/Makefile               |   7 +
> > >  drivers/misc/trinity/trinity.c              | 369 ++++++++++++++
> > >  drivers/misc/trinity/trinity_common.h       | 392 +++++++++++++++
> > >  drivers/misc/trinity/trinity_vision2_drv.c  | 512 ++++++++++++++++++++
> > >  drivers/misc/trinity/trinity_vision2_regs.h | 210 ++++++++
> > >  include/uapi/misc/trinity.h                 | 458 +++++++++++++++++
> > >  9 files changed, 1977 insertions(+)
> > >  create mode 100644 drivers/misc/trinity/Kconfig
> > >  create mode 100644 drivers/misc/trinity/Makefile
> > >  create mode 100644 drivers/misc/trinity/trinity.c
> > >  create mode 100644 drivers/misc/trinity/trinity_common.h
> > >  create mode 100644 drivers/misc/trinity/trinity_vision2_drv.c
> > >  create mode 100644 drivers/misc/trinity/trinity_vision2_regs.h
> > >  create mode 100644 include/uapi/misc/trinity.h
> > > 
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index 41d2bb0ae23a..ad0d5f6af291 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -500,4 +500,5 @@ source "drivers/misc/cardreader/Kconfig"
> > >  source "drivers/misc/habanalabs/Kconfig"
> > >  source "drivers/misc/uacce/Kconfig"
> > >  source "drivers/misc/pvpanic/Kconfig"
> > > +source "drivers/misc/trinity/Kconfig"
> > >  endmenu
> > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > > index 70e800e9127f..c63f3fc89780 100644
> > > --- a/drivers/misc/Makefile
> > > +++ b/drivers/misc/Makefile
> > > @@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> > >  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> > >  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
> > >  obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> > > +obj-$(CONFIG_TRINITY)		+= trinity/
> > > diff --git a/drivers/misc/trinity/Kconfig b/drivers/misc/trinity/Kconfig
> > > new file mode 100644
> > > index 000000000000..ad4bab78f7c6
> > > --- /dev/null
> > > +++ b/drivers/misc/trinity/Kconfig
> > > @@ -0,0 +1,27 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +config TRINITY
> > > +	bool "Samsung Neural Processing Unit"
> > > +	depends on HAS_IOMEM
> > > +	depends on HAS_DMA
> > > +	default n
> > 
> > The default is 'n', no need to ever say it again.
> > 
> > > +	help
> > > +	  Select this option to enable driver support for Samsung
> > > +	  Neural Processing Unit (NPU).
> > > +
> > > +	  This driver works as a base driver of the other drivers
> > > +	  for Trinity device family.
> > > +
> > > +	  This option should be enabled to support Trinity
> > > +	  Vision 2 (TRIV2), and Trinity Audio (TRIA).
> > > +
> > > +config TRINITY_VISION2
> > > +	tristate "Samsung NPU Trinity Vision 2"
> > 
> > What happened to "vision 1"?
> > 
> > > +	depends on TRINITY
> > > +	default n
> > > +	help
> > > +	  Select this option to enable driver support for a Samsung
> > > +	  Neural Processing Unit (NPU), Tinity Vision 2.
> > > +
> > > +	  This driver enables userspace system library to access the
> > > +	  device via /dev/triv2-N.
> > 
> > What is the module name?
> > 
> > Where is the userspace library code that talks to this?  Any
> > documentation for this interface anywhere?
> > 
> > > +#define BASE_DEV_NAME "trinity"
> > 
> > KBUILD_MODNAME?
> > 
> > > +/* A global lock for shared static variables such as dev_bitmap */
> > > +static DEFINE_SPINLOCK(trinity_lock);
> > 
> > That's a sign something is wrong, you should not need any module-wide
> > code variables.
> > 
> > > +/* A bitmap to keep track of active Trinity devices */
> > > +static unsigned long dev_bitmap[TRINITY_DEV_END];
> > 
> > Should not be needed, use a simple ida structure if you really want to
> > name things cleanly.
> > 
> > > +
> > > +/**
> > > + * trinity_release() - A common callback for close() in file_operations for a
> > > + *		Trinity	device node. If there are device-specific data to be
> > > + *		cleaned-up, it is required to clean them up before invoke this
> > > + *		callback.
> > > + *
> > > + * @inode: Inode to be closed
> > > + * @file: File to be closed
> > > + *
> > > + * Returns 0 on success. Otherwise, returns negative error.
> > > + */
> > > +int trinity_release(struct inode *inode, struct file *file)
> > > +{
> > > +	struct trinity_driver *drv;
> > > +
> > > +	drv = file->private_data;
> > > +
> > > +	if (drv->verbose)
> > > +		dev_info(drv_to_dev_ptr(drv), "%s\n", "Device closed");
> > > +
> > > +	mutex_lock(&drv->lock);
> > > +	drv->opened = drv->opened - 1;
> > 
> > That will never work, you can't keep track of open/close calls.
> 
> Hi, can you explain why this will not work?

Let me switch it the other way around, can you explain to me how this
will actually work?  Think about userspace calling dup(2) and passing
file handles around to other processes...

It's an impossible thing, just don't worry about it at all.  If
userspace wants to open multiple instances of the same device and do
foolish things with it, let it.  That's a userspace bug, not a kernel
issue.

thanks,

greg k-h
