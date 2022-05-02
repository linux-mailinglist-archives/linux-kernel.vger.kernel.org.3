Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E21517826
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387403AbiEBUfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350516AbiEBUfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:35:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EB9AE53;
        Mon,  2 May 2022 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651523479;
        bh=XklK64zlUwZuEnTr5Rz+EiXQTXXwRojoscvTGaQkPJ8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XQ+uAwyGERKUngyZtQi62d8g5F9lhnZI0SoQ0xUzv8toiQBxsjLYOY+niHdbr+qtV
         Y3vbMPm8OX3DtxECaoocvNsFBo85P7VEykdnNM8TZZ2elqHaU98pTWAiBQzA68dkKf
         o393Z4KnmCSOPscAK9mJjnbAnFsfctIdNp6ZrreQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVN6j-1nNB2G0ha3-00SNt6; Mon, 02
 May 2022 22:31:19 +0200
Subject: Re: [PATCH 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
To:     LABBE Corentin <clabbe@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220502124249.682058-1-clabbe@baylibre.com>
 <20220502124249.682058-2-clabbe@baylibre.com>
 <0b154a30-7765-e3ac-9980-0ecc7447d7ad@roeck-us.net> <YnAqDxfTU27USQI+@Red>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <1b2bf215-faa1-649d-5ab4-85fc0b907ec2@gmx.de>
Date:   Mon, 2 May 2022 22:31:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YnAqDxfTU27USQI+@Red>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:M5uxf6WZcoVerfbPEAZEXF5O2+y/AzMfRsfNLeOoqO9A7Y9K8z2
 BlqUfqkvRX/hUWYAO5Dfl17zUZGKiHFyKwacDA9IVdgikTm0+LB57B5MFIWO7AScvjfiROg
 7FJKlQdKMxhML/1Uxs/7HIS1SXM11c3UwCMJV7Nk+uVkKs1lw8u2NgqSS05mXBaia2Un8RI
 EjLLURKa8YvirUfxhmNGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xFFzEfXvQII=:r67yR4TqmVHHinn9NzbmMU
 d0sMuGwMdQ7gF4D+ozNZuY2dWJzut4o75cg3EpkHZe0c0euD0Z+u8cCeiUaj5Beyx+NO6C2UJ
 XNdkJCUVAmSFRG6rPXTfLl8bMyl+WXSGl4crW+bKz9OAVE3tj30Y6+RDo8eZf6BQh8UM4xcre
 gTDwuaSk4G7UvIQj8fqYUprxV2aMLlQB4ZTpPIiMOtQ/ynoWg1J/shqyS4JDMmV031np+Qw4Y
 vW0baxnUrwLzlhmPMXtKdEwhVpaQroIXmAG+R55x3jqR+Jkg66OQPMU9JbWKe9KnmiX/rhtbL
 pUucz9ZHla2RWUrNrX2GT+yo3MhhbPM0vclSiZ1BwovbyF/VFSkV9pc9A2zWf55VQePSiywVy
 dQD9BTc70RchHQKZRsYZlx2tkPg7gJsjYngGNxO3nbb/8Sw81v0mMOsGZSgKPD3jmeEBoBWWR
 PAt60lHeQSaiifHWl8IZx0SjUIa7aRREITgUYrahCkjaBnPN9Kv+E5unrJ1lYxWzBNjv8AMsJ
 dk10y9Bd96YKhC5WWQUCEM/ntfG4KpvqeOaA8Csn0usHlJJKQtrVwVZ8//mfiqIRz5oGUkUc4
 ICzfEDnUW5hA1JeL4+5Y4GerznEYjEbYEGfL408xjw9TCfD+JIFdJKVC4Hqm4/VpCtHQCGLgp
 gIo5aaGWn2zVNSw86iPS2K/3y0Orp/G1ehk9HD8SYkhOillMZ6whrOQnHOWvffYpUJyV+bmQ3
 VnBwMCNw+rETVOAYH7c8rk49MolFpO0OEOndwUAFCWm2jhOBt8x8Lvjgbf4mm127PcH8UVCMJ
 erLScY28S8zQ4RqK45SIG7L39dQdi42GtLddzrXj2FgQp1pP1DEOYfZKyw1Jrn3eX8tKAxOhY
 dVChwwuDEzbs8/31Xk/wWq0LnUzo1WYwYymqf4L+pabvvb3PTDeSlCCn/MS7WtC2TUTN2/KZZ
 5QhT/5tzqUJU26wf2UcJQO///ZhzAbJein4tJzUtgOwvtHJzC0PozI/uBRMD3NBTuJH7K7gut
 66/jBG+dJFlN4LyGqiYBSL1ms9zd3melUcuksYJvL8rG+a7eQfZnzPR6zGz86qwYytaZcjF8M
 EnKn8+KGabAUdM=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.05.22 um 20:59 schrieb LABBE Corentin:

> Le Mon, May 02, 2022 at 06:34:44AM -0700, Guenter Roeck a =C3=A9crit :
>> On 5/2/22 05:42, Corentin Labbe wrote:
>>> Booting lead to a hwmon_device_register() is deprecated. Please conver=
t the driver to use hwmon_device_register_with_info().
>>> So let's convert the driver to use hwmon_device_register_with_info().
>>>
>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>> ---
>>>    drivers/hwmon/acpi_power_meter.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_pow=
er_meter.c
>>> index d2545a1be9fc..98293727f980 100644
>>> --- a/drivers/hwmon/acpi_power_meter.c
>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>> @@ -891,7 +891,10 @@ static int acpi_power_meter_add(struct acpi_devic=
e *device)
>>>    	if (res)
>>>    		goto exit_free_capability;
>>>
>>> -	resource->hwmon_dev =3D hwmon_device_register(&device->dev);
>>> +	resource->hwmon_dev =3D hwmon_device_register_with_info(&device->dev=
,
>>> +							      ACPI_POWER_METER_DEVICE_NAME,
>>> +							      NULL, NULL,
>>> +							      NULL);
>> NACK. That isn't a conversion to the new API, it just abuses the fact
>> that the new API has to accept a NULL info pointer for historic reasons=
.
>>
> Hello
>
> I am sorry, I found a driver doing it, so I believed it was okay.
> Converting seems not to hard but, by using the new API, how can I conver=
t power1_model_number/power1_is_battery attribute ?
> There are the remaining attributes I dont find how to convert.
>
> Regards

Hi,

for allowing the driver to provide nonstandard attributes, hwmon_device_re=
gister_with_info()
has the argument "extra_groups" which is an pointer to a list of sysfs att=
ribute groups.
There are some drivers which are using this functionality, maybe you can u=
se them as an
inspiration.

Just a question: what is the name of the driver you originally used as an =
inspiration?

Armin Wolf

