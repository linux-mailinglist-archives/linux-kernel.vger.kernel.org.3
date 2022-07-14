Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1260574C54
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbiGNLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGNLjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:39:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB6325E81
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n35ylgnDDvXCkuWTodn/Riwt5+iE/bXl3REYPzA2y3YlCsTF6pJe/6JfL3HYjJfYm137+V6La7VadRL+Mjj3emEgctY+faSUOWmGFEGFzCf+Bzj8SZuqL+fSjecCCzA0fTk5iEtsK40vIYKQPErhny6zq7lE0poP2K4avC3JofLZYXhgkJzgTf9ZmwRUysJx1PKTJQLRU66TKyk1eOiYtvCDUusOPURtWTkUzwMxPDs4JNxbrZbLTB/t57DkIfXL/GpfztxbeXYVayB9tidNwHGdpVsZDMbNo26oEXHgzwvvMNOtp9NZytkxAXsb6L64tcFDA1dO+nzq6iW9g6fllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo/fueSfex7i2u/z5nflWqJD11bsY91JZasHE5xKXxY=;
 b=fRUMaCco3wWy5Ju+XcYWYnQp7MhuT4Qqe2osSDkJNRyw3LCEZJNzv4XvHZkMYdg8ZR2Xh/LSUKoExxtGW9OfiorR3UJN8UvfuAbTiq7+3nBRz92pwmaDLT1nWdaB3gSPEpxKlsfxk9Nae+BT1IH++okb3RRMLpkld96Ptu1JFc3NYfCiHmla+hT4YxTiEYU74P7rEvxzFnw6f6wc3CVjZVoImrBKn/T7wK8m3Tj3SyTsIOU3F5f8gASkOEfd9XPEjWokxU7bSqmBvyLETzptG8rlq3O8Ba46cGBeDRzehN3PuP3/d9qXZmmnsM/hSKZt064/IagxPItmS4dBD37Nbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo/fueSfex7i2u/z5nflWqJD11bsY91JZasHE5xKXxY=;
 b=gwMUqx+ghbC3edqfp175mbItkckgXIkXkuqejDJEJ8646Y30W8+0+jOJTJdMV8fTNjNGB7jV8i8qZAQ9dlvQNyAO2S9YoOyGU+mfEhskqbi7Jj3XmHNH66Hd+Qbr2LIt9dek0Yu8iDs2fBzBZbxdpSOp7/n25Pnj6sx4hXfG6kwVpYkLO/LvQ/6aBGLsERzaudi/gvx8G7B8U/ruFQSfTjdstXX1RTbRy5r3XbTAy/7vrtgD1ACaZbVcnCf5olGrCiOzBSrTcFWBIa6HoOYv5OoC23qDx7yCONPq/tkAzESXp9tDtfi9e4t7XLf7wv19PT2SPNMJ6tk4Td6wMlGJgQ==
Received: from MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16)
 by DM4PR12MB5135.namprd12.prod.outlook.com (2603:10b6:5:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 11:39:36 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::2b) by MW4PR04CA0071.outlook.office365.com
 (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 14 Jul 2022 11:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 11:39:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 14 Jul 2022 11:39:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 14 Jul 2022 04:39:34 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 14 Jul 2022 04:39:32 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <eperezma@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH 1/2] vdpa/mlx5: Implement susupend virtqueue callback
