Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3150D715
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiDYCsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbiDYCsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86BD15F72
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650854708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0JYFrCznPCe42CEJDCpcgcO1AQ7TAwNbjiA53zvbLbI=;
        b=HMVFR7EdRffz7Z5xyZgftWi3lKRTCkGt4yUfcghPppNasgflLBJqBTIOWIia9kZIRRGCsp
        NmECHCUgLPCMwX3eitS16kmy6x0o9EENKozV08HrbMEq8eRIK0n1PiI5I/phUBynWPxwhi
        C3rnUfdWc//h1WF2MCQP1daHcnmGkxo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-z7RgEV4RMzGeqRJIVscmnQ-1; Sun, 24 Apr 2022 22:45:05 -0400
X-MC-Unique: z7RgEV4RMzGeqRJIVscmnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88FEA80005D;
        Mon, 25 Apr 2022 02:45:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-160.pek2.redhat.com [10.72.13.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB5A79E71;
        Mon, 25 Apr 2022 02:44:57 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     sgarzare@redhat.com, eperezma@redhat.com, lulu@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH V3 4/9] virtio-pci: implement synchronize_cbs()
Date:   Mon, 25 Apr 2022 10:44:13 +0800
Message-Id: <20220425024418.8415-5-jasowang@redhat.com>
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

We can simply reuse vp_synchronize_vectors() for .synchronize_cbs().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.h | 2 ++
 drivers/virtio/virtio_pci_legacy.c | 1 +
 drivers/virtio/virtio_pci_modern.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index eb17a29fc7ef..2b84d5c1b5bc 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -105,6 +105,8 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
 void vp_synchronize_vectors(struct virtio_device *vdev);
 /* the notify function used when creating a virt queue */
 bool vp_notify(struct virtqueue *vq);
+/* synchronize with callbacks */
+void vp_synchronize_vqs(struct virtio_device *vdev);
 /* the config->del_vqs() implementation */
 void vp_del_vqs(struct virtio_device *vdev);
 /* the config->find_vqs() implementation */
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 6f4e34ce96b8..207985107150 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -192,6 +192,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.reset		= vp_reset,
 	.find_vqs	= vp_find_vqs,
 	.del_vqs	= vp_del_vqs,
+	.synchronize_cbs = vp_synchronize_vectors,
 	.get_features	= vp_get_features,
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index a2671a20ef77..18c2190e3059 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -394,6 +394,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.reset		= vp_reset,
 	.find_vqs	= vp_modern_find_vqs,
 	.del_vqs	= vp_del_vqs,
+	.synchronize_cbs = vp_synchronize_vectors,
 	.get_features	= vp_get_features,
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
@@ -411,6 +412,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.reset		= vp_reset,
 	.find_vqs	= vp_modern_find_vqs,
 	.del_vqs	= vp_del_vqs,
+	.synchronize_cbs = vp_synchronize_vectors,
 	.get_features	= vp_get_features,
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
-- 
2.25.1

