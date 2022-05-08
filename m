Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F651EEF6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiEHQhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiEHQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:37:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B08CBF6F
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMCRLFdJuoszTB+ltBRbk9ZtcCP+U1R7Xyk6O/BMnjT56gwd8cV9oeBNsStJ9bl6uf3SXcnmq7tuMFvqhvaobtO9g1gF7xsfCiEYhaXlH3FmP7EzGTsD7hAkhQOPTkFLPA9U92x9THTUQR5OocHv7C7aeCOH83zP9yEPnSUAhkSznlLmstYztiB/5/yb+vgp3I605+MOBy1M/FtkoovfBylet5KBzIXvHl4cnyo6DkjST5ohB6oqtf9aGhmG+kirwFQ6mmkRkPEoglhWgSbPQxLoszN6BeDB3/lclSPfCtbTUe8purZH7ZTpPXYEp8hF+drlx2BtJfCdtLe3wU2fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zWDyUwLk76B9kb2D/xlc2qa/QycmLzUAJqLalncV90=;
 b=SByD6oD/zkuloF1NlQMyzLvW4KUYDO1YPST3/jp0OSVfeu2OlA09CGT920lfBaYOowZfsRCg4iuFAx5gHKHUMKUYhRfKGnruQ/w83NISfpwdemDARyTh8obqQ8E/SFwdEJYZTOm0UirTMQz5tArTMede1KBXx6tOveAUyfZq4JfeM+3y/7KrtsWXp05/OE/Qprei6lXFRJBNsZNRcTKOGXEpTVKE63Z3hDgiEO0CQBwYmnI3nKRJ/yFJa2D1x9HzsV9luYQ2K2xnvlXLfYmc6kaoeORMBqE2A4Nr9Zozduq4VXP3K9/FC2QeG9Nr8J/2y6U0gFXFwUa11mYcNpH9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zWDyUwLk76B9kb2D/xlc2qa/QycmLzUAJqLalncV90=;
 b=P8VyBWQFj7lI5ftz7SbHRM/lk2/5BaxvvyicMEpEnF4XAF6VYhx5ySXLsK1Lx9/2rP4f7iyCNsnP8VLy4u6gI6aKkc6OfBn9f9C2bYuGwFE3QFFbYACy5Y4Gac50fQnFGRB5BO2V8PvtyEP0UJay/QBY/fv32jsi43chCiix7lee/mKNsRFB8nyJe3ZOj9peYom+th6XUzu0H28VSKYMhAW5p8ebv1seuqH7DrSgj5fpcOkeHYp/ApM8n6ApZ3ZGzoOgT1N1Cr9NDJtPg5NC+e8N8bXfgMWLd792hKE7DKRIKY4AvWXzLVU7eVlFDafQ5zRjud8f2+tvDnWNVooupg==
Received: from DM6PR12CA0035.namprd12.prod.outlook.com (2603:10b6:5:1c0::48)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sun, 8 May
 2022 16:33:35 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::3a) by DM6PR12CA0035.outlook.office365.com
 (2603:10b6:5:1c0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Sun, 8 May 2022 16:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Sun, 8 May 2022 16:33:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Sun, 8 May
 2022 16:33:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 8 May 2022
 09:33:33 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 8 May
 2022 09:33:31 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v4 3/3] vdpa/mlx5: Add support for reading descriptor statistics
