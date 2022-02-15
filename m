Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CF14B76B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244080AbiBOUTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:19:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiBOUTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:19:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D1EB15B;
        Tue, 15 Feb 2022 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644956358;
        bh=PiNVdwNEmCNAlW8NgWY6pxYxgjfrfE63FMf6CnZd0Zg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=glb0VUITiMgPox/N6KwPCPsj1+IN3F+x5vWj/w4wsqENnkQAq6zEyQAG/2RnG3jn1
         69R9F0MIKvonrR3vp7IoeGDjWb3cws8IbZlEZWjybeyNfLJOLz7Z94FGb3u/2muwBb
         C1ltrWC5fcHXN/8o3RGxf8fvK/2cioSIilGi2CpA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWih0-1nmmIo11lQ-00X6A4; Tue, 15
 Feb 2022 21:19:18 +0100
Subject: Re: [PATCH 1/7] hwmon: (dell-smm) Allow for specifying fan control
 method as module parameter
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220215191113.16640-1-W_Armin@gmx.de>
 <20220215191113.16640-2-W_Armin@gmx.de>
 <20220215191941.azk5gpcn42ahcnna@pali>
 <a450a2b6-92d3-d2cd-db63-b578480ff385@gmx.de>
 <20220215194909.py62gbsfwe2qxq2i@pali>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <6c9a1f7a-004e-1991-abef-181cc117907e@gmx.de>
Date:   Tue, 15 Feb 2022 21:19:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220215194909.py62gbsfwe2qxq2i@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:V57B0LZCmJoU7AJG3LUVYc+2Q6m7ZkcJre0laygIPB4foV0aiip
 vSiVJRG2NRf2QQMBdWRk5Hexn862geZ8f2n0bUJPh/rYPiObylwe5RwgahaymwAaDl1KjAM
 0YXZs5Wn0wRt+4hgeZ57d7iSrJqnXVnXeG41U3MlFjfoNowb+NkqUH5tRIawA+CkVWwjOND
 74bGyS+ITR4qQgEVJRURg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hTlirKhA/0g=:/Guy996lq8AY4XwK1lPS6C
 bWldHjw6N8jMHuXekhyfPXcrQmdilsmPurhvY47owIeeiuWSItBmfhqkP0sL8xkztSxeo4XpF
 pwKu7txwoynjo4ur8wbpNndwsAi3zYswg14iba7ZqJdIFWsnU+iu4h88Knoknvudyjt0zeep2
 9ostd/WqAYGUQzCcq0KbeXSm/nopL90zXr+eu98sYlIie/dtKoA3LRkRMAXAQUb2EuSgYVt3t
 yTN5/uYKY899uG179oUICKBcu7jSWsYmu0vNooNSsYrdWsAcomlzhccl6cmeNfvlmQlayYthB
 RyK4zGADJL7ywE6zlL0HT1FRdyrv/6aLx6ICJfaeq3m/v5VFQz2ku3ruXIWZRR/asUHov6im2
 XlHqyA9MhK2awviVvNpyQTy4baYqLbpKzsIQMKZaJ/pfGbZFvg8xSL4eXFkPdTmvAMyKrJKHi
 GpD31nrRnhXNzEoT4zhElcSLnWaVqUCtF3q5C3OP9jtOSBq/9IFhS2PXPGuzq4uY5ph5+Fvqj
 bRBCK7nHnD+zbUQMpA031QwhBo3vDPdek6CUXHSHTdpmgcMvui6HEXzIDXFLcc3qefaMEDhQ5
 A3UfgPz4TUBfLhEMNGnTkFLBOLj36vLK10iQ4Ws0gu0p/ZYXq5s3iZf5e1UvKQE+Da28o4zh5
 EXSnM/GsHPAR7j9gBxQCy1wy5WGhnB817zD6uUyY9vLQXfV2pOeDEJlRz5c3o9N1yiNpQEJFc
 hNHzaFix9cllmwV7JVXHgGAkbJ80XOlCI//upaefo02/jgE+0mX90+p6X4nM/TOhRAjyfn02i
 ViMjOuGmEgAL4enEVgbYHAiu4BpJLuAh4nMjL6HIEKaec7RrAJP0egNTa7BxoG2Y43LQC1TgO
 SxCVXIbpqqzfQiPT8Ct+hYb8CmC147JfbdzJFU1oM/eLOJ03LGpYovRsQkmF/nAl+0KFNYSiK
 c0MnePQj0fUgDqcgJ8jHZutuBvNXIWr8ISmJi6vDQbC4y/8p9fOAHkmyA3D6JmWcAtiaZotmj
 D4j18DoHQc2VTlwDqDBexhdwI+/j7hbfK8Ilry5lHgtxTWY5+zBZJdZHGvf0K8/TsNI83fySp
 cq9QQw7Uoummfc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 15.02.22 um 20:49 schrieb Pali Roh=C3=A1r:
