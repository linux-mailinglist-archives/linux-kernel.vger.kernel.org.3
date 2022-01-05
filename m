Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B57484CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 04:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbiAEDUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 22:20:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234507AbiAEDUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 22:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641352835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EV+4L4V3EbdXjbiDS2bLBmpAyubhZUkCxgXn/7JcQ3s=;
        b=FRlknS2CovWQ50MnffuSrJU62pPgJ0YzsGz49CXCq6Pz+KV3hXneZT4QCelH5TZWiwxMni
        eZCes2eRP/0OtWvTFLS4T0+cSRnedC54tEQJXFojLlcUQtvPihXvqyIKL7LzW/uTh3Hr/5
        dpuT0N4ruZy49AtAD8B2n5rmnKUcooI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-ZmlV0xsLPx-Wzl3AbSLwgQ-1; Tue, 04 Jan 2022 22:20:34 -0500
X-MC-Unique: ZmlV0xsLPx-Wzl3AbSLwgQ-1
Received: by mail-lf1-f70.google.com with SMTP id a28-20020ac2505c000000b0042524c397cfso8733819lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 19:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EV+4L4V3EbdXjbiDS2bLBmpAyubhZUkCxgXn/7JcQ3s=;
        b=wKK1o+H/RmRoEnWNZzrlv+jOpjGWVlOPd0hiCKOksCM4C8pddSoYu9C1EUVc091Wph
         gsQ74Cnv6qy8nkM6r/xyj5AMqeCVKud0gLvpiVUGxMd8nuxjuuFCZK4UaWocOCnW8n+q
         2sj1lq0xYjEvBO2rrkyYcV7WS6toAbmpowZQwdggWk2iuSfbrZHZ4juO4W9C2ifDC60A
         uO7lXpACUBTzA9aXa6Z9GA+0kuRsDxyO2oH3SpskgS9EzHF0+0j6DL7ynKUZPrVeI76q
         MwUwULTJWh1gfgXhkqrIHLtOa4Lu2NzEK7n5pybyaEl4JV8z2EWTcCKFwDrlKd3RRJzo
         sroA==
X-Gm-Message-State: AOAM532/7HWyjWbRD8up3uzDzTYCAJZ74RMUlqMuWDfwUgPRwZX93PiJ
        NXii3za7vzKRaxDYT1IXvz16THQduyFha3b0S+5pCLfKHrIPg2ZY4tfiusnbANedLXQD6IPPS1S
        1CDB+LqzZCO/HHDlWhMClFIfhgvBSYn76r31PEy02
X-Received: by 2002:a2e:a177:: with SMTP id u23mr16009623ljl.217.1641352832648;
        Tue, 04 Jan 2022 19:20:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUQbE7b2+xQ4lqIM1r/2/rFDsfrFuYo71pp02AsvjbJyrfkhtBFuB2kvLjfNaqo/yGETaXf2YgGdMIUwsDKZY=
X-Received: by 2002:a2e:a177:: with SMTP id u23mr16009618ljl.217.1641352832413;
 Tue, 04 Jan 2022 19:20:32 -0800 (PST)
MIME-Version: 1.0
References: <20220104151251.1988036-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220104151251.1988036-1-jiasheng@iscas.ac.cn>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 5 Jan 2022 11:20:21 +0800
Message-ID: <CACGkMEtZsBPnzLiTnMGAwrbC2Sjqj2mh6+L56BR4qqLyDXrxTQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_ring: Check null pointer
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 11:13 PM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the alloc_indirect_packed() returns kmalloc_array() that could
> allocation fail and return null pointer, it should be check in order to
> prevent the dereference of null pointer.
>
> Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> v2: Remove the redundant empty line.
> ---
>  drivers/virtio/virtio_ring.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b53e9c1..2923d8a68dc3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -992,6 +992,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>
>         head = vq->packed.next_avail_idx;
>         desc = alloc_indirect_packed(total_sg, gfp);
> +       if (!desc) {
> +               END_USE(vq);
> +               return -ENOMEM;

Just notice this:

My tree contains this commit: fc6d70f40b3d0 ("virtio_ring: check desc
== NULL when using indirect with packed"). It has fixed the wrong
error value but not the END_USE().

Thanks

> +       }
>
>         if (unlikely(vq->vq.num_free < 1)) {
>                 pr_debug("Can't add buf len 1 - avail = 0\n");
> --
> 2.25.1
>

