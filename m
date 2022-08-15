Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC6A5951FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiHPF1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiHPF1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 022D410EECE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660600843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Woc1p74LnDMz9TXkvyQIlZ2BlUNGXfNgs76Y3D9lgg=;
        b=D7V4RiBI/pfDwGyUESH50z/jt2lPEedE44Uij4syI+LjHM2XF64Isnp9+tnGyHYRJCgSgf
        FQWfJfAFIxAxSMSolLK5c+YKe6MnSjfCedtWiA0e1pCnOsRyou1iIdkXbwwZOLI2PBcGQ4
        6+htoKh7m2Z6wD9zj6B1qkDPAC+d5BA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-eF75X6_jNv2688jlcrN8oA-1; Mon, 15 Aug 2022 18:00:41 -0400
X-MC-Unique: eF75X6_jNv2688jlcrN8oA-1
Received: by mail-wm1-f71.google.com with SMTP id 133-20020a1c028b000000b003a5f307844bso1306825wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0Woc1p74LnDMz9TXkvyQIlZ2BlUNGXfNgs76Y3D9lgg=;
        b=M0SolRwFesLpomFH19ncoU+rw4C2pzH6WpgPBPJmCYYWdhglC78ws/MW/mrBwKEe4F
         wYjUZjFTpbeqdOMfjhzCts+EggMOdJpcEjhiQcQHBTFnM47kp2MRFSUbET3nheWxaP/Z
         jM4+4F+rNBPYIUHiw1cw75UZUsLOIRRJ/RxhaFcgwB5RoqQ/0NHeCREDbIr5Q+z8L+ka
         nJNnC/JOF7HVnGgz8og9CwN6EoELlypgsXg/+Wbx3LxGM/kl0SS2Ypjxm+u6DwdS87uH
         K4XBEKUIcmi9uOX7A9e8NJQ+hCwvI4ESeXWDTKz067bvcLLE5bAYLCzxvQUfMZ3ihCln
         tccg==
X-Gm-Message-State: ACgBeo1OPG20hfvP0oCXWCHfT5fEWHBAudqQoIcjCgFlxy9b8M8ktdgZ
        Wz1z84YFvxm8QCOLZhZdSftfhu0xyeKLBRHtdk1w5u08wUNEh+AhPlYwbSIC/0W96PKslSX/9UN
        +MJfkzyLr+wvngw15aka/UsN5tBIw0dREv9jqkJj0P5XhcMHEJt8x4EqEH31Gz0xxo/XvkA==
X-Received: by 2002:a5d:4705:0:b0:21f:3890:8619 with SMTP id y5-20020a5d4705000000b0021f38908619mr9636846wrq.104.1660600839879;
        Mon, 15 Aug 2022 15:00:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5NxSuUyDWQq7UInnZ68N9WtAPaKK7deSifgf1qRjxa6/C2abrrgR1eXC9qHiVHNg4n83AbHg==
X-Received: by 2002:a5d:4705:0:b0:21f:3890:8619 with SMTP id y5-20020a5d4705000000b0021f38908619mr9636823wrq.104.1660600839647;
        Mon, 15 Aug 2022 15:00:39 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b00223b8168b15sm8326754wrf.66.2022.08.15.15.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 15:00:39 -0700 (PDT)
Date:   Mon, 15 Aug 2022 18:00:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v3 3/5] virtio-mmio: Revert "virtio_mmio: support the arg
 sizes of find_vqs()"
Message-ID: <20220815215938.154999-4-mst@redhat.com>
References: <20220815215938.154999-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815215938.154999-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fbed86abba6e0472d98079790e58060e4332608a.
The API is now unused, let's not carry dead code around.

Fixes: fbed86abba6e ("virtio_mmio: support the arg sizes of find_vqs()")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_mmio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index c492a57531c6..dfcecfd7aba1 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -360,7 +360,7 @@ static void vm_synchronize_cbs(struct virtio_device *vdev)
 
 static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int index,
 				  void (*callback)(struct virtqueue *vq),
-				  const char *name, u32 size, bool ctx)
+				  const char *name, bool ctx)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct virtio_mmio_vq_info *info;
@@ -395,11 +395,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 		goto error_new_virtqueue;
 	}
 
-	if (!size || size > num)
-		size = num;
-
 	/* Create the vring */
-	vq = vring_create_virtqueue(index, size, VIRTIO_MMIO_VRING_ALIGN, vdev,
+	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
 				 true, true, ctx, vm_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
@@ -503,7 +500,6 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		}
 
 		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
-				     sizes ? sizes[i] : 0,
 				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			vm_del_vqs(vdev);
-- 
MST