Date:   Thu, 14 Jul 2022 14:39:26 +0300
Message-ID: <20220714113927.85729-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714113927.85729-1-elic@nvidia.com>
References: <20220714113927.85729-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 661fb715-a2cc-45b8-7d29-08da658d8739
X-MS-TrafficTypeDiagnostic: DM4PR12MB5135:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QtleZ8+0noWtkMfd69V+9cWh9DwSJivNjYbuRDZnarWOpxvwpb6zDzRyd5ECPnRyxFDzHKuLemvEV52R1sH212hUCyFESbegeJOrd/yPXLz3gmkKjDY07qOf67I4YZVhU4zuqOe0hxN+wsqOMEjweXj2YFw/u2iN2jQzSdUS7kP53FcgbfHMUoixgpIB4U/fh+mL25y4D/CZRnfYCZMurqTJUzY7wdqWPXsuUwfJl/BmhQSMRN/GQc/12/mGgbDKu0xFRFvAOEB5YS/5e6rnlUBq6OJBBcVIwCdBXR4/F2UG4RV5akvBpIdXKKXZrniohsBjtWO4umbWl1xKcFC+bZSS8nmX/JVxPSmyfInLXYh+QMZt4zzU6jHXEyYnnNHmEi8zG7/1htg4NtiUmleZtNJtoKKYRoR93azt6AWy2MZGQjS4Ur4HmfmjJcV8EfKNascskj8myKxr4dVoCNM8qJBytZ4tNljBVP0TIu5bvNYZiITWYmdyLqq2AFN9b5k3k+FEqjy7r7O0gAAXkSmKOPOAmYHVKgTevcRIFU+KrjlQBZwrp2bL/ZAGuln8h4bm2igOVqXX0f1saHizIo2kUAWyNNPZgaYJlx8Od0Qp5bV0YoIfQJwBCLO9xW9SVAC+kL2pFKLr/9qvxyV4NPzFwqvMdme17a1kZ63z/WlUEojEDp18HbHH0tRpnudEbtlXtCDU2GiHZ6UtfNTlFLJLz4pqM5DNsMd3R4A91I2ggMCk/Gx9ytunupDnxixzQ/xGNhq6SGarfqFwiAPKzjmiS1N0HxcyYTSLkFxNig1y/iFDpyq7CXtsBNw2GCdQRL1Io9SmyDRfFJxthXQ0cmpeRbptNyd8loenmt/pKEfe6xY=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(36840700001)(40470700004)(54906003)(26005)(7696005)(110136005)(36860700001)(8676002)(4326008)(316002)(70586007)(70206006)(36756003)(41300700001)(478600001)(2906002)(2616005)(6666004)(83380400001)(336012)(1076003)(186003)(426003)(47076005)(5660300002)(86362001)(40460700003)(81166007)(8936002)(40480700001)(356005)(82310400005)(107886003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 11:39:35.8426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 661fb715-a2cc-45b8-7d29-08da658d8739
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5135
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the suspend callback allowing to suspend the virtqueues so
they stop processing descriptors. This is required to allow to query a
consistent state of the virtqueue while live migration is taking place.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 83 ++++++++++++++++++++++++++++--
 include/linux/mlx5/mlx5_ifc_vdpa.h |  8 +++
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index e85c1d71f4ed..d0fff559ca15 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -164,6 +164,7 @@ struct mlx5_vdpa_net {
 	bool setup;
 	u32 cur_num_vqs;
 	u32 rqt_size;
+	bool nb_registered;
 	struct notifier_block nb;
 	struct vdpa_callback config_cb;
 	struct mlx5_vdpa_wq_ent cvq_ent;
@@ -895,6 +896,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	if (err)
 		goto err_cmd;
 
+	mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT;
 	kfree(in);
 	mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
 
@@ -922,6 +924,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
 		mlx5_vdpa_warn(&ndev->mvdev, "destroy virtqueue 0x%x\n", mvq->virtq_id);
 		return;
 	}
+	mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
 	umems_destroy(ndev, mvq);
 }
 
@@ -1121,6 +1124,20 @@ static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueu
 	return err;
 }
 
+static bool is_valid_state_change(int oldstate, int newstate)
+{
+	switch (oldstate) {
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
+		return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY;
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
+		return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND;
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR:
+	default:
+		return false;
+	}
+}
+
 static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int state)
 {
 	int inlen = MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
@@ -1130,6 +1147,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	void *in;
 	int err;
 
+	if (mvq->fw_state == MLX5_VIRTIO_NET_Q_OBJECT_NONE)
+		return 0;
+
+	if (!is_valid_state_change(mvq->fw_state, state))
+		return -EINVAL;
+
 	in = kzalloc(inlen, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -1992,6 +2015,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct mlx5_vdpa_virtqueue *mvq;
+	int err;
 
 	if (!mvdev->actual_features)
 		return;
@@ -2005,8 +2029,16 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
 	}
 
 	mvq = &ndev->vqs[idx];
-	if (!ready)
+	if (!ready) {
 		suspend_vq(ndev, mvq);
+	} else {
+		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
+		if (err) {
+			mlx5_vdpa_warn(mvdev, "modify VQ %d to ready failed (%d)\n", idx, err);
+			ready = false;
+		}
+	}
+
 
 	mvq->ready = ready;
 }
