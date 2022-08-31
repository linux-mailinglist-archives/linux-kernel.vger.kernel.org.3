Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F25F5A7C95
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiHaLz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHaLzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:55:22 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5FD53D16;
        Wed, 31 Aug 2022 04:55:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MHjHh3148z6PCVF;
        Wed, 31 Aug 2022 19:53:36 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgBHmnMjTA9jgtW3AA--.42274S3;
        Wed, 31 Aug 2022 19:55:16 +0800 (CST)
Subject: Re: [PATCH -next 0/3] md/raid10: reduce lock contention for io
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <691f9d94-f650-0f04-2d49-74fe84c24bfe@linux.dev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8e7a2dcd-805c-97e0-2236-b2f28941b25b@huaweicloud.com>
Date:   Wed, 31 Aug 2022 19:55:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <691f9d94-f650-0f04-2d49-74fe84c24bfe@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBHmnMjTA9jgtW3AA--.42274S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15GrWUXF4kJw4DtrW3Awb_yoW8Gr48pa
        yfZF4FkFsxGw1xZrW7tr1DWa42y3WxXrZ3CryFkry7Cas8XFyxXrn7JF4rWF4DXF4Sg3W7
        ua98J34rWa48A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
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

Hi!

在 2022/08/29 21:40, Guoqing Jiang 写道:
> 
> 
> On 8/29/22 9:14 PM, Yu Kuai wrote:
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
> Impressive! Pls try mdadm test suites too to avoid regression.
> 
>> Please noted that in kunpeng-920, memory access latency is very bad
>> accross nodes compare to local node, and in other architecture
>> performance improvement might not be significant.
> 
> By any chance can someone try with x64?

I tried to test with Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz,

before this patchset: 7.0 GiB/s
after this patchset : 9.3 GiB/s

Thanks,
Kuai
> 
> Thanks,
> Guoqing
> .
> 

