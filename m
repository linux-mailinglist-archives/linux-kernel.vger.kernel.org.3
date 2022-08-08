Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3477B58C716
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242414AbiHHLCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242137AbiHHLCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:02:16 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B2913D23
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659956525; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XydORn22ib0yibyOs7vrLltEam/bWaIMu8HK47joC6A=;
        b=PP8cVzp+jFUOosVyI8pmg8ckcwyvodHX5n8/w1g+s2T56AgW53ETLx65stWEj4O/fEIJIk
        zxWgvq3D8qcdmxcXPX5H76CH4NOeTEkj0QuVQcjDZKjLSU2mWysfcbdQ5JfJBlPNhKCqIj
        9TpjOkMFxkJbUjM4RgkblpOiJLXZNA8=
Date:   Mon, 08 Aug 2022 13:01:58 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 20/28] mfd: arizona: Remove #ifdef guards for PM related
 functions
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Message-Id: <ANMAGR.U803VAFDNZVL@crapouillou.net>
In-Reply-To: <2c5c063b-da58-1f6f-5422-1ada3dabb90a@opensource.cirrus.com>
References: <20220807145247.46107-1-paul@crapouillou.net>
        <20220807145247.46107-21-paul@crapouillou.net>
        <94394206-a018-27b0-5a21-97976fc4a3bc@opensource.cirrus.com>
        <T2KAGR.KY35O6CZFRQ83@crapouillou.net>
        <2c5c063b-da58-1f6f-5422-1ada3dabb90a@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun., ao=FBt 8 2022 at 11:43:31 +0100, Richard Fitzgerald=20
<rf@opensource.cirrus.com> a =E9crit :
> On 08/08/2022 11:06, Paul Cercueil wrote:
>> Hi Richard,
>>=20
>> Le lun., ao=FBt 8 2022 at 10:53:54 +0100, Richard Fitzgerald=20
>> =7F<rf@opensource.cirrus.com> a =E9crit :
>>> On 07/08/2022 15:52, Paul Cercueil wrote:
>>>> Only export the arizona_pm_ops if CONFIG_PM is set, but leave the
>>>> suspend/resume functions (and related code) outside #ifdef guards.
>>>>=20
>>>> If CONFIG_PM is not set, the arizona_pm_ops will be defined as
>>>> "static __maybe_unused", and the structure plus all the callbacks=20
>>>> will
>>>> be automatically dropped by the compiler.
>>>>=20
>>>> The advantage is then that these functions are now always compiled
>>>> independently of any Kconfig option, and thanks to that bugs and
>>>> regressions are easier to catch.
>>>>=20
>>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>> Cc: patches@opensource.cirrus.com
>>>> ---
>>>>   drivers/mfd/arizona-core.c | 21 +++++++++++----------
>>>>   drivers/mfd/arizona-i2c.c  |  2 +-
>>>>   drivers/mfd/arizona-spi.c  |  2 +-
>>>>   3 files changed, 13 insertions(+), 12 deletions(-)
>>>>=20
>>>> diff --git a/drivers/mfd/arizona-core.c=20
>>>> b/drivers/mfd/arizona-core.c
>>>> index cbf1dd90b70d..c1acc9521f83 100644
>>>> --- a/drivers/mfd/arizona-core.c
>>>> +++ b/drivers/mfd/arizona-core.c
>>>> @@ -480,7 +480,6 @@ static int wm5102_clear_write_sequencer(struct=20
>>>> =7F=7F=7Farizona *arizona)
>>>>       return 0;
>>>>   }
>>>>   =7F-#ifdef CONFIG_PM
>>>>   static int arizona_isolate_dcvdd(struct arizona *arizona)
>>>=20
>>> __maybe_unused?
>>=20
>> No need. The symbols are always referenced.
>>=20
>>>>   {
>>>>       int ret;
>>>> @@ -742,9 +741,7 @@ static int arizona_runtime_suspend(struct=20
>>>> device =7F=7F=7F*dev)
>>>=20
>>> __maybe_unused?
>>>=20
>>>>   =7F      return 0;
>>>>   }
>>>> -#endif
>>>>   =7F-#ifdef CONFIG_PM_SLEEP
>>>>   static int arizona_suspend(struct device *dev)
>>>=20
>>> __maybe_unused?
>>>=20
>>>>   {
>>>>       struct arizona *arizona =3D dev_get_drvdata(dev);
>>>> @@ -784,17 +781,21 @@ static int arizona_resume(struct device *dev)
>>>=20
>>> __maybe_unused?
>>>=20
>>>>   =7F      return 0;
>>>>   }
>>>> -#endif
>>>>   =7F+#ifndef CONFIG_PM
>>>> +static __maybe_unused
>>>> +#endif
>>>=20
>>> No need to ifdef a __maybe_unused.
>>=20
>> Yes, it is needed, because the symbol is conditionally exported. If
>=20
> Why conditionally export it?
>=20
>> !CONFIG_PM, we want the compiler to discard the dev_pm_ops
>  and all the
>> callbacks, hence the "static __maybe_unused". That's the same trick=20
>> used > in _EXPORT_DEV_PM_OPS().
>>=20
>> (note that this patch is broken as it does not change the struct=20
>> name, =7Fin the !PM case, which causes conflicts with the .h. I'll fix=20
>> in v2)
>>=20
>>>>   const struct dev_pm_ops arizona_pm_ops =3D {
>>>> -    SET_RUNTIME_PM_OPS(arizona_runtime_suspend,
>>>> -               arizona_runtime_resume,
>>>> -               NULL)
>>>> -    SET_SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_resume)
>>>> -    SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(arizona_suspend_noirq,
>>>> -                      arizona_resume_noirq)
>>>> +    RUNTIME_PM_OPS(arizona_runtime_suspend,
>>>> +               arizona_runtime_resume,
>>>> +               NULL)
>>>> +    SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_resume)
>>>> +    NOIRQ_SYSTEM_SLEEP_PM_OPS(arizona_suspend_noirq,
>>>> +                  arizona_resume_noirq)
>>>>   };
>>>> +#ifdef CONFIG_PM
>>>>   EXPORT_SYMBOL_GPL(arizona_pm_ops);
>>>> +#endif
>>>=20
>>> This ifdeffing is ugly. Why must the structure only be exported if
>>> CONFIG_PM is set?
>>=20
>> So that all the PM code is garbage-collected by the compiler if=20
>> !CONFIG_PM.
>=20
> The functions will be dropped if they are not referenced. That doesn't
> answer why the struct must not be exported.
>=20
> What is the aim of omitting the struct export?

