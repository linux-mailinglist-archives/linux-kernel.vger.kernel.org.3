Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9023E574C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbiGNLiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGNLiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:38:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273EB5B04A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlfjDDdmGzcswPtFqiNVMCkHEahIjED9jBg4BuWo7/PdxHQ/EwEc4ArsBrYY82sIbuCQE5W3i4erZQCmyj/fDDixZvxATITLJonwxK2UZaOE6ShVJquNo+5o47CdPs7Dv6hA2f7NzrTUPsuXmWJfYzfqXcPngTviu+XEcaXzYx2QbPSEvdgTMpSLwFCUSKcva3YalskDSiFmmr/Pfvhvzv0oE9PL+ZPcojJA69s3oPKR3x85RQrP2LgNFxAtand2mQrvJnsG3NX11bta8xlv16Up9ZHPut7jU/5R1O+Ia56uNc1x5KaDeLUE5Cu97M4Vjz456VefakXmhX6W08mwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo/fueSfex7i2u/z5nflWqJD11bsY91JZasHE5xKXxY=;
 b=Xir5aZD0SRZvv+BOQzUbH+V1kgEFYu9W/W/H2704BF9mJ47o6IiAPSH0DHiZcqvfrq5fXncs6QTyRf98pRgclhOHHFz3YjWKSGcbtYb025nl42SneGDe8/B3lWRe/cA9vjN/T0bmyd8RVGsImIgW13SF7kqDynsrpg7wd1FI3ybPmWyzR0N0AwwjNEZkRNdXuKsE4R7dRsey2uQDE35soT8H8CnHq46fhKiAEZPo9/5n+OvBIReGnv+dN8NYygCHLb+gk5fCTdO1sNP49EpUyULIDk4VeNmjY+mCbghUSkHeW4QlxpMwkWuhxQdImmeYVmplfZJNsHNzyolqILUE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo/fueSfex7i2u/z5nflWqJD11bsY91JZasHE5xKXxY=;
 b=UyFijco87ljKbxubsnBF1reH/BrLL0wnlKbxPPzSvf7a3A1+DAiiWYGVkCkT0OGDp6fCA/U8bVFsJv26AMFeizqPkYERgjHyDEMGLarvobTm18ji1w/zTW1kQeDv1iQXPxgjzfS2r7zmx2beqfwThKXeRs9PCFAK8/f6Thb78VQw+ssBwYNqlupw1o3sWiOioPziEHQa3R3Pf/S/0EeAwnUJTHjdxa/SdIRnf1NzajHuLoGEwSFWS26NSTr+jRgeQOQqNwCiflVSKEUXgncvLPepjmE1yCxK01eiU8XA9VUuxHgw+dozRpLjqEJoO7nzEniIe67Hu4u3pPsROwYMAQ==
Received: from BN9PR03CA0195.namprd03.prod.outlook.com (2603:10b6:408:f9::20)
 by DM5PR1201MB0155.namprd12.prod.outlook.com (2603:10b6:4:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 11:38:20 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::81) by BN9PR03CA0195.outlook.office365.com
 (2603:10b6:408:f9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Thu, 14 Jul 2022 11:38:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 11:38:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 14 Jul 2022 11:38:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 14 Jul 2022 04:38:14 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 14 Jul 2022 04:38:12 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.co>, <eperezma@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH 1/2] vdpa/mlx5: Implement susupend virtqueue callback
Date:   Thu, 14 Jul 2022 14:38:06 +0300
Message-ID: <20220714113807.85665-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714113807.85665-1-elic@nvidia.com>
References: <20220714113807.85665-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4caf4c8-0af4-47c1-1390-08da658d59cd
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0155:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93AHdnfHvp4Pl7dYV7CilquXtwekXMp2t85TOhWSYRHGD6lH4Gkt720Ph9YqbL1gNoZ9cew6YQkwTt06laPMip8XtITpKtEyngaEzFf6UQ6Rmvie2Ybh5GyZEpxEvUAk5xHHtm3Sor3vVBhjh8WgC4m84/pF5y/lG+kAf0KMv5hqbgujbBAF4s00HGfQjj3itdLzLijgPbqRXBXccFek1ehyPbHuRU+47NKjErGlnEOuhT03Qpf+qN7LX5Kr1G0zP6Iba2z6+/o5v1Za56P4cLV8rZMYFK1yk6hTlGO2AW8Sk8ZomUNC4rQ8qhmlDXKVAr0fHiolJp6y2yWSw8IgxQBcJ1aVug8cIOh7yfFjErlfROQY+O4L9zEzvdSFQyhMHZbhGhcTIdWHXVvA5p77Pq0nlYu2C4CHXjx4XDwjwp/8MYYDoREvOGUcK0GfMRhqdu2ujSeiWYcRQtH5u3NMEggwm9DGPG6wIa4gk9l73Mzgy1X7Sf3jZ7K+SvszJGQOGyTC6SgYi60enjTyUpdoQOJ3FKDlWbbScxF9jIyGI7xLz92FJjK6xZNYJsLzZQpbm80RzQ5C5Yrb2uY+eSqlwy+R9gs0hgLIOvpmOMpsOygxcVUHGjIhzsq8GIiY7Xy87miv19uU8oXSZetnve3/RumrPRUogYG85moHP2pSxrsXce/xvuOfjBQ4iyQmlOvZOuVRRY9KdE0uxDEZt5RmkTUI/kzrY4TnYOVv4Ckib8ys/s6uY2lBuPUK3EAGKZpUOg2cUnCGeHLOAcS/l0Zw1XjrE4yfMA16oLpkW+WGZTUkohTbFTIdzL93eOf/a2ebLlm9mM0RKxOXgaEUPr/3sw9QPghSJef1g9MEPgVDv8k=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(40470700004)(46966006)(336012)(82740400003)(8676002)(316002)(70586007)(107886003)(186003)(2616005)(26005)(7696005)(40460700003)(70206006)(8936002)(110136005)(478600001)(1076003)(5660300002)(81166007)(82310400005)(41300700001)(86362001)(6666004)(4326008)(54906003)(356005)(2906002)(47076005)(426003)(40480700001)(83380400001)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 11:38:19.5878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4caf4c8-0af4-47c1-1390-08da658d59cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0155
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

