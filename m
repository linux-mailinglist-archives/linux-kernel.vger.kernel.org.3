Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D41F574C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiGNLi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGNLiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:38:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B3D5B045
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB2WpT5T0rU0D0Td4/b8XxpHdPQ+wZi1UMxDlN0bGKnGu//2aj6wdQqdNQMy785l7MdpOmIa3fZ43FssCyljLXh3g1bAwBe7aGtEbD6FuJTOoouoSQcrZukunZsmFTWPTWNEl7AgCJQA+SQH08xTJvOG2DwcODweRYgdkU/7+pXPecHWq9nEXnAjb2z2lRoGIBjlhe4jhf3W3G5OmdGGdWQYLuq0/cpDMPVK1EpaaWezNYOOyJznvL1Fvq/WgCimowPdMhbu3c7aRNek7XEcjDed4LUO/3NZ4Qa9nll3j4vdM+irGGLwgxNiVt2KQghxIWYGpaej9c8Ipcf5ubd28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oFO1rNzknZZToXxXUnl8+S7wkT2qbMZF/sY+eavt+w=;
 b=IBX5PcNV0y9TZd1j9WJbFd1/I04rjPsyXTXq8cWOt/Og82h+6B/DWMqETRhP5z8WA+wXTBtMR2B9ETgUr9dSFZ6rTXwjGtyfDubv///uteg/o0j4H/u0Hiz8Wnf0ayJF5Dd5NdblzZDlCpjRA22+9maUJRjtKxpDaRC7wHiJaxz15SUd1DzFXIL0L8AwolR0KgW6hsMRjJPNCZ0SzjXwC6pWE2nNpWR9hQWswEr09/uMgGcuUpkKc6pyuH4isJviRvqERNbiXYRCar2QjSbhe8YogsZEoz9NnjYogbYUxvgPbfIgvJNdlpGoXTM/nw6T1tGGScrlGWPJFwYGNCae/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oFO1rNzknZZToXxXUnl8+S7wkT2qbMZF/sY+eavt+w=;
 b=sXQJW1ZzKeL7ATCZmF2N3cx5+F29V5kqDnWQq1uvnUKhLyuwj21nEkGttHSuymxyatnTIcT1N94iBtGx+ZLE3RrCqDtLGxi8VIrevbsRnGbNf+wD49OuIEQkfjiY1lAKPKDcO9CUXQ3heupM0CB/ReReq8VH6uV98LC3URf6b7+sh6mpIuuFcW5vHrrCPKy4DvTojMbkG6O84qSrtjL4hRnjx/VNyB06wX1LMSTpSqwjeRSb7hnovl9ncHT4X/y2vb6Z1Bo0sFJ5LXdA+R8MnoOF9dSwoFxNLuIjnzYPB1wew+us6RjIRD1UcIvc89NfpnLtOkfZaJ+Zthd/UA70Eg==
Received: from BN0PR08CA0004.namprd08.prod.outlook.com (2603:10b6:408:142::22)
 by CY4PR1201MB0087.namprd12.prod.outlook.com (2603:10b6:910:1b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Thu, 14 Jul
 2022 11:38:20 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::3a) by BN0PR08CA0004.outlook.office365.com
 (2603:10b6:408:142::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Thu, 14 Jul 2022 11:38:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 11:38:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 14 Jul 2022 11:38:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 14 Jul 2022 04:38:17 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 14 Jul 2022 04:38:15 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.co>, <eperezma@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH 2/2] vdpa/mlx5: Support different address spaces for control and data
Date:   Thu, 14 Jul 2022 14:38:07 +0300
Message-ID: <20220714113807.85665-3-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714113807.85665-1-elic@nvidia.com>
References: <20220714113807.85665-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5163350b-07fa-4de8-5dd9-08da658d59ac
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0087:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGymn/Od8xBSvJ1gscKSiLGauSgB1maL3M2trawiFzx5MMRI5aFJ3hHM52EQRQd7NANsKA6yN8dh/QQR8p97Zout4B+wD6/QymIfX+BXxs5jiMtINJ/Ga71bmmh3NupgSxFyrX9b+2d+nOfj2xRS806Ldjfxv/rAjbqgJf6qwBlxdZbBtuCHLap6EuaW9gfPdATu593CcfUdcr6hVeMVpzO3QtjRTiUPZi6CtbrVOkHhhdlVDNRXUJEc0NdD+uPFaEB8pcr3r2MHLhB+MkP1w6LiGyTCYibgbdLrIAdgsbsYfJvo2dm9c9HX0uAuSf4F30UPasJLO2M6sXcEwgcdLjm6fZKhKaOYVGJ0QUKdiXfB8WdtiR8eS08N2a71Qw0uJv490yT8kVhsZ8CoD8A6ZkV9cer+i8MsNxxujn1m8MWLulOZyWvxJLrZVzCrRgPrYy42c25F5PnOEV3mZElB/k3CDDcCZ47U2b+5Ub6BjUIXfdpZzsp4c17MZKNXHD53g+r3BJx+VRWrlfr8vJLBuAB9Fn/JokNfwbLuhZnnBnfwsInOUubYyzCw959iu+AkKLTnti50L4yB4OaVP54YblH+q2aRw8Ut/u+PSV4sQ6vWCMHJ+qMgYjcFOgaoDh6chgoIEuQaYD7uAmlT4tagdl7BOg1k1/psVqvgW3G8Xc1c3GaEpzry8mpprM9DxWlB6tTzBb1xLwNMgBOiB2N9a/Z1EW4fo9nSBLc/NyiaMaLMiairuxFHpfwx70ZMcHrCFpxL0mq0YQFCXh8wMdqErfhp0w/gPttcf1LmLEbkhE5EFw6IkX0Ctl/hzf8cRHiW6SVMp0L6HG97evMzkNblVowLJ2Zb4/RpaPuafgRtt9Y=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(40470700004)(26005)(70206006)(47076005)(7696005)(336012)(8676002)(70586007)(107886003)(186003)(4326008)(426003)(1076003)(82310400005)(2616005)(316002)(41300700001)(86362001)(356005)(81166007)(2906002)(110136005)(478600001)(40480700001)(54906003)(6666004)(83380400001)(82740400003)(36860700001)(36756003)(5660300002)(8936002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 11:38:19.3734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5163350b-07fa-4de8-5dd9-08da658d59ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0087
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

