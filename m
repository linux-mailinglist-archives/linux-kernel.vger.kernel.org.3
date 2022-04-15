Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA75025FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350882AbiDOHKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiDOHKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:10:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E744E75C16;
        Fri, 15 Apr 2022 00:07:41 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KfnQd4hL0zFpyJ;
        Fri, 15 Apr 2022 15:05:13 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 15:07:39 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 15:07:38 +0800
Subject: Re: [PATCH -next RFC v2 3/8] sbitmap: make sure waitqueues are
 balanced
To:     "Li, Ming" <ming4.li@intel.com>, <axboe@kernel.dk>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <20220408073916.1428590-4-yukuai3@huawei.com>
 <b9f12710-25f4-3dff-4f9b-cfe0bc3097e2@intel.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <208a49d2-5f29-c48e-206c-260ee3f1d991@huawei.com>
Date:   Fri, 15 Apr 2022 15:07:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b9f12710-25f4-3dff-4f9b-cfe0bc3097e2@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/04/15 14:31, Li, Ming 写道:
> 
> 
> On 4/8/2022 3:39 PM, Yu Kuai wrote:
>> Currently, same waitqueue might be woken up continuously:
>>
>> __sbq_wake_up		__sbq_wake_up
>>   sbq_wake_ptr -> assume	0
>> 			 sbq_wake_ptr -> 0
>>   atomic_dec_return
>> 			atomic_dec_return
>>   atomic_cmpxchg -> succeed
>> 			 atomic_cmpxchg -> failed
>> 			  return true
>>
>> 			__sbq_wake_up
>> 			 sbq_wake_ptr
>> 			  atomic_read(&sbq->wake_index) -> still 0
>>   sbq_index_atomic_inc -> inc to 1
>> 			  if (waitqueue_active(&ws->wait))
>> 			   if (wake_index != atomic_read(&sbq->wake_index))
>> 			    atomic_set -> reset from 1 to 0
>>   wake_up_nr -> wake up first waitqueue
>> 			    // continue to wake up in first waitqueue
>>
>> What's worse, io hung is possible in theory because wake up might be
>> missed. For example, 2 * wake_batch tags are put, while only wake_batch
>> threads are worken:
>>
>> __sbq_wake_up
>>   atomic_cmpxchg -> reset wait_cnt
>> 			__sbq_wake_up -> decrease wait_cnt
>> 			...
>> 			__sbq_wake_up -> wait_cnt is decreased to 0 again
>> 			 atomic_cmpxchg
>> 			 sbq_index_atomic_inc -> increase wake_index
>> 			 wake_up_nr -> wake up and waitqueue might be empty
>>   sbq_index_atomic_inc -> increase again, one waitqueue is skipped
>>   wake_up_nr -> invalid wake up because old wakequeue might be empty
>>
>> To fix the problem, refactor to make sure waitqueues will be woken up
>> one by one, and also choose the next waitqueue by the number of threads
>> that are waiting to keep waitqueues balanced.
> Hi, do you think that updating wake_index before atomic_cmpxchg(ws->wait_cnt) also can solve these two problems?
> like this:
Hi,

The first problem is due to sbq_wake_ptr() is using atomic_set() to
update 'wake_index'.

The second problem is due to __sbq_wake_up() is updating 'wait_cnt'
before 'wait_index'.

> __sbq_wake_up()
> {
> 	....
> 	if (wait_cnt <= 0) {
> 		ret = atomic_cmpxchg(sbq->wake_index, old_wake_index, next_wake_index);
How is the 'next_wake_index' chosen? And the same in sbq_wake_ptr().
> 		if (ret == old_wake_index) {
> 			ret = atomic_cmpxchg(ws->wait_cnt, wait_cnt, wake_batch);

If this failed, just return true with 'wake_index' updated? Then the
caller will call this again, so it seems this can't prevent 'wake_index'
updated multiple times, and 'wait_cnt' in the old 'ws' is not updated.
> 			if (ret == wait_cnt)
> 				wake_up_nr(ws->wait, wake_batch);
> 		}
> 	}
> }
> 
> Your solution is picking the waitqueue with the largest waiters_cnt as the next one to be waked up, I think that waitqueue is possible to starve.
> if lots of threads in a same waitqueue stop waiting before sbq wakes them up, it will cause the waiters_cnt of waitqueue is much less than others, looks like sbq_update_wake_index() would never pick this waitqueue. What do you think? is it possible?

It will be possible if adding threads to waitqueues is not balanced, and
I suppose it's not possible after tag premmption is disabled. However,
instead of chosing the waitqueue with largest waiters_cnt, chosing the
next waitqueue with 'waiters_cnt > 0' might be alternative.

Thanks,
Kuai

