Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B45F5918F6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 07:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiHMF7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 01:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMF7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 01:59:06 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3987B41D3F;
        Fri, 12 Aug 2022 22:59:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M4VFF5nbqzKJY5;
        Sat, 13 Aug 2022 13:57:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA3PfqjPfdi_zsfAQ--.8775S3;
        Sat, 13 Aug 2022 13:59:01 +0800 (CST)
Subject: Re: [PATCH] sbitmap: fix possible io hung due to lost wakeup
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, axboe@kernel.dk,
        osandov@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220803121504.212071-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d31edf9b-bae2-b1f0-b95b-743fd705ba25@huaweicloud.com>
Date:   Sat, 13 Aug 2022 13:58:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220803121504.212071-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3PfqjPfdi_zsfAQ--.8775S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF48Wr4DWw1fury3XryxKrg_yoW7Jr4kpr
        W3JF1vva9YyrWIywsrGr4jv3WF9w4vgrZrGr43Kw15Cr12qr1Ykr109r45ury8ArZ8W345
        tr13JFZ3CFyUJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
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

ÔÚ 2022/08/03 20:15, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> There are two problems can lead to lost wakeup:
> 
> 1) invalid wakeup on the wrong waitqueue:
> 
> For example, 2 * wake_batch tags are put, while only wake_batch threads
> are woken:
> 
> __sbq_wake_up
>   atomic_cmpxchg -> reset wait_cnt
> 			__sbq_wake_up -> decrease wait_cnt
> 			...
> 			__sbq_wake_up -> wait_cnt is decreased to 0 again
> 			 atomic_cmpxchg
> 			 sbq_index_atomic_inc -> increase wake_index
> 			 wake_up_nr -> wake up and waitqueue might be empty
>   sbq_index_atomic_inc -> increase again, one waitqueue is skipped
>   wake_up_nr -> invalid wake up because old wakequeue might be empty
> 
> To fix the problem, increasing 'wake_index' before resetting 'wait_cnt'.
> 
> 2) 'wait_cnt' can be decreased while waitqueue is empty
> 
> As pointed out by Jan Kara, following race is possible:
> 
> CPU1				CPU2
> __sbq_wake_up			 __sbq_wake_up
>   sbq_wake_ptr()			 sbq_wake_ptr() -> the same
>   wait_cnt = atomic_dec_return()
>   /* decreased to 0 */
>   sbq_index_atomic_inc()
>   /* move to next waitqueue */
>   atomic_set()
>   /* reset wait_cnt */
>   wake_up_nr()
>   /* wake up on the old waitqueue */
> 				 wait_cnt = atomic_dec_return()
> 				 /*
> 				  * decrease wait_cnt in the old
> 				  * waitqueue, while it can be
> 				  * empty.
> 				  */
> 
> Fix the problem by waking up before updating 'wake_index' and
> 'wait_cnt'.
> 
> With this patch, noted that 'wait_cnt' is still decreased in the old
> empty waitqueue, however, the wakeup is redirected to a active waitqueue,
> and the extra decrement on the old empty waitqueue is not handled.

friendly ping ...
> 
> Fixes: 88459642cba4 ("blk-mq: abstract tag allocation out into sbitmap library")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
> Changes in official version:
> - fix spelling mistake in comments
> - add review tag
> Changes in rfc v4:
>   - remove patch 1, which improve fairness with overhead
>   - merge patch2 and patch 3
> Changes in rfc v3:
>   - rename patch 2, and add some comments.
>   - add patch 3, which fixes a new issue pointed out by Jan Kara.
> Changes in rfc v2:
>   - split to spearate patches for different problem.
>   - add fix tag
> 
>   previous versions:
> rfc v1: https://lore.kernel.org/all/20220617141125.3024491-1-yukuai3@huawei.com/
> rfc v2: https://lore.kernel.org/all/20220619080309.1630027-1-yukuai3@huawei.com/
> rfc v3: https://lore.kernel.org/all/20220710042200.20936-1-yukuai1@huaweicloud.com/
> rfc v4: https://lore.kernel.org/all/20220723024122.2990436-1-yukuai1@huaweicloud.com/
>   lib/sbitmap.c | 55 ++++++++++++++++++++++++++++++---------------------
>   1 file changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 29eb0484215a..1aa55806f6a5 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -611,32 +611,43 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>   		return false;
>   
>   	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> -	if (wait_cnt <= 0) {
> -		int ret;
> +	/*
> +	 * For concurrent callers of this, callers should call this function
> +	 * again to wakeup a new batch on a different 'ws'.
> +	 */
> +	if (wait_cnt < 0 || !waitqueue_active(&ws->wait))
> +		return true;
>   
> -		wake_batch = READ_ONCE(sbq->wake_batch);
> +	if (wait_cnt > 0)
> +		return false;
>   
> -		/*
> -		 * Pairs with the memory barrier in sbitmap_queue_resize() to
> -		 * ensure that we see the batch size update before the wait
> -		 * count is reset.
> -		 */
> -		smp_mb__before_atomic();
> +	wake_batch = READ_ONCE(sbq->wake_batch);
>   
> -		/*
> -		 * For concurrent callers of this, the one that failed the
> -		 * atomic_cmpxhcg() race should call this function again
> -		 * to wakeup a new batch on a different 'ws'.
> -		 */
> -		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
> -		if (ret == wait_cnt) {
> -			sbq_index_atomic_inc(&sbq->wake_index);
> -			wake_up_nr(&ws->wait, wake_batch);
> -			return false;
> -		}
> +	/*
> +	 * Wake up first in case that concurrent callers decrease wait_cnt
> +	 * while waitqueue is empty.
> +	 */
> +	wake_up_nr(&ws->wait, wake_batch);
>   
> -		return true;
> -	}
> +	/*
> +	 * Pairs with the memory barrier in sbitmap_queue_resize() to
> +	 * ensure that we see the batch size update before the wait
> +	 * count is reset.
> +	 *
> +	 * Also pairs with the implicit barrier between decrementing wait_cnt
> +	 * and checking for waitqueue_active() to make sure waitqueue_active()
> +	 * sees result of the wakeup if atomic_dec_return() has seen the result
> +	 * of atomic_set().
> +	 */
> +	smp_mb__before_atomic();
> +
> +	/*
> +	 * Increase wake_index before updating wait_cnt, otherwise concurrent
> +	 * callers can see valid wait_cnt in old waitqueue, which can cause
> +	 * invalid wakeup on the old waitqueue.
> +	 */
> +	sbq_index_atomic_inc(&sbq->wake_index);
> +	atomic_set(&ws->wait_cnt, wake_batch);
>   
>   	return false;
>   }
> 

