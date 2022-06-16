Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A999B54E1EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377014AbiFPN1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiFPN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:27:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1320A12099
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na7v6yswZ9M/zAfVwJFHopj26zsaZLfE0RWg04i1izsmAnLpSMOmJz98dwJu5kGBX11Nlswdci4xxgCBImRO7TjVGn/zdRLM47SIgc8SPIZJgB42po3V59/1ZqZBWYI+pcnz7x2se2dV9LqQBM/mMk9efN0YWJEeALtjdJG38hBahEtFI/cpIY4CCkFH9Yl/F5n7KjCrbU0VrE90zjiDAw92Ao5m4B9JoaoSgCZi4rkqhDyJgpH4b6g69OruN4lF+z8rA2I/rLZfdy3IjQ/Zhntq2xqoR0C7jb1/gqn1J+7dza/j63WOkMcSQW+82hULVtQJuLQ9A0JOAKcuWHYJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+Df8I5nQd2aEREc8toiOuA+03oW9Ppmmo0tyC6jqV4=;
 b=mVg82Gexo1tCfkLs7qfEQ8pOKLxf0Aq27/rlRiSoD4RmXWe6XpuOQucNBzbN4h/E6OrVIQin6EG7hLvZ2yEr42krXJGDKQ5v90EkGoZvw1ZIlA9M32dMQQTXpiQCZPnCN8sLOHuOrxuTmdvbZU2vgtPPrA7b6/2nFOlhmTTQeZOv7osi9jITTqQyvIeInrhzdP839o8HUB1MprJp8Jg6/JKrsbR8qau7MMuLvpQa9FD0tumzWtiDzZgtKPvU5c31KmI/y9riTO7DCUpiTgyE/PtJWuvoVtgy4YhM2szuHE9UrS0IoC4h+7gaLBQsObXI7QyY3wSm8Qs6ACw+b+J1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+Df8I5nQd2aEREc8toiOuA+03oW9Ppmmo0tyC6jqV4=;
 b=ZJN5L0s7mKdWu++VkQPELnmvJ4wjKvCgDdmdS1VZVuxzZNCc2Y9efrTXfz3gMX2aIUT3VAuXo/Sh/ZLUu/8geSxRXBFQ72JGy4C11evw4bwKbm+Rjididcv7qkgjJNmSDsMie8ngGTFfb+UfphUHBdW/m43sZVk94jto7sfeuM6P9ZYwaQou/otqAmBTXAfqHyAnPwylragJliR4b0RmxHQEHvoK9AFAsvk5QKm/7yvbmdF/SYj0QwMQzQ6anBcYazJbAAGzF6FN/09UN+lgsk4bAy1vWAPGS6dmvew9x7sno744MGCT+TUfvRA9SHzddN81cfbcCJSZHi5ibM9McQ==
Received: from BN6PR14CA0026.namprd14.prod.outlook.com (2603:10b6:404:13f::12)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 13:27:40 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::8c) by BN6PR14CA0026.outlook.office365.com
 (2603:10b6:404:13f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Thu, 16 Jun 2022 13:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 13:27:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 16 Jun
 2022 13:27:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 16 Jun
 2022 06:27:37 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Thu, 16 Jun
 2022 06:27:34 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <eperezma@redhat.com>, <jasowang@redhat.com>, <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH RFC 2/3] vdpa/mlx5: Support different address spaces for control and data
