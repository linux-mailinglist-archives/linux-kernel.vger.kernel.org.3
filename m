Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87B14F5EB6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiDFMu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiDFMto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:49:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3471E7A4A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMiHWo+TpxhkJXv7erWOW7Y98rh6TUq99sDlyqFV2IcQCoNkssA5OSBTwEr6WacvCkaOIXz695n9VojIys9IZL1i2TZmalVLtNDd8/dEhJyjZIiYmIOy1ufvIEuMbl7pGy0P/z/IZA8NTMTpRMpa59DU8RI3b3tbxaGpkhysJOcyvQ5Et1HecN3zSy3L7p7BqPbZp2kbIPSIzW+BiyyDR7kgHcxFIiQ5VvQfoGImnL6/2Tqx68NK80HnXaV8t8oDE6gxpoRVlbVP2D0iUg4OybX0ATLIjRGH0SaSESeqXFt4nWSVUkbfFrnkR7+0fzhOQkGWwr87FVhZDpwoUojRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McThjsTS85EmB2fhaEdb26rTB8J93zN8afmePHG7bQ0=;
 b=etD7AzLggvSHkEdqvoOaRQe9mLDdwUvtXREvOtlulmXTO+gHtb+JBE8McYT4cPblH0fz7LuKhJGNWWA9HcoR97oreEIRxknz7ZI2Y7OM0Sw2eRhrvoxKBBHmB6JGdZZuVvxYoF+QliiwxbJPreJAIYhJchLa4vd+LdUaWoQ2MEMtWs8w3Ng7vCk1aYam/fZLiRUcFDQAcsWhvqaj5OkJYMjNL6YxE3bUsIAcJl2Z3u/srY+IptrlirR+nJHP069/UpF1eXoJvt4ejei264w5I+xrJ1JIZVR9888rCRnv+U4lEJcTBAaZJ26S8/zSOE7HisICIgBjrVnQv/HglFNgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McThjsTS85EmB2fhaEdb26rTB8J93zN8afmePHG7bQ0=;
 b=Gj2GsAaj+4Ut0vwPeVXNufKq1z3sM9hCJ6XomiAorvdbk9b8IzcQ9k0z7IfXu9kCWn/U2y4Z22r+ZrsW+BOLW0xN6SXwDI+MgBi+CHfSoiy/zjw4swyUxF1dt9kQIx4N2BQuJByxRLrE6V2lzAgFcY+3OS8oDHxc9hFTC31xKd2dQMThhBNaKZ6CDFYk4W7NEuGxXFCumD82EK8cCocRxl5oCh3n6XiQt0HkgJAbc/EeyEjX45AoxNBSauyhXi8ef4wN7qGz7T4kRowsCDu+aumOE4Bk0WfDZjcYm2+vJ6d2G1iLe/kXewaEWND26muNfAcatbO27lC7PWPBQM8KxA==
Received: from MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::34)
 by DM6PR12MB3978.namprd12.prod.outlook.com (2603:10b6:5:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 08:53:33 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::83) by MW4P223CA0029.outlook.office365.com
 (2603:10b6:303:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23 via Frontend
 Transport; Wed, 6 Apr 2022 08:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 08:53:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 6 Apr
 2022 08:53:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 01:53:30 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 6 Apr
 2022 01:53:28 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <hdanton@sina.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH RESEND V3 3/3] vdpa/mlx5: Use consistent RQT size
Date:   Wed, 6 Apr 2022 11:53:25 +0300
Message-ID: <20220406085325.87644-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e5235a0-2f4f-4c2b-756d-08da17aaed37
X-MS-TrafficTypeDiagnostic: DM6PR12MB3978:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3978A62E3223311C89F9CFD9ABE79@DM6PR12MB3978.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oas1nllwNIUs4X1Q125TWedDfH4JeI75SzthrB1nFGw/jwlwFdJAuTqpgEInE8pRR9gzyWMk94NfIWrnzLI10iVXybHMdCPlVFCYjPLrefpH5+xGCJptvNNpB20QmuoY+4olOQjMK9xXIqX53QFkXO6BI6V1Db1LFz4yfyq51JQruwnMyMV8G3oetkWSWYkqQcdnViU76prjVD+JZIMTGiBv+AN5ByXlJazw0eXX7r3G2Xka7wlA6UzpdGgWVIaKUKDWavZ69vczeC7+MwBJrLDQLjU6b0zjCljiSIj1sFwHlFrinZ7WuXc/bi2ZLOCwAYVSEFBo68SY2vR0mmex2aX+qiMFcsUbSg9o3yhk++lpezuzZVLCO/pDPaW3J2BXcEAeQ5zGxVLaRNNC7xgsygrQAxkMt/CHr+kxORS40ln+gXYRwMjnufxkNEa6OYW5s5WEJjn1+roQUZUK4ihdew29HKMzdr9XtHj+Jh54qOWT0W19A6k34hZPcUEUrSu3DOx2V/zlFaIko/g6LxlPV3B4HI73xAmI7mEKdIk8mlFYCutr0Ont0rYvBefOei2m1lAdgH/EJtp9j6MN/SB/Lu3Uu8tPWtf7dc15XaSBg2WYSKiI4I3URAGgyUCO37v4s6KeCB99edn3ijH2xb1Of44++l4UywOLXbM4xzrGAbfrP4FwY32M97MYLkuelMqWa402ugHvCz72TFR/O6RGKA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(186003)(82310400005)(2906002)(316002)(81166007)(356005)(36756003)(36860700001)(47076005)(7696005)(1076003)(83380400001)(508600001)(107886003)(4326008)(54906003)(26005)(8676002)(86362001)(6666004)(40460700003)(70586007)(336012)(8936002)(426003)(110136005)(2616005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 08:53:31.6810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5235a0-2f4f-4c2b-756d-08da17aaed37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3978
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code evaluates RQT size based on the configured number of
virtqueues. This can raise an issue in the following scenario:

Assume MQ was negotiated.
1. mlx5_vdpa_set_map() gets called.
2. handle_ctrl_mq() is called setting cur_num_vqs to some value, lower
   than the configured max VQs.
3. A second set_map gets called, but now a smaller number of VQs is used
   to evaluate the size of the RQT.
4. handle_ctrl_mq() is called with a value larger than what the RQT can
   hold. This will emit errors and the driver state is compromised.

To fix this, we use a new field in struct mlx5_vdpa_net to hold the
required number of entries in the RQT. This value is evaluated in
mlx5_vdpa_set_driver_features() where we have the negotiated features
all set up.

In addition to that, we take into consideration the max capability of RQT
entries early when the device is added so we don't need to take consider
it when creating the RQT.

Last, we remove the use of mlx5_vdpa_max_qps() which just returns the
max_vas / 2 and make the code clearer.

Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
V2 -> V3:
Fix typo in change log
Add acked-by Jason

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++--------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 79001301b383..e0de44000d92 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -161,6 +161,7 @@ struct mlx5_vdpa_net {
 	struct mlx5_flow_handle *rx_rule_mcast;
 	bool setup;
 	u32 cur_num_vqs;
+	u32 rqt_size;
 	struct notifier_block nb;
 	struct vdpa_callback config_cb;
 	struct mlx5_vdpa_wq_ent cvq_ent;
@@ -204,17 +205,12 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
 	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
 }
 
-static inline u32 mlx5_vdpa_max_qps(int max_vqs)
-{
-	return max_vqs / 2;
-}
-
 static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
 {
 	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
 		return 2;
 
-	return 2 * mlx5_vdpa_max_qps(mvdev->max_vqs);
+	return mvdev->max_vqs;
 }
 
 static bool is_ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev, u16 idx)
