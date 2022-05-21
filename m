Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD8952FAB3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 12:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbiEUKe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 06:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiEUKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 06:34:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4219162A07;
        Sat, 21 May 2022 03:34:17 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L50LS5ylvzhYl4;
        Sat, 21 May 2022 18:33:36 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 18:34:15 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 18:34:15 +0800
Message-ID: <7e6fab31-8606-a3c7-eddb-d165bcf6b486@huawei.com>
Date:   Sat, 21 May 2022 18:34:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 1/2] psi: add support for multi level pressure stall
 trigger
To:     Alex Shi <seakeel@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20220516033524.3130816-1-chenwandun@huawei.com>
 <30b37eeb-e77b-882e-fc24-3367321a8ca3@gmail.com>
 <CAJuCfpE7fBsp8ntYVeLsW7Cd0Z09OmxN75X9Az_Qco0GJrz3Wg@mail.gmail.com>
 <CAJuCfpH-BDqsft1YvGFhkbR60VC0TJgfXKRVN+80e0iqQdhxpA@mail.gmail.com>
 <3a31521f-a68a-b2a9-baae-9a458ee17033@huawei.com>
 <070fe87d-43a0-5e4f-e4c7-c44782c2c195@gmail.com>
 <CAJuCfpH1mTxe5hmzZTe+AbPFse9heenx8uhGzCXE6fAh5G8SzA@mail.gmail.com>
 <29d66a46-d141-2d02-45dd-a8931786588e@gmail.com>
 <9fc88a71-b484-c471-66cd-a4d87d8c02c4@huawei.com>
 <475ccf8e-5238-6924-0a37-c45bc2c98b69@gmail.com>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <475ccf8e-5238-6924-0a37-c45bc2c98b69@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/21 18:13, Alex Shi 写道:
>
> On 5/21/22 15:23, Chen Wandun wrote:
>>
>> 在 2022/5/19 14:15, Alex Shi 写道:
>>> On 5/19/22 05:38, Suren Baghdasaryan wrote:
>>>> On Wed, May 18, 2022 at 3:29 AM Alex Shi <seakeel@gmail.com> wrote:
>>>>>
>>>>> On 5/17/22 20:46, Chen Wandun wrote:
>>>>>>>>> This breaks the old ABI. And why you need this new function?
>>>>>>>> Both great points.
>>>>>>> BTW, I think the additional max_threshold parameter could be
>>>>>>> implemented in a backward compatible way so that the old API is not
>>>>>>> broken:
>>>>>>>
>>>>>>> arg_count = sscanf(buf, "some %u %u %u", &min_threshold_us,  &arg2, &arg3);
>>>>>>> if (arg_count < 2) return ERR_PTR(-EINVAL);
>>>>>>> if (arg_count < 3) {
>>>>>>>        max_threshold_us = INT_MAX;
>>>>>>>        window_us = arg2;
>>>>>>> } else {
>>>>>>>        max_threshold_us = arg2;
>>>>>>>        window_us = arg3;
>>>>>>> }
>>>>>> OK
>>>>>>
>>>>>> Thanks.
>>>>>>> But again, the motivation still needs to be explained.
>>>>>> we want do different operation for different stall level,
>>>>>> just as prev email explain, multi trigger is also OK in old
>>>>>> ways, but it is a litter complex.
>>>>> In fact, I am not keen for this solution, the older and newer
>>>>> interface is easy to be confused by users, for some resolvable
>>>>> unclear issues. It's not a good idea.
>>>> Maybe adding the max_threshold as an optional last argument will be
>>>> less confusing? Smth like this:
>>>>
>>>> some/full min_threshold window_size [max_threshold]
>>> It's already confused enough. :)
>> which point make you confused？
>> Interface suggest by Suren is compatible with current version,
>> I think it is more reasonable and there is no difficuty to understand it.
> Your 3rd parameter has different meaning depends on the exists or non-exist
> 4th one. It's not a good design.
>
some/full min_threshold window_size [max_threshold]

In this format, the meaning of 3rd parameter keep unchanged.
This format is compatible with current version.

>>> BTW, I still don't see the strong reason for the pressure range.
>> Considering this case:
>> I divide pressure into multi levels, and each level corresponds to a
>> hander,  I have to register multi triggers and wait for fire events,
>> nowadays, these trigger is something like:
>> echo “some 150000 1000000” > /proc/pressure/memory
>> echo “some 350000 1000000” > /proc/pressure/memory
>> echo “some 550000 1000000” > /proc/pressure/memory
>> echo “some 750000 1000000” > /proc/pressure/memory
>>
>> In the best case, stall pressure between 150000 and 350000,
>> only one trigger fire, and only one wakeup.
>>
>> In any other case,  multi triggers fire and multi wakeup, but it
>> indeed is no need.
>>
> Could you give more details info to show what detailed problem
> which your propose could address, but current code cannot?
Current code also can handle this, but thing become complex，jsut
as explained above.

Thanks
Wandun
>
> Thanks
> Alex
>
>> New implement make the fire and wakeup more precise,
>> userspace code will be more simple, no confusing fire event,
>> no need to filter fire event anymore, maybe minor performance
>> improved.
>>
>> Thanks.
>>>>> Also, if we do decide to add it, there should be a warning in the
>>>> documentation that max_threshold usage might lead to a stall being
>>>> missed completely. In your example:
>>>>
>>>> echo "some 150000 350000 1000000" > /proc/pressure/memory
>>>>
>>>> If there is a stall of more than 350ms within a given window, that
>>>> trigger will not fire at all.
>>> Right.
>>> And what if others propose more pressure combinations?
>>> Maybe leave them to user space is more likely workable?
>>>
>>> Thanks
>>> Alex
>>> .
> .

