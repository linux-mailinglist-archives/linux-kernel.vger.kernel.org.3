Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DF74FBC04
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346033AbiDKM37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346023AbiDKM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:29:55 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B1C286EE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD0DqTAwAZLqjxY1Gx6cReRT/YMD0D+mZrO/DgInzpKV2IHb+h+E7FilFmFvqXpMTzxKtWYLd7GlEyEI0V9G7fYd9foA70aRIlzyX2Pimui8K9lcghi7bj0Bym2O7LEYlTtQ8JAF95ZKPtroe5oOSr2rH39eneOg+CUtdtYsLX0Xg3RdKnUCR1XyylgZMehlwNYcIJsh0nhVa9FmNDihsLsmAdGayKIsPeZzH1yz1dqDDpvfd2Nj/4rJzWSVC89nZj85JqoBze6h35cpvOXmSjoe8/rfcLGREo3WUEbZ4kvrRbUCNCTpLpjtHbUkBBfc9clnpTyW2q5Nc6qLdFwWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX6iVm7aweIxy+o6SuNTaTntDpiEMICBY56vx9j6AFI=;
 b=ocE+1pl6oCU+r6eBvatvlwccpdQdboVscWUV5BHYmbzsas0WFo78UKwyVKQzbMTTGBPXm4/cg9Zj5R+H95en3h5bls2C5VIW7NrFBM2flAe1Hr0x7t78LbPW+aO07WB1o1ecjdL4HJaSuQ9GL4g3rk5tAWUUJyHv6Al03VFBMIvCtr6HmylNK/bYT+AChGuX8EZiqzmGLi+0WQJwb2KkMrO4G+rGgX0XMv9KUOdx9EOIfhDQrnCmuY+hv/mp+K/imIHvhCntM84r+kfL20KaEl6BfBpX6yba/dezCSOdmwfIX5JSI0BJgXFVCzjK74BHOdxQHuAvW0IeFUNAHbXwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX6iVm7aweIxy+o6SuNTaTntDpiEMICBY56vx9j6AFI=;
 b=VyTTzkxsF203rxjsyOKNtNm9S8YZcYPBrjev8O7ZfnAzPnMVCNXTlCPtpp69tq8ramyk8FWiLYi3s/4Qe8krsG3fWkdhnTmHy98me2Ira6yTsBX//jTqg1rxLInjaDN08hxHV2Z7ooESZGVVzkcX6n1zaFPb0XK/2d8Z5vNwuBMkXYKSMmFaz0TJbMMy71qNThBmnrU8Y4wDXRG4OEhsHwCKE1LGcazJQ3HXlnTBc31mkkqK1urlPxk5IdQ6b2qwWZkM42nbrOxEwe8bTKGYthwV9r5r9iDMvpEEXr9B+06/UJZyfXE+C+RDEEcHLE6paM1uN0nMx0ySKxm02CStUA==
Received: from DS7PR03CA0245.namprd03.prod.outlook.com (2603:10b6:5:3b3::10)
 by CO6PR12MB5442.namprd12.prod.outlook.com (2603:10b6:5:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:27:40 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::2c) by DS7PR03CA0245.outlook.office365.com
 (2603:10b6:5:3b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 12:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 12:27:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Mon, 11 Apr 2022 12:27:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 05:27:38 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 11 Apr 2022 05:27:36 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <asowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH 1/3] vdpa/mlx5: Remove flow counter from steering
Date:   Mon, 11 Apr 2022 15:27:26 +0300
Message-ID: <20220411122728.225588-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411122728.225588-1-elic@nvidia.com>
References: <20220411122728.225588-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7b01df5-c6a9-4516-6dff-08da1bb6ab57
X-MS-TrafficTypeDiagnostic: CO6PR12MB5442:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54428934453846D584CE964DABEA9@CO6PR12MB5442.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1aLXnGWdz9Gf7eJVYlQ6rTLqsIJCsjKrT7n8Yw+6uoiwu0woWxqEGbxXQITpsBvb1ozXA61exWreZpLvQGkCqgTtoYKZpAkDqLxhNwHLqJuY0oB1zexSgbJu5nsZNHH+7HYBF8GfrLdt9FuCMhl1TyWz5XIm4WaoC1YlslAWRPms3f/1P3MrTCPRdVtPHMuR/5wisZajh8Qxe/NCAM0Wmhjz8FYCGfdrDK8tS9kjuWuaPUVCY6BX8LIvYimcOUN3lk+JAD/Od//g6FNH4sOusj9BZoBIQ5ziUbgDxWSpFp0aaT+S6b2JnGaC7U4LI7HgAFU/WSjYr6bRaC/wSoUqEqOsUKJHOuZD8gFR5COhHR713F2JXxRQiXwzYkBYFcUbhCf6cooutVqEFtFhiEnzwaasSr9n3VVkL/661KUSsZXFxOTRsI6oyTV2N++XAqXkeu3tBXQON+6r3MJMtIHNG42kiJ0HcZXRO+fwB9KhIpxUhsC5IKFfqibdnpjh8nxIqC3cNCLKQuaeKUifAcyJCrQF+jNbyWd3bbDYYZ1gril7awyNaMHFu43fCt/d3Fq2GvRnU4htI1G++miB1ARNCz1MCMaXrGyyUdAPWu2tAfxxiFiPtlQQnr8lG7nTlHtBZBAE8dFpEkw/D84JJ+042mh/QnQAW+oi4pp/Sq+3UQ6zcSnXe4VHC/gs33Fm+ZiB6RX2Ur0SMq5z+Z6+CFTSvQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(70206006)(336012)(36860700001)(8936002)(5660300002)(110136005)(70586007)(54906003)(8676002)(82310400005)(4326008)(7696005)(6666004)(1076003)(2616005)(508600001)(186003)(26005)(426003)(47076005)(83380400001)(107886003)(36756003)(40460700003)(86362001)(2906002)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 12:27:39.6634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b01df5-c6a9-4516-6dff-08da1bb6ab57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5442
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

