Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4548D3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiAMIqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:46:25 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16709 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiAMIqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:46:24 -0500
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JZHxZ2x6dzZf5J;
        Thu, 13 Jan 2022 16:42:42 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 13 Jan 2022 16:46:19 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 16:46:19 +0800
Subject: Re: [PATCH v6 2/2] block: cancel all throttled bios in del_gendisk()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <mkoutny@suse.com>, <paulmck@kernel.org>, <tj@kernel.org>,
        <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220110134758.2233758-1-yukuai3@huawei.com>
 <20220110134758.2233758-3-yukuai3@huawei.com> <Yd5FkuhYX9YcgQkZ@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <2221953d-be40-3433-d46c-f40acd044482@huawei.com>
Date:   Thu, 13 Jan 2022 16:46:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yd5FkuhYX9YcgQkZ@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

�� 2022/01/12 11:05, Ming Lei д��:
> Hello Yu Kuai,
> 
> On Mon, Jan 10, 2022 at 09:47:58PM +0800, Yu Kuai wrote:
>> Throttled bios can't be issued after del_gendisk() is done, thus
>> it's better to cancel them immediately rather than waiting for
>> throttle is done.
>>
>> For example, if user thread is throttled with low bps while it's
>> issuing large io, and the device is deleted. The user thread will
>> wait for a long time for io to return.
>>
>> Noted this patch is mainly from revertion of commit 32e3374304c7
>> ("blk-throttle: remove tg_drain_bios") and commit b77412372b68
>> ("blk-throttle: remove blk_throtl_drain").
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-throttle.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
>>   block/blk-throttle.h |  2 ++
>>   block/genhd.c        |  2 ++
>>   3 files changed, 81 insertions(+)
> 
> Just wondering why not take the built-in way in throtl_upgrade_state() for
> canceling throttled bios? Something like the following, then we can avoid
> to re-invent the wheel.
> 
>   block/blk-throttle.c | 38 +++++++++++++++++++++++++++++++-------
>   block/blk-throttle.h |  2 ++
>   block/genhd.c        |  3 +++
>   3 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index cf7e20804f1b..17e56b2e44c4 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1816,16 +1816,11 @@ static void throtl_upgrade_check(struct throtl_grp *tg)
>   		throtl_upgrade_state(tg->td);
>   }
>   
> -static void throtl_upgrade_state(struct throtl_data *td)
> +static void __throtl_cancel_bios(struct throtl_data *td)
>   {
>   	struct cgroup_subsys_state *pos_css;
>   	struct blkcg_gq *blkg;
>   
> -	throtl_log(&td->service_queue, "upgrade to max");
> -	td->limit_index = LIMIT_MAX;
> -	td->low_upgrade_time = jiffies;
> -	td->scale = 0;
> -	rcu_read_lock();
>   	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
>   		struct throtl_grp *tg = blkg_to_tg(blkg);
>   		struct throtl_service_queue *sq = &tg->service_queue;
> @@ -1834,12 +1829,41 @@ static void throtl_upgrade_state(struct throtl_data *td)
>   		throtl_select_dispatch(sq);
>   		throtl_schedule_next_dispatch(sq, true);
Hi, Ming Lei

I'm confused that how can bios be canceled here?
tg->iops and tg->bps stay untouched, how can throttled bios
dispatch?
>   	}
> -	rcu_read_unlock();
>   	throtl_select_dispatch(&td->service_queue);
>   	throtl_schedule_next_dispatch(&td->service_queue, true);
>   	queue_work(kthrotld_workqueue, &td->dispatch_work);
>   }
>   
> +void blk_throtl_cancel_bios(struct request_queue *q)
> +{
> +	struct cgroup_subsys_state *pos_css;
> +	struct blkcg_gq *blkg;
> +
> +	rcu_read_lock();
> +	spin_lock_irq(&q->queue_lock);
> +	__throtl_cancel_bios(q->td);
> +	spin_unlock_irq(&q->queue_lock);
> +	rcu_read_unlock();
> +
> +	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg)
> +		del_timer_sync(&blkg_to_tg(blkg)->service_queue.pending_timer);
> +	del_timer_sync(&q->td->service_queue.pending_timer);

By the way, I think delete timer will end up io hung here if there are
some bios still be throttled.

Thanks,
Kuai
> +
> +	throtl_shutdown_wq(q);
> +}
> +
> +static void throtl_upgrade_state(struct throtl_data *td)
> +{
> +	throtl_log(&td->service_queue, "upgrade to max");
> +	td->limit_index = LIMIT_MAX;
> +	td->low_upgrade_time = jiffies;
> +	td->scale = 0;
> +
> +	rcu_read_lock();
> +	__throtl_cancel_bios(td);
> +	rcu_read_unlock();
> +}
> +
>   static void throtl_downgrade_state(struct throtl_data *td)
>   {
>   	td->scale /= 2;
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index b23a9f3abb82..525ac607c518 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -162,11 +162,13 @@ static inline int blk_throtl_init(struct request_queue *q) { return 0; }
>   static inline void blk_throtl_exit(struct request_queue *q) { }
>   static inline void blk_throtl_register_queue(struct request_queue *q) { }
>   static inline bool blk_throtl_bio(struct bio *bio) { return false; }
> +static inline void blk_throtl_cancel_bios(struct request_queue *q) {}
>   #else /* CONFIG_BLK_DEV_THROTTLING */
>   int blk_throtl_init(struct request_queue *q);
>   void blk_throtl_exit(struct request_queue *q);
>   void blk_throtl_register_queue(struct request_queue *q);
>   bool __blk_throtl_bio(struct bio *bio);
> +void blk_throtl_cancel_bios(struct request_queue *q);
>   static inline bool blk_throtl_bio(struct bio *bio)
>   {
>   	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
> diff --git a/block/genhd.c b/block/genhd.c
> index 626c8406f21a..1395cbd8eacf 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -30,6 +30,7 @@
>   #include "blk.h"
>   #include "blk-mq-sched.h"
>   #include "blk-rq-qos.h"
> +#include "blk-throttle.h"
>   
>   static struct kobject *block_depr;
>   
> @@ -622,6 +623,8 @@ void del_gendisk(struct gendisk *disk)
>   
>   	blk_mq_freeze_queue_wait(q);
>   
> +	blk_throtl_cancel_bios(q);
> +
>   	rq_qos_exit(q);
>   	blk_sync_queue(q);
>   	blk_flush_integrity();
> 
> Thanks,
> Ming
> 
> .
> 
