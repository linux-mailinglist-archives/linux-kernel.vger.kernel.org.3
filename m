Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF94AA846
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 12:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbiBELMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 06:12:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236239AbiBELMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 06:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644059535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HxRKbMd6yJD0WTJ1BQa8FtU2nYlcfxwjlj/el9ULOxc=;
        b=PNZdrptAsCpzTOIjASegxYzaNU6GaQCU4YP0R2RTvzCR2QYSm2O8UG5MIq9oiGAlEjbsb4
        MPTBzOWGXs/Nm7gb8hnPISSA7unU70fTYSZcq7rVp8SJB1C69RGi2UvCHbA5f5te9vZv2s
        zDAr4fQInGS33ZTfZQ6mFu3wfYSMkdU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-AJdbX42aMHmjvNrfFGSV9g-1; Sat, 05 Feb 2022 06:12:13 -0500
X-MC-Unique: AJdbX42aMHmjvNrfFGSV9g-1
Received: by mail-ed1-f69.google.com with SMTP id j1-20020aa7c341000000b0040417b84efeso4488030edr.21
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 03:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HxRKbMd6yJD0WTJ1BQa8FtU2nYlcfxwjlj/el9ULOxc=;
        b=rx8gqBAHi1yQE8nzGSygcpblWRVrzB2tpBTAXn9KKpQWRvY8Eh1g186CxPtQqibo9J
         bzHlSVQgKDIm80JE5n8qGNzv+d0p2V+SZ90QdNx4M20EwYw52nhQFzOp3Mur4ILOmGdu
         JzPcpOBMIlojwupiuxzH8NHS+pm+8leLywAmE6ChsUjjJhoVSbMnFdF2TCuaovgMvbUY
         cwJMMPeY6xrWCOLHuSiNVdrehptmAPyb9ANTJBVVMUDCKMPkvo3qC/6/FunP03kzxuWS
         qA2UsPyPnVJFGEgHC66qKw85Z18fb3xiyEcWDntWB9q0eFQRUQMJyP6jCu1cAOg3GidM
         TtBg==
X-Gm-Message-State: AOAM531CU0478BeJSpDZSyRR1tJQqGetcsyS1oA+bnJDpVT9o1OhqB4W
        HE3LxMM926WnTz1E1/RaitY2K7yj0wkCv5H/A4/56U28aHLLi/CGPw6nhY59G1FkaEG6Qxx7WSp
        iDu1oRGbUbcd5/rFKfzoPT0L0
X-Received: by 2002:a05:6402:4385:: with SMTP id o5mr3910664edc.48.1644059532541;
        Sat, 05 Feb 2022 03:12:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxf0nwNP4MQHLuEUoev9Jx+1p/wmKAruyS0lSh+DlBNq/siLqNWSIjOwctVLGsAmWy29oOpHg==
X-Received: by 2002:a05:6402:4385:: with SMTP id o5mr3910641edc.48.1644059532163;
        Sat, 05 Feb 2022 03:12:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id d18sm1517919ejd.95.2022.02.05.03.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 03:12:11 -0800 (PST)
Message-ID: <0af0150d-c66e-3f46-f9a5-bb2886045e03@redhat.com>
Date:   Sat, 5 Feb 2022 12:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Wrongly bound Elantech touchpad on Lenovo Yoga Slim 7
Content-Language: en-US
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Takashi Iwai <tiwai@suse.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <s5hleyqwowl.wl-tiwai@suse.de>
 <CAO-hwJK-7migm7VWkwvTPHwxgTZEbNX0XYpk0A1pr6N2jkYrxw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAO-hwJK-7migm7VWkwvTPHwxgTZEbNX0XYpk0A1pr6N2jkYrxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/4/22 18:39, Benjamin Tissoires wrote:
> Hi,
> 
> [adding Dmitry, the maintainer of the input tree and Hans, a colleague of mine]
> 
> On Fri, Feb 4, 2022 at 5:57 PM Takashi Iwai <tiwai@suse.de> wrote:
>>
>> Hi,
>>
>> we've got a bug report on openSUSE Bugzilla about the broken touchpad
>> on Lenovo Yoga Slim 7:
>>   https://bugzilla.opensuse.org/show_bug.cgi?id=1193064
>>
>> The touchpad is an Elantech one, connected over i2c, and there are two
>> drivers supporting it.  Unfortunately, the default one the system
>> binds, elan-i2c input driver, doesn't seem working properly, while
>> i2c-hid driver works.
> 
> Hans, we do have a similar bug on RHEL at
> https://bugzilla.redhat.com/show_bug.cgi?id=2029078 (sorry, private
> bug).
> 
> IIRC you worked on the discrimination between i2c-hid and elan_i2c (I
> might be completely wrong though).