Date:   Sun, 8 May 2022 19:33:17 +0300
Message-ID: <20220508163317.204673-4-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220508163317.204673-1-elic@nvidia.com>
References: <20220508163317.204673-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0703425a-619e-46be-6898-08da31107f48
X-MS-TrafficTypeDiagnostic: MN2PR12MB4301:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4301FF44FEAA0EA4E722B9EDABC79@MN2PR12MB4301.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKPIeYhYxj4c3YsKFQqXAgiT6D/r9cUOrbNzY+7kN5akZNd7v8xPilu1+Rq+pNy+zbsKzFJKevV1OWk5yYHm735oc3qceoqPnmGFdTXKvlWMVrIkYLE7F20ghrptYBKlFzIi/JQQXh/UMZq0+bSt45KOZ01LoPYGcUYoOItjWio6bSUFLNHi0R6UvixTXdRtRXxR+j6QRla09tHN173k9CEkNVspbEOyRnaDMjbcuCUEVDbqJZSVbaPcE6JynfUM+Mh3c85fpNogOB31wuHmmvPLyVLD8DLYZuo6zoCbSGQl33rKjYoJ/jz/UC/LYDV3M/l2chMO7Xgyz4sixwr5GbC7AMNVql1Dp6KsGiyRilbAnp4k/jNbr1U7V7Z1LWJkJOYvww4pRxWMHBwY4cEIG28BRlCYEYvBXfVc5CqzuIPGjgQNhqj5urmr/BLJDBxzsN4vWlvFaHXT2ndrJLYOt22YN2KjafFtZYI9jNJERxPzfg5XwURcWObrIVXPlq0HrMXvygGiy5A2bixaLR+hOQQbY80sHWU192p5DCmVpzFri2/q8eb5GhNBtMItgcqrgwr5M8PLRnfNfAyQx8Yw4JEF5TV8K4EjKzUg12w2NyOTjO7FIDyRhKADD1xj/b70MLrQ+38cVOwl1twgXxuz7XCPYSNtwOYfDKSizNzYB/HgEXRAIzfQmD+bAiNzj2QTRps6E9COaeHb8scamH8Rig==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(2616005)(82310400005)(8936002)(5660300002)(36756003)(110136005)(83380400001)(1076003)(107886003)(6666004)(508600001)(70586007)(26005)(30864003)(70206006)(47076005)(426003)(316002)(54906003)(8676002)(4326008)(336012)(81166007)(40460700003)(2906002)(186003)(7696005)(36860700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 16:33:34.9317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0703425a-619e-46be-6898-08da31107f48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Eli Cohen <elic@nvidia.com>

v3 -> v4:
Only return statistics if feature negotiation was complete
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 171 +++++++++++++++++++++++++++++
 include/linux/mlx5/mlx5_ifc.h      |   1 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |  39 +++++++
 4 files changed, 213 insertions(+)

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
index 79001301b383..5b1c4304ffc7 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -119,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
 	struct mlx5_vdpa_umem umem2;
 	struct mlx5_vdpa_umem umem3;
 
+	u32 counter_set_id;
 	bool initialized;
 	int index;
 	u32 virtq_id;
@@ -164,6 +165,8 @@ struct mlx5_vdpa_net {
 	struct notifier_block nb;
 	struct vdpa_callback config_cb;
 	struct mlx5_vdpa_wq_ent cvq_ent;
+	/* sync access to virtqueues statistics */
+	struct mutex numq_lock;
 };
 
 static void free_resources(struct mlx5_vdpa_net *ndev);
@@ -822,6 +825,12 @@ static u16 get_features_12_3(u64 features)
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
@@ -876,6 +885,8 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
 	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
 	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
+	if (counters_supported(&ndev->mvdev))
+		MLX5_SET(virtio_q, vq_ctx, counter_set_id, mvq->counter_set_id);
 
 	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
 	if (err)
@@ -1139,6 +1150,47 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
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
@@ -1166,6 +1218,10 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 	if (err)
 		goto err_connect;
 
+	err = counter_set_alloc(ndev, mvq);
+	if (err)
+		goto err_counter;
+
 	err = create_virtqueue(ndev, mvq);
 	if (err)
 		goto err_connect;
@@ -1183,6 +1239,8 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 	return 0;
 
 err_connect:
+	counter_set_dealloc(ndev, mvq);
+err_counter:
 	qp_destroy(ndev, &mvq->vqqp);
 err_vqqp:
 	qp_destroy(ndev, &mvq->fwqp);
@@ -1227,6 +1285,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
 
 	suspend_vq(ndev, mvq);
 	destroy_virtqueue(ndev, mvq);
+	counter_set_dealloc(ndev, mvq);
 	qp_destroy(ndev, &mvq->vqqp);
 	qp_destroy(ndev, &mvq->fwqp);
 	cq_destroy(ndev, mvq->index);
@@ -1633,8 +1692,10 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 			break;
 		}
 
+		mutex_lock(&ndev->numq_lock);
 		if (!change_num_qps(mvdev, newqps))
 			status = VIRTIO_NET_OK;
+		mutex_unlock(&ndev->numq_lock);
 
 		break;
 	default:
@@ -1681,6 +1742,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 		if (read != sizeof(ctrl))
 			break;
 
+		cvq->received_desc++;
 		switch (ctrl.class) {
 		case VIRTIO_NET_CTRL_MAC:
 			status = handle_ctrl_mac(mvdev, ctrl.cmd);
@@ -1704,6 +1766,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 		if (vringh_need_notify_iotlb(&cvq->vring))
 			vringh_notify(&cvq->vring);
 
+		cvq->completed_desc++;
 		queue_work(mvdev->wq, &wqent->work);
 		break;
 	}
@@ -2323,6 +2386,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->cur_num_vqs = 0;
+	ndev->mvdev.cvq.received_desc = 0;
+	ndev->mvdev.cvq.completed_desc = 0;
 	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
 	ndev->mvdev.actual_features = 0;
 	++mvdev->generation;
@@ -2401,6 +2466,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 		mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
 	}
 	mlx5_vdpa_free_resources(&ndev->mvdev);
+	mutex_destroy(&ndev->numq_lock);
 	mutex_destroy(&ndev->reslock);
 	kfree(ndev->event_cbs);
 	kfree(ndev->vqs);
@@ -2442,6 +2508,108 @@ static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
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
+	mutex_lock(&ndev->numq_lock);
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
+	mutex_unlock(&ndev->numq_lock);
+	return err;
+}
+
 static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_vq_address = mlx5_vdpa_set_vq_address,
 	.set_vq_num = mlx5_vdpa_set_vq_num,
@@ -2451,6 +2619,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.get_vq_ready = mlx5_vdpa_get_vq_ready,
 	.set_vq_state = mlx5_vdpa_set_vq_state,
 	.get_vq_state = mlx5_vdpa_get_vq_state,
+	.get_vendor_vq_stats = mlx5_vdpa_get_vendor_vq_stats,
 	.get_vq_notification = mlx5_get_vq_notification,
 	.get_vq_irq = mlx5_get_vq_irq,
 	.get_vq_align = mlx5_vdpa_get_vq_align,
@@ -2706,6 +2875,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 
 	init_mvqs(ndev);
 	mutex_init(&ndev->reslock);
+	mutex_init(&ndev->numq_lock);
 	config = &ndev->config;
 
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
@@ -2788,6 +2958,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	if (!is_zero_ether_addr(config->mac))
 		mlx5_mpfs_del_mac(pfmdev, config->mac);
 err_mtu:
+	mutex_destroy(&ndev->numq_lock);
 	mutex_destroy(&ndev->reslock);
 err_alloc:
 	put_device(&mvdev->vdev.dev);
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

