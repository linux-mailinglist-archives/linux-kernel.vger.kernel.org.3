Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC04EA6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiC2E6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC2E6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B518130C36
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648529820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gdLLGvlsfSndXxLHrwfmGo1wuClHNVPUNMw1k7Q6B5c=;
        b=JhjAfjnwERmJ9cLoj9RYsmhdGUnXIuMXfEsFCzETU0VEEmGYV2KHCmg2HxMKbnTjv3iSS9
        B4lZSOtI9zWHcI/3u88ZoWg4X8vdW6FJsx+wF0bQ7wBMz0wNPN5PHH6gHlDt3BofsghRkq
        aPh6jpaoDn7Aqt57fKYPbIjZlJD7B0U=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-I6zVMEIiMcqKNTCw3J7ayg-1; Tue, 29 Mar 2022 00:56:59 -0400
X-MC-Unique: I6zVMEIiMcqKNTCw3J7ayg-1
Received: by mail-lj1-f198.google.com with SMTP id z20-20020a2eb534000000b002495db7fe98so6990832ljm.18
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdLLGvlsfSndXxLHrwfmGo1wuClHNVPUNMw1k7Q6B5c=;
        b=BV4P+keQYTwu0mdg4Sj/bpBX4NgSKCb8ALtFKZM9/VOVZ5XKnHqTrQtnJeSBUTwAbw
         nTWGcOt6wUPbkLO87NBZjm2j5Mx9VtL0WcaUyJSZMXH6XmFM0XN2SYKVtIZ8vXc0MI+y
         OncbTge6ktk1Y9ZWpb4F5Vh5y6iaBb9E4l7fbIkAPaQojF0bW0JCq+zM0QqwiK+Gw5r2
         mvwIhDt0sD4Q6v1IAf+SbbXrXs5igMZmE+WM9XcXvn6z9fNUwyIE+ajaUr0OuH5WCZoE
         VIFTQtpgv7Qu9SLh+itAvQbnn8s7w8W6yTu8fWIhb2C+z4DK/n7BIKysYj/uu4FEMqxR
         H1DQ==
X-Gm-Message-State: AOAM530Xx0rv+XUstxMbqvGr7cKuafdEkV1aJLnuHS95qhFdGqQnhKup
        O/PnlcAasVzQ3jPJdvnt8Y/2ZIHD8FUq8eEfct0HYinTeyz0dBYGfI7JlmrM4DjE7BmgkVmAjTX
        nNRrroqQDBnicoK859SvdmGHgXHnMHGKBd/un+Jb+
X-Received: by 2002:ac2:4477:0:b0:44a:55c6:155d with SMTP id y23-20020ac24477000000b0044a55c6155dmr955554lfl.376.1648529817592;
        Mon, 28 Mar 2022 21:56:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMBty9gTNcSKDAu+UruK8Auyu5/UV/1EcCa8Wu0m7ZR4UG4Wnhxa0RW6zMkOug5DsK9BND0duZE1InjsTyS1w=
X-Received: by 2002:ac2:4477:0:b0:44a:55c6:155d with SMTP id
 y23-20020ac24477000000b0044a55c6155dmr955540lfl.376.1648529817389; Mon, 28
 Mar 2022 21:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 29 Mar 2022 12:56:46 +0800
Message-ID: <CACGkMEvgcJy3k-s39QeLkLFho_wpsBnEbrcHWugajy50qjAo-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_ring: remove unnecessary to_vvq call in vring
 hot path
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     mst <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 6:58 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> It passes '_vq' to virtqueue_use_indirect(), which still calls
> to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
> unnecessary call of to_vvq in hot path.
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 962f1477b1fa..d597fc0874ec 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -205,11 +205,9 @@ struct vring_virtqueue {
>
>  #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>
> -static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
> +static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
>                                           unsigned int total_sg)
>  {
> -       struct vring_virtqueue *vq = to_vvq(_vq);
> -
>         /*
>          * If the host supports indirect descriptor tables, and we have multiple
>          * buffers, then go indirect. FIXME: tune this threshold
> @@ -507,7 +505,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>
>         head = vq->free_head;
>
> -       if (virtqueue_use_indirect(_vq, total_sg))
> +       if (virtqueue_use_indirect(vq, total_sg))
>                 desc = alloc_indirect_split(_vq, total_sg, gfp);
>         else {
>                 desc = NULL;
> @@ -1194,7 +1192,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>
>         BUG_ON(total_sg == 0);
>
> -       if (virtqueue_use_indirect(_vq, total_sg)) {
> +       if (virtqueue_use_indirect(vq, total_sg)) {
>                 err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
>                                                     in_sgs, data, gfp);
>                 if (err != -ENOMEM) {
> --
> 2.17.1
>