Yes I did work on that, but then the other way around making sure
that the i2c-hid driver would not bind to some devices which need
the elan_i2c touch*pad* driver.

And indeed as Dmitry points out:

> I believe we need to do what Hans did for Elan Touch*screen* driver and
> avoid binding to the device if it has i2c-hid-specific _DMS in ACPI.
> I.e. we need to replicate elants_acpi_is_hid_device().
> 
> Even better would be to factor it out, maybe not into a shared module
> but simply shared header with static inline function that we could share
> between elan drivers and maybe others as well.

I did fix a similar problem for the touchscreen driver last year or so.

I agree with Dmitry that we should try to avoid DMI matching here;
and I also agree that having some header with a static inline
acpi_is_hid_device() device helper would be good.

I'm a bit worried about the acpi_is_hid_device() approach though,
there is a lot of copy and pasting going on when vendors create
ACPI tables and sometimes a "PNP0C50" CID is present combined
with a valid i2c-hid _DSM method even though the device is not
an i2c-hid device, also see the i2c_hid_acpi_blacklist[] in
drivers/hid/i2c-hid/i2c-hid-acpi.c .

It seems to me that the problem is that the Lenovo Yoga Slim 7
is using what seems to be a very generic "ELAN0000" ACPI hardware
id instead of one of the many more specific ones.

So we could limit the acpi_is_hid_device() check to just the
"ELAN0000" ACPI hardware id I guess?

So I see the following 2 options:

1. Add an unconditional acpi_is_hid_device() check to elan_probe()
   and watch out for any bug-reports that this is causing breakage
   elsehwere
2. Add an acpi_is_hid_device() check to elan_probe() for ACPI enumerated
   touchpads with a hardware-id of ELAN0000 only; and still
   watch out for any bug-reports that this is causing breakage
   elsehwere just to be sure

Regards,

Hans





>> I'm not sure what's the best fix for this, but below a quick
>> workaround using a deny list with DMI matching.
>> If this is OK, I can resubmit the patch for merging.
>>
>> Any comments appreciated.
>>
>>
>> thanks,
>>
>> Takashi
>>
>> -- 8< --
>> From: Takashi Iwai <tiwai@suse.de>
>> Subject: [PATCH] Input: elan_i2c: Add deny list for Lenovo Yoga Slim 7
>>
>> The touchpad on Lenovo Yoga Slim 7 doesn't work well with elan-i2c but
>> rather better with i2c-hid.  Add a deny list for avoiding to bind with
>> elan-i2c.
>>
>> BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1193064
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> ---
>>  drivers/input/mouse/elan_i2c_core.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
>> index 47af62c12267..fd08481f7aea 100644
>> --- a/drivers/input/mouse/elan_i2c_core.c
>> +++ b/drivers/input/mouse/elan_i2c_core.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/acpi.h>
>>  #include <linux/delay.h>
>>  #include <linux/device.h>
>> +#include <linux/dmi.h>
>>  #include <linux/firmware.h>
>>  #include <linux/i2c.h>
>>  #include <linux/init.h>
>> @@ -1222,6 +1223,20 @@ static void elan_disable_regulator(void *_data)
>>         regulator_disable(data->vcc);
>>  }
>>
>> +static const struct dmi_system_id elan_i2c_denylist[] __initconst = {
>> +#if IS_ENABLED(CONFIG_I2C_HID_ACPI)
>> +       {
>> +               /* Lenovo Yoga Slim 7 is better supported by i2c-hid */
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "82A3"),
>> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "Yoga Slim 7 14ITL05"),
>> +               },
>> +       },
>> +#endif
>> +       { }
>> +};
>> +
>>  static int elan_probe(struct i2c_client *client,
>>                       const struct i2c_device_id *dev_id)
>>  {
>> @@ -1233,6 +1248,10 @@ static int elan_probe(struct i2c_client *client,
>>
>>         if (IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_I2C) &&
>>             i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>> +               if (dmi_check_system(elan_i2c_denylist)) {
>> +                       dev_info(dev, "Hits deny list, skipping\n");
>> +                       return -ENODEV;
>> +               }
>>                 transport_ops = &elan_i2c_ops;
>>         } else if (IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_SMBUS) &&
>>                    i2c_check_functionality(client->adapter,
>> --
>> 2.31.1
>>
>>
>>
>>
>>
>>
>>
> 

