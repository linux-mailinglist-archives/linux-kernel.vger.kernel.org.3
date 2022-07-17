Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54BC5776CA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiGQOtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiGQOtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:49:16 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BF66439;
        Sun, 17 Jul 2022 07:49:15 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id a15so9681683pjs.0;
        Sun, 17 Jul 2022 07:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MBqBRgrfgPQGc4/jdSwIFgnWOJuS+NlWZm/Y/rNo1tY=;
        b=AtWaRYWfkxg8hQctM5pMBpV4cIQbrMTg7OBzcjNIdIHriz4HxAcVF2W3kbSm7Z6qeo
         5rOKaHBTO91kQCg9KbcGDYhzaKlO4g8O8xdRlkVkoUkZqOsC4ly7Vrg6fEsY9chWN1g8
         Qs4kSsLcaSJXNndfAGUQDpZxy1rIDqkyCggwbjKfxWTnmht+nL0JHY1PTDfFojI4sE4j
         D4Rfirn6TXiphpBJWdIURH44eg58fFxs37rWHggY/i3fXTXi7DdN9LM0vudnfiCCGwJe
         KVMSnqh/2XXiYXpHqyXZ74n8+g/HC/bvV9Re06QhBGRzAxO1Drk+Lj83MVnZzK5g3JZ6
         vVFg==
X-Gm-Message-State: AJIora8dJ6rtQYHffiQxcxVy9iAn849g4RdBC/7Y+XP52iof+hMPG577
        ETDyEZoj8vLvJyd8IM4B44c=
X-Google-Smtp-Source: AGRyM1vKlS5JO91dnrQ13ldmYHdfA/q1yTYeHEWzfgJZ/HDGTDHezfDGiHirtSxHBdrdjdCBfqjKTw==
X-Received: by 2002:a17:903:24e:b0:16b:9fa2:41e5 with SMTP id j14-20020a170903024e00b0016b9fa241e5mr23860146plh.127.1658069354999;
        Sun, 17 Jul 2022 07:49:14 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902b59200b0016bcc35000asm7264431pls.302.2022.07.17.07.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 07:49:13 -0700 (PDT)
Message-ID: <d4efe597-94b0-5878-fb54-1c6deb915659@acm.org>
Date:   Sun, 17 Jul 2022 07:49:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] block: Add a NULL check in blk_mq_free_rqs()
Content-Language: en-US
To:     Gautam Menghani <gautammenghani201@gmail.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
References: <20220717102242.219424-1-gautammenghani201@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220717102242.219424-1-gautammenghani201@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/22 03:22, Gautam Menghani wrote:
> Syzbot reported a general protection fault in the function
> blk_mq_clear_rq_mapping() in the file block/blk-mq.c.
> The issue is that the variable drv_tags is NULL, and this
> originates from the struct blk_mq_tag_set. The dashboard link for this
> issue is :
> syzkaller.appspot.com/bug?id=c3ce4caa4fc58c156d4903984131cdfa38eee354
> 
> This patch fixes the above bug, but there is another syzbot bug which is
> related to this and getting triggered after the call to
> blk_mq_clear_rq_mapping(). As a result, I cannot determine if the issue
> is really solved. The link to other issue:
> syzkaller.appspot.com/bug?id=7643cea70f1d0ce15f5f4bc39488918837ad4233
> 
> Please provide feedback/suggestions on the same.
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>   block/blk-mq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 93d9d60980fb..c1dd1b78b95c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3092,7 +3092,8 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>   		}
>   	}
>   
> -	blk_mq_clear_rq_mapping(drv_tags, tags);
> +	if (drv_tags)
> +		blk_mq_clear_rq_mapping(drv_tags, tags);
>   
>   	while (!list_empty(&tags->page_list)) {
>   		page = list_first_entry(&tags->page_list, struct page, lru);

I don't see how drv_tags could be NULL without triggering a race 
condition. Please take a look at the nbd driver to see whether the root 
cause is perhaps in that driver instead of in the block layer core.

Thanks,

Bart.
