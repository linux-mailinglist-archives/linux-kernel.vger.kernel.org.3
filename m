Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE637576DF2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 14:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiGPMdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 08:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiGPMdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 08:33:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0656E1EC72;
        Sat, 16 Jul 2022 05:33:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w7so5294250ply.12;
        Sat, 16 Jul 2022 05:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=MKS3K/qu7LZc/Loe5tqCkJETrf4FLpRaiv4LThbOSeI=;
        b=d6nlbBXlzrrkVZOAMz5SnOzcoJbjKl5R3wMiQAm4svIDGnmO3NeqAfFOznwWdjSuZP
         NIn1R0K+Rr1CW7cg4kaKXx+0QO7iCjB9AgEw5prpY/S+XEepwEFl3VUOf1xqx7fKg00S
         2Ld5jqaf4mDW0sTaz9/YOa8zmJX/kjCfCGzGy+vY5xjDSMbeF0tYAyVt1lWEya8uQrm+
         00wdD7FYwud1tUJHAWGwkWbRU/0jWIt6m3MDA3wSUi2pCCCQBLDe+KzMQ5JpHs4G/Lu2
         6kWS1bgHmY5MDkWj92zWE2SIcJG7MkRkReq27mtRofsKgn11Rjp7oWkUEcSDCKJHZCMh
         q00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=MKS3K/qu7LZc/Loe5tqCkJETrf4FLpRaiv4LThbOSeI=;
        b=EuRI8Hx6imzhGtgkDDNyLblDSGCemQZeizr887WfdHEY1bypWNo1uGQaRApWgX5Ntb
         GapDHRgaGIhcJ33wG1qvGqDRMaEnJBy13XF48N0ixBb1f5PZI1tloh2ZbtRUU7ct5dGE
         mxh+4YiA4v4Jf33A/qyySPLj4NIbVOcaXGUOHeIchw5dIAoBYy1J4MNXH1CmUWARdPjz
         BL6XO+Vq1zqnY4tU9XrvCvBaG01Q0u+bPHUTo/6Jo+SXNV1nQ1BbRnXXYf3e8C4CiyQr
         kCFWHoJooj8LOaKzacn+5zzpAOyu66CokZvOcuEsAVXHkA9kP612ySGvaeu8lYB/x7sG
         dDdg==
X-Gm-Message-State: AJIora8JQglZAXNQvPESmcxe0TjW0XKQZNTa7m2gBZ3pyBmAbKq5uQxG
        cRLW1ZZtrcll4EisfOptzkLIHEb5Lp1PwQ==
X-Google-Smtp-Source: AGRyM1sKafAftYprPFaOv0roY7UuXnpxUxTmll9YfRRTwu8eUvMwIOuiN2is4UKUukPtbVRrTWgTLQ==
X-Received: by 2002:a17:903:260e:b0:16b:deaf:970a with SMTP id jd14-20020a170903260e00b0016bdeaf970amr18075425plb.121.1657974813149;
        Sat, 16 Jul 2022 05:33:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r5-20020aa79885000000b00525442ac579sm5736021pfl.212.2022.07.16.05.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 05:33:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <df046bcd-d8be-6606-a1fa-6399e5da534f@roeck-us.net>
Date:   Sat, 16 Jul 2022 05:32:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Alexey Klimov <klimov.linux@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, oneukum@suse.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        atishp@rivosinc.com, atishp@atishpatra.org, yury.norov@gmail.com,
        aklimov@redhat.com, atomlin@redhat.com
References: <20220715234442.3910204-1-klimov.linux@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] watchdog: add driver for StreamLabs USB watchdog
 device
In-Reply-To: <20220715234442.3910204-1-klimov.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 16:44, Alexey Klimov wrote:
> Driver supports StreamLabs usb watchdog device. The device plugs
> into 9-pin usb header and connects to reset pins and reset button
> pins on desktop PC.
> 
> USB commands used to communicate with device were reverse
> engineered using usbmon.
> 
> Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>

