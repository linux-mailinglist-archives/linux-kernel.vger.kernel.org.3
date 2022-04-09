Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1824FA583
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 09:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbiDIHDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 03:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiDIHDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 03:03:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314B91D97E8;
        Sat,  9 Apr 2022 00:01:30 -0700 (PDT)
Received: from kwepemi100024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kb5b03CpLzgYTj;
        Sat,  9 Apr 2022 14:59:40 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100024.china.huawei.com (7.221.188.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 15:01:26 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 15:01:26 +0800
Subject: Re: [PATCH -next RFC v2 8/8] sbitmap: wake up the number of threads
 based on required tags
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <20220408073916.1428590-9-yukuai3@huawei.com>
 <6470d923-8fa5-cda1-e519-6f890cdcb00a@acm.org>
 <4c322eee-3ad9-812f-a341-aa5e91573912@huawei.com>
 <fc82d24f-51d8-5f8c-1a44-6c95da722f54@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <51aa71af-4c05-2991-5698-12014a4943d5@huawei.com>
Date:   Sat, 9 Apr 2022 15:01:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fc82d24f-51d8-5f8c-1a44-6c95da722f54@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/04/09 12:16, Bart Van Assche 写道:
> On 4/8/22 19:17, yukuai (C) wrote:
>> I think the reason to wake up 'wake_batch' waiters is to make sure
>> wakers will use up 'wake_batch' tags that is just freed, because each
>> wakers should aquire at least one tag. Thus I think if we can make sure
>> wakers will use up 'wake_batch' tags, it's ok to wake up less waiters.
> 
> Hmm ... I think it's up to you to (a) explain this behavior change in 
> detail in the commit message and (b) to prove that this behavior change 
> won't cause trouble (I guess this change will cause trouble).

Hi, Bart

Sorry that the commit message doesn't explain clearly.

There are only two situations that wakers will be less than 'wake_batch'
after this patch:

(a) some wakers will acquire multipul tags, as I mentioned above, this
is ok because wakers will use up 'wake_batch' tags.

(b) the total number of waiters is less than 'wake_batch', this is
problematic if tag preemption is disabled, because io concurrency will
be declined.(patch 5 should fix the problem)

For the race that new threads are waited after get_wake_nr() and before
wake_up_nr() in situation (b), I can't figure out how this can be
problematic, however, this can be optimized by triggering additional
wake up:

@@ -623,15 +623,17 @@ static unsigned int get_wake_nr(struct 
sbq_wait_state *ws, unsigned int nr_tags)
         spin_lock_irq(&ws->wait.lock);
         list_for_each_entry(entry, &ws->wait.head, entry) {
                 wait = container_of(entry, struct sbq_wait, wait);
-               if (nr_tags <= wait->nr_tags)
+               if (nr_tags <= wait->nr_tags) {
+                       nr_tags = 0;
                         break;
+               }

                 nr++;
                 nr_tags -= wait->nr_tags;
         }
         spin_unlock_irq(&ws->wait.lock);

-       return nr;
+       return nr + nr_tags;
  }

What do you think?

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> .
> 
