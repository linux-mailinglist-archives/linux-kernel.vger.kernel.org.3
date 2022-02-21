Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2524BE6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352513AbiBUJzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:55:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352955AbiBUJsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:48:03 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E9513CCE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:21:47 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id x3so30510043qvd.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/zMMnHpU33a/fR4VbyyTa7iT756O176trm2NNe2YalE=;
        b=XWfdKjiBLSrYRHJ7/rGaFYqwg7r6A02RDtCHCx5hbmI+4V23kJ8KQsYDrmseKrg3Wb
         0WSn+/fpw+NOz3DEpldSRYkla5ClpTo7OntL08Pozd07RG4dC2p4cCgAbO/zDAJX785E
         hGBTzSPsFygKMFdTCMXaKlJnnB8IqUergCbK1vvab97FA30h3B2oqqBTleH/LctaJ/Eh
         cvBYqNpXqU3u3b956xaPiF/f/R0yhZSUXY2r7CszqMK7tdGq8PJ2oS0XZnBrYWxweoy5
         aBGa/ejbjVDRVNNTLFWFqSPKNHOTq3jlMwzL95M14bDa6bOAEyt1MJmC+qkvWmolNlex
         scEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/zMMnHpU33a/fR4VbyyTa7iT756O176trm2NNe2YalE=;
        b=0gTCmHjKe514wmiZyXFaOVvzuSJeVn8Ozezqc9FLhfiblcYF1ihVhZ8ixEwH9fpuvE
         /v+QV5IYrCuPiKz/OVacj54DDPvcBAGzz7yUtQO8zixN7+NyMl5bGXkKBZpiBTUvbbY0
         B/cp0uyAbgkf/LhFM8v4wW9YE4IjlmrUdepJ5Tjbw62msI9FNx3DcOU9ZUqoV9e1YOPx
         vw2c3W5w8AOZk2RbGQQGl8VBnicn91E8+9V1PmFekqMURnfn4AxV9/X36JnwBuzQcsmk
         0MumjLK2QwKDO0Hj8O8TY8gv/E5qa4y7QbcucJWBGHasWwI2A0f8tT/ZRCQW5eVlmSMB
         9SnA==
X-Gm-Message-State: AOAM533uY4p4Ng14/JCeiL6f9jsp9yVMaIKZUTmEesbrR4but/Uhh1y/
        /aT06aJFsTeJQ1Y69efUw896Fz1nbkrUQh/wgtg=
X-Google-Smtp-Source: ABdhPJz9jbEsluAZP7h5vwHMMRZOFdSZnFCjnNW3VeSP0WGX5JfWxc0E2hUYM0VvR0QJZEhhUDSdjqAZ7mD06DWDlE0=
X-Received: by 2002:a05:622a:19a2:b0:2de:600:a597 with SMTP id
 u34-20020a05622a19a200b002de0600a597mr6539456qtc.160.1645435306596; Mon, 21
 Feb 2022 01:21:46 -0800 (PST)
MIME-Version: 1.0
References: <1645174105-31224-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1645174105-31224-1-git-send-email-huangzhaoyang@gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 21 Feb 2022 17:21:18 +0800
Message-ID: <CAGWkznHS7AnManNUyytEZGxymFKi+MxOOq2vZe5U03W9YPdqww@mail.gmail.com>
Subject: Re: [RFC PATCH] block: set bdi congested when no tag available
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Feb 18, 2022 at 4:48 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> In previous version, block layer will set bdi to be congested when
> get_request fail, which may throttle direct_reclaim. Move them back
> under current design.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  block/blk-mq-tag.c      | 18 +++++++++++++++++-
>  include/linux/sbitmap.h |  1 +
>  lib/sbitmap.c           | 17 +++++++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 995336a..abb0685 100644
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
>         if (tag != BLK_MQ_NO_TAG)
>                 goto found_tag;
>
> -       if (data->flags & BLK_MQ_REQ_NOWAIT)
> +       if (data->flags & BLK_MQ_REQ_NOWAIT) {
> +               set_bdi_congested(data->q->disk->bdi,BLK_RW_SYNC);
> +               set_bdi_congested(data->q->disk->bdi,BLK_RW_ASYNC);
>                 return BLK_MQ_NO_TAG;
> +       }
>
>         ws = bt_wait_ptr(bt, data->hctx);
>         do {
> @@ -193,9 +197,21 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>         return tag + tag_offset;
>  }
>
> +static bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
> +{
> +       if (!tags)
> +               return true;
> +
> +       return sbitmap_any_bit_set(&tags->bitmap_tags.sb);
should be return sbitmap_any_bit_clear(&tags->bitmap_tags.sb)
> +}
> +
>  void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
>                     unsigned int tag)
>  {
> +       if (!blk_mq_has_free_tags(tags)) {
> +               clear_bdi_congested(ctx->queue->disk->bdi, BLK_RW_SYNC);
> +               clear_bdi_congested(ctx->queue->disk->bdi, BLK_RW_ASYNC);
> +       }
>         if (!blk_mq_tag_is_reserved(tags, tag)) {
>                 const int real_tag = tag - tags->nr_reserved_tags;
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
> +       unsigned int i;
> +
> +       for (i = 0; i < sb->map_nr; i++) {
> +               const struct sbitmap_word *word = &sb->map[i];
> +               unsigned long mask = word->word & ~word->cleared;
> +               unsigned long ret;
> +
> +               ret = find_first_zero_bit(&mask, word->depth);
> +               if (ret < word->depth)
> +                       return true;
> +       }
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(sbitmap_any_bit_clear);
> +
>  static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
>  {
>         unsigned int i, weight = 0;
> --
> 1.9.1
>
