Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAC25A7CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiHaMH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiHaMHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:07:24 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DEF43301;
        Wed, 31 Aug 2022 05:07:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MHjYX3Fyyz6R4VK;
        Wed, 31 Aug 2022 20:05:36 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXPzTg9jlze4AA--.43595S3;
        Wed, 31 Aug 2022 20:07:16 +0800 (CST)
Subject: Re: [PATCH -next 0/3] md/raid10: reduce lock contention for io
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <70172016-8ae5-92b8-2a43-8f0d4a2f6668@molgen.mpg.de>
 <0e22c51b-d36a-2216-4bfd-522049d3ed44@huaweicloud.com>
 <39f59994-cf2e-f8c4-fd57-988e8c7e05e5@molgen.mpg.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1df89f4f-4e3a-8683-89c9-6e048ed79119@huaweicloud.com>
Date:   Wed, 31 Aug 2022 20:07:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <39f59994-cf2e-f8c4-fd57-988e8c7e05e5@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXPzTg9jlze4AA--.43595S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxuw4DZF13Jr1xuw1xZrb_yoW8KF18pa
        yfKa1Yvr4Uuw1furyavr1UWFyYyayxXrZ8Wr9xXryxZFZ0qFW8XF4xtF4rWryDXrsYkw17
        Xw1UJrWfW345Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aP
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul!

在 2022/08/31 19:59, Paul Menzel 写道:
> Dear Yu,
> 
> 
> Am 30.08.22 um 03:09 schrieb Yu Kuai:
> 
>> 在 2022/08/29 21:58, Paul Menzel 写道:
> 
>>> Am 29.08.22 um 15:14 schrieb Yu Kuai:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> patch 1 is a small problem found by code review.
>>>> patch 2 avoid holding resync_lock in fast path.
>>>> patch 3 avoid holding lock in wake_up() in fast path.
>>>>
>>>> Test environment:
>>>>
>>>> Architecture: aarch64
>>>> Cpu: Huawei KUNPENG 920, there are four numa nodes
>>>>
>>>> Raid10 initialize:
>>>> mdadm --create /dev/md0 --level 10 --bitmap none --raid-devices 4 
>>>> /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1
>>>>
>>>> Test cmd:
>>>> fio -name=0 -ioengine=libaio -direct=1 -group_reporting=1 
>>>> -randseed=2022 -rwmixread=70 -refill_buffers -filename=/dev/md0 
>>>> -numjobs=16 -runtime=60s -bs=4k -iodepth=256 -rw=randread
>>>>
>>>> Test result:
>>>> before this patchset:    2.9 GiB/s
>>>> after this patchset:    6.6 Gib/s
>>>
>>> Could you please give more details about the test setup, like the 
>>> drives used?
>>
>> test setup is described above, four nvme disks is used.
> 
> I was wondering about the model to be able to reproduce it.
> 
>>> Did you use some tools like ftrace to figure out the bottleneck?
>>
>> Yes, I'm sure the bottleneck is spin_lock(), specifically threads from
>> multiple nodes try to grab the same lock. By the way, if I bind the
>> threads to the same node, performance can also improve to 6.6 Gib/s
>> without this patchset.
> 
> Interesting. Maybe you could add all that to the commit message of the 
> second patch.

Of course, I will do that in next version.

Thanks,
Kuai
> 
> 
> Kind regards,
> 
> Paul
> 
> 
>>>> Please noted that in kunpeng-920, memory access latency is very bad
>>>> accross nodes compare to local node, and in other architecture
>>>> performance improvement might not be significant.
>>>>
>>>> Yu Kuai (3):
>>>>    md/raid10: fix improper BUG_ON() in raise_barrier()
>>>>    md/raid10: convert resync_lock to use seqlock
>>>>    md/raid10: prevent unnecessary calls to wake_up() in fast path
>>>>
>>>>   drivers/md/raid10.c | 88 
>>>> +++++++++++++++++++++++++++++----------------
>>>>   drivers/md/raid10.h |  2 +-
>>>>   2 files changed, 59 insertions(+), 31 deletions(-)
> .
> 

