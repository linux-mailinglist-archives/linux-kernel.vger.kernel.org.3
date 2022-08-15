Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3DA5951FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiHPF1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiHPF1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96EB724B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660600838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bnInJhTNmcRkk5WIZQp/adh2w/55qWjBovtngHxo1PM=;
        b=EHiMupOJ2icYjOXVQ8sFxh3ko4sXMrIsr1zUjvxgs2aZ2xlNXKOVwuIbtfqcTrgo9pEjNB
        +9h++a7QLDe7Vq4zfaMRKjME/FqhPMgaBrWboaHEQrVlh2BvP96jVbtn13Za7qCsvvuiNj
        ZADl3pbeZ7R/Ve5a/OJ38NwC46IhjlQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-270-Gstdbta0PAyhY_TmsxDQ3A-1; Mon, 15 Aug 2022 18:00:37 -0400
X-MC-Unique: Gstdbta0PAyhY_TmsxDQ3A-1
Received: by mail-wm1-f69.google.com with SMTP id a17-20020a05600c349100b003a545125f6eso9253259wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bnInJhTNmcRkk5WIZQp/adh2w/55qWjBovtngHxo1PM=;
        b=hLeOPUBSywm/wWfPIXxhBVdkqZhUGzjTA3wnL59A+quAwc1+QRLaN5h4Icel6nEqGf
         lnort6pPYIdYmyeqjWcKy0hUHvPZ1oyTiLYJVwsQ6o7bCJKGQRxdX8JUxU+VOiAFy9+o
         a6DMpI+xhtC5nQ8fMS+kL0OoYZvKGB/dcueF/8qTYMsVG5GYFzvfqwOFIAY2OOgdt7VS
         XL7cHm2VY9u+kSezzJy669eeb2FDdyO9RUzDz5pOdp4jAOaDpBmOjga0UJsG+kv9zKbo
         oihDUE+Z5CGdAp4ZfeY4Cgxlcv4QrK6JurwQmz/xmQfqq23ofrAKh0gekEYO1Gd1jS3Z
         Wu5Q==
X-Gm-Message-State: ACgBeo3h9PhGix9X/jR5sVllDaCbr4Shv0zkxUQm/QoPtCKSOA1GZ9Rf
        l/hZAegs5EqGZwFCKw99kFtEKPJ9TtCh1pGYJno33aorSHj9K7qTmdnATx3yaTGgFkVrbmvwmF2
        ZEGhZlndzPefUVjW2VmG8SqKah5gRQef9HjiJgovzE3W18wCn79qPmEpcZkt4MtrQK8sfPg==
X-Received: by 2002:adf:fe0d:0:b0:220:5df9:e5cf with SMTP id n13-20020adffe0d000000b002205df9e5cfmr10037606wrr.332.1660600836275;
        Mon, 15 Aug 2022 15:00:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7neOEEnsfPvVNfIdJ1DGmTNBVQIoh+gohySWeq1ab7WHyHnV34ZmbBICAeo695PHmm06CKHw==
X-Received: by 2002:adf:fe0d:0:b0:220:5df9:e5cf with SMTP id n13-20020adffe0d000000b002205df9e5cfmr10037579wrr.332.1660600835925;
        Mon, 15 Aug 2022 15:00:35 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id r187-20020a1c44c4000000b003a5f2cc2f1dsm6101446wma.42.2022.08.15.15.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 15:00:35 -0700 (PDT)
Date:   Mon, 15 Aug 2022 18:00:31 -0400
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
Subject: [PATCH v3 2/5] virtio: Revert "virtio: add helper
 virtio_find_vqs_ctx_size()"
Message-ID: <20220815215938.154999-3-mst@redhat.com>
References: <20220815215938.154999-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815215938.154999-1-mst@redhat.com>
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

This reverts commit fe3dc04e31aa51f91dc7f741a5f76cc4817eb5b4: the
API is now unused and in fact can't be implemented on top of a legacy
device.

Fixes: fe3dc04e31aa ("virtio: add helper virtio_find_vqs_ctx_size()")
Cc: "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 6adff09f7170..888f7e96f0c7 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -241,18 +241,6 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 				      ctx, desc);
 }
 
-static inline
-int virtio_find_vqs_ctx_size(struct virtio_device *vdev, u32 nvqs,
-			     struct virtqueue *vqs[],
-			     vq_callback_t *callbacks[],
-			     const char * const names[],
-			     u32 sizes[],
-			     const bool *ctx, struct irq_affinity *desc)
-{
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, sizes,
-				      ctx, desc);
-}
-
 /**
  * virtio_synchronize_cbs - synchronize with virtqueue callbacks
  * @vdev: the device
-- 
MST