@@ -1236,25 +1232,13 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
 static int create_rqt(struct mlx5_vdpa_net *ndev)
 {
 	__be32 *list;
-	int max_rqt;
 	void *rqtc;
 	int inlen;
 	void *in;
 	int i, j;
 	int err;
-	int num;
-
-	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
-		num = 1;
-	else
-		num = ndev->cur_num_vqs / 2;
 
-	max_rqt = min_t(int, roundup_pow_of_two(num),
-			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
-	if (max_rqt < 1)
-		return -EOPNOTSUPP;
-
-	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
+	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
 	in = kzalloc(inlen, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -1263,12 +1247,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
 	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
 
 	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
-	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
+	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
 	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
-	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
-		list[i] = cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
+	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
+		list[i] = cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
 
-	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
+	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
 	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
 	kfree(in);
 	if (err)
@@ -1282,19 +1266,13 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
 static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
 {
 	__be32 *list;
-	int max_rqt;
 	void *rqtc;
 	int inlen;
 	void *in;
 	int i, j;
 	int err;
 
-	max_rqt = min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
-			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
-	if (max_rqt < 1)
-		return -EOPNOTSUPP;
-
-	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
+	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
 	in = kzalloc(inlen, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -1305,10 +1283,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
 	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
 
 	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
-	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
+	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
 		list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
 
-	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
+	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
 	err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
 	kfree(in);
 	if (err)
@@ -1625,7 +1603,7 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 
 		newqps = mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
 		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
-		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
+		    newqps > ndev->rqt_size)
 			break;
 
 		if (ndev->cur_num_vqs == 2 * newqps) {
@@ -1989,7 +1967,7 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
 	int err;
 	int i;
 
-	for (i = 0; i < 2 * mlx5_vdpa_max_qps(mvdev->max_vqs); i++) {
+	for (i = 0; i < mvdev->max_vqs; i++) {
 		err = setup_vq(ndev, &ndev->vqs[i]);
 		if (err)
 			goto err_vq;
@@ -2060,9 +2038,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 
 	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
 	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
-		ndev->cur_num_vqs = 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
+		ndev->rqt_size = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
 	else
-		ndev->cur_num_vqs = 2;
+		ndev->rqt_size = 1;
+
+	ndev->cur_num_vqs = 2 * ndev->rqt_size;
 
 	update_cvq_info(mvdev);
 	return err;
@@ -2529,7 +2509,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
 	struct mlx5_vdpa_virtqueue *mvq;
 	int i;
 
-	for (i = 0; i < 2 * mlx5_vdpa_max_qps(ndev->mvdev.max_vqs); ++i) {
+	for (i = 0; i < ndev->mvdev.max_vqs; ++i) {
 		mvq = &ndev->vqs[i];
 		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
 		mvq->index = i;
@@ -2671,7 +2651,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		return -EOPNOTSUPP;
 	}
 
-	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
+	max_vqs = min_t(int, MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues),
+			1 << MLX5_CAP_GEN(mdev, log_max_rqt_size));
 	if (max_vqs < 2) {
 		dev_warn(mdev->device,
 			 "%d virtqueues are supported. At least 2 are required\n",
@@ -2742,7 +2723,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
 	}
 
-	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, mlx5_vdpa_max_qps(max_vqs));
+	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
 	mvdev->vdev.dma_dev = &mdev->pdev->dev;
 	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
 	if (err)
@@ -2769,7 +2750,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	ndev->nb.notifier_call = event_handler;
 	mlx5_notifier_register(mdev, &ndev->nb);
 	mvdev->vdev.mdev = &mgtdev->mgtdev;
-	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs) + 1);
+	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
 	if (err)
 		goto err_reg;
 
-- 
2.35.1

