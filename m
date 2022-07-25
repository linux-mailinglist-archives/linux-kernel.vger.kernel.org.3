Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987A0580056
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiGYODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiGYODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:03:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621F313F2B;
        Mon, 25 Jul 2022 07:02:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so14464524pjg.3;
        Mon, 25 Jul 2022 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=A1tInnMiD3UhhNWtPyHlS5U6ehJzhf/UIpSI9NqeJbA=;
        b=n7/iaWwcdyvflGsLgg3iJM3dZFdBjfxdt/aspdRtTc5C+/BYDjZA9gAI4bnD7Gq9Ux
         9PQByLYNBtmEGBwl4EP4Kh3DQAPSliR0Hi5Y2DZrOGY/+Y6OArFD0eBGXD6I7xTg9Iwk
         Zvb3W0JZUo5lTfoOQAy6yng5+8FGKJhf0+XyA7oKkWxLh8tII/QFSPVLPj7rgfQGc7i8
         APqi/YU3a8FFag/2bWfSO6lG80gQNyFrBvySp5SHgo9YS8/eGR3guwuNQ4hWP0AR5rjY
         +kQQtVhVcp4+TRmLM1e0sjvAztYAcQ1MErNwl3/RsbFHiniJ+Gl7Xf5qJiHg3DsN51fA
         Etpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=A1tInnMiD3UhhNWtPyHlS5U6ehJzhf/UIpSI9NqeJbA=;
        b=tVo6M1yTWehOQ4kgXV+ZHm4Q8j1/O2/HPiZ0Nw/pwpgSkFD6CJyZlSAsqSOkwgsI0w
         F19Xp1DXFrkHTvHt6e8IYbQCgB4LzUZ7pYB86241WFb4ycgk/ChI1/DON5QZ9gvClUSw
         Leww+7LrEtcBhlo9JCNjorpxw7GH1nm5Nr/nYVJFozqI59Ole0rUupLjKdQlmEQ4Cqyy
         FhPImxkdGbq6836eC2jENalIAhsaQL7dUrIWDg6x+pFFn1lYa55+T7OjGipGHCNtgfKL
         68LdQfD9dJR+O8cNLkpt/WaBNacz1hHFmQeDUPW3quPllvXtGqqfQlW4VWiMGV2/qD9B
         R/DA==
X-Gm-Message-State: AJIora9F2e6BmXHbjqvuV3wq/qTTwceo1QJ6MJDUK+3X5T68UsC2QaGp
        GCLmw3LKpT60c9OCDN28YDE=
X-Google-Smtp-Source: AGRyM1vbHYzLsYxo+ukvLyvZfhNKs1XnQySgJCanxVyo/Ll6HDDb4ybzIhCcxwlD0hmvPITa/wZtfQ==
X-Received: by 2002:a17:90b:4c87:b0:1f2:cf1d:c906 with SMTP id my7-20020a17090b4c8700b001f2cf1dc906mr2219701pjb.119.1658757778571;
        Mon, 25 Jul 2022 07:02:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b0015ee60ef65bsm9380952plh.260.2022.07.25.07.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 07:02:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <573466e4-e836-d053-d1b9-dc04c6a046e5@roeck-us.net>
Date:   Mon, 25 Jul 2022 07:02:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Alexey Klimov <klimov.linux@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, oneukum@suse.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        atishp@rivosinc.com, atishp@atishpatra.org, yury.norov@gmail.com,
        aklimov@redhat.com, atomlin@redhat.com
References: <20220725030605.1808710-1-klimov.linux@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog
 device
In-Reply-To: <20220725030605.1808710-1-klimov.linux@gmail.com>
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

