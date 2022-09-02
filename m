Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8855AABFE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiIBKCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbiIBKCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:02:12 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5679A9AD;
        Fri,  2 Sep 2022 03:02:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MJth93Yyjz6S93D;
        Fri,  2 Sep 2022 18:00:25 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgDHGXOe1BFjcdgPAQ--.13112S3;
        Fri, 02 Sep 2022 18:02:07 +0800 (CST)
Subject: Re: [PATCH -next 2/3] md/raid10: convert resync_lock to use seqlock
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <20220829131502.165356-3-yukuai1@huaweicloud.com>
 <3d8859bc-80d6-08b0-fd40-8874df4d3419@linux.dev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1891ec2c-0ccc-681e-31de-fdd28eebce82@huaweicloud.com>
Date:   Fri, 2 Sep 2022 18:02:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3d8859bc-80d6-08b0-fd40-8874df4d3419@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHGXOe1BFjcdgPAQ--.13112S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKF48Xw47Gw13Wr4fKw1xXwb_yoWfuwc_K3
        98Wr1DWFW5J3y7Kr1qgr42vr9rtr1jkr1jyan0yF15G3W5GFZ8Jr1rXa95Jr15Gr45Jrnx
        uryfua43t3WUujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
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

Hi,

在 2022/09/02 17:42, Guoqing Jiang 写道:
> Hi,
> 
> On 8/29/22 9:15 PM, Yu Kuai wrote:
>> +static bool wait_barrier_nolock(struct r10conf *conf)
>> +{
>> +    unsigned int seq = raw_read_seqcount(&conf->resync_lock.seqcount);
>> +
>> +    if (seq & 1)
>> +        return false;
>> +
>> +    if (READ_ONCE(conf->barrier))
>> +        return false;
>> +
>> +    atomic_inc(&conf->nr_pending);
>> +    if (!read_seqcount_retry(&conf->resync_lock.seqcount, seq))
> 
> I think 'seq' is usually get from read_seqcount_begin.

read_seqcount_begin will loop untill "req & 1" failed, I'm afraid this
will cause high cpu usage in come cases.

What I try to do here is just try once, and fall back to hold lock and
wait if failed.

What do you think?

Thanks,
Kuai
> 
>> +        return true;
>> +
>> +    atomic_dec(&conf->nr_pending);
>> +    return false;
>> +
> 
> Thanks,
> Guoqing
> .
> 

