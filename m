Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237D9594E69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 04:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiHPCD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 22:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiHPCCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6884A220BAA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660600430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Woc1p74LnDMz9TXkvyQIlZ2BlUNGXfNgs76Y3D9lgg=;
        b=gQy0pOCuABmxJxl68Yu24XbuqdXNkPrR3EMBsdIIthe8mL1+Rdp8YKxhbBE3XE2Q6ncgpz
        NfmwUbnoE94v5mm7NRAaf2qzNIm/FUGlx9/qzJFrAjsCANGl6Zu7bc77/Sjm6XBUbT4+xf
        Y0kkE7LzCiQ7PWgBdaUBU4kul1Yrey8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-3s6TYtLKOTaMlCPWPBUg-w-1; Mon, 15 Aug 2022 17:53:49 -0400
X-MC-Unique: 3s6TYtLKOTaMlCPWPBUg-w-1
Received: by mail-wr1-f71.google.com with SMTP id m2-20020adfc582000000b0021e28acded7so1482204wrg.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0Woc1p74LnDMz9TXkvyQIlZ2BlUNGXfNgs76Y3D9lgg=;
        b=bS6LKRNnFF6VUgcIQgq/ijdv+ZXJIcsbqnAMR6o4BNkzHWBcVJd91bhwokmB/DHUmy
         7JCx6vQZIVjHWte93Dn9C/bW4EGZixLRFVjUtZzziIv1WjxwkBv+iUZTU1//TnyICeWN
         fAfR0VTukm3Ci9GML3eVztTx41wD6G/3JknvGdVwiJY2ud2yy/V3nDoMArAAzh8vy6lr
         5kd9KGInZnqz2NjU/yrUoMtxCpQviFANuIkJY0M60pQBb7g7UJ0jHcJja9nwJ88KyXHj
         KbV9D7DRIixmPZcre4mZNl5Rj1qXp6xwmJsdWOsmL+sUo0shrlUJWumTU0p2o3qAHn2/
         /Mrw==
X-Gm-Message-State: ACgBeo3UPou5T8EbevL/+RZ8JHpizXi7urLz5N5DNMzGz0YLhlmWK0zw
        in6i97wgMPi2YCN9yfjgY7tvrFzp0SMP6UdjJoDHkh5rlTHECh8FC32YDz9bV7Z/N79ejq3TzKF
        Mb/8hMUg9OCU5Wjdi0ujL/Y2oO9LTHO5IWednTIAZFMCD5LfGhsbJgVvDT+yoUvnV6QkuHA==
X-Received: by 2002:a05:600c:ad4:b0:3a5:50b2:f991 with SMTP id c20-20020a05600c0ad400b003a550b2f991mr16731051wmr.146.1660600426266;
        Mon, 15 Aug 2022 14:53:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7WhVEK8u+bWBQ+vsIP1p2ogF6bjbQsW8dmESOECqvboXglS7PHGAZ3CszZnuGHypllX9oYGw==
X-Received: by 2002:a05:600c:ad4:b0:3a5:50b2:f991 with SMTP id c20-20020a05600c0ad400b003a550b2f991mr16731025wmr.146.1660600425942;
        Mon, 15 Aug 2022 14:53:45 -0700 (PDT)
Received: from redhat.com ([2.55.4.37])
        by smtp.gmail.com with ESMTPSA id n32-20020a05600c502000b003a2d47d3051sm13154371wmr.41.2022.08.15.14.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:53:45 -0700 (PDT)
Date:   Mon, 15 Aug 2022 17:53:42 -0400
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
Subject: [PATCH v2 3/5] virtio-mmio: Revert "virtio_mmio: support the arg
 sizes of find_vqs()"
Message-ID: <20220815215251.154451-6-mst@redhat.com>
References: <20220815215251.154451-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815215251.154451-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

