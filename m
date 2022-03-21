Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014144E2A72
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347503AbiCUOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350775AbiCUOVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:21:21 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD15F193152
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IL94MDKqN85l3Irnq3X13JTYK1Xll0cNLpV6OqLN8tttRD0rlDkyPgeIO3PAXxl35LqitfCm2HSLQO68bZRGxk6KzZgrHGPRp4H1YFFYDpBPog2luJEOZs7wfAU9rt1UyXDKga2BWxBHADTmeuxa/qzBVxpU6xCXpa9nI7uTICg52lzqSC6JhlVa0fawC4ETQih/bOB83EtPmq3NmrvhX2KWQnxkflfcfC10+WhFeMrD6gt/gTTmF+gFR1OnV62dB6MRW9zVub5+rAyI2o0X8JE45TNzo00nhRiyFq3wymzLhmgn2KvaeNGKj0D/4w1/JyDPpmDOu+eHELfS5GL+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKZru733Z7BIJrMwQ6nHX/4BdQQJsYiP8NR5wpoD9m4=;
 b=jW8uNcuzQGijArTWROBc24ywiatpL9MUTj72nZqr7AxpQHiOY/Enoc1xivvQa558t2uX97kUw1WrEAFzS0Vjccj8Dk7c9YCDG+nsbXayGhrY+SgKa8BUjw6fvpiRsDUXM8fbt13Sjljg6oZOM2Hg1St+YQNKjdLanB191UgkmU6YY/w4ujsCehRVxDABDjNKAKL0XJURcpeeiYnywoEnntqQ6b7zE0t1xRp1RXPpEQAlllKIbGwDPIplIyUdi9wpTrlHz69sqbghaOu1jzEEPuUaVQLC8riKEbmi24SmGSaqGzAZdOkRdRmc2ik7Wu3hzYqVgg83XHwr3nUVP0O3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKZru733Z7BIJrMwQ6nHX/4BdQQJsYiP8NR5wpoD9m4=;
 b=B0RU6Oi+SVv9H7IE5PobLssjYzletKsnc7LBV0Jr1AdcpeHN9loe6agpm33X1l1LC7YJs0cSVd2fmFMsUeldqFbiX5HhuAGUDRE/RhQliD/aFH3VuW13jixPHhVA4bCFH/wY9HOYwGc7hy3opQMTem8z4YztkjXxRVF9NG74PU08rI7U034TQrMAHd7qtZ9lL2z91ahHN60JJsCdtcfjy76l4+tEX5PlXDW6zMOs12wD+dmc3Mzk1SY3DaEwQQ1gIbyWrUM6BP7ekk1i0b18WhwLE4Xwl1WNwsnuZVNrkc+17AdfGV1A+6sF5VXKgTUR1mL/z4wcyLAJzd0++tmI8A==
Received: from BN6PR14CA0025.namprd14.prod.outlook.com (2603:10b6:404:13f::11)
 by DM5PR12MB2566.namprd12.prod.outlook.com (2603:10b6:4:b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Mon, 21 Mar
 2022 14:13:36 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::d9) by BN6PR14CA0025.outlook.office365.com
 (2603:10b6:404:13f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23 via Frontend
 Transport; Mon, 21 Mar 2022 14:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Mon, 21 Mar 2022 14:13:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 21 Mar
 2022 14:13:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 21 Mar
 2022 07:13:20 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 21 Mar
 2022 07:13:18 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jwang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH] vdpa/mlx5: Avoid processing works if workqueue was destroyed
Date:   Mon, 21 Mar 2022 16:13:03 +0200
Message-ID: <20220321141303.9586-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0731429-cf0a-4256-1a71-08da0b44fccb
X-MS-TrafficTypeDiagnostic: DM5PR12MB2566:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2566A5AF634CB166F6E8E018AB169@DM5PR12MB2566.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXM5OUeP7PQHYBtXOKZQKcPQSqJhKf7wM+Eg0BxpTIqAPlxqO0JhrYTcX00o6E+WB/ILt2DXXYQJn4Fb56yQxmzBXBtk0brpdn1U6NvQSso182MWuukHjtNDuCLbBQgCU/DdfbusZmXrDJRfaMImQC6wrohGWfj5amf3/LmvQFm+OTsqHQSMungLmNyestK8PzR60CCqnd3aE2/ZwChOFY46ThEr853MjJwGnPNAfPL1sO/JW+51/7MU34fGl88i4HmztyqzX48QAIpBOe/uEfE6wCWwfZvqIkIlZyGhYJg0N2KYU8TC1z6edXHH0HkQQ8XkbcLwCHIJ6ajijDjOtlow3S6ruvVoDaaVrqY8Sm7OKbXVlg/tbzYYLek1Bt2GqN9hB8GuCcebY+Bth7JOYCEOfxymc0xykN3xJCyv14GVcQopwes1NYrwjBUq9uUPEqskFA1yjJkaWsxRLT+VA3GCYRGgEX9ioTSEoaeIu6hB0jFIIga9DAu9DWR7UBL5edQS0VqhL5RpjD/KgiVEMiDdJeQ2BLmCGzt6ONmMoBHr5BzBK0T+6v3qFhi6rurtTMVCuoUIYJzOaXqBjhPL1dg62IogHvilJMSWjS6ZEjcQ+XAp80sz6dzAWUg5qOfXDZ2tNpTngcxQUdIr6sD0kQGIOD0xsXsEob+ba9hMyBGBu9tnWyt0PNwcvdZXLRg+7P3igS6qcqXQ6DDIgWK3yg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(336012)(426003)(47076005)(36860700001)(356005)(81166007)(83380400001)(40460700003)(36756003)(316002)(54906003)(508600001)(70206006)(70586007)(110136005)(4326008)(8676002)(1076003)(186003)(7696005)(82310400004)(2906002)(5660300002)(107886003)(2616005)(8936002)(6666004)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 14:13:34.1635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0731429-cf0a-4256-1a71-08da0b44fccb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2566
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mlx5_vdpa gets unloaded while a VM is running, the workqueue will be
destroyed. However, vhost might still have reference to the kick
function and might attempt to push new works. This could lead to null
pointer dereference.

To fix this, set mvdev->wq to NULL just before destroying and verify
that the workqueue is not NULL in mlx5_vdpa_kick_vq before attempting to
push a new work.

Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 5d7f3e8000c6..5c9cb0fc3e7a 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1669,7 +1669,7 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
 		return;
 
 	if (unlikely(is_ctrl_vq_idx(mvdev, idx))) {
-		if (!mvdev->cvq.ready)
+		if (!mvdev->wq || !mvdev->cvq.ready)
 			return;
 
 		wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
@@ -2736,9 +2736,12 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	struct workqueue_struct *wq;
 
 	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
-	destroy_workqueue(mvdev->wq);
+	wq = mvdev->wq;
+	mvdev->wq = NULL;
+	destroy_workqueue(wq);
 	_vdpa_unregister_device(dev);
 	mgtdev->ndev = NULL;
 }
-- 
2.35.1

