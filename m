Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A694622B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhK2VDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:03:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:55815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhK2VBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638219461;
        bh=DNtADlqCD16a0p6leRSeTgFd5ERa28Gj8N49dVh2+pg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YQ81nweFNdzUZYSaFn1hWZQq0zH3r9P6bR1QvsNtmJMPNsKflJELhWKDytM+LliwJ
         FW8vLu5SGv3nvahoaJLLSAuhnawlj3jmr/S24TtVnHzFu4lEQeaIZVx7YQgVkaIWag
         StV04iT+TicCnKHrp4KOAYn0tcculpszqJj9RgCI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.29] ([91.137.126.34]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1mEHyv3CAi-00mdX7; Mon, 29
 Nov 2021 21:57:41 +0100
Subject: Re: [PATCH 1/2] hwmon: (dell-smm) Simplify ioctl handler
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211120170319.72369-1-W_Armin@gmx.de>
 <20211120170319.72369-2-W_Armin@gmx.de>
 <20211123161332.discv3bfx4rkowah@pali>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <5024959a-772a-ebde-089d-0668e1e188f7@gmx.de>
Date:   Mon, 29 Nov 2021 21:57:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211123161332.discv3bfx4rkowah@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:t4sNQTDSNMewwWOSx+cI2e1mkeNskLRcioK8L/S4emE+Bty8THA
 vJzDjGrPxyr9ISIKc/mwbSVAgjhSZ7WjJA8R/ce6YczPjWpAdl1JIT6nwXV8KAipbmTk3Rd
 nhwu5QM5PN/LnDUWKvhGwv19hFd3uLozIy+3d91Ibg/1xRfYUqGzQvdlGhrWOMt84R6TQkE
 jA/uAhZu1M6ljht0kgL9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u5DZRe+gL4o=:I9068Yw+qcpz3A9OOhXab0
 nu1NKe24BjQQ8r70SoRbS7Ug2+AgnSA4zOz1KngP2js2IbkNcYKMVS4bmP1ozmixcBXbMx1KM
 oOjP9LB1VsO0hdJowRRVoAS1BtSHumfNe6DKprAlO1VG1osAAV+MqmxUvpQzWnW+a36IvLhZV
 Z8lveNnVD3FkXpOJMaP0zUlLOX9QJcoASdHOh2vbcAMa/5T9782/fnkL8/LzebxMxDnet3BM0
 RMUmAF72ZWmXaR1Px8OLeQwsZnyaRtA4PUaB+5XZyp7dttf6qGdpQP5zTTmjYEEs/54rQ54Ns
 hEQi5CW2wsnbAEP7eY2xzWYR79EgsMWLb6P1uo67fuQaCNdRGklooZvIW4k8sZDpuinlyMBdD
 FOxnN3yJay0r9jqrmudRBRnenaEbXgUnI8I0xZVoxSet8AwWhl/yl4qn/pLd5BQHS04AEntxj
 pWCcpq/avQSJDAdAZGwHbj/XKdsY2U40QY7Kvty9KcbFwusZeCa73HX692YOxced6qJIHRh5g
 9VcV9Fj1gxMUf12TTsdP3pGBlird/4hiXTghJ84VRsFHN1Agg7+roXyk04NtuPFx6STlmL2a6
 76DQFIyDrNDc+wEMAIzn/ZGGbRHshg60xw505ws1/XKpiiL+tTfZCgUejvZC0tV51njohRhpt
 svL6NLzFFdUo+IqJnO2Zg+OCFECeCbdD2wV3R9zZ2YnkZeIcJMX9UcvIrLo8+PQaRy6hz9Syw
 WwFyXTRCr/AQuN/ijtELdkXqwO7ZYqku028I+oZXPQ7lQKGmxPToHTW3Io5HOK7gnFTDtPWqp
 96AJd1jspDHbHMWX5gv7IApXst7x0PvNrEnTNU3pI30YdQv3K1czP0aCubSWM24GuUamtFOU7
 eCz19lKCU4S/vQCaoosDRm0kIaSqo4wOJ6BERsFXnsYa+OQdLyggBflYg6onVEPFMy6Q3TSSu
 ywS5L4gHmy9kGwKMgJY3UbI7hHigAb+/SEdXnVA9U0awOFud87Dw3Y4eBPQvAW1iuYTHqwRV+
 psuBCXOryqyyXDHTxGxDFcHUwBZQpHS7P8qDvPD0pCQ6RImbQg0LNqDEJQ6fGOmPMLWcWqzQN
 uL/DjGpTuN3qpQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.11.21 um 17:13 schrieb Pali Roh=C3=A1r:

> On Saturday 20 November 2021 18:03:18 Armin Wolf wrote:
>> The second switch-case has no real purpose:
>>
>> - for I8K_BIOS_VERSION, val does not represent a return value,
>>    making the check for error values unnecessary.
>> - for I8K_MACHINE_ID, val remains zero, so the error check is
>>    unnecessary too.
>>
>> Remove the switch-case and move the calls to copy_to_user()
>> into the first switch-case for I8K_BIOS_VERSION/_MACHINE_ID.
>> Omit buff[] since data->machineid already contains the string
> s/->machineid/->bios_machineid/
>
>> with the necessary zero padding.
> data is allocated by devm_kzalloc() so data->bios_machineid is really
> zero padded.
>
>> Tested on a Dell Inspiron 3505.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/hwmon/dell-smm-hwmon.c | 30 +++++++++---------------------
>>   1 file changed, 9 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hw=
mon.c
>> index 5596c211f38d..b5d1703faa62 100644
>> --- a/drivers/hwmon/dell-smm-hwmon.c
>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>> @@ -454,7 +454,6 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm=
_data *data, unsigned int cmd
>>   {
>>   	int val =3D 0;
>>   	int speed, err;
>> -	unsigned char buff[16];
>>   	int __user *argp =3D (int __user *)arg;
>>
>>   	if (!argp)
>> @@ -468,15 +467,19 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_s=
mm_data *data, unsigned int cmd
>>
>>   		val =3D (data->bios_version[0] << 16) |
>>   				(data->bios_version[1] << 8) | data->bios_version[2];
>> -		break;
>>
>> +		if (copy_to_user(argp, &val, 4))
>> +			return -EFAULT;
>> +
>> +		return 0;
>>   	case I8K_MACHINE_ID:
>>   		if (restricted && !capable(CAP_SYS_ADMIN))
>>   			return -EPERM;
>>
>> -		strscpy_pad(buff, data->bios_machineid, sizeof(buff));
>> -		break;
>> +		if (copy_to_user(argp, data->bios_machineid, 16))
> What about usage of sizeof(data->bios_machineid) instead of hardcoded
> constant 16? And maybe same for constant 4?

For the string yes, but maybe i should change the int to an u32?

>> +			return -EFAULT;
>>
>> +		return 0;
>>   	case I8K_FN_STATUS:
>>   		val =3D i8k_get_fn_status();
>>   		break;
>> @@ -527,23 +530,8 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_sm=
m_data *data, unsigned int cmd
>>   	if (val < 0)
>>   		return val;
>>
>> -	switch (cmd) {
>> -	case I8K_BIOS_VERSION:
>> -		if (copy_to_user(argp, &val, 4))
>> -			return -EFAULT;
>> -
>> -		break;
>> -	case I8K_MACHINE_ID:
>> -		if (copy_to_user(argp, buff, 16))
>> -			return -EFAULT;
>> -
>> -		break;
>> -	default:
>> -		if (copy_to_user(argp, &val, sizeof(int)))
>> -			return -EFAULT;
>> -
>> -		break;
>> -	}
>> +	if (copy_to_user(argp, &val, sizeof(int)))
>> +		return -EFAULT;
>>
>>   	return 0;
>>   }
>> --
>> 2.30.2
>>