On 7/24/22 20:06, Alexey Klimov wrote:
> Driver supports StreamLabs usb watchdog device. The device plugs
> into 9-pin usb header and connects to reset pins and reset button
> pins on desktop PC.
> 
> USB commands used to communicate with device were reverse
> engineered using usbmon.
> 
> Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
> ---
> Changes since v4:
> 	-- added more comments;
> 	-- added nowayout check in ->disconnect();
> 	-- completely rework usb_streamlabs_wdt_cmd() ->
>                  __usb_streamlabs_wdt_cmd() and functions
> 		that handle validation of the response;
> 	-- usb sending and receiving msgs are moved to separate
> 		functions;
>          -- added soft_unbind=1 flag in usb_driver struct
> 		to make it possible to send URBs in ->disconnect();
>          -- buffer is declared as __le16 now;
>          -- made checkpatch.pl --strict happy;
> 
> Previous version:
> https://lore.kernel.org/linux-watchdog/20220715234442.3910204-1-klimov.linux@gmail.com/
> 
> 
>   MAINTAINERS                       |   6 +
>   drivers/watchdog/Kconfig          |  15 ++
>   drivers/watchdog/Makefile         |   1 +
>   drivers/watchdog/streamlabs_wdt.c | 360 ++++++++++++++++++++++++++++++
>   4 files changed, 382 insertions(+)
>   create mode 100644 drivers/watchdog/streamlabs_wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64379c699903..fb31c1823043 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19190,6 +19190,12 @@ W:	http://www.stlinux.com
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
> index 000000000000..f1130fe5559c
> --- /dev/null
> +++ b/drivers/watchdog/streamlabs_wdt.c
> @@ -0,0 +1,360 @@
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
Comment about the unit (ms) might be useful.

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
> +	/* Serialises usb communication with a device */
> +	struct mutex lock;
> +	__le16 *buffer;
> +};
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +/* USB call wrappers to send and receive messages to/from the device. */
> +static int usb_streamlabs_send_msg(struct usb_device *usbdev, __le16 *buf)
> +{
> +	int retval;
> +	int size;
> +
> +	retval = usb_interrupt_msg(usbdev, usb_sndintpipe(usbdev, 0x02),
> +				   buf, BUFFER_TRANSFER_LENGTH,
> +				   &size, USB_TIMEOUT);
> +
> +	if (size != BUFFER_TRANSFER_LENGTH)
> +		return -EIO;
> +

If usb_interrupt_msg() returns an error, it will likely not set size,
which may result in a random -EIO. I think this should be something like

	if (retval)
		return retval;
	if (size != BUFFER_TRANSFER_LENGTH)
		return -EIO;

	return 0;


> +	return retval;
> +}
> +
> +static int usb_streamlabs_get_msg(struct usb_device *usbdev, __le16 *buf)
> +{
> +	int retval;
> +	int size;
> +
> +	retval = usb_interrupt_msg(usbdev, usb_rcvintpipe(usbdev, 0x81),
> +				   buf, BUFFER_LENGTH,
> +				   &size, USB_TIMEOUT);
> +
> +	if (size != BUFFER_LENGTH)
> +		return -EIO;
> +
Same here.

> +	return retval;
> +}
> +
> +/*
> + * This function is used to check if watchdog timeout in the received buffer
> + * matches the timeout passed from watchdog subsystem.
> + */
> +static int usb_streamlabs_wdt_check_timeout(__le16 *buf, unsigned long timeout)
> +{
> +	if (buf[3] != cpu_to_le16(timeout))
> +		return -EPROTO;
> +
> +	return 0;
> +}
> +
> +static int usb_streamlabs_wdt_check_response(u8 *buf)
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
> +/*
> + * This function is used to check if watchdog command in the received buffer
> + * matches the command passed to the device.
> + */
> +static int usb_streamlabs_wdt_check_command(__le16 *buf, u16 cmd)
> +{
> +	if (buf[0] != cpu_to_le16(cmd))
> +		return -EPROTO;
> +
> +	return 0;
> +}
> +
> +static int usb_streamlabs_wdt_validate_response(__le16 *buf, u16 cmd,
> +						unsigned long timeout_msec)
> +{
> +	int retval;
> +
> +	retval = usb_streamlabs_wdt_check_response((u8 *)buf);
> +	if (retval)
> +		return retval;
> +
> +	retval = usb_streamlabs_wdt_check_command(buf, cmd);
> +	if (retval)
> +		return retval;
> +
> +	retval = usb_streamlabs_wdt_check_timeout(buf, timeout_msec);
> +	return retval;

	assignment to retval is unnecessary.

> +}
> +
> +static void usb_streamlabs_wdt_prepare_buf(__le16 *buf, u16 cmd,
> +					   unsigned long timeout_msec)
> +{
> +	/*
> +	 * remaining elements expected to be zero everytime during
> +	 * communication
> +	 */
> +	buf[0] = cpu_to_le16(cmd);
> +	buf[1] = cpu_to_le16(0x8000);
> +	buf[3] = cpu_to_le16(timeout_msec);

Not setting buf[2] and buf[4] contradicts the comment above. Maybe
those offsets are not _expected_ to be set by the device, but that
is not guaranteed. It may be safer to just use memset() at the
beginning of the function to clear the buffer.

> +	buf[5] = 0x0;
> +	buf[6] = 0x0;
> +}
> +
> +static int __usb_streamlabs_wdt_cmd(struct streamlabs_wdt *wdt, u16 cmd)
> +{
> +	struct usb_device *usbdev;
> +	unsigned long timeout_msec;
> +	/* how many times to re-try getting the state of the device */
> +	unsigned int retry_counter = 10;
> +	int retval;
> +
> +	if (unlikely(!wdt->intf))
> +		return -ENODEV;
> +
> +	usbdev = interface_to_usbdev(wdt->intf);
> +	timeout_msec = wdt->wdt_dev.timeout * MSEC_PER_SEC;
> +
> +	usb_streamlabs_wdt_prepare_buf(wdt->buffer, cmd, timeout_msec);
> +
> +	/* send command to watchdog */
> +	retval = usb_streamlabs_send_msg(usbdev, wdt->buffer);
> +	if (retval)
> +		return retval;
> +
> +	/*
> +	 * Transition from one state to another in this device
> +	 * doesn't happen immediately, especially stopping the device
> +	 * is not observed on the first reading of the response.
> +	 * Plus to avoid potentially stale response message in the device
> +	 * we keep reading the state of the device until we see:
> +	 * -- that device recognised the sent command;
> +	 * -- the received state (started or stopped) matches the state
> +	 * that was requested;
> +	 * -- the timeout passed matches the timeout value read from
> +	 * the device.
> +	 * Keep retrying 10 times and if watchdog device doesn't respond
> +	 * correctly as expected we bail out and return an error.
> +	 */
> +	do {
> +		retval = usb_streamlabs_get_msg(usbdev, wdt->buffer);
> +		if (retval)
> +			break;
> +
> +		retval = usb_streamlabs_wdt_validate_response(wdt->buffer, cmd,
> +							      timeout_msec);
> +	} while (retval && retry_counter--);
> +
> +	return retry_counter ? retval : -EIO;
> +}
> +
> +static int usb_streamlabs_wdt_cmd(struct streamlabs_wdt *streamlabs_wdt, u16 cmd)
> +{
> +	int retval;
> +
> +	mutex_lock(&streamlabs_wdt->lock);
> +	retval = __usb_streamlabs_wdt_cmd(streamlabs_wdt, cmd);
> +	mutex_unlock(&streamlabs_wdt->lock);
> +
> +	return retval;
> +}
> +
> +static int usb_streamlabs_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
> +
> +	return usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_START);
> +}
> +
> +static int usb_streamlabs_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
> +
> +	return usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_STOP);
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
> +				    const struct usb_device_id *id)
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
> +	if (!usbdev->product || !usbdev->manufacturer ||
> +	    strncmp(usbdev->product, "USBkit", 6) ||
> +	    strncmp(usbdev->manufacturer, "STREAM LABS", 11))
> +		return -ENODEV;
> +
> +	streamlabs_wdt = devm_kzalloc(&intf->dev, sizeof(struct streamlabs_wdt),
> +				      GFP_KERNEL);
> +	if (!streamlabs_wdt)
> +		return -ENOMEM;
> +
> +	streamlabs_wdt->buffer = devm_kzalloc(&intf->dev, BUFFER_LENGTH,
> +					      GFP_KERNEL);
> +	if (!streamlabs_wdt->buffer)
> +		return -ENOMEM;
> +

Nit: buffer could be made part of struct streamlabs_wdt and be tagged with
____cacheline_aligned to avoid the double allocation.

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

A comment explaining why the watchdog is explicitly stopped when running
might be useful.

> +	retval = devm_watchdog_register_device(&intf->dev,
> +					       &streamlabs_wdt->wdt_dev);
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
> +				      pm_message_t message)
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
> +	/*
> +	 * If disconnect happens via sysfs or on rmmod, then try to stop
> +	 * the watchdog. In case of physical detachment of the device this call
> +	 * will fail but we continue.
> +	 */
> +	if (!nowayout)
> +		__usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_STOP);
> +	/* Stop sending (new) messages to the device */
> +	streamlabs_wdt->intf = NULL;
> +	mutex_unlock(&streamlabs_wdt->lock);
> +}
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
> +	.soft_unbind	= 1,
> +};
> +
> +module_usb_driver(usb_streamlabs_wdt_driver);

