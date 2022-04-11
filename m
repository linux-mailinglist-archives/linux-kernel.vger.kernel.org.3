Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CFD4FBC10
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346079AbiDKMcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbiDKMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:32:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C43F3EB8A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8ogd4bXA1ttcY0cs6n04nKAl8aa0PMxGoYK8eYuDBA8b6HRTqrL35qGLs9/JiLiHVMZrI2SMM9uGht9ptyeb7pgDBDybj53NAxVacjnhf/uLbTcLqogdfend3OpAP6y2kiDh87FJtI4lVTcKaQRYHgVxaC5iZ/zTq5pD4Tjpez1hp/nNwB5cX3uRmX01L1BGZqa1SbsRJ6h0TEVGRukovI6Ql53IFUT8tVOkX6M3UpTx6zj9uXmHY9p9KZlqEt3wSrp3tY1SSMSyErp5+KASx0/G5IwKhRK9Dzq1W1UIlyYeiz5g+Pqp7jqCFBTYITP1ozkglW2eX1fzFcoBnvLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX6iVm7aweIxy+o6SuNTaTntDpiEMICBY56vx9j6AFI=;
 b=gfCrlf4ox6ctS3YSXK9mP+j8/kIv8TdadrR9Mfzxyq27dA4GYFY0ZHCLWG88mC7Oy+6dTy6X3uhJjDItoXZUIYXmik3Gj2609DTj9ErTZFCuw6qxIG+SpddSRpWKaHTL2ozmL+1BrrBOVPg/Oiqev7MYFIbQALJ5WUbBSQINzwj/sO5tqEbNMmjQltf2GhmxjdJRCIUmzacnZbUEISfLO3MLHdTxY0B+zmKy6TXFEHOMAGaCBzqnUBp4Ge+JpWQetTQ2+M/IVgA0bbQDdgQEa7TN7RkfWifWJHTdiQkI/0X5ABASKd1W6XsYLu3z2NQY4ggw7DE5dvXcN1RjcakvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX6iVm7aweIxy+o6SuNTaTntDpiEMICBY56vx9j6AFI=;
 b=qdf9CpKQCrYt+iKlhkyYVzmOv074JsOX6IprBAoGsZY2CEwgjf5IQlDkBX+blmK0HcPCjEQ5oO/PX9pflcINfx8JmKx3jQoGgDRa1qjKOoMM9p2u9Nd4gBdEu0G5CDgRavV+mL9ZFxTo0Y5rtmYUUqt560LnUDZv+Gt3duwOPImQe/G5RCa6tlaF5+XZ1w4otsCGGipaq4QEkH4xilmcRKaXqKLlLOHOvK7RsbCuHdcGBbzrrzSQ4Wdk029Db7K4lvAtQ8de3IjPwRDcPxmv5Pb8ZI+eE59tUe44vhHRgHJZyN8MUXl1DMgXWp5AY/Jrw7Sh304L0k0a5c/z3KWqNw==
Received: from MW2PR2101CA0019.namprd21.prod.outlook.com (2603:10b6:302:1::32)
 by DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:29:50 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::13) by MW2PR2101CA0019.outlook.office365.com
 (2603:10b6:302:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.6 via Frontend
 Transport; Mon, 11 Apr 2022 12:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 12:29:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 11 Apr
 2022 12:29:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 05:29:48 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 11 Apr
 2022 05:29:47 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH 1/3] vdpa/mlx5: Remove flow counter from steering
