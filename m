Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A331A52476B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351215AbiELHv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351195AbiELHvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:51:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046BF2CCAF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:51:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go+xOKAGv/jkiJmw+lAswkwXdjBauLH2y3li9Zxmvj46dNpb1+/Btd2ceyinTR96YJdy9edqyPwwgCwBR/ZCGibYlAx4B+IPu6MO04pO+AJbTaTV103TvJMK1eARS9fqdVyZkSv4KXF09wJANbaUo+M+kiaflecU9kk73opF79tRFWNRjsPhZ/aKI1dq0/95d3tUN+M4+zLPIY97P91G+6FJO427uPqt8eRH4p4uQw0TScHiNEiB+2FJjAaNIonj26mONSlNN7e4n0lllSLYxUdM4JgMk3HOq0wwlVUq+cMSK1YN3wKeLzPD97lkfDfoGCYvaTB2Zs4aEgdH+wlN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=312A3BVq8nGwxPItx97gwsGjNQOj1EAqLAX9lSsqoQQ=;
 b=AQl2i36WwH8zE+J7UYquvwJRRHZo3KuIL8FcSL+Nou7qQiYG+0Xw5f8UCghu1mwXj6h90raSVKWCY9TiDKsLPr9lwKccIvcfBXYgMDxfl7L8PQVgK+4ZtpMD63xG+0Tce9//kRIkcy2TaIOUlOd1y9Y8oR1TNZVkFhlOvrWINY6GoAJzW4vp0e0ZEp4aiLz08IhcJGKuI7micW17Zhu64YRU12jNtPDnadZ7qmqKqy4r+yZnO5OQ4smHI0cnn/ADepS7JaGbmkFjb/GTVGst9mOgwvQ4y8M0VVa3EpDYji6jMLvZspKN8uhaLp3+Xw7a/l0qsRvu7/ANhK0k3ziDVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=312A3BVq8nGwxPItx97gwsGjNQOj1EAqLAX9lSsqoQQ=;
 b=VQ0OTHOgbEw+lDCsmbKUzL0ntU8hXi3n2FzRBnmj+4O0eKjXaaBxiCdA8tnJ05eWipBPNrwJJ/b7YqacYBnzPKcXT0nC2ZIUAmxC7/QlgjCvOs802vnzKpyDNnpOWO/VhW5nHeQaeyEVkT37s0zXAtYD7TZfwabu4nWy5VNNBLTCruAxeopZGgbQwkzktgJWU0+ef1F9h4ZIKx4IQgKGz3SVqDKu1q1C8MqEwAi0MKZpqeBOrA6hgq+D1Tz4AroVlRcLCPlnDmUc1qIRSF+6bNymXkgtQhKMTmAZCOpQYGv6Q34k2H6vrlOtUzVrUVKU9x2Xs3j8ObkM+jI3K05AmQ==
Received: from MW4PR03CA0028.namprd03.prod.outlook.com (2603:10b6:303:8f::33)
 by MW2PR12MB2474.namprd12.prod.outlook.com (2603:10b6:907:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 07:51:13 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::78) by MW4PR03CA0028.outlook.office365.com
 (2603:10b6:303:8f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Thu, 12 May 2022 07:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 07:51:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 12 May 2022 07:51:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 00:51:12 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 12 May 2022 00:51:10 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v6 4/4] vdpa/mlx5: Add support for reading descriptor statistics
