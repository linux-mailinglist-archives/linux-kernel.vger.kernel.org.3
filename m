Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3F94F8F21
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiDHGzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiDHGzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:55:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04E731F29A;
        Thu,  7 Apr 2022 23:53:45 -0700 (PDT)
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KZTPl4ZsJzBrX0;
        Fri,  8 Apr 2022 14:49:31 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 14:53:44 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 14:53:43 +0800
Subject: Re: [PATCH] blk-mq: fix possible creation failure for 'debugfs_dir'
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.co>
References: <20220401035139.272897-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <0ad66cff-e679-5b41-055d-656b0b46805d@huawei.com>
Date:   Fri, 8 Apr 2022 14:53:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220401035139.272897-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

ÔÚ 2022/04/01 11:51, Yu Kuai Ð´µÀ:
> 'q->debugfs_dir' is created in blk_register_queue(), however, it's not
> removed in blk_unregister_queue() and is delayed to blk_release_queue().
> Thus it's possible that del_gendisk() is done and the old 'debugfs_dir'
> is not removed yet, and in the mean time blk_register_queue() is called
> for the new device with the same name. In this case, kernel will
> compalin about creation failure for 'debugfs_dir' like following:
> 
> debugfs: Directory 'nullb1' with parent 'block' already present!
> 
> Fix the problem by moving forward the removal of 'debgfs_dir' to
> blk_unregister_queue().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-sysfs.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 88bd41d4cb59..15fc3f0786e3 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -779,11 +779,6 @@ static void blk_release_queue(struct kobject *kobj)
>   	if (queue_is_mq(q))
>   		blk_mq_release(q);
>   
> -	blk_trace_shutdown(q);
> -	mutex_lock(&q->debugfs_mutex);
> -	debugfs_remove_recursive(q->debugfs_dir);
> -	mutex_unlock(&q->debugfs_mutex);
> -
>   	if (queue_is_mq(q))
>   		blk_mq_debugfs_unregister(q);
>   
> @@ -951,5 +946,11 @@ void blk_unregister_queue(struct gendisk *disk)
>   
>   	mutex_unlock(&q->sysfs_dir_lock);
>   
> +	blk_trace_shutdown(q);
> +	mutex_lock(&q->debugfs_mutex);
> +	blk_mq_debugfs_unregister_hctxs(q);
> +	debugfs_remove_recursive(q->debugfs_dir);
> +	mutex_unlock(&q->debugfs_mutex);
> +
>   	kobject_put(&disk_to_dev(disk)->kobj);
>   }
> 
