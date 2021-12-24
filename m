Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5660E47EE7C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 12:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352550AbhLXLLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 06:11:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352540AbhLXLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 06:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640344292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0HLcfphfNI+cDeJbstKyNhj8Mcmd2ahCAE0vIfjeInA=;
        b=T3sgxRndqgQRxRqjtesZ9ENB3ppzlwZGJL+4Po2FANrPKM0vebT41bvcLuLoAwHLICOpYs
        8ZlUhsSlEeRdgM6wqpwIto8LKsIXJxPrOVBSIfk0GpQGfsqdDhJYEACzPMhNrWs8c67rRp
        EKrBRGt4jSmZTwY9xYtWBzD16Xvctxc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-CuxEmNIUMxu9G5KVqtWvkA-1; Fri, 24 Dec 2021 06:11:31 -0500
X-MC-Unique: CuxEmNIUMxu9G5KVqtWvkA-1
Received: by mail-ed1-f70.google.com with SMTP id w10-20020a50d78a000000b003f82342a95aso6584199edi.22
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 03:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0HLcfphfNI+cDeJbstKyNhj8Mcmd2ahCAE0vIfjeInA=;
        b=W9luq6gfEZ5WrM82KOUdqljDakV98tCXp7KL2eqsanhMy9zDZdAd1kXhUBjpI6951b
         pRdMj7TU/eQGp83oUXPiQrlyfFeZPRW6b5RV0k5MzFHzxmOzxSvJj0LO3ItvHrFtGYkL
         uuIaSXs/hHzJZKT8juJHjCCdnQ+8EcV3F9mfFQS+WMk5POokepVf6xB84vu+GZ6m7OEa
         FM9b5zVsIRUjfyjKe+yYCJdHe6vfoCGpbsV5cA7QwWjeyhh3KwrUfnaeEtUPr04g4GME
         eqb9Nt5yjzVhWOKFv6Im0ZefjFeBQ+Agy1ADnd+yEZq8ulEkpvl9LztzCi9KpRfdYQ/F
         tDIg==
X-Gm-Message-State: AOAM532seMxYWdzN5AMEct/5JOYjJk65QrGLyn4L0PWLFLFDNbhrq7+5
        /y3YqLLMbMtkgpVU+B42Xh4THdxckJ1G95+96ujuz5JQzmbRwLaqhRpPMByq9TwUyjlSN6DJPCp
        06XpvX7OtwzQ/Gv1aAiUG4tHl
X-Received: by 2002:a17:906:9d01:: with SMTP id fn1mr4919727ejc.391.1640344289953;
        Fri, 24 Dec 2021 03:11:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjg2BNR2S53slhtopTIGvvPKIIg1S4cRyvF6EkvIgrzDBp3QOuzZ4LOHtGKydjsLpNAzVBmw==
X-Received: by 2002:a17:906:9d01:: with SMTP id fn1mr4919718ejc.391.1640344289711;
        Fri, 24 Dec 2021 03:11:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id di16sm2611919ejc.82.2021.12.24.03.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 03:11:29 -0800 (PST)
Message-ID: <a71d4e73-6db8-16e7-2a3c-e50e26c0a07e@redhat.com>
Date:   Fri, 24 Dec 2021 12:11:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/3] Input: elan_i2c - Use PM subsystem to manage wake irq
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, linux-input@vger.kernel.org,
        dianders@chromium.org, "jingle.wu" <jingle.wu@emc.com.tw>
References: <20211220234346.2798027-1-rrangel@chromium.org>
 <20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid>
 <YcE+xrSnS7qw0G1/@google.com>
 <9b004b3d-deed-1b63-2344-a445a9e53b61@redhat.com>
 <YcToUCQ8gzzSWbrm@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YcToUCQ8gzzSWbrm@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/23/21 22:21, Dmitry Torokhov wrote:
