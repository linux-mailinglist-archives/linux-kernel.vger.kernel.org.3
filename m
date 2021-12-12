Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10433471938
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 09:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhLLIHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 03:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhLLIHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 03:07:11 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6676AC061751
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 00:07:11 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y13so42232410edd.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 00:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jgxXFCg8o6FmTCfH8ziDqYyXNzOfy9cCmD86MxLgyqE=;
        b=z1dOkB4CiDacYDWOkNzAgWfPT8Ov73bd2jqA0j6im6E+SHJHtGs+b3FWk+/fa/7AQa
         3rgNikErNOLN4ChWS/KpEg8f8cbw5xnTfObZ+epjMIazEpd2BTd8wR8tEmPCiL2cmid/
         Aec4jMUWQ9CS4PPST21inkY8vl71az/SrKSYKQdX14ffXAoB6uR1kcb5z9pE/RRrBeyJ
         1b3B+P6UG97bGfHNVthK1eN1DI90X6xFCuDEVWU9uOiQGyBX0K1rar7zHjp+ATocWbb/
         og94MYiR2q5ilqOjf/1D2c6oQYQdJ5M1uRBAfPy12l2pdLtKl4oEMSkFEN3jlCHCnYUf
         SkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jgxXFCg8o6FmTCfH8ziDqYyXNzOfy9cCmD86MxLgyqE=;
        b=uj1/6YRYvpiIfB03apcymj6E3QrGXdQLJJ7wfbjwaPCShCTL4dZNFhj53BFCDvtlP7
         g0a6bt0RRJSoN+Wr0ldLbcXZNJZ4v+NJ8T2FUZQsf6mZ7uN37MmZtkEjE51c0mFY7tMy
         nAj/aXMMx+U0EeUPTtfogYdWNoLg/ad/otcoW+AUp60Kd78Ud05VxANXT11EmwTJxj/+
         6ws7A+jl3igySPtIqrN8z7PbWADDZ1IL37HPM7GGwi7qGAKFcbGnCT3cZzZfb7+wbTYk
         ogyv9LGQlmTCYncidOzEU2KvF8ypNb/Xrif3S2ZOMQ3om06EtZnUOkqLf8b948q6mqAw
         odfg==
X-Gm-Message-State: AOAM5315TkRNYYHCvKntE7IB5wHW4QOwXOWAyz6n2CkdLOQd59u6iTrB
        uAA8Qn5aVLEfp0MRAuDRcfJxZquz/rNHWXxJL57k
X-Google-Smtp-Source: ABdhPJxRa2k6IWJ815KzICfS67nw7HOIiqy5WJ3wICGPZvO6tTdyijax7nA+509fQUzj79ziBIK9MaTFEnKLG8bpHmE=
X-Received: by 2002:a17:907:72c7:: with SMTP id du7mr36577783ejc.424.1639296429851;
 Sun, 12 Dec 2021 00:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20210913111928.98-1-xieyongji@bytedance.com> <Ya/vW/eGXCzbmvAC@sol.localdomain>
 <YbOiO7xlOL0kkuYF@sol.localdomain>
In-Reply-To: <YbOiO7xlOL0kkuYF@sol.localdomain>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Sun, 12 Dec 2021 16:07:01 +0800
Message-ID: <CACycT3sQHP+QgVitE6848Pxio+DC00dzpg-MAPwf191GXJYwsw@mail.gmail.com>
Subject: Re: [PATCH] aio: Fix incorrect usage of eventfd_signal_allowed()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     bcrl@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 2:53 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Dec 07, 2021 at 03:33:47PM -0800, Eric Biggers wrote:
> > On Mon, Sep 13, 2021 at 07:19:28PM +0800, Xie Yongji wrote:
> > > We should defer eventfd_signal() to the workqueue when
> > > eventfd_signal_allowed() return false rather than return
> > > true.
> > >
> > > Fixes: b542e383d8c0 ("eventfd: Make signal recursion protection a tas=
k bit")
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  fs/aio.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/aio.c b/fs/aio.c
> > > index 51b08ab01dff..8822e3ed4566 100644
> > > --- a/fs/aio.c
> > > +++ b/fs/aio.c
> > > @@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entr=
y *wait, unsigned mode, int sync,
> > >             list_del(&iocb->ki_list);
> > >             iocb->ki_res.res =3D mangle_poll(mask);
> > >             req->done =3D true;
> > > -           if (iocb->ki_eventfd && eventfd_signal_allowed()) {
> > > +           if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
> > >                     iocb =3D NULL;
> > >                     INIT_WORK(&req->work, aio_poll_put_work);
> > >                     schedule_work(&req->work);
> > > --
> > > 2.11.0
> > >
> >
> > Since I was just working with this file...:
> >
> > Reviewed-by: Eric Biggers <ebiggers@google.com>
> >
> > I don't know who is taking aio fixes these days, but whoever does so pr=
obably
> > should take this one at the same time as mine
> > (https://lore.kernel.org/linux-fsdevel/20211207095726.169766-1-ebiggers=
@kernel.org).
>
> Apparently no one is, so I've included this patch in the pull request I'v=
e sent
> (https://lore.kernel.org/r/YbOdV8CPbyPAF234@sol.localdomain).
>

Thank you!

Thanks=EF=BC=8C
Yongji
