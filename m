Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB2B54C40E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbiFOI7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbiFOI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:58:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568491EA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:58:36 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i29so17881688lfp.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJrquJD+yWQFne/J/19SMMhbGp5M+QEOAu37o1AhNAA=;
        b=WMRSrpMOmpoafabiWjDDIeuA3xMWBIcaqigjlUnHATSRayX90Bqze2kjD60E30r5pd
         Fwf8kaAe6PmfFCDXkGlBXXncuqVUdh9oaeW3jKkaXwT0MteMTgEbt3Q7LR8xEh8NPXvp
         ATKAGgQUfkQM6pxE0L3R6Fvq3u8vA2naFPwU8bcCb5ByHusZmGnBgVNEqAejeyAnQZZ5
         1Bqwg04omL41Lrz3qV7umt9105daiKLgCXxS8vdLTJmyJMh2e7gSetHC3MG6WNMLmmaz
         4G3KJYX9XT224Y5eTfLIx12rDgjIlhU0JVahKbiUy2g9FplxWReoIdmP7pyoKXuJTust
         OVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJrquJD+yWQFne/J/19SMMhbGp5M+QEOAu37o1AhNAA=;
        b=XtYLGEuBoBwbVDyDyftDFLc0I7DEBRYBSFTIRLpL1p1sXuG/mT090ChzzGMUngYYu1
         t6YTB6a+qJ1o6nNslhWPQRa7W7wZunwUSP1qT3MAA8Cun3pUrcBymaycR4eeTRKiRPpy
         whoP3FLQXiyPF2I+8XCJvDwtOTrYbOJXcIJeqEq4ER3Ju/C7pixiMOG4/c0faEae34GT
         eHYuL1Riq35TNlwu8RIzOeoaE3KOeGbLEpS8CnQ8EzvkOkd1EICvXB4x99rZV8V6/YIr
         OVUbhkhHHJA3wWMBY3F4vBgIyxorgHrd3qG/EB/THb0tuxYkhbkuKObu0bcF3zaL37CL
         kx/Q==
X-Gm-Message-State: AJIora9/Q1T1HL/g9AKDGI8K0oIrvwWuouRYFJyYhTE8TnoIXhJ1ESJd
        7kTtSj0muxwjKBfk4HsAN5CkDGYt6quFQW+cs+k=
X-Google-Smtp-Source: AGRyM1sGHf2L4J+YkwRxx2Bu8JTMes7eyyFHbYxOCnTYClF6Wl8rexsy5O+64SdUNWwSQJPN3HVFN/MEaxS0Jq4f2BA=
X-Received: by 2002:a05:6512:1050:b0:47d:c714:10ba with SMTP id
 c16-20020a056512105000b0047dc71410bamr5524327lfb.165.1655283513046; Wed, 15
 Jun 2022 01:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <1645174105-31224-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznFRps1P21Oggx0y+6B4svs2FFe7LS0W-N9EcpeToMtJ=g@mail.gmail.com> <6862cdff-189e-619b-3c87-7dce6b45475f@suse.cz>
