Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75B8565CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiGDRRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiGDRRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1C5412779
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656955059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSo0TPjRmSn1V/oaklydrMSZvzy1inQBu0gNIodOnPc=;
        b=i8aJiXoiZVgoqqdZffZAuGmnUphRKLHERKbsuf0YTC9HAqNxMBrw4BreW2ARR8vsE0lvEA
        2J4E1NsFslyvZ3ToyKEELG5bYXgpQveYcqkJs82yu3Qxrt4vs4dXrBVu3UcVAkaZirnlN2
        SES9JA0JgPJJeNAozRC0ji6NPPomfN4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-6hB6NocWNQeZfV2rXRfsfQ-1; Mon, 04 Jul 2022 13:17:38 -0400
X-MC-Unique: 6hB6NocWNQeZfV2rXRfsfQ-1
Received: by mail-qt1-f200.google.com with SMTP id m6-20020ac866c6000000b002f52f9fb4edso7303558qtp.19
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 10:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tSo0TPjRmSn1V/oaklydrMSZvzy1inQBu0gNIodOnPc=;
        b=xlPgPtzP4xNGtQiO0ye7TS9T+SW7FQH48nUtvOvgx1k1W9G/dEwsIJepT6qrgiZSxk
         HshCKbzKOh2KeHkyQu7eGRcCD0mbpUkEWRjQVfXl/EBdoc21WYcK5K3I4tMgMJZnwFfI
         iJJJYNKT8Ops9ZnPD9sJr7++MPiK65iLKo0kPoAqcRYug+UhevLKut933AeITv0ANUjg
         S3y9MoHLx8A/+b/OoDCfU++FIAS6mYhIFSlx9jgF+1ojydeBe+5YmVrWUSXCxmV1vEo0
         j8nFtNl3RoNc5/RWyuedzmF0fd8WMt8U1CnAIUb5/iaJr4mpd1Yfh2oYKPeAo9ndrDsl
         nisA==
X-Gm-Message-State: AJIora9DZNxzJQhr5qTAqNX1c0C9HlOjqc76SWNoLplLQBQwGGDBsGc8
        7Ca1CSC30a6VtS8GkzReWbumi3lAwDqIVqckjBu8EUl6WDe9naL0NyZu8IZeNbZctyZbtY+3BKk
        6i6Z6v6otc141DU9ExbX8JDTN
X-Received: by 2002:a05:620a:2697:b0:699:cca7:f8b2 with SMTP id c23-20020a05620a269700b00699cca7f8b2mr20820466qkp.738.1656955058185;
        Mon, 04 Jul 2022 10:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uc6e9t+TDjozVIHS20Xkm/89T4WuJyrekSiGRvrPx9nG54HgL0oXw8KiDuQ3MmSutE1rHC3Q==
X-Received: by 2002:a05:620a:2697:b0:699:cca7:f8b2 with SMTP id c23-20020a05620a269700b00699cca7f8b2mr20820452qkp.738.1656955057917;
        Mon, 04 Jul 2022 10:17:37 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id y7-20020a37f607000000b006a75e8d920bsm10788838qkj.88.2022.07.04.10.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:17:37 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 4/6] tools/virtio: move feature negotiation in vdev_info_init()
Date:   Mon,  4 Jul 2022 19:16:59 +0200
Message-Id: <20220704171701.127665-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704171701.127665-1-sgarzare@redhat.com>
References: <20220704171701.127665-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature negotiation are per device, so it' s better to move them
earlier in vdev_info_init() since vhost_vq_setup() contains the code
to initialize virtqueue.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/virtio_test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 765e64895dab..2d8a3e881637 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -69,7 +69,6 @@ void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
 {
 	struct vhost_vring_state state = { .index = info->idx };
 	struct vhost_vring_file file = { .index = info->idx };
-	unsigned long long features = dev->vdev.features;
 	struct vhost_vring_addr addr = {
 		.index = info->idx,
 		.desc_user_addr = (uint64_t)(unsigned long)info->vring.desc,
@@ -77,8 +76,6 @@ void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
 		.used_user_addr = (uint64_t)(unsigned long)info->vring.used,
 	};
 	int r;
-	r = ioctl(dev->control, VHOST_SET_FEATURES, &features);
-	assert(r >= 0);
 	state.num = info->vring.num;
 	r = ioctl(dev->control, VHOST_SET_VRING_NUM, &state);
 	assert(r >= 0);
@@ -149,6 +146,8 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 	dev->mem->regions[0].memory_size = dev->buf_size;
 	r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
 	assert(r >= 0);
+	r = ioctl(dev->control, VHOST_SET_FEATURES, &features);
+	assert(r >= 0);
 }
 
 /* TODO: this is pretty bad: we get a cache line bounce
-- 
2.36.1

