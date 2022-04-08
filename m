Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C085E4F97F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiDHO05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiDHO0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:26:54 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1749352E43;
        Fri,  8 Apr 2022 07:24:50 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id q19so7907578pgm.6;
        Fri, 08 Apr 2022 07:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6ODb0Vvt7yJSXTfd7/roxI6ds9SrXkY3UoyCBz1N6yg=;
        b=Yp0BemXTzFsiq0rCtVlZa3+FNCorzAkZmwvgY7xwS209zMwuAs/SGYeT9VHh/LMEc2
         3lSLTbGOuvF70Oly7/ZlyPEhfwIHpdbs1V1ZIO3AL6J9gcrvdWsxFrIkE6Z6htEuQdBY
         3UtP8UxYU3FjNyyOcvQjAkhix/1GCq5/R97X1Z84Y0R/uWp58VwCU3+ypOM/hoxV5aP4
         TqrKAgAcvBXRdHYS2E2X9woLtOe0aRFOyT15Emj58cN0YaNBty+NRjhsLQj/nI6ppwE+
         1HwJQxpvS7g0qUZ9yZX2vGSZPrJJI4KSdBp2XAUt6MejZdlMzc0VqiMRMugxhw9KaaAF
         zVhg==
X-Gm-Message-State: AOAM532I0P1jWzoZWqMRwnvOvGD/HmkrZjOI0Y2DHxo6xN4bsYGXqojx
        j74Yxah8JBOyCLhUizqBL1M=
X-Google-Smtp-Source: ABdhPJxTs6S4CtJPYyP8s02ZrwKd9mFCt4lTRL8yGczwwgM1zjya290zt205U2JZ6gZJJTcnRHO9vA==
X-Received: by 2002:a65:6a16:0:b0:39d:4f3:67e6 with SMTP id m22-20020a656a16000000b0039d04f367e6mr1835982pgu.84.1649427890298;
        Fri, 08 Apr 2022 07:24:50 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id j24-20020aa78d18000000b0050564584660sm6223983pfe.32.2022.04.08.07.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 07:24:49 -0700 (PDT)
Message-ID: <0dab5bd2-4f19-0b04-fa8c-6ed68b70c20e@acm.org>
Date:   Fri, 8 Apr 2022 07:24:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC v2 4/8] blk-mq: don't preempt tag under heavy
 load
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, axboe@kernel.dk,
        andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <20220408073916.1428590-5-yukuai3@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220408073916.1428590-5-yukuai3@huawei.com>
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
> The idle way to disable tag preemption is to track how many tags are

idle -> ideal?

> available, and wait directly in blk_mq_get_tag() if free tags are
> very little. However, this is out of reality because fast path is
> affected.
> 
> As 'ws_active' is only updated in slow path, this patch disable tag
> preemption if 'ws_active' is greater than 8, which means there are many
> threads waiting for tags already.
> 
> Once tag preemption is disabled, there is a situation that can cause
> performance degration(or io hung in extreme scenarios): the waitqueue

degration -> degradation?

> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 2615bd58bad3..b49b20e11350 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -156,6 +156,7 @@ struct blk_mq_alloc_data {
>   
>   	/* allocate multiple requests/tags in one go */
>   	unsigned int nr_tags;
> +	bool preemption;
>   	struct request **cached_rq;
>   

Please change "preemption" into "preempt".

Thanks,

Bart.

