Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1116F51EEF4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiEHQh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbiEHQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:37:23 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BFCBE3A
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMBWkDS5y3Ek/35s/MG3Z7tMBk36yLOZuznWMKqflAEeMLigOuok3xX5UVWv9TbzUpsDweyl8j1eKkfY4QWNvRY4ICIKZIYKg23sXQVZpFV73PMOsY5YPal+mkDh5ji9XrYJM1ANAlzXTM6tIvXQlEswWhf0GU5RG/dYvvFiiwBOC843wsg1nQLW8s2jEn+hC/WcAGRTBAuT5dCSWJJV5oTclMY/t9Nza1820IGgGWrRYtHshXfg4DSCA28hhpASeW3GoaxWWL2edFhKyM7SUmGb1gs3mYbU3FWlaIXkWXIWJqEhte7mOmW5TPVlMpCU26SXzCIkocX4fpwBwSk7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS0gzU8MhsWWY1UdLp+k/aj565NZzV7Iz0/5YWGdbEY=;
 b=mY7Xe/83RCnd3/gH1hogLdjXClFBU4JL8pckeSQjnwngxH0zB9Mgx9CFZxUvtpPe22QdGZ0MIyT2DlYZNU3SYpj2pEnvrX0AxJa4H8JgNv/fHar99GCGLj+gr95aqcvXDrIUQDR09lDG+6mpKvS+jBQHY/AYzj37uxvHnthnudhcM/qrLgLUExgj+YeJeM7K5AU+NzHfmUlEvChHOWITg4u3q0TdZg4QBGQARHpraIcO7iMNWpPy3DcKiwpKV07VMqb8j3H9LBv01/D3qLeNfREH8JJ+b+cJ+srha+0pM1K3lbCX305yiBcnXklWWoqW40U4qNdu99GQZhgDSnGUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS0gzU8MhsWWY1UdLp+k/aj565NZzV7Iz0/5YWGdbEY=;
 b=QSc2fjF0GKC1ged6nCCFQcy+2MCZ+mtFLZlgQ/bG++UdlRGYApHQWxRCXNITl+rowjnSVZFKcUHjmxcufIHjsK9fE5wnZF8nRXiqK/trh0yKAZox/GKQvDX/KL8jgSUDQLbOjx9vxzwpEoE91HdDvGMR3bIdIUa3RLI7/msds0i4Fduh3GXCj0DuCx8YihjePW5l63qmUGkrJLR7fslWkYFyQBbOxkpSbz/0THEH2y0p4QsgGk1+1c7jODNfKHWuZibbyJPdy5T0AZIossCEO+ikr/UC2+GZjIH36wfoRDUnS8KouAVWsFtbT3NbgZb28diQF7XUpwo4nI6XT+wgnQ==
Received: from DS7PR05CA0098.namprd05.prod.outlook.com (2603:10b6:8:56::8) by
 BN6PR12MB1459.namprd12.prod.outlook.com (2603:10b6:405:e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Sun, 8 May 2022 16:33:30 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::95) by DS7PR05CA0098.outlook.office365.com
 (2603:10b6:8:56::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Sun, 8 May 2022 16:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Sun, 8 May 2022 16:33:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Sun, 8 May
 2022 16:33:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 8 May 2022
 09:33:29 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 8 May
 2022 09:33:27 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v4 1/3] vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
Date:   Sun, 8 May 2022 19:33:15 +0300
Message-ID: <20220508163317.204673-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220508163317.204673-1-elic@nvidia.com>
References: <20220508163317.204673-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97452d8c-23ac-451f-6a7a-08da31107c87
X-MS-TrafficTypeDiagnostic: BN6PR12MB1459:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14597C486AD0AFF2974675EEABC79@BN6PR12MB1459.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAwh4EXGI5+aP1eH0Sxm2dpPPbMvvvAuj+NhQaWaHKxZbD1z/2cacCGOxDRZdJvZVAmzm6idFbMWmQEOGYJ7N4PlnLf4sXPM2zdnvr4PwmvYwxyEOYT9H8CC8Mfly1fY536SEsijLH7SxPsy0LzuBxOPagWm1fhH9uzOF+LE6K+SEpwU48LRITYt94KYhhcIcxzyIV+sdlB6ZK7JrRk2dz+WxYwzJessjTMbMq2JkU3w/dHj2x/JiMyZSCLeDhHOqf/xMkZ68zLkCYqZcruZl+G5WrHALo1CuMwDhtAn5AEfWPeX9vzrF6L+RcnDS8pTpr7/m8Lno3YiNQmjteVmQrkRUkPv9g8+wABfq9Uuv/CNW1ep3srYBwhYDzNGvSTNOylQrv6VO0tbWKHYX/KuFsweJbQSkPEyr8p/iVne9tx/2f5Uxo3EDztf/TZrZE97+94fZFuwnEPMVFa/JwmQf+jRCyzo/FZrCdcYRd2TOQ7haoAfbWs6cII+3gwWj/MDGRu7IngeVnqxx1imVwcjG3kC51Xe5LNfXjVBCYkkg/o5OEJ13M3AmRBMTyVl8nDBVPiFJopO9BCGLjOK+SrCDBnmlm6cy9ieoJw2YhMGDi3qivRfkLLqnUXUIF9N4HK7X4zwZSXtTOYAkxVUg8sq9/75kVX1S7RK8skGNmCJXoTsKWcfv2HtQwGlCSj28Yz+8RMjtDwZ+lONtNMCYwWtww==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(356005)(2906002)(36756003)(8936002)(81166007)(36860700001)(5660300002)(47076005)(426003)(336012)(4326008)(83380400001)(70206006)(508600001)(186003)(107886003)(1076003)(70586007)(2616005)(8676002)(82310400005)(54906003)(316002)(110136005)(7696005)(86362001)(6666004)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 16:33:30.3583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97452d8c-23ac-451f-6a7a-08da31107c87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1459
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vdpa_nl_cmd_dev_get_doit(), ff the call to genlmsg_reply() fails we
must not call nlmsg_free() since this is done inside genlmsg_reply().

Fix it.

Fixes: bc0d90ee021f ("vdpa: Enable user to query vdpa device info")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 2b75c00b1005..fac89a0d8178 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -756,14 +756,19 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 		goto mdev_err;
 	}
 	err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
-	if (!err)
-		err = genlmsg_reply(msg, info);
+	if (err)
+		goto mdev_err;
+
+	err = genlmsg_reply(msg, info);
+	put_device(dev);
+	mutex_unlock(&vdpa_dev_mutex);
+	return err;
+
 mdev_err:
 	put_device(dev);
 err:
 	mutex_unlock(&vdpa_dev_mutex);
-	if (err)
-		nlmsg_free(msg);
+	nlmsg_free(msg);
 	return err;
 }
 
-- 
2.35.1

