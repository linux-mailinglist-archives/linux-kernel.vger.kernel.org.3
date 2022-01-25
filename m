Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F1149B6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579984AbiAYOlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:41:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32802 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiAYOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:37:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25D99B8180E;
        Tue, 25 Jan 2022 14:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B83CC340E0;
        Tue, 25 Jan 2022 14:37:04 +0000 (UTC)
Date:   Tue, 25 Jan 2022 09:37:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [Patch v3] block: introduce block_rq_error tracepoint
Message-ID: <20220125093702.3ffdb721@gandalf.local.home>
In-Reply-To: <CAHbLzkoUmhPbnt=yMfBSFs2G6r2S5ggD6AkYQvg0zxBAqQK2fA@mail.gmail.com>
References: <20200203053650.8923-1-xiyou.wangcong@gmail.com>
        <CAHbLzkoUmhPbnt=yMfBSFs2G6r2S5ggD6AkYQvg0zxBAqQK2fA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 12:54:01 -0800
Yang Shi <shy828301@gmail.com> wrote:

> Hi folks,
> 
> I think the problems fixed by this patch still exist and we do need
> this patch to make disk error handling in rasdaemon easier. I saw
> Steven already gave his reviewed-by, I'm wondering why this patch was
> not merged to upstream? I didn't see any unsolved comments.

Maybe I did that prematurely, as I think I found a mistake in the tracing
below.

> 
> If it looks fine, would Jens (I guess it should go with block tree)
> please merge this patch upstream? The latest kernel moved
> blk_update_request() to blk-mq.c, if it is ok to move forward, I could
> prepare a new version.
> 
> Thanks,
> Yang
> 
> On Sun, Feb 2, 2020 at 11:15 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > Currently, rasdaemon uses the existing tracepoint block_rq_complete
> > and filters out non-error cases in order to capture block disk errors.
> >
> > But there are a few problems with this approach:
> >
> > 1. Even kernel trace filter could do the filtering work, there is
> >    still some overhead after we enable this tracepoint.
> >
> > 2. The filter is merely based on errno, which does not align with kernel
> >    logic to check the errors for print_req_error().
> >
> > 3. block_rq_complete only provides dev major and minor to identify
> >    the block device, it is not convenient to use in user-space.
> >
> > So introduce a new tracepoint block_rq_error just for the error case
> > and provides the device name for convenience too. With this patch,
> > rasdaemon could switch to block_rq_error.
> >
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > ---
> >  block/blk-core.c             |  4 +++-
> >  include/trace/events/block.h | 41 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 089e890ab208..0c7ad70d06be 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1450,8 +1450,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
> >  #endif
> >
> >         if (unlikely(error && !blk_rq_is_passthrough(req) &&
> > -                    !(req->rq_flags & RQF_QUIET)))
> > +                    !(req->rq_flags & RQF_QUIET))) {
> > +               trace_block_rq_error(req, blk_status_to_errno(error), nr_bytes);
> >                 print_req_error(req, error, __func__);
> > +       }
> >
> >         blk_account_io_completion(req, nr_bytes);
> >
> > diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> > index 81b43f5bdf23..575054e7cfa0 100644
> > --- a/include/trace/events/block.h
> > +++ b/include/trace/events/block.h
> > @@ -145,6 +145,47 @@ TRACE_EVENT(block_rq_complete,
> >                   __entry->nr_sector, __entry->error)
> >  );
> >
> > +/**
> > + * block_rq_error - block IO operation error reported by device driver
> > + * @rq: block operations request
> > + * @error: status code
> > + * @nr_bytes: number of completed bytes
> > + *
> > + * The block_rq_error tracepoint event indicates that some portion
> > + * of operation request has failed as reported by the device driver.
> > + */
> > +TRACE_EVENT(block_rq_error,
> > +
> > +       TP_PROTO(struct request *rq, int error, unsigned int nr_bytes),
> > +
> > +       TP_ARGS(rq, error, nr_bytes),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(  dev_t,        dev                     )
> > +               __string( name,         rq->rq_disk ? rq->rq_disk->disk_name : "?")
> > +               __field(  sector_t,     sector                  )
> > +               __field(  unsigned int, nr_sector               )
> > +               __field(  int,          error                   )
> > +               __array(  char,         rwbs,   RWBS_LEN        )

Why is the above not "__string" ?

> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->dev       = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
> > +               __assign_str(name,   rq->rq_disk ? rq->rq_disk->disk_name : "?");

__assign_str() will not work on an __array() type. It only works here
because you added it at the end, but it's just shear luck that it didn't
crash.

-- Steve


> > +               __entry->sector    = blk_rq_pos(rq);
> > +               __entry->nr_sector = nr_bytes >> 9;
> > +               __entry->error     = error;
> > +
> > +               blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);
> > +       ),
> > +
> > +       TP_printk("%d,%d %s %s %llu + %u [%d]",
> > +                 MAJOR(__entry->dev), MINOR(__entry->dev),
> > +                 __get_str(name), __entry->rwbs,
> > +                 (unsigned long long)__entry->sector,
> > +                 __entry->nr_sector, __entry->error)
> > +);
> > +
> >  DECLARE_EVENT_CLASS(block_rq,
> >
> >         TP_PROTO(struct request_queue *q, struct request *rq),
> > --
> > 2.21.1
> >  

