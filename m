Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B33E551C73
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbiFTN1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344162AbiFTNYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:24:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A9C1ADBB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV3CKmw6pvj86HwYYwdw0dwVHpaXgyJQ1mqavMMWn2P9FaeQJyOzrgt71a6PdGCj+IoPfwh8q/qYurSoyQY6wW9BzS3e30fvMbmo/Fi3UZBvj1db1h9MltuKL+hasp7EwGk+cHdHf4A+bvq78W1egGeIrmyQTzu2/AkV6O5D+lDRWWnWiSxJnkBE7ue8AEm30KpCYWhGTU91638mD9SLm8bOl6vbK0ewub2d9xgh0B65Ids6e95cqYKEeJl06WgYfbwFb60IcD7/kQtxh6/Y82a9KZXyEAy2yua82wNdHjbLocRPQuXsUcelLwJSTBhzCmUK8/pEph0Bcbu07MII7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ou2ppbxAbvFdX4WGLtc1eGFB+awm+z1fE4hNPRIWlag=;
 b=USZvqzv2CQTNSQG1j0qFETexKXPQ00Pzn+sGIiDgGFhNqWsDy2rdMSS7R2Y3TfwtDO9YVgN7ZQh35WUHQ/8/JdwA5BBgQUYUCpb/vFwxmKLi488OB54SnOxLK0T6V1PRO69urKPapuBNpsbQ1sB43bUI10tO70M+XFsAaVpEErUr5CuJ7ETJnSxhTIJlYDK7ReyT1Jma8XUm4WLyTGdn/YT7DE/gF3XKCYLM2qMyjsgmuOrdBjJPCcoOhJPIZ5Mt6dlT46AnXb61uYxcHa78M+f736tJrgXkOvqgbclYQLTIy0fNxTQ52sId2a/xHzwHxJvw6uHOOpOTG9Orqf0PFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou2ppbxAbvFdX4WGLtc1eGFB+awm+z1fE4hNPRIWlag=;
 b=gnUmIt9XaW3+JivbLDXTYL128o2lltAklrDDQuJl7sCIT/jvjPit9kuvhSmbFNlNkNL1sy50Rl2oFV2lD1oByAy7KFMBw1gQQHn7PqCjJz/VS4pCwhbzuQ7AdGK1Hk6JRDpGtlWSU6/02kHhJ+egv2NHP86LBd/dv20eqhitqlOy7WRQIPxYClYhaiWds9Mdouk9iA1jHvfpIE9wFLYrv289oRvUK80LucHv+yEQo3ez5nZIhOZwxYMeZMy3IoYYe3GnkiM+YyW0e0ajuez8zHjCIyAijNcLmuMC7rjhleR1SlLHb2Cotdzygbot5zXjTpHyeIhsxM88/fWNAWttDw==
Received: from DM6PR13CA0017.namprd13.prod.outlook.com (2603:10b6:5:bc::30) by
 BY5PR12MB3939.namprd12.prod.outlook.com (2603:10b6:a03:1a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 13:06:26 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::8e) by DM6PR13CA0017.outlook.office365.com
 (2603:10b6:5:bc::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.5 via Frontend
 Transport; Mon, 20 Jun 2022 13:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 13:06:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 20 Jun
 2022 13:06:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 06:06:24 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 20 Jun
 2022 06:06:22 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <eperezma@redhat.com>, <jasowang@redhat.com>, <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH RFC v1 2/3] vdpa/mlx5: Support different address spaces for control and data
