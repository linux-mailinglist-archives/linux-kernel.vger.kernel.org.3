Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4794E57A9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbiCWRiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343741AbiCWRiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 790E97EA00
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648056997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/auHUunRKmj44ZRhZ4Uljn8hCNOGxN6qXBgu6Qo8Sg=;
        b=QKHyfpuRSUuiZJtghqAfKumY87h4n23tRuTtMD6kWlm1KMgNuIscxae+pxJ05Vv/aAs6Mu
        MSMUOzUBCf0YJuorfzB6UMoINsDOCPxpG36Rddji/EyGNMoakqzvKt/7ZqVMlqSchW3Se4
        uN9kzc9f7i+MwHc+d8fnZbFE0YEt+vA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-9PCtHSzuPSalO9GqmRquQQ-1; Wed, 23 Mar 2022 13:36:36 -0400
X-MC-Unique: 9PCtHSzuPSalO9GqmRquQQ-1
Received: by mail-qk1-f197.google.com with SMTP id y140-20020a376492000000b0067b14129a63so1469856qkb.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/auHUunRKmj44ZRhZ4Uljn8hCNOGxN6qXBgu6Qo8Sg=;
        b=6YJ8J8Cmvp7pPB58o6XMMxYxfjZWM6/BrlL3uiLKGg6G4exA7pkB2xcJLde5QAnnvc
         NDMrPilN6mn5lSThe6Znk8d/JDTDGGc5fUlkcQOdkHM+XrIsydJav6EkCrs25UNrhbgi
         iCHtxisZJ/DdslWDNoJ8SEbRYWNF/cWItvvfeoS7SVo0LyWDI3x/gLM5sjaouWrOfZ+6
         8D9xUm5WMy3yA/r3IyYZX/i8/mPOiWPnN6gxMjTeOL+Mflz/AdWQTxOeE4hgJ+QGTDsy
         qznV9L9r+7s6OODHtHCEdr4z7/bhGMHGvHSSGbsua5DCaaTUSVp7L56sgxNwDD9gAO7x
         Md5g==
X-Gm-Message-State: AOAM5321JHr7SajVdXRPylUGX54Spp+NxQNSF9XTM97ptq3MlfJFXZYl
        34rMTnoyhKIjaNzakYEkuTXeq3xEYCpnJ6Ijhmm+dXZPt6pqjle7pGgUgw49bytDmLwcq7w0euC
        8Uqn7EfvNBFJC2Bc7D1mWTVpf
X-Received: by 2002:a05:620a:15cf:b0:67d:f378:5cf8 with SMTP id o15-20020a05620a15cf00b0067df3785cf8mr745288qkm.354.1648056995707;
        Wed, 23 Mar 2022 10:36:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTUiRkn6eha8XU1o1IqDFFHEY3objSBoDDAqSNfC0KM2Zb1piJWjlVMzOTuJp+NKhZ0Bg0SA==
X-Received: by 2002:a05:620a:15cf:b0:67d:f378:5cf8 with SMTP id o15-20020a05620a15cf00b0067df3785cf8mr745251qkm.354.1648056995111;
        Wed, 23 Mar 2022 10:36:35 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-114.business.telecomitalia.it. [87.12.25.114])
        by smtp.gmail.com with ESMTPSA id h14-20020a05622a170e00b002e1a65754d8sm476127qtk.91.2022.03.23.10.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:36:34 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, Asias He <asias@redhat.com>,
        Arseny Krasnov <arseny.krasnov@kaspersky.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH net v3 1/3] vsock/virtio: initialize vdev->priv before using VQs
Date:   Wed, 23 Mar 2022 18:36:23 +0100
Message-Id: <20220323173625.91119-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323173625.91119-1-sgarzare@redhat.com>
References: <20220323173625.91119-1-sgarzare@redhat.com>
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

When we fill VQs with empty buffers and kick the host, it may send
an interrupt. `vdev->priv` must be initialized before this since it
is used in the virtqueue callbacks.

Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 5afc194a58bb..3e5513934c9f 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -622,6 +622,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
 	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
 
+	vdev->priv = vsock;
+
 	mutex_lock(&vsock->tx_lock);
 	vsock->tx_run = true;
 	mutex_unlock(&vsock->tx_lock);
@@ -639,7 +641,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
 		vsock->seqpacket_allow = true;
 
-	vdev->priv = vsock;
 	rcu_assign_pointer(the_virtio_vsock, vsock);
 
 	mutex_unlock(&the_virtio_vsock_mutex);
-- 
2.35.1