@@ -2733,6 +2765,37 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
 	return err;
 }
 
+static void mlx5_vdpa_cvq_suspend(struct mlx5_vdpa_dev *mvdev)
+{
+	struct mlx5_control_vq *cvq;
+
+	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
+		return;
+
+	cvq = &mvdev->cvq;
+	cvq->ready = false;
+}
+
+static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
+{
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	struct mlx5_vdpa_virtqueue *mvq;
+	int i;
+
+	down_write(&ndev->reslock);
+	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
+	ndev->nb_registered = false;
+	flush_workqueue(ndev->mvdev.wq);
+	for (i = 0; i < ndev->cur_num_vqs; i++) {
+		mvq = &ndev->vqs[i];
+		suspend_vq(ndev, mvq);
+	}
+	mlx5_vdpa_cvq_suspend(mvdev);
+	up_write(&ndev->reslock);
+	return 0;
+}
+
 static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_vq_address = mlx5_vdpa_set_vq_address,
 	.set_vq_num = mlx5_vdpa_set_vq_num,
@@ -2763,6 +2826,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.get_generation = mlx5_vdpa_get_generation,
 	.set_map = mlx5_vdpa_set_map,
 	.free = mlx5_vdpa_free,
+	.suspend = mlx5_vdpa_suspend,
 };
 
 static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
@@ -2828,6 +2892,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
 		mvq->index = i;
 		mvq->ndev = ndev;
 		mvq->fwqp.fw = true;
+		mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
 	}
 	for (; i < ndev->mvdev.max_vqs; i++) {
 		mvq = &ndev->vqs[i];
@@ -2902,13 +2967,21 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
 		switch (eqe->sub_type) {
 		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
 		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
+			down_read(&ndev->reslock);
+			if (!ndev->nb_registered) {
+				up_read(&ndev->reslock);
+				return NOTIFY_DONE;
+			}
 			wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
-			if (!wqent)
+			if (!wqent) {
+				up_read(&ndev->reslock);
 				return NOTIFY_DONE;
+			}
 
 			wqent->mvdev = &ndev->mvdev;
 			INIT_WORK(&wqent->work, update_carrier);
 			queue_work(ndev->mvdev.wq, &wqent->work);
+			up_read(&ndev->reslock);
 			ret = NOTIFY_OK;
 			break;
 		default:
@@ -3062,6 +3135,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 
 	ndev->nb.notifier_call = event_handler;
 	mlx5_notifier_register(mdev, &ndev->nb);
+	ndev->nb_registered = true;
 	mvdev->vdev.mdev = &mgtdev->mgtdev;
 	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
 	if (err)
@@ -3093,7 +3167,10 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct workqueue_struct *wq;
 
-	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
+	if (ndev->nb_registered) {
+		mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
+		ndev->nb_registered = false;
+	}
 	wq = mvdev->wq;
 	mvdev->wq = NULL;
 	destroy_workqueue(wq);
diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
index 4414ed5b6ed2..9becdc3fa503 100644
--- a/include/linux/mlx5/mlx5_ifc_vdpa.h
+++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
@@ -150,6 +150,14 @@ enum {
 	MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR      = 0x3,
 };
 
+/* This indicates that the object was not created or has already
+ * been desroyed. It is very safe to assume that this object will never
+ * have so many states
+ */
+enum {
+	MLX5_VIRTIO_NET_Q_OBJECT_NONE = 0xffffffff
+};
+
 enum {
 	MLX5_RQTC_LIST_Q_TYPE_RQ            = 0x0,
 	MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q  = 0x1,
-- 
2.35.1

