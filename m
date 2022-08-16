Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509DB5954B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiHPILh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiHPIKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 528DE67C96
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660628200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Woc1p74LnDMz9TXkvyQIlZ2BlUNGXfNgs76Y3D9lgg=;
        b=I/neypUbeR2iAOHmGEfxaVrLFBUV08yHmcmbsarmc6S2IBFRjj3Anf5ZMpgFLFGA0zGq0C
        fJlWabcuY1itR62OFBM7KI8IBCcnqSJshqwVPCc21+kSBDCQeR0+7QjpzZdpthlKq+RjuJ
        q6eSh2YucMJnPcm3FmNHQ9Qj/OkR3IU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-300-wq30lc0kN8Sn4qeZUYTQdQ-1; Tue, 16 Aug 2022 01:36:38 -0400
X-MC-Unique: wq30lc0kN8Sn4qeZUYTQdQ-1
Received: by mail-wm1-f69.google.com with SMTP id i132-20020a1c3b8a000000b003a537064611so4462835wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0Woc1p74LnDMz9TXkvyQIlZ2BlUNGXfNgs76Y3D9lgg=;
        b=X1ulHijKPneqX8Xwbfh+gi9MxNDpNMJhAJ1m6abJ3vdl0NonsRrdS0nEptIvi2Uuly
         ZR7lVgFV4BVk5rmPcfAh7Zf8jDOUwTSuzS1OKGJKgt38pmVHUgtGWchdFtztIjRZ9oJV
         k43iiPYKqdBZMmuR1hVROUOPfSNfViARbjWWAq0XB8d61CSxx562Oye/Gr86vdbF3DP0
         SQY79LxOr8q5jHw6WEpffVOLEnVAEkkpb//+sCns7rJNEE1DlBFYmSDopT6GdwADGwO0
         4t32FRMDFoUSvlr0eeomd8fWRwS2d7Umptt5qRBB3lxE3dFPvBNPQ7TR5+B5fB3qy/Jw
         zVhg==
X-Gm-Message-State: ACgBeo32Z7hqDguIbF0hmAK4VdVFCcCDFhURJO4ycfuJ2PpPcct1UTUu
        th24hp9JCCnuq/5khbt3HXlt7nL/WSOeaYis5dhKLPSk03rDJYDRin9xLP+F3Mbduedu0qKyScm
        r1K8Z30KZ8EvThrJhYLQtk1F3mIqxwrYlrr2xpOb5TXaS3FxZWoR9VTPpNZaLI2p5R36xyA==
X-Received: by 2002:a5d:6312:0:b0:220:6820:57d7 with SMTP id i18-20020a5d6312000000b00220682057d7mr10333261wru.8.1660628195741;
        Mon, 15 Aug 2022 22:36:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5lfJNXkB52mr103dHeF1YNUqGQn4R8ZmPcZt7Bv3gQF4wEpKRHrZVkPc9XrO/DSv/ceTxJOA==
X-Received: by 2002:a5d:6312:0:b0:220:6820:57d7 with SMTP id i18-20020a5d6312000000b00220682057d7mr10333235wru.8.1660628195428;
        Mon, 15 Aug 2022 22:36:35 -0700 (PDT)
Received: from redhat.com ([2.55.4.37])
        by smtp.gmail.com with ESMTPSA id ba11-20020a0560001c0b00b002235eb9d200sm9225278wrb.10.2022.08.15.22.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 22:36:34 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:36:32 -0400
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
Subject: [PATCH v4 3/6] virtio-mmio: Revert "virtio_mmio: support the arg
 sizes of find_vqs()"
Message-ID: <20220816053602.173815-4-mst@redhat.com>
References: <20220816053602.173815-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816053602.173815-1-mst@redhat.com>
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

