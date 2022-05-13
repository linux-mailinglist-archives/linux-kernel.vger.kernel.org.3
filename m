Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E81526C95
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384751AbiEMVsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353675AbiEMVsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:48:05 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0512E9D6;
        Fri, 13 May 2022 14:48:02 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w130so11772021oig.0;
        Fri, 13 May 2022 14:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=hslt8jkHu0h5fi9fPNSR3eGjGyLf8LQPKOpfy2rBnPQ=;
        b=hIkz4iOvn3NjXSUu8d0W8v2HuY6MY0n/uXNG6y6XyIUVaSFpe/PYez0hD5yVmUQk6W
         rRFaOs54H8yirRDNztngm9QKGNLRiwDBJZW1e70QxTIQ6QwsWA1V8gQGCvP2oCzWE46u
         ZJIkZNt/lk8TRNMcGC3r8kaVMCa2mtWbK14nPWPmujrk306RHO0KIpPaczHK64IZLTEo
         kKm2IxG78vWuJPD4OX4OI7zpcy98fAh/M6IwcnkqqZdRkr3to/HOrPJVfY84MhK5iQ6D
         QMpuo5PjEOnSni0gifaF+rNg7YYZ2d9gD8HNB/UYUDv+bUbUSehr5Eq90mUehIvQZQI8
         C1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=hslt8jkHu0h5fi9fPNSR3eGjGyLf8LQPKOpfy2rBnPQ=;
        b=RrZ6rImGuHMwWJSxp1Z/nDNOuqQ4T7fPAYOTkY3mxs9wAh3mRfRHjfuDagc3ciQdHW
         LnXdFlsJhm3tHgl99+Rd8MHvdoblV7j9tU6snpIc74h0KrWXqmNZq2qQn2xK98HTl8aZ
         fmd5VynKbQwFWRGuLIKs01XjyBR0TZjsxL7G+NIROBaHSZjkfi1YfMfk3K3ey0Kabw1w
         7YU19XvX9uDXkC3137A+eykQZ4amGLUCtiJOz0wVtA+qs0ZgzHHS8NoIgwumlXvFW7sp
         KZPB8MRFXdW8O5aGetyeoi+K6bvQlYaIWzMzsOWxHZMmY4sS3i9pGzrWocCYvUk4cyP7
         CAjQ==
X-Gm-Message-State: AOAM532CWivzbL1F5N+dcD7GG5ty2iwYRe686CW0Lc1mcqC5yLg6ewwM
        5KBjDVrNT4Cv1YgKvzFB4LeAzAUtTkVgcw==
X-Google-Smtp-Source: ABdhPJzA+CkNZLsIx6wAPGIhIetgSMD5t7dUZQJuOM88+3MbSxXXr1oKhzDah/v7eAhC5aTSrFgAWg==
X-Received: by 2002:a05:6808:1b0e:b0:328:a9d4:88ac with SMTP id bx14-20020a0568081b0e00b00328a9d488acmr8842179oib.163.1652478481799;
        Fri, 13 May 2022 14:48:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p8-20020aca4208000000b00325cda1ffa2sm1590196oia.33.2022.05.13.14.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 14:48:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <17636709-e536-b8c5-cb8f-976ac7657735@roeck-us.net>
Date:   Fri, 13 May 2022 14:47:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Henning Schild <henning.schild@siemens.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>
References: <20211213120502.20661-1-henning.schild@siemens.com>
 <20211213120502.20661-3-henning.schild@siemens.com>
 <20220513214030.7254b1bf@md1za8fc.ad001.siemens.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 2/4] leds: simatic-ipc-leds: add new driver for Siemens
 Industial PCs
