Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE824EA662
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiC2EXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiC2EXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B30423B3D7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648527684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/Fki2qhrqzIn3lkIi3YIPXgrFjahMDx8WQomnumvye4=;
        b=b+IXYznIvo5PN/UJ4/XtC5rmhEpsYZXQyQECkmQNde4yFw6Ld+758Gsr5evEdOyFRQKAtl
        VesBCAh6i/hWWvoHIFAggecVkCa92kRac8M8YKFt7uIVgv/vWxN0ETGox5SP0w5qADd0NT
        J29Xo2voaEa7R2Ux7/hIPqjeGV80VEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-_GFlxY4ZMDycqaqXkHLD-w-1; Tue, 29 Mar 2022 00:21:16 -0400
X-MC-Unique: _GFlxY4ZMDycqaqXkHLD-w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98654811E80;
        Tue, 29 Mar 2022 04:21:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-210.pek2.redhat.com [10.72.13.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68A94401DEA;
        Tue, 29 Mar 2022 04:21:12 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     elic@nvidia.com, hdanton@sina.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND V2 1/3] vdpa: mlx5: prevent cvq work from hogging CPU
Date:   Tue, 29 Mar 2022 12:21:07 +0800
Message-Id: <20220329042109.4029-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A userspace triggerable infinite loop could happen in
mlx5_cvq_kick_handler() if userspace keeps sending a huge amount of
cvq requests.

Fixing this by introducing a quota and re-queue the work if we're out
of the budget (currently the implicit budget is one) . While at it,
using a per device work struct to avoid on demand memory allocation
for cvq.

Fixes: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- Using 1 as the budget
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index d0f91078600e..b2afd2b6fbca 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -163,6 +163,7 @@ struct mlx5_vdpa_net {
 	u32 cur_num_vqs;
 	struct notifier_block nb;
 	struct vdpa_callback config_cb;
+	struct mlx5_vdpa_wq_ent cvq_ent;
 };
 
 static void free_resources(struct mlx5_vdpa_net *ndev);
@@ -1616,10 +1617,10 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 	cvq = &mvdev->cvq;
 	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
-		goto out;
+		return;
 
 	if (!cvq->ready)
-		goto out;
+		return;
 
 	while (true) {
 		err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
@@ -1653,9 +1654,10 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 
 		if (vringh_need_notify_iotlb(&cvq->vring))
 			vringh_notify(&cvq->vring);
+
+		queue_work(mvdev->wq, &wqent->work);
+		break;
 	}
-out:
-	kfree(wqent);
 }
 
 static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
@@ -1663,7 +1665,6 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct mlx5_vdpa_virtqueue *mvq;
-	struct mlx5_vdpa_wq_ent *wqent;
 
 	if (!is_index_valid(mvdev, idx))
 		return;
@@ -1672,13 +1673,7 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
 		if (!mvdev->cvq.ready)
 			return;
 
-		wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
-		if (!wqent)
-			return;
-
-		wqent->mvdev = mvdev;
-		INIT_WORK(&wqent->work, mlx5_cvq_kick_handler);
-		queue_work(mvdev->wq, &wqent->work);
+		queue_work(mvdev->wq, &ndev->cvq_ent.work);
 		return;
 	}
 
@@ -2668,6 +2663,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	if (err)
 		goto err_mr;
 
+	ndev->cvq_ent.mvdev = mvdev;
+	INIT_WORK(&ndev->cvq_ent.work, mlx5_cvq_kick_handler);
 	mvdev->wq = create_singlethread_workqueue("mlx5_vdpa_wq");
 	if (!mvdev->wq) {
 		err = -ENOMEM;
-- 
2.18.1

