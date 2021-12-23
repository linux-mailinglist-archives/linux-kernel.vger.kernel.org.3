Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0FB47E08A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347267AbhLWIlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:41:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239194AbhLWIlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640248875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+zi2qLJy+cjuIafxW7erWBqbZlPWsSY4/Iu/ZPhCfxc=;
        b=VAkMFUSIc50TGgS3WfrVzmzu1Eh+qDdSO9tSTql9j+FJ78blMQwb74lIsjHqgoVrxrGl6L
        ww6mzmAz0nY9U4Q03sb/YJhcAM3oSECk0widnD+3bh3rpp1gMDrVhHMK8xnV5KmC/JmHza
        H4VxoxdzakJZVPHp0G2HT60ARBVdC/g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-tKti_exbOuWzfvXoj_auCg-1; Thu, 23 Dec 2021 03:41:14 -0500
X-MC-Unique: tKti_exbOuWzfvXoj_auCg-1
Received: by mail-ed1-f70.google.com with SMTP id y17-20020a056402271100b003f7ef5ca612so3941596edd.17
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 00:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+zi2qLJy+cjuIafxW7erWBqbZlPWsSY4/Iu/ZPhCfxc=;
        b=Vq3gsHCh22pu/L4GkLo9ULfa7itd5dJk3+KSPrYg1/pgn6nKoIIyA6IuQMPNVJZa5y
         2/7LU5y+J4E1XAEbOVrrbkaDvbFtpcx/rXTS2kKJwD3Sfp4YWenMMOlWy6mKpSEziuNR
         9Sm5IXlP8FvKZhz1epBI+o3jTTBj4MfcOFdZAMjGEblAB6yM6rV7RkmNlugT8LvOGARm
         xQK3ScUmrQUtpzwL10UrmFvGSNFsmHTTFWp8OTichqQwVE3aHnD5L1Gx+O3MCGgttPbc
         sMGUJ8wdwGsUJgh3qZ6hfjKLyFdyzPUYSea1+r8myVFJ8ngAUG0fqtS0sZtq5483Oa6D
         vdyQ==
X-Gm-Message-State: AOAM532Iizwe1N/vlq1GVgto3LwqaDrOipYOLeyft1Jf3vTmnleXmPDI
        W4OHn/2eR4/G+m8cGJeCku/A7JXM/5DkNzXXUeLAukeiwks70J9ooWnaY6LnRT4dc28u4RjSUrp
        B0bhymr6d/aW+DyWkvLisaFdx
X-Received: by 2002:a17:906:5248:: with SMTP id y8mr1108915ejm.365.1640248872658;
        Thu, 23 Dec 2021 00:41:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5bgt2MYIRLflJyANil0Y6OmKNgC8Ia1Iz5Acis1wx1BFxwANsmf8mH0wUI2tH1SlcwMs2GA==
X-Received: by 2002:a17:906:5248:: with SMTP id y8mr1108900ejm.365.1640248872383;
        Thu, 23 Dec 2021 00:41:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id 13sm1500712ejh.225.2021.12.23.00.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 00:41:11 -0800 (PST)
Message-ID: <f594afab-8c1a-8821-a775-e5512e17ce8f@redhat.com>
Date:   Thu, 23 Dec 2021 09:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/3] HID: i2c-hid-acpi: Remove explicit
 device_set_wakeup_capable
Content-Language: en-US
To:     Raul Rangel <rrangel@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        mario.limonciello@amd.com, linux-input@vger.kernel.org,
        dianders@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20211220234346.2798027-1-rrangel@chromium.org>
 <20211220163823.1.Ie20ca47a26d3ea68124d8197b67bb1344c67f650@changeid>
 <7d4f20da-f18b-eccf-19c4-ea7c15492634@redhat.com>
 <CAHQZ30BSLE9G_fw3n4aSW_YOYc6w08eGiXdwa6eJxpR6eFpc+A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHQZ30BSLE9G_fw3n4aSW_YOYc6w08eGiXdwa6eJxpR6eFpc+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/22/21 00:40, Raul Rangel wrote:
