Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDCC475628
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhLOKWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:22:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233789AbhLOKWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639563770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sN85kJ5BVIX7SJggp68Vh2TuPaLa+7Zowk6DvU/tm0M=;
        b=WaxhE4020VNNC+PZD0g6NjQQvgYGBgxELLlDuP7hMYZgWR0na9i+R+71LsL1Aqf2w9jmof
        tQKOLsOdvMeJ63SEOR2aB7bW488R5I1B5hnaUlQQa2s4y3WVO4YXaFedUrbfq7OCa9/OgB
        YR/qG0G1+BVd59SuYw99SvZP+f+gtH0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-JFsKKp7GMw-B3u_GM8wj6w-1; Wed, 15 Dec 2021 05:22:49 -0500
X-MC-Unique: JFsKKp7GMw-B3u_GM8wj6w-1
Received: by mail-ed1-f71.google.com with SMTP id y11-20020a056402358b00b003f7ce63b89eso2953859edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sN85kJ5BVIX7SJggp68Vh2TuPaLa+7Zowk6DvU/tm0M=;
        b=j0Ju8MrJndPLy2GNQ9ikVyTYddF0dNjX5YfwyfGJvf709Yxz1hfCbw+uGm/8iU1GVZ
         l3PHWab1gc9J9xy0Rx5fiuM2bWzt4qW734amIV2VcSZo/KrZadpBBNqMdCLP2juRzunI
         2+39/m2CG6QkL90BRt6DhC0vZGsxjlNX5wGP349uDZezPteBWGr7PbxcRnFm/nsG2jH0
         a6RDhyKrqYffqKxTLALE1TVmfowsoITSoevjA0B/5FhL8cn4/kgcvInOjdWFMrF8AYZJ
         NK6KLNfM4zGttDX8ZFYXH+Ks3OA5VQ+U1GKI5q5TV2VJhBJ1KQ5zht+lE3Gj8i2fzjBu
         6S9w==
X-Gm-Message-State: AOAM5320q6j33swIh2sHSVDvfOYw26dZl3MEXTQuHRx7jPnpKLQRw1ft
        VbnxTx3pJILF2PFtUCIxsr+wE5fTqsiydFc3905O+xVYWb29n4GHcSIHoyCXqdCiCDITZ78mXP3
        gJxgpM821WymSwCV/exWtYgbt
X-Received: by 2002:a17:907:7242:: with SMTP id ds2mr9982333ejc.269.1639563767783;
        Wed, 15 Dec 2021 02:22:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztW3Db4ls0Z7qFhAjfiWXizIwwqnpXo3THJgcrxm7KdGZeAS9A/6HMP16fG0ZRw9VmeDZl0Q==
X-Received: by 2002:a17:907:7242:: with SMTP id ds2mr9982324ejc.269.1639563767591;
        Wed, 15 Dec 2021 02:22:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id sd2sm558377ejc.22.2021.12.15.02.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 02:22:47 -0800 (PST)
Message-ID: <fd960dc4-2702-6031-f628-6140289f0f4b@redhat.com>
Date:   Wed, 15 Dec 2021 11:22:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 0/6] Support Spi in i2c-multi-instantiate driver
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        'Mark Brown' <broonie@kernel.org>,
        "'Rafael J . Wysocki'" <rafael@kernel.org>,
        'Len Brown' <lenb@kernel.org>,
        'Mark Gross' <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
 <8160a1c8-544d-6d95-4f80-224c7a9a9d40@redhat.com>
 <002401d7f016$3bb4f260$b31ed720$@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <002401d7f016$3bb4f260$b31ed720$@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/13/21 12:40, Stefan Binding wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: 10 December 2021 16:55
