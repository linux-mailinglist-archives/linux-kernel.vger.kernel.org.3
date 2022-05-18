Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06AB52BCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbiERNir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbiERNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:38:24 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2058.outbound.protection.outlook.com [40.107.101.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DC7170666
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS0VxYoEPFaPjxc8bYVz44IveL01A0S5mgJ/tSZtR+Pj5j2ZRysy0Y/dhJegLupB95r76RJvZ9uE7z8SCitWnUbh7RdmENq5GkB1Pzt+xkF56bWcq5pWqut3Ek9jeUeuUs5rEuLicULGjfaP5vLfbtyfFy8q7yu1NCuFacYu/hfofqOS/6To8v+nknFEeuK5Rb8tvXhRK1INr85Vc9SFsVblCXrCMM/ta7YUFwLaxsFNSCoDqfl2GGmO94bIENRT/iX1pp43EeCEAmcWmraNR+xG2S18T8nE30b0scam7RhBMjSB953h3/aQ1+HBlxVA3Hgzz+nDuOIuhyumfTN3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DItOkeNP3L8G1rp1N7chn23N4FgDIkEm7EoUFb+2nPs=;
 b=bjReenxjEMzXknyUos1fUoqcGJwP+5MwgfPA4/vunBxgeGskcWXrrxOjjOlbExMM/d5ff5pQJXrTNbVLzyVm53wzhKsuo6hLU5xY1GmAYqhB/OcQr98Rg/0EgWzcRHG7vAzXzNgJPTkWa3BALvz6DXlk1We8Vn/7WTsI8TWOO9bbHnflRTU4cM0XeNA8ZPlVKuCSrt4zmuxXsY8hpbWzOWbslVOP/k/RK+DDjQIwdzavTFHF2GILpVnuVCjLAOJnbGp+NDRtn03Z4fJEHMvadG3oxG/YC8ZTeO8lORAaY9ZSahiEnwl6igJBz2y8IjniTD42pUMoTlhkaAh0KmqcQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DItOkeNP3L8G1rp1N7chn23N4FgDIkEm7EoUFb+2nPs=;
 b=cEm3uyjB7+knxQae35pNmMsNXGDA/NC4RF4vo7E4nOk0v/LeTCjr9IyhxUpeZ8xjV2rJVIgMmHncbQyTHb32SCcTw17a1WSkBfJkik7o9Zdm4yFY26oM/e1P3QVOAMAslYkXhiXvd8dqgIhYphbzozSXR+g31NQQauW/Yhg6dvaOFI/p/fPD058bdudiOgUzTSsmbudUXUend4WXeIwOXzRBLq1ybZH6araTG4dbsWuOtjPFOvJFJBNgC/Ov3fuw81Epc5DP12Krb1XqsXrNEJj///ysqawYuzYgrLLpqyuLvKDw6l1L8vOW8UhlsZNd0BPk7UAjUTTLrEN7qWs7Uw==
Received: from BN9PR03CA0444.namprd03.prod.outlook.com (2603:10b6:408:113::29)
 by DM6PR12MB4529.namprd12.prod.outlook.com (2603:10b6:5:2ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 13:38:21 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::ed) by BN9PR03CA0444.outlook.office365.com
 (2603:10b6:408:113::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Wed, 18 May 2022 13:38:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 13:38:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 18 May
 2022 13:38:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 06:38:19 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 18 May
 2022 06:38:17 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v8 5/6] vdpa/mlx5: Add support for reading descriptor statistics
Date:   Wed, 18 May 2022 16:38:03 +0300
Message-ID: <20220518133804.1075129-6-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518133804.1075129-1-elic@nvidia.com>
References: <20220518133804.1075129-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd581a8e-b603-41f9-cd66-08da38d3ac92
X-MS-TrafficTypeDiagnostic: DM6PR12MB4529:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB45291684287E83EFCDFA7E37ABD19@DM6PR12MB4529.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haMfXm3cNRzqadcsjxJT9blcYCUsjlzTBbWeXgQv7ayCN5oEka5ZBt73zj4kOevtWdhaKFDk51H40edSOLkDNb3/vuSY7QR92gLhainouLoDv2nRHX79pL3wwY7bRJN5J9XCq/UBVFRPKNqfKOKqAH199OTx3S501Qup588w5HSa0JfMC1I/62Ia8MS2KeHueO3U+PDf0Fnv803ufzK/GrVvAi1ytPRTi3QN9pdGdbdGrZy5OFk3BG3ruypgsUWTbFXioShClDrdnWyc0o6dpVM5jQE3BCBnRMvzpaLkCB+mr/O08eIzU+09PDSz2qXP9QHi0bEBHITlhgRE7dlndACRHk4WcefD7h401N0NIZEOZNv6Z3RFS2q5zIPCCg9zVG8B5mVqmqFeW/2nag8MHLYqvYK13Ct7DS94kZXj1GvrR/Mu8jpi+pAjHLRrtcT5/pOdMUlNYGzG/G4/aY8npkrP7bExRcyx69ooJTsUcDZTvC9r3iJ2ztsDYuDNleB030ba+EPdf13TvCIqNoPiAvREYlwFGyvYmRSVORv9KIumAGYDaihv/9YlT7ha6CvI58L8zr7ujXjr5iStrTy8VC/541yISUuN7UUIsEts6iokzycU4bjRCNl/J6BgMSTVLVnCbP1mzPfZAiAmFeyBr6kEweqN132yfge3h4L4SmzvdGO6UfjDgKzwLL9TZHhIA2YNRNqiqqzxJvEFRbOTaQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(81166007)(47076005)(1076003)(2616005)(36860700001)(107886003)(7696005)(508600001)(336012)(36756003)(2906002)(54906003)(82310400005)(6666004)(426003)(110136005)(316002)(83380400001)(26005)(86362001)(30864003)(70206006)(5660300002)(70586007)(8936002)(356005)(186003)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 13:38:20.9184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd581a8e-b603-41f9-cd66-08da38d3ac92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4529
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Currently supported are received descriptors and completed descriptors.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 149 +++++++++++++++++++++++++++++
 include/linux/mlx5/mlx5_ifc.h      |   1 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |  39 ++++++++
 4 files changed, 191 insertions(+)

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
index e0de44000d92..2b815ef850c8 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -119,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
 	struct mlx5_vdpa_umem umem2;
 	struct mlx5_vdpa_umem umem3;
 
+	u32 counter_set_id;
 	bool initialized;
 	int index;
 	u32 virtq_id;
@@ -818,6 +819,12 @@ static u16 get_features_12_3(u64 features)
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
@@ -872,6 +879,8 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
 	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
 	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
+	if (counters_supported(&ndev->mvdev))
+		MLX5_SET(virtio_q, vq_ctx, counter_set_id, mvq->counter_set_id);
 
 	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
 	if (err)
@@ -1135,6 +1144,47 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
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
@@ -1162,6 +1212,10 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 	if (err)
 		goto err_connect;
 
+	err = counter_set_alloc(ndev, mvq);
+	if (err)
+		goto err_counter;
+
 	err = create_virtqueue(ndev, mvq);
 	if (err)
 		goto err_connect;
@@ -1179,6 +1233,8 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 	return 0;
 
 err_connect:
+	counter_set_dealloc(ndev, mvq);
+err_counter:
 	qp_destroy(ndev, &mvq->vqqp);
 err_vqqp:
 	qp_destroy(ndev, &mvq->fwqp);
@@ -1223,6 +1279,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
 
 	suspend_vq(ndev, mvq);
 	destroy_virtqueue(ndev, mvq);
+	counter_set_dealloc(ndev, mvq);
 	qp_destroy(ndev, &mvq->vqqp);
 	qp_destroy(ndev, &mvq->fwqp);
 	cq_destroy(ndev, mvq->index);
@@ -1659,6 +1716,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 		if (read != sizeof(ctrl))
 			break;
 
+		cvq->received_desc++;
 		switch (ctrl.class) {
 		case VIRTIO_NET_CTRL_MAC:
 			status = handle_ctrl_mac(mvdev, ctrl.cmd);
@@ -1682,6 +1740,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 		if (vringh_need_notify_iotlb(&cvq->vring))
 			vringh_notify(&cvq->vring);
 
+		cvq->completed_desc++;
 		queue_work(mvdev->wq, &wqent->work);
 		break;
 	}
@@ -2303,6 +2362,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->cur_num_vqs = 0;
+	ndev->mvdev.cvq.received_desc = 0;
+	ndev->mvdev.cvq.completed_desc = 0;
 	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
 	ndev->mvdev.actual_features = 0;
 	++mvdev->generation;
@@ -2422,6 +2483,93 @@ static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
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
@@ -2431,6 +2579,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
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

