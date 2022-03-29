Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F874EA8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiC2Hv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiC2Hvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F2F71F0469
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648540181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lsR/34KqJqbBBpHRK+08f40lqnu5rbIFXnCvn3suC+k=;
        b=BNL3RNYL3PcPxhJfBz0Qm0HJQayLCdBpfS4L9eAlemeOhJKH8orvX2md/LP53Rgbdkjk7l
        XsdllckbxLTaLD1G4rXPHuTLLhEr/quveNDS82aVfvIVPBfDB8DQVBeISDtMjrfJ9giitv
        BdF8/ejjQXuVUvlnvlP8wQeoEgSJRns=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-0hyErVTbOxedsg8Z2ri00w-1; Tue, 29 Mar 2022 03:49:40 -0400
X-MC-Unique: 0hyErVTbOxedsg8Z2ri00w-1
Received: by mail-qv1-f70.google.com with SMTP id s14-20020ad4446e000000b00440d3810126so13147501qvt.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lsR/34KqJqbBBpHRK+08f40lqnu5rbIFXnCvn3suC+k=;
        b=1laiiTU8iJ75Mb3T3VcyLyobrn5K1GgsUPzt3LmjzcxnYcrmgr7KXc17YGkAKsnYtB
         R/hxUqb1QnPivg2XLx/se8T4uKeGL7yagNA0HvySr6KBZ/J3V6bgTMV0iTt1nXolDIKm
         u+UMlgZwFFhp4WppecIHHyx59oBpPkyWGQ/WC0laIju7/v9gNZ/1lYyv+pJgZpNq9BZF
         VfWsfYuLBVPJqCzuQdfjwJGevuE/yZs85DCeZ0u66ZRqHPx64GKS99SX+bAzCV6ol1qV
         YPo31XG5QPpYw1322snlKSrjobJ+meNIcXIPop7Tle602fpxx044F4yhDrJxGMpEwiCW
         Pv1w==
X-Gm-Message-State: AOAM533W860oFrJPwQTa6VtOybE3U0BccytOt/80htNJ9oWZMB/LQY83
        18Bym8JGaJ3x2mobGGKpUt1/yo3tW2g8Ca+Q0YCHqq57oK6AYJv7KeeYOxoNf0qA6bRg4+wta2I
        kJ8aRy3Y8HtWg7gpUzgJ0RaPa
X-Received: by 2002:ac8:5743:0:b0:2e1:cee6:f15 with SMTP id 3-20020ac85743000000b002e1cee60f15mr26099601qtx.634.1648540178444;
        Tue, 29 Mar 2022 00:49:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF88WnyEL92F591a91CJkQdQTk0tHBD5HJOhEHqqmJn3s+62AbX5AdLhjztsk5SSSRj9HebA==
X-Received: by 2002:ac8:5743:0:b0:2e1:cee6:f15 with SMTP id 3-20020ac85743000000b002e1cee60f15mr26099593qtx.634.1648540178179;
        Tue, 29 Mar 2022 00:49:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-67.retail.telecomitalia.it. [79.46.200.67])
        by smtp.gmail.com with ESMTPSA id bs32-20020a05620a472000b0067d4560a516sm9478080qkb.32.2022.03.29.00.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:37 -0700 (PDT)
Date:   Tue, 29 Mar 2022 09:49:32 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio_ring: remove unnecessary to_vvq call in vring
 hot path
Message-ID: <20220329074932.5wtyi7fd7ud5dedd@sgarzare-redhat>
References: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 06:58:16PM +0800, Xianting Tian wrote:
>It passes '_vq' to virtqueue_use_indirect(), which still calls
>to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
>unnecessary call of to_vvq in hot path.
>
>Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>---
> drivers/virtio/virtio_ring.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>index 962f1477b1fa..d597fc0874ec 100644
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

