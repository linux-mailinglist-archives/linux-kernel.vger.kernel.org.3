Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F57594E66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 04:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbiHPCDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 22:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiHPCBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46562220B89
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660600424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bnInJhTNmcRkk5WIZQp/adh2w/55qWjBovtngHxo1PM=;
        b=LvyEx60idQ/fjXGx+vQMMOZ7NVMIO5WyMH2VgKkrAByxB1RkL1A3JR+t/3kNp5qG45I5R3
        9PTbKouLnDJ2ADFaqVkKSh4dFW2XPoqbQjIj5QuvMtliMcRQM0BOLOUnumhyF7CD+rMAtE
        vLhkCaJ8SVd1LVkXaLPnR1T2GabXAsg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-210-0b67NieTN_CNN0ZpF6KnbQ-1; Mon, 15 Aug 2022 17:53:43 -0400
X-MC-Unique: 0b67NieTN_CNN0ZpF6KnbQ-1
Received: by mail-wm1-f70.google.com with SMTP id i132-20020a1c3b8a000000b003a537064611so4048586wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bnInJhTNmcRkk5WIZQp/adh2w/55qWjBovtngHxo1PM=;
        b=ya2EpO5NnpLycK2aZnWVxsXXMkZlC5mYagSMMlycktQ4vkL3bdiwE+MC8r6fO87dYi
         ofiUVCco0Ufx+LR87CWixbFhKn2AMnVdVkXviA+6UWPpnZqTbd7bh5IUbQP735gtiyQ7
         nxpNUo2tJJ3VxblCakgrNVOTjXN+KKcYlfpd+dpJrRR32W/YXsl/V8nt0Onru8g6hHOQ
         xdVaOxKZObzMX581Yp0Z7ryuZXX6RvMz2C4ApvPYD8VtWXAS9o5VV+hp3nPlHixPhwQt
         8nLrSXA8fe6Tp9+folKTBKhUBGmXs8N8op/x9+nigLzlSrm/2OMAjuC8Oo2VM0dmSMcQ
         H57w==
X-Gm-Message-State: ACgBeo3/xU3vNFQUilBFoULpB+L+iV3hxiQp9zyfjC6804Vgwpqak/Gc
        9KiUlWUzesGP5bC/rIx3UaGEY+anhuz4E7zlwTVIDdsBDCEvCbsr02FqK9YGAOBvRrfQDq+SYPj
        SfS77/868/DwUI42x2VK/w8yVElLUoezTSHk/kwe9Ri9L8+c8r246QpvdaSaz2Tw3VxqgJQ==
X-Received: by 2002:adf:eb8e:0:b0:223:a1f6:26b2 with SMTP id t14-20020adfeb8e000000b00223a1f626b2mr9621611wrn.216.1660600422363;
        Mon, 15 Aug 2022 14:53:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4jlIHrGyk0NQDFhbHw+XilfZD0zV7zttfZd98h/WsQfsn3+HtdmVcfipmuVvb8Tr8KPbBRvA==
X-Received: by 2002:adf:eb8e:0:b0:223:a1f6:26b2 with SMTP id t14-20020adfeb8e000000b00223a1f626b2mr9621582wrn.216.1660600422078;
        Mon, 15 Aug 2022 14:53:42 -0700 (PDT)
Received: from redhat.com ([2.55.4.37])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600010c300b002217339ce90sm8455090wrx.8.2022.08.15.14.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:53:41 -0700 (PDT)
Date:   Mon, 15 Aug 2022 17:53:38 -0400
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
Subject: [PATCH v2 2/5] virtio: Revert "virtio: add helper
 virtio_find_vqs_ctx_size()"
Message-ID: <20220815215251.154451-5-mst@redhat.com>
References: <20220815215251.154451-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815215251.154451-1-mst@redhat.com>
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

