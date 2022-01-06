Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B122F486177
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiAFIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:31:30 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57446 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236699AbiAFIb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:31:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V15Ff-y_1641457886;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0V15Ff-y_1641457886)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Jan 2022 16:31:26 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] virtio-pci: fix memory leak of vp_dev
Date:   Thu,  6 Jan 2022 16:31:23 +0800
Message-Id: <20220106083123.4064853-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In virtio_pci_probe(), vp_dev will not be freed if it goes to
"err_register" branch. fix it

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index fdbde1db5..48b5ac15e 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -602,8 +602,7 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 err_enable_device:
 	if (reg_dev)
 		put_device(&vp_dev->vdev.dev);
-	else
-		kfree(vp_dev);
+	kfree(vp_dev);
 	return rc;
 }
 
-- 
2.17.1