In-Reply-To: <20220513214030.7254b1bf@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 12:40, Henning Schild wrote:
> Am Mon, 13 Dec 2021 13:05:00 +0100
> schrieb Henning Schild <henning.schild@siemens.com>:
> 
>> This driver adds initial support for several devices from Siemens. It
>> is based on a platform driver introduced in an earlier commit.
>>
>> One of the supported machines has GPIO connected LEDs, here we poke
>> GPIO memory directly because pinctrl does not come up.
>>
>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>> ---
>>   drivers/leds/Kconfig                   |   3 +
>>   drivers/leds/Makefile                  |   3 +
>>   drivers/leds/simple/Kconfig            |  11 ++
>>   drivers/leds/simple/Makefile           |   2 +
>>   drivers/leds/simple/simatic-ipc-leds.c | 202
>> +++++++++++++++++++++++++ 5 files changed, 221 insertions(+)
>>   create mode 100644 drivers/leds/simple/Kconfig
>>   create mode 100644 drivers/leds/simple/Makefile
>>   create mode 100644 drivers/leds/simple/simatic-ipc-leds.c
>>
>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>> index ed800f5da7d8..ac6688d7a3f4 100644
>> --- a/drivers/leds/Kconfig
>> +++ b/drivers/leds/Kconfig
>> @@ -879,4 +879,7 @@ source "drivers/leds/flash/Kconfig"
>>   comment "LED Triggers"
>>   source "drivers/leds/trigger/Kconfig"
>>   
>> +comment "Simple LED drivers"
>> +source "drivers/leds/simple/Kconfig"
>> +
>>   endif # NEW_LEDS
>> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
>> index c636ec069612..1a719caf14c0 100644
>> --- a/drivers/leds/Makefile
>> +++ b/drivers/leds/Makefile
>> @@ -105,3 +105,6 @@ obj-$(CONFIG_LEDS_TRIGGERS)		+=
>> trigger/
>>   # LED Blink
>>   obj-y					+= blink/
>> +
>> +# Simple LED drivers
>> +obj-y					+= simple/
>> diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
>> new file mode 100644
>> index 000000000000..9f6a68336659
>> --- /dev/null
>> +++ b/drivers/leds/simple/Kconfig
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config LEDS_SIEMENS_SIMATIC_IPC
>> +	tristate "LED driver for Siemens Simatic IPCs"
>> +	depends on LEDS_CLASS
>> +	depends on SIEMENS_SIMATIC_IPC
> 
> Trying to bring this into distros i think this one should rather be
> "select SIEMENS_SIMATIC_IPC" and the same thought goes for wdt.
> 
> Users care about enabling a feature and maybe not too much about having
> to enable infra, enabling SIEMENS_SIMATIC_IPC is just infra and useless
> without LEDS_SIEMENS_SIMATIC_IPC and/or SIEMENS_SIMATIC_IPC_WDT.
> 
> So those two should probably "select" and not "depend".
> 
> I will send a patch, feel free to tell me that i am wrong and teach me
> about how deps should work.
> 

I disagree. Normally drivers depend on the platform and don't select it.
It would make more sense to specify something like

	depends on SIEMENS_SIMATIC_IPC
	default SIEMENS_SIMATIC_IPC

In this context, the description for SIEMENS_SIMATIC_IPC is
a bit misleading. Something like "Platform driver for Simatic
Industrial PC" or just "Support for Simatic Industrial PC"
would be a better description.

Guenter

