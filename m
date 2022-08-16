Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE55954BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiHPILy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiHPIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C28581138
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660628214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7gwPm9xDUr2cS5ofMDcan9qf7hv2F2NrtQxh7A5E41E=;
        b=U00L7QtQgHspuYpwccuUZfF2iX/PiZXQ2M0x5ZCdP/1zszqOEWAxY2tDsWBRQlcYgGWx/8
        +8scAI+79nVESuvYSdHaJ0XZqf3PBi27GTZm/+X9shPW3QU175lhpFrZcVeyA/f2mfwtNm
        LRi8cXecoK3/V1QaAFQnCt7g7jJvRM4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-Yrmk5kl8Ow6vnVXm7Y03cA-1; Tue, 16 Aug 2022 01:36:46 -0400
X-MC-Unique: Yrmk5kl8Ow6vnVXm7Y03cA-1
Received: by mail-wr1-f71.google.com with SMTP id r17-20020adfa151000000b00224f8e2a2edso1140005wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7gwPm9xDUr2cS5ofMDcan9qf7hv2F2NrtQxh7A5E41E=;
        b=thceOW0MfWReW9A0+Bkvd9ROWjzRWV5/F8Q8TPVQVHDoqG4jiwZmKdLWJKf9PIO3MF
         bevT64mwBy/d+vCirTcI5PxtjJhTMy5tHyY4WZeft+D8JsquTAsIn7TCLTBXm1HDKIwv
         IvCu3W8mIr2r2/pKphrLB/scL6yKWr3tAUupebc7gOgFTGe6Of4k37pXodNuJyRTnLHK
         6GVF9x1FHxPYxHDvW10dS3RT/l/MYN5gBPnFqWKcMkTQON9IyYu5CcGwR3Oxa0jKquMi
         4HNQHu9jW+nZvgQRAef2gF9L6vryQT81N+KgHI8YVEWCIwu4Nwyjo0igZDkpvQLBqWpI
         MLVg==
X-Gm-Message-State: ACgBeo2kAfO4+LzvLur/m+DJ65R1W++14qIOBU+KGZp7HcRHTYuPf8V4
        AMuD8ie8N3Y7MeGb4iUfRhEwa+8YVkCS0R7x8byCr2Kl9f8dsOvJ68rF3vMRl0c4LZB3B2uNRZu
        dldfgrmNRy8stjc7tqYRxkUdaNoEG8BzKqqXKdz35/T9ElzUng0oWe2spDMfbbi0pi16iIg==
X-Received: by 2002:a05:600c:3492:b0:3a5:e1a0:24c9 with SMTP id a18-20020a05600c349200b003a5e1a024c9mr7684233wmq.177.1660628205057;
        Mon, 15 Aug 2022 22:36:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7cl47H6aW+psCSXTD8lf2D+3OkxsNSPvJV6zikekDWgdM77/QiAz5BzR9Prm3rV3l9dztplA==
X-Received: by 2002:a05:600c:3492:b0:3a5:e1a0:24c9 with SMTP id a18-20020a05600c349200b003a5e1a024c9mr7684208wmq.177.1660628204830;
        Mon, 15 Aug 2022 22:36:44 -0700 (PDT)
Received: from redhat.com ([2.55.4.37])
        by smtp.gmail.com with ESMTPSA id q65-20020a1c4344000000b003a327b98c0asm11713634wma.22.2022.08.15.22.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 22:36:44 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:36:41 -0400
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
        Greg KH <gregkh@linuxfoundation.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH v4 5/6] virtio: Revert "virtio_vdpa: support the arg sizes of
 find_vqs()"
Message-ID: <20220816053602.173815-6-mst@redhat.com>
References: <20220816053602.173815-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816053602.173815-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 99e8927d8a4da8eb8a8a5904dc13a3156be8e7c0:
proposed API isn't supported on all transports but no
effort was made to address this.

It might not be hard to fix if we want to: maybe just rename size to
size_hint and make sure legacy transports ignore the hint.

But it's not sure what the benefit is in any case, so let's drop it.

Fixes: 99e8927d8a4d ("virtio_vdpa: support the arg sizes of find_vqs()")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_vdpa.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 9bc4d110b800..832d2c5b1b19 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -131,7 +131,7 @@ static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
 static struct virtqueue *
 virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		     void (*callback)(struct virtqueue *vq),
-		     const char *name, u32 size, bool ctx)
+		     const char *name, bool ctx)
 {
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
@@ -168,17 +168,14 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		goto error_new_virtqueue;
 	}
 
-	if (!size || size > max_num)
-		size = max_num;
-
 	if (ops->get_vq_num_min)
 		min_num = ops->get_vq_num_min(vdpa);
 
-	may_reduce_num = (size == min_num) ? false : true;
+	may_reduce_num = (max_num == min_num) ? false : true;
 
 	/* Create the vring */
 	align = ops->get_vq_align(vdpa);
-	vq = vring_create_virtqueue(index, size, align, vdev,
+	vq = vring_create_virtqueue(index, max_num, align, vdev,
 				    true, may_reduce_num, ctx,
 				    virtio_vdpa_notify, callback, name);
 	if (!vq) {
@@ -288,9 +285,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			continue;
 		}
 
-		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, callbacks[i],
-						  names[i], sizes ? sizes[i] : 0,
-						  ctx ? ctx[i] : false);
+		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++,
+					      callbacks[i], names[i], ctx ?
+					      ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto err_setup_vq;
-- 
MST