> On Thu, Dec 23, 2021 at 03:42:24PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 12/21/21 03:41, Dmitry Torokhov wrote:
>>> Hi Raul,
>>>
>>> On Mon, Dec 20, 2021 at 04:43:45PM -0700, Raul E Rangel wrote:
>>>> @@ -1368,11 +1367,13 @@ static int elan_probe(struct i2c_client *client,
>>>>  	}
>>>>  
>>>>  	/*
>>>> -	 * Systems using device tree should set up wakeup via DTS,
>>>> +	 * Systems using device tree or ACPI should set up wakeup via DTS/ACPI,
>>>>  	 * the rest will configure device as wakeup source by default.
>>>>  	 */
>>>> -	if (!dev->of_node)
>>>> +	if (!dev->of_node && !ACPI_COMPANION(dev)) {
>>>
>>> I think this will break our Rambis that use ACPI for enumeration but
>>> actually lack _PRW. As far as I remember their trackpads were capable
>>> of waking up the system.
>>>
>>> I think we should remove this chunk completely and instead add necessary
>>> code to drivers/platform/chrome/chrome-laptop.c (I suppose we need to
>>> have additional member in struct acpi_peripheral to indicate whether
>>> device needs to be configured for wakeup and then act upon it in
>>> chromeos_laptop_adjust_client().
> 
> FWIW I looked at Rambi some more and I see that it actually defines a
> separate device an ACPI to handle wakeups, it is separate from the ACPI
> node for the trackpad:
> 
> Scope (\_SB)
> {
> #ifdef BOARD_TRACKPAD_IRQ
>         /* Wake device for touchpad */
>         Device (TPAD)
>         {
>                 Name (_HID, EisaId ("PNP0C0E"))
>                 Name (_UID, 1)
>                 Name (_PRW, Package() { BOARD_TRACKPAD_WAKE_GPIO, 0x3 })
> 
>                 Name (RBUF, ResourceTemplate()
>                 {
>                         Interrupt (ResourceConsumer, Level, ActiveLow)
>                         {
>                                 BOARD_TRACKPAD_IRQ
>                         }
>                 })
> 
>                 Method (_CRS)
>                 {
>                         /* Only return interrupt if I2C1 is PCI mode */
>                         If (LEqual (\S1EN, 0)) {
>                                 Return (^RBUF)
>                         }
> 
>                         /* Return empty resource template otherwise */
>                         Return (ResourceTemplate() {})
>                 }
>         }
> #endif
> 
> I am not quite sure why we did this...
> 
>>>
>>>>  		device_init_wakeup(dev, true);
>>>> +		dev_pm_set_wake_irq(dev, client->irq);
>>>> +	}
>>
>> As I already mentioned in my other reply in this thread:
>>
>> https://lore.kernel.org/linux-input/f594afab-8c1a-8821-a775-e5512e17ce8f@redhat.com/
>>
>> AFAICT most x86 ACPI laptops do not use GPEs for wakeup by touchpad and
>> as such they do not have a _PRW method.
>>
>> So for wakeup by elan_i2c touchpads to keep working this code is not
>> just necessary for some ChromeOS devices, but it is necessary on
>> most ACPI devices.
>>
>> The problem of not making these calls on devices where a GPE is actually
>> used for touchpad wakeup (which at least for now is the exception not
>> the rule) should probably be fixed by no running this "chunk"
>> when the device has an ACPI_COMPANION (as this patch already checks)
>> *and* that ACPI_COMPANION has a valid _PRW method.
>>
>> Simply removing this chunk, or taking this patch as is will very
>> likely lead to regressions on various x86 laptop models.
> 
> Hans, could you share a couple of DSDTs for devices that do not use GPEs
> for wakeup?
> 
> For OF we already recognize that wakeup source/interrupt might differ
> from "main" I2C interrupt, I guess we need to do similar for ACPI cases.
> The question is to how determine if a device is supposed to be a wakeup
> source if it does not have _PRW.

With s2idle (rather then S3) we never really suspend, we just put
everything in an as low power state as possible and call halt on the
CPU and then hope that the SoC power-management-unit shuts of a whole
bunch of power-planes based on all the devices being in a low power
state.

This means that in practice with s2idle any device can be a wakeup
device since regular IRQs work fine as wakeup sources in s2idle.

This is what the s2idle support in the i2c-hid code is based on:
drivers/hid/i2c-hid/i2c-hid-acpi.c:

        if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
                device_set_wakeup_capable(dev, true);
                device_set_wakeup_enable(dev, false);
        }

So I did just test this on a Lenovo ThinkPad X1 carbon gen 8, which
uses i2c_hid_acpi as driver for its touchpad and if I echo
enabled to the wakeup attr there, then wakeup by touchpad does work.

One interesting thing there is that the touchpad ACPI node does not
have _PS0 and _PS3. Which means that the touchpad working as wakeup
device makes sense, since it can not be turned off at all.

So I guess we could extend the above check in the i2c-hid-acpi
code to read:

        if ((acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) &&
	    !adev->flags.power_manageable) {
                device_set_wakeup_capable(dev, true);
                device_set_wakeup_enable(dev, false);
        }

Because if there is a _PS3, which presumably is the case for
the troublesome touchscreen Raul is trying to fix, then we
will call that on suspend; and after that it is likely that
the device will not work as a wakeup source.

And I just checked the DSDT of a couple of devices where I'm
reasonable sure that the touchpad uses I2C-HID and none of
them define _PS0/_PS3 methods on the touchpad ACPI node.

So I think that the above suggestion should fix things
for the i2c-hid case.

I've added Kai-Heng, the author of the original change
introducing the device_set_wakeup_capable() call, to the Cc.
Kai-Heng what do you think about this ?

Raul, can you check if this resolves your issue?

FWIW here is an acpidump of the X1C8:
https://fedorapeople.org/~jwrdegoede/acpidump-lenovo-x1c8

Regards,

Hans


p.s.

An other interesting datapoint is that despite not declaring
a _PRW method the DSDTs which I've checked do all 3 contain
an _S0W method, returning 3 or 4. Which suggests that maybe the
ACPI code should look at _S0W even when no GPE is being used?

