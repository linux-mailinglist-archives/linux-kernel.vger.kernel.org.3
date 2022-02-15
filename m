Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA44B77BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbiBOTqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:46:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbiBOTqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:46:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FFD46676;
        Tue, 15 Feb 2022 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644954335;
        bh=t7E1wBwBZ1L0pSaVu8ORZHH6TzOpG2QxjJQD1qRfkjs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OWKRGKqWpH3T9Qh7ApvbdjoprRAvqdaX7lNb6d9gUYOA+4LwExR/eEr+6+cKB7Ryl
         xlJZApM/KDFmH+V9k2kLhQEWyTwhQoLyuwbi/wTrvFJmfeWm8B1/t9aRuqCMWyyfwI
         quFalf0+DT18sGEFS8Rd7XE6mEpe7dRxlxiuThLc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1o8bBJ38aF-00v4j9; Tue, 15
 Feb 2022 20:45:34 +0100
Subject: Re: [PATCH 1/7] hwmon: (dell-smm) Allow for specifying fan control
 method as module parameter
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220215191113.16640-1-W_Armin@gmx.de>
 <20220215191113.16640-2-W_Armin@gmx.de>
 <20220215191941.azk5gpcn42ahcnna@pali>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <8309c55b-110c-5123-f7bc-8a82bdbf5086@gmx.de>
Date:   Tue, 15 Feb 2022 20:45:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220215191941.azk5gpcn42ahcnna@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:Zob9yYEJWaX3OKgk8E5VOH9wMrGqlEXGZVr7+FYrKmyTpdadB9d
 ahXakVJsuH7r4MkBCvJJ7BtneOYQzbYJ7ERAM8rNzTl01FdSCL6BX9GPLszal2/7hy4xpy7
 10Oa7aW/S18rh225eB2Gcg/zrtB5bMiC9VuO4PwdzWDWw0bUPdVwXdqycIM+IyOL8yyKEo6
 01Gsd5OelbW0SY4vQ6SvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VdLLrJWpFKE=:tavM/9lQlzu6esqpsFyWsf
 RXZy6LKaQrc8NkxjW1uACGEmTrOlOB8ktfHtoSO71YXEtLko+MnYGJd6p+2/5nBmfGBeuKgus
 piXLBcOp1O2VqD1vZn3ydSqFg+t8UeXT0V/xL+CIWgVDd3u8MAHIIZ0H0WpFNA/p6qUwGCXHL
 NgoU7XK9copm2Z6qd5XqYxa7WZqpkqqvM0+PyQizqJNAe7ePN0/g+OKO5xobQlKKkm/ZrTUHN
 C9PSwxUuSVzzPtjMnRgb7Wvii7bFm/95NCItcxZCDUBNj0JobtWDnUjeEI0lIRa9ngsMpHD88
 E/N2E9zQoPv7KcMd23zJoC7EccDS9aZCClnvXt0g7s+FNqutIxceObjWc81ejOelmaL75B7Dn
 nNBggfbnbwgnNA/WdlyAOpCWJytXdYXpHp8kWrFyf64m/U+aIDVvsQdBatbwx8AKNvLflHGGn
 BKDocyGw0GE/GBGTowZdlAC2hDZOTsk89yFK8YCtAFjEfQPB0Dsv27If9XVypLkZiE0NSaRCi
 iXa3BFSusIS2EBCqZpvAeUgTQpfzzOIS3hknrueMVZNnbyeeewNYKXbQiKoPZL/NTW92D4sxt
 lvpqYCo+jGKo4TmVMKGayahDAGAp7ndDLN9yGbgwUzA5ep8SvcK3RU9Z7cUPDNJCnDvR7C93X
 NtO505S9tL26rQEeM9rWtgit2qXoudLM1Ih5/v5ru5Y3ssLPKmiKyF2YElFvxEceUpGkKFe7R
 SytfqHb/kPGmTa6kPMYgH+ZfkNTh+vMGVFl1EszoR6yHN/rKlG7Dg5sex6S1022gbpzzoPCpB
 ruEW2DNwiYbe3fdPIb95KH2oGC/2iY5GWqIHI0w4s1iglyuY4VkpgO2YYGcgIYdFcVa3KUQlJ
 Fo44+2yVijx9yJ2w29n2gz5qGpiQwjurB9gv+QfaEU2FOxW+c98DFif1rMNVtP1y38UtJPFyK
 o9N7YukykQ864reuKUgkqZcUqR718wykayXTCCh4zpDeaar2LEAUNr14QaZ9lfrfs09Dhn/EE
 wsTBm+I+tbu7m7fDjHgx0VlfginTyEPxNWo6lI6SA56nCC3Q2fULXZS9++1pR1nYbbvdcF24g
 otU3hFMJOizG58=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 15.02.22 um 20:19 schrieb Pali Roh=C3=A1r:
> On Tuesday 15 February 2022 20:11:07 Armin Wolf wrote:
>> Right now, the only way to test if setting manual/auto fan control work=
s
>> is to edit and recompile the module, which may be too cumbersome for
>> the average user.
> There is also another way suitable for testing purposes which do not
> requires any kernel patch. Call iopl(3) syscall which changes I/O
> privilege level to 3 and which allows to poke I/O registers.
>
This is not possible under kernel lockdown/Secure Boot.