>> To: Stefan Binding <sbinding@opensource.cirrus.com>; Mark Brown
>> <broonie@kernel.org>; Rafael J . Wysocki <rafael@kernel.org>; Len Brown
>> <lenb@kernel.org>; Mark Gross <markgross@kernel.org>
>> Cc: linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org; linux-
>> acpi@vger.kernel.org; platform-driver-x86@vger.kernel.org;
>> patches@opensource.cirrus.com
>> Subject: Re: [PATCH v2 0/6] Support Spi in i2c-multi-instantiate driver
>>
>> Hi Stefan,
>>
>> On 12/10/21 16:40, Stefan Binding wrote:
>>> Add support for SPI bus in the ic2-multi-instantiate driver as
>>> upcoming laptops will need to multi instantiate SPI devices from a
>>> single device node, which has multiple SpiSerialBus entries at the
>>> ACPI table.
>>>
>>> With the new SPI support, i2c-multi-instantiate becomes
>>> bus-multi-instantiate and is moved to the ACPI folder.
>>>
>>> The intention is to support the SPI bus by re-using the current I2C
>>> multi instantiate, instead of creating a new SPI multi instantiate, to
>>> make it possible for peripherals that can be controlled by I2C or SPI
>>> to have the same HID at the ACPI table.
>>>
>>> The new driver (Bus multi instantiate, bmi) checks for the hard-coded
>>> bus type and returns -ENODEV in case of zero devices found for that
>>> bus. In the case of automatic bus detection, the driver will give
>>> preference to I2C.
>>>
>>> The expectation is for a device node in the ACPI table to have
>>> multiple I2cSerialBus only or multiple SpiSerialBus only, not a mix of
>>> both; and for the case where there are both entries in one device
>>> node, only the I2C ones would be probed.
>>>
>>> This new bus multi instantiate will be used in CS35L41 HDA new driver,
>>> being upstreamed:
>>> https://lkml.org/lkml/2021/11/23/723
>>
>> Unfortunately you never really answered my questions about v1 of this
>> series:
>>
>> https://lore.kernel.org/platform-driver-x86/a1f546c2-5c63-573a-c032-
>> 603c792f3f7c@redhat.com/
>>
>> So looking at the linked CS35L41 HDA series there is a single ACPI device node
>> with a HID of CLSA0100 which describes two CS35L41 amplifiers connected
>> over I2C ?
> 
> Yes, the related series uses HID CLSA0100, which contains 2 I2C devices inside a
> single node. This ID was mistakenly used for this laptop, and instead CSC3551 
> has been used for subsequent laptops.
> 
>>
>> I assume you are doing this work because there are also designs where there
>> is a similar CLSA0100 ACPI device which also describes two CS35L41 amplifiers
>> but then connected over SPI ?
> 
> Yes, there are several laptop designs which use an equivalent ACPI which describes
> 2 or 4 CS35L41 amplifiers which are connected either via I2C or via SPI.
> Both designs use the same ACPI design and have 2-4 devices (either I2C or SPI)
> defined inside a single ACPI node for HID CSC3551.
> Note that the devices inside the node can be either SPI or I2C, but never SPI
> and I2C.
> 
>>
>> It would really help if you can:
>>
>> 1. Answer my questions from v1
> 
> I hope my colleague Lucas has answered these questions now.

Yes, thank you .

