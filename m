Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A849D1D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244189AbiAZSgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiAZSgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:36:12 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDDBC06161C;
        Wed, 26 Jan 2022 10:36:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a18so415861edj.7;
        Wed, 26 Jan 2022 10:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIv2lBySDQKuLdPHpVEfN5DTmOKpNIBBtz27Np5pjBs=;
        b=YEIlpKJ98MWEUJYL4CbgZhaiOFeTWJ3MJeooSJ4MIVj4L7eOFGHB2ukyAiGsaz47FX
         z7UvaoDQgwl0jkr/w9d+Lj5TNCHiAovaQWvH5hs0t4iYxygwLdbhT4vuug94xEvdsldk
         y+gJzkGt9Fz6yN1e1wkgNc9ZSbwkYuafvifedVVjwOSpK5fczlexTSrQjDSGWVC20gGM
         RmWk/2DXB+1Q3ygO+YoO2U/MuBiLG9bIBMfcmiv91702xVr4q9oI2rFZB4eTB6ZsWN7L
         0O5EEBiqYqnqdIc4N94/I+uoo32WKwicF9xKG5xxxwmwpTuhqwiwGE7paSAeFy2oOpxG
         JJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIv2lBySDQKuLdPHpVEfN5DTmOKpNIBBtz27Np5pjBs=;
        b=NyqOefL8DN1kCbs/y75sY+SYql0FT0tkwDOip9rgaHxOD08gqq9mVpG+HFMCe8nibL
         VfJ3noNdICuPKuPg4ga0kPX37PVkYKe4rPKPr4zemxbQgrjp5z+41O/x2nw0B06AwffV
         SS137cTayFsNSby9FUnOtv5x3kI9778gXslmubjsX/CI3I1egNrf0GfTi1tiLI7JsbKJ
         cJuGVmGRoP+B8y1GfuXy+Q2ZJfVZQQEj29wPjXDvdLEmpMetSQFn2p/GlBcOivWaGpF7
         0+KEv0Hp1BQI7A+Ehzq7zIz6meLqHKbFSFYa8S38YbBv9dgTnhkT+TF9silh/YTlNhBg
         wS+g==
X-Gm-Message-State: AOAM533tY67ED7OkBaO29CN6HpTuUQWalNOIbbYe0zc/EpBbUqeyzosL
        OeUkmZ6qbbJTKmWlvRHV/qvHzIJr6vqQWqJjowVpsHg2
X-Google-Smtp-Source: ABdhPJxcPb3yuO2kg71BJe3/VCzS/xRUBoWsgeZAKM8JtpENt1sJrIw1A34rRk5qSmiuJ5u4b4YHY0ycl1/bpMbRM44=
X-Received: by 2002:a05:6402:12cf:: with SMTP id k15mr260420edx.299.1643222170905;
 Wed, 26 Jan 2022 10:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20220125203548.352278-1-shy828301@gmail.com> <YfEEn06IEPjdGzHc@infradead.org>
In-Reply-To: <YfEEn06IEPjdGzHc@infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 26 Jan 2022 10:35:59 -0800
Message-ID: <CAHbLzkoaM=e7EXpKQkxP+BRi-1gSjfJ=9GHM+s=5Lyh2ksZ+Kw@mail.gmail.com>
Subject: Re: [v4 PATCH] block: introduce block_rq_error tracepoint
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:21 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jan 25, 2022 at 12:35:48PM -0800, Yang Shi wrote:
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
> > Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> > The v3 patch was submitted in Feb 2020, and Steven reviewed the patch, but
> > it was not merged to upstream. See
> > https://lore.kernel.org/lkml/20200203053650.8923-1-xiyou.wangcong@gmail.com/.
> >
> > The problems fixed by that patch still exist and we do need it to make
> > disk error handling in rasdaemon easier. So this resurrected it and
> > continued the version number.
> >
> > v3 --> v4:
> >  * Rebased to v5.17-rc1.
> >  * Collected reviewed-by tag from Steven.
> >
> >  block/blk-mq.c               |  4 +++-
> >  include/trace/events/block.h | 41 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index f3bf3358a3bb..bb0593f93675 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -789,8 +789,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
> >  #endif
> >
> >       if (unlikely(error && !blk_rq_is_passthrough(req) &&
> > -                  !(req->rq_flags & RQF_QUIET)))
> > +                  !(req->rq_flags & RQF_QUIET))) {
> > +             trace_block_rq_error(req, blk_status_to_errno(error), nr_bytes);
>
> Please report the atual block layer status code instead of the errno
> mapping here.

Sure, thanks.
