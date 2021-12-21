Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290AF47B6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 02:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhLUBep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 20:34:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230414AbhLUBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 20:34:44 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BKM2jpB012049;
        Tue, 21 Dec 2021 01:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=AOyM3F7ZKfKRxxoqk+1O5vL+ffNPJtqG3kFO9/ZRuxQ=;
 b=b3YwNHSurmFmsT+EI/8E4bZ/xVlqiV5t3AMgHBh1Z19CImGmXd1te8pdhqwMqDgZHhC2
 Lt9h7aguk3Co5j4lohDIACuW9CuoAKcqLGJSoforgRCNuJtZVsggzUXgbCasQoe6dgl6
 LP+xS+0Ujkc1HcvmF4ZiYRa8LakpGDpraaKFl/h6K0QAyPYHMo6mGHmZCMjyQ47QCeTs
 yVoXevQUT3rJT0E1IegVwTtuoTvTkbaOOLwQV3sBAceeKgzhh08oeJPs71WkUrgY4e1O
 7K6Os8zoPM7NRlINmKPKY4VO73oAn5O6iHAulIFcdN2Xv+pD/Ii7X+ZrmJxeUdbwWVVV VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d1s15shpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 01:34:39 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BL1QB8F011750;
        Tue, 21 Dec 2021 01:34:38 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d1s15shph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 01:34:38 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BL1YaY3030263;
        Tue, 21 Dec 2021 01:34:37 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3d179ahhqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 01:34:37 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BL1YYOq31130102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 01:34:34 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D1747805C;
        Tue, 21 Dec 2021 01:34:34 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC83078066;
        Tue, 21 Dec 2021 01:34:32 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.65.210.85])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 Dec 2021 01:34:32 +0000 (GMT)
Subject: Re: [PATCH] tpm: Fix kexec crash due to access to ops NULL pointer
 (powerpc)
To:     Stefan Berger <stefanb@linux.ibm.com>, jarkko@kernel.org,
        peterhuewe@gmx.de, linux-integrity@vger.kernel.org
Cc:     Korrapati.Likhitha@ibm.com, pavrampu@in.ibm.com,
        linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        linux-security-module@vger.kernel.org, gcwilson@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20211212012804.1555661-1-stefanb@linux.ibm.com>
 <1052cd36-1b85-5d36-045f-5c5bf9f0fc4e@linux.ibm.com>
 <d9eafa8f-4006-4bc2-c09b-6b02a14c6ef3@linux.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <35d1e223-f0f0-0752-42ee-c51e8b90a806@linux.ibm.com>
