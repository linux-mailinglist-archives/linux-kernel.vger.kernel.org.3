Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037335427BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243803AbiFHHNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354598AbiFHGTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0AFCDF5C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654668891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WgWKGhriuZ/b08VwpIQ7c/Jw4pb896/SIme7WzVP+jY=;
        b=BW4hKJrlTzUHPkQ2fHTsptkFeQf0OjpYKlZcXIcmaIznMmn+wlfdumYaSOZ1esLASX3S6k
        DJdlOZL8I8Fjzlm7iDc/U9MhRvT4NGyNr+ZkVUXejJ2JPYPbsPV8osdYzqHyukQXqRJl9F
        MNg29haKYOK+Eo8Y4LbG3Nhv5ojHM+Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-jMlX7HzrOBWmWzfaYQeWtA-1; Wed, 08 Jun 2022 02:14:48 -0400
X-MC-Unique: jMlX7HzrOBWmWzfaYQeWtA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 206043804518;
        Wed,  8 Jun 2022 06:14:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-97.pek2.redhat.com [10.72.13.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B808F2166B26;
        Wed,  8 Jun 2022 06:14:25 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, mpm@selenic.com, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvivier@redhat.com, Jason Wang <jasowang@redhat.com>,
        syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com
Subject: [PATCH] virtio-rng: make device ready before making request
Date:   Wed,  8 Jun 2022 14:14:22 +0800
Message-Id: <20220608061422.38437-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current virtio-rng does a entropy request before DRIVER_OK, this
violates the spec and kernel will ignore the interrupt after commit
8b4ec69d7e09 ("virtio: harden vring IRQ").

Fixing this by making device ready before the request.

Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
Reported-and-tested-by: syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index e856df7e285c..a6f3a8a2aca6 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -159,6 +159,8 @@ static int probe_common(struct virtio_device *vdev)
 		goto err_find;
 	}
 
+	virtio_device_ready(vdev);
+
 	/* we always have a pending entropy request */
 	request_entropy(vi);
 
-- 
2.25.1

