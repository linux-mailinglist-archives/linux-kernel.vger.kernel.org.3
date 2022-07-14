Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC27574C55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbiGNLjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGNLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:39:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AA25B068
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKgXmTQThgY6+yUTAw02xcA5BMiv3I4/zWODl1kei0xnqivN85TDiwm/Ii/jt1v6ljstvWn7AS1cOpgobLJWN+jLtLpReqzKfnk9+VmaEywYUYbGS066wg2XEY9RUpx28Kb1wlv9qunzB+h7yfsz0cBdJ2EToz+Mn4KA4wb7D2IRnuZxKcSvtSULjpU6Tl6Ut4wNjVjT4UsTjUgzFuqNm22++/iM3f24aEcF4CJFBU1t6d5XXXRY8LZ3391VccEEKDKxIRviu3rGXUtMqlq5e0TKxXpr5d06fq+nW4dbnK0HLPhGQfDWn1EJ3VesZbcXq5/urCHuCqTKqjzSkH98Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oFO1rNzknZZToXxXUnl8+S7wkT2qbMZF/sY+eavt+w=;
 b=SpTh74ZiFeNqvfYO9GyPeBeVYZ9fSztp5gkLx/012t2eLrGQ5NfcAOrRvPqf8iqrJSWzEJR5dC697RuY5+Ow86Das54o1D8/NyayvPWHwd0chSTKHXcSFHh+2UnrEAJ3Y0KVdVvQ0j4XOuE+qzP341qkaeSs5clcRdJm17orqsrS1hV/1o+oF+Lb6nGQcMK2MWA4K42jPQYxtT0H5AqrS2B2btjSNVs6DWfBoXDfVdBrK4bwYxO8/XcpBIbhDUYwBFXYob+FqFQvaZq8xVgvCoUb08UGVjmWgC1IMxf59fOOI0pHwEMYu0UEEG3aGdsesXc2xfQejTpGisEk7d6CHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oFO1rNzknZZToXxXUnl8+S7wkT2qbMZF/sY+eavt+w=;
 b=aV2AL+SFlGYyfIXAWTRjn0/WtaWwocYBCKRMpxRaWjTUprkd2DueRyLoUS1fDKTEuevCLG4bPi2lmzY0uNiZ/i3Oml+vTxzl3e5tTmoJ+ZtE6Ilc2PYpgGkd0N8bDJu9vrSpTKL3g5C9gxdHpUMVL/wr4IApFIo9ARUZ2QT3DxNjtL4vaoj++QA3F35L8l+nRl3cn7t7Grgy3NqUTM9MKR2FYh+9Lg/iYAMH7JCCizxgllUAii7G0NA3tpt8MXq6Lh1Kk+j/6Z42erQsQ7vJiA69DEU0CyQqlsoJw+OcfBoKmYggFNsifroAdGlxmA1FMj4zFvAH6LXwJctTqnvTbw==
Received: from MW4PR04CA0294.namprd04.prod.outlook.com (2603:10b6:303:89::29)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.25; Thu, 14 Jul 2022 11:39:39 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::75) by MW4PR04CA0294.outlook.office365.com
 (2603:10b6:303:89::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Thu, 14 Jul 2022 11:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 11:39:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 14 Jul 2022 11:39:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 14 Jul 2022 04:39:36 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 14 Jul 2022 04:39:34 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <eperezma@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH 2/2] vdpa/mlx5: Support different address spaces for control and data
Date:   Thu, 14 Jul 2022 14:39:27 +0300
Message-ID: <20220714113927.85729-3-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714113927.85729-1-elic@nvidia.com>
References: <20220714113927.85729-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6e68212-d4b5-4212-b4cb-08da658d88d9
X-MS-TrafficTypeDiagnostic: DM4PR12MB6135:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4ydo2u0ZcJtSWaRYBBLRyweW56hKvZ9H/Fgk2z2LY7dCIYvw1sBFYpOs0o6UpXc5CZ4255f25mrdFBRnSQVVjQbBLHeG7c2uSqsUgc32mkwgl7mlV8UDltUrk9n+eSODyO3LWrB9NjRrlxAFaWbpqxTyN6umaqFlg37HF/fCkK6oVCfRsE1q8PEvash9Vsq5ZJJOJP1mwHltULoMC0ClhEc9I2eVzjsIJRscZtvcJ1k7TyujobF5ca+PCgVFeIXkvo1tc5OtS71le0FDM0ZKcGPdBHrqV+nVDVHIcpBhKgTEXStowYDu164fl0DNwdgZ0T1FWb9si8lsDIgs/1+8g8dB207xt7xc4ux8cgyurKzJT/7ZAQrOSD0L8t7FD0N4JHjnBMvGKoDYFjWZwk+CvqeiTX6vsZ0pgWizIeDuhESwFzsGBoVslR0q6YCdvdR+3GKuRkUes23Dg+fEDFXi9XhUc7A7mZbRjEFCxM3ZR2SiYi7TKjxqgo8h8ajZoeOvTEbc2pwXAgA63Z3QBNXmN0BKlD42tPhpExI+h/Z8i2x8ty2HQDrsRA4qvwD+2iBvwodMcl5hVGDYfu/JdBVJHgaqDfaciValtRyZiRGWRUqYf6g3Q98u/tCSGmty6abMhbs6lfBTT0Ta50yJLzRJRuxHxAXIbfrrJ5OqYHzmC4wa2SGEYxAuA/giyvo8NMswCeD1ir552wWyvVfe8eIKbwe47LtZDKVxnke4Aavu5w4AiDGGIcnUhrq4JoXPmonOkq8LCtm7Lj8PqzN8ZmwL/eX1VwvBHlMf4F/3Ncgj2ujYSbHH/c8f8rThczbSFw8gDqFh5tyJ8kI5xB++2yEIUuISyKgWJw5r0aaofT8djc=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(40470700004)(36840700001)(356005)(86362001)(70206006)(2616005)(478600001)(47076005)(6666004)(70586007)(4326008)(186003)(41300700001)(426003)(36860700001)(54906003)(8676002)(110136005)(1076003)(81166007)(107886003)(36756003)(316002)(82740400003)(40460700003)(2906002)(5660300002)(83380400001)(82310400005)(8936002)(7696005)(336012)(40480700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 11:39:38.6172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e68212-d4b5-4212-b4cb-08da658d88d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
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
index d0fff559ca15..834023e8e073 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2127,9 +2127,14 @@ static u32 mlx5_vdpa_get_vq_align(struct vdpa_device *vdev)
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
@@ -2543,6 +2548,15 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
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
@@ -2561,7 +2575,9 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	ndev->mvdev.cvq.completed_desc = 0;
 	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
 	ndev->mvdev.actual_features = 0;
+	init_group_to_asid_map(mvdev);
 	++mvdev->generation;
+
 	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
 		if (mlx5_vdpa_create_mr(mvdev, NULL))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
@@ -2599,26 +2615,63 @@ static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
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
@@ -2796,6 +2849,18 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
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
@@ -3055,7 +3121,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	}
 
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
-				 1, 1, name, false);
+				 MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
-- 
2.35.1

