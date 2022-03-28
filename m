Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8F04E90BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbiC1JHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238697AbiC1JG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5501612AD3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648458317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dazmAAoQFVivnRUQJ98F5Rcg+F0tp/OFcYuPcUPV2Z4=;
        b=D1woTACaPeUFb3U7pxERaCtKp/372WkeBvCgb9AGsYjqi2h1obp0iPPbNn/mwgG9Xhtph0
        318zl3iBqBtj7ES28nc4oOcgK+M00oXs1BlxFUvY6xDmugqd77tXKljl0HzfQXeG4cEj1n
        eTHWu85CEZ1MtQDUl+iRmg91gv1DJdU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-6MGl-1R1MAOCKE4QWlAW3A-1; Mon, 28 Mar 2022 05:05:16 -0400
X-MC-Unique: 6MGl-1R1MAOCKE4QWlAW3A-1
Received: by mail-qv1-f69.google.com with SMTP id d11-20020a0cffab000000b00440f965f77cso10903348qvv.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dazmAAoQFVivnRUQJ98F5Rcg+F0tp/OFcYuPcUPV2Z4=;
        b=xXd7LxrUw18+GJYjKK3LrBZ2sQ9mlWc5VlJptwjaIjF6ZfapuF9NMG/Jr/pxaDNAOX
         mRl7c0Qve2i1JOeppe5vLPKbhIxMHcD1Ghr1ieVGgH8bbRwN+ahZdrlXjRkeXRPPYj5v
         NcFQe0gR4PSXYxJE66ie5hEBXi9RUuOO4P7Fe3lNquyeSR6OfIHDn8Z7POBiu9xUX2WR
         q2Rtdb5WrLaPmLIcH72birj4L9e5g/jpBunnL4rXhG4rKCdir7hMMS7M/mirAnFbQ/20
         KtdNztSB4DbF0v7ubJMrVYSxSAiV0VoLFEV+gfelprQecnJ4VZH+UVvy7bDMZLzBBsRO
         NnXg==
X-Gm-Message-State: AOAM533VDpNjmEvNqFdlXrpzFOGt4aNPzR+Y4MmpKKhU/QYzWXW9ZfRc
        S5cRCfPtscHLN1kQfAjV6qZ6cxS/VvF4fV3RQIogepxErNfJzuYJ6zeWpEwp7NwdYFAqgTnIdoW
        g07USZvMjSfLkFzdxpSs+xYOM
X-Received: by 2002:a37:b986:0:b0:680:4b6b:893d with SMTP id j128-20020a37b986000000b006804b6b893dmr14824662qkf.98.1648458315733;
        Mon, 28 Mar 2022 02:05:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyp+dxtmyBke0/hVE2RSfvhkWtdTPytf1c5FXG5YXQIuysovYo1EKmn66JOnErH+703DCeLPQ==
X-Received: by 2002:a37:b986:0:b0:680:4b6b:893d with SMTP id j128-20020a37b986000000b006804b6b893dmr14824645qkf.98.1648458315455;
        Mon, 28 Mar 2022 02:05:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-67.retail.telecomitalia.it. [79.46.200.67])
        by smtp.gmail.com with ESMTPSA id o21-20020ac85a55000000b002e16389b501sm12175863qta.96.2022.03.28.02.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 02:05:14 -0700 (PDT)
Date:   Mon, 28 Mar 2022 11:05:03 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq call in vring hot
 path
Message-ID: <20220328090503.wk5idknhwsbunkjs@sgarzare-redhat>
References: <20220324073340.632656-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220324073340.632656-1-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 03:33:40PM +0800, Xianting Tian wrote:
>It passes '_vq' to virtqueue_use_indirect(), which still calls
>to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
>unnecessary call of to_vvq in hot path.

It seems reasonable to me.

>
>Other tiny optimization:
>Add unlikely to "if (vq->vq.num_free < descs_used).

Better to do this change in another patch.

Thanks,
Stefano

>
>Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>---
> drivers/virtio/virtio_ring.c | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>index 962f1477b1fa..ab6d5f0cb579 100644
>--- a/drivers/virtio/virtio_ring.c
>+++ b/drivers/virtio/virtio_ring.c
>@@ -205,11 +205,9 @@ struct vring_virtqueue {
>
> #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>
>-static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
>+static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
> 					  unsigned int total_sg)
> {
>-	struct vring_virtqueue *vq = to_vvq(_vq);
>-
> 	/*
> 	 * If the host supports indirect descriptor tables, and we have multiple
> 	 * buffers, then go indirect. FIXME: tune this threshold
>@@ -507,7 +505,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>
> 	head = vq->free_head;
>
>-	if (virtqueue_use_indirect(_vq, total_sg))
>+	if (virtqueue_use_indirect(vq, total_sg))
> 		desc = alloc_indirect_split(_vq, total_sg, gfp);
> 	else {
> 		desc = NULL;
>@@ -527,7 +525,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> 		descs_used = total_sg;
> 	}
>
>-	if (vq->vq.num_free < descs_used) {
>+	if (unlikely(vq->vq.num_free < descs_used)) {
> 		pr_debug("Can't add buf len %i - avail = %i\n",
> 			 descs_used, vq->vq.num_free);
> 		/* FIXME: for historical reasons, we force a notify here if
>@@ -1194,7 +1192,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>
> 	BUG_ON(total_sg == 0);
>
>-	if (virtqueue_use_indirect(_vq, total_sg)) {
>+	if (virtqueue_use_indirect(vq, total_sg)) {
> 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> 						    in_sgs, data, gfp);
> 		if (err != -ENOMEM) {
>-- 
>2.17.1
>

