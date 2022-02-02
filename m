Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57894A7712
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiBBRr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245487AbiBBRr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:47:56 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE51C061714;
        Wed,  2 Feb 2022 09:47:55 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id k25so23563ejp.5;
        Wed, 02 Feb 2022 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AamInyOOTBBGovz85dTdC8owJuF7NBk/tyX7bBLgOk=;
        b=H0g9b2FKQCmM+dXDcg/CEux+iY077CMc6zivamSyyAtG2GiCirq4qWNTJkuDuOcljp
         snvP7E39bJXkpJAGRnbLSQlB1wgijC1Hhi0Vr6QVCGPHfq5bqLJgiHKwMLkTGVE9UAKu
         cLc/U07SDXBBOPypX+8KUO6eH1VksG3UU12/lwDsT5BaEpkzLbEIi0q3ldVmGXVpng5r
         +8G2vlgcuwksg4Y/SCvCHqhwK9Mz/z+nKJ17+tH8Hr2qLOYV76Jeff+sEvG0FlXTDeQ5
         vq2Gu1ENHU2G0+WfGfdyQazkNQHN2Ji8Gt0Gd646y2w5aY8z91v3rheIYzxPOQAMQtZr
         GdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AamInyOOTBBGovz85dTdC8owJuF7NBk/tyX7bBLgOk=;
        b=Ijcn/5DJfu8yIUelx85dI9GDGcAofF4CWgp8W1RMeq5+4fsxDcv8s2N+1r031Qey1w
         nFpiR4koYjcGqLqLuCUTzqmP7h1IMX1Ez2msy5CkvGeVew8AxGDWIRRW/VO1uY337Okz
         A835Z+kk9Jem2SaNDYxEqZqj6JIBhZZGvlHRU5fxcN3e/Asjc0PMiokSPQL1d85Eo39u
         kqSzhP33xi1A2pXciDf0U0oHZPFf2ubVDTM0Z/VB2SEdyro1BAWFN2GyheF98tFNEQYN
         +d9vYtNZfOvkUq5mcWV3PsIIxivy7pXd+YbgF1o9GBKcLJF366cZofPwoabeLFZKqB/T
         G9zA==
X-Gm-Message-State: AOAM533xnXGSM929/5yTGYjRS9zX2H0KfJiHsLysJjhUwGIdME+2Wyo7
        Vav+EAOrpPOzn7HnCEddn+OOwD1TbQiOEFLNTRc=
X-Google-Smtp-Source: ABdhPJzh73CAbM/4RbWI3z4AVB0icVBLQfjZCZt5gRHnqXOGTYiCaVfj4lhsZa9kP73TUMBSfPzDNc2e4G1cqg3/rK8=
X-Received: by 2002:a17:907:6e1a:: with SMTP id sd26mr25152915ejc.270.1643824074319;
 Wed, 02 Feb 2022 09:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20220126185153.417948-1-shy828301@gmail.com> <YfJrsid0OJQykXYz@infradead.org>
 <CAHbLzkqNdnECNHGn0=kfUOfaxq6LLrwPSVvJKRHNvnuFtPve2w@mail.gmail.com>
In-Reply-To: <CAHbLzkqNdnECNHGn0=kfUOfaxq6LLrwPSVvJKRHNvnuFtPve2w@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 2 Feb 2022 09:47:42 -0800
Message-ID: <CAHbLzkqAEmwjC-A=kuS1DY676jiDWD+cohO486djdmPDvgOF3A@mail.gmail.com>
Subject: Re: [v5 PATCH] block: introduce block_rq_error tracepoint
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 10:18 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Jan 27, 2022 at 1:53 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Jan 26, 2022 at 10:51:53AM -0800, Yang Shi wrote:
> > > +             __entry->dev       = rq->q->disk ? disk_devt(rq->q->disk) : 0;
> > > +             __assign_str(name,   rq->q->disk ? rq->q->disk->disk_name : "?");
> >
> > None f the other tracepoints has the disk name, why does this one need
> > it?  And if you add it please avoid the overly long line.
>
> I guess the disk name was added to ease some handling in userspace
> tools. But if all other tracepoints don't have disk name shown, I
> think I'd better follow the convention. I did overlook this when I
> ported this patch. Will remove it.
>
> >
> > > +             __entry->sector    = blk_rq_pos(rq);
> > > +             __entry->nr_sector = nr_bytes >> 9;
> > > +             __entry->error     = blk_status_to_errno(error);
> >
> > This still converts the block status to an errno.
>
> I may misunderstand your comments. I just followed what
> block_rq_complete tracepoint does. Or the linux-block community is
> converting all tracepoints to show blk status code instead of
> conventional errno?
>
> And the userspace tool doesn't know blk status code and still expects
> the conventional errno. For example, rasdaemon reads block_rq_complete
> events now and have the below:
>
> static const struct {
>         int             error;
>         const char      *name;
> } blk_errors[] = {
>         { -EOPNOTSUPP, "operation not supported error" },
>         { -ETIMEDOUT, "timeout error" },
>         { -ENOSPC,    "critical space allocation error" },
>         { -ENOLINK,   "recoverable transport error" },
>         { -EREMOTEIO, "critical target error" },
>         { -EBADE,     "critical nexus error" },
>         { -ENODATA,   "critical medium error" },
>         { -EILSEQ,    "protection error" },
>         { -ENOMEM,    "kernel resource error" },
>         { -EBUSY,     "device resource error" },
>         { -EAGAIN,    "nonblocking retry error" },
>         { -EREMCHG, "dm internal retry error" },
>         { -EIO,       "I/O error" },
> };

Gently ping. Should I print blk status code instead of errno for this
trace point? But I really don't get why. And block_rq_complete
tracepoint does:

        TP_fast_assign(
                __entry->dev       = rq->q->disk ? disk_devt(rq->q->disk) : 0;
                __entry->sector    = blk_rq_pos(rq);
                __entry->nr_sector = nr_bytes >> 9;
                __entry->error     = blk_status_to_errno(error); <===
convert blk status code to errno

                blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
                __get_str(cmd)[0] = '\0';
        ),

>
> This patch aims to add block_rq_err tracepoint to replace
> block_rq_complete in rasdaemon.
