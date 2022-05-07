Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2133551E52C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445984AbiEGHYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 03:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445991AbiEGHY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 03:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 626ED625D
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 00:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651908039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zE4BJVkXb+UoGK7fe/PzJ3m4ViAol/YAukmnEmZTdLY=;
        b=CID2dH85d2nMgZ/xiQ/139Qd3d3SQhxBxWc5W1cI2rpYUo3MoRi0bbkw3IYpOpHRTZwpPk
        C7CJeBORQ7FFXRZfd90oyxmD49Pse8KOO580spf8mcBu1zn/MLqFTQbNnZIha/OQeaGi5B
        BUEKdMv3riJRgmogekF3kR64Y3oDANg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-n01PwdGlPgeQERt2_e9L8w-1; Sat, 07 May 2022 03:20:36 -0400
X-MC-Unique: n01PwdGlPgeQERt2_e9L8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA3D1101AA42;
        Sat,  7 May 2022 07:20:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-216.pek2.redhat.com [10.72.13.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0D6A40D2971;
        Sat,  7 May 2022 07:20:29 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, sgarzare@redhat.com,
        xuanzhuo@linux.alibaba.com
Subject: [PATCH V4 5/9] virtio-mmio: implement synchronize_cbs()
Date:   Sat,  7 May 2022 15:19:50 +0800
Message-Id: <20220507071954.14455-6-jasowang@redhat.com>
In-Reply-To: <20220507071954.14455-1-jasowang@redhat.com>
References: <20220507071954.14455-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply synchronize the platform irq that is used by us.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_mmio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..4a3b66e4e198 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -345,6 +345,14 @@ static void vm_del_vqs(struct virtio_device *vdev)
 	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
 }
 
+
+static void vm_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+
+	synchronize_irq(platform_get_irq(vm_dev->pdev, 0));
+}
+
 static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name, bool ctx)
@@ -541,6 +549,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.finalize_features = vm_finalize_features,
 	.bus_name	= vm_bus_name,
 	.get_shm_region = vm_get_shm_region,
+	.synchronize_cbs = vm_synchronize_cbs,
 };
 
 
-- 
2.25.1

