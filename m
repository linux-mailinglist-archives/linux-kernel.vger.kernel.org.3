Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7873F483B21
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 04:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiADDmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 22:42:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbiADDmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 22:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641267735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SwFXhGn57Ik/8yv+mERRlVV9PBTKn9DgoCqspftrb0U=;
        b=a8pJqXHPzDmTB6PBuBnPCPBYPUIkfewqfGlMHZqXtDM+f2GJ4b/0Kn9iQhToWzJIusdOAp
        8nla3y5ZbYd0MEOfioO7ZljY4SgUFLXahA78b3jWVmws3m+4P00vysqiKxoaGbwpATGGiX
        mnX1+09FlqnGMiH3dJXihGLJQIk/Ey0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-RYjsC8fsPZq_wrS8EH216w-1; Mon, 03 Jan 2022 22:42:14 -0500
X-MC-Unique: RYjsC8fsPZq_wrS8EH216w-1
Received: by mail-lf1-f71.google.com with SMTP id f17-20020a05651232d100b00429623cf219so5358430lfg.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 19:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwFXhGn57Ik/8yv+mERRlVV9PBTKn9DgoCqspftrb0U=;
        b=T+MN+PPBOpRD7DvXOIWyehJNGNW8N8Oq3eEhlCcHkgx4n9Xwy6Mn9lMUAu0A04dh8j
         Al/kKf/uizAZJ7rZ9/fCs6f/fUJn/Uo4Y4c9BE+UPJlmtmhqlsDAJko38BAl+YHvCyvV
         7dJNmRgTENfCwZgKLJFdtJcqNpxNjcl11+VAFCWMxfbMDCrSZ3mn4U5ViwhwxKyLnrIt
         oD5Tr0YCEu5AMcDxeDMG5nupXm59t+nZGBPNs0KJOrlM2OMOS8lQB6GckkLqlZdEYsuk
         NyEggrLAi53SD8L++h0oy+ikka5vryHDksg0d6wNWbAr1ndARHvs7kHyxG3UBEyq0pFc
         WCnQ==
X-Gm-Message-State: AOAM532aXvHeYLms5/SHxUSaMQlO0244c2vMRSVg9a4cwGB2DzqjCJzi
        JVHDvdZvBQKsq9awvpwe2FrJyrj7NAm96MZv08iYw5glDopu12wHVDKic7pNwgT++D5OqZxl07y
        7YkB7Oi9+Lz5XpcHR+4a9RBLZDew5lY+YWrLbu3yC
X-Received: by 2002:a05:651c:1a0d:: with SMTP id by13mr31580404ljb.107.1641267733037;
        Mon, 03 Jan 2022 19:42:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx90ph1BuLv80bniEX7O6j0IQH75tTw6Q0lIGjPvVyZoAE/LEns1b2VVRYEkf3ISCOL4yV/IMQfDl7AdFba/cw=
X-Received: by 2002:a05:651c:1a0d:: with SMTP id by13mr31580400ljb.107.1641267732858;
 Mon, 03 Jan 2022 19:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20211224101007.1635703-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20211224101007.1635703-1-jiasheng@iscas.ac.cn>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 4 Jan 2022 11:42:01 +0800
Message-ID: <CACGkMEuTn4uaS5dfudF-X-Y0Rw0wH9VXcTkVsZJ_TUtxXGMBVw@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: Check null pointer
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 6:10 PM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the alloc_indirect_packed() returns kmalloc_array() that could
> allocation fail and return null pointer, it should be check in order to
> prevent the dereference of null pointer.
>
> Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/virtio/virtio_ring.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b53e9c1..30fd925165ac 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -991,7 +991,12 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>         dma_addr_t addr;
>
>         head = vq->packed.next_avail_idx;
> +

Unnecessary changes.

Other than this:

Acked-by: Jason Wang <jasowang@redhat.com>

>         desc = alloc_indirect_packed(total_sg, gfp);
> +       if (!desc) {
> +               END_USE(vq);
> +               return -ENOMEM;
> +       }
>
>         if (unlikely(vq->vq.num_free < 1)) {
>                 pr_debug("Can't add buf len 1 - avail = 0\n");
> --
> 2.25.1
>