Date:   Mon, 20 Jun 2022 16:06:13 +0300
Message-ID: <20220620130614.19679-3-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620130614.19679-1-elic@nvidia.com>
References: <20220620130614.19679-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d17bbab-4169-466d-6c51-08da52bdaee7
X-MS-TrafficTypeDiagnostic: BY5PR12MB3939:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39390EAB626E1EB5F7491E2CABB09@BY5PR12MB3939.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0c8RMbrFj92MpN5y30Xu2LV+cjs2iKMP+NwZ0vrka5/alcwaN7xvnfi6XrQqmfq0ANaNujqOj87pzg4GkMEPBQeoMttkbrReOX1BN/W12Zq/SkExi6JWTbB0KJihgRIXNr+lGrt8PHijnSlQ87+wp1/+B7zh/ifQMIObXXd6/e5VogARJce6dip35hhsDFZl/PqIufbHlFK5HT0udleQH/maXGiSmHTeBEVec6LHYk2yDLFd30I5lq4EicQbp+rj6z2XUn41GlGcfAX05euqZcE9gYXEGFvhZyI5VhtU2cgVVT0X3cBZiaKLWaRUXXDOGl1TcfgeF5L++u6J7VYpegBAGCUATWyVV4C+pSBUQJNVUruHLB/mhNQkMbUEdp4YRXQ4sw+s3kigDEgqtjN74Dptxs9fr3faS1X2qIepSsOskSa6EKMj4yGGl+PPF6xnf2fAnzqn14+8wQQU73+vdniGs1mVyvFirR/REXT5h6xCiNWqg4Zz/AWhnMGmk8GrX3PzWzZEMZGxFFcMPJh9ghGvLcCrIqWnXLUS2OQH91ybTt6lvxxykhjP6yuoYqImuklza3WMRA0nB4RBe0pYLQsZDtybjjsJCBFAvgBxJpwOS3H0kqHXakD1fCx8wAUB+FHbDv569YEX61NL1jVBsNqgooxe8ntCUunYFxce0DncBTPHs7B/fuxK89K6KU3gqFIGj7hnYR+h6WI1dMRkpBpV8NMEF9XUFNG0QP1PV9R761G1Wt73ucPqb9m9Trtx
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(46966006)(40470700004)(54906003)(110136005)(2906002)(478600001)(26005)(316002)(4326008)(5660300002)(8676002)(8936002)(36756003)(2616005)(41300700001)(70586007)(70206006)(107886003)(186003)(40460700003)(83380400001)(336012)(426003)(47076005)(82740400003)(81166007)(82310400005)(7696005)(36860700001)(356005)(6666004)(40480700001)(86362001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 13:06:26.1951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d17bbab-4169-466d-6c51-08da52bdaee7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3939
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partition virtqueues to two different address spaces: one for control
virtqueue which is implemented in software, and one for data virtqueues.

Based-on: <20220526124338.36247-1-eperezma@redhat.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h | 11 ++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 88 ++++++++++++++++++++++++++----
 2 files changed, 88 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 44104093163b..6af9fdbb86b7 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -70,6 +70,16 @@ struct mlx5_vdpa_wq_ent {
 	struct mlx5_vdpa_dev *mvdev;
 };
 
+enum {
+	MLX5_VDPA_DATAVQ_GROUP,
+	MLX5_VDPA_CVQ_GROUP,
+	MLX5_VDPA_NUMVQ_GROUPS
+};
+
+enum {
+	MLX5_VDPA_NUM_AS = MLX5_VDPA_NUMVQ_GROUPS
+};
+
 struct mlx5_vdpa_dev {
 	struct vdpa_device vdev;
 	struct mlx5_core_dev *mdev;
@@ -85,6 +95,7 @@ struct mlx5_vdpa_dev {
 	struct mlx5_vdpa_mr mr;
 	struct mlx5_control_vq cvq;
 	struct workqueue_struct *wq;
+	unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
 };
 
 int mlx5_vdpa_alloc_pd(struct mlx5_vdpa_dev *dev, u32 *pdn, u16 uid);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ea4bc8a0cd25..cb637dee2ea8 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2125,9 +2125,14 @@ static u32 mlx5_vdpa_get_vq_align(struct vdpa_device *vdev)
 	return PAGE_SIZE;
 }
 
-static u32 mlx5_vdpa_get_vq_group(struct vdpa_device *vdpa, u16 idx)
+static u32 mlx5_vdpa_get_vq_group(struct vdpa_device *vdev, u16 idx)
 {
-	return 0;
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+
+	if (is_ctrl_vq_idx(mvdev, idx))
+		return MLX5_VDPA_CVQ_GROUP;
+
+	return MLX5_VDPA_DATAVQ_GROUP;
 }
 
 enum { MLX5_VIRTIO_NET_F_GUEST_CSUM = 1 << 9,
@@ -2541,6 +2546,15 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 	up_write(&ndev->reslock);
 }
 
+static void init_group_to_asid_map(struct mlx5_vdpa_dev *mvdev)
+{
+	int i;
+
+	/* default mapping all groups are mapped to asid 0 */
+	for (i = 0; i < MLX5_VDPA_NUMVQ_GROUPS; i++)
+		mvdev->group2asid[i] = 0;
+}
+
 static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -2559,7 +2573,9 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	ndev->mvdev.cvq.completed_desc = 0;
 	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
 	ndev->mvdev.actual_features = 0;
+	init_group_to_asid_map(mvdev);
 	++mvdev->generation;
+
 	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
 		if (mlx5_vdpa_create_mr(mvdev, NULL))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
@@ -2597,26 +2613,63 @@ static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
 	return mvdev->generation;
 }
 
