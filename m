Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0DB52BBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiERNi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiERNiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:38:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7295C16F922
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ+oDTe3Ll9MMT9BBYeS3ARHYdslioJ0Fo4UZeSzoH04YcQg1aPE0JkKClcm7h9lG5o88/xme/2feMDSOZvQGMR54/EtcNgtOuglmnQPhVRJpczoKnii3ObF+XM3Ux2Eigack2P0S+dDU8opJd6wvfIQ1L0HreJHzJFm4+7cCAB+XH1ggf1BefgkY4T7JXVAssh40ng6ED3X+vJ856qzTOpSKPG2qHTnX1lkbZFO+FTzBuilEC5wHs0JZK1OlDBxXTG3f8lwxAlBmXLnn0tmATcRAF6ZYfxQnkeRVkATDM9p2v4iXM4u0xWjsD9f7giQyycv/wNF144XMcFr0riwaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGY/rnrmZfeVYSbH5qfssA9Kvmv/F7hqQZT70lekDqU=;
 b=ZxnYTIIXMnQL95rPJ+UpzQUFJXN8ZyrtcZOXFY1YlfzcuO+ejge54dwpDZu6KARzjGuH7qA6mvRLHZzgvswiw5rxQCWeSFb9cEDnoIZp38cyi7CWAcB02Lhab6qgiYHS9QQqqWVGUyeahTy4T3r9O1Xt/L91rpCGJknbIz/JXBJaQ4ZcmcJk+srDaka8F6TcT++nVGKyIJ+AeOF5C45FwZW6tL7qdYxLSIAaVnFwkWkVX+50GpybG8sx07YpdCykeX/2aXBwHvHaRLJi8MOY8pl23DPE39ghZp5TiPqrPxAk4cHLPAbf9wROswwe+NwkppwcBKXs5ifAkmLUHPtW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGY/rnrmZfeVYSbH5qfssA9Kvmv/F7hqQZT70lekDqU=;
 b=aFzYfNH6P+7WOPkAW3h6IGM7U7Vg/8zHy6N+U75kS1zJflKZ4DOG/QXZ1oxnqpOvkji9R0qzl68tao/79YDobOXQnVvbPNaV+cm9Mga/SiJJFNaOmZeD0fNjH0qSyQpDqkzW2kFx8s1JyUDtVtu8xSTh3ty7w/ueIneKJXkd5Amr7t0jhkEA3l/NXKPrOJq04Nmu5O1lhvsZfWOz1AnxQnuFL0/x9wdnzE2iEx3lIDSA6Ziowis385is8sS4xvWLfKFL/SXVuVV/dacpNxs7wRw85wJGSQhXZ/Ar0lyJbdtuUsmjSLzA/SYTYxl3j1Gm5nWmiAleBanPiGFgz04TVQ==
Received: from BN9PR03CA0721.namprd03.prod.outlook.com (2603:10b6:408:110::6)
 by CY4PR1201MB0262.namprd12.prod.outlook.com (2603:10b6:910:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 13:38:19 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::5d) by BN9PR03CA0721.outlook.office365.com
 (2603:10b6:408:110::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Wed, 18 May 2022 13:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 13:38:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 18 May
 2022 13:38:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 06:38:17 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 18 May
 2022 06:38:15 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v8 4/6] net/vdpa: Use readers/writers semaphore instead of cf_mutex
Date:   Wed, 18 May 2022 16:38:02 +0300
Message-ID: <20220518133804.1075129-5-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518133804.1075129-1-elic@nvidia.com>
References: <20220518133804.1075129-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 318cd30e-e4f8-4065-4725-08da38d3ab18
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0262:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB026289CC0F4FE77392AE085CABD19@CY4PR1201MB0262.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HFTWPqG66YT5QDn8erKj5av+BQM1r1PLP4pxolciQGbAdompgNLbnn6BEYtQLh+eTBqZchgZCVsKBJEdU2w/KckyqrYponUfgdeWL/uz5Gc3bDKo4WXWAmVZclJ2OsVIwJ/o2I+FlVjiNfJSNhqiI8ZslHUN4nWjzsynHEYCFDdXNe1Einy3lzI+BxL/Ee1SOndRlNJeXxjIw2QxvPvwGEgNz4IsIlYdNWsXOuLeUaJ/K519DxnhWAo8kHQHSeftaPba0mXvxtbQbIkh7487B5fNrcx1ydLLkR2XkERqwWJpkhiff9oNpKPzuX8DqIUqhd9ar0OzJh4czbbAV75KDo35G2rHoTwerjJX8EhnVmdbUgdoSXjXQ0fMfoQS/5/gCASPmMxESX0MntQN5AAqbxTEuQHoQ/B05ryRVEmuPz4JW5nSDsm/pKC52ZKe569YL/cw9NwE7VP36ptIXmUtQGhI2RIELJ98QGZfuDc2tKkA7i+FAWKK27iSK0/vth6oVUx50bz5NiQj0f/9CaeqgXq8UJra/58oF0IPLKszxKxu7BiyhiJTSAqxh2nmwrSYfRVmOwyuqEMH1XcHVFvoCa1+kWUgZNtJI0q8N7hLFItryY9lS8NhKEYzK4RX8l4TMnOozQQ7di/1kjGYWQMjfvvL7pM2VXkOmdaUuORroUATllYowTSLzY+qc9vjEnrn32MnI0hW05br007H6R4dw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(508600001)(110136005)(54906003)(316002)(81166007)(7696005)(70206006)(86362001)(356005)(8676002)(4326008)(40460700003)(6666004)(5660300002)(186003)(336012)(26005)(36860700001)(426003)(47076005)(107886003)(82310400005)(1076003)(8936002)(2616005)(83380400001)(36756003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 13:38:18.4377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 318cd30e-e4f8-4065-4725-08da38d3ab18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0262
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cf_mutex with rw_semaphore to reflect the fact that some calls
could be called concurrently but can suffice with read lock.

Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa.c  | 25 ++++++++++++-------------
 include/linux/vdpa.h | 12 ++++++------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 2ff7de5e6b2f..9d3534a0bc5f 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -23,9 +23,9 @@ static DEFINE_IDA(vdpa_index_ida);
 
 void vdpa_set_status(struct vdpa_device *vdev, u8 status)
 {
-	mutex_lock(&vdev->cf_mutex);
+	down_write(&vdev->cf_lock);
 	vdev->config->set_status(vdev, status);
-	mutex_unlock(&vdev->cf_mutex);
+	up_write(&vdev->cf_lock);
 }
 EXPORT_SYMBOL(vdpa_set_status);
 
@@ -148,7 +148,6 @@ static void vdpa_release_dev(struct device *d)
 		ops->free(vdev);
 
 	ida_simple_remove(&vdpa_index_ida, vdev->index);
-	mutex_destroy(&vdev->cf_mutex);
 	kfree(vdev->driver_override);
 	kfree(vdev);
 }
