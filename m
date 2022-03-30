Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050BB4EBAC4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbiC3GZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243287AbiC3GZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A77251E46
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648621413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8TGY8FPvAj69Ea635jOIsz/rfPRMfoGdBaPywDij9qk=;
        b=MMH8WpxtjPbPyz5cgNC9lzbISZaywE9mml8yzi2PqEMh6wDg5SDBCSbmA7oLCeYSAhUbp6
        tnIxJ3plbGlLYdEt2RQekbCXDe3yb4ySFPiTBKwCdwnH0n8R8rLhxpgz9guZJZBWCG2pvp
        86SB9/wNigEeQuYa75Xuo9aXR1uDPXo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-lIdZguAzMASiyCLw0vrY7Q-1; Wed, 30 Mar 2022 02:23:32 -0400
X-MC-Unique: lIdZguAzMASiyCLw0vrY7Q-1
Received: by mail-wm1-f69.google.com with SMTP id c62-20020a1c3541000000b003815245c642so592353wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8TGY8FPvAj69Ea635jOIsz/rfPRMfoGdBaPywDij9qk=;
        b=kNnikaViRGzRatFpGVBTSeebINLJ7xdT4bYoFOF8WeGFtx2i9m5JvM8WkEBiY8eYIy
         a4W/EWU2ta7ZXMzgelG9mTR6PT0yE03o68X0S3s9lXEwXxvfaEnqqkMx+yNpaULqZ+1H
         Bt4VKWJD4T89Ps9p5csconBTAc5gz4dqQmdEDOUvW9AsqtEThx6BnFGNqpzt8QyoJDg+
         KcII5RvSNs6tRZ0rEr3+f4oL7esvr0PwHPm2WIOVzQwGGi5ioK/fMMJyBp15uMKKHNJO
         oqj6w8hWX7qIrlSPDcypkf0cbIMiXHKT5HgfEPi6p6iNgtYiwcMFLdwlTnj8rhaDURCM
         0srg==
X-Gm-Message-State: AOAM530iRfcfRXTO1KLonV6eGcPKHdZCSsvVd0ba/8i1KUtuY5r1O77m
        GHMt/qyjky7Yi0FpAbesqGy9MWxRiIVnXkJe012Il7kdetDJg+BlKTvr9yvlXbRfCHXEKFuMzsB
        MdWlZhiOjkEBxB1V504Ol9pqYlDI8oZdOvuMOm2XqSfsMI/3dm+XB8MDly1gU2RlLssqGLg==
X-Received: by 2002:adf:e58a:0:b0:203:f3c8:4cfe with SMTP id l10-20020adfe58a000000b00203f3c84cfemr34658951wrm.475.1648621410692;
        Tue, 29 Mar 2022 23:23:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqd0k6v3wYqEXpvBX5cQt/Kl9g/JqVY1JyMjZJFzrNQq8Nfcjn2ou2eHRnr8n6fxvobm+ufQ==
X-Received: by 2002:adf:e58a:0:b0:203:f3c8:4cfe with SMTP id l10-20020adfe58a000000b00203f3c84cfemr34658934wrm.475.1648621410459;
        Tue, 29 Mar 2022 23:23:30 -0700 (PDT)
Received: from redhat.com ([2.52.9.207])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0038cba2f88c0sm5173811wms.26.2022.03.29.23.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 23:23:29 -0700 (PDT)
Date:   Wed, 30 Mar 2022 02:23:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 1/2] Revert "virtio: use virtio_device_ready() in
 virtio_device_restore()"
Message-ID: <20220330062315.125924-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8d65bc9a5be3f23c5e2ab36b6b8ef40095165b18.

We reverted the problematic changes, no more need for work
arounds on restore.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 75c8d560bbd3..22f15f444f75 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -526,9 +526,8 @@ int virtio_device_restore(struct virtio_device *dev)
 			goto err;
 	}
 
-	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
-	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
-		virtio_device_ready(dev);
+	/* Finally, tell the device we're all set */
+	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
 
 	virtio_config_enable(dev);
 
-- 
MST

