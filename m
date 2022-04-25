Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ADF50D9BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiDYGum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDYGud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:50:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A2A69483;
        Sun, 24 Apr 2022 23:47:28 -0700 (PDT)
Received: from kwepemi500017.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KmwXW0KbYzfb6Z;
        Mon, 25 Apr 2022 14:46:35 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500017.china.huawei.com (7.221.188.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 14:47:26 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 14:47:25 +0800
Subject: Re: [PATCH -next RFC v3 0/8] improve tag allocation under heavy load
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <bvanassche@acm.org>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>, <qiulaibin@huawei.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220415101053.554495-1-yukuai3@huawei.com>
 <dc800086-43c6-1ff2-659e-258cb75649dd@huawei.com>
 <3fbadd9f-11dd-9043-11cf-f0839dcf30e1@opensource.wdc.com>
 <63e84f2a-2487-a0c3-cab2-7d2011bc2db4@huawei.com>
 <55e8b04f-0d2f-2ce1-6514-5abd0b67fd48@opensource.wdc.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <6957af40-8720-d74b-5be7-6bcdd9aa1089@huawei.com>
Date:   Mon, 25 Apr 2022 14:47:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <55e8b04f-0d2f-2ce1-6514-5abd0b67fd48@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/04/25 14:23, Damien Le Moal 写道:
> On 4/25/22 15:14, yukuai (C) wrote:
>> 在 2022/04/25 11:24, Damien Le Moal 写道:
>>> On 4/24/22 11:43, yukuai (C) wrote:
>>>> friendly ping ...
>>>>
>>>> 在 2022/04/15 18:10, Yu Kuai 写道:
>>>>> Changes in v3:
>>>>>     - update 'waiters_cnt' before 'ws_active' in sbitmap_prepare_to_wait()
>>>>>     in patch 1, in case __sbq_wake_up() see 'ws_active > 0' while
>>>>>     'waiters_cnt' are all 0, which will cause deap loop.
>>>>>     - don't add 'wait_index' during each loop in patch 2
>>>>>     - fix that 'wake_index' might mismatch in the first wake up in patch 3,
>>>>>     also improving coding for the patch.
>>>>>     - add a detection in patch 4 in case io hung is triggered in corner
>>>>>     cases.
>>>>>     - make the detection, free tags are sufficient, more flexible.
>>>>>     - fix a race in patch 8.
>>>>>     - fix some words and add some comments.
>>>>>
>>>>> Changes in v2:
>>>>>     - use a new title
>>>>>     - add patches to fix waitqueues' unfairness - path 1-3
>>>>>     - delete patch to add queue flag
>>>>>     - delete patch to split big io thoroughly
>>>>>
>>>>> In this patchset:
>>>>>     - patch 1-3 fix waitqueues' unfairness.
>>>>>     - patch 4,5 disable tag preemption on heavy load.
>>>>>     - patch 6 forces tag preemption for split bios.
>>>>>     - patch 7,8 improve large random io for HDD. We do meet the problem and
>>>>>     I'm trying to fix it at very low cost. However, if anyone still thinks
>>>>>     this is not a common case and not worth to optimize, I'll drop them.
>>>>>
>>>>> There is a defect for blk-mq compare to blk-sq, specifically split io
>>>>> will end up discontinuous if the device is under high io pressure, while
>>>>> split io will still be continuous in sq, this is because:
>>>>>
>>>>> 1) new io can preempt tag even if there are lots of threads waiting.
>>>>> 2) split bio is issued one by one, if one bio can't get tag, it will go
>>>>> to wail.
>>>>> 3) each time 8(or wake batch) requests is done, 8 waiters will be woken up.
>>>>> Thus if a thread is woken up, it will unlikey to get multiple tags.
>>>>>
>>>>> The problem was first found by upgrading kernel from v3.10 to v4.18,
>>>>> test device is HDD with 256 'max_sectors_kb', and test case is issuing 1m
>>>>> ios with high concurrency.
>>>>>
>>>>> Noted that there is a precondition for such performance problem:
>>>>> There is a certain gap between bandwidth for single io with
>>>>> bs=max_sectors_kb and disk upper limit.
>>>>>
>>>>> During the test, I found that waitqueues can be extremly unbalanced on
>>>>> heavy load. This is because 'wake_index' is not set properly in
>>>>> __sbq_wake_up(), see details in patch 3.
>>>>>
>>>>> Test environment:
>>>>> arm64, 96 core with 200 BogoMIPS, test device is HDD. The default
>>>>> 'max_sectors_kb' is 1280(Sorry that I was unable to test on the machine
>>>>> where 'max_sectors_kb' is 256).>>
>>>>> The single io performance(randwrite):
>>>>>
>>>>> | bs       | 128k | 256k | 512k | 1m   | 1280k | 2m   | 4m   |
>>>>> | -------- | ---- | ---- | ---- | ---- | ----- | ---- | ---- |
>>>>> | bw MiB/s | 20.1 | 33.4 | 51.8 | 67.1 | 74.7  | 82.9 | 82.9 |
>>>
>>> These results are extremely strange, unless you are running with the
>>> device write cache disabled ? If you have the device write cache enabled,
>>> the problem you mention above would be most likely completely invisible,
>>> which I guess is why nobody really noticed any issue until now.
>>>
>>> Similarly, with reads, the device side read-ahead may hide the problem,
>>> albeit that depends on how "intelligent" the drive is at identifying
>>> sequential accesses.
>>>
>>>>>
>>>>> It can be seen that 1280k io is already close to upper limit, and it'll
>>>>> be hard to see differences with the default value, thus I set
>>>>> 'max_sectors_kb' to 128 in the following test.
>>>>>
>>>>> Test cmd:
>>>>>            fio \
>>>>>            -filename=/dev/$dev \
>>>>>            -name=test \
>>>>>            -ioengine=psync \
>>>>>            -allow_mounted_write=0 \
>>>>>            -group_reporting \
>>>>>            -direct=1 \
>>>>>            -offset_increment=1g \
>>>>>            -rw=randwrite \
>>>>>            -bs=1024k \
>>>>>            -numjobs={1,2,4,8,16,32,64,128,256,512} \
>>>>>            -runtime=110 \
>>>>>            -ramp_time=10
>>>>>
>>>>> Test result: MiB/s
>>>>>
>>>>> | numjobs | v5.18-rc1 | v5.18-rc1-patched |
>>>>> | ------- | --------- | ----------------- |
>>>>> | 1       | 67.7      | 67.7              |
>>>>> | 2       | 67.7      | 67.7              |
>>>>> | 4       | 67.7      | 67.7              |
>>>>> | 8       | 67.7      | 67.7              |
>>>>> | 16      | 64.8      | 65.6              |
>>>>> | 32      | 59.8      | 63.8              |
>>>>> | 64      | 54.9      | 59.4              |
>>>>> | 128     | 49        | 56.9              |
>>>>> | 256     | 37.7      | 58.3              |
>>>>> | 512     | 31.8      | 57.9              |
>>>
>>> Device write cache disabled ?
>>>
>>> Also, what is the max QD of this disk ?
>>>
>>> E.g., if it is SATA, it is 32, so you will only get at most 64 scheduler
>>> tags. So for any of your tests with more than 64 threads, many of the
>>> threads will be waiting for a scheduler tag for the BIO before the
>>> bio_split problem you explain triggers. Given that the numbers you show
>>> are the same for before-after patch with a number of threads <= 64, I am
>>> tempted to think that the problem is not really BIO splitting...
>>>
>>> What about random read workloads ? What kind of results do you see ?
>>
>> Hi,
>>
>> Sorry about the misleading of this test case.
>>
>> This testcase is high concurrency huge randwrite, it's just for the
>> problem that split bios won't be issued continuously, which is the
>> root cause of the performance degradation as the numjobs increases.
>>
>> queue_depth is 32, and numjobs is 64, thus when numjobs is not greater
>> than 8, performance is fine, because the ratio of sequential io should
>> be 7/8. However, as numjobs increases, performance is worse because
>> the ratio is lower. For example, when numjobs is 512, the ratio of
>> sequential io is about 20%.
> 
> But with 512 jobs, you will get only 64 jobs only with IOs in the queue.
> All other jobs will be waiting for a scheduler tag before being able to
> issue their large BIO. No ?

Hi,

It's right.

In fact, after this patchset, since each large io will need total 8
tags, only 8 jobs can be in the queue while others are waiting for
scheduler tag.

> 
> It sounds like the set of scheduler tags should be a bit more elastic:
> always allow BIOs from a split of a large BIO to be submitted (that is to
> get a scheduler tag) even if that causes a temporary excess of the number
> of requests beyond the default number of scheduler tags. Doing so, all
> fragments of a large BIOs can be queued immediately. From there, if the
> scheduler operates correctly, all the requests from the large BIOs split
> would be issued in sequence to the device.

This solution sounds feasible in theory, however, I'm not sure yet how
to implement that 'temporary excess'.

Thanks,
Kuai
> 
> 
>>
>> patch 6-8 will let split bios still be issued continuously under high
>> pressure.
>>
>> Thanks,
>> Kuai
>>
> 
> 
