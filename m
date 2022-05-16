Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C7F528007
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbiEPIrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiEPIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:47:48 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D6910A4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj2oA6hADLsjgCts7HGkpIWWdvlFx2LKRPYc9m5WIio1JSx6TDB7DJjlKXAUE1qwAswLBvU3O5oGhpPt07VheMPXVgnMFDkMkPvHDjVPga3i1y4Vv3XaLxTPBucphxyCcez0jzmnhlHrO5zA03MFxmORjWdB0SIyL0zczwnEAjN4fjyGkSWnC73ZXXH4dztkZecDSjkG6uv7sQwwzRYLKOcDOMJNEYZu8dopL8UUdoHurrtV2Ic67D0P0Acm59D6xHj+0RuP062c2vsABz0aB5Kqi88bL82NftaA/BmWsKB3Q8KpGZaKI1Hodlcg4O6IQoYg9ag/VgNSs8VkXMdvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgZxvcylrc8yYbwhGJXjl/6R84Z5f6E/vxRXI62lGd0=;
 b=UXySbhzXSmXn1ZgatUzLZLT/FMNMMZsHLLR2ugTBquFMmqnGcmK6dNlbEREg1kZ8iJzdMsSrVoVBGmRnsAyezCjcCsKQ+CEE1emx0FRckgQLTq/4QtGr5YreAMr9AFd+1LbdiwtGFXfDCeEvpDzo8Kh/aIZbukUGggYfZD0N5LPmDV4Fs9Fnb2OtyrMRL9YKPzE5ZT78n3ESeate74DcXYCwRlYgGbrWq45l+Pr8dlmUETDPfm4+FEYqCzAmQbo5Wg2m7CwFkz57HSvQs4/dCxKv6XuAOF8mJH0iBUSSaP7GDMtBZdHcg12RYrlzCdfbtaEsOqnphteWRWruHd1lPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgZxvcylrc8yYbwhGJXjl/6R84Z5f6E/vxRXI62lGd0=;
 b=n5YWAi6pC7Yip5qCfhUdnPxbOM1UyHLQZYpyJuGPzJLJgIyZT1lKD8nhnINDrZtYTYaXfLelHOYrMGt2sNEiIdBjipr0We5x0LC4rm/rf5pXWJMWfiFde2rYqdnLxbET+Vel3I4jfw6gGf3w5iY+/nPD+dr64o4iOcofEvCK5BnbNB/eJIY8iieszb44xYtpTsVbRhJYj9qf7IeWISI+UEdSdIL93t0P7hTXzAz2J//27Zx8KmztHMmRuje0ol+ulqIkpp+pM9u5T+7lTy2lwxzKzeipEO0ZKCQM6Uh3KU7vNhSo0HLBOcdU2lsCuQtzGZJK49qfLTJ5jg0KZ9FlEw==
Received: from MW4PR03CA0360.namprd03.prod.outlook.com (2603:10b6:303:dc::35)
 by BN6PR12MB1809.namprd12.prod.outlook.com (2603:10b6:404:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Mon, 16 May
 2022 08:47:42 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::31) by MW4PR03CA0360.outlook.office365.com
 (2603:10b6:303:dc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Mon, 16 May 2022 08:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Mon, 16 May 2022 08:47:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 16 May
 2022 08:47:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 16 May
 2022 01:47:40 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 16 May
 2022 01:47:38 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH] vdpa/mlx5: Use consistent RQT size
Date:   Mon, 16 May 2022 11:47:35 +0300
Message-ID: <20220516084735.198165-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b71418de-51bb-44bf-1f6a-08da3718bd4f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1809:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB180976CFF7301FEA07A5BD4DABCF9@BN6PR12MB1809.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yfZ5vqzJ4Zn1tW7WBZ2YZzsDMFc5p51xoK/EKhA8piwxlupwfEDEYxUc6OuYro+rf+4w9Z9QdHNk19vugw1KNSlwvo74HPhcxdy3QXUWAzWhfRp13zAgZDKWd46ZGcupeo1Zw1AmJvJpRtN1nK2zxeeoqPhhciQAdpdXmTxyZvVvwEriRONwuDRm4uCNsJa05/PGnh4nSFiK/imfbQ3jGiwrUdWv+EaHkvbgWIK1jV0VayFL22w1OXu/hSr/WEa+/jjnlY/wM3KtH2kE6eFNU23QTyXd6eX82Iz1tK+kH+rlG0Oa1GSxDyQ4kZ0weNwhb8bwyiIwrdSrcHBiAzBqBgmVo3v/j74ftpa4BtcaQw2MJfmSArI4xW1WQFxAZVcD5P6+O0/9//gomEx06M/eacQldpvXla+nKWFo5320a4fecNaouZsarkFa/Zt9/0hp7/gTe+IQTJ945VcmCQ4uuq5v8t7snDCJsT/C7aq/uDEFwnHnC0CwsedPCZcFXhNlfPPopdixd52J1jqlm8AxlMwsyt9sq+eIyLMus++kwamUvx44g0rp16cmYU3w2YnvIexs8e6wi6mJPps/jUYbgJo1pWnBCErjQPwLFhifZthi9TxI4zkYd93nZ8fUOJXJ+qDy/RZ8FWfnMBO0GxXbVOhrqyXY4x1O/qz7FSIiCjh1caUEsBUy5Zbof9/ABZLzjSt3hDGO3Wa4AIraT6C9g==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(70586007)(70206006)(36860700001)(8676002)(81166007)(36756003)(2906002)(1076003)(26005)(54906003)(110136005)(82310400005)(316002)(40460700003)(47076005)(186003)(7696005)(8936002)(356005)(83380400001)(5660300002)(86362001)(6666004)(2616005)(107886003)(426003)(336012)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 08:47:42.0074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b71418de-51bb-44bf-1f6a-08da3718bd4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1809
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

