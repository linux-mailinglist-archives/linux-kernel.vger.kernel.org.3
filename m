Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900C258C610
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242354AbiHHKGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242258AbiHHKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:06:41 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067B611808
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659953197; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AwLi/sxUWbQ2u8h1M+uWOgbjCN8M4cM8EmRaHGzr1aw=;
        b=4Fj2elb/irp4DtXDZKVbLFKAf9tQJvWN3VXmNprQjjbK/g3eN9EJe4IUnjuyE0Zhe1clzo
        UN0GK6wWjGgU7iOBLZajrjE0fHd2bcKwYug3FrVM5/y0LTFR3puyJK+MSke5gTdIKF1l6k
        VpgKaH3SIhFVGgujlP+kz33S17JaxI0=
Date:   Mon, 08 Aug 2022 12:06:29 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 20/28] mfd: arizona: Remove #ifdef guards for PM related
 functions
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Message-Id: <T2KAGR.KY35O6CZFRQ83@crapouillou.net>
In-Reply-To: <94394206-a018-27b0-5a21-97976fc4a3bc@opensource.cirrus.com>
References: <20220807145247.46107-1-paul@crapouillou.net>
        <20220807145247.46107-21-paul@crapouillou.net>
        <94394206-a018-27b0-5a21-97976fc4a3bc@opensource.cirrus.com>
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

Hi Richard,

Le lun., ao=FBt 8 2022 at 10:53:54 +0100, Richard Fitzgerald=20
<rf@opensource.cirrus.com> a =E9crit :
> On 07/08/2022 15:52, Paul Cercueil wrote:
>> Only export the arizona_pm_ops if CONFIG_PM is set, but leave the
>> suspend/resume functions (and related code) outside #ifdef guards.
>>=20
>> If CONFIG_PM is not set, the arizona_pm_ops will be defined as
>> "static __maybe_unused", and the structure plus all the callbacks=20
>> will
>> be automatically dropped by the compiler.
>>=20
>> The advantage is then that these functions are now always compiled
>> independently of any Kconfig option, and thanks to that bugs and
>> regressions are easier to catch.
>>=20
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> Cc: patches@opensource.cirrus.com
>> ---
>>   drivers/mfd/arizona-core.c | 21 +++++++++++----------
>>   drivers/mfd/arizona-i2c.c  |  2 +-
>>   drivers/mfd/arizona-spi.c  |  2 +-
>>   3 files changed, 13 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
>> index cbf1dd90b70d..c1acc9521f83 100644
>> --- a/drivers/mfd/arizona-core.c
>> +++ b/drivers/mfd/arizona-core.c
>> @@ -480,7 +480,6 @@ static int wm5102_clear_write_sequencer(struct=20
>> arizona *arizona)
>>   	return 0;
>>   }
>>   =7F-#ifdef CONFIG_PM
>>   static int arizona_isolate_dcvdd(struct arizona *arizona)
>=20
> __maybe_unused?

No need. The symbols are always referenced.

>>   {
>>   	int ret;
>> @@ -742,9 +741,7 @@ static int arizona_runtime_suspend(struct device=20
>> *dev)
>=20
> __maybe_unused?
>=20
>>   =7F  	return 0;
>>   }
>> -#endif
>>   =7F-#ifdef CONFIG_PM_SLEEP
>>   static int arizona_suspend(struct device *dev)
>=20
> __maybe_unused?
>=20
>>   {
>>   	struct arizona *arizona =3D dev_get_drvdata(dev);
>> @@ -784,17 +781,21 @@ static int arizona_resume(struct device *dev)
>=20
> __maybe_unused?
>=20
>>   =7F  	return 0;
>>   }
>> -#endif
>>   =7F+#ifndef CONFIG_PM
>> +static __maybe_unused
>> +#endif
>=20
> No need to ifdef a __maybe_unused.

Yes, it is needed, because the symbol is conditionally exported. If=20
!CONFIG_PM, we want the compiler to discard the dev_pm_ops and all the=20
callbacks, hence the "static __maybe_unused". That's the same trick=20
used in _EXPORT_DEV_PM_OPS().

(note that this patch is broken as it does not change the struct name,=20
in the !PM case, which causes conflicts with the .h. I'll fix in v2)

>>   const struct dev_pm_ops arizona_pm_ops =3D {
>> -	SET_RUNTIME_PM_OPS(arizona_runtime_suspend,
>> -			   arizona_runtime_resume,
>> -			   NULL)
>> -	SET_SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_resume)
>> -	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(arizona_suspend_noirq,
>> -				      arizona_resume_noirq)
>> +	RUNTIME_PM_OPS(arizona_runtime_suspend,
>> +		       arizona_runtime_resume,
>> +		       NULL)
>> +	SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_resume)
>> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(arizona_suspend_noirq,
>> +				  arizona_resume_noirq)
>>   };
>> +#ifdef CONFIG_PM
>>   EXPORT_SYMBOL_GPL(arizona_pm_ops);
>> +#endif
>=20
> This ifdeffing is ugly. Why must the structure only be exported if
> CONFIG_PM is set?

So that all the PM code is garbage-collected by the compiler if=20
!CONFIG_PM.

Ideally I would use something like EXPORT_SIMPLE_DEV_PM_OPS() which=20
would make the patch much cleaner, but it doesn't support noirq=20
callbacks - and that's why I suggested in the cover letter that maybe a=20
new PM macro can be added if this patch is deemed too messy.

Cheers,
-Paul

>>   =7F  #ifdef CONFIG_OF
>>   static int arizona_of_get_core_pdata(struct arizona *arizona)
>> diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
>> index 6d83e6b9a692..8799d9183bee 100644
>> --- a/drivers/mfd/arizona-i2c.c
>> +++ b/drivers/mfd/arizona-i2c.c
>> @@ -119,7 +119,7 @@ static const struct of_device_id=20
>> arizona_i2c_of_match[] =3D {
>>   static struct i2c_driver arizona_i2c_driver =3D {
>>   	.driver =3D {
>>   		.name	=3D "arizona",
>> -		.pm	=3D &arizona_pm_ops,
>> +		.pm	=3D pm_ptr(&arizona_pm_ops),
>>   		.of_match_table	=3D of_match_ptr(arizona_i2c_of_match),
>>   	},
>>   	.probe		=3D arizona_i2c_probe,
>> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
>> index 941b0267d09d..da05b966d48c 100644
>> --- a/drivers/mfd/arizona-spi.c
>> +++ b/drivers/mfd/arizona-spi.c
>> @@ -282,7 +282,7 @@ static const struct of_device_id=20
>> arizona_spi_of_match[] =3D {
>>   static struct spi_driver arizona_spi_driver =3D {
>>   	.driver =3D {
>>   		.name	=3D "arizona",
>> -		.pm	=3D &arizona_pm_ops,
>> +		.pm	=3D pm_ptr(&arizona_pm_ops),
>>   		.of_match_table	=3D of_match_ptr(arizona_spi_of_match),
>>   		.acpi_match_table =3D ACPI_PTR(arizona_acpi_match),
>>   	},


