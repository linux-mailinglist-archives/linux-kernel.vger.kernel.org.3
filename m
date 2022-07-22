Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3661F57DC11
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiGVIP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiGVIP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:15:56 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EF05007C;
        Fri, 22 Jul 2022 01:15:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK4HbEZ_1658477750;
Received: from 30.178.80.135(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VK4HbEZ_1658477750)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 16:15:51 +0800
Message-ID: <eb99b420-3e28-98c7-dacc-767d564661e2@linux.alibaba.com>
Date:   Fri, 22 Jul 2022 16:15:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH] blk-mq: avoid potential infinite loop in
 __blk_mq_alloc_request
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1658467343-55843-1-git-send-email-liusong@linux.alibaba.com>
 <Yto2sHfyiJITgYAn@infradead.org>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <Yto2sHfyiJITgYAn@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jul 22, 2022 at 01:22:23PM +0800, Liu Song wrote:
>> From: Liu Song <liusong@linux.alibaba.com>
>>
>> If "blk_mq_get_tag" returns BLK_MQ_NO_TAG because the value of
>> "tags->nr_reserved_tags" is 0, it will fall into an infinite loop in
>> "__blk_mq_alloc_requests", so borrow BLK_MQ_REQ_NOWAIT to exit the loop.
> That means the driver calling blk_mq_alloc_request has a bug, and
> we should not work round that in the low level tag allocation path.
>
> If we want to be nice we can add a WARN_ON before going all the way
> down into the tag allocator, something like:
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 92aae03103b74..d6c7e2ece025f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -520,6 +520,10 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
>   	struct request *rq;
>   	int ret;
>   
> +	if (WARN_ON_ONCE((flags & BLK_MQ_REQ_RESERVED) &&
> +			!q->tag_set->reserved_tags))
> +		return ERR_PTR(-EINVAL);
> +

Hi，

It is a reasonable approach to prevent abnormal alloc from going down,
but this is a very rare exception after all, and above modification is 
checked
every alloc request, which seems to be a bit excessive overhead.

After the rare exception occurs and fix it, the impact on the alloc 
request will be lower.

Thanks

>   	ret = blk_queue_enter(q, flags);
>   	if (ret)
>   		return ERR_PTR(ret);