-static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
-			     struct vhost_iotlb *iotlb)
+static int set_map_control(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
+{
+	u64 start = 0ULL, last = 0ULL - 1;
+	struct vhost_iotlb_map *map;
+	int err = 0;
+
+	spin_lock(&mvdev->cvq.iommu_lock);
+	vhost_iotlb_reset(mvdev->cvq.iotlb);
+
+	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
+	     map = vhost_iotlb_itree_next(map, start, last)) {
+		err = vhost_iotlb_add_range(mvdev->cvq.iotlb, map->start,
+					    map->last, map->addr, map->perm);
+		if (err)
+			goto out;
+	}
+
+out:
+	spin_unlock(&mvdev->cvq.iommu_lock);
+	return err;
+}
+
+static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
 {
-	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
-	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	bool change_map;
 	int err;
 
-	down_write(&ndev->reslock);
-
 	err = mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map);
 	if (err) {
 		mlx5_vdpa_warn(mvdev, "set map failed(%d)\n", err);
-		goto err;
+		return err;
 	}
 
 	if (change_map)
 		err = mlx5_vdpa_change_map(mvdev, iotlb);
 
-err:
+	return err;
+}
+
+static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
+			     struct vhost_iotlb *iotlb)
+{
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	int err;
+
+	down_write(&ndev->reslock);
+	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
+		err = set_map_data(mvdev, iotlb);
+		if (err)
+			goto out;
+	}
+
+	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid)
+		err = set_map_control(mvdev, iotlb);
+
+out:
 	up_write(&ndev->reslock);
 	return err;
 }
@@ -2796,6 +2849,18 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
 	return 0;
 }
 
+static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
+			       unsigned int asid)
+{
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+
+	if (group >= MLX5_VDPA_NUMVQ_GROUPS)
+		return -EINVAL;
+
+	mvdev->group2asid[group] = asid;
+	return 0;
+}
+
 static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_vq_address = mlx5_vdpa_set_vq_address,
 	.set_vq_num = mlx5_vdpa_set_vq_num,
@@ -2825,6 +2890,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_config = mlx5_vdpa_set_config,
 	.get_generation = mlx5_vdpa_get_generation,
 	.set_map = mlx5_vdpa_set_map,
+	.set_group_asid = mlx5_set_group_asid,
 	.free = mlx5_vdpa_free,
 	.suspend = mlx5_vdpa_suspend,
 };
@@ -3047,7 +3113,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	}
 
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
-				 1, 1, name, false);
+				 MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
-- 
2.35.1