> On Tue, Dec 21, 2021 at 11:49 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 12/21/21 00:43, Raul E Rangel wrote:
>>> The ACPI subsystem is responsible for managing the power and wake
>>> sources for an ACPI device. By explicitly calling
>>> device_set_wakeup_capable, we are circumvent the ACPI subsystem and
>>> setting wake capabilities on the device when it doesn't support it.
>>>
>>> Take the following example:
>>> * We have an ACPI HID device that has `_PR0` and `_PR3`. It doesn't have
>>> `_PRW` so that means the device can't wake the system.
>>> * The IRQ line is active level low for this device and is pulled up by the
>>> power resource defined in `_PR0`/`_PR3`.
>>>
>>> Since the i2c-hid driver has set the device as wake capable, the wake
>>> pin gets enabled on suspend.
>>
>> The IRQ pin should only have a enable_irq_wake() called on it if
>> something has actually requested the i2c-HID device to be a wakeup source,
>> the removed code claims the device is wakeup *capable*, but is also
>> explicitly calls device_set_wakeup_enable(dev, false), disabling wakeup.
>>
>> And i2c-hid suspend does:
>>
>>         if (device_may_wakeup(&client->dev)) {
>>                 wake_status = enable_irq_wake(client->irq);
>>
>> And device_may_wakeup() checks the wakeup *enabled* setting AFAIK.
>>
>> I've added Rafael to the Cc since he knows all this a lot better then me.
>>
>> I have the feeling that your userspace is perhaps poking the
>> wakeup settings in sysfs, triggering this issue.
> 
> You are correct, I added some printks in and it is userspace enabling the wake:
> 
>     [    3.280464] i2c_hid_acpi i2c-GDIX0000:00: wakeup_store: start: disabled
>     [    3.280502] i2c_hid_acpi i2c-GDIX0000:00: wakeup_store: start: enabled
>     [    3.280537] i2c_hid_acpi i2c-GDIX0000:00: device_wakeup_enable: start
>     [    3.280541] CPU: 0 PID: 1248 Comm: powerd Not tainted 5.10.83
> #151 c334d4c4185a84ded39aafcb495de6870a8e5161
>     [    3.280545] Hardware name: Google Guybrush/Guybrush, BIOS
> Google_Guybrush.4.15-624-g9d80a9c6aa40 12/21/2021
>     [    3.280548] Call Trace:
>     [    3.280554]  dump_stack+0x9c/0xe7
>     [    3.280560]  device_wakeup_enable+0x136/0x172
>     [    3.280564]  wakeup_store+0xbc/0xc4
>     [    3.280572]  kernfs_fop_write_iter+0x10b/0x18a
>     [    3.280576]  vfs_write+0x383/0x405
>     [    3.280579]  ksys_write+0x74/0xd4
>     [    3.280583]  do_syscall_64+0x43/0x55
>     [    3.280587]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
>>
>>> As part of suspend, ACPI will power down
>>> the device since it's not a wake source. When the device is powered
>>> down, the IRQ line will drop, and it will trigger a wake event.
>>
>> To me that sounds like the device is not wakeup *capable* at all, so
>> its ACPI node should not set the ACPI_FADT_LOW_POWER_S0 flag at all.
> 
> The ACPI_FADT_LOW_POWER_S0 flag is a system level flag. The
> system is wake capable and supports S0ix. The touchscreen device
> does not support waking the system because it doesn't provide
> a `_PRW`.

I've checked a whole bunch of DSDTs from standard x86 ACPI laptops and
it seems the _PRW is only used when devices use a GPE for wakeup; not when
they are using a standard GPIO-irq as wakeup source.

To be specific _PRW seems to only be present on PCI devices and on the
ACPI pwr-button and ACPI lid switch devices.

I2C attached touchpads and touchscreens seem to never have _PRW set
(at least in the collection of DSDTs which I have).

Note that what you are doing here is in essence completely reverting
commit 203c38fbe833 ("HID: i2c-hid: Enable wakeup capability from Suspend-to-Idle")
(note when I reviewed that I deliberately asked for the wakeup to be
disabled by default to avoid regressions).

Going ahead with this change would in essence cause regressions,
breaking wakeup by touchpad on many many laptops, so NACK.

>> Note I'm not certain about this at all, but at a first look this feels
>> like it is not the right fix for your problem.
> 
> We can't have the `i2c-hid-acpi` driver calling `device_set_wakeup_capable`.
> This will make the kernel expose the wakeup sysfs entry to userspace
> regardless if the device supports wakeup or not. This would require userspace
> to know that enabling this wake source will cause suspend problems and to
> avoid it.

I'm in 2 minds about this. To me this feels like the story where a person goes
to the doctor and says "doctor if I do this-thing it hurts". To which the doctor
replies: "Well then don't do this-thing". IOW if ChromeOS would not write the
wakeup sysfs attribute then there would be no problem

If I've understood the problem correctly then the issue is with a touchscreen
right? Unlike the I2C-HID driver which does not know the difference between
a touchpad, touchscreen or say a sensor-hub. Userspace can easily query the
associated input evdev node and NOT enable wakeup on touchscreens (which seems
to be a weird thing to do regardless of if it works properly or not).
Blindly enabling wakeup on all devices seems like it is a recipe for hitting
all sort of interesting bugs; and it seems best to just avoid that in
the first place.

As I said I'm in 2 minds about this, OTOH this does feel like a hardware
bug why does the interrupt trigger when the touchscreen is put into S3 ?

To me this feels as if the interrupt line is missing a pull-up/-down or
has the wrong pull-up/-down setting requiring it to be actively driven
to the not-irq state and sending an irq signal as soon as the line is
not actively driven. Could this be a problem with the configuration of
the built-in pull-up/-downs of the GPIO pin used for the IRQ
(which can be controlled by the firmware) ?

you are right that the kernel should not export a non working wakeup sysfs
attribute, so if this cannot be fixed in firmware, then the best option is
probably to add a quirk for this model to the existing quirk list in the
I2C-HID code and to not do the device_set_wakeup_capable() call on this
specific touchscreen based on a new quirk.

> I thought of something else:
> 
>> And i2c-hid suspend does:
>>
>>         if (device_may_wakeup(&client->dev)) {
>>                 wake_status = enable_irq_wake(client->irq);
>>
> 
> I think we also need to guard the enable_irq_wake call with
> `!ACPI_COMPANION(dev)`.
> ACPI will handle enabling the correct GPIO or GPE defined in `_PRW`.
> 

Calling enable_irq_wake() is necessary for wakeup to work on devices which
use a normal GPIO IRQ rather then a GPE for wakeup.

The only case where the enable_irq_wake() should probably not be done is when
their is an ACPI_COMPANION and that ACPI companion has a valid _PRW, which
as mentioned above most (all?) I2C-HID ACPI device nodes do _not_ have.

Regards,

Hans



>>>
>>> See the following debug log:
>>> [   42.335804] PM: Suspending system (s2idle)
>>> [   42.340186] amd_gpio AMD0030:00: RX: Setting wake for pin 89 to enable
>>> [   42.467736]     power-0416 __acpi_power_off      : Power resource [PR00] turned off
>>> [   42.467739] device_pm-0280 device_set_power      : Device [H05D] transitioned to D3cold
>>> [   42.475210] PM: pm_system_irq_wakeup: 11 triggered pinctrl_amd
>>> [   42.535293] PM: Wakeup unrelated to ACPI SCI
>>> [   42.535294] PM: resume from suspend-to-idle
>>>
>>> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
>>> ---
>>>
>>>  drivers/hid/i2c-hid/i2c-hid-acpi.c | 5 -----
>>>  1 file changed, 5 deletions(-)
>>>
>>> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
>>> index a6f0257a26de..fc311a19a19d 100644
>>> --- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
>>> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
>>> @@ -105,11 +105,6 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
>>>
>>>       acpi_device_fix_up_power(adev);
>>>
>>> -     if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
>>> -             device_set_wakeup_capable(dev, true);
>>> -             device_set_wakeup_enable(dev, false);
>>> -     }
>>> -
>>>       return i2c_hid_core_probe(client, &ihid_acpi->ops,
>>>                                 hid_descriptor_address);
>>>  }
>>>
>>
> 

