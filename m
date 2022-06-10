Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648DD546931
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiFJPMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiFJPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:12:13 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684E5DF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1654873931;
  x=1686409931;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tCw79+MuKNiYqOirenBZ2/RDY7QIvwcwV2Oku2bJPXE=;
  b=pBkKEPDnSFBlXccVpuTUmO4aZGcwZj4vUOrfjlvd/jJCowKcJnoy0SSc
   +mxJk4Z/ltJk63mAJRoONZhJa3L4NQyYm+MfoR4VWywv67lzkqI639c/a
   QvhVT6R6lTH5/wEnxNLN9a00p+naiSQFTrrAmvn0oGJT8kTGmj1nj/GRl
   MV2ErfoW0/KsmCa5DIjldu2bsMIk/nEF9DX6wdOvsNy59SDAI7zymezd6
   nPW+JZioN8NsqWbLifInFJwvtnwePaI4BcgieTBF3g+FSppYhL0Ir7lZD
   icAHGH5qarXduj0mVdXqJwheG4vObZaSsDzzTQ+TNF3uvDr+rPkr1BWIo
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: virt-pci: set device ready in probe()
Date:   Fri, 10 Jun 2022 17:12:03 +0200
Message-ID: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call virtio_device_ready() to make this driver work after commit
b4ec69d7e09 ("virtio: harden vring IRQ"), since the driver uses the
virtqueues in the probe function.  (The virtio core sets the device
ready when probe returns.)

Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/drivers/virt-pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 5c092a9153ea..027847023184 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -544,6 +544,8 @@ static int um_pci_init_vqs(struct um_pci_device *dev)
 	dev->cmd_vq = vqs[0];
 	dev->irq_vq = vqs[1];
 
+	virtio_device_ready(dev->vdev);
+
 	for (i = 0; i < NUM_IRQ_MSGS; i++) {
 		void *msg = kzalloc(MAX_IRQ_MSG_SIZE, GFP_KERNEL);
 
@@ -587,7 +589,7 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
 	dev->irq = irq_alloc_desc(numa_node_id());
 	if (dev->irq < 0) {
 		err = dev->irq;
-		goto error;
+		goto err_reset;
 	}
 	um_pci_devices[free].dev = dev;
 	vdev->priv = dev;
@@ -604,6 +606,9 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
 
 	um_pci_rescan();
 	return 0;
+err_reset:
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
 error:
 	mutex_unlock(&um_pci_mtx);
 	kfree(dev);
-- 
2.34.1

