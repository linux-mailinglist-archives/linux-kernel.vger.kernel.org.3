Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD452310B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbiEKK46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiEKK4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:56:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD939B97
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtuCO/HdAJfiwqTlBsG3ODZOPBWoTLM/HUsRQ/KidJ4W4q/ZmoiHzjL2oM4hhubVpiCsW1bebLglaMsUTB1hCFa7xqrsocxRUw6Vvf/V/KlN0VgqWuMLtp6NMfhPMDjX97QwwGDgexFwGjwdAxq2radQNBBFqQtKiEgRUJQNmIwNTokmL2NiE8d6RS33rLk9BCBfBak7dzs+fOQz+kRK/ypCRLbNIPFswCo7w6nU4C5aF06g6vYvakFZjZWLbGPy+7yIPpcGLjElMJAOyhFW+kVPIq0iXFSHz5n7t23q+P/FsYnvy6VM7UeF7RmDMGeTGpiFtQmer2U7Ru6DOOISSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR5LnD8QVfplJknKFPCjthP1Nav1xqWxp+a71y81xrQ=;
 b=KClwYpU6PIej61e1XoW55fltR52x7xRip39QAwnQVYH9qco/5wOnXp/AUhzFnhzZNxB+be9AkeXpbxpILEul2ool9xpPrQJVr5RUWGNcdVGHZ8SRuqmdxnIvUFl1eVkg/nEWo1YfqviXsUtHgWLRy0cVyD7TplEtdB2u6LoGhJFK0dwJedQnkTsfYiFu0KLafJyNFUpQRX5mNihRg0ED1nMBEoBB7FQ51Xs8qb4sjW+xRrLmKL8bvShMrNzaSKTS3t/jEA43V1xuPzceHJmpVA1s3jFIyr+Tk33T3X9lH+zi+fNycOUIHgwpn7dHtKk7MqqDfcUsutkNKv6pVzHO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR5LnD8QVfplJknKFPCjthP1Nav1xqWxp+a71y81xrQ=;
 b=UkcRlMfxauHZHozkVPDDAY8hX3lkPoGdo/Bxu+5vAHUnQ51eiM0S5Lzo9gnFFN/dCQgrXT3bRngwIfwYXeEnEP+aR4P5jvWdqU5s6dJM2qA29jhL/BE3WweYNYMp2f/ffoJf1teuOmtBzkdUcItB6M2eD7dr/9K202i8ZR3bS1StszBXaQKvzTmNHcjRpboEhT0b1QjNBarPM0i1pmnVrcV+lYyRgCgkj7nTlyWkM9j2ZAV4JH63lrVPw5IEJidV98A/7AlEnpkvxLCgqM5/J6PIQQWL9LE5k3v7PGrzJEbDUaJ9IrnD/dzMhNoSdCziM+jSr/j0Aqp5DkcIIoEYyA==
Received: from MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::30)
 by SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 10:56:47 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::72) by MW4P223CA0025.outlook.office365.com
 (2603:10b6:303:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 10:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 10:56:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May
 2022 10:56:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 03:56:45 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 11 May
 2022 03:56:44 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v1] vdpa: Warn if MTU configured is too low
Date:   Wed, 11 May 2022 13:56:42 +0300
Message-ID: <20220511105642.124806-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77f479bb-2ee5-4818-016c-08da333cf1b0
X-MS-TrafficTypeDiagnostic: SN6PR12MB4720:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB472016DE36102F6840EA8307ABC89@SN6PR12MB4720.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFafYkXcl4ytGf22WxDVe29zbppMbEfaVBojb3+XwIiW4J2SNm+sFs/4qF1BSNROPaCNTwNIQUrDL2yjfMfIGKs3SxswB9Cl/E9sijRiuRaP/IgnVnW9dihYMuJIbEnfm8ze0q1jasPWRQ6RbYE+Lyaozt4aXE3VW527G8fBXlwuL3SQqPbIeQfB93W9DRoEIof0cpS3u3wWXaLkLE5kvuNkCdiaG84ix65wN9KcjGMGvtL64eH0NMh3Ip9KUd1htpD2hjXdQPstXQQNZOqH0U8s0QBj/35eSePjEWw50c5EA/ZSzDBrSb70q2Ibng2vKHbF0bO3VTWI8+ZTTsLIVtnRrIajsWaKbITbzOVlYNa+Xcdoin65GuLdqISkqAio3fDaQzu+0NWZOjyV12qwfjuE7JlOlP3/adu2jko7KH/ma4TXNUA0du5JRgQHgYROCb/wqEWXm0ZVJRAXkT/s8bzLkmrQbvF20iJ+o+2OZYM689WwuCGMly34rk7Ko/vHhYNGJMmpdYIvr1yNAaTHrflvPsFJdvWyT6lpGroMhpcfppTmqiYOchIsV9QZIChXsooeH+3CyoMoLxAP3ObxwWMUeXF4CwhD32NVca8G+MgQWD5okI/xms5w+3+5ZrWtDCp4edlZczAt3vGhH4KiiVAJTxYOMX1pdZ13m/dL3tc/kfSsiWPu/AIy/zi/jVFKxqoZwtuUfLQA4byCfYc5Dg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(8936002)(7696005)(508600001)(40460700003)(336012)(426003)(36860700001)(81166007)(83380400001)(2616005)(26005)(186003)(82310400005)(1076003)(107886003)(47076005)(356005)(2906002)(5660300002)(36756003)(110136005)(54906003)(316002)(4326008)(8676002)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 10:56:47.1150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f479bb-2ee5-4818-016c-08da333cf1b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4720
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
v0 -> v1:
  chage pr_warn to netlink warning to userspace

 drivers/vdpa/vdpa.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 91f4c13c7c7c..0fb4a615f267 100644
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
+		NL_SET_ERR_MSG_MOD(info->extack, "MTU is below recommended value\n");
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