> On Tuesday 15 February 2022 20:44:20 Armin Wolf wrote:
>> Am 15.02.22 um 20:19 schrieb Pali Roh=C3=A1r:
>>> On Tuesday 15 February 2022 20:11:07 Armin Wolf wrote:
>>>> Right now, the only way to test if setting manual/auto fan control wo=
rks
>>>> is to edit and recompile the module, which may be too cumbersome for
>>>> the average user.
>>> There is also another way suitable for testing purposes which do not
>>> requires any kernel patch. Call iopl(3) syscall which changes I/O
>>> privilege level to 3 and which allows to poke I/O registers.
>>>
>> This is not possible under kernel lockdown/Secure Boot.
> Under Secure Boot it should be still possible.

Afaik, access to iopl() and ioperm() is blocked in this mode too.
This for example causes dell-bios-fan-control to fail when
the machine is booted in Secure Boot mode.

> With kernel lockdown, no kernel testing/debugging at HW level is
> acceptable due to security reasons, as it is against what kernel
> lockdown should achieve.
>
That is the reason i limited the number of selectable code pairs to
two which are known to work on a wide range of machines.
So users are unable to specify SMM commands, which are controlled by
the driver. If this still is to much, then we may drop this patch.

>>>> Allow for specifying the desired fan mode control method when loading
>>>> the module, but taint the kernel if so since there is the possibility
>>>> for strange side effects on non-whitelisted models.
>>>> Also update docs and kernel-parameters.txt accordingly.
>>>>
>>>> Tested on a Dell Inspiron 3505.
>>>>
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>> ---
>>>>    .../admin-guide/kernel-parameters.txt         |  3 +++
>>>>    Documentation/hwmon/dell-smm-hwmon.rst        | 21 ++++++++++-----=
-
>>>>    drivers/hwmon/dell-smm-hwmon.c                | 25 +++++++++++++--=
----
>>>>    3 files changed, 35 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docume=
ntation/admin-guide/kernel-parameters.txt
>>>> index d68053db21cc..4f1b6c2b7ed1 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -968,6 +968,9 @@
>>>>    	dell_smm_hwmon.fan_max=3D
>>>>    			[HW] Maximum configurable fan speed.
>>>>
>>>> +	dell_smm_hwmon.fan_mode_method=3D
>>>> +			[HW] Method to use for changing fan mode.
>>>> +
>>>>    	dfltcc=3D		[HW,S390]
>>>>    			Format: { on | off | def_only | inf_only | always }
>>>>    			on:       s390 zlib hardware support for compression on
>>>> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/h=
wmon/dell-smm-hwmon.rst
>>>> index beec88491171..564d99cda869 100644
>>>> --- a/Documentation/hwmon/dell-smm-hwmon.rst
>>>> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
>>>> @@ -67,13 +67,16 @@ for your hardware. It is possible that codes that=
 work for other
