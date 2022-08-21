Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D585959B618
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 21:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiHUTLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 15:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiHUTLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 15:11:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E86C1B7AE;
        Sun, 21 Aug 2022 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661109085;
        bh=xXlJFzE/RmrPZcunWw32jAe55Yko3tEOJOCDepAu6zY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=K7VktiH7PTnbFQznNi4rXe0FqZWDvQcOuX/7VMezvHmQroLbpJgpH3rxeEugkVF0v
         224P3vpqLMG4XtoOPFd0cgdSmJcwNakvNnDulhkeXI32MGFV1B3FkdI+pGGCRzHawM
         Bh5+B8GdJtF6N0ajdDynbloqSw+1iHIPJ8XLatpE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.21] ([141.30.226.119]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1p9wkX25do-00kQ7D; Sun, 21
 Aug 2022 21:11:25 +0200
Subject: Re: [PATCH 1/3] hwmon: (dell-smm) Fail probing when cooling device
 registration fails
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220821151713.11198-1-W_Armin@gmx.de>
 <20220821151713.11198-2-W_Armin@gmx.de>
 <20220821154145.v7da76besv2qzqhj@pali>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <ea06f15d-cb22-1d5d-9437-59d595e24e43@gmx.de>
Date:   Sun, 21 Aug 2022 21:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220821154145.v7da76besv2qzqhj@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:kre3G2oBS9gCz9PF7rhKOEbMD4ubfZgE5R36d9SIbsk2jwAhVzF
 gLSShiiM6eIetS3CVSUoI+tsNlhcYYmAauD0gx4fPLhlZs50CbnfpaSDM899YS0bebkRPGe
 1uYgoaW2jiDFxwo3zdqpO7j+9ZiSyNABYBP2NKHSwlaVUoNtHoKXOr4O/wCxweMHDvdV9gN
 dcbAC6q0Vl1j1dcbD0neA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mw5h3K2QREQ=:GG737428vBK/FwPwKqcI3J
 x97t6CPRY8TRE/yFUmItZipSFFQxvRORxiKERQCWSKLVrqd/YZiUtKeQTa6OTQ5SE2SX0t+Gj
 bgTD4IW8hVbW5WThzwCeyNrDFnCeuioUtdN0mevddI6fnCyHIrG+hJqvFiH6DsrhACv5cVYaE
 btyMNb7edmSRC8IxD2q3rsoa5Uu/tRe2hgQEIKcuQ5Da+6unJU67kbm8tKRzkgTD2Ge1SJAGm
 inoNteatw3ajMN32CMrFAazMlZc6xcRWNmxHHG/FZLHytO4tAzDePBZDwV7iQQjvDmq5+8Afo
 vvpp1N2XklIyXYnACmEMTPpQ7n3QOUpvr+yvtx5LajqUaLoiCbOMI+pQBv5KWYCowouSTX0An
 vweTKNRoeEmckcMWae5XEJ/94dgaYtF8nbk0r4u8KKEBcGLIOWf85EiDfWh3hSa5eSyD7a3fC
 Mw/lquTbb7C4w8V/dFnmoEbuUemkwiPs2NAcbuI+747SPNh4iG39ha0zvzqFOparP+yFIAO4N
 huEW8RFaRzYMSHxLSvPgTvoCgMWGGrq57Yp8UJAWT7Fm+l/3mfg7B3t9m5SVNg+U1LdvJDYgU
 Xuil2X/qUeWCqJjlifZ3BC6CjXfGS0Stb+edeZ/lQrOyNyhMvlnUWSgumrvcRhwIvIdc7UcQH
 RFgMaZ+Y6LSx4AjtGVUafY6cx6dXofDX8eFLHRwNJjlhmKtCaD7sDhO5nVUaP06eIzR/OYU5s
 8D1Dj2BHoTmDqXpptGSziw4ztXGrUbofC3wmhYkC7TfOkG0LvMPm70OdPxVk4y1P8Ydg5RWpr
 Dz+0m9uG2op2k4qyZEA7QqM+YUiAPM1U77/ucJ778W63xL4pNoAM3pCwfoD9eMvDf2sCtQMzV
 O6myyAeW5tLpKmwvsmC+2n4t3UqThwksEvN9lqFGKKmpX39RTH8s1IS/O+7/PBpwSPkHk8hp2
 p7r29cy3+0NzhE8WFZaVfjMvaVmia4wCTZbwAw3aonL/dF9jVXjzvRINWtf9ZNC6zzV3JFGvl
 ZbBEJKCGU12uljNhOlAOBgMFp/Qe/Elgq0RBG1r6jJiZ8CRH/aAO1T6B6HnHdD8rU04xLfypF
 8Mm0rVOS6KwflBU4ToOc1P8R808BORnh1NkWEbhWAhKSs9eEe9y+dk4pg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.08.22 um 17:41 schrieb Pali Roh=C3=A1r:

> On Sunday 21 August 2022 17:17:11 Armin Wolf wrote:
>> Previously, it was thought that failing to register a cooling device
>> would not be critical, so the probing was not aborted in such a case.
>> This however would lead to userspace being unable to rely on those
>> cooling devices, since they might not represent all fans being present.
>> Fix that by failing probing when cooling device registration fails.
> This patch does not fix address this issue fully. CONFIG_THERMAL can be
> disabled during compile time and then cooling device would not be
> registered too.

I though of the cooling device feature as being optional "as a whole".
So when CONFIG_THERMAL is disabled during compile time, the driver does
not create any cooling devices. If however CONFIG_THERMAL was enabled
during compile time, the driver should fail probing if it cannot register
all cooling devices.

Armin Wolf

>> Tested on a Dell Inspiron 3505.
>>
>> Fixes: e0d3f7cb2606 ("hwmon: (dell-smm) Add cooling device support")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/hwmon/dell-smm-hwmon.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hw=
mon.c
>> index 7f8d95dd2717..1dab7591576a 100644
>> --- a/drivers/hwmon/dell-smm-hwmon.c
>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>> @@ -1013,12 +1013,10 @@ static int __init dell_smm_init_hwmon(struct de=
vice *dev)
>>
>>   		data->fan[i] =3D true;
>>
>> -		/* the cooling device is not critical, ignore failures */
>>   		if (IS_REACHABLE(CONFIG_THERMAL)) {
>>   			err =3D dell_smm_init_cdev(dev, i);
>>   			if (err < 0)
>> -				dev_warn(dev, "Failed to register cooling device for fan %u\n",
>> -					 i + 1);
>> +				return err;
>>   		}
>>
>>   		data->fan_nominal_speed[i] =3D devm_kmalloc_array(dev, data->i8k_fa=
n_max + 1,
>> --
>> 2.30.2
>>
