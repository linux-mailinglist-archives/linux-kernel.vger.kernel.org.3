Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A688949EA3D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbiA0SSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiA0SST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:18:19 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C893C061747;
        Thu, 27 Jan 2022 10:18:19 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id j2so7724338ejk.6;
        Thu, 27 Jan 2022 10:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xHTfty/6qjJB9GUu+F5khyO+ticx0XfQj2FfNXTPBg=;
        b=hWpc0eVTVZ1XxVX52Awg0oiO4DRZUWuE4geKSONsXE6eydbHyAjNJmoInBa+d3HBmr
         pR2BFAyP5s+TwDLhDELSCXejZd/pbcfm8Uo+b4ueLAqOPnQ8bIWDEBY3AoupZPpTS6qU
         k4eCKiRP1NMHY7zstlfeftFe5zSfkBW7CAeG99frZ80UWE6JNxME4k72/boojLaoNiz0
         sjassiUUY0a4vUFHmemDFDgiKTF6JBe+8lZI3pPrHcLIfVJyOGuY6sdH0CYi1qWYpiN+
         NSykpA0Co7pwVNYcWNd/rCPJgs9Gkiek8VorISss69/qC1VEPT4yMPk4t1yNi5ZsoG5s
         EyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xHTfty/6qjJB9GUu+F5khyO+ticx0XfQj2FfNXTPBg=;
        b=JmMPp1Ap3mORwgXopNcxSX5Q8EkH1k8YwRTIVjTa7pLUes0rcS6F9BTcTYBrw9dTiP
         gJ0xTjrnrVnXIGRnD/wIJv7XNIDsY46wSBp0H9ULSXk3YTgLE4KRGHb6MqVzHoacPAGY
         5jlrZBrmXkKLYM2nG6H9sdNL4NqXk3g88g4H6+sNxaow/663+3cOKSVUd4KJ8ZSVKayY
         4f8iDRAFdVy/9pnaHAB1iIVUb9emlcnxrKMfczI420ZdPT8lGPP6A6wDLjeu0T2keCUg
         itwt5jnFaPscvxznIx8xMcaV1ZWMs6hODeK9TADgj9bdqFh/I/VfC9VPpi4sUdS3lw19
         Fd5A==
X-Gm-Message-State: AOAM533nGidjYFQdrB7wJSGtQpxkaaIM5gtAF7AG+IEjMTCR+HZx3XFK
        IXv9/k3CjhNJO0tLDb+uiIpDv2coTS/SXyzUhZyzQCHwuCeSPA==
X-Google-Smtp-Source: ABdhPJw/rAJqAilRpag/zzv2nAxG/MnaLOyPqzLRRSqZ/xBK5zyNMJI2n79FoN7rCP3thEKagaLAUc/uPN1MAjDPcHY=
X-Received: by 2002:a17:907:6089:: with SMTP id ht9mr3792241ejc.612.1643307497685;
 Thu, 27 Jan 2022 10:18:17 -0800 (PST)
MIME-Version: 1.0
References: <20220126185153.417948-1-shy828301@gmail.com> <YfJrsid0OJQykXYz@infradead.org>
In-Reply-To: <YfJrsid0OJQykXYz@infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 27 Jan 2022 10:18:05 -0800
Message-ID: <CAHbLzkqNdnECNHGn0=kfUOfaxq6LLrwPSVvJKRHNvnuFtPve2w@mail.gmail.com>
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

On Thu, Jan 27, 2022 at 1:53 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jan 26, 2022 at 10:51:53AM -0800, Yang Shi wrote:
> > +             __entry->dev       = rq->q->disk ? disk_devt(rq->q->disk) : 0;
> > +             __assign_str(name,   rq->q->disk ? rq->q->disk->disk_name : "?");
>
> None f the other tracepoints has the disk name, why does this one need
> it?  And if you add it please avoid the overly long line.

I guess the disk name was added to ease some handling in userspace
tools. But if all other tracepoints don't have disk name shown, I
think I'd better follow the convention. I did overlook this when I
ported this patch. Will remove it.

>
> > +             __entry->sector    = blk_rq_pos(rq);
> > +             __entry->nr_sector = nr_bytes >> 9;
> > +             __entry->error     = blk_status_to_errno(error);
>
> This still converts the block status to an errno.

I may misunderstand your comments. I just followed what
block_rq_complete tracepoint does. Or the linux-block community is
converting all tracepoints to show blk status code instead of
conventional errno?

And the userspace tool doesn't know blk status code and still expects
the conventional errno. For example, rasdaemon reads block_rq_complete
events now and have the below:

static const struct {
        int             error;
        const char      *name;
} blk_errors[] = {
        { -EOPNOTSUPP, "operation not supported error" },
        { -ETIMEDOUT, "timeout error" },
        { -ENOSPC,    "critical space allocation error" },
        { -ENOLINK,   "recoverable transport error" },
        { -EREMOTEIO, "critical target error" },
        { -EBADE,     "critical nexus error" },
        { -ENODATA,   "critical medium error" },
        { -EILSEQ,    "protection error" },
        { -ENOMEM,    "kernel resource error" },
        { -EBUSY,     "device resource error" },
        { -EAGAIN,    "nonblocking retry error" },
        { -EREMCHG, "dm internal retry error" },
        { -EIO,       "I/O error" },
};

This patch aims to add block_rq_err tracepoint to replace
block_rq_complete in rasdaemon.
