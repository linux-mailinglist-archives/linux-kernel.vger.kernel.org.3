Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE948A6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiAKEJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:09:00 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:27449 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347448AbiAKEI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:08:57 -0500
X-QQ-mid: bizesmtp2t1641874129t0i3xrpx5
Received: from localhost.localdomain (unknown [111.193.225.251])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 11 Jan 2022 12:08:42 +0800 (CST)
X-QQ-SSF: 01000000002000B06000000A0000000
X-QQ-FEAT: 835QeueZ15tztOVm6/bsUfNjyJ6gY/fZsz15qIb0Z3mmrNfg+V8Vx19fsnM1g
        ui9IO0N3pojArQbqo7hfZd1Rp0HaEtTxuPhWDDSmuoVgDLn/qXLcC0tW8op/Q4g/vRLTDdK
        +j2aGxgPdRyBf3pwX1zhpRiEQ9EpaKi94jBzlmUqvsKbD9PD7kDslqMHe5uoJ4o+B9qYpg7
        T4TziNgnFghO3ecsSDkBJSvnMJ2T29yeDJ3X7CwvnWLuw/q59fsempaBuACe2SQIotlhcic
        Q5D+gNEsdY+ceovSszwVh5VmCft3Qz9PJ28sHEukYsTFTaWN65J8iEyGpNh6HIe196aMQgo
        R0wPrit9aDl2b6mBxYynWt11oWyaQ==
X-QQ-GoodBg: 0
From:   dongsheng li <lidongsheng@dayudpu.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        dongsheng li <lidongsheng@dayudpu.com>
Subject: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa device
Date:   Tue, 11 Jan 2022 12:08:31 +0800
Message-Id: <20220111040831.5224-1-lidongsheng@dayudpu.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:dayudpu.com:qybgspam:qybgspam2
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
index 4a9ddb44b2a7..fd930409d190 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -374,6 +374,7 @@ static void virtio_vdpa_remove(struct vdpa_device *vdpa)
 {
 	struct virtio_vdpa_device *vd_dev = vdpa_get_drvdata(vdpa);
 
+	virtio_break_device(vd_dev->vdev);
 	unregister_virtio_device(&vd_dev->vdev);
 }
 
-- 
2.17.1

