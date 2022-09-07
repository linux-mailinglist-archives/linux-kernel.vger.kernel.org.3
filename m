Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57E55AF95A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 03:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIGBMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 21:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIGBMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:12:44 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9020980364;
        Tue,  6 Sep 2022 18:12:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MMkhs3wQ5zKJ98;
        Wed,  7 Sep 2022 09:10:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXMG8Bdj5VXqAQ--.62488S3;
        Wed, 07 Sep 2022 09:12:40 +0800 (CST)
Subject: Re: [PATCH] sbitmap: fix possible io hung due to lost wakeup
To:     Keith Busch <kbusch@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, axboe@kernel.dk, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220803121504.212071-1-yukuai1@huaweicloud.com>
 <Yxe7V3yfBcADoYLE@kbusch-mbp.dhcp.thefacebook.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <496b87d9-c89d-3d4f-8ba8-5bb706de7fd0@huaweicloud.com>
Date:   Wed, 7 Sep 2022 09:12:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yxe7V3yfBcADoYLE@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXMG8Bdj5VXqAQ--.62488S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW7GFWUtrW5KFW8tr48tFb_yoW5CryDpr
        WUtF1vva1vvFWIywsrXr4jv34a939akrZ7Gr45Ka4kAr4agw42yr109rn8ury8Ars3X34r
        JF43trZxCa4UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/09/07 5:27, Keith Busch Ð´µÀ:
> On Wed, Aug 03, 2022 at 08:15:04PM +0800, Yu Kuai wrote:
>>   	wait_cnt = atomic_dec_return(&ws->wait_cnt);
>> -	if (wait_cnt <= 0) {
>> -		int ret;
>> +	/*
>> +	 * For concurrent callers of this, callers should call this function
>> +	 * again to wakeup a new batch on a different 'ws'.
>> +	 */
>> +	if (wait_cnt < 0 || !waitqueue_active(&ws->wait))
>> +		return true;
> 
> If wait_cnt is '0', but the waitqueue_active happens to be false due to racing
> with add_wait_queue(), this returns true so the caller will retry. The next
> atomic_dec will set the current waitstate wait_cnt < 0, which also forces an
> early return true. When does the wake up happen, or wait_cnt and wait_index get
> updated in that case?

If waitqueue becomes empty, then concurrent callers can go on:

__sbq_wake_up
  sbq_wake_ptr
   for (i = 0; i < SBQ_WAIT_QUEUES; i++)
    if (waitqueue_active(&ws->wait)) -> only choose the active waitqueue

If waitqueue is not empty, it is the same with or without this patch,
concurrent caller will have to wait for the one who wins the race:

Before:
  __sbq_wake_up
   atomic_cmpxchg -> win the race
   sbq_index_atomic_inc ->  concurrent callers can go

After:
  __sbq_wake_up
  wake_up_nr -> concurrent callers can go on if waitqueue become empty
  atomic_dec_return -> return 0
  sbq_index_atomic_inc

Thanks,
Kuai
>    
>> -		wake_batch = READ_ONCE(sbq->wake_batch);
>> +	if (wait_cnt > 0)
>> +		return false;
>>   
>> -		/*
>> -		 * Pairs with the memory barrier in sbitmap_queue_resize() to
>> -		 * ensure that we see the batch size update before the wait
>> -		 * count is reset.
>> -		 */
>> -		smp_mb__before_atomic();
>> +	wake_batch = READ_ONCE(sbq->wake_batch);
>>   
>> -		/*
>> -		 * For concurrent callers of this, the one that failed the
>> -		 * atomic_cmpxhcg() race should call this function again
>> -		 * to wakeup a new batch on a different 'ws'.
>> -		 */
>> -		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
>> -		if (ret == wait_cnt) {
>> -			sbq_index_atomic_inc(&sbq->wake_index);
>> -			wake_up_nr(&ws->wait, wake_batch);
>> -			return false;
>> -		}
>> +	/*
>> +	 * Wake up first in case that concurrent callers decrease wait_cnt
>> +	 * while waitqueue is empty.
>> +	 */
>> +	wake_up_nr(&ws->wait, wake_batch);
>>   
>> -		return true;
>> -	}
>> +	/*
>> +	 * Pairs with the memory barrier in sbitmap_queue_resize() to
>> +	 * ensure that we see the batch size update before the wait
>> +	 * count is reset.
>> +	 *
>> +	 * Also pairs with the implicit barrier between decrementing wait_cnt
>> +	 * and checking for waitqueue_active() to make sure waitqueue_active()
>> +	 * sees result of the wakeup if atomic_dec_return() has seen the result
>> +	 * of atomic_set().
>> +	 */
>> +	smp_mb__before_atomic();
>> +
>> +	/*
>> +	 * Increase wake_index before updating wait_cnt, otherwise concurrent
>> +	 * callers can see valid wait_cnt in old waitqueue, which can cause
>> +	 * invalid wakeup on the old waitqueue.
>> +	 */
>> +	sbq_index_atomic_inc(&sbq->wake_index);
>> +	atomic_set(&ws->wait_cnt, wake_batch);
>>   
>>   	return false;
>>   }
>> -- 
>> 2.31.1
>>
> .
> 