Date:   Mon, 20 Dec 2021 17:34:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <d9eafa8f-4006-4bc2-c09b-6b02a14c6ef3@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9AcxF-yJy9LqcgFfUva5CkZKNj-tq296
X-Proofpoint-ORIG-GUID: LHes3wBBIXGA2dBVrmhNmhHI5hOP-x4V
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_11,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/21 5:05 PM, Stefan Berger wrote:
> 
> On 12/20/21 19:39, Tyrel Datwyler wrote:
>> On 12/11/21 5:28 PM, Stefan Berger wrote:
>>> Fix the following crash on kexec by checking chip->ops for a NULL pointer
>>> in tpm_chip_start() and returning an error code if this is the case.
>>>
>>> BUG: Kernel NULL pointer dereference on read at 0x00000060
>>> Faulting instruction address: 0xc00000000099a06c
>>> Oops: Kernel access of bad area, sig: 11 [#1]
>>> ...
>>> NIP [c00000000099a06c] tpm_chip_start+0x2c/0x140
>>>   LR [c00000000099a808] tpm_chip_unregister+0x108/0x170
>>> Call Trace:
>>> [c0000000188bfa00] [c000000002b03930] fw_devlink_strict+0x0/0x8 (unreliable)
>>> [c0000000188bfa30] [c00000000099a808] tpm_chip_unregister+0x108/0x170
>>> [c0000000188bfa70] [c0000000009a3874] tpm_ibmvtpm_remove+0x34/0x130
>>> [c0000000188bfae0] [c000000000110dbc] vio_bus_remove+0x5c/0xb0
>>> [c0000000188bfb20] [c0000000009bc154] device_shutdown+0x1d4/0x3a8
>>> [c0000000188bfbc0] [c000000000196e14] kernel_restart_prepare+0x54/0x70
>>>
>>> The referenced patch below introduced a function to shut down the VIO bus.
>>> The bus shutdown now calls tpm_del_char_device (via tpm_chip_unregister)
>>> after a call to tpm_class_shutdown, which already set chip->ops to NULL.
>>> The crash occurrs when tpm_del_char_device calls tpm_chip_start with the
>>> chip->ops NULL pointer.
>> It was unclear to me at first, but IIUC the problem is the ibmvtpm device
>> receives two shutdown calls, the first is a class shutdown call for TPM devices,
>> followed by a bus shutdown call for VIO devices.
>>
>> It appears that the class shutdown routines are meant to be a pre-shutdown
>> routine as they are defined as class->shutdown_pre(), and it is clearly allowed
>> to call class->shutdown_pre() followed by one of but not both of the following
>> bus->shutdown() or driver->shutdown(). Even tpm_class_shutdown() mentions in the
>> function comment that bus/device shutdown to follow.
> 
> I suppose you are referring to this here:
> 
> /**
>  * tpm_class_shutdown() - prepare the TPM device for loss of power.
>  * @dev: device to which the chip is associated.
>  *
>  * Issues a TPM2_Shutdown command prior to loss of power, as required by the
>  * TPM 2.0 spec. Then, calls bus- and device- specific shutdown code.
>  *
>  * Return: always 0 (i.e. success)
>  */
> 
> I think this comment still refers to the ancient code here:
> 
> https://elixir.bootlin.com/linux/v4.4.295/source/drivers/char/tpm/tpm-chip.c#L161
> 
>     if (dev->bus && dev->bus->shutdown)
>         dev->bus->shutdown(dev);
>     else if (dev->driver && dev->driver->shutdown)
>         dev->driver->shutdown(dev);
> 

Right, but that was because device_shutdown didn't use to call bus or driver
shutdown routines if class->shutdown was defined. TPM is the class of devices
that implements class->shutdown and that code above was removed and
device_shutdown was made to call class and either bus/driver shutdown as well.

See: Commit 7521621e600ae ("Do not disable driver and bus shutdown hook when
class shutdown hook is set")
> 
> 
>>> Fixes: 39d0099f9439 ("powerpc/pseries: Add shutdown() to vio_driver and
>>> vio_bus")
>> This patch left implementing each vio driver shutdown routine as an exercise for
>> the respective maintainers, and instead just big hammers anything that doesn't
>> have a shutdown routine by calling the driver->remove().
>>
>> If tpm_class_shutdown() quiecses ibmvtpm enough implementing a no-op
>> ibmvtpm->shutdown() with a comment saying so suffices.
>>
>> However, the generic TPM code is still introducing a bug that an attempt to call
>> tpm_chip_unregister() after tpm_class_shutdown() will crash as mentioned above.
> 
> 
> An alternative solution may be this here:

Right, this is exactly what I was proposing in my last comment previously.

> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..4cb908349b31 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -473,15 +473,8 @@ static void tpm_del_char_device(struct tpm_chip *chip)
>         mutex_unlock(&idr_lock);
> 
>         /* Make the driver uncallable. */
> -       down_write(&chip->ops_sem);
> -       if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -               if (!tpm_chip_start(chip)) {
> -                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
> -                       tpm_chip_stop(chip);
> -               }
> -       }
> -       chip->ops = NULL;
> -       up_write(&chip->ops_sem);
> +       if (chip->ops)
> +               tpm_class_shutdown(&chip->dev);
>  }
> 
>  static void tpm_del_legacy_sysfs(struct tpm_chip *chip)
> 
> 
> I could post this as v2 ?! Let me know...

Seeing as it is in TPM generic code and I'm not expert it would be nice if we
got some input from Jarkko, or someone else with more experience in this area to
make sure we aren't missing some other interaction. Otherwise, works for me.

-Tyrel

> 
>    Stefan
> 
> 
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>   drivers/char/tpm/tpm-chip.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>>> index ddaeceb7e109..cca1bde296ee 100644
>>> --- a/drivers/char/tpm/tpm-chip.c
>>> +++ b/drivers/char/tpm/tpm-chip.c
>>> @@ -101,6 +101,9 @@ int tpm_chip_start(struct tpm_chip *chip)
>>>   {
>>>       int ret;
>>>
>>> +    if (!chip->ops)
>>> +        return -EINVAL;
>>> +
>> I wonder if a better fix would to have tpm_del_char_device() check for valid
>> chip->ops and call tpm_class_shutdown() when the ops are still valid. Calling
>> tpm_class_shutdown() allows for some code deduplication in tpm_del_char_device().
>>
>> -Tyrel
>>
>>>       tpm_clk_enable(chip);
>>>
>>>       if (chip->locality == -1) {
>>>