Please run checkpatch --strict and fix what it reports.

> ---
> 
> Changes since v3:
> 	-- added nowayout module param;
> 	-- removed usb_set_intfdata(intf, NULL) in ->disconnect since
> 	usb_unbind_interface() should take care of it;
> 	-- keep the usb_streamlabs_wdt_stop_cmd() in ->disconnect().
> 	Disconnect can be triggered via sysfs or on module removing,
> 	it looks like we want to stop the watchdog on such events;
> 	Should it also be stopped in ->disconnect() only if !nowayout?
> 	-- rebased, cleanups, URL correction;
> 	-- migrated to managed (devm_*) interfaces;
> 	-- error in usb_streamlabs_wdt_validate_response() changed
> 	to -EPROTO;
> 	-- added entry in MAINTAINERS file;
> 	-- const struct usb_device_id and watchdog_ops;
> 
> Previous version:
> https://lore.kernel.org/lkml/20170217092523.23358-1-klimov.linux@gmail.com/
> 
>   MAINTAINERS                       |   6 +
>   drivers/watchdog/Kconfig          |  15 ++
>   drivers/watchdog/Makefile         |   1 +
>   drivers/watchdog/streamlabs_wdt.c | 311 ++++++++++++++++++++++++++++++
>   4 files changed, 333 insertions(+)
>   create mode 100644 drivers/watchdog/streamlabs_wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5f65e7a113d..717d39a2d874 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19120,6 +19120,12 @@ W:	http://www.stlinux.com
>   F:	Documentation/networking/device_drivers/ethernet/stmicro/
>   F:	drivers/net/ethernet/stmicro/stmmac/
>   
> +STREAMLABS USB WATCHDOG DRIVER
> +M:	Alexey Klimov <klimov.linux@gmail.com>
> +L:	linux-watchdog@vger.kernel.org
> +S:	Maintained
> +F:	drivers/watchdog/streamlabs_wdt.c
> +
>   SUN3/3X
>   M:	Sam Creasey <sammy@sammy.net>
>   S:	Maintained
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 32fd37698932..64b7f947b196 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2171,6 +2171,21 @@ config USBPCWATCHDOG
>   
>   	  Most people will say N.
>   
> +config USB_STREAMLABS_WATCHDOG
> +	tristate "StreamLabs USB watchdog driver"
> +	depends on USB
> +	help
> +	  This is the driver for the USB Watchdog dongle from StreamLabs.
> +	  If you correctly connect reset pins to motherboard Reset pin and
> +	  to Reset button then this device will simply watch your kernel to make
> +	  sure it doesn't freeze, and if it does, it reboots your computer
> +	  after a certain amount of time.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called streamlabs_wdt.
> +
> +	  Most people will say N. Say yes or M if you want to use such usb device.
> +
>   config KEEMBAY_WATCHDOG
>   	tristate "Intel Keem Bay SoC non-secure watchdog"
>   	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index c324e9d820e9..2d601da9b5bd 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_WDTPCI) += wdt_pci.o
>   
>   # USB-based Watchdog Cards
>   obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
> +obj-$(CONFIG_USB_STREAMLABS_WATCHDOG) += streamlabs_wdt.o
>   
>   # ALPHA Architecture
>   
> diff --git a/drivers/watchdog/streamlabs_wdt.c b/drivers/watchdog/streamlabs_wdt.c
> new file mode 100644
> index 000000000000..f2b782f3c98e
> --- /dev/null
> +++ b/drivers/watchdog/streamlabs_wdt.c
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StreamLabs USB Watchdog driver
> + *
> + * Copyright (c) 2016-2017,2022 Alexey Klimov <klimov.linux@gmail.com>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/usb.h>
> +#include <linux/watchdog.h>
> +#include <asm/byteorder.h>
> +
> +/*
> + * USB Watchdog device from Streamlabs:
> + * https://www.stream-labs.com/products/devices/watch-dog/
> + *
> + * USB commands have been reverse engineered using usbmon.
> + */
> +
> +#define DRIVER_AUTHOR "Alexey Klimov <klimov.linux@gmail.com>"
> +#define DRIVER_DESC "StreamLabs USB watchdog driver"
> +#define DRIVER_NAME "usb_streamlabs_wdt"
> +
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("GPL");
> +
> +#define USB_STREAMLABS_WATCHDOG_VENDOR	0x13c0
> +#define USB_STREAMLABS_WATCHDOG_PRODUCT	0x0011
> +
> +/*
> + * one buffer is used for communication, however transmitted message is only
> + * 32 bytes long
> + */
> +#define BUFFER_TRANSFER_LENGTH	32
> +#define BUFFER_LENGTH		64
> +#define USB_TIMEOUT		350
> +
> +#define STREAMLABS_CMD_START	0xaacc
> +#define STREAMLABS_CMD_STOP	0xbbff
> +
> +/* timeout values are taken from windows program */
> +#define STREAMLABS_WDT_MIN_TIMEOUT	1
> +#define STREAMLABS_WDT_MAX_TIMEOUT	46
> +
> +struct streamlabs_wdt {
> +	struct watchdog_device wdt_dev;
> +	struct usb_interface *intf;
> +	struct mutex lock;
> +	u8 *buffer;
> +};
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +/*
> + * This function is used to check if watchdog actually changed
> + * its state to disabled that is reported in first two bytes of response
> + * message.
> + */
> +static int usb_streamlabs_wdt_check_stop(u16 *buf)
> +{
> +	if (buf[0] != cpu_to_le16(STREAMLABS_CMD_STOP))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int usb_streamlabs_wdt_validate_response(u8 *buf)
> +{
> +	/*
> +	 * If watchdog device understood the command it will acknowledge
> +	 * with values 1,2,3,4 at indexes 10, 11, 12, 13 in response message
> +	 * when response treated as 8bit message.
> +	 */
> +	if (buf[10] != 1 || buf[11] != 2 || buf[12] != 3 || buf[13] != 4)
> +		return -EPROTO;
> +
> +	return 0;
> +}
> +
> +static void usb_streamlabs_wdt_prepare_buf(u16 *buf, u16 cmd,
> +						unsigned long timeout_msec)
> +{
> +	/*
> +	 * remaining elements expected to be zero everytime during
> +	 * communication
> +	 */
> +	buf[0] = cpu_to_le16(cmd);
> +	buf[1] = cpu_to_le16(0x8000);
> +	buf[3] = cpu_to_le16(timeout_msec);
> +	buf[5] = 0x0;
> +	buf[6] = 0x0;
> +}
> +
> +static int usb_streamlabs_wdt_cmd(struct streamlabs_wdt *wdt, u16 cmd)
> +{
> +	struct usb_device *usbdev;
> +	unsigned long timeout_msec;
> +	int retval;
> +	int size;
> +
> +	if (unlikely(!wdt->intf))
> +		return -ENODEV;
> +
> +	usbdev = interface_to_usbdev(wdt->intf);
> +	timeout_msec = wdt->wdt_dev.timeout * MSEC_PER_SEC;
> +
> +	usb_streamlabs_wdt_prepare_buf((u16 *) wdt->buffer, cmd, timeout_msec);
> +
> +	/* send command to watchdog */
> +	retval = usb_interrupt_msg(usbdev, usb_sndintpipe(usbdev, 0x02),
> +					wdt->buffer, BUFFER_TRANSFER_LENGTH,
> +					&size, USB_TIMEOUT);
> +	if (retval)
> +		return retval;
> +
> +	if (size != BUFFER_TRANSFER_LENGTH)
> +		return -EIO;
> +
> +	/* and read response from watchdog */
> +	retval = usb_interrupt_msg(usbdev, usb_rcvintpipe(usbdev, 0x81),
> +					wdt->buffer, BUFFER_LENGTH,
> +					&size, USB_TIMEOUT);

How do you know this is the response to the current command
and not the response to some previous command ? If there are
unread messages queued in the receive pipe which were never retrieved
you might just retrieve those old messages.

At the very least there needs to be an explanation why this doesn't
happen (if it doesn't).

> +	if (retval)
> +		return retval;
> +
> +	if (size != BUFFER_LENGTH)
> +		return -EIO;
> +
> +	/* check if watchdog actually acked/recognized command */
> +	return usb_streamlabs_wdt_validate_response(wdt->buffer);
> +}
> +
> +static int usb_streamlabs_wdt_stop_cmd(struct streamlabs_wdt *wdt)
> +{
> +	/* how many times to re-send stop cmd */
> +	int retry_counter = 10;
> +	int retval;
> +
> +	/*
> +	 * Transition from enabled to disabled state in this device
> +	 * for stop command doesn't happen immediately. Usually, 2 or 3
> +	 * (sometimes even 4) stop commands should be sent until
> +	 * watchdog answers 'I'm stopped!'.
> +	 * Retry only stop command if watchdog fails to answer correctly
> +	 * about its state. After 10 attempts go out and return error.
> +	 */
> +
> +	do {
> +		retval = usb_streamlabs_wdt_cmd(wdt, STREAMLABS_CMD_STOP);
> +		if (retval)
> +			break;
> +
> +		retval = usb_streamlabs_wdt_check_stop((u16 *) wdt->buffer);
> +

Does it really make sense to keep resending immediately, or would it be
better to wait a bit in between ? Also, I am a bit concerned that the
"response" message retrieved in usb_streamlabs_wdt_cmd() may actually
be the response to some previous command.

> +	} while (retval && --retry_counter >= 0);
> +
> +	return retry_counter > 0 ? retval : -EIO;
> +}
> +
> +static int usb_streamlabs_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
> +	int retval;
> +
> +	mutex_lock(&streamlabs_wdt->lock);
> +	retval = usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_START);
> +	mutex_unlock(&streamlabs_wdt->lock);
> +
> +	return retval;
> +}
> +
> +static int usb_streamlabs_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
> +	int retval;
> +
> +	mutex_lock(&streamlabs_wdt->lock);
> +	retval = usb_streamlabs_wdt_stop_cmd(streamlabs_wdt);
> +	mutex_unlock(&streamlabs_wdt->lock);
> +
> +	return retval;
> +}
> +
> +static const struct watchdog_info streamlabs_wdt_ident = {
> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.identity	= DRIVER_NAME,
> +};
> +
> +static const struct watchdog_ops usb_streamlabs_wdt_ops = {
> +	.owner	= THIS_MODULE,
> +	.start	= usb_streamlabs_wdt_start,
> +	.stop	= usb_streamlabs_wdt_stop,
> +};
> +
> +static int usb_streamlabs_wdt_probe(struct usb_interface *intf,
> +					const struct usb_device_id *id)
> +{
> +	struct usb_device *usbdev = interface_to_usbdev(intf);
> +	struct streamlabs_wdt *streamlabs_wdt;
> +	int retval;
> +
> +	/*
> +	 * USB IDs of this device appear to be weird/unregistered. Hence, do
> +	 * an additional check on product and manufacturer.
> +	 * If there is similar device in the field with same values then
> +	 * there is stop command in probe() below that checks if the device
> +	 * behaves as a watchdog.
> +	 */
> +	if (!usbdev->product || !usbdev->manufacturer
> +		|| strncmp(usbdev->product, "USBkit", 6)
> +		|| strncmp(usbdev->manufacturer, "STREAM LABS", 11))
> +		return -ENODEV;
> +
> +	streamlabs_wdt = devm_kzalloc(&intf->dev, sizeof(struct streamlabs_wdt),
> +								GFP_KERNEL);
> +	if (!streamlabs_wdt)
> +		return -ENOMEM;
> +
> +	streamlabs_wdt->buffer = devm_kzalloc(&intf->dev, BUFFER_LENGTH,
> +								GFP_KERNEL);
> +	if (!streamlabs_wdt->buffer)
> +		return -ENOMEM;
> +
> +	mutex_init(&streamlabs_wdt->lock);
> +
> +	streamlabs_wdt->wdt_dev.info = &streamlabs_wdt_ident;
> +	streamlabs_wdt->wdt_dev.ops = &usb_streamlabs_wdt_ops;
> +	streamlabs_wdt->wdt_dev.timeout = STREAMLABS_WDT_MAX_TIMEOUT;
> +	streamlabs_wdt->wdt_dev.max_timeout = STREAMLABS_WDT_MAX_TIMEOUT;
> +	streamlabs_wdt->wdt_dev.min_timeout = STREAMLABS_WDT_MIN_TIMEOUT;
> +	streamlabs_wdt->wdt_dev.parent = &intf->dev;
> +
> +	streamlabs_wdt->intf = intf;
> +	usb_set_intfdata(intf, &streamlabs_wdt->wdt_dev);
> +	watchdog_set_drvdata(&streamlabs_wdt->wdt_dev, streamlabs_wdt);
> +	watchdog_set_nowayout(&streamlabs_wdt->wdt_dev, nowayout);
> +
> +	retval = usb_streamlabs_wdt_stop(&streamlabs_wdt->wdt_dev);
> +	if (retval)
> +		return -ENODEV;
> +
> +	retval = devm_watchdog_register_device(&intf->dev,
> +						&streamlabs_wdt->wdt_dev);
> +	if (retval) {
> +		dev_err(&intf->dev, "failed to register watchdog device\n");
> +		return retval;
> +	}
> +
> +	dev_info(&intf->dev, "StreamLabs USB watchdog driver loaded.\n");
> +	return 0;
> +}
> +
> +static int usb_streamlabs_wdt_suspend(struct usb_interface *intf,
> +					pm_message_t message)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
> +
> +	if (watchdog_active(&streamlabs_wdt->wdt_dev))
> +		return usb_streamlabs_wdt_stop(&streamlabs_wdt->wdt_dev);
> +
> +	return 0;
> +}
> +
> +static int usb_streamlabs_wdt_resume(struct usb_interface *intf)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
> +
> +	if (watchdog_active(&streamlabs_wdt->wdt_dev))
> +		return usb_streamlabs_wdt_start(&streamlabs_wdt->wdt_dev);
> +
> +	return 0;
> +}
> +
> +static void usb_streamlabs_wdt_disconnect(struct usb_interface *intf)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
> +
> +	mutex_lock(&streamlabs_wdt->lock);
> +	usb_streamlabs_wdt_stop_cmd(streamlabs_wdt);
> +	/* Stop sending messages to the device */
> +	streamlabs_wdt->intf = NULL;
> +	mutex_unlock(&streamlabs_wdt->lock);
> +}

Tis leaves the watchdog device in place even though it has been disconnected.
This is, at the very least, unusual, and doesn't really make sense.
Please explain. Also, wWhat happens when it is reconnected ?

Guenter

> +
> +static const struct usb_device_id usb_streamlabs_wdt_device_table[] = {
> +	{ USB_DEVICE(USB_STREAMLABS_WATCHDOG_VENDOR, USB_STREAMLABS_WATCHDOG_PRODUCT) },
> +	{ }	/* Terminating entry */
> +};
> +
> +MODULE_DEVICE_TABLE(usb, usb_streamlabs_wdt_device_table);
> +
> +static struct usb_driver usb_streamlabs_wdt_driver = {
> +	.name		= DRIVER_NAME,
> +	.probe		= usb_streamlabs_wdt_probe,
> +	.disconnect	= usb_streamlabs_wdt_disconnect,
> +	.suspend	= usb_streamlabs_wdt_suspend,
> +	.resume		= usb_streamlabs_wdt_resume,
> +	.reset_resume	= usb_streamlabs_wdt_resume,
> +	.id_table	= usb_streamlabs_wdt_device_table,
> +};
> +
> +module_usb_driver(usb_streamlabs_wdt_driver);

