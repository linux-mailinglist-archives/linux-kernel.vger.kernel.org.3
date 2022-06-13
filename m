Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3773054813F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiFMIAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiFMIAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:00:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602BD5598
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqoV8PY//rHbSqyccSL1mpjrnePrzug6qeQUukF2hzzd9IARZ8gqqDWuBRiAu14l2ugk5lMcWwxNx0PQBDsbF4qR4bs/Ll/r8rXrlKKdj0VFyf4iKz8gDV5wpEFRxWG/yLjLRQavRv+JBZahRDPgAH/I2JNTToknrV9MZpMBtERrWN6+JLijBG+oqRaNo5butJg3gWAB7YQno0/f4AcFQ98g+7d9NYIRPWNlBJx/JPc2IvBoVC0e9vtUmSpsLGj97dciNe1EYBivgsZBTpt45seSzyeYB12zBRdMLCPrJ6k6hM9ILwHVM2mDDbtF2uAjtDHO0D2jl1aTO06umFIKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGnFIkUDgRxR2qUiOCuiP3pXh3IVQNugGgi2+ZQsmmA=;
 b=WL73Wh6ibwcG6uvuOFWW1rom4cBQYbuJdbLkJLmQTOC/hITDIqaKh/ngzEq58dmYNJMPVwqXizoXRnlqFHBTnHH2sqKXZoZAoO+Cn23SeD6JOGfD3tjBARqU4/WbRDL8PfuilnQfnkJmXdZmnOPXtnnHwp5hZmTj6ACHo1rbb5tI4tMspRh/S/nQ+KBWUGWZRoHfxC8QfZ1V5mShcpxiy/YzEGGib2Sqp6PZdEe/3R0ljbze22xqo9JdS52K03INN3CfNFv0jFsreVFc1X3aAt58A23JkyUUsw0uqaP/lJ0zfVqpc0E194NgSoBpF2JVwO0QmzmbqEV3JVjzai/qnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGnFIkUDgRxR2qUiOCuiP3pXh3IVQNugGgi2+ZQsmmA=;
 b=s5OyuBo0Nwu33DmOpMVhqUXc2MLQtqMjY9DDbsEW+MyIjuCD1He8Y32AsY5YNhZP+74nm8m+OPHIHQU64YRz2jKkf6KN2JLaFM390kiQ1zWwa+nAl/B26bZ5SeR39Yh0jQ6xgcb2UGbV1U55cVddHx8VjA0drtJmbukOJ/9xxaQ2rY7/bccWzOFNPVJPdkYc18ybExiwZ4v4W8+52IUiN98Ol+vDZ3RUhh900vubiz/YwnTkrQec8PWG1Be1hMDKJXlWxOJ24n5eSyDo7RAhs0nSBk/fX4SplGyaQ1vyIOuGm5NG4x2l2n/ZYIv4WT9x+IzLTc1S1vxohvcQ2gJbTw==
Received: from MWHPR22CA0029.namprd22.prod.outlook.com (2603:10b6:300:69::15)
 by BYAPR12MB2661.namprd12.prod.outlook.com (2603:10b6:a03:67::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 08:00:05 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69::4) by MWHPR22CA0029.outlook.office365.com
 (2603:10b6:300:69::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20 via Frontend
 Transport; Mon, 13 Jun 2022 08:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 08:00:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Mon, 13 Jun 2022 08:00:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 01:00:03 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 13 Jun 2022 01:00:02 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <eperezma@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH 1/2] vdpa/mlx5: Update Control VQ callback information
Date:   Mon, 13 Jun 2022 10:59:57 +0300
Message-ID: <20220613075958.511064-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be27bbe6-38c9-418f-e09c-08da4d12ba0e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2661:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB266199F6A86A96ED714A5471ABAB9@BYAPR12MB2661.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cqsa05yTNKy++cdjcLi5QbpavEDmEoIi2YcU8KaWS2slzIoPE5i5l0OERuFLExqZnXYOtAjngsWh/In94f1DfIl935Uk2SL1Pybggjr3teTQ7op7i9sQcOTpdBDdyJ9znmggQ3onroFuvayVfIihTfw5ENKUOsEoU+OYTLwJ45K+/VMDpYGMu6Pq+K/BSHTxu2JHZnOsnBg6ls19D5GF6Y15Ogrwh2/JvSIJlr92vAmLMT4rTxafixef5XFGa5rx9+xt/SHCaIaZOhNPbuxWB+HqfyWRGAE2poNe92xV6meDcPTyRrdoJf5rKJ6E59OCAhK7Dji4qYZXus15zHERNKLGJwgRQv1HMDpUA/LIs41kgN4ANTqctB39GugnOveLRxM4Yd5hM0caB+48PrtI+MyrnGhkVo4qLE05OxshXq4n2AdIgRKzA8Bu7h4fT4bA9I4PMLeHBvq/2J4rLURp6VBmYtYtPAujCg5CzKqY3O0SVxTibyfaDFF0eRVH4lqUm2D0V5ryg5XrRFFGGSQsjIeze/r/FSmMgSOb6XmGEBGuuuzF+4cIYBVw6ZHJlcUn5PsjEUd1N/5clNzbXTNI0bRtllZ2Z/kcCvz37NqvOglrfdTtwvTAnxphfxurQ7uhDA+41R7fbTUsmPeXA5KJEQooP2G9DSRERgtADquePozNcfoR9v6ZNvJlqI8WSSmtrxgJuPupmLwqAckdKhBy9A==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(86362001)(426003)(508600001)(2906002)(15650500001)(316002)(336012)(70586007)(70206006)(356005)(54906003)(5660300002)(8676002)(4326008)(110136005)(81166007)(8936002)(2616005)(26005)(107886003)(83380400001)(40460700003)(6666004)(36756003)(82310400005)(47076005)(7696005)(186003)(4744005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 08:00:05.2008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be27bbe6-38c9-418f-e09c-08da4d12ba0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2661
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The control VQ specific information is stored in the dedicated struct
mlx5_control_vq. When the callback is updated through
mlx5_vdpa_set_vq_cb(), make sure to update the control VQ struct.

Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 1b6d46b86f81..789c078ff1af 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1962,6 +1962,8 @@ static void mlx5_vdpa_set_vq_cb(struct vdpa_device *vdev, u16 idx, struct vdpa_c
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 
 	ndev->event_cbs[idx] = *cb;
+	if (is_ctrl_vq_idx(mvdev, idx))
+		mvdev->cvq.event_cb = *cb;
 }
 
 static void mlx5_cvq_notify(struct vringh *vring)
-- 
2.35.1

