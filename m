Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB8B4F97E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiDHOWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbiDHOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:22:47 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D088352757;
        Fri,  8 Apr 2022 07:20:44 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id h19so8524357pfv.1;
        Fri, 08 Apr 2022 07:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=59y8Knnm/vo+DF9GRlYZP2tt3eWm5aI01xbVEtK4FKw=;
        b=6bqLueH0uxAM7KlwXt3UeA751KjQ+UUZr06bWXVhKl/hCbPhqHEtpzA9zD8woGG1ey
         FwVquK7UtD/8UfiE0IQzskso5t/EMZ6OTW8mh2fbOrmTTIQk1bzu0rWKvdVCtQHo2VPT
         hlfaSSZ3yDuCrWgqbeXWUAQFkq1E+JZeUoK3ckEgGrtagMHnAic3yA73ks8lY0bVP6N2
         fJy2tzZwn2FJJjlXfQwuMaQ3WCxx4HEaSRNASc9fJtUgXcb7HH033NZIJErr14IWAnJ6
         srcCxzDMYhc3e+dGKptlQilmbTxm6q1gKTAAxvSYIM2Uu6qpV46AfNFwp+eVeJdBXuz1
         AtaQ==
X-Gm-Message-State: AOAM5317bZODh+aE/bs2KuL91fpcuO/0iguo0tcDDlJcPLjfvNfk3PSE
        eEkTHGyZ8ZtmXw+k7R/JAlM=
X-Google-Smtp-Source: ABdhPJzZWMfIG402lALbShGS99uGAKZUQfqRqgaqZx31QtK9Qd/ymxMpyxANbS/x5lnbUscHq5QN2A==
X-Received: by 2002:a05:6a00:8c9:b0:4fe:ecc:9bcd with SMTP id s9-20020a056a0008c900b004fe0ecc9bcdmr19787517pfu.34.1649427643485;
        Fri, 08 Apr 2022 07:20:43 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id l22-20020a17090aaa9600b001ca7a005620sm11567002pjq.49.2022.04.08.07.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 07:20:42 -0700 (PDT)
Message-ID: <f6bcc53d-1419-7190-fd9a-8c5fa7178fe1@acm.org>
Date:   Fri, 8 Apr 2022 07:20:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC v2 2/8] blk-mq: call 'bt_wait_ptr()' later in
 blk_mq_get_tag()
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, axboe@kernel.dk,
        andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <20220408073916.1428590-3-yukuai3@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220408073916.1428590-3-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 00:39, Yu Kuai wrote:
> bt_wait_ptr() will increase 'wait_index', however, if blk_mq_get_tag()
> get a tag successfully after bt_wait_ptr() is called and before
> sbitmap_prepare_to_wait() is called, then the 'ws' is skipped. This
> behavior might cause 8 waitqueues to be unbalanced.
> 
> Move bt_wait_ptr() later should reduce the problem when the disk is
> under high io preesure.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-mq-tag.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 68ac23d0b640..228a0001694f 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -155,7 +155,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>   	if (data->flags & BLK_MQ_REQ_NOWAIT)
>   		return BLK_MQ_NO_TAG;
>   
> -	ws = bt_wait_ptr(bt, data->hctx);
>   	do {
>   		struct sbitmap_queue *bt_prev;
>   
> @@ -174,6 +173,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>   		if (tag != BLK_MQ_NO_TAG)
>   			break;
>   
> +		ws = bt_wait_ptr(bt, data->hctx);
>   		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
>   
>   		tag = __blk_mq_get_tag(data, bt);
> @@ -201,8 +201,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>   		 */
>   		if (bt != bt_prev)
>   			sbitmap_queue_wake_up(bt_prev);
> -
> -		ws = bt_wait_ptr(bt, data->hctx);
>   	} while (1);

Is it necessary to call bt_wait_ptr() during every loop iteration or 
only if bt != bt_prev? Would calling bt_wait_ptr() only if bt != bt_prev 
help to reduce unfairness further?

Thanks,

Bart.
