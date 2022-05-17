Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B651152A2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbiEQNOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346014AbiEQNOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:14:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CEB41F9A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6NtaJbSVhTWt96/Mq9LtTmgwRQJ+Nrg7dJyBztU92RAVhH9jkHaIYToDlF4/pLRSyxmcGwYf2SSK3jLncMJyEp+iep361/i4QdHXAnOq1t6/6wHM/A1w7D+L7+UEt2Z7/2i3/Hu8845vPrKI88I6Csmqkuhaxfx+8SOZd9HHce/3AVYYcz9e0hzHg1mjIcJmrv7gm/4/yAQjjbpGjl/Gh6ZV2Qx4aadffivhFI9EWI/bqB2t4936dk2/LCazP6JNPIVhQsPrDHeFrZh/9Tmlm8ISKnZIKfS6zGg29Myc0MmCkIyhSRMgvdI25nHkUkmYcHMvbyhUTjuSxdRfqmmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Pi6WnOyiPFRfWQVGpvgB/982+kHi+Dgas0akDbhZKw=;
 b=mDNzp6s/QMrjc2hrI6wdRJ9zlBzpO0+L6qWaK4EHvcVqiUMY4RsDxuNcEEZdJAht8HP590//IMqPOMFwDcZW0HEWAfemjYdUe6bfl6E7cYe8SCuqXfUNrbnRFg4kSuJkDzV358CfYcL1KfYO85fuBuN8eofWmX6LAfdTF1C0HyYYXCYYjaF7eAJusqG7MbbmoB4xz0QZNnXZzXfnCwUewkF+iVRxhKSudZlb89doDOvUdFLpEgxGg0g7tag6xHTzuNxbT/CkdLUCWES/nPTJJI0vynol3lxQbK31cmbOk3dNW+bu18BwdDXonwB5Y28qze/wfTJ0I8iAPyQ5YaFBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Pi6WnOyiPFRfWQVGpvgB/982+kHi+Dgas0akDbhZKw=;
 b=kHtDAAlUF8ufHHRio7irOqy/hBtVMAb/Cwm0H/cgS94XGYd30msJz1jygycC9n+QbBoAGQJ0GFO+PQiX4beCyMFLBXdKE7uPchRJiYjSFvsjZU3HpbGgP+O4rR2hglvffbGK5vRw+HhnrqR9T8vl/CtqhTXQtIJbxdYujp5rjstR8drW4kB951UMfwkLMPGdoavszlTAUkgKBoCQ9hywyQt2Y45pEFRqzot3jtvQJSu8jPNjt8yBYNe690xJJvUU+voB3xognAYZxzEZIAlavQaTpLEcSrkFrfF0TIWuXr4x8UGzzSwXhV08jRXM/kWzEQVXDdaqGsWvE5XqD/H5wA==
Received: from BN0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:e7::21)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 13:14:06 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::1f) by BN0PR03CA0046.outlook.office365.com
 (2603:10b6:408:e7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17 via Frontend
 Transport; Tue, 17 May 2022 13:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 13:14:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 17 May
 2022 13:14:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 17 May
 2022 06:14:04 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Tue, 17 May
 2022 06:14:02 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v7 5/5] vdpa/mlx5: Use readers/writers semaphore instead of mutex
Date:   Tue, 17 May 2022 16:13:48 +0300
Message-ID: <20220517131348.498421-6-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517131348.498421-1-elic@nvidia.com>
References: <20220517131348.498421-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dd73197-1ec6-45bf-2176-08da38071eec
X-MS-TrafficTypeDiagnostic: MN2PR12MB4079:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4079B7D922BA71777E8FE012ABCE9@MN2PR12MB4079.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UiHjDKB2tq7SVVVOJDCuEa/wGwC/O3e0sKEl5OKYtrGsCo7T9WMlxqHKpknYNyPwZituQT5+nJWvV2+GWphyuYOsLGIoawTc7zaoDTBSy4tLgeKGko8KnpPFNylLaDTTfyzvqQE4jRkIWqSKdY9iKkV9g9wt6JQFiSmneKPS9GhGnKRs0+neuw8gIUfK8Eq7IlT2eoi+SiDObgMaFoH4e8codop/CFz98x5omHyheH1q0Tnk8JHWJffM3+M7TbC8Tevv2jU9FKKHwwZd5+UyGGEGWWwiBx6udiBmHyXD2YxROanN92/XuEJwffhSYoHCY5lCRtedPUGLBvRv0SQ/IB6siPYMn/bDttqN2nPfrV13REge4eBEG5KqIreYG2ka1ntY7dENu7NrE+SE0fE5G5xuV5Vj63IOYJfrxQTS3rMYy4IHCOa6gnFdGa7ShMfcrXBzXKjjqRmq4l4/HPB6ox9LcCVe9V5gBzT03JQPSstZdBSH4+HIYSk4+VJDsXlLMf6yeMWmVPGevZwcoE6vnzM07hxChO5w+6oFILGeSU2uP1eNbbAilLk7SvG7veHiPwp84hvhBAuHzhh3DnCG+LDisMur8J7J3JFGa8Bo25N7+2ePCtgzVbvh05iBU1cRHarEZx5V6jylzX4tU4oZnQis32p1v2OUtCw+FzbkmTIo5d86S/qqA3IoBQAMm7TSAzNP4BT3Tkk/uLVrP3WkFg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(107886003)(36860700001)(2906002)(186003)(2616005)(508600001)(5660300002)(7696005)(8936002)(36756003)(8676002)(82310400005)(83380400001)(6666004)(316002)(426003)(336012)(110136005)(86362001)(54906003)(4326008)(26005)(1076003)(47076005)(40460700003)(70586007)(81166007)(356005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 13:14:05.9345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd73197-1ec6-45bf-2176-08da38071eec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading statistics could be done intensively and by several processes
concurrently. Reader's lock is sufficient in this case.

Change reslock from mutex to a rwsem.

Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 41 ++++++++++++++-----------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 2b815ef850c8..57cfc64248b7 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -155,7 +155,7 @@ struct mlx5_vdpa_net {
 	 * since memory map might change and we need to destroy and create
 	 * resources while driver in operational.
 	 */
-	struct mutex reslock;
+	struct rw_semaphore reslock;
 	struct mlx5_flow_table *rxft;
 	struct mlx5_fc *rx_counter;
 	struct mlx5_flow_handle *rx_rule_ucast;
@@ -1695,7 +1695,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 	cvq = &mvdev->cvq;
 
-	mutex_lock(&ndev->reslock);
+	down_write(&ndev->reslock);
 
 	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
 		goto out;
@@ -1746,7 +1746,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 	}
 
 out:
-	mutex_unlock(&ndev->reslock);
+	up_write(&ndev->reslock);
 }
 
 static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
