Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDED3551CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346856AbiFTNgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346594AbiFTNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:36:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A860A27FE9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5Guh2dVcfm0ktRjnkdvKIY9ys1E1zhRMJ161mkEMeyn5ZUO7Tj5N6B1xtdCjPN2BWqVafQRzTA9IndRiYYwKnArKEt8KPymHwpSeTo1HNvsmxZm/onmyV/vD3S/1HImTnRUfoHtJiKHpC9jYWKbNsU2EfPLWe1e+ozQDSxgTkWEdRA2trLe4KN4DFaJ3DUlODVAJKrIdTSGdO4kaNCaTJD1zaRNkHIRdNDwa3wsnpv36MPP65xBhA9RVEMYQdcqRWTiVmd/emLGGsX8xKUJHZoIfHKBcfaO5hG4nw6y6AABi8RblgBG4RVWtR0dcqgGkN8fZRz0W/o2y7N77ATLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9Yst6c2MqlinmSyIwGLQR7WgpJw5gbEFk5B0yxic84=;
 b=m2sFCm2kFi+jh6dJFtib9qG4OTNS6+U3jQ5X7dp8dcpNReZtqFPV0UPUKpb6OVCyQsOTUyCFFlY70yF5IWEIyiDdhdPsV5tlnlbFC9AKThe1mERGnbRZ4EjHubExaKTAjT2GydR56kmOoQjxmuZ4fI8BG760qsbqXnbssz9QHMYcfnr0HskhpJfP4RHXRi3WXljSdFIaNtcBdJOEeDHjeledJLDOu3GUb/jJzit2EPuwzBNPYm7HLzrZ2Z3UrEc7S0KhsX9NKFroqqgcY18pK1nTVS0Mr1ZUZy7tZVEmmNMSumMp9tx65AL1ncJm1bIegZOB0rO12jzSVYkwi38ICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9Yst6c2MqlinmSyIwGLQR7WgpJw5gbEFk5B0yxic84=;
 b=r2f2fy1icJv7INgMopa+4pxs/X/f2FVWL3LTaHgO41t/k/VSh97NcglLaxpbSMC2V5acaXtzgttLJ7812Q+EQTT6jVu4cTjfMeaMh+r2wBqQFrUCHGT5I7vbI8seAXz7iwKWb2ouQ6x41B2mJt/oWXUwwa+ekfmzrw91/A3UdVAnFgOUhslN3ZeDa1JGkkB72INWqo1wqfC/LSmK+kX+zsox9sxAf5Wh0p4pdPLMNTHv+URY8LjWaFGAhA9Dx5Ib4KfY5/W6efKMb1eHvyPJ0aWjNwLPlXE6In7UZ0nfhSlepVIjOhYL1u81TtFDiRkLh/nuCyhbvT73gJfGz32++w==
Received: from MWH0EPF00056D17.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1b) by MN2PR12MB4454.namprd12.prod.outlook.com
 (2603:10b6:208:26c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 13:06:24 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::207) by MWH0EPF00056D17.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.2 via Frontend
 Transport; Mon, 20 Jun 2022 13:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 13:06:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 20 Jun
 2022 13:06:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 06:06:21 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 20 Jun
 2022 06:06:19 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <eperezma@redhat.com>, <jasowang@redhat.com>, <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH RFC v1 1/3] vdpa/mlx5: Implement susupend virtqueue callback
