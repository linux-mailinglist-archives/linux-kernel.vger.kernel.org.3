Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50F24F8F0C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiDHG4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiDHG4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:56:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE8432C213;
        Thu,  7 Apr 2022 23:54:27 -0700 (PDT)
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KZTVr4DLrz1HBfw;
        Fri,  8 Apr 2022 14:53:56 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 14:54:25 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 14:54:24 +0800
Subject: Re: [PATCH] blk-mq: add debugfs to print information for
 blk_mq_tag_set
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220401035319.274260-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <a7d35fc4-2ec5-7b64-4990-8a3a5bffa358@huawei.com>
Date:   Fri, 8 Apr 2022 14:54:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220401035319.274260-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping ...

ÔÚ 2022/04/01 11:53, Yu Kuai Ð´µÀ:
> This should be helpful to solve some problems.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-mq-debugfs.c | 54 ++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index aa0349e9f083..3c6260df7a95 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -183,12 +183,52 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
>   	return count;
>   }
>   
> +static void __flags_show(unsigned long flags, struct seq_file *m);
> +
> +static int queue_tag_set_show(void *data, struct seq_file *m)
> +{
> +	struct request_queue *q = data;
> +	struct blk_mq_tag_set *set = q->tag_set;
> +	int i, j;
> +
> +	seq_puts(m, "map:\n");
> +	for (i = 0; i < set->nr_maps; ++i) {
> +		struct blk_mq_queue_map *map = &set->map[i];
> +
> +		if (!map) {
> +			seq_puts(m, "    NULL\n");
> +			continue;
> +		}
> +
> +		seq_printf(m, "    nr_queues %u offset %u map:", map->nr_queues,
> +			   map->queue_offset);
> +		if (!map->mq_map) {
> +			seq_puts(m, " NULL\n");
> +			continue;
> +		}
> +		for (j = 0; j < nr_cpu_ids; ++j)
> +			seq_printf(m, " %u", map->mq_map[j]);
> +		seq_puts(m, "\n");
> +	}
> +
> +	seq_printf(m, "nr_hw_queues: %u\n", set->nr_hw_queues);
> +	seq_printf(m, "queue_depth: %u\n", set->queue_depth);
> +	seq_printf(m, "reserved_tags: %u\n", set->reserved_tags);
> +	seq_printf(m, "cmd_size: %u\n", set->cmd_size);
> +	seq_printf(m, "numa_node: %d\n", set->numa_node);
> +	seq_printf(m, "timeout: %u\n", set->timeout);
> +	__flags_show(set->flags, m);
> +
> +	return 0;
> +}
> +
>   static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
>   	{ "poll_stat", 0400, queue_poll_stat_show },
>   	{ "requeue_list", 0400, .seq_ops = &queue_requeue_list_seq_ops },
>   	{ "pm_only", 0600, queue_pm_only_show, NULL },
>   	{ "state", 0600, queue_state_show, queue_state_write },
>   	{ "zone_wlock", 0400, queue_zone_wlock_show, NULL },
> +	{ "tag_set", 0400, queue_tag_set_show, NULL },
>   	{ },
>   };
>   
> @@ -229,10 +269,9 @@ static const char *const hctx_flag_name[] = {
>   };
>   #undef HCTX_FLAG_NAME
>   
> -static int hctx_flags_show(void *data, struct seq_file *m)
> +static void __flags_show(unsigned long flags, struct seq_file *m)
>   {
> -	struct blk_mq_hw_ctx *hctx = data;
> -	const int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(hctx->flags);
> +	const int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(flags);
>   
>   	seq_puts(m, "alloc_policy=");
>   	if (alloc_policy < ARRAY_SIZE(alloc_policy_name) &&
> @@ -242,9 +281,16 @@ static int hctx_flags_show(void *data, struct seq_file *m)
>   		seq_printf(m, "%d", alloc_policy);
>   	seq_puts(m, " ");
>   	blk_flags_show(m,
> -		       hctx->flags ^ BLK_ALLOC_POLICY_TO_MQ_FLAG(alloc_policy),
> +		       flags ^ BLK_ALLOC_POLICY_TO_MQ_FLAG(alloc_policy),
>   		       hctx_flag_name, ARRAY_SIZE(hctx_flag_name));
>   	seq_puts(m, "\n");
> +}
> +
> +static int hctx_flags_show(void *data, struct seq_file *m)
> +{
> +	struct blk_mq_hw_ctx *hctx = data;
> +
> +	__flags_show(hctx->flags, m);
>   	return 0;
>   }
>   
> 