Date:   Thu, 12 May 2022 10:51:00 +0300
Message-ID: <20220512075100.1715286-5-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512075100.1715286-1-elic@nvidia.com>
References: <20220512075100.1715286-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd671e95-ba6e-4666-030e-08da33ec2fc9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2474:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB247472B55D8CE363C70DE6CBABCB9@MW2PR12MB2474.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H2YpElOH5Y4jmYhIkYejiY3694HmnSGelqgsAYJN84FKnGkGTVdHaVLovdz5pxHdwWr5TpZ9rV3omEOxSEsHOEdfUbcqNA8ibc2Xfsj4R9gp5icn/Hu+Vr/gMnxKC2Hlir1JzKFHmeU0jXUVfFLXCLVQuEo+i467KTZMO/IZmGzbeKTpO+kS0GCohua3DfGl/IruFXZrEtfT8H4pm7smbYkzmTFfVqjHYAwTM89BtvUOFMvLyDdwvhjCN5Zmp9aMNibGhWwRi1fh53hR+Xr6bika5ZeAcRNywEi8dbRz36FwQcyzRrMU12jQasc4Oj2wjaVK7BNRPg4Do1ESqVaDv4+Lov84J6aqKWFWFmK7FKRO3NJY22rpXIVWfCIooRu2UTyd/yAai2Y9CjnwLxPE+uGbNGX5MDsJn7/X9tolTBGfopbjWJS5P+2cjJVeQXWuDNOhNxdQuXaEbPHwmBSggGZ3b+nD6iVeau2d6l30LiwAg6T0yY9a/1mFnhLyl0YSpFOmiGbFoz1hJZXtKd9I6MRQViXZ0TNAjzN1i8o4sFUcRLg1eLPNjjoVFymsZqME5nYixEb0QFaozHKwoUMaqMJz68ZaxxR8rRunRZtuKalK8p7Mu+sIRD8iDtBhpvpvOFQwsjEtmo40FLTQQHBGTH4I2TqnHE7pKpCQR3OcEAwejpyIqHOKR2AgKP/Qkhf3gwZCw2l/w5PxvhZm1E7CMg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(86362001)(7696005)(6666004)(336012)(426003)(40460700003)(36860700001)(83380400001)(81166007)(54906003)(2616005)(26005)(1076003)(186003)(82310400005)(356005)(8936002)(107886003)(36756003)(5660300002)(2906002)(316002)(110136005)(8676002)(70206006)(70586007)(4326008)(30864003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 07:51:13.2253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd671e95-ba6e-4666-030e-08da33ec2fc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2474
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the get_vq_stats calback of vdpa_config_ops to return the
statistics for a virtqueue.

The statistics are provided as vendor specific statistics where the
driver provides a pair of attribute name and attribute value.

In addition to the attribute name/attribute value pair, the driver
returns the negotiated features and max virtqueue pairs for userspace
can decide for a given queue index whether it is a data or control
virtqueue.

Currently supported are received descriptors and completed descriptors.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>

v3 -> v4:
Only return statistics if feature negotiation was complete
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 155 +++++++++++++++++++++++++++++
 include/linux/mlx5/mlx5_ifc.h      |   1 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |  39 ++++++++
 4 files changed, 197 insertions(+)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index daaf7b503677..44104093163b 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -61,6 +61,8 @@ struct mlx5_control_vq {
 	struct vringh_kiov riov;
 	struct vringh_kiov wiov;
 	unsigned short head;
+	unsigned int received_desc;
+	unsigned int completed_desc;
 };
 
 struct mlx5_vdpa_wq_ent {
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 79001301b383..c9759021dfd6 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -119,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
 	struct mlx5_vdpa_umem umem2;
 	struct mlx5_vdpa_umem umem3;
 
+	u32 counter_set_id;
 	bool initialized;
 	int index;
 	u32 virtq_id;
@@ -164,6 +165,7 @@ struct mlx5_vdpa_net {
 	struct notifier_block nb;
 	struct vdpa_callback config_cb;
 	struct mlx5_vdpa_wq_ent cvq_ent;
+	/* sync access to virtqueues statistics */
 };
 
 static void free_resources(struct mlx5_vdpa_net *ndev);
@@ -822,6 +824,12 @@ static u16 get_features_12_3(u64 features)
 	       (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_CSUM)) << 6);
 }
 
+static bool counters_supported(const struct mlx5_vdpa_dev *mvdev)
+{
+	return MLX5_CAP_GEN_64(mvdev->mdev, general_obj_types) &
+	       BIT_ULL(MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
+}
+
 static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
@@ -876,6 +884,8 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
 	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
 	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
+	if (counters_supported(&ndev->mvdev))
+		MLX5_SET(virtio_q, vq_ctx, counter_set_id, mvq->counter_set_id);
 
 	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
 	if (err)
@@ -1139,6 +1149,47 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	return err;
 }
 
