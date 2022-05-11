Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDC9522EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbiEKIsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244024AbiEKIsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:48:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F6C20130D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrfVjcJhSBgGp36qa4itIj1sGDhwv4P06sP5NWDfktnUH0wRDnuaGTS9/htjrZMK2X0eWH3k3BNZCmdg4LVHiJm/AihY/ICCgPT1YC3Br9qsgcSdpgekl/mSwUXhmzrTDPPYU5sAcSccGVgdt1dgPxce0bXvZv612mfwPetQ9QBJfq0CILRxS8wqo89I4KBYUIxFf1X5Gf0RkduG5XsYtApqaiWzlmz1zCLE6+8IQmwt1VqP+ODpWlMiyB8jluuGGZfdIMbCRIDjcszPUv+6Zalg7GI/24lDWS3Z551r0gsmR8POhpQM+a5dlt/WppgsWsjYiecJmSIBBoGdJxJ3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItO9TutRwek/RY5zIMp+HqAHxGDs7jJ2ELpQTpFFSeY=;
 b=NhrelxZmCOQHn7ezRiJxZiJFkPenTEIvnzodLBv+8dl9ZmZqJ8visaTcXh5ROxBlSg7sKdt7HO7EjndhS0J+cf/jW967gSQkOZFeX8/B7mduHAEVcJRLCqNRH996IMgUPLmZ7V6ch6tWSDr61sYbOB1VS+1cB+wmYOeWqrRpglgxBsxjaytxyQElSFUXjmOtSv6hmOchZmINqZX0A4sjZ3gg2cFYyyRGJOUb6oH8q2HZeJ2+BirDDO8bCi1+uo1cIwv2w2MhWrAfZ5BJUADfQxD9ahYO+kYBEd9zcwxzhUT10m5CRZV1NjhjuPpWsV0PC8qVX/6Skc2eWJRY241rxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItO9TutRwek/RY5zIMp+HqAHxGDs7jJ2ELpQTpFFSeY=;
 b=Q3ZZ1cjwSRHtc2NS217krY6VmgbZlvOixIgbMb6ArKc7Q87cou0HikEcgDwKxaDI4EYsr34yns/4am5uZEJpRVv4OsGVIKkdJZN3gCTXBFSf9ahDBYf7VYYJ4Rvhj742BL5SMk8G91V2sB14lA/u2ch+9L+FsvrpwgF3mdrw79FnR2Yt5+GRBtitC55EGmFjPoL9wAIKkdgG0NKNVWHledpRBfJSvWsElglCQ53FSmjsbsQayQPL405zpu+P9xoYYlZiuzZKculNfnAXn5K+c4nBX/gpnwl1e/ydcbnDQO1wVMQJbYkLcB0Xh8Gkxr6+711Faufz5kP9l2+8M6WaJQ==
Received: from DS7PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:2a::29) by
 BN8PR12MB3220.namprd12.prod.outlook.com (2603:10b6:408:9e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Wed, 11 May 2022 08:48:11 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::f4) by DS7PR06CA0016.outlook.office365.com
 (2603:10b6:8:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Wed, 11 May 2022 08:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 08:48:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May
 2022 08:48:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 01:48:09 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 11 May
 2022 01:48:08 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH] vdpa: Warn if MTU configured is too low
Date:   Wed, 11 May 2022 11:48:04 +0300
Message-ID: <20220511084804.82482-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99b154dc-59fc-4022-5b86-08da332afaa0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3220:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3220434266C69179B9668993ABC89@BN8PR12MB3220.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFMKkm49RFGizCGXYw2FTVhb+I5/eu6Cte7BGdyjSoH48N/DbMk/DOlaOrhZyyakox6AZEtzQxbo5yJBOT8tX/XDpuCEpKEOrUrolH3qEB01rmrpKpFaCS+yXrcKmOThuebNvIz0z46F5OdLdp+chaVsaOawEOe5C1cvnwhfnRKaK5zLVdFbHQBvQbjc/VGU96kHsbyY+sBLWWJWr8hZCm3NSi2y6EathLda1/L9sYvWPAABWh07o035gCspW4tLwlhC6Zwt/W+rTlCtkwQFoNtTxyF26zoLiAYVa2IJpQlmAYBLziVFkARqcGLduq3F0TuJx7d0nVTrRXcOS8VZc8cMD9hSn6t8+OBFgqKNekcDnH9oJUALxeL5Wrajfs/zUR8MXMC8bsnYEl7oAgJNdxUEZQg7fZ0OcojOG+0YFdiJ9rCKKolz+LB1H6MpC0YmyGO0EbDpU+U7S5BIUqyffgw6hY97kvZPCbw6n48oaDgyESz4qF4Or4S/ZTekIHTJ7FRbY/4/c5Az3F6XuwjTWfuHiyU9v7UMAOn+IXj9vEIMSYs7k8+kSe/lR+JS0vreBZkhEbyVlUh1C5koS9icy77N8SYUY4cwIjZIdE5fvyNZQ6ixr2c8KfuGUAlELzs5PdybfxGIEAjX98mQpQhbfxtyF+v2xO+wu2RmJfk5tPXUzdj6e8ubRFPkHD7FPMkxFpSP1FPMjFkDeM1eOCtC9g==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(70586007)(70206006)(2616005)(4326008)(8676002)(508600001)(5660300002)(36756003)(8936002)(1076003)(107886003)(356005)(86362001)(40460700003)(7696005)(2906002)(26005)(6666004)(54906003)(110136005)(316002)(82310400005)(336012)(426003)(47076005)(83380400001)(186003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 08:48:11.1552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b154dc-59fc-4022-5b86-08da332afaa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3220
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the recommendation in virio spec 1.1, a device offering
VIRTIO_NET_F_MTU should set the mtu to at least 1280 bytes.

Print a warning if this recommendation is not met.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 91f4c13c7c7c..961168fe9094 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -583,6 +583,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
 				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
 				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
 
+/* Recommended virtio spec 1.1 section 5.1.4.1 */
+#define VIRTIO_MIN_PREFERRED_MTU 1280
+
 static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct vdpa_dev_set_config config = {};
@@ -634,6 +637,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		err = PTR_ERR(mdev);
 		goto err;
 	}
+	if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MTU)) &&
+	    (config.mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) &&
+	    config.net.mtu < VIRTIO_MIN_PREFERRED_MTU))
+		pr_warn("MTU is below recommended value\n");
 	if ((config.mask & mdev->config_attr_mask) != config.mask) {
 		NL_SET_ERR_MSG_MOD(info->extack,
 				   "All provided attributes are not supported");
@@ -1135,7 +1142,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
 	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
 	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
-	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
+	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, ETH_MIN_MTU),
 };
 
 static const struct genl_ops vdpa_nl_ops[] = {
-- 
2.35.1

