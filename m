Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D357E4C2142
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiBXBqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiBXBqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:46:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EAC141FC2;
        Wed, 23 Feb 2022 17:46:02 -0800 (PST)
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K3wDl2BGGzbbnh;
        Thu, 24 Feb 2022 09:24:39 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 09:29:10 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 09:29:10 +0800
Subject: Re: [PATCH RFC] blk-mq: fix potential uaf for 'queue_hw_ctx'
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220223112601.2902761-1-yukuai3@huawei.com>
 <YhZFITXtiL8Xaord@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <df32802a-7dfb-3e80-359a-206c2be6ebe5@huawei.com>
Date:   Thu, 24 Feb 2022 09:29:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YhZFITXtiL8Xaord@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
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

ÔÚ 2022/02/23 22:30, Ming Lei Ð´µÀ:
> On Wed, Feb 23, 2022 at 07:26:01PM +0800, Yu Kuai wrote:
>> blk_mq_realloc_hw_ctxs() will free the 'queue_hw_ctx'(e.g. undate
>> submit_queues through configfs for null_blk), while it might still be
>> used from other context(e.g. switch elevator to none):
>>
>> t1					t2
>> elevator_switch
>>   blk_mq_unquiesce_queue
>>    blk_mq_run_hw_queues
>>     queue_for_each_hw_ctx
>>      // assembly code for hctx = (q)->queue_hw_ctx[i]
>>      mov    0x48(%rbp),%rdx -> read old queue_hw_ctx
>>
>> 					__blk_mq_update_nr_hw_queues
>> 					 blk_mq_realloc_hw_ctxs
>> 					  hctxs = q->queue_hw_ctx
>> 					  q->queue_hw_ctx = new_hctxs
>> 					  kfree(hctxs)
>>      movslq %ebx,%rax
>>      mov    (%rdx,%rax,8),%rdi ->uaf
>>
> 
> Not only uaf on queue_hw_ctx, but also other similar issue on other
> structures, and I think the correct and easy fix is to quiesce request
> queue during updating nr_hw_queues, something like the following patch:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a05ce7725031..d8e7c3cce0dd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4467,8 +4467,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
>   		return;
>   
> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>   		blk_mq_freeze_queue(q);
> +		blk_mq_quiesce_queue(q);
> +	}
>   	/*
>   	 * Switch IO scheduler to 'none', cleaning up the data associated
>   	 * with the previous scheduler. We will switch back once we are done
> @@ -4518,8 +4520,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   	list_for_each_entry(q, &set->tag_list, tag_set_list)
>   		blk_mq_elv_switch_back(&head, q);
>   
> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		blk_mq_unquiesce_queue(q);
>   		blk_mq_unfreeze_queue(q);
> +	}
>   }
>   
>   void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
Hi, Ming

If blk_mq_quiesce_queue() is called from __blk_mq_update_nr_hw_queues()
first, and then swithing elevator to none won't trigger the problem. 
However, what if blk_mq_unquiesce_queue() from switching elevator
decrease quiesce_depth to 0 first, and then blk_mq_quiesce_queue() is
called from __blk_mq_update_nr_hw_queues(), it seems to me such
concurrent scenarios still exist.

Thanks,
Kuai
> 
> 
> 
> Thanks,
> Ming
> 
> .
> 
