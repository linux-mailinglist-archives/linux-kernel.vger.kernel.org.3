Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A052E4EE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbiETGYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiETGYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:24:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF1F14C751;
        Thu, 19 May 2022 23:23:59 -0700 (PDT)
Received: from kwepemi100024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L4Gr72S9fzhZCv;
        Fri, 20 May 2022 14:23:19 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100024.china.huawei.com (7.221.188.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 14:23:56 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 14:23:56 +0800
Subject: Re: [PATCH -next v2] blk-mq: fix panic during blk_mq_run_work_fn()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220520032542.3331610-1-yukuai3@huawei.com>
 <YocOsw6n3y11lNym@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <2b7a82e0-1e33-e2ff-74d7-d80f152fdc75@huawei.com>
Date:   Fri, 20 May 2022 14:23:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YocOsw6n3y11lNym@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

ÔÚ 2022/05/20 11:44, Ming Lei Ð´µÀ:
> On Fri, May 20, 2022 at 11:25:42AM +0800, Yu Kuai wrote:
>> Our test report a following crash:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000018
>> PGD 0 P4D 0
>> Oops: 0000 [#1] SMP NOPTI
>> CPU: 6 PID: 265 Comm: kworker/6:1H Kdump: loaded Tainted: G           O      5.10.0-60.17.0.h43.eulerosv2r11.x86_64 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-20220320_160524-szxrtosci10000 04/01/2014
>> Workqueue: kblockd blk_mq_run_work_fn
>> RIP: 0010:blk_mq_delay_run_hw_queues+0xb6/0xe0
>> RSP: 0018:ffffacc6803d3d88 EFLAGS: 00010246
>> RAX: 0000000000000006 RBX: ffff99e2c3d25008 RCX: 00000000ffffffff
>> RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff99e2c911ae18
>> RBP: ffffacc6803d3dd8 R08: 0000000000000000 R09: ffff99e2c0901f6c
>> R10: 0000000000000018 R11: 0000000000000018 R12: ffff99e2c911ae18
>> R13: 0000000000000000 R14: 0000000000000003 R15: ffff99e2c911ae18
>> FS:  0000000000000000(0000) GS:ffff99e6bbf00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000018 CR3: 000000007460a006 CR4: 00000000003706e0
>> Call Trace:
>>   __blk_mq_do_dispatch_sched+0x2a7/0x2c0
>>   ? newidle_balance+0x23e/0x2f0
>>   __blk_mq_sched_dispatch_requests+0x13f/0x190
>>   blk_mq_sched_dispatch_requests+0x30/0x60
>>   __blk_mq_run_hw_queue+0x47/0xd0
>>   process_one_work+0x1b0/0x350
>>   worker_thread+0x49/0x300
>>   ? rescuer_thread+0x3a0/0x3a0
>>   kthread+0xfe/0x140
>>   ? kthread_park+0x90/0x90
>>   ret_from_fork+0x22/0x30
>>
>> After digging from vmcore, I found that the queue is cleaned
>> up(blk_cleanup_queue() is done) and tag set is
>> freed(blk_mq_free_tag_set() is done).
>>
>> There are two problems here:
>>
>> 1) blk_mq_delay_run_hw_queues() will only be called from
>> __blk_mq_do_dispatch_sched() if e->type->ops.has_work() return true.
>> This seems impossible because blk_cleanup_queue() is done, and there
>> should be no io. Commit ddc25c86b466 ("block, bfq: make bfq_has_work()
>> more accurate") fix the problem in bfq. And currently ohter schedulers
>> don't have such problem.
>>
>> 2) 'hctx->run_work' still exists after blk_cleanup_queue().
>> blk_mq_cancel_work_sync() is called from blk_cleanup_queue() to cancel
>> all the 'run_work'. However, there is no guarantee that new 'run_work'
>> won't be queued after that(and before blk_mq_exit_queue() is done).
> 
> It is blk_mq_run_hw_queue() caller's responsibility to grab
> ->q_usage_counter for avoiding queue cleaned up, so please fix the user
> side.
> 
Hi,

Thanks for your advice.

blk_mq_run_hw_queue() can be called async, in order to do that, what I
can think of is that grab 'q_usage_counte' before queuing 'run->work'
and release it after. Which is very similar to this patch...

Kuai
> 
> Thanks,
> Ming
> 
> .
> 