The functions are always referenced by the dev_pm_ops structure.=20
Omitting the struct export means that the struct can now be a "static=20
__maybe_unused" symbol in the !CONFIG_PM case, and everything related=20
to PM will be automatically removed by the compiler.

Otherwise, the symbol is exported as usual. The symbol being=20
conditionally exported is not a problem - the struct is always=20
referenced (as it should be) using the pm_sleep_ptr() or pm_ptr()=20
macros.

This is basically what EXPORT_SIMPLE_DEV_PM_OPS() does by the way.

Cheers,
-Paul

>>=20
>> Ideally I would use something like EXPORT_SIMPLE_DEV_PM_OPS() which=20
>> =7Fwould make the patch much cleaner, but it doesn't support noirq=20
>> =7Fcallbacks - and that's why I suggested in the cover letter that=20
>> maybe a =7Fnew PM macro can be added if this patch is deemed too messy.
>>=20
>> Cheers,
>> -Paul
>>=20
>>>>   =7F  #ifdef CONFIG_OF
>>>>   static int arizona_of_get_core_pdata(struct arizona *arizona)
>>>> diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
>>>> index 6d83e6b9a692..8799d9183bee 100644
>>>> --- a/drivers/mfd/arizona-i2c.c
>>>> +++ b/drivers/mfd/arizona-i2c.c
>>>> @@ -119,7 +119,7 @@ static const struct of_device_id=20
>>>> =7F=7F=7Farizona_i2c_of_match[] =3D {
>>>>   static struct i2c_driver arizona_i2c_driver =3D {
>>>>       .driver =3D {
>>>>           .name    =3D "arizona",
>>>> -        .pm    =3D &arizona_pm_ops,
>>>> +        .pm    =3D pm_ptr(&arizona_pm_ops),
>>>>           .of_match_table    =3D of_match_ptr(arizona_i2c_of_match),
>>>>       },
>>>>       .probe        =3D arizona_i2c_probe,
>>>> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
>>>> index 941b0267d09d..da05b966d48c 100644
>>>> --- a/drivers/mfd/arizona-spi.c
>>>> +++ b/drivers/mfd/arizona-spi.c
>>>> @@ -282,7 +282,7 @@ static const struct of_device_id=20
>>>> =7F=7F=7Farizona_spi_of_match[] =3D {
>>>>   static struct spi_driver arizona_spi_driver =3D {
>>>>       .driver =3D {
>>>>           .name    =3D "arizona",
>>>> -        .pm    =3D &arizona_pm_ops,
>>>> +        .pm    =3D pm_ptr(&arizona_pm_ops),
>>>>           .of_match_table    =3D of_match_ptr(arizona_spi_of_match),
>>>>           .acpi_match_table =3D ACPI_PTR(arizona_acpi_match),
>>>>       },
>>=20
>>=20


