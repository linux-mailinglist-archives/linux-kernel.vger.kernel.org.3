Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB452593D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376296AbiEMBIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353559AbiEMBIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:08:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B601A28D4FF;
        Thu, 12 May 2022 18:08:17 -0700 (PDT)
Received: from kwepemi100003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kzr9F290ZzgYtM;
        Fri, 13 May 2022 09:07:45 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100003.china.huawei.com (7.221.188.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 09:08:15 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 09:08:14 +0800
Subject: Re: [PATCH -next 2/2] block, bfq: make bfq_has_work() more accurate
To:     Jan Kara <jack@suse.cz>
CC:     <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220510131629.1964415-1-yukuai3@huawei.com>
 <20220510131629.1964415-3-yukuai3@huawei.com>
 <20220511140832.w6eqphw5uepre5ws@quack3.lan>
 <67425a7b-f9e1-d7a9-9ec8-158f9f8ce13e@huawei.com>
 <20220512171025.blstxod6aphulctm@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <ef85c1de-21d3-e528-da79-351bc93b9193@huawei.com>
Date:   Fri, 13 May 2022 09:08:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220512171025.blstxod6aphulctm@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/05/13 1:10, Jan Kara Ð´µÀ:
> On Thu 12-05-22 09:30:16, yukuai (C) wrote:
>> On 2022/05/11 22:08, Jan Kara wrote:
>>> On Tue 10-05-22 21:16:29, Yu Kuai wrote:
>>>> bfq_has_work() is using busy_queues currently, which is not accurate
>>>> because bfq_queue is busy doesn't represent that it has requests. Since
>>>> bfqd aready has a counter 'queued' to record how many requests are in
>>>> bfq, use it instead of busy_queues.
>>>>
>>>> Noted that bfq_has_work() can be called with 'bfqd->lock' held, thus the
>>>> lock can't be held in bfq_has_work() to protect 'bfqd->queued'.
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>
>>> So did you find this causing any real problem? Because bfq queue is
>>> accounted among busy queues once bfq_add_bfqq_busy() is called. And that
>>> happens once a new request is inserted into the queue so it should be very
>>> similar to bfqd->queued.
>>>
>>> 								Honza
>>
>> Hi,
>>
>> The related problem is described here:
>>
>> https://lore.kernel.org/all/20220510112302.1215092-1-yukuai3@huawei.com/
>>
>> The root cause of the panic is a linux-block problem, however, it can
>> be bypassed if bfq_has_work() is accurate. On the other hand,
>> unnecessary run_work will be triggered if bfqq stays busy:
>>
>> __blk_mq_run_hw_queue
>>   __blk_mq_sched_dispatch_requests
>>    __blk_mq_do_dispatch_sched
>>     if (!bfq_has_work())
>>      break;
>>     blk_mq_delay_run_hw_queues -> run again after 3ms
> 
> Ah, I see. So it is the other way around than I thought. Due to idling
> bfq_tot_busy_queues() can be greater than 0 even if there are no requests
> to dispatch. Indeed. OK, the patch makes sense. But please use WRITE_ONCE
> for the updates of bfqd->queued. Otherwise the READ_ONCE does not really
> make sense (it can still result in some bogus value due to compiler
> optimizations on the write side).

Thanks for you adivce, I'll send a new version.

Kuai