>>>>    laptops actually work for yours as well, or that you have to disco=
ver
>>>>    new codes.
>>>>
>>>> -Check the list ``i8k_whitelist_fan_control`` in file
>>>> -``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree: as a first
>>>> -attempt you can try to add your machine and use an already-known cod=
e
>>>> -pair. If, after recompiling the kernel, you see that ``pwm1_enable``
>>>> -is present and works (i.e., you can manually control the fan speed),
>>>> -then please submit your finding as a kernel patch, so that other use=
rs
>>>> -can benefit from it. Please see
>>>> +As a first step, you can load the module with the module parameter
>>>> +``fan_mode_method`` set to 1 to test if your hardware works with
>>>> +an already know method for disabling automatic BIOS fan control.
>>>> +If ``pwm1_enable`` is now present and works (i.e., you can
>>>> +manually control the fan speed), then please submit your finding
>>>> +as a kernel patch, so that other users can benefit from it.
>>>> +Just add your model to the list ``i8k_whitelist_fan_control`` in
>>>> +file ``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree and use
>>>> +the already known code pair.
>>>> +Please read
>>>>    :ref:`Documentation/process/submitting-patches.rst <submittingpatc=
hes>`
>>>>    for information on submitting patches.
>>>>
>>>> @@ -120,6 +123,10 @@ Module parameters
>>>>                       Maximum configurable fan speed. (default:
>>>>                       autodetect)
>>>>
>>>> +* fan_mode_method:uint
>>>> +                   Method to use for changing fan mode (default:
>>>> +                   from whitelist)
>>>> +
>>>>    Legacy ``/proc`` interface
>>>>    --------------------------
>>>>
>>>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-=
hwmon.c
>>>> index 9949eeb79378..1c4cc516c8b2 100644
>>>> --- a/drivers/hwmon/dell-smm-hwmon.c
>>>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>>>> @@ -111,6 +111,10 @@ static uint fan_max;
>>>>    module_param(fan_max, uint, 0);
>>>>    MODULE_PARM_DESC(fan_max, "Maximum configurable fan speed (default=
: autodetect)");
>>>>
>>>> +static uint fan_mode_method;
>>>> +module_param_unsafe(fan_mode_method, uint, 0);
>>>> +MODULE_PARM_DESC(fan_mode_method, "Method to use for changing fan mo=
de (default: from whitelist)");
>>> No, please really do not introduce another kernel parameter for this
>>> driver. There are already many and we do not need to extend this list.

Since there are two code pairs, i could not reuse the force param for that=
.
Since the newly added pair is unused, should i remove it and reuse the
force param?

>>>> +
>>>>    struct smm_regs {
>>>>    	unsigned int eax;
>>>>    	unsigned int ebx;
>>>> @@ -677,7 +681,7 @@ static umode_t dell_smm_is_visible(const void *dr=
vdata, enum hwmon_sensor_types
>>>>
>>>>    			break;
>>>>    		case hwmon_pwm_enable:
>>>> -			if (data->auto_fan)
>>>> +			if (data->auto_fan && data->manual_fan)
>>>>    				/*
>>>>    				 * There is no command for retrieve the current status
>>>>    				 * from BIOS, and userspace/firmware itself can change
>>>> @@ -1282,14 +1286,21 @@ static int __init dell_smm_probe(struct platf=
orm_device *pdev)
>>>>    	data->i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 =
*/
>>>>    	data->i8k_pwm_mult =3D DIV_ROUND_UP(255, data->i8k_fan_max);
>>>>
>>>> -	fan_control =3D dmi_first_match(i8k_whitelist_fan_control);
>>>> -	if (fan_control && fan_control->driver_data) {
>>>> -		const struct i8k_fan_control_data *control =3D fan_control->driver=
_data;
>>>> +	/* value specified via module param overrides whitelist */
>>>> +	if (fan_mode_method > 0 && fan_mode_method <=3D ARRAY_SIZE(i8k_fan_=
control_data)) {
>>>> +		data->manual_fan =3D i8k_fan_control_data[fan_mode_method - 1].man=
ual_fan;
>>>> +		data->auto_fan =3D i8k_fan_control_data[fan_mode_method - 1].auto_=
fan;
>>>> +	} else {
>>>> +		fan_control =3D dmi_first_match(i8k_whitelist_fan_control);
>>>> +		if (fan_control && fan_control->driver_data) {
>>>> +			const struct i8k_fan_control_data *control =3D fan_control->drive=
r_data;
>>>>
>>>> -		data->manual_fan =3D control->manual_fan;
>>>> -		data->auto_fan =3D control->auto_fan;
>>>> -		dev_info(&pdev->dev, "enabling support for setting automatic/manua=
l fan control\n");
>>>> +			data->manual_fan =3D control->manual_fan;
>>>> +			data->auto_fan =3D control->auto_fan;
>>>> +		}
>>>>    	}
>>>> +	if (data->manual_fan && data->auto_fan)
>>>> +		dev_info(&pdev->dev, "enabling support for setting automatic/manua=
l fan control\n");
>>>>
>>>>    	if (!fan_mult) {
>>>>    		/*
>>>> --
>>>> 2.30.2
>>>>
