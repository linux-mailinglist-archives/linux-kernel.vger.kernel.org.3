Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE93C50D714
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbiDYCr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240416AbiDYCr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E274168F8D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650854692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/ELbaZ0PLUil3oOHDVWmIPGFqZ0fOs67NHhVsEPwgY=;
        b=MwukoiCxoAsa2Ykpo42gU9Lx7KtJo/2P3sRrG03FJzXm52xcNyoIqXxNx3hnXlZBgewoXf
        H7UTJcEDAC0vzBDYPk10RizX5E8T1x5G0NC1+QMfo+cu5G6Ig0iCTWWb6CsxcTpGLrPdc8
        TAguK0kynSPUfdIYxSodzev9CO28wvM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-HjWr8CuPMHO2fdYAeyYrLg-1; Sun, 24 Apr 2022 22:44:51 -0400
X-MC-Unique: HjWr8CuPMHO2fdYAeyYrLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 536C61E14BC1;
        Mon, 25 Apr 2022 02:44:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-160.pek2.redhat.com [10.72.13.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAB5D9E74;
        Mon, 25 Apr 2022 02:44:42 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     sgarzare@redhat.com, eperezma@redhat.com, lulu@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH V3 2/9] virtio: use virtio_reset_device() when possible
Date:   Mon, 25 Apr 2022 10:44:11 +0800
Message-Id: <20220425024418.8415-3-jasowang@redhat.com>
In-Reply-To: <20220425024418.8415-1-jasowang@redhat.com>
References: <20220425024418.8415-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to do common extension without duplicating code.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
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

