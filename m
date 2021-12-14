Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57419473B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhLNDNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:13:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235472AbhLNDNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639451600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99hHa+R8DxpGc57uFm6oCLjvQUYhFLts8EwSb1a/bxk=;
        b=i98HusjQARCC5iXS0/CA/19lKvRRlbvvSg347gmDb2uCXUc/A0uhcpX+JdTnelivBLesyp
        hDg5Gt2bB82trC0SFMjL2RC1E37MD0Gotq0i9BBQ7oc7RO4FxkU/oIvAyFmjT4DT9K7zMb
        hwVA+Hfo9ahXCuiUkNi2aS3MD/eroZY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-ufLOXVnlOVy-OOZaY_Cb6Q-1; Mon, 13 Dec 2021 22:13:19 -0500
X-MC-Unique: ufLOXVnlOVy-OOZaY_Cb6Q-1
Received: by mail-lj1-f199.google.com with SMTP id b3-20020a2ebc03000000b0021ffe75b14cso4895403ljf.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 19:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=99hHa+R8DxpGc57uFm6oCLjvQUYhFLts8EwSb1a/bxk=;
        b=CKY3f36lYfCUAmZtgEK2lXc9ifg/4euhGqccE1Tp3tkv6OsOcRN8GCVEnH+HLcOW8t
         fPdFJ4JSoQCZQ2RASuyOWRwMz8peslLvUzk1LrR3Aka7WRAprBBb02Au4a4bQBOg8ofS
         GHebyXGmrEzMp4NL0wRfe1yuJwn7JWfRUo9kmBo/L50X5gCJVkcBfsNSvlQSVY0pSew2
         GgxfIEGskhhNfKHo2qxa255QuZeqk6AKt90C86rwvkBANeoU8W8CwSIgwpUQPtw/r9CX
         0OAz1a7yiRblkjjcfsXtQnw4zXxqacoWqs542RSbX+FIXA3kdWhTX8UOrf89ZO1vk+lU
         i1GA==
X-Gm-Message-State: AOAM533BzGaZ9cozpqPHSzSPXvV0+CtyEvN+9S5ZedZlBj6GGIEKUc2u
        ym8oyQ7rKqPPqfNJqJm36AH+J7w8+trS9iCue6zUDd0Fky9b9WG+ziZ7QviO5L3ULPwOhPEd5xP
        87Uoc7zUh1Nz0E17te5uxr3JidbcEgISKM5QOjGYE
X-Received: by 2002:ac2:518b:: with SMTP id u11mr2321119lfi.498.1639451597760;
        Mon, 13 Dec 2021 19:13:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZ1HCIVLCKmLXdf3Yl2yAjouNx1OCPxPcR7jWZs3VxYTOSPUyURuqCGeB00yGBqOXmIWH1kqW4dvobsBNeN9Y=
X-Received: by 2002:ac2:518b:: with SMTP id u11mr2321107lfi.498.1639451597577;
 Mon, 13 Dec 2021 19:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20211213045012.12757-1-mengensun@tencent.com> <CACGkMEtLso8QjvmjTQ=S_bbGxu11O_scRa8GT7z6MXfJbfzfRg@mail.gmail.com>
In-Reply-To: <CACGkMEtLso8QjvmjTQ=S_bbGxu11O_scRa8GT7z6MXfJbfzfRg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 14 Dec 2021 11:13:06 +0800
Message-ID: <CACGkMEukGbDcxJe3nGFkeBNenniJdMkFMRnrN4OOfDsCb7ZPuA@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: make copy len check in xdp_linearize_page
To:     mengensun8801@gmail.com
Cc:     davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        mengensun <mengensun@tencent.com>,
        MengLong Dong <imagedong@tencent.com>,
        ZhengXiong Jiang <mungerjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 5:14 PM =E5=AD=99=E8=92=99=E6=81=A9 <mengensun8801@=
gmail.com> wrote:
>
> Jason Wang <jasowang@redhat.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=B8=80 15:49=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Dec 13, 2021 at 12:50 PM <mengensun8801@gmail.com> wrote:
> > >
> > > From: mengensun <mengensun@tencent.com>
> > >
> > > xdp_linearize_page asume ring elem size is smaller then page size
> > > when copy the first ring elem, but, there may be a elem size bigger
> > > then page size.
> > >
> > > add_recvbuf_mergeable may add a hole to ring elem, the hole size is
> > > not sure, according EWMA.
> >
> > The logic is to try to avoid dropping packets in this case, so I
> > wonder if it's better to "fix" the add_recvbuf_mergeable().
>

Adding lists back.

> turn to XDP generic is so difficulty for me, here can "fix" the
> add_recvbuf_mergeable link follow:
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 36a4b7c195d5..06ce8bb10b47 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1315,6 +1315,7 @@ static int add_recvbuf_mergeable(struct virtnet_inf=
o *vi,
>                 alloc_frag->offset +=3D hole;
>         }
> +       len =3D min(len, PAGE_SIZE - room);
>         sg_init_one(rq->sg, buf, len);
>         ctx =3D mergeable_len_to_ctx(len, headroom);

Then the truesize here is wrong.

>         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
>
> it seems a rule that, length of elem giving to vring is away smaller
> or equall then PAGE_SIZE

It aims to be consistent to what EWMA tries to do:

        len =3D hdr_len + clamp_t(unsigned int, ewma_pkt_len_read(avg_pkt_l=
en),
                        rq->min_buf_len, PAGE_SIZE - hdr_len);

Thanks

>
> >
> > Or another idea is to switch to use XDP generic here where we can use
> > skb_linearize() which should be more robust and we can drop the
> > xdp_linearize_page() logic completely.
> >
> > Thanks
> >
> > >
> > > so, fix it by check copy len,if checked failed, just dropped the
> > > whole frame, not make the memory dirty after the page.
> > >
> > > Signed-off-by: mengensun <mengensun@tencent.com>
> > > Reviewed-by: MengLong Dong <imagedong@tencent.com>
> > > Reviewed-by: ZhengXiong Jiang <mungerjiang@tencent.com>
> > > ---
> > >  drivers/net/virtio_net.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 36a4b7c195d5..844bdbd67ff7 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -662,8 +662,12 @@ static struct page *xdp_linearize_page(struct re=
ceive_queue *rq,
> > >                                        int page_off,
> > >                                        unsigned int *len)
> > >  {
> > > -       struct page *page =3D alloc_page(GFP_ATOMIC);
> > > +       struct page *page;
> > >
> > > +       if (*len > PAGE_SIZE - page_off)
> > > +               return NULL;
> > > +
> > > +       page =3D alloc_page(GFP_ATOMIC);
> > >         if (!page)
> > >                 return NULL;
> > >
> > > --
> > > 2.27.0
> > >
> >
>