> regards,
> Henning
> 
>> +	help
>> +	  This option enables support for the LEDs of several
>> Industrial PCs
>> +	  from Siemens.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> module
>> +	  will be called simatic-ipc-leds.
>> diff --git a/drivers/leds/simple/Makefile
>> b/drivers/leds/simple/Makefile new file mode 100644
>> index 000000000000..8481f1e9e360
>> --- /dev/null
>> +++ b/drivers/leds/simple/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
>> diff --git a/drivers/leds/simple/simatic-ipc-leds.c
>> b/drivers/leds/simple/simatic-ipc-leds.c new file mode 100644
>> index 000000000000..ff2c96e73241
>> --- /dev/null
>> +++ b/drivers/leds/simple/simatic-ipc-leds.c
>> @@ -0,0 +1,202 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Siemens SIMATIC IPC driver for LEDs
>> + *
>> + * Copyright (c) Siemens AG, 2018-2021
>> + *
>> + * Authors:
>> + *  Henning Schild <henning.schild@siemens.com>
>> + *  Jan Kiszka <jan.kiszka@siemens.com>
>> + *  Gerd Haeussler <gerd.haeussler.ext@siemens.com>
>> + */
>> +
>> +#include <linux/ioport.h>
>> +#include <linux/kernel.h>
>> +#include <linux/leds.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_data/x86/simatic-ipc-base.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/sizes.h>
>> +#include <linux/spinlock.h>
>> +
>> +#define SIMATIC_IPC_LED_PORT_BASE	0x404E
>> +
>> +struct simatic_ipc_led {
>> +	unsigned int value; /* mask for io and offset for mem */
>> +	char *name;
>> +	struct led_classdev cdev;
>> +};
>> +
>> +static struct simatic_ipc_led simatic_ipc_leds_io[] = {
>> +	{1 << 15, "green:" LED_FUNCTION_STATUS "-1" },
>> +	{1 << 7,  "yellow:" LED_FUNCTION_STATUS "-1" },
>> +	{1 << 14, "red:" LED_FUNCTION_STATUS "-2" },
>> +	{1 << 6,  "yellow:" LED_FUNCTION_STATUS "-2" },
>> +	{1 << 13, "red:" LED_FUNCTION_STATUS "-3" },
>> +	{1 << 5,  "yellow:" LED_FUNCTION_STATUS "-3" },
>> +	{ }
>> +};
>> +
>> +/* the actual start will be discovered with PCI, 0 is a placeholder
>> */ +struct resource simatic_ipc_led_mem_res = DEFINE_RES_MEM_NAMED(0,
>> SZ_4K, KBUILD_MODNAME); +
>> +static void *simatic_ipc_led_memory;
>> +
>> +static struct simatic_ipc_led simatic_ipc_leds_mem[] = {
>> +	{0x500 + 0x1A0, "red:" LED_FUNCTION_STATUS "-1"},
>> +	{0x500 + 0x1A8, "green:" LED_FUNCTION_STATUS "-1"},
>> +	{0x500 + 0x1C8, "red:" LED_FUNCTION_STATUS "-2"},
>> +	{0x500 + 0x1D0, "green:" LED_FUNCTION_STATUS "-2"},
>> +	{0x500 + 0x1E0, "red:" LED_FUNCTION_STATUS "-3"},
>> +	{0x500 + 0x198, "green:" LED_FUNCTION_STATUS "-3"},
>> +	{ }
>> +};
>> +
>> +static struct resource simatic_ipc_led_io_res =
>> +	DEFINE_RES_IO_NAMED(SIMATIC_IPC_LED_PORT_BASE, SZ_2,
>> KBUILD_MODNAME); +
>> +static DEFINE_SPINLOCK(reg_lock);
>> +
>> +static inline struct simatic_ipc_led *cdev_to_led(struct
>> led_classdev *led_cd) +{
>> +	return container_of(led_cd, struct simatic_ipc_led, cdev);
>> +}
>> +
>> +static void simatic_ipc_led_set_io(struct led_classdev *led_cd,
>> +				   enum led_brightness brightness)
>> +{
>> +	struct simatic_ipc_led *led = cdev_to_led(led_cd);
>> +	unsigned long flags;
>> +	unsigned int val;
>> +
>> +	spin_lock_irqsave(&reg_lock, flags);
>> +
>> +	val = inw(SIMATIC_IPC_LED_PORT_BASE);
>> +	if (brightness == LED_OFF)
>> +		outw(val | led->value, SIMATIC_IPC_LED_PORT_BASE);
>> +	else
>> +		outw(val & ~led->value, SIMATIC_IPC_LED_PORT_BASE);
>> +
>> +	spin_unlock_irqrestore(&reg_lock, flags);
>> +}
>> +
>> +static enum led_brightness simatic_ipc_led_get_io(struct
>> led_classdev *led_cd) +{
>> +	struct simatic_ipc_led *led = cdev_to_led(led_cd);
>> +
>> +	return inw(SIMATIC_IPC_LED_PORT_BASE) & led->value ? LED_OFF
>> : led_cd->max_brightness; +}
>> +
>> +static void simatic_ipc_led_set_mem(struct led_classdev *led_cd,
>> +				    enum led_brightness brightness)
>> +{
>> +	struct simatic_ipc_led *led = cdev_to_led(led_cd);
>> +
>> +	u32 *p;
>> +
>> +	p = simatic_ipc_led_memory + led->value;
>> +	*p = (*p & ~1) | (brightness == LED_OFF);
>> +}
>> +
>> +static enum led_brightness simatic_ipc_led_get_mem(struct
>> led_classdev *led_cd) +{
>> +	struct simatic_ipc_led *led = cdev_to_led(led_cd);
>> +
>> +	u32 *p;
>> +
>> +	p = simatic_ipc_led_memory + led->value;
>> +	return (*p & 1) ? LED_OFF : led_cd->max_brightness;
>> +}
>> +
>> +static int simatic_ipc_leds_probe(struct platform_device *pdev)
>> +{
>> +	const struct simatic_ipc_platform *plat =
>> pdev->dev.platform_data;
>> +	struct device *dev = &pdev->dev;
>> +	struct simatic_ipc_led *ipcled;
>> +	struct led_classdev *cdev;
>> +	struct resource *res;
>> +	int err, type;
>> +	u32 *p;
>> +
>> +	switch (plat->devmode) {
>> +	case SIMATIC_IPC_DEVICE_227D:
>> +	case SIMATIC_IPC_DEVICE_427E:
>> +		res = &simatic_ipc_led_io_res;
>> +		ipcled = simatic_ipc_leds_io;
>> +		/* on 227D the two bytes work the other way araound
>> */
>> +		if (plat->devmode == SIMATIC_IPC_DEVICE_227D) {
>> +			while (ipcled->value) {
>> +				ipcled->value =
>> swab16(ipcled->value);
>> +				ipcled++;
>> +			}
>> +			ipcled = simatic_ipc_leds_io;
>> +		}
>> +		type = IORESOURCE_IO;
>> +		if (!devm_request_region(dev, res->start,
>> resource_size(res), KBUILD_MODNAME)) {
>> +			dev_err(dev, "Unable to register IO resource
>> at %pR\n", res);
>> +			return -EBUSY;
>> +		}
>> +		break;
>> +	case SIMATIC_IPC_DEVICE_127E:
>> +		res = &simatic_ipc_led_mem_res;
>> +		ipcled = simatic_ipc_leds_mem;
>> +		type = IORESOURCE_MEM;
>> +
>> +		/* get GPIO base from PCI */
>> +		res->start = simatic_ipc_get_membase0(PCI_DEVFN(13,
>> 0));
>> +		if (res->start == 0)
>> +			return -ENODEV;
>> +
>> +		/* do the final address calculation */
>> +		res->start = res->start + (0xC5 << 16);
>> +		res->end += res->start;
>> +
>> +		simatic_ipc_led_memory = devm_ioremap_resource(dev,
>> res);
>> +		if (IS_ERR(simatic_ipc_led_memory))
>> +			return PTR_ERR(simatic_ipc_led_memory);
>> +
>> +		/* initialize power/watchdog LED */
>> +		p = simatic_ipc_led_memory + 0x500 + 0x1D8; /*
>> PM_WDT_OUT */
>> +		*p = (*p & ~1);
>> +		p = simatic_ipc_led_memory + 0x500 + 0x1C0; /*
>> PM_BIOS_BOOT_N */
>> +		*p = (*p | 1);
>> +
>> +		break;
>> +	default:
>> +		return -ENODEV;
>> +	}
>> +
>> +	while (ipcled->value) {
>> +		cdev = &ipcled->cdev;
>> +		if (type == IORESOURCE_MEM) {
>> +			cdev->brightness_set =
>> simatic_ipc_led_set_mem;
>> +			cdev->brightness_get =
>> simatic_ipc_led_get_mem;
>> +		} else {
>> +			cdev->brightness_set =
>> simatic_ipc_led_set_io;
>> +			cdev->brightness_get =
>> simatic_ipc_led_get_io;
>> +		}
>> +		cdev->max_brightness = LED_ON;
>> +		cdev->name = ipcled->name;
>> +
>> +		err = devm_led_classdev_register(dev, cdev);
>> +		if (err < 0)
>> +			return err;
>> +		ipcled++;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver simatic_ipc_led_driver = {
>> +	.probe = simatic_ipc_leds_probe,
>> +	.driver = {
>> +		.name = KBUILD_MODNAME,
>> +	}
>> +};
>> +
>> +module_platform_driver(simatic_ipc_led_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:" KBUILD_MODNAME);
>> +MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
> 

