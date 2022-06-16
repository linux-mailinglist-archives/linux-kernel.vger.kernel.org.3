Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9654E1EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377005AbiFPN1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376850AbiFPN1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:27:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3F71055D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVOcuCtYX4d3vWL0Qa5ca4e/hO+vgARV6DiWgf/TVpV1hq9rKH/Sh5MffejAUCa69wDWH5dtECT430JWOvGqDuwMhryLIOI97MXKIRB1qtEK9pGp+mmRGoegWsP8XAczMmsuRcDQfG2ZksnY13sLhYRj1BiW6BiPri/nk08HZIn5GARaRJrQcf4Umf8Q83yogXKoo+hSxVNVynS2GVQ8IQ4gWvo1C+KI90M3zZ426LIUa5C4lFOagPu5rwPNks8wzM4e4ygZxtRD+20umUN4C1QpCMSdcLedbSelDUZ36+O8hC9KNFlenLr1KdjLz4D1x3RTxEUOxzJthJo5QOAyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1TNaiYlGz6BOATzCfzpp76zcvcQbVRq3YMZbzx1OS0=;
 b=ONmbyiMg3fkr/GyzudjnGaYpgfL/6eqyaBUa1e30BVdykcvnoABRA7FGbnl5BftrZ0r/1IZBOdPnw6a3fLXagUtPhomCAinyi3UTrj/HyTTFuK2leQbf1IQ/nYh7mO9C1NNVuTZTugh3uCkPv0IcxX6Z4MGxV1dTi4pMrKiqjslF6t6iMDGKruTEPa1Zd4G5JZ085li92d3XK8sPfL5dphACwQlzMqGWQ2qVSK5jBs1pyI2KKyO49TuFQHdl2QUARAjb5wTEGFlguZll10ZmCfxf4P7qjNZ4vNpPz0LFp4Gtw412AOuWbfp7ZWbomD7n6Cjkf7Sd6mPTWRqKqo6jWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1TNaiYlGz6BOATzCfzpp76zcvcQbVRq3YMZbzx1OS0=;
 b=OxdX1/xpf0BxRg1Imol0U4ld+XA5eSGrZsCUS9RKXW+BTkaMj2k+XLMbXBI72xrwzOwcJgH0yhDwbC7kSesF483iHJv3a+G8ihcr22b5gyeEWp0j8ocEIP4dzxY8C59WW7nS/t8QA3vbCR7slfSg1gDiPhSa3ZByJvt1I2aRB2Sv/9R4HUQZyyqfAW/HatWu4chvolOEDqumpRkG6TdMMAAQLi9tx8iHbn4CXJkVwxSfEhuMEAj06ghOu5vZLJw8UoSQ/S4xnf8hC4TyY8z5XBJLUJ6/2sc+9IrE6VaaL1MUYQHyh1wnHKgN0mzvEkOggsWjAOiqdumHTnwMnTMuYA==
Received: from MWHPR12CA0052.namprd12.prod.outlook.com (2603:10b6:300:103::14)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 16 Jun
 2022 13:27:35 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::7c) by MWHPR12CA0052.outlook.office365.com
 (2603:10b6:300:103::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 13:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Thu, 16 Jun 2022 13:27:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 16 Jun
 2022 13:27:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 16 Jun
 2022 06:27:33 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Thu, 16 Jun
 2022 06:27:31 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <eperezma@redhat.com>, <jasowang@redhat.com>, <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
Date:   Thu, 16 Jun 2022 16:27:23 +0300
Message-ID: <20220616132725.50599-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616132725.50599-1-elic@nvidia.com>
References: <20220616132725.50599-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cd4b356-0112-4cd8-3599-08da4f9bf962
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5047D041FDB99DD4E860DB9FABAC9@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b13mvtWNB839LkNVeFDSAkz+hrsMMZ4gp28X6qXtQ+BuHwf7sLBYRFifN6oPyBujP2klomFN4Q5yRPYH6DkRwxMZClbS5fnrHoNGIJe/SjPMFHPx68XAz48Olkg7vcORrmnBXaY3A7TQMn9kHQH090Eh7I+TaTFA7KLsh1aTD9Ue2giMYZcJRzg3AOUGbJBXkSvSQGysd2AQrpKLPSy0VprjDCAuir+Z8VbVAC1dhGvqHIewcLP5qmw7NQWgtZCFMcxyiEI7FEagRpOoJRW3aTV55HbqnkD91YI4Oh0Hwf3waKtmzJHuKSnAdFOAe3rb4hinEW/JlgpsSqV1UbSugSI8KF0HPtHjXLcpB6GbVVgAVUaJqNWKh1jwkzD7g6UIwvRlqUtQ3g6594fvmb80CwGsY9PYn7bInhBxdv/K/r3Eo5MEQxCA7sd46IFMBE7nu43ASl6JbW0xrl9crzGg3AKzI+wmC+q0cOD3Y9BODbjpykqaZ0CXVg9eeZ3nQMm7R1i+Iyf7FbvLglxIlnfc649oC70vAWBecZP+q7mfK3noSzKiMOxgakrxt6oBH5rb479ZtJgaleZ2AAyWmdOn1VQCi+ML6fCO3jYVREStRVC9wH2EOhsjtSzKyv6Sch3IhgmphUiDQA+ccP8d/xcOiT7WZA7xCtRcJ1vvsLg6ir2jkhkwwqK4UtReuz06H3ePm3F9TbUpqZufwgt3RMZBAQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(8676002)(81166007)(36860700001)(83380400001)(4326008)(40460700003)(26005)(70586007)(82310400005)(86362001)(5660300002)(70206006)(186003)(508600001)(7696005)(110136005)(47076005)(336012)(356005)(426003)(2616005)(1076003)(2906002)(36756003)(316002)(6666004)(107886003)(54906003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 13:27:34.7740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd4b356-0112-4cd8-3599-08da4f9bf962
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
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
they stop processing descriptors. This is required to allow the shadow
virtqueue to kick in.

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
index 4414ed5b6ed2..423562f39d3c 100644
--- a/include/linux/mlx5/mlx5_ifc_vdpa.h
+++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
@@ -150,6 +150,14 @@ enum {
 	MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR      = 0x3,
 };
 
+/* This indicates that the object was not created or has alreadyi
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