+static int counter_set_alloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+{
+	u32 in[MLX5_ST_SZ_DW(create_virtio_q_counters_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(create_virtio_q_counters_out)] = {};
+	void *cmd_hdr;
+	int err;
+
+	if (!counters_supported(&ndev->mvdev))
+		return 0;
+
+	cmd_hdr = MLX5_ADDR_OF(create_virtio_q_counters_in, in, hdr);
+
+	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
+	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
+	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
+
+	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out));
+	if (err)
+		return err;
+
+	mvq->counter_set_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
+
+	return 0;
+}
+
+static void counter_set_dealloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+{
+	u32 in[MLX5_ST_SZ_DW(destroy_virtio_q_counters_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(destroy_virtio_q_counters_out)] = {};
+
+	if (!counters_supported(&ndev->mvdev))
+		return;
+
+	MLX5_SET(destroy_virtio_q_counters_in, in, hdr.opcode, MLX5_CMD_OP_DESTROY_GENERAL_OBJECT);
+	MLX5_SET(destroy_virtio_q_counters_in, in, hdr.obj_id, mvq->counter_set_id);
+	MLX5_SET(destroy_virtio_q_counters_in, in, hdr.uid, ndev->mvdev.res.uid);
+	MLX5_SET(destroy_virtio_q_counters_in, in, hdr.obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
+	if (mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out)))
+		mlx5_vdpa_warn(&ndev->mvdev, "dealloc counter set 0x%x\n", mvq->counter_set_id);
+}
+
 static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 {
 	u16 idx = mvq->index;
@@ -1166,6 +1217,10 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 	if (err)
 		goto err_connect;
 
+	err = counter_set_alloc(ndev, mvq);
+	if (err)
+		goto err_counter;
+
 	err = create_virtqueue(ndev, mvq);
 	if (err)
 		goto err_connect;
@@ -1183,6 +1238,8 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 	return 0;
 
 err_connect:
+	counter_set_dealloc(ndev, mvq);
+err_counter:
 	qp_destroy(ndev, &mvq->vqqp);
 err_vqqp:
 	qp_destroy(ndev, &mvq->fwqp);
@@ -1227,6 +1284,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
 
 	suspend_vq(ndev, mvq);
 	destroy_virtqueue(ndev, mvq);
+	counter_set_dealloc(ndev, mvq);
 	qp_destroy(ndev, &mvq->vqqp);
 	qp_destroy(ndev, &mvq->fwqp);
 	cq_destroy(ndev, mvq->index);
@@ -1681,6 +1739,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 		if (read != sizeof(ctrl))
 			break;
 
+		cvq->received_desc++;
 		switch (ctrl.class) {
 		case VIRTIO_NET_CTRL_MAC:
 			status = handle_ctrl_mac(mvdev, ctrl.cmd);
@@ -1704,6 +1763,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 		if (vringh_need_notify_iotlb(&cvq->vring))
 			vringh_notify(&cvq->vring);
 
+		cvq->completed_desc++;
 		queue_work(mvdev->wq, &wqent->work);
 		break;
 	}
@@ -2323,6 +2383,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->cur_num_vqs = 0;
+	ndev->mvdev.cvq.received_desc = 0;
+	ndev->mvdev.cvq.completed_desc = 0;
 	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
 	ndev->mvdev.actual_features = 0;
 	++mvdev->generation;
@@ -2442,6 +2504,98 @@ static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
 	return mvdev->actual_features;
 }
 