Date:   Mon, 20 Jun 2022 16:06:12 +0300
Message-ID: <20220620130614.19679-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620130614.19679-1-elic@nvidia.com>
References: <20220620130614.19679-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29174267-edd2-48f3-7704-08da52bdad1f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4454:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44543D6CDA200EAA4985A867ABB09@MN2PR12MB4454.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3kcsymknxPWe+SKEO0qvs5QRDkkUbHQjGnUNM8GEnkv5qdot2ErgjKW5cbE/x3nPA7PcnpxaI1RBidQ7yOoCRkshSIa7r/LNUtwO50HMKzzlfgpBTPe5ksu2+XVd9w+rkP+Iy1AL17PUYfJbSg3Lm2V27H/qql5Xrgnz93JmFfbBA1e1SnX4mVoQSZKBhks9cvhUTURoLFbZtFmRFvNWpojCVQgfCwAHw7EedjVIWks/K7ZDb3jJGLSdiSuQOI5lvIPW77DXMlbQBH2DChWhiOQVbpvzeDTC4BLuVri0DEHPjxKcbxJpP6jJDQebUeu30MNmsDeFE/l03PdgfP3YA+iMv5rfww3KB2qNcR480Yx+Q6L6e8jRiKf4FPbKLhQ8qlSIf4NkAYH1hf978RmDXGbMXIjUGHYODWmghieBMHkXfgqTVgSzubFPYrPMSXMcoLpyBaObzBKvSY6zn2LgDiasgrhNhfsVsf12g/2eko4C0Pu/lojwRmL61f02WYXmz5/QWwoNdS7kz/BpSoP/j3RL949x4kIGuoG3qIbKsRrKVGRSD0Iwj6tc3qpoEs8r+TSNG5G1Dg2NgzL+ZJbCsmXoz5VuVf0BGEDpZFcv6BbQUVoV71BkEsrh6pZn7dUGwO13DXvZSxGnAcmIOp6XjG6Hhr6PuAcvfyQSjD7eH5F1YRUBx6BDUszpNjMnHR0O1IAdLyd/eVpnieorHS1tl8I/pPfHRqENGmPYAyo9LSJ8viv8Sfta0Mwv0bRZp2F
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(40470700004)(336012)(47076005)(4326008)(426003)(1076003)(8676002)(70586007)(70206006)(110136005)(40480700001)(186003)(54906003)(82740400003)(5660300002)(41300700001)(2616005)(7696005)(36756003)(26005)(107886003)(83380400001)(82310400005)(40460700003)(36860700001)(86362001)(2906002)(316002)(6666004)(8936002)(356005)(81166007)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 13:06:23.1913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29174267-edd2-48f3-7704-08da52bdad1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 68 +++++++++++++++++++++++++++++-
 include/linux/mlx5/mlx5_ifc_vdpa.h |  8 ++++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index fb0b23e71383..ea4bc8a0cd25 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -895,6 +895,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	if (err)
 		goto err_cmd;
 
+	mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT;
 	kfree(in);
 	mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
 
@@ -922,6 +923,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
 		mlx5_vdpa_warn(&ndev->mvdev, "destroy virtqueue 0x%x\n", mvq->virtq_id);
 		return;
 	}
+	mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
 	umems_destroy(ndev, mvq);
 }
 
@@ -1121,6 +1123,20 @@ static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueu
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
@@ -1130,6 +1146,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
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
@@ -1991,6 +2013,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct mlx5_vdpa_virtqueue *mvq;
+	int err;
 
 	if (!mvdev->actual_features)
 		return;
@@ -2004,8 +2027,16 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
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
@@ -2732,6 +2763,39 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
 	return err;
 }
 
+static void mlx5_vdpa_cvq_suspend(struct mlx5_vdpa_dev *mvdev, bool suspend)
+{
+	struct mlx5_control_vq *cvq;
+
+	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
+		return;
+
+	cvq = &mvdev->cvq;
+	cvq->ready = !suspend;
+}
+
+static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
+{
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	struct mlx5_vdpa_virtqueue *mvq;
+	int i;
+
+	if (!suspend) {
+		mlx5_vdpa_warn(mvdev, "Resume of virtqueues is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	down_write(&ndev->reslock);
+	for (i = 0; i < ndev->cur_num_vqs; i++) {
+		mvq = &ndev->vqs[i];
+		suspend_vq(ndev, mvq);
+	}
+	mlx5_vdpa_cvq_suspend(mvdev, suspend);
+	up_write(&ndev->reslock);
+	return 0;
+}
+
 static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_vq_address = mlx5_vdpa_set_vq_address,
 	.set_vq_num = mlx5_vdpa_set_vq_num,
@@ -2762,6 +2826,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.get_generation = mlx5_vdpa_get_generation,
 	.set_map = mlx5_vdpa_set_map,
 	.free = mlx5_vdpa_free,
+	.suspend = mlx5_vdpa_suspend,
 };
 
 static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
@@ -2827,6 +2892,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
 		mvq->index = i;
 		mvq->ndev = ndev;
 		mvq->fwqp.fw = true;
+		mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
 	}
 	for (; i < ndev->mvdev.max_vqs; i++) {
 		mvq = &ndev->vqs[i];
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

