Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6664D2E70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiCILv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiCILvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:51:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65466D877
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:50:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 994151F380;
        Wed,  9 Mar 2022 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646826625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77/+4d7X0PUMZCE3w8amPXaBw2DrEeoYDC06UAyXeKU=;
        b=CqsKO/xrGdQxpe2iyQLbHbNsR5AWhoMafdA+R54uivRMJ3SDy3TLp0Eyeon3oAOICDx4sf
        DupATaIvbPi2CboKU7n/XKuywz4lLorj1Vn8TFId3hldYSk2pYUYPs0OQpRbMUL0DpdmuR
        LpFfSOhehO22hexdMnAOLB8SlmJ+s90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646826625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77/+4d7X0PUMZCE3w8amPXaBw2DrEeoYDC06UAyXeKU=;
        b=P9GjjwBgPBZ2xo5B6XeZ3CK8NKIq9Uouz+XaBC9zshFw3IfyVpdsFzU6855TxEhDShGggu
        rFc+/1ZcjgH2IwBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73A5613D7A;
        Wed,  9 Mar 2022 11:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F/SgG4GUKGJpbwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 09 Mar 2022 11:50:25 +0000
Message-ID: <6862cdff-189e-619b-3c87-7dce6b45475f@suse.cz>
Date:   Wed, 9 Mar 2022 12:50:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH] block: set bdi congested when no tag available
Content-Language: en-US
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
References: <1645174105-31224-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznFRps1P21Oggx0y+6B4svs2FFe7LS0W-N9EcpeToMtJ=g@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAGWkznFRps1P21Oggx0y+6B4svs2FFe7LS0W-N9EcpeToMtJ=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 08:40, Zhaoyang Huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> In previous version, block layer will set bdi to be congested when
> get_request fail, which may throttle direct_reclaim. Move them back
> under current blk-mq design.

Hm I thought Mel removed the direct reclaim throttling based on bdi
congestion in his series [1]. Maybe block layers has other uses (I have no
idea), for tracking congestion, that should be mentioned instead?

[1]
https://lore.kernel.org/all/20211022144651.19914-1-mgorman@techsingularity.net/

> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  block/blk-mq-tag.c      | 18 +++++++++++++++++-
>  include/linux/sbitmap.h |  1 +
>  lib/sbitmap.c           | 17 +++++++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 995336a..bd1e520 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -11,6 +11,7 @@
> 
>  #include <linux/blk-mq.h>
>  #include <linux/delay.h>
> +#include <linux/backing-dev.h>
>  #include "blk.h"
>  #include "blk-mq.h"
>  #include "blk-mq-sched.h"
> @@ -126,8 +127,11 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>   if (tag != BLK_MQ_NO_TAG)
>   goto found_tag;
> 
> - if (data->flags & BLK_MQ_REQ_NOWAIT)
> + if (data->flags & BLK_MQ_REQ_NOWAIT) {
> + set_bdi_congested(data->q->disk->bdi,BLK_RW_SYNC);
> + set_bdi_congested(data->q->disk->bdi,BLK_RW_ASYNC);
>   return BLK_MQ_NO_TAG;
> + }
> 
>   ws = bt_wait_ptr(bt, data->hctx);
>   do {
> @@ -193,9 +197,21 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>   return tag + tag_offset;
>  }
> 
> +static bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
> +{
> + if (!tags)
> + return true;
> +
> + return sbitmap_any_bit_clear(&tags->bitmap_tags.sb);
> +}
> +
>  void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
>       unsigned int tag)
>  {
> + if (!blk_mq_has_free_tags(tags)) {
> + clear_bdi_congested(ctx->queue->disk->bdi, BLK_RW_SYNC);
> + clear_bdi_congested(ctx->queue->disk->bdi, BLK_RW_ASYNC);
> + }
>   if (!blk_mq_tag_is_reserved(tags, tag)) {
>   const int real_tag = tag - tags->nr_reserved_tags;
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 4a6ff27..30a5553 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -210,6 +210,7 @@ static inline void sbitmap_free(struct sbitmap *sb)
>   * Return: true if any bit in the bitmap is set, false otherwise.
>   */
>  bool sbitmap_any_bit_set(const struct sbitmap *sb);
> +bool sbitmap_any_bit_clear(const struct sbitmap *sb);
> 
>  #define SB_NR_TO_INDEX(sb, bitnr) ((bitnr) >> (sb)->shift)
>  #define SB_NR_TO_BIT(sb, bitnr) ((bitnr) & ((1U << (sb)->shift) - 1U))
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 2709ab8..baa30d8 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -309,6 +309,23 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb)
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_any_bit_set);
> 
> +bool sbitmap_any_bit_clear(const struct sbitmap *sb)
> +{
> + unsigned int i;
> +
> + for (i = 0; i < sb->map_nr; i++) {
> + const struct sbitmap_word *word = &sb->map[i];
> + unsigned long mask = word->word & ~word->cleared;
> + unsigned long ret;
> +
> + ret = find_first_zero_bit(&mask, word->depth);
> + if (ret < word->depth)
> + return true;
> + }
> + return false;
> +}
> +EXPORT_SYMBOL_GPL(sbitmap_any_bit_clear);
> +
>  static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
>  {
>   unsigned int i, weight = 0;

