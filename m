Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F108548132
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiFMIAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiFMIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:00:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1905FCC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwsE2DtqPqq4rSab+D93YoIMtQ3b6QSpDeAg/A40wqVDZPOCc7/rjyDrK1T+1DXEmWx9SZt7snjEexkhxbiDXrebkWPUcFRBu1c56PNTey+etZVKalwkEyyzbPh5yM4WHujQgF8DvWTxD+182OZz8EuKOGC9izAggt+0bS/x/XCym5MZrCvTb9t9+FytJiMUdYqi9mf4vhxxkuPUM3XKtcnGC260j0ZPQDRMBbhMLCZA11ifrNXBJQHwVohgq3xGtZkm3Vbg/TtNlVEaSMwoQgg1RFbXe/mbjusJxFM6z0CSDSiY/BvjsXm7nrvYR5YXZ9WYEPQw4ZRt1pfdkS/VxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDPFy7EizHKEXfncNwFD6Rdw06WCGK+bCYcDq34VNTU=;
 b=IXT5PZWhyNCA0z+gCM3neaaSLuFk71yt1pIGU2m12UIQ73n23i4jdMhLb2jtfeR3zUYk5u7nwaXMK924Y8cKZLupt6joW+VWGgofK9sPfNVAFLSO0pjQIh4AOYuM5HK6oH7jS8o6MeR0xd8Y2Ef8h2J4g+rEkGrUK8HU6tuj44gTBUpuXUeMke9uloIgcw45T7CfB2Cx3zTAs5nqck+Fia3obHSKS9kLTAAxLciYvAFeabZIqkl7oy6uFApM7kBjGUcDXHSaK0DTbPzv4qTCedPl3scZlLNry52lOToElCSngUOLqnMfAMhCg6yvzsq126pqhAadiiswOj6rX7wkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDPFy7EizHKEXfncNwFD6Rdw06WCGK+bCYcDq34VNTU=;
 b=UELcoW1NZC13pvSy4+QLzJLLojnxX3YY9mG0QgckD1ni5NnVAKiZiegVJ10Ojm7UEShucamnfmZJP7r0fxTd8fQve84xuLdqi+zCHFkCa2iMYq6qrH3f8z1BDvxeccZGjUkwOtLR3Ejlbg77iuH0pcvD1AeaOeD1np/7HrW1Q/tEjd62Q0YE7MXbu/aej4yxRw59+SrSsCgEp3vExaX42WFytVhTgUd0LOao1iMekTARqoqthMGTTx6LfaZGhZhFjZioeNhCbzH22Ny8d/VJDsOD9d3Q1JLOh8EClsixtiDaBKuA2D2buOFd5a8XPBB4lV65bd1nPY7VebM2T98Axw==
Received: from CO1PR15CA0112.namprd15.prod.outlook.com (2603:10b6:101:21::32)
 by SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 08:00:08 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::c9) by CO1PR15CA0112.outlook.office365.com
 (2603:10b6:101:21::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20 via Frontend
 Transport; Mon, 13 Jun 2022 08:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 08:00:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Mon, 13 Jun 2022 08:00:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 01:00:06 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 13 Jun 2022 01:00:04 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <eperezma@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH 2/2] vdpa/mlx5: Initializde CVQ vringh only once
Date:   Mon, 13 Jun 2022 10:59:58 +0300
Message-ID: <20220613075958.511064-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220613075958.511064-1-elic@nvidia.com>
References: <20220613075958.511064-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04388719-a2ef-466d-fa15-08da4d12bb3c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2591:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB25913689E56FBAFF3CB264C4ABAB9@SN1PR12MB2591.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpXpPL/rFotvc9PHQo4xkyxcydAo9Un9e261LjHHu3uD2kdC5X3j5ivyb2uysck/l/vcH6EVPKMWUxUn1oWJRY1CYkLxDkQfFokBBugJ61CxOiDucxkt3hBB6na/s1oJxVKc/StS/BB43ZNHTy2TRvhVo4jV6fhiyqVMkRjLPnl5h7Fha+SWPRKRA00WIjvAEPd+ZBTD7CL/Rb4h3o2bLFH+TOXvtXvQAyc1JjWKpl4TThN0yQqILKfOOur64IAYlKJEoaPj9qM6yj0if5j4Pl1jjt5DFxCKMr3uFtzjn1RT1FNufkF/zC59lPkCKkLxHnOnUMISmc+yQFd9qb+7QCvSFMTZ6hNLblQcYXU+0fi+85iRVV7eRJvGvh4cLYpdzLIC8VfJmKDH/iBWFeYuXvQJRZh5P5GyrVxk+wgdSITJNfd1RvF/8PSzEaGVvzqCCDLDwnXuugPgDmVTdffv0i2iBTn165trroHa4Jk/JDGYu6hGoO2iaE8jaH+CdqwrYZVDYwvCRA00zhhH6ZS/+z1HLfefq+3UlUCLDkxFyeBY2uZEU2ifvMbzBq9sIfv2MFk2oOIvFAKOS2CZ11RE0h2Mjv/D7d/hD+v4eI6dJKx2XT9oDxEPrlM6Gnl7YY+8FtPSDujjsPvgYrIgzMFIRpJNhBVMLAsnyy4cWQyqKa9xFsaCLGcbPgBQbFEZ1kcL0XxvkiC23+tPIAKBCYfEfQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(356005)(110136005)(81166007)(54906003)(316002)(36860700001)(36756003)(83380400001)(186003)(2616005)(107886003)(426003)(336012)(47076005)(1076003)(82310400005)(5660300002)(4326008)(70206006)(70586007)(8676002)(6666004)(2906002)(7696005)(8936002)(508600001)(26005)(40460700003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 08:00:07.1182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04388719-a2ef-466d-fa15-08da4d12bb3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2591
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, CVQ vringh is initialized inside setup_virtqueues() which is
called every time a memory update is done. This is undesirable since it
resets all the context of the vring, including the available and used
indices.

Move the initialization to mlx5_vdpa_set_status() when
VIRTIO_CONFIG_S_DRIVER_OK is set.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 789c078ff1af..e85c1d71f4ed 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2176,7 +2176,6 @@ static int verify_driver_features(struct mlx5_vdpa_dev *mvdev, u64 features)
 static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
 {
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
-	struct mlx5_control_vq *cvq = &mvdev->cvq;
 	int err;
 	int i;
 
@@ -2186,16 +2185,6 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
 			goto err_vq;
 	}
 
-	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
-		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
-					MLX5_CVQ_MAX_ENT, false,
-					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
-					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
-					(struct vring_used *)(uintptr_t)cvq->device_addr);
-		if (err)
-			goto err_vq;
-	}
-
 	return 0;
 
 err_vq:
@@ -2468,6 +2457,21 @@ static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
 	ndev->mvdev.cvq.ready = false;
 }
 
+static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
+{
+	struct mlx5_control_vq *cvq = &mvdev->cvq;
+	int err = 0;
+
+	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
+		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
+					MLX5_CVQ_MAX_ENT, false,
+					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
+					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
+					(struct vring_used *)(uintptr_t)cvq->device_addr);
+
+	return err;
+}
+
 static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -2480,6 +2484,11 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 
 	if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
 		if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+			err = setup_cvq_vring(mvdev);
+			if (err) {
+				mlx5_vdpa_warn(mvdev, "failed to setup control VQ vring\n");
+				goto err_setup;
+			}
 			err = setup_driver(mvdev);
 			if (err) {
 				mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
-- 
2.35.1

