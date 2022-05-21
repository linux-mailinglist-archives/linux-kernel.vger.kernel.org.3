Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5ED52F812
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354457AbiEUDdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241133AbiEUDdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:33:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D513185C9B;
        Fri, 20 May 2022 20:33:15 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L4q0f4M26zhYQn;
        Sat, 21 May 2022 11:32:34 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 11:33:13 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 11:33:12 +0800
Subject: Re: [PATCH -next v2] blk-mq: fix panic during blk_mq_run_work_fn()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220520032542.3331610-1-yukuai3@huawei.com>
 <YocOsw6n3y11lNym@T590> <2b7a82e0-1e33-e2ff-74d7-d80f152fdc75@huawei.com>
 <afe9dec4-733d-88e9-850d-5c36e9201119@huawei.com> <YodSlSm/sIC8G2iG@T590>
 <dbe2deec-b007-470f-eb5a-35fae63ad134@huawei.com> <YodlGOo7vrUa7DZK@T590>
 <0e7967de-0c32-790d-fa08-b0bc9ef5923d@huawei.com> <Yod93DOdYosa+SvS@T590>
 <8e6a806b-f42e-319b-e6c8-de1f07befce2@huawei.com> <YoeeEw4SFvWtXNRk@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <759cb032-ccb4-0d74-ad7f-e84c791fc0af@huawei.com>
Date:   Sat, 21 May 2022 11:33:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YoeeEw4SFvWtXNRk@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/05/20 21:56, Ming Lei 写道:
> On Fri, May 20, 2022 at 08:01:31PM +0800, yukuai (C) wrote:
>> 在 2022/05/20 19:39, Ming Lei 写道:
>>
>>>
>>> In short:
>>>
>>> 1) run queue can be in-progress during cleanup queue, or returns from
>>> cleanup queue; we drain it in both blk_cleanup_queue() and
>>> disk_release_mq(), see commit 2a19b28f7929 ("blk-mq: cancel blk-mq dispatch
>>> work in both blk_cleanup_queue and disk_release()")
>> I understand that, however, there is no garantee new 'hctx->run_work'
>> won't be queued after 'drain it', for this crash, I think this is how
> 
> No, run queue activity will be shutdown after both disk_release_mq()
> and blk_cleanup_queue() are done.
> 
> disk_release_mq() is called after all FS IOs are done, so there isn't
> any run queue from FS IO code path, either sync or async.
> 
> In blk_cleanup_queue(), we only focus on passthrough request, and
> passthrough request is always explicitly allocated & freed by
> its caller, so once queue is frozen, all sync dispatch activity
> for passthrough request has been done, then it is enough to just cancel
> dispatch work for avoiding any dispatch activity.
> 
Hi, Ming

Thanks for you explanation, it really help me understand the code
better.

In our test kernel, elevator_exit() is not called from
disk_release_mq(), that is the reason I thought differently about
root cause...

> That is why both request queue and hctx can be released safely
> after the two are done.
> 
>> it triggered:
>>
>> assum that there is no io, while some bfq_queue is still busy:
>>
>> blk_cleanup_queue
>>   blk_freeze_queue
>>   blk_mq_cancel_work_sync
>>   cancel_delayed_work_sync(hctx1)
>> 				blk_mq_run_work_fn -> hctx2
>> 				 __blk_mq_run_hw_queue
>> 				  blk_mq_sched_dispatch_requests
>> 				   __blk_mq_do_dispatch_sched
>> 				    blk_mq_delay_run_hw_queues
>> 				     blk_mq_delay_run_hw_queue
>> 				      -> add hctx1->run_work again
>>   cancel_delayed_work_sync(hctx2)
> 
> Yes, even blk_mq_delay_run_hw_queues() can be called after all
> hctx->run_work are canceled since __blk_mq_run_hw_queue() could be
> running in sync io code path, not via ->run_work.
> 
> And my patch will fix the issue, won't it?

Yes, like I said before, your patch do make sense. It seems like
commit 28ce942fa2d5 ("block: move blk_exit_queue into disk_release")
is the real fix for the crash in out test.

Thanks,
Kuai
> 
> 
> Thanks,
> Ming
> 
> .
> 
