Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA64B49A0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1847074AbiAXXS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585996AbiAXWZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:25:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F30DC08C5DA;
        Mon, 24 Jan 2022 12:54:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id j23so53695316edp.5;
        Mon, 24 Jan 2022 12:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dq82rTxhxBvlr65w2A2LxY6QpISYac4cCUON/cmECxM=;
        b=BKwlTzCftZwPf6j/zl1A5IP6JA/uv6iAJ245F7MdeRr53EcaA58eHLhNWC2fEK4KE/
         aa7mm4s9YlBHAb2/gxhtizia/ONBaQHnhqZts6FCR+S3k0ZwLd/STZR0P37Eevplq/PY
         xK3knjKKrSAxGkbWH6ZiECl4cDe0TIh1LV9boZPVyVDrzm4bLPevoYNgWzV6osoPDMl6
         eBIeumWpiR56Bw6IHhndLVgqhaz2dzWqHvCfq1SD4nHJOOeneP/PWDHpwcqMIb6VH9Sb
         OAfAWnKxTtCxjg/umTgwEdIzyucc2fxMoPvsFfXqCFEYG759Bz12biGyXBY+p2BMgrQ7
         nzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dq82rTxhxBvlr65w2A2LxY6QpISYac4cCUON/cmECxM=;
        b=z9aSUCSBL0Ny5mXnvQxupA1yucyC6BA9AK9RlfTSlk9zIBzLMc7B59FHHcLfs25URZ
         p2kW+IlpOBUfW91XSvyfi9uPLioLZs9mDKMkvKmTQKnE6CbpsqU5HyEj4gsa+E9x2RH9
         pSwLxRDmFI+zs4JfLxOjFDYoooxVkwj3HiqBs1jf/0ITXpeLtPbn+rjBjUYLMJ0/Ob2H
         Yd4B9XMljbKbCnkOmlLaiySSIeKhzAJK7DitVgclt3a8jDu6ANreJMCbcOvAhx7UNnKi
         3CkBIpiqEZfX5zdBhRch0TjpimfE7RLUuoDGkprc9Nm4qdCYTm0v8r9VT+kbJkms9rVF
         wMlQ==
X-Gm-Message-State: AOAM533oMlygrh48Lq4v9y69y0X0LrTWwRu7Hko+POPRgiVyG2B6CxnR
        bkh28Ol3AoCpV6sEQTIwUQICO35qszSgJMuV7UE=
X-Google-Smtp-Source: ABdhPJxgCjB5sxN7wLpYS0l6Ot8/8MQ39XA1r1OciT5BGHQ3M7sM442yKV2s5PadWccZJTn6fI64HXfhnIWhErZiY/s=
X-Received: by 2002:a50:cf86:: with SMTP id h6mr17934469edk.82.1643057653792;
 Mon, 24 Jan 2022 12:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20200203053650.8923-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20200203053650.8923-1-xiyou.wangcong@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 24 Jan 2022 12:54:01 -0800
Message-ID: <CAHbLzkoUmhPbnt=yMfBSFs2G6r2S5ggD6AkYQvg0zxBAqQK2fA@mail.gmail.com>
Subject: Re: [Patch v3] block: introduce block_rq_error tracepoint
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I think the problems fixed by this patch still exist and we do need
this patch to make disk error handling in rasdaemon easier. I saw
Steven already gave his reviewed-by, I'm wondering why this patch was
not merged to upstream? I didn't see any unsolved comments.

If it looks fine, would Jens (I guess it should go with block tree)
please merge this patch upstream? The latest kernel moved
blk_update_request() to blk-mq.c, if it is ok to move forward, I could
prepare a new version.

Thanks,
Yang

On Sun, Feb 2, 2020 at 11:15 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> Currently, rasdaemon uses the existing tracepoint block_rq_complete
> and filters out non-error cases in order to capture block disk errors.
>
> But there are a few problems with this approach:
>
> 1. Even kernel trace filter could do the filtering work, there is
>    still some overhead after we enable this tracepoint.
>
> 2. The filter is merely based on errno, which does not align with kernel
>    logic to check the errors for print_req_error().
>
> 3. block_rq_complete only provides dev major and minor to identify
>    the block device, it is not convenient to use in user-space.
>
> So introduce a new tracepoint block_rq_error just for the error case
> and provides the device name for convenience too. With this patch,
> rasdaemon could switch to block_rq_error.
>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  block/blk-core.c             |  4 +++-
>  include/trace/events/block.h | 41 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 089e890ab208..0c7ad70d06be 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1450,8 +1450,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
>  #endif
>
>         if (unlikely(error && !blk_rq_is_passthrough(req) &&
> -                    !(req->rq_flags & RQF_QUIET)))
> +                    !(req->rq_flags & RQF_QUIET))) {
> +               trace_block_rq_error(req, blk_status_to_errno(error), nr_bytes);
>                 print_req_error(req, error, __func__);
> +       }
>
>         blk_account_io_completion(req, nr_bytes);
>
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 81b43f5bdf23..575054e7cfa0 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -145,6 +145,47 @@ TRACE_EVENT(block_rq_complete,
>                   __entry->nr_sector, __entry->error)
>  );
>
> +/**
> + * block_rq_error - block IO operation error reported by device driver
> + * @rq: block operations request
> + * @error: status code
> + * @nr_bytes: number of completed bytes
> + *
> + * The block_rq_error tracepoint event indicates that some portion
> + * of operation request has failed as reported by the device driver.
> + */
> +TRACE_EVENT(block_rq_error,
> +
> +       TP_PROTO(struct request *rq, int error, unsigned int nr_bytes),
> +
> +       TP_ARGS(rq, error, nr_bytes),
> +
> +       TP_STRUCT__entry(
> +               __field(  dev_t,        dev                     )
> +               __string( name,         rq->rq_disk ? rq->rq_disk->disk_name : "?")
> +               __field(  sector_t,     sector                  )
> +               __field(  unsigned int, nr_sector               )
> +               __field(  int,          error                   )
> +               __array(  char,         rwbs,   RWBS_LEN        )
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->dev       = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
> +               __assign_str(name,   rq->rq_disk ? rq->rq_disk->disk_name : "?");
> +               __entry->sector    = blk_rq_pos(rq);
> +               __entry->nr_sector = nr_bytes >> 9;
> +               __entry->error     = error;
> +
> +               blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);
> +       ),
> +
> +       TP_printk("%d,%d %s %s %llu + %u [%d]",
> +                 MAJOR(__entry->dev), MINOR(__entry->dev),
> +                 __get_str(name), __entry->rwbs,
> +                 (unsigned long long)__entry->sector,
> +                 __entry->nr_sector, __entry->error)
> +);
> +
>  DECLARE_EVENT_CLASS(block_rq,
>
>         TP_PROTO(struct request_queue *q, struct request *rq),
> --
> 2.21.1
>
