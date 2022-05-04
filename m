Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313025197D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345259AbiEDHJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345236AbiEDHI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:08:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8731F621;
        Wed,  4 May 2022 00:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651647904;
        bh=mMc3bKJ5bARSc3IOJZCgKaDycLjp4WC8jucmpRGTgQY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lM9mkX7hYWvhmnr6iAClqIJ71Jwrjb4gUNS0z9Huf+Sz9kRr+syTn+MOdxG6DcRwP
         WE8KnO3lhcs6VGRoETIqirBk+BOsz0HzmXDU+x3ZHTUnllyxeS+KpMdLJIitWsVdWU
         YhmA8zj1aYqkjZ5mezFGD9JrfR09N6Uu+V5LwrIQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7iCW-1nqBaU2K70-014jMb; Wed, 04
 May 2022 09:05:04 +0200
Subject: Re: [PATCH 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
To:     Guenter Roeck <linux@roeck-us.net>,
        LABBE Corentin <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220502124249.682058-1-clabbe@baylibre.com>
 <20220502124249.682058-2-clabbe@baylibre.com>
 <0b154a30-7765-e3ac-9980-0ecc7447d7ad@roeck-us.net> <YnAqDxfTU27USQI+@Red>
 <1b2bf215-faa1-649d-5ab4-85fc0b907ec2@gmx.de>
 <dabc2be2-36ce-a9d4-8aa5-ae3f2a57f904@roeck-us.net>
 <72cce35f-a227-cd18-17f0-00eee350bcf4@gmx.de>
 <367acd5f-9130-f071-7146-21212b578043@roeck-us.net>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <55fa8f93-e9ac-df87-eb4e-b5e20360658f@gmx.de>
Date:   Wed, 4 May 2022 09:05:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <367acd5f-9130-f071-7146-21212b578043@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:afakAUqS4OtOxwTE5b4XdL7xdVrGAWCIHJ2BZRR2Irz6XZiJVvy
 cN9FHRX5lVvBWFWoXNsUWz/Ac5Q3MGOicxree4vb4hjf5NvpNYsjTNvpfx/e2RnQAXwArW8
 cbWH1itkt97CIlz5gplJ3yD6BZdPpJvd/DLZrRtqP0vE3zttqaw6J9bnh23tCSTOR8Nz+Qy
 5Das0iIkr8MbEkh/7llWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cUoedrbzUKs=:KWeX665n6A3cdcCUbZMt8m
 7xdljR5kq6TbJR+N6yfRmj54WZrR0SV05px7cimNxdp2PwkZD3Aywe8gYEghrJlfrFraiYjfu
 8I3azZV8jsfbmWJHYQ88E0OmygHuvifporunCI6FsUZR3wGqmo++BrVU4bekgJcT1DrLTsTNB
 /wKIKEzMKzaILSbYdY8SM/pMQ6FnTnn/nQ+RMYdPMcHm4/zljiowWqIv1vkthmI7P9e9hth2a
 Imwb1s4GBZY3JUEfT1nVTbKPrK4P/37mGEKOuWsORinRgSekTp2+6GN+QBcdguenXAmJKSOrP
 TDMSwgdpwRUUeG2G6nV3Ky3S3Zw05m/1Wg7wQ0dw8/W/maSxMRtIohfhQPO62JN/FfmIJy6s2
 Qf3JDfr28lP4kNh4qqYi+4cYWeBgl20A++kDZaZbH7jxPGuCEJCWpoN/bIEKAPXk9VyAGxrw+
 MIBJwl5iwFt8E6mqqCvPLuJYtHcrnpLJbekDe09Jk0Yd1WPm8Bm77OzxYsPxtAlLAu/e7bejh
 DVT1fYty+9HbRloeq17kkovxIZYToOrg4+LzMMPiatwMoc5j6WfzIL8/Olg01buxB1pMvOz4C
 Pz54PVC329XTX9YuxSd/KqzEWPrBNS1RG4iSzXa7zdAUHwXGKyfSADfK/BfzAqTlbHtunL7bo
 t8wipNn4SlkxofMuBy0j7eNVCG45c5gds6ZY8fcGMG2dMJYffsK5csM/bx4o3XBxXk0+USqFp
 aAD1JEymIeysASlfCbr7lu27p1dQUrOsVFIyX+LaEM+4hwYUj0sX9p6OpmDLBcWEaKcHabw3K
 2LeJqiIwiRY3CnbtmvmY5T5TBxksydNdLIgU1BC4ytZEP0Nl+F0zQFu9qws8XD5piYP0p8OCf
 pep2Cyt6hYDTB2cj+7Kt/4RWEfdy0rSphMiiKX2dp3A1C6bpGP++FaK8R5CwQIyrZXHMlx7ov
 KRhivA5K3z7w8cMxv3b72jDn/R2ZrYVcV5PxRR4EAcPsNitNP0/fBRFmcdacYL83ZcA/ff6Lz
 KYiyQIS5OEOvfwzJN+y1xJHgYX80aTMq9Uy3LYNjMBI3vARpxaEIzAjMtp4NIfE0kwTsyjdjf
 sIl93Lw6HqtnuA=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.05.22 um 01:43 schrieb Guenter Roeck:

> On 5/2/22 14:00, Armin Wolf wrote:
>> Am 02.05.22 um 22:42 schrieb Guenter Roeck:
>>> On 5/2/22 13:31, Armin Wolf wrote:
>>>> Am 02.05.22 um 20:59 schrieb LABBE Corentin:
>>>>
>>>>> Le Mon, May 02, 2022 at 06:34:44AM -0700, Guenter Roeck a =C3=A9crit=
 :
>>>>>> On 5/2/22 05:42, Corentin Labbe wrote:
>>>>>>> Booting lead to a hwmon_device_register() is deprecated. Please
>>>>>>> convert the driver to use hwmon_device_register_with_info().
>>>>>>> So let's convert the driver to use
>>>>>>> hwmon_device_register_with_info().
>>>>>>>
>>>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>>>>> ---
>>>>>>> =C2=A0=C2=A0 drivers/hwmon/acpi_power_meter.c | 5 ++++-
>>>>>>> =C2=A0=C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/hwmon/acpi_power_meter.c
>>>>>>> b/drivers/hwmon/acpi_power_meter.c
>>>>>>> index d2545a1be9fc..98293727f980 100644
>>>>>>> --- a/drivers/hwmon/acpi_power_meter.c
>>>>>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>>>>>> @@ -891,7 +891,10 @@ static int acpi_power_meter_add(struct
>>>>>>> acpi_device *device)
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (res)
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
exit_free_capability;
>>>>>>>
>>>>>>> -=C2=A0=C2=A0=C2=A0 resource->hwmon_dev =3D hwmon_device_register(=
&device->dev);
>>>>>>> +=C2=A0=C2=A0=C2=A0 resource->hwmon_dev =3D
>>>>>>> hwmon_device_register_with_info(&device->dev,
>>>>>>> + ACPI_POWER_METER_DEVICE_NAME,
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL=
,
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
>>>>>> NACK. That isn't a conversion to the new API, it just abuses the
>>>>>> fact
>>>>>> that the new API has to accept a NULL info pointer for historic
>>>>>> reasons.
>>>>>>
>>>>> Hello
>>>>>
>>>>> I am sorry, I found a driver doing it, so I believed it was okay.
>>>>> Converting seems not to hard but, by using the new API, how can I
>>>>> convert power1_model_number/power1_is_battery attribute ?
>>>>> There are the remaining attributes I dont find how to convert.
>>>>>
>>>>> Regards
>>>>
>>>> Hi,
>>>>
>>>> for allowing the driver to provide nonstandard attributes,
>>>> hwmon_device_register_with_info()
>>>> has the argument "extra_groups" which is an pointer to a list of
>>>> sysfs attribute groups.
>>>> There are some drivers which are using this functionality, maybe you
>>>> can use them as an
>>>> inspiration.
>>>>
>>>> Just a question: what is the name of the driver you originally used
>>>> as an inspiration?
>>>>
>>>
>>> Originally it was for drivers/thermal/thermal_hwmon.c. Now there is
>>> also
>>> drivers/platform/mips/cpu_hwmon.c which is clearly an abuse. I may hav=
e
>>> missed others.
>>>
>>> Guenter
>> Should we notify the maintainers of cpu_hwmon.c about that?
>> This could potentially prevent such incidents from happening again.
>>
>
> I am more inclined to create a special API for thermal, call it from
> the thermal code, and issue a warning with backtrace if anyone else
> calls hwmon_device_register_with_info() with NULL info pointer.
> And explain all that in detail in the API documentation.
>
> Guenter
Sounds good.

Armin Wolf
