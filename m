Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2185A47C02C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhLUMzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:55:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4313 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbhLUMzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:55:49 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JJGbM2jPCz67Vss;
        Tue, 21 Dec 2021 20:53:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 13:55:46 +0100
Received: from [10.195.32.222] (10.195.32.222) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 12:55:45 +0000
Subject: Re: [PATCH RFT] blk-mq: optimize queue tag busy iter for shared_tags
To:     Kashyap Desai <kashyap.desai@broadcom.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <sathya.prakash@broadcom.com>
References: <20211221123157.14052-1-kashyap.desai@broadcom.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e9174a89-b3a4-d737-c5a9-ff3969053479@huawei.com>
Date:   Tue, 21 Dec 2021 12:55:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211221123157.14052-1-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.32.222]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2021 12:31, Kashyap Desai wrote:

Hi Kashyap,

What kernel is this for? 5.17 or 5.16 + stable? Your intention is not 
clear to me.


> In [0], CPU usage for blk_mq_queue_tag_busy_iter() was optimized, but
> there are still periodic call of blk_mq_queue_tag_busy_iter() from
> below context. Below context is used for block layer timer to find out
> potential expired command (per request queue) which requires tag iteration
> almost every 5 seconds(defined BLK_MAX_TIMEOUT) for each request queue.
> 
> kthread
>          worker_thread
>          process_one_work
>          blk_mq_timeout_work
>          blk_mq_queue_tag_busy_iter
>          bt_iter
>          blk_mq_find_and_get_req
>          _raw_spin_lock_irqsave
>          native_queued_spin_lock_slowpath
> 
> Changes in this patch optimize extra iterations of tags in case of
> shared_tags. One iteration of shared_tags can give expected results for
> iterate function.
> 
> Setup -  AMD64 Gen-4.0 Server.
> 64 Virtual Drive created using 16 Nvme drives + mpi3mr driver (in
> shared_tags mode)
> 
> Test command -
> fio 64.fio --rw=randread --bs=4K --iodepth=32 --numjobs=2 --ioscheduler=mq-deadline --disk_util=0
> 
> Without this patch on 5.16.0-rc5, mpi3mr driver in shared_tags mode can
> give 4.0M IOPs vs expected to get ~6.0M.
> Snippet of perf top
> 
>    25.42%  [kernel]                               [k] native_queued_spin_lock_slowpath
>     3.95%  [kernel]                               [k] cpupri_set
>     2.05%  [kernel]                               [k] __blk_mq_get_driver_tag
>     1.67%  [kernel]                               [k] __rcu_read_unlock
>     1.63%  [kernel]                               [k] check_preemption_disabled
> 
> After applying this patch on 5.16.0-rc5, mpi3mr driver in shared_tags
> mode reach up to 5.8M IOPs.
> 
> Snippet of perf top
> 
>     7.95%  [kernel]                               [k] native_queued_spin_lock_slowpath
>     5.61%  [kernel]                               [k] cpupri_set
>     2.98%  [kernel]                               [k] acpi_processor_ffh_cstate_enter
>     2.49%  [kernel]                               [k] read_tsc
>     2.15%  [kernel]                               [k] check_preemption_disabled
> 
> 
> [0] https://lore.kernel.org/all/9b092ca49e9b5415772cd950a3c12584@mail.gmail.com/
> 
> 
> Cc: linux-block@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: john.garry@huawei.com
> Cc: ming.lei@redhat.com
> Cc: sathya.prakash@broadcom.com
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> ---
>   block/blk-mq-tag.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 995336abee33..3e0a8e79f966 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -253,7 +253,8 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	if (!rq)
>   		return true;
>   
> -	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
> +	if (rq->q == hctx->queue && (rq->mq_hctx == hctx ||
> +				blk_mq_is_shared_tags(hctx->flags)))
>   		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
>   	blk_mq_put_rq_ref(rq);
>   	return ret;
> @@ -484,6 +485,14 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>   		if (tags->nr_reserved_tags)
>   			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
>   		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
> +		
> +		/* In case of shared bitmap if shared_tags is allocated, it is not required
> +		 * to iterate all the hctx. Looping one hctx is good enough.
> +		 */
> +		if (blk_mq_is_shared_tags(hctx->flags)) {
> +			blk_queue_exit(q);
> +			return;

this looks like v5.16-rc6 code

> +		}
>   	}
>   	blk_queue_exit(q);
>   }
> 



Thanks,
John
