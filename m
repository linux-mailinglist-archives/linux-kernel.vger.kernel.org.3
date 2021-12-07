Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0C146BA2F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhLGLlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbhLGLlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:41:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28386C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 03:38:17 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id e3so55939791edu.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 03:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcONFbkMq0aQgDFOGecCASi4QK2A5FCN577AfWqoSrE=;
        b=XCLAQQ3aQV+2wHAdAiWLreYKr5+A7XhBsEd26d12iCqPN/W8eys1YPh4mB5EQM5kUf
         atInw1bc2IWIWoio+X+M3YS6GqYjMBwiDz2G0nJTAUYu9rCO0jbzKkg9G1bfIcXYZr9e
         bYJAehFSR8pXSWbEdBX+9txdBevAPM9QNG+iNEV5/H9ftZ8Zl5stvtsyssevhcmQ4aw2
         em9zZ66Zc9yJX+pRVPdQW2lcIROo45a0CUvOTrmcKvD/cNHsEhBzrykh76aTswkOmEQ9
         OlMI/L6hOSmFw++nWW5g2979vYwX0it89hMwv0pmZx/CunSQtAf5hEd6FqhWxKNMD0ni
         0mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcONFbkMq0aQgDFOGecCASi4QK2A5FCN577AfWqoSrE=;
        b=q+S8qAekbhH+xQNMCbzQwiX5yDt13bqj73L6s/wJGLB9yL7Os7JFx2BeQDIz2byw7H
         slBsBQDjcpHtWVcYq8vIHeLeWZG1KLO2fc28iPtpIapNuMhuh9uitqzt8NsAHWRV0Ydz
         fUUBOTvBcZ9XaXRVFBZcg4hFs/FJAuIs/rFZHMM7cySUDpRRYXFVqx9lSMtpl9dyy/Qz
         qxCGAXYoikYVTAdG+P2ROJqtGOo9tMokrpiS8yLQZ1h2Ff3p0PvJptSBQDhdgLofULBC
         ijCpeTLApSsweBLSCsWzoVJ5SOYeW2oohLuUShSgeGDv+PlPhiWqj89g53zhJHDOoMl2
         84JA==
X-Gm-Message-State: AOAM531F5PJvMkD6AThFlS0zqT5bdkLOAGtMzuafkc5nEeUrBPEKRj1S
        OlvacUGte1TqxjxbaMI/32bQNw+nv+zOeiM0su5x
X-Google-Smtp-Source: ABdhPJzOung/etClm624N3JnBTWt3GkIiRGSofg6IC61AfMN7BR7UOHAD1XTt+ag+M14IN8e3IJcUawX1wQNgmHXLrM=
X-Received: by 2002:a17:907:72c7:: with SMTP id du7mr53191810ejc.424.1638877095740;
 Tue, 07 Dec 2021 03:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20210913111928.98-1-xieyongji@bytedance.com> <CACycT3ugx-wwPVb+Euzhj6hWn0fXO+jvfsUCew6v1iBaB8SZsQ@mail.gmail.com>
In-Reply-To: <CACycT3ugx-wwPVb+Euzhj6hWn0fXO+jvfsUCew6v1iBaB8SZsQ@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 7 Dec 2021 19:38:04 +0800
Message-ID: <CACycT3vaPcjYbORMN9mkFmZEgspPQ46y=ONQbiAEi-MYCu-0Mw@mail.gmail.com>
Subject: Re: [PATCH] aio: Fix incorrect usage of eventfd_signal_allowed()
To:     bcrl@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping again.

On Sun, Nov 14, 2021 at 3:15 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> Ping
>
> On Mon, Sep 13, 2021 at 7:20 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > We should defer eventfd_signal() to the workqueue when
> > eventfd_signal_allowed() return false rather than return
> > true.
> >
> > Fixes: b542e383d8c0 ("eventfd: Make signal recursion protection a task bit")
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  fs/aio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/aio.c b/fs/aio.c
> > index 51b08ab01dff..8822e3ed4566 100644
> > --- a/fs/aio.c
> > +++ b/fs/aio.c
> > @@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
> >                 list_del(&iocb->ki_list);
> >                 iocb->ki_res.res = mangle_poll(mask);
> >                 req->done = true;
> > -               if (iocb->ki_eventfd && eventfd_signal_allowed()) {
> > +               if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
> >                         iocb = NULL;
> >                         INIT_WORK(&req->work, aio_poll_put_work);
> >                         schedule_work(&req->work);
> > --
> > 2.11.0
> >
