Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DD55AACD6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiIBKyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIBKyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:54:01 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE86C480C;
        Fri,  2 Sep 2022 03:54:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MJvrG5MShzlCC0;
        Fri,  2 Sep 2022 18:52:30 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgD3SXPE4BFjn3sRAQ--.17387S3;
        Fri, 02 Sep 2022 18:53:58 +0800 (CST)
Subject: Re: [PATCH -next 2/3] md/raid10: convert resync_lock to use seqlock
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <20220829131502.165356-3-yukuai1@huaweicloud.com>
 <3d8859bc-80d6-08b0-fd40-8874df4d3419@linux.dev>
 <1891ec2c-0ccc-681e-31de-fdd28eebce82@huaweicloud.com>
 <82f11462-454c-4a5e-d3a2-e71479960eaf@linux.dev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <01191595-f2f7-d953-fb00-e24803910515@huaweicloud.com>
Date:   Fri, 2 Sep 2022 18:53:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <82f11462-454c-4a5e-d3a2-e71479960eaf@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgD3SXPE4BFjn3sRAQ--.17387S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1fuw1UWFyxWFW8Jw4xJFb_yoW8Xr1kpa
        1kXFWUtrWYyrnY9w4Dt3yvvasayw17ta1UXrZ3X3W7AFnFqr4Sqry5WrnFgFyDZrWkJ3Wj
        qFWUWa9xZF9xGFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/09/02 18:16, Guoqing Jiang 写道:
> 
> 
> On 9/2/22 6:02 PM, Yu Kuai wrote:
>> Hi,
>>
>> 在 2022/09/02 17:42, Guoqing Jiang 写道:
>>> Hi,
>>>
>>> On 8/29/22 9:15 PM, Yu Kuai wrote:
>>>> +static bool wait_barrier_nolock(struct r10conf *conf)
>>>> +{
>>>> +    unsigned int seq = raw_read_seqcount(&conf->resync_lock.seqcount);
>>>> +
>>>> +    if (seq & 1)
>>>> +        return false;
>>>> +
>>>> +    if (READ_ONCE(conf->barrier))
>>>> +        return false;
>>>> +
>>>> +    atomic_inc(&conf->nr_pending);
>>>> +    if (!read_seqcount_retry(&conf->resync_lock.seqcount, seq))
>>>
>>> I think 'seq' is usually get from read_seqcount_begin.
>>
>> read_seqcount_begin will loop untill "req & 1" failed, I'm afraid this
>> will cause high cpu usage in come cases.
>>
>> What I try to do here is just try once, and fall back to hold lock and
>> wait if failed.
> 
> Thanks for the explanation.
> 
> I'd suggest to try with read_seqcount_begin/read_seqcount_retry pattern
> because it is a common usage in kernel I think, then check whether the
> performance drops or not.  Maybe it is related to lockdep issue, but I am
> not sure.

I can try read_seqcount_begin/read_seqcount_retry.

Please take a look at another thread, lockdep issue is due to
inconsistent usage of lock and seqcount inside seqlock:

wait_event() only release lock, seqcount is not released.

Thansk,
Kuai
> 
> Thanks,
> Guoqing
> .
> 

