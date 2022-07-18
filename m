Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168ED577939
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiGRBYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiGRBYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:24:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CB765EA;
        Sun, 17 Jul 2022 18:24:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t1so16937534lft.8;
        Sun, 17 Jul 2022 18:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVWub3H/B6UX3jdHLwvCDl0MxcH5fjBbnt1S3KD+3E4=;
        b=jn1vrwiFLvLL3hf3aUhkxFDp48jnEyi8XbZruka1/5DJZ6oSMpb9YJcHfGgAw2fNDU
         I9FgXs7xxGKxdqwiOiLTMAixT7vm6t8zYukONgNGdE701GfA5OMWn1OZ1kGWE8PNYG0b
         lCnvcOVbqxPZ9ZDmJ84DNmkZBCcUK88JaMuG7uzaJyF2RH7gsrAmGQAgPpZJGJ8vjlFP
         OTS0U81UI26PDnhVwBYYvSJqqYxCF0uMDapWgOl4vEJYxbm3NwiPlZdZKts/A+f/0vBx
         vQa8Y0YSMpB6ZYoKblK8krCWtjD8+2cubNS3jmcqYeL5qWHUQ1zN23GgWP9S+8SP82Ad
         C7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVWub3H/B6UX3jdHLwvCDl0MxcH5fjBbnt1S3KD+3E4=;
        b=GxZ6AXx9/Vc3GXwZQYVpUqeeYneAbGfvzrMaOpfKjq7CEcuZBiNkx+izIG3oJ9ObJ9
         Mrn0VMo8P/TSpzEQE5VQvfOLqARPek1iLYurj4ySv+RhqIJiJNuFeubfT7WWKNoLFNyH
         2RnQ2k7l9ufxMHV4TTEQ8f36xrQqPhYL8Gg2WyEo+/b+AQ0JCl/XhtgxMbdCDYMo9rpf
         RxrE64X6J58vBo0pLiLk3NaLI7U7zVNeBDCilKR6+58mWjba5PMd+z3nIx6Yp/znF4ZH
         FFAT+a6CuJ4oJUOnlf4K6kuZgxvoOnpYPDj2gBDK3TPz/d3yVdHIl701asI4iiuYjtOJ
         EMxA==
X-Gm-Message-State: AJIora8krxLNCDrGInHuQZZobSdY3F/Aw7r07I634V2Ui8Bh2f6LJ0Sj
        ogNiMkPMfvNuyNqZa2ZkE7irKD7NjMAs0/Xy1na9WQc722cRnHa+
X-Google-Smtp-Source: AGRyM1skJeX/by7ovznDKsVn0+Jtvta4NUTmj0xIoqn5TAfuP1TqmmNwNiLpbdKVVcunulmjusZ1ei8vrsQAdet5G9M=
X-Received: by 2002:ac2:4bc9:0:b0:48a:ad3:f226 with SMTP id
 o9-20020ac24bc9000000b0048a0ad3f226mr12403871lfq.200.1658107443470; Sun, 17
 Jul 2022 18:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220715234442.3910204-1-klimov.linux@gmail.com> <df046bcd-d8be-6606-a1fa-6399e5da534f@roeck-us.net>
In-Reply-To: <df046bcd-d8be-6606-a1fa-6399e5da534f@roeck-us.net>
From:   Alexey Klimov <klimov.linux@gmail.com>
Date:   Mon, 18 Jul 2022 02:23:51 +0100
Message-ID: <CALW4P++23LZ3w6cueyr-WB-gj4Tb-pRxnzV2QqGiB0hg8NiR3w@mail.gmail.com>
Subject: Re: [PATCH v4] watchdog: add driver for StreamLabs USB watchdog device
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        Oliver Neukum <oneukum@suse.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        atishp@rivosinc.com, atishp@atishpatra.org,
        Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Aaron Tomlin <atomlin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 1:33 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/15/22 16:44, Alexey Klimov wrote:
