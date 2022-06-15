Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE854C47B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348089AbiFOJTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241370AbiFOJTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:19:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3D91A83E;
        Wed, 15 Jun 2022 02:19:01 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LNKR06hyHzSgvS;
        Wed, 15 Jun 2022 17:15:40 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 17:18:58 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 17:18:58 +0800
Subject: Re: [PATCH v2 2/3] Documentation: add a isolation strategy vfs node
 for uacce
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20220614122943.1406-1-yekai13@huawei.com>
 <20220614122943.1406-3-yekai13@huawei.com> <YqiCEHTauCoceNNI@kroah.com>
 <20220615094813.000026a6@Huawei.com>
CC:     <herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
        <linux-crypto@vger.kernel.org>, <zhangfei.gao@linaro.org>,
        <linux-accelerators@lists.ozlabs.org>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <bb9c0b39-3663-107c-e725-c0374b3831c8@huawei.com>
Date:   Wed, 15 Jun 2022 17:18:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220615094813.000026a6@Huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/15 16:48, Jonathan Cameron wrote:
> On Tue, 14 Jun 2022 14:41:52 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
>> On Tue, Jun 14, 2022 at 08:29:39PM +0800, Kai Ye wrote:
>>> Update documentation describing DebugFS that could help to
>>> configure hard error frequency for users in th user space.
>>>
>>> Signed-off-by: Kai Ye <yekai13@huawei.com>
>>> ---
>>>  Documentation/ABI/testing/sysfs-driver-uacce | 17 +++++++++++++++++
>>>  1 file changed, 17 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
>>> index 08f2591138af..0c4226364182 100644
>>> --- a/Documentation/ABI/testing/sysfs-driver-uacce
>>> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
>>> @@ -19,6 +19,23 @@ Contact:        linux-accelerators@lists.ozlabs.org
>>>  Description:    Available instances left of the device
>>>                  Return -ENODEV if uacce_ops get_available_instances is not provided
>>>
>>> +What:           /sys/class/uacce/<dev_name>/isolate_strategy
>>> +Date:           Jun 2022
>>> +KernelVersion:  5.19
>>> +Contact:        linux-accelerators@lists.ozlabs.org
>>> +Description:    A vfs node that used to configures the hardware
>>
>> What is a "vfs node"?
>>
>>> +                error frequency. This frequency is abstract. Like once an hour
>>> +                or once a day. The specific isolation strategy can be defined in
>>> +                each driver module.
>>
>> No, you need to be specific here and describe the units and the format.
>> Otherwise it is no description at all :(
>
> Also, rename it.   A frequency isn't a strategy.  Strategy would be something
> like:
>
> * First fault
> * Faults in moving time window.
> * Faults in fixed time window.
>
> some of which would then need separate controls for the threshold and the
> time window - those should be in separate sysfs attributes.
>

I will describe the units and the format in here.

Thanks

Kai
>>
>>> +
>>> +What:           /sys/class/uacce/<dev_name>/isolate
>>> +Date:           Jun 2022
>>> +KernelVersion:  5.19
>>
>> 5.19 will not have this change.
>>
>>> +Contact:        linux-accelerators@lists.ozlabs.org
>>> +Description:    A vfs node that show the device isolated state. The value 0
>>> +                means that the device is working. The value 1 means that the
>>> +                device has been isolated.
>>
>> What does "working" or "isolated" mean?
>>
>> thanks,
>>
>> greg k-h
>
> .
>
