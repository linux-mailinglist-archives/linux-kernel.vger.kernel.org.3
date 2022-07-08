Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256FA56B5CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiGHJiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbiGHJiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:38:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621B5C9FB;
        Fri,  8 Jul 2022 02:38:19 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LfSpm60gTzhYqb;
        Fri,  8 Jul 2022 17:36:48 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 17:38:18 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 17:38:18 +0800
Subject: Re: [PATCH v5 2/3] Documentation: add a isolation strategy sysfs node
 for uacce
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20220708070820.43958-1-yekai13@huawei.com>
 <20220708070820.43958-3-yekai13@huawei.com> <YsfdDgetpgMzteKt@kroah.com>
CC:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <9eaebf54-5095-0b02-8a06-f7235e2ba793@huawei.com>
Date:   Fri, 8 Jul 2022 17:38:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YsfdDgetpgMzteKt@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/8 15:30, Greg KH wrote:
> On Fri, Jul 08, 2022 at 03:08:19PM +0800, Kai Ye wrote:
>> Update documentation describing sysfs node that could help to
>> configure isolation strategy for users in the user space. And
>> describing sysfs node that could read the device isolated state.
>>
>> Signed-off-by: Kai Ye <yekai13@huawei.com>
>> ---
>>  Documentation/ABI/testing/sysfs-driver-uacce | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
>> index 08f2591138af..a8056271a963 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-uacce
>> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
>> @@ -19,6 +19,24 @@ Contact:        linux-accelerators@lists.ozlabs.org
>>  Description:    Available instances left of the device
>>                  Return -ENODEV if uacce_ops get_available_instances is not provided
>>
>> +What:           /sys/class/uacce/<dev_name>/isolate_strategy
>> +Date:           Jul 2022
>> +KernelVersion:  5.20
>> +Contact:        linux-accelerators@lists.ozlabs.org
>> +Description:    A sysfs node that used to configures the hardware error
>
> This is not a "node" it is just a file.
>
>
>> +                isolation strategy. This strategy is a configured integer value.
>> +                The default is 0. The maximum value is 65535. This value
>> +                indicates the number of device slot resets per unit time
>> +                that your service can tolerate.
>
> I do not understand this, sorry.  What do you mean by "that your service
> can tolerate"?

it means the user can tolerable reset frequency, because the reset will 
interrupt services.

>
>> +
>> +What:           /sys/class/uacce/<dev_name>/isolate
>> +Date:           Jul 2022
>> +KernelVersion:  5.20
>> +Contact:        linux-accelerators@lists.ozlabs.org
>> +Description:    A sysfs node that read the device isolated state. The value 0
>> +                means that the device is working. The value 1 means that the
>> +                device has been isolated.
>
> So 1 means "not working"?  This seems odd, perhaps you can rephrase this
> a bit better?

1 means the device is unavailable. 0 means the device is available.
>
> thanks,
>
> greg k-h
> .
>

Thanks

Kai
