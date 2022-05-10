Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966365213BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbiEJLcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240981AbiEJLbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:31:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814FA224A73
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz4ApkRILfW3DJZyC7xAuRSZky7i2rxwCGQJmvhT2ORO8nkiWKgdD7hRj2b4op+dM44tSZvF8EY3HsCRw33r42puITjRy6NRhkuMwnewUMRAHNRHt17+HK6LSuQrNupxy371hLmNVUCYovhtHeiS6R1WCdh8FKjYln/RRO+AjqJf45/DXVNaT8TI5T7bn8/hnhCQ2di40LsIrAtU8tfvsG1yJLizV0aW2vGmR5deln8ubZIa+I12SV9HxPr6LMIe0s2bRCjQCk0Uqt/0x/tD3bnYklDfeLfJ+YiF4fWbsJs74cgR1Y7hmba61pSoJDuRYF49PBtjkAYLnnBdVGNDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnGB/r1aogWuiq/xH3oeOf8AVfUAV2kjkRRjhIxl1lE=;
 b=MtIZgswljZmBuLGHq3qR2m7RpVqZrKEBdHWy3Rso05TnDmyV830y8lwULDCAAqKEBwY3LWzdNtOOMwXtlYYLMJ4uYYoo5oCuUoaVGXh0ShKctXtrGs3Y1I6CnIuPLWOLM9uLju1Sx7EY02b0NYO8O5tQ0FNCT5uzXq9Kr/uFYTm6X06TmuvS4JnrWfLtZbVzIcjelLQRrmnBE6mUNtp21PDnAsMiz89ekS5cJD6f0ospaQTBKRTYyvWDh1JOedMisDqZ4dgSFl1pctIQMoP2ItTtFrCycSJCT5URDevNCH0SxRq1O5NJs9zByGPlvgAt0GVNPia2bOdrV8eXT9LXGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnGB/r1aogWuiq/xH3oeOf8AVfUAV2kjkRRjhIxl1lE=;
 b=J/ogylL2UrJhltuGd3ImqoJvANDXe1Z5V/HY7CLTNpgl/sJIONeHf+COHUohiqIACdpQB8xx5hxoGYDhBYlXc4KAceyaz2Jql5aDpZbeXdLUuMhiWdFHCesPZh4LuLbTkwCHsRA0XXRxOY8aUFRiX3ZJF+VLbCbYARnC6Hg5MjwIl/lxrctD+I8b/R4QokyW6yFfNuQtaipvWA5bQtYfLBphnowRDBk+5wGrRxTfKfP7x5iaz5IXvXb573vGTOomfJm73+YRUNaT+wS/qfoPj214dz/qEZPD9Crd3UIrvxrS8omrFrRtXUUECJc98/rLkYV6a8WWhxk7JC5uKTm3FQ==
Received: from DM5PR07CA0091.namprd07.prod.outlook.com (2603:10b6:4:ae::20) by
 CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Tue, 10 May 2022 11:27:48 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::7b) by DM5PR07CA0091.outlook.office365.com
 (2603:10b6:4:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Tue, 10 May 2022 11:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 11:27:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 10 May
 2022 11:27:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 04:27:45 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Tue, 10 May
 2022 04:27:44 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v5 3/3] vdpa/mlx5: Add support for reading descriptor statistics
Date:   Tue, 10 May 2022 14:27:34 +0300
Message-ID: <20220510112734.205669-4-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510112734.205669-1-elic@nvidia.com>
References: <20220510112734.205669-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a012206-b28c-44d1-7b88-08da32781ce4
X-MS-TrafficTypeDiagnostic: CY5PR12MB6479:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6479F7110FAE735137DA0485ABC99@CY5PR12MB6479.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJe39LmHip5GUCGcpltcnuK57rsok2y2u1+/b0Q1FnWlJuaF3EIKFlwwMWkHq8fMlNXdlkts8tMqC8Q9/5ormUu8RVAzMOQrLH5PHrWiOMwZHachgT50pBcPKPI7QSY3yOJRQonmiV7S5W7ElLKJ3+FRPmR7qLyIAglIEtZ+t08K2v8eQBmWCi9oQ4W/JPEHOw1vLEayQdu3s0wjrfvxn+OlJ5BN55nW6Xol7IxPqW4XU+tSvxV6NhZ5iPtiEpM1sucYfMyrZgHI14aCjFkRTbWQ2kR9avhNhZL1ede1wy9uYn0QOcoQ5rGm8VfKV8X+oJJcAEXF41BZTx49/Hv0O2OQeIKjSOWhk7/61NOSipBBSikgH82STe0wWg9JaDTDaxkacdTEt0tpPgFYGqEvXVkoOH3DSbrpWNQfoGn58a7vgM7l8qaKWjAOFrD5myXZbPkwhImYVPqOyzmOvuFtlxSRoZ2BE6r8lUcq2rWiUA1fYU9IgXtqKK3vAc1DPTS8cV8HZErcq/PlghmAcZdfFDaN8WEsUQ+YlN1p7wMPsGXa3UYKwrF09KOaQxqbW45BpsJVjPg8Vvm/9ekxiM84sMHJyJIJYTkAC2cpxdRWvKaw4el5tfKJ7F1+PZzyFbwn9dL160Mg7Kio7j/3+0xGd9chDe1ZodAierGzMMcUgDTqCrVeSFid10cv/obKJdKV9gs0aJNvCEgurePCnJc7RA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(30864003)(86362001)(7696005)(6666004)(508600001)(8936002)(5660300002)(81166007)(83380400001)(356005)(2906002)(40460700003)(36860700001)(26005)(2616005)(107886003)(1076003)(336012)(426003)(186003)(47076005)(110136005)(316002)(36756003)(82310400005)(54906003)(8676002)(4326008)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 11:27:48.6984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a012206-b28c-44d1-7b88-08da32781ce4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
---
v4 -> v5:
 Remove numq_lock mutex. Use reslock instread.


 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 165 +++++++++++++++++++++++++++++
 include/linux/mlx5/mlx5_ifc.h      |   1 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |  39 +++++++
 4 files changed, 207 insertions(+)

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
index 79001301b383..99b0621e7a87 100644
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
@@ -2442,6 +2504,108 @@ static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
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
+	if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_FEATURES_OK)) {
+		NL_SET_ERR_MSG_MOD(extack, "feature negotiation not complete");
+		err = -EAGAIN;
+		goto out_err;
+	}
+
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
+	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
+			      mvdev->actual_features, VDPA_ATTR_PAD))
+		goto out_err;
+
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
@@ -2451,6 +2615,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
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

