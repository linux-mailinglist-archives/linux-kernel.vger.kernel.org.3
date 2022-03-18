Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA444DD50D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiCRHHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiCRHHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:07:22 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B22E2D69;
        Fri, 18 Mar 2022 00:06:03 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id f3so292414qvz.10;
        Fri, 18 Mar 2022 00:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1POxteJqhn86ccNlL5l8f0s/frZWvjX/O/O2Vw5LzMw=;
        b=hRtySJnhJAo4m+08dy2m+2JR5AqPTU0EGkY40IBv5MYBCejbGhKpqquHDCuKRCuQvL
         i45REsUOGp2WdDGKBaBgD9z8f4VSE+te0EHVdMZgk/CObTWpRiUiU99QKBgrnaGMJoRn
         +sypfMBlmhtlMmRHBe9Kz51xIPL1sjW3Y6y8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1POxteJqhn86ccNlL5l8f0s/frZWvjX/O/O2Vw5LzMw=;
        b=SIRUqHTGzrobv6+UvFTJdKQY0FbnkzTA28DYH5hvPLhivfaWrkk0I0oFmQZd8f/Xhi
         ERoJOZIFw9UzsdvArh8i1l1axuBE+xP16ZWLZZPUPrdKQu6ubX/x4bSuN6OsJ8te3CAi
         W/P8JKTysNIhyxykKZY8LwuI8JEF464949fnyX8HxlsctDtQhcqnvUcb99EYsa/L+FLk
         wlF1hN2/xIu2ErvaMSKmPFIS4uBCnE1aMCN3PEzj9Li9Q70SQJ/AZwQSKN8awjuKtngW
         LhB0PGSn2/gAcjaesDVyk/Ouc731aebdMwFiAcgp2l12IIG54ZlX/DnI1FbW//hMP1zV
         w5Rw==
X-Gm-Message-State: AOAM531nu+rVsEUuBXA9RrApNqkLKJNONiOSmbxCywo1kUGiABjOseBT
        GBIRXBCqMAH82n3CTppYIUb4eAGzdwFdDnb7og0=
X-Google-Smtp-Source: ABdhPJwGwhb7fCzeyvFIv7e/qapj5R2TYP9QkcWNDqhK7NXXAzV7ODN8teo6BoOVmAN7F3kgK6rYqFLvdC66anGfHCw=
X-Received: by 2002:ad4:5fc5:0:b0:435:4420:d056 with SMTP id
 jq5-20020ad45fc5000000b004354420d056mr6165427qvb.130.1647587162290; Fri, 18
 Mar 2022 00:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210817025848.19914-1-chiawei_wang@aspeedtech.com> <20210817025848.19914-2-chiawei_wang@aspeedtech.com>
In-Reply-To: <20210817025848.19914-2-chiawei_wang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 18 Mar 2022 07:05:50 +0000
Message-ID: <CACPK8XcmZVXX6a-PY6BnpSrbZ2UZysBtVMCL7qxkOF=hvE2QfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: aspeed: Add LPC mailbox support
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Cyril Bur <cyrilbur@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2021 at 02:58, Chia-Wei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> The LPC mailbox controller consists of multiple general
> registers for the communication between the Host and the BMC.
> The interrupts for data update signaling are also introduced.

The concern with this approach is the userspace API. We don't want
every driver to invent it's own way of communicating with usersapce.

I know when Cyril first submitted this driver it was suggested to use
the kernel mailbox subsystem. After investigation it was decided that
this hardware is not a fit; although it is a mailbox it is more like a
IPMI BT or KCS device, that needs an interface to push data to and
from userspace over the device.

Chai-Wei, can you link to some userspace programs that use the
existing ioctl interface?

Arnd, do you have any suggestions?