@@ -2244,7 +2244,7 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	int err;
 
-	WARN_ON(!mutex_is_locked(&ndev->reslock));
+	WARN_ON(!rwsem_is_locked(&ndev->reslock));
 
 	if (ndev->setup) {
 		mlx5_vdpa_warn(mvdev, "setup driver called for already setup driver\n");
@@ -2292,7 +2292,7 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 static void teardown_driver(struct mlx5_vdpa_net *ndev)
 {
 
-	WARN_ON(!mutex_is_locked(&ndev->reslock));
+	WARN_ON(!rwsem_is_locked(&ndev->reslock));
 
 	if (!ndev->setup)
 		return;
@@ -2322,7 +2322,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 
 	print_status(mvdev, status, true);
 
-	mutex_lock(&ndev->reslock);
+	down_write(&ndev->reslock);
 
 	if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
 		if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
@@ -2338,14 +2338,14 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 	}
 
 	ndev->mvdev.status = status;
-	mutex_unlock(&ndev->reslock);
+	up_write(&ndev->reslock);
 	return;
 
 err_setup:
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
 	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
 err_clear:
-	mutex_unlock(&ndev->reslock);
+	up_write(&ndev->reslock);
 }
 
 static int mlx5_vdpa_reset(struct vdpa_device *vdev)
@@ -2356,7 +2356,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	print_status(mvdev, 0, true);
 	mlx5_vdpa_info(mvdev, "performing device reset\n");
 
-	mutex_lock(&ndev->reslock);
+	down_write(&ndev->reslock);
 	teardown_driver(ndev);
 	clear_vqs_ready(ndev);
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
@@ -2371,7 +2371,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 		if (mlx5_vdpa_create_mr(mvdev, NULL))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
 	}
-	mutex_unlock(&ndev->reslock);
+	up_write(&ndev->reslock);
 
 	return 0;
 }
@@ -2411,7 +2411,7 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, struct vhost_iotlb *iotlb
 	bool change_map;
 	int err;
 
-	mutex_lock(&ndev->reslock);
+	down_write(&ndev->reslock);
 
 	err = mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map);
 	if (err) {
@@ -2423,7 +2423,7 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, struct vhost_iotlb *iotlb
 		err = mlx5_vdpa_change_map(mvdev, iotlb);
 
 err:
-	mutex_unlock(&ndev->reslock);
+	up_write(&ndev->reslock);
 	return err;
 }
 
@@ -2442,7 +2442,6 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 		mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
 	}
 	mlx5_vdpa_free_resources(&ndev->mvdev);
-	mutex_destroy(&ndev->reslock);
 	kfree(ndev->event_cbs);
 	kfree(ndev->vqs);
 }
@@ -2527,7 +2526,7 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
 	u64 completed_desc;
 	int err = 0;
 
-	mutex_lock(&ndev->reslock);
+	down_read(&ndev->reslock);
 	if (!is_index_valid(mvdev, idx)) {
 		NL_SET_ERR_MSG_MOD(extack, "virtqueue index is not valid");
 		err = -EINVAL;
@@ -2566,7 +2565,7 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
 
 	err = 0;
 out_err:
-	mutex_unlock(&ndev->reslock);
+	up_read(&ndev->reslock);
 	return err;
 }
 
@@ -2835,18 +2834,18 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	}
 
 	init_mvqs(ndev);
-	mutex_init(&ndev->reslock);
+	init_rwsem(&ndev->reslock);
 	config = &ndev->config;
 
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
 		err = config_func_mtu(mdev, add_config->net.mtu);
 		if (err)
-			goto err_mtu;
+			goto err_alloc;
 	}
 
 	err = query_mtu(mdev, &mtu);
 	if (err)
-		goto err_mtu;
+		goto err_alloc;
 
 	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
 
@@ -2860,14 +2859,14 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	} else {
 		err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
 		if (err)
-			goto err_mtu;
+			goto err_alloc;
 	}
 
 	if (!is_zero_ether_addr(config->mac)) {
 		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
 		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
 		if (err)
-			goto err_mtu;
+			goto err_alloc;
 
 		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
 	}
@@ -2917,8 +2916,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 err_mpfs:
 	if (!is_zero_ether_addr(config->mac))
 		mlx5_mpfs_del_mac(pfmdev, config->mac);
-err_mtu:
-	mutex_destroy(&ndev->reslock);
 err_alloc:
 	put_device(&mvdev->vdev.dev);
 	return err;
-- 
2.35.1