@@ -211,7 +210,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	if (err)
 		goto err_name;
 
-	mutex_init(&vdev->cf_mutex);
+	init_rwsem(&vdev->cf_lock);
 	device_initialize(&vdev->dev);
 
 	return vdev;
@@ -407,9 +406,9 @@ static void vdpa_get_config_unlocked(struct vdpa_device *vdev,
 void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 		     void *buf, unsigned int len)
 {
-	mutex_lock(&vdev->cf_mutex);
+	down_read(&vdev->cf_lock);
 	vdpa_get_config_unlocked(vdev, offset, buf, len);
-	mutex_unlock(&vdev->cf_mutex);
+	up_read(&vdev->cf_lock);
 }
 EXPORT_SYMBOL_GPL(vdpa_get_config);
 
@@ -423,9 +422,9 @@ EXPORT_SYMBOL_GPL(vdpa_get_config);
 void vdpa_set_config(struct vdpa_device *vdev, unsigned int offset,
 		     const void *buf, unsigned int length)
 {
-	mutex_lock(&vdev->cf_mutex);
+	down_write(&vdev->cf_lock);
 	vdev->config->set_config(vdev, offset, buf, length);
-	mutex_unlock(&vdev->cf_mutex);
+	up_write(&vdev->cf_lock);
 }
 EXPORT_SYMBOL_GPL(vdpa_set_config);
 
@@ -866,7 +865,7 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
 	u8 status;
 	int err;
 
-	mutex_lock(&vdev->cf_mutex);
+	down_read(&vdev->cf_lock);
 	status = vdev->config->get_status(vdev);
 	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
 		NL_SET_ERR_MSG_MOD(extack, "Features negotiation not completed");
@@ -903,14 +902,14 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
 	if (err)
 		goto msg_err;
 
-	mutex_unlock(&vdev->cf_mutex);
+	up_read(&vdev->cf_lock);
 	genlmsg_end(msg, hdr);
 	return 0;
 
 msg_err:
 	genlmsg_cancel(msg, hdr);
 out:
-	mutex_unlock(&vdev->cf_mutex);
+	up_read(&vdev->cf_lock);
 	return err;
 }
 
@@ -954,7 +953,7 @@ static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
 {
 	int err;
 
-	mutex_lock(&vdev->cf_mutex);
+	down_read(&vdev->cf_lock);
 	if (!vdev->config->get_vendor_vq_stats) {
 		err = -EOPNOTSUPP;
 		goto out;
@@ -962,7 +961,7 @@ static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
 
 	err = vdpa_fill_stats_rec(vdev, msg, info, index);
 out:
-	mutex_unlock(&vdev->cf_mutex);
+	up_read(&vdev->cf_lock);
 	return err;
 }
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 2ae8443331e1..2cb14847831e 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -66,7 +66,7 @@ struct vdpa_mgmt_dev;
  * @dma_dev: the actual device that is performing DMA
  * @driver_override: driver name to force a match
  * @config: the configuration ops for this device.
- * @cf_mutex: Protects get and set access to configuration layout.
+ * @cf_lock: Protects get and set access to configuration layout.
  * @index: device index
  * @features_valid: were features initialized? for legacy guests
  * @use_va: indicate whether virtual address must be used by this device
@@ -79,7 +79,7 @@ struct vdpa_device {
 	struct device *dma_dev;
 	const char *driver_override;
 	const struct vdpa_config_ops *config;
-	struct mutex cf_mutex; /* Protects get/set config */
+	struct rw_semaphore cf_lock; /* Protects get/set config */
 	unsigned int index;
 	bool features_valid;
 	bool use_va;
@@ -398,10 +398,10 @@ static inline int vdpa_reset(struct vdpa_device *vdev)
 	const struct vdpa_config_ops *ops = vdev->config;
 	int ret;
 
-	mutex_lock(&vdev->cf_mutex);
+	down_write(&vdev->cf_lock);
 	vdev->features_valid = false;
 	ret = ops->reset(vdev);
-	mutex_unlock(&vdev->cf_mutex);
+	up_write(&vdev->cf_lock);
 	return ret;
 }
 
@@ -420,9 +420,9 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
 	int ret;
 
-	mutex_lock(&vdev->cf_mutex);
+	down_write(&vdev->cf_lock);
 	ret = vdpa_set_features_unlocked(vdev, features);
-	mutex_unlock(&vdev->cf_mutex);
+	up_write(&vdev->cf_lock);
 
 	return ret;
 }
-- 
2.35.1

