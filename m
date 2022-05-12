Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38329524767
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351210AbiELHvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351179AbiELHvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:51:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEA023BD7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWx0ViBsm7Fo5OTKWhYFnzu3VVDTy48XomEB+yHj5/CNvtk3gms8s2r4cPTl8pYUUfGSJR2flQ3/ba2Tz7OrSI4xBjz6Ytjd5II+Z+UUPyhKkJr1P6XIfNPPigmgGOLDgDmkYQTh2wWQTAkLldHCobL7DRlGhVR2no/1IOZG5PtoP6hH4azwXzggiMh7/W8SFm0OpSCSqrslvMp2AJq5x+8A5ZIJ0I7ZUkJKtj3G0HZUxr2JG7C6v5Cs03M1TEiSu2foGGa6ZJwS/LSDoR7AJzZcRP0LM3kmPI9cem2PeXMWN+Xuy0ICaAODxBwoJ/W9/7THF5qzZOE6amsgjXKDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp2CQkeKufDpXiu33CxbPm9FCMw4CDft+U6WNmlxzc8=;
 b=mqMzXv153SvP5KdOOPtX25UoqzaDZtwSvKhupcF6IYHhr84uzQSBJHeMfRqX5gZutkmWxOIjbpz1cNoMKytytHgslGWwV/Ddo0ksyX1GCHvce4dibU3JyerRLzAlAy8a2kZWLbUSY28F6YiSBHF+zvN+v//ZbHMFduDmA3tI8ycunnghmbvQ6ohMrpiHU2KgVvCJEnwaYlazPWvW1aJXRLOgcCpobr0Hc2qnxBj4D2xpLUCT+RbTqy+Z5RuacdA3kBz91mKP4H5ojEGSBZ8MErdhbUniXjy1cqUYAdeUsRksXQ4fJQ/3FYG6di+3SDz1pJN5W9xm/7YelSDQRfCfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp2CQkeKufDpXiu33CxbPm9FCMw4CDft+U6WNmlxzc8=;
 b=BdtMjX0yGSPZ1XbQdeVmsAVlWxncqZbOGWjPad79VMBwNuzLXHPUeQXBKUlrnmKcW4dxb0PC5K8hf34ULSftGB1jovydEEuH/PTExZu/49b5qhTMAEOaa2gan0sJpWmETBVa8P7nJj2XYARImlSEaQVnhQUjG5tZEnZYwJZ2H8N65oc40TmBELRHFdpUIjogs2VFmdQzged4Vx9Rq8GszeTWlRAEuyCI4nLN3AyfSFGBTaoKUZJosSvhlWcc2l4Sh+bS+0IPRinUxTmicY+9N3p/FD4KOYwlsHvvbdCkG8Ppdt6pOC8uLtkwSrNtSBM6oiXvLiB6h0BLSd/e2M8sQA==
Received: from MW4PR04CA0248.namprd04.prod.outlook.com (2603:10b6:303:88::13)
 by BY5PR12MB3906.namprd12.prod.outlook.com (2603:10b6:a03:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 07:51:07 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::b1) by MW4PR04CA0248.outlook.office365.com
 (2603:10b6:303:88::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Thu, 12 May 2022 07:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 07:51:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 12 May 2022 07:51:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 00:51:06 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 12 May 2022 00:51:04 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v6 1/4] vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
Date:   Thu, 12 May 2022 10:50:57 +0300
Message-ID: <20220512075100.1715286-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512075100.1715286-1-elic@nvidia.com>
References: <20220512075100.1715286-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a28aac7e-7631-41f1-c3ea-08da33ec2c22
X-MS-TrafficTypeDiagnostic: BY5PR12MB3906:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39060C43DC5D78DD6D6AB3AEABCB9@BY5PR12MB3906.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VNnOp9VNDR7JUer9MYmWILcuOldMNSEkYYitX00rNOUsu/HpoZPlyBtc9My1TqkuDams02nS7hvLFdiB9azhZQoKMcGXP2wQeousKSbUUHISVV4tBkzouedYENjQKvqWCKKaUY4FBjC+EQ/AYLy5/WS0glbTbf4SuIkuYo1Rs5A8pNDf4+x9vqyMkZqBYlo361xkINWedGLtSVCSkptu134F84tCBzrCzxdnSqwl1ccaEG9bANjczZW+UGt/FyS+7O+Mv3ojx1GUtfnZuM62cB4JdUqtox7BccbjoXChsXNL4t2y1QBPTXMM5gYwMVyWjoKniNZp/Uf77gasSRxOkPBvEj83+iPNCOmyczpOK+V54fhg7Q0vTb1FvAe0VYcZqLhQNTHCCLNEEpOokEqEEAPUjmGZtzTc/hrZo3SpRCkM5QhgFRA99AEkVkmXkN23vggFz6Xrk3k9P3niMm38auKgd0coResNBRBxPcE0lFYMPOrrjkM6zLhBghEWhoE7NDhRtNJ1YgSzZj0lCbpr6+ppceDp1Kgddo6otlrt2XhAa+NHUhwv8y526FSkYwpT95fuPyk1Eyz4ZbcBDLWqUsJ1QAthM/RkmGtWvfEHzBT49UwORq3J/9XAE+F94aEDNs7cIDgb7fS0na0b39wHmN064b9e5LHj4zwhRxNy1exz+Ib5sq3acU724xhKv87W0Gy5eT1bK7iHgho93zPZQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(2616005)(40460700003)(107886003)(36860700001)(8676002)(36756003)(4326008)(82310400005)(47076005)(186003)(1076003)(426003)(336012)(110136005)(316002)(70586007)(54906003)(70206006)(2906002)(5660300002)(6666004)(86362001)(508600001)(8936002)(7696005)(81166007)(356005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 07:51:07.0870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a28aac7e-7631-41f1-c3ea-08da33ec2c22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3906
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vdpa_nl_cmd_dev_get_doit(), if the call to genlmsg_reply() fails we
must not call nlmsg_free() since this is done inside genlmsg_reply().

Fix it.

Fixes: bc0d90ee021f ("vdpa: Enable user to query vdpa device info")
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
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