Date:   Mon, 11 Apr 2022 15:29:40 +0300
Message-ID: <20220411122942.225717-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411122942.225717-1-elic@nvidia.com>
References: <20220411122942.225717-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7e22bfe-969c-42c2-a7e3-08da1bb6f923
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB289167A2F9FD655EDC9E7F59ABEA9@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSWUQnWuVXkrjhHA3UEE7oWYM62SnfCQfgMquIOiLDenI7qvMGScCNmMC12/HuLRCeBfhT9QhLSQZoCCa7NLcLQbE+9f5JalT+/R8D9I3UbjIsRx87lE4iu6eV/517jdgCONqKJCLm3lHceVfC5wPmsUaWLuybHBJ+PDSHgjwtdc5bmAwyXd4FLsfeaARgMRaubf7Z2u//eCdbV/7qlVx4eCb1BDHRsJYIL/Qwt8KBHXkt81XQzQPwd/xSDBXjsDqfpbgALfWqRiLkHwU4qYamjY0ZI2eIsVIzJKYCLWHhi1pgTqZq7W3eam8B55o4o1buBroffsmgWX4k91Dkd8m2qdTNK35mwRxFwIgXUFIk38r/H6ZqE5Cp2WRVF7BNaxAEMWUVSuIDJVuR1Sq9EdxS00YLnu3tR97+iSmHxn13oky9F/UHe151dIgQOMMK3tZMwja1iFLvtYYxAYCQTs9vgnMcAJD2n1ok3rQuYC/U76yrnhfROwyMSJ3zY8XTsf5SB+XxVxnA/a08mLk/Wt52MfDEUC4OPQ4V4oWSj5lM+/vd9eV7dvt5Ank2iqFsGHh9SW7+SSGDhEWu71h92v7WWH1ZNqN6O8qgIo+sm3rAYPbHBxdp1lgAP2ruwhMNyldJSr7zx9VikhlOF+1vjLSUBczeorpasGsHqauFV10oYZQTHDZxtY0+gG2aRlzqtWQ6P5DqVbYCtpiOTpIalxCQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(47076005)(86362001)(426003)(336012)(82310400005)(5660300002)(8676002)(36860700001)(26005)(110136005)(316002)(186003)(508600001)(83380400001)(54906003)(1076003)(7696005)(70586007)(70206006)(8936002)(36756003)(2906002)(356005)(2616005)(107886003)(6666004)(81166007)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 12:29:50.3114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e22bfe-969c-42c2-a7e3-08da1bb6f923
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flow counter has been introduced in early versions of the driver to
aid in debugging. It is no longer needed and can harm performance.

Remove it.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index e0de44000d92..5aa6220c7129 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -156,7 +156,6 @@ struct mlx5_vdpa_net {
 	 */
 	struct mutex reslock;
 	struct mlx5_flow_table *rxft;
-	struct mlx5_fc *rx_counter;
 	struct mlx5_flow_handle *rx_rule_ucast;
 	struct mlx5_flow_handle *rx_rule_mcast;
 	bool setup;
@@ -1349,7 +1348,7 @@ static void destroy_tir(struct mlx5_vdpa_net *ndev)
 
 static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
 {
-	struct mlx5_flow_destination dest[2] = {};
+	struct mlx5_flow_destination dest = {};
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_namespace *ns;
@@ -1381,12 +1380,6 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
 		goto err_ns;
 	}
 
-	ndev->rx_counter = mlx5_fc_create(ndev->mvdev.mdev, false);
-	if (IS_ERR(ndev->rx_counter)) {
-		err = PTR_ERR(ndev->rx_counter);
-		goto err_fc;
-	}
-
 	headers_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, outer_headers);
 	dmac_c = MLX5_ADDR_OF(fte_match_param, headers_c, outer_headers.dmac_47_16);
 	memset(dmac_c, 0xff, ETH_ALEN);
@@ -1394,12 +1387,10 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
 	dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
 	ether_addr_copy(dmac_v, ndev->config.mac);
 
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST | MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
-	dest[0].tir_num = ndev->res.tirn;
-	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest[1].counter_id = mlx5_fc_id(ndev->rx_counter);
-	ndev->rx_rule_ucast = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dest, 2);
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
+	dest.tir_num = ndev->res.tirn;
+	ndev->rx_rule_ucast = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
 
 	if (IS_ERR(ndev->rx_rule_ucast)) {
 		err = PTR_ERR(ndev->rx_rule_ucast);
@@ -1412,7 +1403,7 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
 	dmac_c[0] = 1;
 	dmac_v[0] = 1;
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-	ndev->rx_rule_mcast = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dest, 1);
+	ndev->rx_rule_mcast = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(ndev->rx_rule_mcast)) {
 		err = PTR_ERR(ndev->rx_rule_mcast);
 		ndev->rx_rule_mcast = NULL;
@@ -1426,8 +1417,6 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
 	mlx5_del_flow_rules(ndev->rx_rule_ucast);
 	ndev->rx_rule_ucast = NULL;
 err_rule_ucast:
-	mlx5_fc_destroy(ndev->mvdev.mdev, ndev->rx_counter);
-err_fc:
 	mlx5_destroy_flow_table(ndev->rxft);
 err_ns:
 	kvfree(spec);
@@ -1443,7 +1432,6 @@ static void remove_fwd_to_tir(struct mlx5_vdpa_net *ndev)
 	ndev->rx_rule_mcast = NULL;
 	mlx5_del_flow_rules(ndev->rx_rule_ucast);
 	ndev->rx_rule_ucast = NULL;
-	mlx5_fc_destroy(ndev->mvdev.mdev, ndev->rx_counter);
 	mlx5_destroy_flow_table(ndev->rxft);
 }
 
-- 
2.35.1

