Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0855866D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiHAJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiHAJZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:25:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D472B264;
        Mon,  1 Aug 2022 02:25:07 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LxCLh4MZ4zjXfM;
        Mon,  1 Aug 2022 17:22:04 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 17:25:04 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 17:25:04 +0800
Subject: Re: [PATCH v6 2/3] Documentation: add a isolation strategy sysfs node
 for uacce
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20220730083246.55646-1-yekai13@huawei.com>
 <20220730083246.55646-3-yekai13@huawei.com> <YuUQuNPIV6Xrfmwt@kroah.com>
 <901896fa-2acc-127c-a8ea-8143cda47b1b@huawei.com>
 <YudvGPbcegOZQlbE@kroah.com>
CC:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <liulongfang@huawei.com>
From:   "yekai (A)" <yekai13@huawei.com>
Message-ID: <3d8542bd-42b3-e739-6d97-d1e75effdba8@huawei.com>
Date:   Mon, 1 Aug 2022 17:25:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YudvGPbcegOZQlbE@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/1 14:13, Greg KH wrote:
> On Mon, Aug 01, 2022 at 10:20:27AM +0800, yekai (A) wrote:
>>
>> On 2022/7/30 19:06, Greg KH wrote:
>>> On Sat, Jul 30, 2022 at 04:32:45PM +0800, Kai Ye wrote:
>>>> Update documentation describing sysfs node that could help to
>>>> configure isolation strategy for users in the user space. And
>>>> describing sysfs node that could read the device isolated state.
>>>>
>>>> Signed-off-by: Kai Ye <yekai13@huawei.com>
>>>> ---
>>>>  Documentation/ABI/testing/sysfs-driver-uacce | 17 +++++++++++++++++
>>>>  1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
>>>> index 08f2591138af..1601f9dac29c 100644
>>>> --- a/Documentation/ABI/testing/sysfs-driver-uacce
>>>> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
>>>> @@ -19,6 +19,23 @@ Contact:        linux-accelerators@lists.ozlabs.org
>>>>  Description:    Available instances left of the device
>>>>                  Return -ENODEV if uacce_ops get_available_instances is not provided
>>>>  
>>>> +What:           /sys/class/uacce/<dev_name>/isolate_strategy
>>>> +Date:           Jul 2022
>>>> +KernelVersion:  5.20
>>>> +Contact:        linux-accelerators@lists.ozlabs.org
>>>> +Description:    (RW) Configure the frequency size for the hardware error
>>>> +                isolation strategy. This size is a configured integer value.
>>>> +                The default is 0. The maximum value is 65535. This value is a
>>>> +                threshold based on your driver handling strategy.
>>> what is a "driver handling strategy"?  What exactly is this units in?
>>> Any documentation for how to use this?
>>>
>>> thanks,
>>>
>>> greg k-h
>>> .
>> The unit is the number of times, also means frequency size.
>> e.g.
>> In the  hisilicon acc engine, First we will time-stamp every slot AER error. Then check the AER error log when the device
>> AER error occurred. if the device slot AER error count  exceeds the preset the number of times in one hour, the isolated state
>> will be set to true. So the device will be isolated.  And the AER error log that exceed one hour  will be cleared.  Of course,
>> different strategy can be defined in different drivers.
> Ok, can you please explain this better here when you redo the patch
> series?
>
> thanks,
>
> greg k-h
> .
>
OK, I will do this in the next v7 patch series.

thanks

Kai