>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/soc/aspeed/Kconfig           |  10 +
>  drivers/soc/aspeed/Makefile          |   9 +-
>  drivers/soc/aspeed/aspeed-lpc-mbox.c | 418 +++++++++++++++++++++++++++
>  3 files changed, 433 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/soc/aspeed/aspeed-lpc-mbox.c
>
> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> index 243ca196e6ad..5b31a6e2620c 100644
> --- a/drivers/soc/aspeed/Kconfig
> +++ b/drivers/soc/aspeed/Kconfig
> @@ -24,6 +24,16 @@ config ASPEED_LPC_SNOOP
>           allows the BMC to listen on and save the data written by
>           the host to an arbitrary LPC I/O port.
>
> +config ASPEED_LPC_MAILBOX
> +       tristate "ASPEED LPC mailbox support"
> +       select REGMAP
> +       select MFD_SYSCON
> +       default ARCH_ASPEED
> +       help
> +         Provides a driver to control the LPC mailbox which possesses
> +         up to 32 data registers for the communication between the Host
> +         and the BMC over LPC.
> +
>  config ASPEED_P2A_CTRL
>         tristate "ASPEED P2A (VGA MMIO to BMC) bridge control"
>         select REGMAP
> diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> index fcab7192e1a4..cde6b4514c97 100644
> --- a/drivers/soc/aspeed/Makefile
> +++ b/drivers/soc/aspeed/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_ASPEED_LPC_CTRL)  += aspeed-lpc-ctrl.o
> -obj-$(CONFIG_ASPEED_LPC_SNOOP) += aspeed-lpc-snoop.o
> -obj-$(CONFIG_ASPEED_P2A_CTRL)  += aspeed-p2a-ctrl.o
> -obj-$(CONFIG_ASPEED_SOCINFO)   += aspeed-socinfo.o
> +obj-$(CONFIG_ASPEED_LPC_CTRL)          += aspeed-lpc-ctrl.o
> +obj-$(CONFIG_ASPEED_LPC_SNOOP)         += aspeed-lpc-snoop.o
> +obj-$(CONFIG_ASPEED_LPC_MAILBOX)       += aspeed-lpc-mbox.o
> +obj-$(CONFIG_ASPEED_P2A_CTRL)          += aspeed-p2a-ctrl.o
> +obj-$(CONFIG_ASPEED_SOCINFO)           += aspeed-socinfo.o
> diff --git a/drivers/soc/aspeed/aspeed-lpc-mbox.c b/drivers/soc/aspeed/aspeed-lpc-mbox.c
> new file mode 100644
> index 000000000000..a09ca6a175f7
> --- /dev/null
> +++ b/drivers/soc/aspeed/aspeed-lpc-mbox.c
> @@ -0,0 +1,418 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2017 IBM Corporation
> + * Copyright 2021 Aspeed Technology Inc.
> + */
> +#include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/poll.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define DEVICE_NAME    "aspeed-mbox"
> +
> +#define ASPEED_MBOX_DR(dr, n)  (dr + (n * 4))
> +#define ASPEED_MBOX_STR(str, n)        (str + (n / 8) * 4)
> +#define ASPEED_MBOX_BIE(bie, n)        (bie + (n / 8) * 4)
> +#define ASPEED_MBOX_HIE(hie, n) (hie + (n / 8) * 4)
> +
> +#define ASPEED_MBOX_BCR_RECV   BIT(7)
> +#define ASPEED_MBOX_BCR_MASK   BIT(1)
> +#define ASPEED_MBOX_BCR_SEND   BIT(0)
> +
> +/* ioctl code */
> +#define ASPEED_MBOX_IOCTL              0xA3
> +#define ASPEED_MBOX_IOCTL_GET_SIZE     \
> +       _IOR(ASPEED_MBOX_IOCTL, 0, struct aspeed_mbox_ioctl_data)
> +
> +struct aspeed_mbox_ioctl_data {
> +       unsigned int data;
> +};
> +
> +struct aspeed_mbox_model {
> +       unsigned int dr_num;
> +
> +       /* offsets to the MBOX registers */
> +       unsigned int dr;
> +       unsigned int str;
> +       unsigned int bcr;
> +       unsigned int hcr;
> +       unsigned int bie;
> +       unsigned int hie;
> +};
> +
> +struct aspeed_mbox {
> +       struct miscdevice miscdev;
> +       struct regmap *map;
> +       unsigned int base;
> +       wait_queue_head_t queue;
> +       struct mutex mutex;
> +       const struct aspeed_mbox_model *model;
> +};
> +
> +static atomic_t aspeed_mbox_open_count = ATOMIC_INIT(0);
> +
> +static u8 aspeed_mbox_inb(struct aspeed_mbox *mbox, int reg)
> +{
> +       /*
> +        * The mbox registers are actually only one byte but are addressed
> +        * four bytes apart. The other three bytes are marked 'reserved',
> +        * they *should* be zero but lets not rely on it.
> +        * I am going to rely on the fact we can casually read/write to them...
> +        */
> +       unsigned int val = 0xff; /* If regmap throws an error return 0xff */
> +       int rc = regmap_read(mbox->map, mbox->base + reg, &val);
> +
> +       if (rc)
> +               dev_err(mbox->miscdev.parent, "regmap_read() failed with "
> +                       "%d (reg: 0x%08x)\n", rc, reg);
> +
> +       return val & 0xff;
> +}
> +
> +static void aspeed_mbox_outb(struct aspeed_mbox *mbox, u8 data, int reg)
> +{
> +       int rc = regmap_write(mbox->map, mbox->base + reg, data);
> +
> +       if (rc)
> +               dev_err(mbox->miscdev.parent, "regmap_write() failed with "
> +                       "%d (data: %u reg: 0x%08x)\n", rc, data, reg);
> +}
> +
> +static struct aspeed_mbox *file_mbox(struct file *file)
> +{
> +       return container_of(file->private_data, struct aspeed_mbox, miscdev);
> +}
> +
> +static int aspeed_mbox_open(struct inode *inode, struct file *file)
> +{
> +       struct aspeed_mbox *mbox = file_mbox(file);
> +       const struct aspeed_mbox_model *model = mbox->model;
> +
> +       if (atomic_inc_return(&aspeed_mbox_open_count) == 1) {
> +               /*
> +                * Clear the interrupt status bit if it was left on and unmask
> +                * interrupts.
> +                * ASPEED_MBOX_BCR_RECV bit is W1C, this also unmasks in 1 step
> +                */
> +               aspeed_mbox_outb(mbox, ASPEED_MBOX_BCR_RECV, model->bcr);
> +               return 0;
> +       }
> +
> +       atomic_dec(&aspeed_mbox_open_count);
> +       return -EBUSY;
> +}
> +
> +static ssize_t aspeed_mbox_read(struct file *file, char __user *buf,
> +                               size_t count, loff_t *ppos)
> +{
> +       struct aspeed_mbox *mbox = file_mbox(file);
> +       const struct aspeed_mbox_model *model = mbox->model;
> +       char __user *p = buf;
> +       ssize_t ret;
> +       int i;
> +
> +       if (!access_ok(buf, count))
> +               return -EFAULT;
> +
> +       if (count + *ppos > model->dr_num)
> +               return -EINVAL;
> +
> +       if (file->f_flags & O_NONBLOCK) {
> +               if (!(aspeed_mbox_inb(mbox, model->bcr) &
> +                               ASPEED_MBOX_BCR_RECV))
> +                       return -EAGAIN;
> +       } else if (wait_event_interruptible(mbox->queue,
> +                               aspeed_mbox_inb(mbox, model->bcr) &
> +                               ASPEED_MBOX_BCR_RECV)) {
> +               return -ERESTARTSYS;
> +       }
> +
> +       mutex_lock(&mbox->mutex);
> +
> +       for (i = *ppos; count > 0 && i < model->dr_num; i++) {
> +               uint8_t reg = aspeed_mbox_inb(mbox, ASPEED_MBOX_DR(model->dr, i));
> +
> +               ret = __put_user(reg, p);
> +               if (ret)
> +                       goto out_unlock;
> +
> +               p++;
> +               count--;
> +       }
> +
> +       /* ASPEED_MBOX_BCR_RECV bit is write to clear, this also unmasks in 1 step */
> +       aspeed_mbox_outb(mbox, ASPEED_MBOX_BCR_RECV, model->bcr);
> +       ret = p - buf;
> +
> +out_unlock:
> +       mutex_unlock(&mbox->mutex);
> +       return ret;
> +}
> +
> +static ssize_t aspeed_mbox_write(struct file *file, const char __user *buf,
> +                               size_t count, loff_t *ppos)
> +{
> +       struct aspeed_mbox *mbox = file_mbox(file);
> +       const struct aspeed_mbox_model *model = mbox->model;
> +       const char __user *p = buf;
> +       ssize_t ret;
> +       char c;
> +       int i;
> +
> +       if (!access_ok(buf, count))
> +               return -EFAULT;
> +
> +       if (count + *ppos > model->dr_num)
> +               return -EINVAL;
> +
> +       mutex_lock(&mbox->mutex);
> +
> +       for (i = *ppos; count > 0 && i < model->dr_num; i++) {
> +               ret = __get_user(c, p);
> +               if (ret)
> +                       goto out_unlock;
> +
> +               aspeed_mbox_outb(mbox, c, ASPEED_MBOX_DR(model->dr, i));
> +               p++;
> +               count--;
> +       }
> +
> +       aspeed_mbox_outb(mbox, ASPEED_MBOX_BCR_SEND, model->bcr);
> +       ret = p - buf;
> +
> +out_unlock:
> +       mutex_unlock(&mbox->mutex);
> +       return ret;
> +}
> +
> +static __poll_t aspeed_mbox_poll(struct file *file, poll_table *wait)
> +{
> +       struct aspeed_mbox *mbox = file_mbox(file);
> +       const struct aspeed_mbox_model *model = mbox->model;
> +       __poll_t mask = 0;
> +
> +       poll_wait(file, &mbox->queue, wait);
> +
> +       if (aspeed_mbox_inb(mbox, model->bcr) & ASPEED_MBOX_BCR_RECV)
> +               mask |= POLLIN;
> +
> +       return mask;
> +}
> +
> +static int aspeed_mbox_release(struct inode *inode, struct file *file)
> +{
> +       atomic_dec(&aspeed_mbox_open_count);
> +       return 0;
> +}
> +
> +static long aspeed_mbox_ioctl(struct file *file, unsigned int cmd,
> +                                unsigned long param)
> +{
> +       long ret = 0;
> +       struct aspeed_mbox *mbox = file_mbox(file);
> +       const struct aspeed_mbox_model *model = mbox->model;
> +       struct aspeed_mbox_ioctl_data data;
> +
> +       switch (cmd) {
> +       case ASPEED_MBOX_IOCTL_GET_SIZE:
> +               data.data = model->dr_num;
> +               if (copy_to_user((void __user *)param, &data, sizeof(data)))
> +                       ret = -EFAULT;
> +               break;
> +       default:
> +               ret = -ENOTTY;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct file_operations aspeed_mbox_fops = {
> +       .owner          = THIS_MODULE,
> +       .llseek         = no_seek_end_llseek,
> +       .read           = aspeed_mbox_read,
> +       .write          = aspeed_mbox_write,
> +       .open           = aspeed_mbox_open,
> +       .release        = aspeed_mbox_release,
> +       .poll           = aspeed_mbox_poll,
> +       .unlocked_ioctl = aspeed_mbox_ioctl,
> +};
> +
> +static irqreturn_t aspeed_mbox_irq(int irq, void *arg)
> +{
> +       struct aspeed_mbox *mbox = arg;
> +       const struct aspeed_mbox_model *model = mbox->model;
> +
> +       if (!(aspeed_mbox_inb(mbox, model->bcr) & ASPEED_MBOX_BCR_RECV))
> +               return IRQ_NONE;
> +
> +       /*
> +        * Leave the status bit set so that we know the data is for us,
> +        * clear it once it has been read.
> +        */
> +
> +       /* Mask it off, we'll clear it when we the data gets read */
> +       aspeed_mbox_outb(mbox, ASPEED_MBOX_BCR_MASK, model->bcr);
> +
> +       wake_up(&mbox->queue);
> +       return IRQ_HANDLED;
> +}
> +
> +static int aspeed_mbox_config_irq(struct aspeed_mbox *mbox,
> +               struct platform_device *pdev)
> +{
> +       const struct aspeed_mbox_model *model = mbox->model;
> +       struct device *dev = &pdev->dev;
> +       int i, rc, irq;
> +
> +       irq = irq_of_parse_and_map(dev->of_node, 0);
> +       if (!irq)
> +               return -ENODEV;
> +
> +       rc = devm_request_irq(dev, irq, aspeed_mbox_irq,
> +                       IRQF_SHARED, DEVICE_NAME, mbox);
> +       if (rc < 0) {
> +               dev_err(dev, "Unable to request IRQ %d\n", irq);
> +               return rc;
> +       }
> +
> +       /*
> +        * Disable all register based interrupts.
> +        */
> +       for (i = 0; i < model->dr_num / 8; ++i)
> +               aspeed_mbox_outb(mbox, 0x00, ASPEED_MBOX_BIE(model->bie, i));
> +
> +       /* These registers are write one to clear. Clear them. */
> +       for (i = 0; i < model->dr_num / 8; ++i)
> +               aspeed_mbox_outb(mbox, 0xff, ASPEED_MBOX_STR(model->str, i));
> +
> +       aspeed_mbox_outb(mbox, ASPEED_MBOX_BCR_RECV, model->bcr);
> +       return 0;
> +}
> +
> +static int aspeed_mbox_probe(struct platform_device *pdev)
> +{
> +       struct aspeed_mbox *mbox;
> +       struct device *dev;
> +       int rc;
> +
> +       dev = &pdev->dev;
> +
> +       mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +       if (!mbox)
> +               return -ENOMEM;
> +
> +       dev_set_drvdata(&pdev->dev, mbox);
> +
> +       rc = of_property_read_u32(dev->of_node, "reg", &mbox->base);
> +       if (rc) {
> +               dev_err(dev, "Couldn't read reg device tree property\n");
> +               return rc;
> +       }
> +
> +       mbox->model = of_device_get_match_data(dev);
> +       if (IS_ERR(mbox->model)) {
> +               dev_err(dev, "Couldn't get model data\n");
> +               return -ENODEV;
> +       }
> +
> +       mbox->map = syscon_node_to_regmap(
> +                       pdev->dev.parent->of_node);
> +       if (IS_ERR(mbox->map)) {
> +               dev_err(dev, "Couldn't get regmap\n");
> +               return -ENODEV;
> +       }
> +
> +       mutex_init(&mbox->mutex);
> +       init_waitqueue_head(&mbox->queue);
> +
> +       mbox->miscdev.minor = MISC_DYNAMIC_MINOR;
> +       mbox->miscdev.name = DEVICE_NAME;
> +       mbox->miscdev.fops = &aspeed_mbox_fops;
> +       mbox->miscdev.parent = dev;
> +       rc = misc_register(&mbox->miscdev);
> +       if (rc) {
> +               dev_err(dev, "Unable to register device\n");
> +               return rc;
> +       }
> +
> +       rc = aspeed_mbox_config_irq(mbox, pdev);
> +       if (rc) {
> +               dev_err(dev, "Failed to configure IRQ\n");
> +               misc_deregister(&mbox->miscdev);
> +               return rc;
> +       }
> +
> +       return 0;
> +}
> +
> +static int aspeed_mbox_remove(struct platform_device *pdev)
> +{
> +       struct aspeed_mbox *mbox = dev_get_drvdata(&pdev->dev);
> +
> +       misc_deregister(&mbox->miscdev);
> +
> +       return 0;
> +}
> +
> +static const struct aspeed_mbox_model ast2400_model = {
> +       .dr_num = 16,
> +       .dr     = 0x0,
> +       .str = 0x40,
> +       .bcr = 0x48,
> +       .hcr = 0x4c,
> +       .bie = 0x50,
> +       .hie = 0x58,
> +};
> +
> +static const struct aspeed_mbox_model ast2500_model = {
> +       .dr_num = 16,
> +       .dr     = 0x0,
> +       .str = 0x40,
> +       .bcr = 0x48,
> +       .hcr = 0x4c,
> +       .bie = 0x50,
> +       .hie = 0x58,
> +};
> +
> +static const struct aspeed_mbox_model ast2600_model = {
> +       .dr_num = 32,
> +       .dr     = 0x0,
> +       .str = 0x80,
> +       .bcr = 0x90,
> +       .hcr = 0x94,
> +       .bie = 0xa0,
> +       .hie = 0xb0,
> +};
> +
> +static const struct of_device_id aspeed_mbox_match[] = {
> +       { .compatible = "aspeed,ast2400-mbox",
> +         .data = &ast2400_model },
> +       { .compatible = "aspeed,ast2500-mbox",
> +         .data = &ast2500_model },
> +       { .compatible = "aspeed,ast2600-mbox",
> +         .data = &ast2600_model },
> +       { },
> +};
> +
> +static struct platform_driver aspeed_mbox_driver = {
> +       .driver = {
> +               .name           = DEVICE_NAME,
> +               .of_match_table = aspeed_mbox_match,
> +       },
> +       .probe = aspeed_mbox_probe,
> +       .remove = aspeed_mbox_remove,
> +};
> +
> +module_platform_driver(aspeed_mbox_driver);
> +MODULE_DEVICE_TABLE(of, aspeed_mbox_match);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Cyril Bur <cyrilbur@gmail.com>");
> +MODULE_AUTHOR("Chia-Wei Wang <chiawei_wang@aspeedtech.com");
> +MODULE_DESCRIPTION("Aspeed mailbox device driver");
> --
> 2.17.1
>
