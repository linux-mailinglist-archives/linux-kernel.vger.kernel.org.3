Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0198352BBDF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbiERNix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbiERNi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:38:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219E2170F21
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJs5fP3enU1aZwrhLcXL07znuQ16CPCSnhNLQwhO9AIpjp9n9McrjaU9qzQppu+MTyovPiriniyewnpE6uwKonkKYSaFPrXgXu4Xv1FN+tYwCTlJegpWoHyuLr2kenhugqmWPCJhrxzfecsjVp7HD2wwsRYSn5J6ufW3Y9mUlL9g9Vfs952BTe9ZnpS0hYKQJJOXCBwdHeX0BuLBe2dEmbLVLpg2BqzmAGj3ncAPPySs9Gk5yQVawEEodIoQa/h3QTAyGFtt+xlY0ygP7QuXKuzhEvWpB7KS01MgUclvR3WfIEybAloVBt9v0sxzACaMCSWcIrzjD1I0mFSGmrRd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Pi6WnOyiPFRfWQVGpvgB/982+kHi+Dgas0akDbhZKw=;
 b=VDJMiNUwqhz/qUOmSb02/ZUrcN8UUndwkHnYlKlj2bj194JT7y2M1TgvaU5ETXpAJoHimAtNTsg2rjiWyVj6HxLSE86NLX8lWyyziICHe/EUFm91D5ey0Vfh6sD+F1B9gg1aeI92bP2LVAd2wHzdmN716KjyK5h7IHcWf3VWoLLBa712HsAR4ZMcHYTkMV+fe1UxHRtIBBa2fhV6mF+7DeR5g6x1MiP9YKfrXybt3iXQOlGHXs0E7jq9emN7BQ3cG+R0B3UsrR8ds06enpeUDdT5VTURWEFB4HKdAOav/3K36sn6FNXpwTvufmVQ7o3MCaYDCHevYfCqq1k1jQCbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Pi6WnOyiPFRfWQVGpvgB/982+kHi+Dgas0akDbhZKw=;
 b=EfLmS6nt80oScDLNI0AyK/BEBtAoR8Iy0gVH5hm1HuBblfNDKo0TxQ04uvXehMuKBurDyPuQnnyrV9dQsblGYnmlodNEUexv1SLKlILXHagS8XOhqBpLL5PLlvnNITRZu0tqFCkpidHa1EU2r9rKx5wG6lTGR9gde+oG5bx8jfIZwbX8heVHpWETO/lNqBHJWeI32giBIkunFPCskeLNrI7WM5m9uh8LxhJIRD/v6XAY6GHK5tn82/IY1B/y+OwMRG0lqUQ+kgutJpxv+dEqSnLp1nN4N+A5K3/h0PtEjE0WuCRjHvOTMYfpTnYyIK9fcO1layrhAn2Cy4x1XTH1zg==
Received: from MW4PR04CA0121.namprd04.prod.outlook.com (2603:10b6:303:84::6)
 by DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 18 May
 2022 13:38:23 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::dc) by MW4PR04CA0121.outlook.office365.com
 (2603:10b6:303:84::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Wed, 18 May 2022 13:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 13:38:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 18 May
 2022 13:38:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 06:38:21 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 18 May
 2022 06:38:20 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v8 6/6] vdpa/mlx5: Use readers/writers semaphore instead of mutex
Date:   Wed, 18 May 2022 16:38:04 +0300
Message-ID: <20220518133804.1075129-7-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518133804.1075129-1-elic@nvidia.com>
References: <20220518133804.1075129-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce849420-c3c1-42ca-45c4-08da38d3adc0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4896:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48960C02CE1D60FF476735A7ABD19@DM6PR12MB4896.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xvt7FxB1rBjk3Q+rX4H2EKPj5VmAe4PVlHsU8XuwYUQMZ7/RXJx7nZbEQnJ5kBL9R2ihzyAn53W0/OByeLOOsUQzYE5Xc5f3WVu0LchekF16pWhrg+Zs916jgbeInIAXLBozRFb1lGZmJEAUnKX93NL/jWnPMi+mKOMBUpzMP6tMDC9AUtZiriqWT4nrxzVzxA+Z8QXPrtVX+iFk6ac90G81p0Qi3A4zeGA8BmdnCYihNghI/oIWYtZZ23EBHq/o0deVjQEMZCiwsJDLO8H7yrjIAqdpINedn5QNBcWYr3aqUqGzDB3GMTzCoYQS7oZwhXR0JSkt9y8a6NOvQYnm0mV9jZqZon4WPaD+86NxSAPogZpZwdNhGcQlFJMTTcfhDJa/TMAlIFxJuIdwSKsLjM7G+qh2Y7GIB6CYkF6nu/6rPbabsLg9pfQy0KeLGMu60JBMSTYVaB2w4n5VrQS9qSI5jCtjPYiUJ5x5mSbCeGGdFdGvF+kHdWZXw55mYFHA03k0RlA45omuOK7hQHPMnpzbl9LDlRMcSSfUZzizZQae76mFeaCNkEWn+s6vVlhCu81mI9Bve4MhKygXHyy6fpeZTI6UGvFV3Vet3payUJ4rs07vg+e2slOiDXQcor1zkzc8wdhARt430yxwbRZYbwJM0Tfi6wisDf5j5KqU14YSTMhdxGxKc+9AIGsrxbhRN+VBrHgXCXrcnFCVG3D0GA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(81166007)(36860700001)(70586007)(70206006)(54906003)(336012)(356005)(86362001)(36756003)(4326008)(40460700003)(47076005)(426003)(2616005)(110136005)(5660300002)(26005)(6666004)(7696005)(186003)(8936002)(508600001)(1076003)(8676002)(82310400005)(316002)(83380400001)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 13:38:22.9566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce849420-c3c1-42ca-45c4-08da38d3adc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

