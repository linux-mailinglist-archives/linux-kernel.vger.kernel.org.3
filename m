Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB57849BC8B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiAYT6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiAYT6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:58:25 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBE3C06173B;
        Tue, 25 Jan 2022 11:58:24 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w14so12348360edd.10;
        Tue, 25 Jan 2022 11:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqEkMlKlC7FnTLHx5Minz69eiY5CvMKlzfe3/dQEwDc=;
        b=lSvgKlqPn05vyHPzpZ9+feRBlr1Uwu76xo8cKzPrBNsnca6vbmtbnZGdbVfIecp+7P
         GTwsD4ZQKo4XsP0ciR1kTso4U8kR2sWPuucsqzPXkd78Uzym+oGx8PwWD2+p+wDc3nf3
         TrG+RP0lObnlfujrGCcsCMT2dHK8bAiIEnprXjWwCbtMooL9Tgbl9dOLjpOIMs9le9xu
         /vMSjPML7+BaPp0RQKWD50BH4tbeqc99JLqDQmQ7BMRAmKiO7AobWyPdDwOESPiDgLqD
         xtWWkSIiJ3fWtLk/DMVCoMFqsiaUxZKHNvAvokPw6cxL8xV+Vsf/RBhgO/h2/PyAN07V
         QemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqEkMlKlC7FnTLHx5Minz69eiY5CvMKlzfe3/dQEwDc=;
        b=0erlfRb33hwzlPmIHutDVCtyPWQwdcshudhpIzFmnM1vlESiSLcHZVlDXJLQJvXXB+
         4ng79379FxA8WCOLrnA0G/b/Z7iRJDHFoYJfgGuYRXVtKBGAwhg+N8fvAWFUeTUmgA4T
         U3Vxly/5M2hKeTcVTShGD3x9P4tr+FFsTkuthSoTuEqU6xYGisfz+pMmeomiw3mtSKUU
         L/p9UdhBMGBanbTWnkRdbffbmTr/J5/iJT/VFFt4yVkrq9kI7pI6RvXXVxq6Inm4nKhu
         j2k/naim4+LdxaVA9ZV8fP9gVYGQP+qeQmgcGV9y0F5B5FRETgYCMN++JclQtHli/864
         /zkQ==
X-Gm-Message-State: AOAM533ke4ZRdBPQbuL3soLrkW4iAN4I5i53gcFCFqlj38k2InKu/P7A
        W346ZUKyxoxwwB4FAIPGvkSVsyXSTRyvU2lre/4=
X-Google-Smtp-Source: ABdhPJwxxjiocU/x0+UBBiSzGnwxfP7/UHjogryOWokteUvX+qcCGNzs6qDS2LUVDs5aLOcdr9UAqyzqaszaUepAriM=
X-Received: by 2002:a05:6402:84c:: with SMTP id b12mr21392420edz.321.1643140702990;
 Tue, 25 Jan 2022 11:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20200203053650.8923-1-xiyou.wangcong@gmail.com>
 <CAHbLzkoUmhPbnt=yMfBSFs2G6r2S5ggD6AkYQvg0zxBAqQK2fA@mail.gmail.com>
 <20220125093702.3ffdb721@gandalf.local.home> <20220125093846.59826cad@gandalf.local.home>
In-Reply-To: <20220125093846.59826cad@gandalf.local.home>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 25 Jan 2022 11:58:10 -0800
Message-ID: <CAHbLzkq51-_Rxj0YyWR4qxQRzosvP2Tj6D52=OtCZUG_mydDBQ@mail.gmail.com>
Subject: Re: [Patch v3] block: introduce block_rq_error tracepoint
To:     Steven Rostedt <rostedt@goodmis.org>,
        shi yang <shy828301@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 6:38 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 25 Jan 2022 09:37:02 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > > +TRACE_EVENT(block_rq_error,
> > > > +
> > > > +       TP_PROTO(struct request *rq, int error, unsigned int nr_bytes),
> > > > +
> > > > +       TP_ARGS(rq, error, nr_bytes),
> > > > +
> > > > +       TP_STRUCT__entry(
> > > > +               __field(  dev_t,        dev                     )
> > > > +               __string( name,         rq->rq_disk ? rq->rq_disk->disk_name : "?")
> > > > +               __field(  sector_t,     sector                  )
> > > > +               __field(  unsigned int, nr_sector               )
> > > > +               __field(  int,          error                   )
> > > > +               __array(  char,         rwbs,   RWBS_LEN        )
> >
> > Why is the above not "__string" ?
> >
> > > > +       ),
> > > > +
> > > > +       TP_fast_assign(
> > > > +               __entry->dev       = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
> > > > +               __assign_str(name,   rq->rq_disk ? rq->rq_disk->disk_name : "?");
> >
> > __assign_str() will not work on an __array() type. It only works here
> > because you added it at the end, but it's just shear luck that it didn't
> > crash.
>
> Never mind :-p  I see the above is for name which is __string, and the
> array is for rwbs which is filled below. I need to finish my first cup of
> coffee before reviewing patches.

Never mind. Other than the code restructure, I also found some data
structure (struct request) and function (blk_fill_rwbs) change. I
think I'd better rebase the patch to 5.17-rc1 then resubmit it. Since
there is no fundamental change to the patch, can I keep your
reviewed-by tag?


>
> -- Steve
>
> >
> >
> > > > +               __entry->sector    = blk_rq_pos(rq);
> > > > +               __entry->nr_sector = nr_bytes >> 9;
> > > > +               __entry->error     = error;
> > > > +
> > > > +               blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);
> > > > +       ),
> > > > +
> > > > +       TP_printk("%d,%d %s %s %llu + %u [%d]",
> > > > +                 MAJOR(__entry->dev), MINOR(__entry->dev),
> > > > +                 __get_str(name), __entry->rwbs,
> > > > +                 (unsigned long long)__entry->sector,
> > > > +                 __entry->nr_sector, __entry->error)
> > > > +);
> > > > +
