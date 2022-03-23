Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F714E4E93
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbiCWIvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242906AbiCWIvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E9F473066
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648025405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VkoZGCDazaob935cf0K6/xqwp1grV8y7vA1EUagsdw8=;
        b=E2BLsoaRp7bqL5g54mC9rJgYyG8Oreov6JgY9i+5FDTRrV+kHKiIcDKJ8ZJyPagL61l0D1
        1xArt7LRazHcNe9GEXeMdblW98ye7B4P08ek/rNVNy0WmeShhXdbC573wSRc6MGJrPvdCE
        +9+j9S6w/mWpmmOn7rFPIum5tl+4ZYE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-LWe4_xpFN_WCNeQbyvw0SA-1; Wed, 23 Mar 2022 04:50:04 -0400
X-MC-Unique: LWe4_xpFN_WCNeQbyvw0SA-1
Received: by mail-qk1-f199.google.com with SMTP id i2-20020a05620a248200b0067b51fa1269so544372qkn.19
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkoZGCDazaob935cf0K6/xqwp1grV8y7vA1EUagsdw8=;
        b=JjtMsfCIOhnD99HHUobP2ZaO1trtHLb0rfoBe///3Wow6LbkAVPtVkGZnYcghHNgs6
         lVwLN5bOEaZ0o3wtuIcc/4gxZcSkvjQDEgd8wpYXGlP2H2lbx2+kz19cadGC6GN5F54u
         2KRWM7enAbJn+pUc0CQWGd06ZUEJAU8CWJ0CgkAnWTW9s3T9yim7XhHK9ik5RomUqvnL
         fOQcEctaNexVzl/HK4gevpjYFwtPiO6SmfytqQcAqSBwMD8vV/CNjHQeJdSYNBhgLMzX
         mO9XZw8+PqsTmS+6QjKcELeV4Bm84vSmZyP6zio3uJI9VeiSEUSnoyGiNqaIIlUfgz+C
         M4Iw==
X-Gm-Message-State: AOAM532pA9FWw9UVGbN9UvYjIkvDG/hKso+8+e2GR9cECAzSDbrZRLqP
        gexIynQ+9RuW5AHFLRP+Zd0NjqjYKPyr+O7GVnU6oZabwmWAntXiqcF2TZ1+yc/Zf4g8h3ZNEfz
        NoRs6BGTMiF7Gi+kYKLOqtIer
X-Received: by 2002:a05:620a:1a92:b0:67d:b2c2:8311 with SMTP id bl18-20020a05620a1a9200b0067db2c28311mr17908330qkb.594.1648025404185;
        Wed, 23 Mar 2022 01:50:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylURIbsHFC5CVM0PxCcg9Ie4RCz+seln0B3QhsU0NKbzEwgOSb1+E5im+z84ivzzgUFUDiHg==
X-Received: by 2002:a05:620a:1a92:b0:67d:b2c2:8311 with SMTP id bl18-20020a05620a1a9200b0067db2c28311mr17908319qkb.594.1648025404003;
        Wed, 23 Mar 2022 01:50:04 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-114.business.telecomitalia.it. [87.12.25.114])
        by smtp.gmail.com with ESMTPSA id j188-20020a3755c5000000b0067d1c76a09fsm10640609qkb.74.2022.03.23.01.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 01:50:03 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Arseny Krasnov <arseny.krasnov@kaspersky.com>,
        "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Asias He <asias@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 1/3] vsock/virtio: enable VQs early on probe
Date:   Wed, 23 Mar 2022 09:49:52 +0100
Message-Id: <20220323084954.11769-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323084954.11769-1-sgarzare@redhat.com>
References: <20220323084954.11769-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio spec requires drivers to set DRIVER_OK before using VQs.
This is set automatically after probe returns, but virtio-vsock
driver uses VQs in the probe function to fill rx and event VQs
with new buffers.

Let's fix this, calling virtio_device_ready() before using VQs
in the probe function.

Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 5afc194a58bb..b1962f8cd502 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -622,6 +622,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
 	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
 
+	virtio_device_ready(vdev);
+
 	mutex_lock(&vsock->tx_lock);
 	vsock->tx_run = true;
 	mutex_unlock(&vsock->tx_lock);
-- 
2.35.1

