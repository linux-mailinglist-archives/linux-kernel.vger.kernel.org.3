Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4241A5A58D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiH3BJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiH3BJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:09:54 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0740272E;
        Mon, 29 Aug 2022 18:09:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGq1h626Xzl653;
        Tue, 30 Aug 2022 09:08:24 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgB3_TBdYw1jg5twAA--.39274S3;
        Tue, 30 Aug 2022 09:09:49 +0800 (CST)
Subject: Re: [PATCH -next 0/3] md/raid10: reduce lock contention for io
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <70172016-8ae5-92b8-2a43-8f0d4a2f6668@molgen.mpg.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0e22c51b-d36a-2216-4bfd-522049d3ed44@huaweicloud.com>
Date:   Tue, 30 Aug 2022 09:09:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <70172016-8ae5-92b8-2a43-8f0d4a2f6668@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgB3_TBdYw1jg5twAA--.39274S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7trWUuFW5Gw17ArWUJwb_yoW8ZrWDpa
        y3KFW3Zr47uw1xZrWavr4UXa4YyayxXrZ8Cry3Jry7AFW5ZFWxXF4IgF4rWryqqrZYgw17
        X3WUGrZ5Wa45Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9
        -UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul!

在 2022/08/29 21:58, Paul Menzel 写道:
> Dear Yu,
> 
> 
> Thank you for your patches.
> 
> Am 29.08.22 um 15:14 schrieb Yu Kuai:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> patch 1 is a small problem found by code review.
>> patch 2 avoid holding resync_lock in fast path.
>> patch 3 avoid holding lock in wake_up() in fast path.
>>
>> Test environment:
>>
>> Architecture: aarch64
>> Cpu: Huawei KUNPENG 920, there are four numa nodes
>>
>> Raid10 initialize:
>> mdadm --create /dev/md0 --level 10 --bitmap none --raid-devices 4 
>> /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1
>>
>> Test cmd:
>> fio -name=0 -ioengine=libaio -direct=1 -group_reporting=1 
>> -randseed=2022 -rwmixread=70 -refill_buffers -filename=/dev/md0 
>> -numjobs=16 -runtime=60s -bs=4k -iodepth=256 -rw=randread
>>
>> Test result:
>> before this patchset:    2.9 GiB/s
>> after this patchset:    6.6 Gib/s
> 
> Could you please give more details about the test setup, like the drives 
> used?

test setup is described above, four nvme disks is used.
> 
> Did you use some tools like ftrace to figure out the bottleneck?

Yes, I'm sure the bottleneck is spin_lock(), specifically threads from
multiple nodes try to grab the same lock. By the way, if I bind the
threads to the same node, performance can also improve to 6.6 Gib/s
without this patchset.

Thanks,
Kuai
> 
>> Please noted that in kunpeng-920, memory access latency is very bad
>> accross nodes compare to local node, and in other architecture
>> performance improvement might not be significant.
>>
>> Yu Kuai (3):
>>    md/raid10: fix improper BUG_ON() in raise_barrier()
>>    md/raid10: convert resync_lock to use seqlock
>>    md/raid10: prevent unnecessary calls to wake_up() in fast path
>>
>>   drivers/md/raid10.c | 88 +++++++++++++++++++++++++++++----------------
>>   drivers/md/raid10.h |  2 +-
>>   2 files changed, 59 insertions(+), 31 deletions(-)
> 
> 
> Kind regards,
> 
> Paul
> .
> 

