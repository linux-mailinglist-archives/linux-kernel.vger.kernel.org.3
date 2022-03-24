Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF4A4E6085
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347879AbiCXImT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348986AbiCXImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFB0F9BAD1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648111237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Drmr5TjWEOenjc+0+Kv1dSZ5mTjFeVl7EjBosulduKE=;
        b=PkzBzIygCzajrsLwxGtTYW2xv0plK+YSLxxLBRZsTSrKzfE8tmXX6bD6hWKPxFVOri0rdo
        eV6gu5bEFCB4D1MqRkhAnGtFBCAa/v5ZrPZHlEHRQUlvnd+Cjn3EcW33Zk3xtlSmlZ7Psv
        bR9rmS+0bXdrRkPECgFbL0O6cBq2uIg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-bNo7rXMjOfKUZOJ2JzmHPw-1; Thu, 24 Mar 2022 04:40:34 -0400
X-MC-Unique: bNo7rXMjOfKUZOJ2JzmHPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DD933C23FA5;
        Thu, 24 Mar 2022 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-240.pek2.redhat.com [10.72.13.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AC4F40CFD05;
        Thu, 24 Mar 2022 08:40:30 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com, keirf@google.com
Subject: [PATCH 2/3] virtio: use virtio_reset_device() when possible
Date:   Thu, 24 Mar 2022 16:40:03 +0800
Message-Id: <20220324084004.14349-3-jasowang@redhat.com>
In-Reply-To: <20220324084004.14349-1-jasowang@redhat.com>
References: <20220324084004.14349-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to do common extension without duplicating codes.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 75c8d560bbd3..8dde44ea044a 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -430,7 +430,7 @@ int register_virtio_device(struct virtio_device *dev)
 
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up.  This also tests that code path a little. */
-	dev->config->reset(dev);
+	virtio_reset_device(dev);
 
 	/* Acknowledge that we've seen the device. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
@@ -496,7 +496,7 @@ int virtio_device_restore(struct virtio_device *dev)
 
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up. */
-	dev->config->reset(dev);
+	virtio_reset_device(dev);
 
 	/* Acknowledge that we've seen the device. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
-- 
2.25.1

