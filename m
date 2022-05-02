Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A7E5178B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387512AbiEBVEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387571AbiEBVD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:03:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EC2E1B;
        Mon,  2 May 2022 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651525212;
        bh=t+hthDPvIlMi9NfBj+0zjxZtl8ZtreiL6WlpPmAvFKQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Doy2CmDUq/Kq2q/jd+Cv4azrWGDUJT3YJodM5yHStynRebV8lpRYAdOCLEHnxK2XU
         Iac4viEMa+8XKPdA0xcFYkKF11Jf7uGtJBVQhEQwT9ZOlLm3hTRDsuXahAEtY+jF3o
         enMA/s57S8Yik6zw6yra6qZkrFxZewQsJkXmNVBc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSt8W-1nP38E2iic-00UFSy; Mon, 02
 May 2022 23:00:12 +0200
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
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <72cce35f-a227-cd18-17f0-00eee350bcf4@gmx.de>
Date:   Mon, 2 May 2022 23:00:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <dabc2be2-36ce-a9d4-8aa5-ae3f2a57f904@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:FqbPnGyKm8pJ5TzgnH7TmE5YcAX3wsNf1IDG/uGi6Mb26x8Yq7R
 eLdRgM6AlT2tNshRq7tUJYIB6OGLYtX9ucH4uVRZEftkigQfgmUFu0MWbods+E4P1UGN6VC
 oAXIpOyUj5Gjs9dy06Yr6pXsXSmw+DZgcMm7IPvAyiX9os9dMqUzytsSbFF93FICSSVj/yo
 u4cPRUfVBtvVwqvXJ2+4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:59vlulbQkmo=:/9DGdmxyWPAsq2g4yAUchr
 Y+jU7R8Iu34xsI0rNSfvEYez2XOJjGpzv2pVA537FcqCHqbHQcqkjGhUIjovLTo8fzpLZhWMp
 tVmTY09YnXlFUHe80NAwda8vRuKKwE/ndJzvsEctFXgXAcqfkn+mTXG6nD1xWXfVL6kYu4lqT
 8ainEnEH8gPtkfiwBpf6+20MK1mnoajJ3JhfU/QXDQU6vCGdiiEMIJFzssgoYh7hm/EAF/guP
 rlruZJ4ikMzo4is5i4PfHiy8Cs5UX79eZ52zWUNAJqiE9uAAn4DoGQN5O/N60BYS4Fwz19DXw
 RbNlXaGfs4btvjECrxU1FewGnZc4IKrAiNNXUqziyEr+X0h5Kt8k88kiem1id4bKo1xSpaOh8
 scxUXpfhxw+yAwG2LLoWea1RCyGsVKSL1zBtR8IWPTmn2uhjxR4URDBRH6PNH8h71Yb8JZ0Fs
 rTkXPkN9wCccAPMv6T7rBz83u/VgnAS0Yjql0x8tyS60hDdf3FwL4F/0o/ccFHNJ2Jfr5TnoT
 ZIbSdaj8byfSmX4M30YfJ1fGBnIjS5plBnUGlHL7M0GWQiT0B5EnVxIiuqmu9C8e4v9i9MlrJ
 Iyi8EnV2XY2t2asAWgESLaqKePxe+F4R86IeqY9xtJdLjILLrh/l9H+WvGXZeHDhhF5rsE8UU
 ij44uoHiYbWkD/pyNCQV9t3i5yDfdI1ewhJWnAYK4SgnXtCnJr1Wxi+BP4IgamZA8UJ6rmkre
 DbENW9GQNUmaBsG0nTaJxdvsBK5Nkw6yIW+vwjX2cFT3NTYBHrrG3pQrC4vH1XtZwDiZkxUXr
 q08jtPaajwsnCi49UqljpgOk3sdkXrCb3fCaZqeiMH1j5FdgRpW66v6huR8Wmg6Kf6i9Q6KHz
 zYQI1D9YC7KeDq3cyuZWxQXRTrbL8YtdSUvHurDGJM/ysJEMer6TAs6gDTXVgRT9kCgCi8vPs
 mZm96CyEhGBiwUWyPcDM3diDEWUxr4308HQi4ntHagxFbo+RvnNCbVKqE+bZN3OnnBN12rs73
 e08QlPaIdlvpBLmd2P6TKifo/4qmCuQugv0sahpBVUAWuCrPm4J4fZF+X1um8MTzzzzf09v1u
 R0cU8MswG7o4wLmX8CuqqwX2l3/m0CW1mK4rl1OneVmRF1CTL7hKEU9Y0aZkeorGbvWa3FVUB
 XXSfNFgnKTuRO3u7iZOYQ1BuiUSxd3kk38+3UpPT/HaktrAn/vORRdqwpNAr68JG0X14+h0bE
 wDekQylOp3oc9ySvevcuAwK6kJKXL2sMC4lWUqA==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.05.22 um 22:42 schrieb Guenter Roeck:
> On 5/2/22 13:31, Armin Wolf wrote:
>> Am 02.05.22 um 20:59 schrieb LABBE Corentin:
>>
>>> Le Mon, May 02, 2022 at 06:34:44AM -0700, Guenter Roeck a =C3=A9crit :
>>>> On 5/2/22 05:42, Corentin Labbe wrote:
>>>>> Booting lead to a hwmon_device_register() is deprecated. Please
>>>>> convert the driver to use hwmon_device_register_with_info().
>>>>> So let's convert the driver to use hwmon_device_register_with_info()=
.
>>>>>
>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 drivers/hwmon/acpi_power_meter.c | 5 ++++-
>>>>> =C2=A0=C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/hwmon/acpi_power_meter.c
>>>>> b/drivers/hwmon/acpi_power_meter.c
>>>>> index d2545a1be9fc..98293727f980 100644
>>>>> --- a/drivers/hwmon/acpi_power_meter.c
>>>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>>>> @@ -891,7 +891,10 @@ static int acpi_power_meter_add(struct
>>>>> acpi_device *device)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (res)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ex=
it_free_capability;
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0 resource->hwmon_dev =3D hwmon_device_register(&d=
evice->dev);
>>>>> +=C2=A0=C2=A0=C2=A0 resource->hwmon_dev =3D
>>>>> hwmon_device_register_with_info(&device->dev,
>>>>> + ACPI_POWER_METER_DEVICE_NAME,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
>>>> NACK. That isn't a conversion to the new API, it just abuses the fact
>>>> that the new API has to accept a NULL info pointer for historic
>>>> reasons.
>>>>
>>> Hello
>>>
>>> I am sorry, I found a driver doing it, so I believed it was okay.
>>> Converting seems not to hard but, by using the new API, how can I
>>> convert power1_model_number/power1_is_battery attribute ?
>>> There are the remaining attributes I dont find how to convert.
>>>
>>> Regards
>>
>> Hi,
>>
>> for allowing the driver to provide nonstandard attributes,
>> hwmon_device_register_with_info()
>> has the argument "extra_groups" which is an pointer to a list of
>> sysfs attribute groups.
>> There are some drivers which are using this functionality, maybe you
>> can use them as an
>> inspiration.
>>
>> Just a question: what is the name of the driver you originally used
>> as an inspiration?
>>
>
> Originally it was for drivers/thermal/thermal_hwmon.c. Now there is also
> drivers/platform/mips/cpu_hwmon.c which is clearly an abuse. I may have
> missed others.
>
> Guenter
Should we notify the maintainers of cpu_hwmon.c about that?
This could potentially prevent such incidents from happening again.

Armin Wolf
