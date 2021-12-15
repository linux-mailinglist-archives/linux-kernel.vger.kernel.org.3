Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C7C4763CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhLOUyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:54:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230062AbhLOUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639601641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XuSuTXhhLMWW5MExMvY+07UDK63es7OPWddsx5/ve8=;
        b=Ce9gdBcDieONpqdAoQWI1TN32/EG9DaaEPS2rUynm/RGjMp5hybG+gEBWlB01N7hQElzpk
        7QXiqFZzEfZ3PdP9n5dbDtZtaEsC2KQAjkUFJGiLKaW5NCRAy8STKKwGC0L1abb4uylEOP
        C94o6Deh7IcfpFJkRc6kEDhwTlopXSA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-QAWVx0y5P5-4GqhMaZQuYw-1; Wed, 15 Dec 2021 15:54:00 -0500
X-MC-Unique: QAWVx0y5P5-4GqhMaZQuYw-1
Received: by mail-ed1-f72.google.com with SMTP id m17-20020aa7d351000000b003e7c0bc8523so21260521edr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 12:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2XuSuTXhhLMWW5MExMvY+07UDK63es7OPWddsx5/ve8=;
        b=JFc9HeKMeKJ6g95AOdwry8MyH57LSOULfvbcl52sRKsaLCaDKeDVtolW9bUjbLmTED
         R4Orojg0o78MzFjZ12h2E2BGVwAVbedfriSbMqQi9PwZsSCHhnFxtYIzFdna9zMeWUbr
         JYgw73C2lXxpagexW/XJ4KNvscoAqyaZOpM0Smx/eFJ98O/IXOFjklZi9jPLGkSt2tvm
         EYkloUTiA7h1XIqQxMqGDGg0RbEmAH1mBhHqFTPvIBzzJ/GQxeedJxnuu1D8aLYaNnQJ
         8xxGQCrTM1K8ENvZ0RRhB7/MEae1pinndwgjEQgVyRKcECYAZ/C4VsmgvJIGEzPUX/OP
         T+TQ==
X-Gm-Message-State: AOAM530Mty9r05QWuCLjjaweXQL5WiPzfphgqWNkfbDRMAxKqc7bsdTt
        MlClVI/uvqU5voCFSg9H35NjZv0rLX+iaknCo4SgPhc+fNLx2jeEDYvKU29H6Hnh1BB8pp/ITbQ
        bSoO7Wd4P1yhGiJ67ZwBAJZKS
X-Received: by 2002:a17:906:5050:: with SMTP id e16mr12363113ejk.719.1639601637646;
        Wed, 15 Dec 2021 12:53:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyL9AhACA2rSqUmiIL+ycw9yP6XEnblkXQBYJ/ZG7niVxhYPfIU/201q0vA+UGCp/JUf6WTqQ==
X-Received: by 2002:a17:906:5050:: with SMTP id e16mr12363097ejk.719.1639601637450;
        Wed, 15 Dec 2021 12:53:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id y15sm1584826eda.13.2021.12.15.12.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 12:53:57 -0800 (PST)
Message-ID: <61983e62-bc3d-a711-c197-7436a2e33531@redhat.com>
Date:   Wed, 15 Dec 2021 21:53:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v5 2/4] leds: simatic-ipc-leds: add new driver for Siemens
 Industial PCs
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>,
        Henning Schild <henning.schild@siemens.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>
References: <20211213120502.20661-1-henning.schild@siemens.com>
 <20211213120502.20661-3-henning.schild@siemens.com>
 <20211215201800.GA28336@duo.ucw.cz>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211215201800.GA28336@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/15/21 21:18, Pavel Machek wrote:
> On Mon 2021-12-13 13:05:00, Henning Schild wrote:
>> This driver adds initial support for several devices from Siemens. It is
>> based on a platform driver introduced in an earlier commit.
>>
>> One of the supported machines has GPIO connected LEDs, here we poke GPIO
>> memory directly because pinctrl does not come up.
>>
>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

I see that this patch #includes linux/platform_data/x86/simatic-ipc-base.h
which gets added by patch 1/4.

Pavel, can I take this patch upstream through the pdx86 tree (with you Ack
added)? Or shall I prepare an immutable branch with patch 1 for you to
merge ?

Regards,

Hans


> 
>> index c636ec069612..1a719caf14c0 100644
>> --- a/drivers/leds/Makefile
>> +++ b/drivers/leds/Makefile
>> @@ -105,3 +105,6 @@ obj-$(CONFIG_LEDS_TRIGGERS)		+= trigger/
>>  
>>  # LED Blink
>>  obj-y					+= blink/
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
>> +	help
>> +	  This option enables support for the LEDs of several Industrial PCs
>> +	  from Siemens.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called simatic-ipc-leds.
>> diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
>> new file mode 100644
>> index 000000000000..8481f1e9e360
>> --- /dev/null
>> +++ b/drivers/leds/simple/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
>> diff --git a/drivers/leds/simple/simatic-ipc-leds.c b/drivers/leds/simple/simatic-ipc-leds.c
>> new file mode 100644
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
>> +/* the actual start will be discovered with PCI, 0 is a placeholder */
>> +struct resource simatic_ipc_led_mem_res = DEFINE_RES_MEM_NAMED(0, SZ_4K, KBUILD_MODNAME);
>> +
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
> 
> Would it be possible to get some better naming for leds? status-1 to
> status-3 is not quite useful.
> 
> Best regards,
> 								Pavel
> 