>> Allow for specifying the desired fan mode control method when loading
>> the module, but taint the kernel if so since there is the possibility
>> for strange side effects on non-whitelisted models.
>> Also update docs and kernel-parameters.txt accordingly.
>>
>> Tested on a Dell Inspiron 3505.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  3 +++
>>   Documentation/hwmon/dell-smm-hwmon.rst        | 21 ++++++++++------
>>   drivers/hwmon/dell-smm-hwmon.c                | 25 +++++++++++++-----=
-
>>   3 files changed, 35 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
>> index d68053db21cc..4f1b6c2b7ed1 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -968,6 +968,9 @@
>>   	dell_smm_hwmon.fan_max=3D
>>   			[HW] Maximum configurable fan speed.
>>
>> +	dell_smm_hwmon.fan_mode_method=3D
>> +			[HW] Method to use for changing fan mode.
>> +
>>   	dfltcc=3D		[HW,S390]
>>   			Format: { on | off | def_only | inf_only | always }
>>   			on:       s390 zlib hardware support for compression on
>> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwm=
on/dell-smm-hwmon.rst
>> index beec88491171..564d99cda869 100644
>> --- a/Documentation/hwmon/dell-smm-hwmon.rst
>> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
>> @@ -67,13 +67,16 @@ for your hardware. It is possible that codes that w=
ork for other
>>   laptops actually work for yours as well, or that you have to discover
>>   new codes.
>>
>> -Check the list ``i8k_whitelist_fan_control`` in file
>> -``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree: as a first
>> -attempt you can try to add your machine and use an already-known code
>> -pair. If, after recompiling the kernel, you see that ``pwm1_enable``
>> -is present and works (i.e., you can manually control the fan speed),
>> -then please submit your finding as a kernel patch, so that other users
>> -can benefit from it. Please see
>> +As a first step, you can load the module with the module parameter
>> +``fan_mode_method`` set to 1 to test if your hardware works with
>> +an already know method for disabling automatic BIOS fan control.
>> +If ``pwm1_enable`` is now present and works (i.e., you can
>> +manually control the fan speed), then please submit your finding
>> +as a kernel patch, so that other users can benefit from it.
>> +Just add your model to the list ``i8k_whitelist_fan_control`` in
>> +file ``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree and use
>> +the already known code pair.
>> +Please read
>>   :ref:`Documentation/process/submitting-patches.rst <submittingpatches=
>`
>>   for information on submitting patches.
>>
>> @@ -120,6 +123,10 @@ Module parameters
>>                      Maximum configurable fan speed. (default:
>>                      autodetect)
>>
>> +* fan_mode_method:uint
>> +                   Method to use for changing fan mode (default:
>> +                   from whitelist)
>> +
>>   Legacy ``/proc`` interface
>>   --------------------------
>>
>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hw=
mon.c
>> index 9949eeb79378..1c4cc516c8b2 100644
>> --- a/drivers/hwmon/dell-smm-hwmon.c
>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>> @@ -111,6 +111,10 @@ static uint fan_max;
>>   module_param(fan_max, uint, 0);
>>   MODULE_PARM_DESC(fan_max, "Maximum configurable fan speed (default: a=
utodetect)");
>>
>> +static uint fan_mode_method;
>> +module_param_unsafe(fan_mode_method, uint, 0);
>> +MODULE_PARM_DESC(fan_mode_method, "Method to use for changing fan mode=
 (default: from whitelist)");
> No, please really do not introduce another kernel parameter for this
> driver. There are already many and we do not need to extend this list.
>
>> +
>>   struct smm_regs {
>>   	unsigned int eax;
>>   	unsigned int ebx;
>> @@ -677,7 +681,7 @@ static umode_t dell_smm_is_visible(const void *drvd=
ata, enum hwmon_sensor_types
>>
>>   			break;
>>   		case hwmon_pwm_enable:
>> -			if (data->auto_fan)
>> +			if (data->auto_fan && data->manual_fan)
>>   				/*
>>   				 * There is no command for retrieve the current status
>>   				 * from BIOS, and userspace/firmware itself can change
>> @@ -1282,14 +1286,21 @@ static int __init dell_smm_probe(struct platfor=
m_device *pdev)
>>   	data->i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
>>   	data->i8k_pwm_mult =3D DIV_ROUND_UP(255, data->i8k_fan_max);
>>
>> -	fan_control =3D dmi_first_match(i8k_whitelist_fan_control);
>> -	if (fan_control && fan_control->driver_data) {
>> -		const struct i8k_fan_control_data *control =3D fan_control->driver_d=
ata;
>> +	/* value specified via module param overrides whitelist */
>> +	if (fan_mode_method > 0 && fan_mode_method <=3D ARRAY_SIZE(i8k_fan_co=
ntrol_data)) {
>> +		data->manual_fan =3D i8k_fan_control_data[fan_mode_method - 1].manua=
l_fan;
>> +		data->auto_fan =3D i8k_fan_control_data[fan_mode_method - 1].auto_fa=
n;
>> +	} else {
>> +		fan_control =3D dmi_first_match(i8k_whitelist_fan_control);
>> +		if (fan_control && fan_control->driver_data) {
>> +			const struct i8k_fan_control_data *control =3D fan_control->driver_=
data;
>>
>> -		data->manual_fan =3D control->manual_fan;
>> -		data->auto_fan =3D control->auto_fan;
>> -		dev_info(&pdev->dev, "enabling support for setting automatic/manual =
fan control\n");
>> +			data->manual_fan =3D control->manual_fan;
>> +			data->auto_fan =3D control->auto_fan;
>> +		}
>>   	}
>> +	if (data->manual_fan && data->auto_fan)
>> +		dev_info(&pdev->dev, "enabling support for setting automatic/manual =
fan control\n");
>>
>>   	if (!fan_mult) {
>>   		/*
>> --
>> 2.30.2
>>
