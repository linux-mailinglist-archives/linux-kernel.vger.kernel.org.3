Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA894F0845
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 09:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355390AbiDCHZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 03:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiDCHZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 03:25:51 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D00A3193A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 00:23:56 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id auaYnoz7xN7CcauaYnN1jG; Sun, 03 Apr 2022 09:23:54 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Apr 2022 09:23:54 +0200
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] vp_vdpa: Fix an error handling path in vp_vdpa_probe()
Date:   Sun,  3 Apr 2022 09:23:52 +0200
Message-Id: <d7015dad7734eac626f5e8de2687cad40568ad79.1648970592.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful vp_modern_probe() call, it should be
undone by a corresponding vp_modern_remove() call, as already do in the
remove function.

Fixes: 64b9f64f80a6 ("vdpa: introduce virtio pci driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is completely speculative.
Review with care.
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index cce101e6a940..9b713fe0f2c7 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -491,7 +491,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Failed for adding devres for freeing irq vectors\n");
-		goto err;
+		goto err_remove;
 	}
 
 	vp_vdpa->vring = devm_kcalloc(&pdev->dev, vp_vdpa->queues,
@@ -500,7 +500,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!vp_vdpa->vring) {
 		ret = -ENOMEM;
 		dev_err(&pdev->dev, "Fail to allocate virtqueues\n");
-		goto err;
+		goto err_remove;
 	}
 
 	for (i = 0; i < vp_vdpa->queues; i++) {
@@ -511,7 +511,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		if (!vp_vdpa->vring[i].notify) {
 			ret = -EINVAL;
 			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
-			goto err;
+			goto err_remove;
 		}
 	}
 	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
@@ -519,11 +519,13 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
-		goto err;
+		goto err_remove;
 	}
 
 	return 0;
 
+err_remove:
+	vp_modern_remove(&vp_vdpa->mdev);
 err:
 	put_device(&vp_vdpa->vdpa.dev);
 	return ret;
-- 
2.32.0