In-Reply-To: <6862cdff-189e-619b-3c87-7dce6b45475f@suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 15 Jun 2022 16:58:03 +0800
Message-ID: <CAGWkznEtMQ67G5ebOsrDqVKdXcVZNHA6rLNz0B9jMODkABiSFQ@mail.gmail.com>
Subject: Re: [RFC PATCH] block: set bdi congested when no tag available
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 7:50 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 3/9/22 08:40, Zhaoyang Huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > In previous version, block layer will set bdi to be congested when
> > get_request fail, which may throttle direct_reclaim. Move them back
> > under current blk-mq design.
>
> Hm I thought Mel removed the direct reclaim throttling based on bdi
> congestion in his series [1]. Maybe block layers has other uses (I have no
> idea), for tracking congestion, that should be mentioned instead?
>
> [1]
> https://lore.kernel.org/all/20211022144651.19914-1-mgorman@techsingularity.net/
>
As my understanding, the above patch change suspending on bdi
congested for a given interval to be woken up by finish of request or
bio. This patch is not against above one, which add one more scenario
for setting bdi as congested.
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  block/blk-mq-tag.c      | 18 +++++++++++++++++-
> >  include/linux/sbitmap.h |  1 +
> >  lib/sbitmap.c           | 17 +++++++++++++++++
> >  3 files changed, 35 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 995336a..bd1e520 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -11,6 +11,7 @@
> >
> >  #include <linux/blk-mq.h>
> >  #include <linux/delay.h>
> > +#include <linux/backing-dev.h>
> >  #include "blk.h"
> >  #include "blk-mq.h"
> >  #include "blk-mq-sched.h"
> > @@ -126,8 +127,11 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
> >   if (tag != BLK_MQ_NO_TAG)
> >   goto found_tag;
> >
> > - if (data->flags & BLK_MQ_REQ_NOWAIT)
> > + if (data->flags & BLK_MQ_REQ_NOWAIT) {
> > + set_bdi_congested(data->q->disk->bdi,BLK_RW_SYNC);
> > + set_bdi_congested(data->q->disk->bdi,BLK_RW_ASYNC);
> >   return BLK_MQ_NO_TAG;
> > + }
> >
> >   ws = bt_wait_ptr(bt, data->hctx);
> >   do {
> > @@ -193,9 +197,21 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
> >   return tag + tag_offset;
> >  }
> >
> > +static bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
> > +{
> > + if (!tags)
> > + return true;
> > +
> > + return sbitmap_any_bit_clear(&tags->bitmap_tags.sb);
> > +}
> > +
> >  void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
> >       unsigned int tag)
> >  {
> > + if (!blk_mq_has_free_tags(tags)) {
> > + clear_bdi_congested(ctx->queue->disk->bdi, BLK_RW_SYNC);
> > + clear_bdi_congested(ctx->queue->disk->bdi, BLK_RW_ASYNC);
> > + }
> >   if (!blk_mq_tag_is_reserved(tags, tag)) {
> >   const int real_tag = tag - tags->nr_reserved_tags;
> >
> > diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> > index 4a6ff27..30a5553 100644
> > --- a/include/linux/sbitmap.h
> > +++ b/include/linux/sbitmap.h
> > @@ -210,6 +210,7 @@ static inline void sbitmap_free(struct sbitmap *sb)
> >   * Return: true if any bit in the bitmap is set, false otherwise.
> >   */
> >  bool sbitmap_any_bit_set(const struct sbitmap *sb);
> > +bool sbitmap_any_bit_clear(const struct sbitmap *sb);
> >
> >  #define SB_NR_TO_INDEX(sb, bitnr) ((bitnr) >> (sb)->shift)
> >  #define SB_NR_TO_BIT(sb, bitnr) ((bitnr) & ((1U << (sb)->shift) - 1U))
> > diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> > index 2709ab8..baa30d8 100644
> > --- a/lib/sbitmap.c
> > +++ b/lib/sbitmap.c
> > @@ -309,6 +309,23 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb)
> >  }
> >  EXPORT_SYMBOL_GPL(sbitmap_any_bit_set);
> >
> > +bool sbitmap_any_bit_clear(const struct sbitmap *sb)
> > +{
> > + unsigned int i;
> > +
> > + for (i = 0; i < sb->map_nr; i++) {
> > + const struct sbitmap_word *word = &sb->map[i];
> > + unsigned long mask = word->word & ~word->cleared;
> > + unsigned long ret;
> > +
> > + ret = find_first_zero_bit(&mask, word->depth);
> > + if (ret < word->depth)
> > + return true;
> > + }
> > + return false;
> > +}
> > +EXPORT_SYMBOL_GPL(sbitmap_any_bit_clear);
> > +
> >  static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
> >  {
> >   unsigned int i, weight = 0;
>
