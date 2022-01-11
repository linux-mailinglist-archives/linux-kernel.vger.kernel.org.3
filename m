Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D1148A7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348341AbiAKGz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:55:59 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:46113 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233846AbiAKGz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:55:58 -0500
X-QQ-mid: bizesmtp38t1641884139th4l42ea
Received: from localhost.localdomain (unknown [111.193.225.251])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 11 Jan 2022 14:55:34 +0800 (CST)
X-QQ-SSF: 01000000002000B04000000A0000000
X-QQ-FEAT: 381xoVMPsRHV8pelhKUk5JgVDuvK6LRGi3z89mYnDe/YjSmHtDGetmN6W9pfL
        f0RnEaj2b3Yp+KP8Pcw0bLEhF/R21aJN6dCMucfTFCu79FcxuLemU7q80HJ4bNswZjCWf3X
        OqqsSu0zomArq5U9x/cybFSLM2pRzDiksMwQ2HXBQ2hVIISeJmQotiVzW8MPvktO6vWjOEV
        KmVi2SVb/OVKn92TN2el3fDZ0UCMf1mdWxtzFoOzN+4037kLtecfGw1qMiod02Gs/i+2lCH
        QM6xPQ65lUk6cIiasESOnlayswsUTeVcio6r6gYI0H+BvefMG8NIA5z553W66N9qn/aOPWi
        3Hcne1dJE4dt3bkLb5Xfr4vPYSPeQ==
X-QQ-GoodBg: 0
From:   dongsheng li <lidongsheng@dayudpu.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wangwei@dayudpu.com,
        dongsheng li <lidongsheng@dayudpu.com>
Subject: [PATCH v2] virtio_vdpa: Support surprise removal of virtio vdpa device
Date:   Tue, 11 Jan 2022 14:55:27 +0800
Message-Id: <20220111065527.1160-1-lidongsheng@dayudpu.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:dayudpu.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When virtio vdpa device removed, the abnormal damage of the device cannot be
perceived normally, which will cause problems similar to:

Commit 43bb40c5b926 ("virtio_pci: Support surprise removal of
virtio pci device")
Hence, add the ability to abort the command on surprise removal

Signed-off-by: dongsheng li <lidongsheng@dayudpu.com>
---
 drivers/virtio/virtio_vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index f85f860bc10b..a5cebad09320 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -396,6 +396,7 @@ static void virtio_vdpa_remove(struct vdpa_device *vdpa)
 {
 	struct virtio_vdpa_device *vd_dev = vdpa_get_drvdata(vdpa);
 
+	virtio_break_device(&vd_dev->vdev);
 	unregister_virtio_device(&vd_dev->vdev);
 }
 
-- 
2.17.1