+static int counter_set_query(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq,
+			     u64 *received_desc, u64 *completed_desc)
+{
+	u32 in[MLX5_ST_SZ_DW(query_virtio_q_counters_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(query_virtio_q_counters_out)] = {};
+	void *cmd_hdr;
+	void *ctx;
+	int err;
+
+	if (!counters_supported(&ndev->mvdev))
+		return -EOPNOTSUPP;
+
+	if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
+		return -EAGAIN;
+
+	cmd_hdr = MLX5_ADDR_OF(query_virtio_q_counters_in, in, hdr);
+
+	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_QUERY_GENERAL_OBJECT);
+	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
+	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
+	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_id, mvq->counter_set_id);
+
+	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out));
+	if (err)
+		return err;
+
+	ctx = MLX5_ADDR_OF(query_virtio_q_counters_out, out, counters);
+	*received_desc = MLX5_GET64(virtio_q_counters, ctx, received_desc);
+	*completed_desc = MLX5_GET64(virtio_q_counters, ctx, completed_desc);
+	return 0;
+}
+
+static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
+					 struct sk_buff *msg,
+					 struct netlink_ext_ack *extack)
+{
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	struct mlx5_vdpa_virtqueue *mvq;
+	struct mlx5_control_vq *cvq;
+	u64 received_desc;
+	u64 completed_desc;
+	int err = 0;
+	u16 max_vqp;
+
+	mutex_lock(&ndev->reslock);
+	if (!is_index_valid(mvdev, idx)) {
+		NL_SET_ERR_MSG_MOD(extack, "virtqueue index is not valid");
+		err = -EINVAL;
+		goto out_err;
+	}
+
+	if (idx == ctrl_vq_idx(mvdev)) {
+		cvq = &mvdev->cvq;
+		received_desc = cvq->received_desc;
+		completed_desc = cvq->completed_desc;
+		goto out;
+	}
+
+	mvq = &ndev->vqs[idx];
+	err = counter_set_query(ndev, mvq, &received_desc, &completed_desc);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "failed to query hardware");
+		goto out_err;
+	}
+
+out:
+	err = -EMSGSIZE;
+	max_vqp = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
+	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
+		goto out_err;
+
+	if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "received_desc"))
+		goto out_err;
+
+	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, received_desc,
+			      VDPA_ATTR_PAD))
+		goto out_err;
+
+	if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "completed_desc"))
+		goto out_err;
+
+	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, completed_desc,
+			      VDPA_ATTR_PAD))
+		goto out_err;
+
+	err = 0;
+out_err:
+	mutex_unlock(&ndev->reslock);
+	return err;
+}
+
 static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_vq_address = mlx5_vdpa_set_vq_address,
 	.set_vq_num = mlx5_vdpa_set_vq_num,
@@ -2451,6 +2605,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.get_vq_ready = mlx5_vdpa_get_vq_ready,
 	.set_vq_state = mlx5_vdpa_set_vq_state,
 	.get_vq_state = mlx5_vdpa_get_vq_state,
+	.get_vendor_vq_stats = mlx5_vdpa_get_vendor_vq_stats,
 	.get_vq_notification = mlx5_get_vq_notification,
 	.get_vq_irq = mlx5_get_vq_irq,
 	.get_vq_align = mlx5_vdpa_get_vq_align,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 49a48d7709ac..1d193d9b6029 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -94,6 +94,7 @@ enum {
 enum {
 	MLX5_OBJ_TYPE_GENEVE_TLV_OPT = 0x000b,
 	MLX5_OBJ_TYPE_VIRTIO_NET_Q = 0x000d,
+	MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS = 0x001c,
 	MLX5_OBJ_TYPE_MATCH_DEFINER = 0x0018,
 	MLX5_OBJ_TYPE_MKEY = 0xff01,
 	MLX5_OBJ_TYPE_QP = 0xff02,
diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
index 1a9c9d94cb59..4414ed5b6ed2 100644
--- a/include/linux/mlx5/mlx5_ifc_vdpa.h
+++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
@@ -165,4 +165,43 @@ struct mlx5_ifc_modify_virtio_net_q_out_bits {
 	struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
 };
 
+struct mlx5_ifc_virtio_q_counters_bits {
+	u8    modify_field_select[0x40];
+	u8    reserved_at_40[0x40];
+	u8    received_desc[0x40];
+	u8    completed_desc[0x40];
+	u8    error_cqes[0x20];
+	u8    bad_desc_errors[0x20];
+	u8    exceed_max_chain[0x20];
+	u8    invalid_buffer[0x20];
+	u8    reserved_at_180[0x280];
+};
+
+struct mlx5_ifc_create_virtio_q_counters_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
+	struct mlx5_ifc_virtio_q_counters_bits virtio_q_counters;
+};
+
+struct mlx5_ifc_create_virtio_q_counters_out_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
+	struct mlx5_ifc_virtio_q_counters_bits virtio_q_counters;
+};
+
+struct mlx5_ifc_destroy_virtio_q_counters_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
+};
+
+struct mlx5_ifc_destroy_virtio_q_counters_out_bits {
+	struct mlx5_ifc_general_obj_out_cmd_hdr_bits hdr;
+};
+
+struct mlx5_ifc_query_virtio_q_counters_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
+};
+
+struct mlx5_ifc_query_virtio_q_counters_out_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
+	struct mlx5_ifc_virtio_q_counters_bits counters;
+};
+
 #endif /* __MLX5_IFC_VDPA_H_ */
-- 
2.35.1

