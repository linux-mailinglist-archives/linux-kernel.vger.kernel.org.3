Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9481C5ABD5C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiICGHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiICGHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:07:09 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AFADC09A;
        Fri,  2 Sep 2022 23:07:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MKPQn1wFgzl3xd;
        Sat,  3 Sep 2022 14:05:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgAnenMH7xJjzRo3AQ--.49859S3;
        Sat, 03 Sep 2022 14:07:05 +0800 (CST)
Subject: Re: [PATCH -next 2/3] md/raid10: convert resync_lock to use seqlock
To:     Logan Gunthorpe <logang@deltatee.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <20220829131502.165356-3-yukuai1@huaweicloud.com>
 <04128618-962f-fd4e-64a9-09ecf7f83776@deltatee.com>
 <b87d0e03-ea92-4e79-f304-7d4c1cbf3fbf@huaweicloud.com>
 <3d07a8fd-3b5e-dc68-4c32-6c0dcd0c1264@huaweicloud.com>
 <04571bb7-10b3-e841-a975-d9b6e0305e8a@deltatee.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8dd81e04-0041-63a4-e16f-f92dd8c4930e@huaweicloud.com>
Date:   Sat, 3 Sep 2022 14:07:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <04571bb7-10b3-e841-a975-d9b6e0305e8a@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenMH7xJjzRo3AQ--.49859S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4fKF1rAF4DCr43KFW8Crg_yoWrXry8p3
        ySqr15tFWUtF90qw1Dta1j9F1Fgw4kKF9rGFZ5Wa1kZFsYqryfJFy3GryrKryqvr93AFy8
        Xa98GrZ3Gw1UtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
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

在 2022/09/03 1:03, Logan Gunthorpe 写道:
> 
> 
> 
> On 2022-09-02 02:14, Yu Kuai wrote:
>> Can you try the following patch? I'm running mdadm tests myself and I
>> didn't see any problems yet.
> 
> Yes, that patch seems to fix the issue.
> 
> However, may I suggest we do this without trying to introduce new
> helpers into wait.h? I suspect that could result in a fair amount of
> bike shedding and delay. wait_event_cmd() is often used in situations
> where a specific lock type doesn't have a helper.

Yes, that sounds good.
> 
> My stab at it is in a diff below which also fixes the bug.
> 
> I'd also recommend somebody clean up that nasty condition in
> wait_barrier(). Put it into an appropriately named function
> with some comments. As is, it is pretty much unreadable.

Now we're at it, I can take a look.

Thanks,
Kuai
> 
> Logan
> 
> --
> 
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 0e3229ee1ebc..ae297bc870bd 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -934,22 +934,26 @@ static void flush_pending_writes(struct r10conf *conf)
>    *    lower_barrier when the particular background IO completes.
>    */
>   
> +#define wait_event_barrier_cmd(conf, cond, cmd) \
> +	wait_event_cmd((conf)->wait_barrier, cond, \
> +		       write_sequnlock_irq(&(conf)->resync_lock); cmd, \
> +		       write_seqlock_irq(&(conf)->resync_lock))
> +#define wait_event_barrier(conf, cond) wait_event_barrier_cmd(conf, cond, )
> +
>   static void raise_barrier(struct r10conf *conf, int force)
>   {
>   	write_seqlock_irq(&conf->resync_lock);
>   	BUG_ON(force && !conf->barrier);
>   
>   	/* Wait until no block IO is waiting (unless 'force') */
> -	wait_event_lock_irq(conf->wait_barrier, force || !conf->nr_waiting,
> -			    conf->resync_lock.lock);
> +	wait_event_barrier(conf, force || !conf->nr_waiting);
>   
>   	/* block any new IO from starting */
>   	WRITE_ONCE(conf->barrier, conf->barrier + 1);
>   
>   	/* Now wait for all pending IO to complete */
> -	wait_event_lock_irq(conf->wait_barrier,
> -			    !atomic_read(&conf->nr_pending) && conf->barrier < RESYNC_DEPTH,
> -			    conf->resync_lock.lock);
> +	wait_event_barrier(conf, !atomic_read(&conf->nr_pending) &&
> +			   conf->barrier < RESYNC_DEPTH);
>   
>   	write_sequnlock_irq(&conf->resync_lock);
>   }
> @@ -1007,20 +1011,19 @@ static bool wait_barrier(struct r10conf *conf, bool nowait)
>   			ret = false;
>   		} else {
>   			raid10_log(conf->mddev, "wait barrier");
> -			wait_event_lock_irq(conf->wait_barrier,
> -					    !conf->barrier ||
> -					    (atomic_read(&conf->nr_pending) &&
> -					     bio_list &&
> -					     (!bio_list_empty(&bio_list[0]) ||
> -					      !bio_list_empty(&bio_list[1]))) ||
> +			wait_event_barrier(conf,
> +					   !conf->barrier ||
> +					   (atomic_read(&conf->nr_pending) &&
> +					    bio_list &&
> +					    (!bio_list_empty(&bio_list[0]) ||
> +					     !bio_list_empty(&bio_list[1]))) ||
>   					     /* move on if recovery thread is
>   					      * blocked by us
>   					      */
> -					     (conf->mddev->thread->tsk == current &&
> -					      test_bit(MD_RECOVERY_RUNNING,
> -						       &conf->mddev->recovery) &&
> -					      conf->nr_queued > 0),
> -					    conf->resync_lock.lock);
> +					    (conf->mddev->thread->tsk == current &&
> +					     test_bit(MD_RECOVERY_RUNNING,
> +					       &conf->mddev->recovery) &&
> +					     conf->nr_queued > 0));
>   		}
>   		conf->nr_waiting--;
>   		if (!conf->nr_waiting)
> @@ -1058,10 +1061,9 @@ static void freeze_array(struct r10conf *conf, int extra)
>   	conf->array_freeze_pending++;
>   	WRITE_ONCE(conf->barrier, conf->barrier + 1);
>   	conf->nr_waiting++;
> -	wait_event_lock_irq_cmd(conf->wait_barrier,
> -				atomic_read(&conf->nr_pending) == conf->nr_queued+extra,
> -				conf->resync_lock.lock,
> -				flush_pending_writes(conf));
> +	wait_event_barrier_cmd(conf,
> +		atomic_read(&conf->nr_pending) == conf->nr_queued+extra,
> +		flush_pending_writes(conf));
>   
>   	conf->array_freeze_pending--;
>   	write_sequnlock_irq(&conf->resync_lock);
> .
> 

