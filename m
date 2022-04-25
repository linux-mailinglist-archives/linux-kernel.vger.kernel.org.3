Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9487B50E4CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243031AbiDYPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbiDYPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:55:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17D3A5CC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:52:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p12so21414582lfs.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pZLWDFS8RgdNHPorQYwwXOayoTTe55X/Bje9P63wXrs=;
        b=U4q32/rfGq9w+bSl++Voj3jErOzHopqHFSCG1ZCNHrA8sXi5P0MvRB9cLQeFTzLNlO
         wy7A1A91Kn/3ZBD9EtSQ7dKkdAIVbQ3VlPScpWJPPib8NE8VvqjD2X+MRIt6/t6gjGQr
         DC6QlO0VcQnkoZgItRZRAtIL6cMvP3N2YPOGsHMoaQHHEy8HuftwXSRkFszrid32rdkO
         z7tRS0YevWvzb51xWq56bZuiHu6g4pmr5Any+GjRGaf2omKMKyiwhAxnF0Owe/BfZO8B
         1Jy1ojfzHEZ49DNTdaGIByA9E11eO76Y/3GaWeEGSZy5IHjFHiR+z73q+8F7Ft0LBznV
         VK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pZLWDFS8RgdNHPorQYwwXOayoTTe55X/Bje9P63wXrs=;
        b=caJsbZEXRXZs8wkH36TBMX3mfgBKonzsdgTjmdct4flL3fmaCRXpCGIhqw5EezGMcY
         qGKRDeWh8+fqwB69QfH0sKFgNNAQJyYhSVwfD+RRH2lrJqtY7R9NFtBx7uopvGntgsLQ
         YA+0TO8QbMxXblmNpa6CXsEuWwR1ol1mf02DzOZccTbsnSnfyzQM5CAY8l1iCYbR3s0a
         uz4mrIjdpAW/jA9KOWTJR4xvJ8stK/EKjbnvLHaive1XE4PR4YtfaBufO4m6r1gWIsWq
         9kDV21HHKKjtt3vhGQxBs4/yu/VrPCY15Xu5wHgCaDSIJghNjOnbyd6IRhO/ziJ1mt3C
         ga/Q==
X-Gm-Message-State: AOAM531BiLnd7HvJ+Ntteei+HmN3Qt4hufKHHTxNkOjFDQSZf1qWHlVP
        74xB2qVQ6we+is/pIlcXSR02s2bjP0G9jFrSlLgpTg==
X-Google-Smtp-Source: ABdhPJw6D+cinT5TVs9fSgHUkfhth9VTb4/6bYC9e61q4d/XxB7DdILo1eyJ+M0NR49dzQJCyWVeMjfgQvoc6MTKYlQ=
X-Received: by 2002:a19:f00f:0:b0:471:b497:8583 with SMTP id
 p15-20020a19f00f000000b00471b4978583mr14125238lfc.502.1650901941658; Mon, 25
 Apr 2022 08:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220423102421.16869-1-fmdefrancesco@gmail.com>
 <20220423102421.16869-4-fmdefrancesco@gmail.com> <fad918d3-6923-5bec-7830-5cddf7a725d6@wanadoo.fr>
 <2583087.X9hSmTKtgW@leap>
In-Reply-To: <2583087.X9hSmTKtgW@leap>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 25 Apr 2022 08:52:09 -0700
Message-ID: <CAHRSSEwvPB27SJNtzq-5ZoMW=VDbVpv-2BmACT+hzQYUXJWO4A@mail.gmail.com>
Subject: Re: [PATCH 3/3] binder: Use kmap_local_page() in binder_alloc_get_page()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 2:40 AM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On sabato 23 aprile 2022 18:02:48 CEST Christophe JAILLET wrote:
> > Hi,
> >
> > Le 23/04/2022 =C3=A0 12:24, Fabio M. De Francesco a =C3=A9crit :
> > > The use of kmap_atomic() is being deprecated in favor of
> kmap_local_page()
> > > where it is feasible. Each call of kmap_atomic() in the kernel create=
s
> > > a non-preemptible section and disable pagefaults. This could be a
> source
> > > of unwanted latency, so it should be only used if it is absolutely
> > > required, otherwise kmap_local_page() should be preferred.
> > >
> > > With kmap_local_page(), the mapping is per thread, CPU local and not
> > > globally visible. Furthermore, the mapping can be acquired from any
> context
> > > (including interrupts).
> > >
> > > Therefore, use kmap_local_page() / kunmap_local() in place of
> > > kmap_atomic() / kunmap_atomic().
> > >
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >   drivers/android/binder_alloc.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/
> binder_alloc.c
> > > index 0875c463c002..058595cc7ff0 100644
> > > --- a/drivers/android/binder_alloc.c
> > > +++ b/drivers/android/binder_alloc.c
> > > @@ -1250,17 +1250,17 @@ static int binder_alloc_do_buffer_copy(struct
> binder_alloc *alloc,
> > >             page =3D binder_alloc_get_page(alloc, buffer,
> > >                                          buffer_offset,
> &pgoff);
> > >             size =3D min_t(size_t, bytes, PAGE_SIZE - pgoff);
> > > -           base_ptr =3D kmap_atomic(page);
> > > +           base_ptr =3D kmap_local_page(page);
> > >             tmpptr =3D base_ptr + pgoff;
> > >             if (to_buffer)
> > >                     memcpy(tmpptr, ptr, size);
> > >             else
> > >                     memcpy(ptr, tmpptr, size);
> >
> > in the same spirit as patch 1/3, memcpy_to_page() and memcpy_from_page(=
)
> > looks good candidate to avoid code duplication.
>
> Hello Christophe, Todd,
>
> I had thought to use memcpy_to_page() and memcpy_from_page() (exactly as =
I
> did in other conversions I have been working on during the latest couple =
of
> weeks).
>
> However, I decided to avoid to use them for I should also have deleted th=
e
> comment which is before "kunmap_local(base_ptr);".
>
> I don't know how much Maintainers think it is necessary to make readers
> notice that "kunmap_local() takes care of flushing the cache []" (exactly
> as kunmap_atomic() does). Actually I'd delete that comment that looks
> redundant and unnecessary to me, but I cannot know if Todd wants it to
> remain there.
>
> @Todd: Can you please say what you think about this topic? Should I leave
> the patch as-is or I should use memcpy_{to,from}_page() and delete that
> comment?

I'm fine with using memcpy_{to,from}_page() and removing the comment.

>
> I won't send any v2 unless I have your confirmation.
>
> Thanks,
>
> Fabio
>
> >
> > Not checked in details, but looks mostly the same.
> >
> > Just my 2c.
> >
> > CJ
> >
> > >             /*
> > > -            * kunmap_atomic() takes care of flushing the cache
> > > +            * kunmap_local() takes care of flushing the cache
> > >              * if this device has VIVT cache arch
> > >              */
> > > -           kunmap_atomic(base_ptr);
> > > +           kunmap_local(base_ptr);
> > >             bytes -=3D size;
> > >             pgoff =3D 0;
> > >             ptr =3D ptr + size;
> >
> >
>
>
>
>