Date:   Thu, 16 Jun 2022 16:27:24 +0300
Message-ID: <20220616132725.50599-3-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616132725.50599-1-elic@nvidia.com>
References: <20220616132725.50599-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74e684fc-b3d3-4928-09e4-08da4f9bfbdc
X-MS-TrafficTypeDiagnostic: BL3PR12MB6547:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB654729D9BF139CF3EA462F45ABAC9@BL3PR12MB6547.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psxzAlzhfcuWblcf0MK24w3UqLiIDRpYE+h9NVkzi2EQFHBInMDxKuXtl1Vwiu8B3p6Duv39IvXFFGE9bb20Qb0oiFOr5UVSc48UvykrbRxSRzQOZznwTOK8kJgrlWBNhsfvZ61pusdxMb81ExvvzGA7fVku6X3gAo2yCfAZsQRH3Hcc9jSqM9zrJ4yfGwRCP82NK5VPzKPwgtwAt7GWna1ulb8LmsQcIp4nF1pzGXOm1pwHsENbsbk7qV3JtD9bwNea2uyaj27qD3iFrJH+eVX5nDP51UYwY/tG0cmD0fVRVFOnk83aoeCrtUvPYg3wRcgxdhxjD6vCpziHnnBb+bxLPk8BKsgf14T/Pw92o5WxivDnlKDHWLBr/PNgwHSOOiUWGOGUnxeB2LO6f/KXOnaKZMr3AiMeHINlRmdjYqXxSqJAA/A/+97bSJypbfAVrDbvlFTrRT9UORr0GZE2vXFC3YegQQrtNmN5bbkS40yt+0qEN9YHtVwu+dLjMd5nMSZZEuFoLZc+vmgHDezbh7+LtjVWLWrOfU+M4UbO0DDfn1TLwLPQzg/cGyKxJuuUZZSTnDZrpNcPpn4v6mQKvQJOWFra5ryn12gExnSZhyZEV6jICJOM66H0kpO/EbSn2c0riJ9M9T/HQ6IblKV8dNd3IfZXVJLyMLUAjz9ja1bpzYUuHjYFNw6JSWGC8EQqF7CtjpsZ/2UodKsTcmTt7g==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(1076003)(107886003)(2616005)(81166007)(356005)(36860700001)(316002)(186003)(83380400001)(336012)(47076005)(8676002)(5660300002)(8936002)(70206006)(2906002)(82310400005)(6666004)(7696005)(4326008)(40460700003)(54906003)(26005)(508600001)(110136005)(36756003)(426003)(86362001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 13:27:38.8654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e684fc-b3d3-4928-09e4-08da4f9bfbdc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partition virtqueues to two different address spaces: oce for control
virtqueue which is implemented in software, and one for data virtqueus.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  11 ++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 101 +++++++++++++++++++++++++----
 2 files changed, 101 insertions(+), 11 deletions(-)

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
index ea4bc8a0cd25..34bd81cb697c 100644
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
@@ -2597,26 +2613,76 @@ static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
 	return mvdev->generation;
 }
 
-static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
-			     struct vhost_iotlb *iotlb)
+static u32 get_group(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+{
+	u32 group;
+
+	for (group = 0; group < MLX5_VDPA_NUMVQ_GROUPS; group++) {
+		if (mvdev->group2asid[group] == asid)
+			return group;
+	}
+	return -EINVAL;
+}
+
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
+	u32 group;
+	int err;
+
+	down_write(&ndev->reslock);
+	group = get_group(mvdev, asid);
+	switch (group) {
+	case MLX5_VDPA_DATAVQ_GROUP:
+		err = set_map_data(mvdev, iotlb);
+		break;
+	case MLX5_VDPA_CVQ_GROUP:
+		err = set_map_control(mvdev, iotlb);
+		break;
+	default:
+		err = -EINVAL;
+	}
 	up_write(&ndev->reslock);
 	return err;
 }
@@ -2796,6 +2862,18 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
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
@@ -2825,6 +2903,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_config = mlx5_vdpa_set_config,
 	.get_generation = mlx5_vdpa_get_generation,
 	.set_map = mlx5_vdpa_set_map,
+	.set_group_asid = mlx5_set_group_asid,
 	.free = mlx5_vdpa_free,
 	.suspend = mlx5_vdpa_suspend,
 };
@@ -3047,7 +3126,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	}
 
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
-				 1, 1, name, false);
+				 MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
-- 
2.35.1

