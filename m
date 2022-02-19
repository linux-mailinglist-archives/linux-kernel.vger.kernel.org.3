Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9644BC523
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 04:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241233AbiBSDDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 22:03:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbiBSDC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 22:02:59 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874B9109A76;
        Fri, 18 Feb 2022 19:02:38 -0800 (PST)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K0tcm53vwzdZMM;
        Sat, 19 Feb 2022 11:01:28 +0800 (CST)
Received: from [10.174.176.103] (10.174.176.103) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Sat, 19 Feb 2022 11:02:36 +0800
Message-ID: <52ed098e-db59-f20e-6536-bef48d473317@huawei.com>
Date:   Sat, 19 Feb 2022 11:02:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH -next v2] block: update io_ticks when io hang
From:   "zhangwensheng (E)" <zhangwensheng5@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220217064247.4041435-1-zhangwensheng5@huawei.com>
In-Reply-To: <20220217064247.4041435-1-zhangwensheng5@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.103]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping...

在 2022/2/17 14:42, Zhang Wensheng 写道:
> When the inflight IOs are slow and no new IOs are issued, we expect
> iostat could manifest the IO hang problem. However after
> commit 5b18b5a73760 ("block: delete part_round_stats and switch to less
> precise counting"), io_tick and time_in_queue will not be updated until
> the end of IO, and the avgqu-sz and %util columns of iostat will be zero.
>
> Because it has using stat.nsecs accumulation to express time_in_queue
> which is not suitable to change, and may %util will express the status
> better when io hang occur. To fix io_ticks, we use update_io_ticks and
> inflight to update io_ticks when diskstats_show and part_stat_show
> been called.
>
> Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
> ---
>   block/genhd.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> ---
> v2:
> * add part_stat_lock() & part_stat_unlock() to protect update_io_ticks().
> v1: https://www.spinics.net/lists/linux-block/msg78931.html
>
> diff --git a/block/genhd.c b/block/genhd.c
> index 626c8406f21a..781dc78f97d8 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -913,12 +913,17 @@ ssize_t part_stat_show(struct device *dev,
>   	struct disk_stats stat;
>   	unsigned int inflight;
>   
> -	part_stat_read_all(bdev, &stat);
>   	if (queue_is_mq(q))
>   		inflight = blk_mq_in_flight(q, bdev);
>   	else
>   		inflight = part_in_flight(bdev);
>   
> +	if (inflight) {
> +		part_stat_lock();
> +		update_io_ticks(bdev, jiffies, true);
> +		part_stat_unlock();
> +	}
> +	part_stat_read_all(bdev, &stat);
>   	return sprintf(buf,
>   		"%8lu %8lu %8llu %8u "
>   		"%8lu %8lu %8llu %8u "
> @@ -1174,12 +1179,17 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>   	xa_for_each(&gp->part_tbl, idx, hd) {
>   		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
>   			continue;
> -		part_stat_read_all(hd, &stat);
>   		if (queue_is_mq(gp->queue))
>   			inflight = blk_mq_in_flight(gp->queue, hd);
>   		else
>   			inflight = part_in_flight(hd);
>   
> +		if (inflight) {
> +			part_stat_lock();
> +			update_io_ticks(hd, jiffies, true);
> +			part_stat_unlock();
> +		}
> +		part_stat_read_all(hd, &stat);
>   		seq_printf(seqf, "%4d %7d %pg "
>   			   "%lu %lu %lu %u "
>   			   "%lu %lu %lu %u "