> > Driver supports StreamLabs usb watchdog device. The device plugs
> > into 9-pin usb header and connects to reset pins and reset button
> > pins on desktop PC.
> >
> > USB commands used to communicate with device were reverse
> > engineered using usbmon.
> >
> > Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
>
> Please run checkpatch --strict and fix what it reports.

Thanks, didn't know about that option.
Also kernel test robot reported some warning -- need to fix that too.

> > ---
> >
> > Changes since v3:
> >       -- added nowayout module param;
> >       -- removed usb_set_intfdata(intf, NULL) in ->disconnect since
> >       usb_unbind_interface() should take care of it;
> >       -- keep the usb_streamlabs_wdt_stop_cmd() in ->disconnect().
> >       Disconnect can be triggered via sysfs or on module removing,
> >       it looks like we want to stop the watchdog on such events;
> >       Should it also be stopped in ->disconnect() only if !nowayout?
> >       -- rebased, cleanups, URL correction;
> >       -- migrated to managed (devm_*) interfaces;
> >       -- error in usb_streamlabs_wdt_validate_response() changed
> >       to -EPROTO;
> >       -- added entry in MAINTAINERS file;
> >       -- const struct usb_device_id and watchdog_ops;
> >
> > Previous version:
> > https://lore.kernel.org/lkml/20170217092523.23358-1-klimov.linux@gmail.com/
> >
> >   MAINTAINERS                       |   6 +
> >   drivers/watchdog/Kconfig          |  15 ++
> >   drivers/watchdog/Makefile         |   1 +
> >   drivers/watchdog/streamlabs_wdt.c | 311 ++++++++++++++++++++++++++++++
> >   4 files changed, 333 insertions(+)
> >   create mode 100644 drivers/watchdog/streamlabs_wdt.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a5f65e7a113d..717d39a2d874 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19120,6 +19120,12 @@ W:   http://www.stlinux.com
> >   F:  Documentation/networking/device_drivers/ethernet/stmicro/
> >   F:  drivers/net/ethernet/stmicro/stmmac/
> >
> > +STREAMLABS USB WATCHDOG DRIVER
> > +M:   Alexey Klimov <klimov.linux@gmail.com>
> > +L:   linux-watchdog@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/watchdog/streamlabs_wdt.c
> > +
> >   SUN3/3X
> >   M:  Sam Creasey <sammy@sammy.net>
> >   S:  Maintained
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 32fd37698932..64b7f947b196 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -2171,6 +2171,21 @@ config USBPCWATCHDOG
> >
> >         Most people will say N.
> >
> > +config USB_STREAMLABS_WATCHDOG
> > +     tristate "StreamLabs USB watchdog driver"
> > +     depends on USB
> > +     help
> > +       This is the driver for the USB Watchdog dongle from StreamLabs.
> > +       If you correctly connect reset pins to motherboard Reset pin and
> > +       to Reset button then this device will simply watch your kernel to make
> > +       sure it doesn't freeze, and if it does, it reboots your computer
> > +       after a certain amount of time.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called streamlabs_wdt.
> > +
> > +       Most people will say N. Say yes or M if you want to use such usb device.
> > +
> >   config KEEMBAY_WATCHDOG
> >       tristate "Intel Keem Bay SoC non-secure watchdog"
> >       depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index c324e9d820e9..2d601da9b5bd 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -33,6 +33,7 @@ obj-$(CONFIG_WDTPCI) += wdt_pci.o
> >
> >   # USB-based Watchdog Cards
> >   obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
> > +obj-$(CONFIG_USB_STREAMLABS_WATCHDOG) += streamlabs_wdt.o
> >
> >   # ALPHA Architecture
> >
> > diff --git a/drivers/watchdog/streamlabs_wdt.c b/drivers/watchdog/streamlabs_wdt.c
> > new file mode 100644
> > index 000000000000..f2b782f3c98e
> > --- /dev/null
> > +++ b/drivers/watchdog/streamlabs_wdt.c
> > @@ -0,0 +1,311 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * StreamLabs USB Watchdog driver
> > + *
> > + * Copyright (c) 2016-2017,2022 Alexey Klimov <klimov.linux@gmail.com>
> > + */
> > +
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <linux/usb.h>
> > +#include <linux/watchdog.h>
> > +#include <asm/byteorder.h>
> > +
> > +/*
> > + * USB Watchdog device from Streamlabs:
> > + * https://www.stream-labs.com/products/devices/watch-dog/
> > + *
> > + * USB commands have been reverse engineered using usbmon.
> > + */
> > +
> > +#define DRIVER_AUTHOR "Alexey Klimov <klimov.linux@gmail.com>"
> > +#define DRIVER_DESC "StreamLabs USB watchdog driver"
> > +#define DRIVER_NAME "usb_streamlabs_wdt"
> > +
> > +MODULE_AUTHOR(DRIVER_AUTHOR);
> > +MODULE_DESCRIPTION(DRIVER_DESC);
> > +MODULE_LICENSE("GPL");
> > +
> > +#define USB_STREAMLABS_WATCHDOG_VENDOR       0x13c0
> > +#define USB_STREAMLABS_WATCHDOG_PRODUCT      0x0011
> > +
> > +/*
> > + * one buffer is used for communication, however transmitted message is only
> > + * 32 bytes long
> > + */
> > +#define BUFFER_TRANSFER_LENGTH       32
> > +#define BUFFER_LENGTH                64
> > +#define USB_TIMEOUT          350
> > +
> > +#define STREAMLABS_CMD_START 0xaacc
> > +#define STREAMLABS_CMD_STOP  0xbbff
> > +
> > +/* timeout values are taken from windows program */
> > +#define STREAMLABS_WDT_MIN_TIMEOUT   1
> > +#define STREAMLABS_WDT_MAX_TIMEOUT   46
> > +
> > +struct streamlabs_wdt {
> > +     struct watchdog_device wdt_dev;
> > +     struct usb_interface *intf;
> > +     struct mutex lock;
> > +     u8 *buffer;
> > +};
> > +
> > +static bool nowayout = WATCHDOG_NOWAYOUT;
> > +module_param(nowayout, bool, 0);
> > +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> > +                     __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> > +
> > +/*
> > + * This function is used to check if watchdog actually changed
> > + * its state to disabled that is reported in first two bytes of response
> > + * message.
> > + */
> > +static int usb_streamlabs_wdt_check_stop(u16 *buf)
> > +{
> > +     if (buf[0] != cpu_to_le16(STREAMLABS_CMD_STOP))
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +
> > +static int usb_streamlabs_wdt_validate_response(u8 *buf)
> > +{
> > +     /*
> > +      * If watchdog device understood the command it will acknowledge
> > +      * with values 1,2,3,4 at indexes 10, 11, 12, 13 in response message
> > +      * when response treated as 8bit message.
> > +      */
> > +     if (buf[10] != 1 || buf[11] != 2 || buf[12] != 3 || buf[13] != 4)
> > +             return -EPROTO;
> > +
> > +     return 0;
> > +}
> > +
> > +static void usb_streamlabs_wdt_prepare_buf(u16 *buf, u16 cmd,
> > +                                             unsigned long timeout_msec)
> > +{
> > +     /*
> > +      * remaining elements expected to be zero everytime during
> > +      * communication
> > +      */
> > +     buf[0] = cpu_to_le16(cmd);
> > +     buf[1] = cpu_to_le16(0x8000);
> > +     buf[3] = cpu_to_le16(timeout_msec);
> > +     buf[5] = 0x0;
> > +     buf[6] = 0x0;
> > +}
> > +
> > +static int usb_streamlabs_wdt_cmd(struct streamlabs_wdt *wdt, u16 cmd)
> > +{
> > +     struct usb_device *usbdev;
> > +     unsigned long timeout_msec;
> > +     int retval;
> > +     int size;
> > +
> > +     if (unlikely(!wdt->intf))
> > +             return -ENODEV;
> > +
> > +     usbdev = interface_to_usbdev(wdt->intf);
> > +     timeout_msec = wdt->wdt_dev.timeout * MSEC_PER_SEC;
> > +
> > +     usb_streamlabs_wdt_prepare_buf((u16 *) wdt->buffer, cmd, timeout_msec);
> > +
> > +     /* send command to watchdog */
> > +     retval = usb_interrupt_msg(usbdev, usb_sndintpipe(usbdev, 0x02),
> > +                                     wdt->buffer, BUFFER_TRANSFER_LENGTH,
> > +                                     &size, USB_TIMEOUT);
> > +     if (retval)
> > +             return retval;
> > +
> > +     if (size != BUFFER_TRANSFER_LENGTH)
> > +             return -EIO;
> > +
> > +     /* and read response from watchdog */
> > +     retval = usb_interrupt_msg(usbdev, usb_rcvintpipe(usbdev, 0x81),
> > +                                     wdt->buffer, BUFFER_LENGTH,
> > +                                     &size, USB_TIMEOUT);
>
> How do you know this is the response to the current command
> and not the response to some previous command ? If there are
> unread messages queued in the receive pipe which were never retrieved
> you might just retrieve those old messages.
>
> At the very least there needs to be an explanation why this doesn't
> happen (if it doesn't).

Let me answer below.


> > +     if (retval)
> > +             return retval;
> > +
> > +     if (size != BUFFER_LENGTH)
> > +             return -EIO;
> > +
> > +     /* check if watchdog actually acked/recognized command */
> > +     return usb_streamlabs_wdt_validate_response(wdt->buffer);
> > +}
> > +
> > +static int usb_streamlabs_wdt_stop_cmd(struct streamlabs_wdt *wdt)
> > +{
> > +     /* how many times to re-send stop cmd */
> > +     int retry_counter = 10;
> > +     int retval;
> > +
> > +     /*
> > +      * Transition from enabled to disabled state in this device
> > +      * for stop command doesn't happen immediately. Usually, 2 or 3
> > +      * (sometimes even 4) stop commands should be sent until
> > +      * watchdog answers 'I'm stopped!'.
> > +      * Retry only stop command if watchdog fails to answer correctly
> > +      * about its state. After 10 attempts go out and return error.
> > +      */
> > +
> > +     do {
> > +             retval = usb_streamlabs_wdt_cmd(wdt, STREAMLABS_CMD_STOP);
> > +             if (retval)
> > +                     break;
> > +
> > +             retval = usb_streamlabs_wdt_check_stop((u16 *) wdt->buffer);
> > +
>
> Does it really make sense to keep resending immediately, or would it be
> better to wait a bit in between ? Also, I am a bit concerned that the
> "response" message retrieved in usb_streamlabs_wdt_cmd() may actually
> be the response to some previous command.

The driver here tries to reproduce the behaviour of the driver under
another operating system and if I recall correctly just does the same
things like it is done there. Nobody here is saying that it is perfect
doing things according to datasheet (which I don't have) and commands
were reverse engineered.
The code like this was tested for couple of years on two motherboards.
If you think that this is not the place for this in under
drivers/watchdog/ then maybe this can go via staging tree. Or what do
you suggest? I am also not planning to disappear and want to handle
issues with this driver if there will be any.

Now regarding the retrieving the potentially stale status or responses
to old commands.
That is a good catch! Thank you.
I have zero knowledge about what's going on there internally, if there
are any queued messages in the pipe or the usb retrieving messages
just "read" the current state.

I started to experiment with different approaches.
So far seems like delays between sending the command to device and
retrieving the response do not change anything, I tried up to 1.5
seconds before retrieving the status.

However, I notice that usb_streamlabs_wdt_cmd() retrieves the stale
data and _really_ may get the response to the previous command. It
could be true and correct.

I observed that even on start command it got the "stop" response:
ffff888100caab40 217899972 S Io:005:02 -115 32 = ccaa0080 000010a4
00000000 00000000 00000000 00000000 00000000 00000000
^^^ start cmd
ffff888100caab40 217908487 C Io:005:02 0 32 >
ffff888100caab40 217908527 S Ii:005:01 -115 64 <
ffff888100caab40 217909500 C Ii:005:01 0 64 = ffbb0080 000010a4
00000102 03040000 00000000 00000000 00000000 00000000
^^^ device answers "i am stopped"

I am thinking to implement something like this:

mutex_lock();
send_command();
keep retrieving the responses until we observe that:
 -- the retrieved status if the device matches the command that was sent;
 -- and for start command the "read" timeout is the same that was sent;
 -- and the response says that the command was successful;
mutex_unlock();

Let's say I can spin the retrieving loop with maximum retry counter 10
(like it is currently done for stop command) and report error about
communicating with the device when counter reaches zero. Or I can even
export the counter value as a module parameter.

What are your thoughts on this? Any suggestions?

> > +     } while (retval && --retry_counter >= 0);
> > +
> > +     return retry_counter > 0 ? retval : -EIO;
> > +}
> > +
> > +static int usb_streamlabs_wdt_start(struct watchdog_device *wdt_dev)
> > +{
> > +     struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
> > +     int retval;
> > +
> > +     mutex_lock(&streamlabs_wdt->lock);
> > +     retval = usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_START);
> > +     mutex_unlock(&streamlabs_wdt->lock);
> > +
> > +     return retval;
> > +}
> > +
> > +static int usb_streamlabs_wdt_stop(struct watchdog_device *wdt_dev)
> > +{
> > +     struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
> > +     int retval;
> > +
> > +     mutex_lock(&streamlabs_wdt->lock);
> > +     retval = usb_streamlabs_wdt_stop_cmd(streamlabs_wdt);
> > +     mutex_unlock(&streamlabs_wdt->lock);
> > +
> > +     return retval;
> > +}
> > +
> > +static const struct watchdog_info streamlabs_wdt_ident = {
> > +     .options        = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> > +     .identity       = DRIVER_NAME,
> > +};
> > +
> > +static const struct watchdog_ops usb_streamlabs_wdt_ops = {
> > +     .owner  = THIS_MODULE,
> > +     .start  = usb_streamlabs_wdt_start,
> > +     .stop   = usb_streamlabs_wdt_stop,
> > +};
> > +
> > +static int usb_streamlabs_wdt_probe(struct usb_interface *intf,
> > +                                     const struct usb_device_id *id)
> > +{
> > +     struct usb_device *usbdev = interface_to_usbdev(intf);
> > +     struct streamlabs_wdt *streamlabs_wdt;
> > +     int retval;
> > +
> > +     /*
> > +      * USB IDs of this device appear to be weird/unregistered. Hence, do
> > +      * an additional check on product and manufacturer.
> > +      * If there is similar device in the field with same values then
> > +      * there is stop command in probe() below that checks if the device
> > +      * behaves as a watchdog.
> > +      */
> > +     if (!usbdev->product || !usbdev->manufacturer
> > +             || strncmp(usbdev->product, "USBkit", 6)
> > +             || strncmp(usbdev->manufacturer, "STREAM LABS", 11))
> > +             return -ENODEV;
> > +
> > +     streamlabs_wdt = devm_kzalloc(&intf->dev, sizeof(struct streamlabs_wdt),
> > +                                                             GFP_KERNEL);
> > +     if (!streamlabs_wdt)
> > +             return -ENOMEM;
> > +
> > +     streamlabs_wdt->buffer = devm_kzalloc(&intf->dev, BUFFER_LENGTH,
> > +                                                             GFP_KERNEL);
> > +     if (!streamlabs_wdt->buffer)
> > +             return -ENOMEM;
> > +
> > +     mutex_init(&streamlabs_wdt->lock);
> > +
> > +     streamlabs_wdt->wdt_dev.info = &streamlabs_wdt_ident;
> > +     streamlabs_wdt->wdt_dev.ops = &usb_streamlabs_wdt_ops;
> > +     streamlabs_wdt->wdt_dev.timeout = STREAMLABS_WDT_MAX_TIMEOUT;
> > +     streamlabs_wdt->wdt_dev.max_timeout = STREAMLABS_WDT_MAX_TIMEOUT;
> > +     streamlabs_wdt->wdt_dev.min_timeout = STREAMLABS_WDT_MIN_TIMEOUT;
> > +     streamlabs_wdt->wdt_dev.parent = &intf->dev;
> > +
> > +     streamlabs_wdt->intf = intf;
> > +     usb_set_intfdata(intf, &streamlabs_wdt->wdt_dev);
> > +     watchdog_set_drvdata(&streamlabs_wdt->wdt_dev, streamlabs_wdt);
> > +     watchdog_set_nowayout(&streamlabs_wdt->wdt_dev, nowayout);
> > +
> > +     retval = usb_streamlabs_wdt_stop(&streamlabs_wdt->wdt_dev);
> > +     if (retval)
> > +             return -ENODEV;
> > +
> > +     retval = devm_watchdog_register_device(&intf->dev,
> > +                                             &streamlabs_wdt->wdt_dev);
> > +     if (retval) {
> > +             dev_err(&intf->dev, "failed to register watchdog device\n");
> > +             return retval;
> > +     }
> > +
> > +     dev_info(&intf->dev, "StreamLabs USB watchdog driver loaded.\n");
> > +     return 0;
> > +}
> > +
> > +static int usb_streamlabs_wdt_suspend(struct usb_interface *intf,
> > +                                     pm_message_t message)
> > +{
> > +     struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
> > +
> > +     if (watchdog_active(&streamlabs_wdt->wdt_dev))
> > +             return usb_streamlabs_wdt_stop(&streamlabs_wdt->wdt_dev);
> > +
> > +     return 0;
> > +}
> > +
> > +static int usb_streamlabs_wdt_resume(struct usb_interface *intf)
> > +{
> > +     struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
> > +
> > +     if (watchdog_active(&streamlabs_wdt->wdt_dev))
> > +             return usb_streamlabs_wdt_start(&streamlabs_wdt->wdt_dev);
> > +
> > +     return 0;
> > +}
> > +
> > +static void usb_streamlabs_wdt_disconnect(struct usb_interface *intf)
> > +{
> > +     struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
> > +
> > +     mutex_lock(&streamlabs_wdt->lock);
> > +     usb_streamlabs_wdt_stop_cmd(streamlabs_wdt);
> > +     /* Stop sending messages to the device */
> > +     streamlabs_wdt->intf = NULL;
> > +     mutex_unlock(&streamlabs_wdt->lock);
> > +}
>
> Tis leaves the watchdog device in place even though it has been disconnected.
> This is, at the very least, unusual, and doesn't really make sense.
> Please explain. Also, wWhat happens when it is reconnected ?

Not sure what you mean. release_nodes() takes care about removing
watchdog device.
devm_watchdog_register_device() works on top of device resource
management framework.
Upon removing the device it should take care of freeing the resources.
The exact path for instance for rmmod will be (from bottom to top):

watchdog_unregister_device
release_nodes
devres_release_all
device_unbind_cleanup
device_release_driver_internal
driver_detach
bus_remove_driver
usb_deregister
__do_sys_delete_module

or on disconnect via sysfs:
 watchdog_unregister_device
 release_nodes
 devres_release_all
 device_unbind_cleanup
 device_release_driver_internal
 bus_remove_device
 device_del
 usb_disable_device
 usb_set_configuration
 usb_unbind_device
 device_release_driver_internal
 unbind_store
 kernfs_fop_write_iter
 new_sync_write
 vfs_write
 ksys_write
 do_syscall_64

On reconnection the usb framework calls ->probe() method.
For instance, the more info is in Documentation/driver-api/usb/callbacks.rst

Thank you for the review.

Thanks,
Alexey