>> 2. Provide a concrete example of a device where these changes will be
>> necessary to make things work, preferably with a link to an actual ACPI DSDT
>> of that device.
> 
> This is the CSC3551 node for a laptop with 4 SPI nodes, with a shared IRQ:
> 
>  Scope (_SB.PC00.SPI0)
>     {
>         Device (GSPK)
>         {
>             Name (_HID, "CSC3551")  // _HID: Hardware ID
>             Method (AUID, 0, NotSerialized)
>             {
>                 Return ("103C89C3")
>             }
> 
>             Method (_SUB, 0, NotSerialized)  // _SUB: Subsystem ID
>             {
>                 Return (AUID ())
>             }
> 
>             Name (_UID, One)  // _UID: Unique ID
>             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>             {
>                 Name (RBUF, ResourceTemplate ()
>                 {
>                     SpiSerialBusV2 (0x0000, PolarityLow, FourWireMode, 0x08,
>                         ControllerInitiated, 0x003D0900, ClockPolarityLow,
>                         ClockPhaseFirst, "\\_SB.PC00.SPI0",
>                         0x00, ResourceConsumer, , Exclusive,
>                         )
>                     SpiSerialBusV2 (0x0001, PolarityLow, FourWireMode, 0x08,
>                         ControllerInitiated, 0x003D0900, ClockPolarityLow,
>                         ClockPhaseFirst, "\\_SB.PC00.SPI0",
>                         0x00, ResourceConsumer, , Exclusive,
>                         )
>                     SpiSerialBusV2 (0x0002, PolarityLow, FourWireMode, 0x08,
>                         ControllerInitiated, 0x003D0900, ClockPolarityLow,
>                         ClockPhaseFirst, "\\_SB.PC00.SPI0",
>                         0x00, ResourceConsumer, , Exclusive,
>                         )
>                     SpiSerialBusV2 (0x0003, PolarityLow, FourWireMode, 0x08,
>                         ControllerInitiated, 0x003D0900, ClockPolarityLow,
>                         ClockPhaseFirst, "\\_SB.PC00.SPI0",
>                         0x00, ResourceConsumer, , Exclusive,
>                         )
>                     GpioIo (Exclusive, PullUp, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                         "\\_SB.GPI0", 0x00, ResourceConsumer, ,
>                         )
>                         {   // Pin list
>                             0x0000
>                         }
>                     GpioIo (Exclusive, PullUp, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                         "\\_SB.GPI0", 0x00, ResourceConsumer, ,
>                         )
>                         {   // Pin list
>                             0x0000
>                         }
>                     GpioIo (Exclusive, PullUp, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                         "\\_SB.GPI0", 0x00, ResourceConsumer, ,
>                         )
>                         {   // Pin list
>                             0x0000
>                         }
>                     GpioIo (Exclusive, PullDown, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                         "\\_SB.GPI0", 0x00, ResourceConsumer, ,
>                         )
>                         {   // Pin list
>                             0x0000
>                         }
>                     GpioIo (Shared, PullUp, 0x0064, 0x0000, IoRestrictionInputOnly,
>                         "\\_SB.GPI0", 0x00, ResourceConsumer, ,
>                         )
>                         {   // Pin list
>                             0x0000
>                         }
>                     GpioInt (Edge, ActiveBoth, Shared, PullUp, 0x0064,
>                         "\\_SB.GPI0", 0x00, ResourceConsumer, ,
>                         )
>                         {   // Pin list
>                             0x0000
>                         }
>                 })
>                 CreateWordField (RBUF, 0xCA, ACS1)
>                 CreateWordField (RBUF, 0xA7, ACS2)
>                 CreateWordField (RBUF, 0xED, ACS3)
>                 CreateWordField (RBUF, 0x0110, ARST)
>                 CreateWordField (RBUF, 0x0133, AINT)
>                 CreateWordField (RBUF, 0x0156, AIN2)
>                 ACS1 = GNUM (0x090E0016)
>                 ACS2 = GNUM (0x090E0017)
>                 ACS3 = GNUM (0x090C0006)
>                 ARST = GNUM (0x09070017)
>                 AINT = GNUM (0x09070013)
>                 AIN2 = GNUM (0x09070013)
>                 Return (RBUF) /* \_SB_.PC00.SPI0.GSPK._CRS.RBUF */
>             }
> 
>             Method (_STA, 0, NotSerialized)  // _STA: Status
>             {
>                 Return (0x0F)
>             }
> 
>             Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
>             {
>             }
>             Name (_DSD, Package ()  // _DSD: Device-Specific Data
>             {
>                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
>                 Package ()
>                 {
>                     Package () { "cirrus,dev-index", Package () { 0, 1, 2, 3 } },
>                     Package ()
>                     {
>                         "reset-gpios", Package ()
>                         {
>                             ^GSPK, 3, 0, 0,
>                             ^GSPK, 3, 0, 0,
>                             ^GSPK, 3, 0, 0,
>                             ^GSPK, 3, 0, 0,
>                         },
>                     },
>                     Package () { "cirrus,speaker-position",     Package () { 1, 0, 1, 0 } },
>                     Package () { "cirrus,gpio1-func",           Package () { 3, 3, 3, 3 } },
>                     Package () { "cirrus,gpio2-func",           Package () { 2, 2, 2, 2 } },
>                     Package () { "cirrus,boost-ind-nanohenry",  Package () { 1000, 1000, 1000, 1000 } },
>                     Package () { "cirrus,boost-peak-milliamp",  Package () { 4500, 4500, 4500, 4500 } },
>                     Package () { "cirrus,boost-cap-microfarad", Package () { 24, 24, 24, 24 } },
>                 }
>             })
>         }
>     }
> 
> This is just our node from the DSDT, we are working to obtain and share the full DSDT, if still required.

Thanks, there is no need to share the full DSDT, this is exactly what I was looking for.

With the provided info I believe that this indeed is the right approach
and I no longer have any objections against this approach.

I will try to make some time to review this series soon-ish.

Regards,

Hans


