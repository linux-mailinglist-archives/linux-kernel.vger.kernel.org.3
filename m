Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B606B48E416
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbiANGMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:12:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239284AbiANGMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642140738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EUt20B2ZQKiul9TVzlscr0qYlhPciKBJGV+dQspDLic=;
        b=hGXZGoJcTiW7PKM9s6Ieshfgjnj1FjD3PUO5zAge1yN2pupq+Pz5UeC0b6MOFJLYTFkN9f
        aY8bWKso+w7rA8qmZ4i3Vm90fsWVQ0R3ztndYNEvIRLcGHCFrVZHVNYdXtJSX3y5WFIaAv
        jIyxkl19EWVFOCdzyOPKG5UksTMvh/c=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-r0LUZt3gPxKprcFWdHx0IA-1; Fri, 14 Jan 2022 01:12:17 -0500
X-MC-Unique: r0LUZt3gPxKprcFWdHx0IA-1
Received: by mail-lf1-f69.google.com with SMTP id l29-20020a19495d000000b0042d1e9c46f3so5525787lfj.22
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUt20B2ZQKiul9TVzlscr0qYlhPciKBJGV+dQspDLic=;
        b=wzPOI75XXt5cpWyctactk7eOdJjMRNyxtsFBnM8qLYtlsWOL11yhffxLr1Y5wM4aY5
         vRM4iNm9+dBWquLJ+GXUcDiaNlyNmqDzrb2MEg7oeae+guTIv13su4Z4uge5icSB45xk
         HImawmjYIlwfDEFReR7kxA8i8qF0msvM01PIAcQj3Cu6a16ZMH8i6dmL9wJrxE2RwhF5
         kuso3pvMpVtwr7xSTRUoJmsiFx2ThyA0aKsQNx8F7E3lRRUN7tag+v3R8ZG3LyWXp5gl
         b5H4QY77aLMgOjAmAWtYxx+UfRdO/Vs7ZhaVNDnlWE0XVk9Nw+nbglsAgvl7D1mO8INy
         beSQ==
X-Gm-Message-State: AOAM532NenfM0LVnhQBI9gxXYPY/FDZojpP1vQUI07Ba6iekvW+TJS82
        kD5wojJr9jvSzgt6h9lo/STB4ox3m7KScInEU9mVh18F1UmH/QARENNpdHHQPqGxwrMpd54DkNa
        93Ki3VUY+NeZlQaEAo59m+Tn+baFKwLhATNzkMuP1
X-Received: by 2002:a05:6512:3d24:: with SMTP id d36mr6244860lfv.481.1642140735519;
        Thu, 13 Jan 2022 22:12:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXfcJ6JMKErK1A1bwY9Z9Ixp5/QcPqABoqPDeUk3JLyw951WqrUnFZxZXBpbXddgs9NIe5WU7RNU0Xu5pWstw=
X-Received: by 2002:a05:6512:3d24:: with SMTP id d36mr6244843lfv.481.1642140735248;
 Thu, 13 Jan 2022 22:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20220113141134.186773-1-sgarzare@redhat.com>
In-Reply-To: <20220113141134.186773-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 14 Jan 2022 14:12:04 +0800
Message-ID: <CACGkMEuFbr+V7qzm=DXKuDUehFH-8Hrw-dojPTDxN3zKOq_kCQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: remove avail_event arg from vhost_update_avail_event()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 10:11 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> In vhost_update_avail_event() we never used the `avail_event` argument,
> since its introduction in commit 2723feaa8ec6 ("vhost: set log when
> updating used flags or avail event").
>
> Let's remove it to clean up the code.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vhost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..ee171e663a18 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1981,7 +1981,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
>         return 0;
>  }
>
> -static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
> +static int vhost_update_avail_event(struct vhost_virtqueue *vq)
>  {
>         if (vhost_put_avail_event(vq))
>                 return -EFAULT;
> @@ -2527,7 +2527,7 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>                         return false;
>                 }
>         } else {
> -               r = vhost_update_avail_event(vq, vq->avail_idx);
> +               r = vhost_update_avail_event(vq);
>                 if (r) {
>                         vq_err(vq, "Failed to update avail event index at %p: %d\n",
>                                vhost_avail_event(vq), r);
> --
> 2.31.1
>

