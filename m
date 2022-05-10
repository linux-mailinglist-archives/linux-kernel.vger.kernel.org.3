Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0175213B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbiEJLbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240897AbiEJLbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:31:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4E81FE3CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrw0Sx5y2i3lOtIxxKLinc3wyz+B7+wURuyxl0EeYkxGE1DXiLPhosu5KurqJn0edRQ+QTcAKiljO5kFKyu2HViL+AiJkCKA3WIVviNfVqtKol84yRi8vNaOVe/PP6KwKJcsS7n4h2EVr4ltEmGwrYp25HN0yKrwq9UO7kwtjm/sa2xcS97sG20TFQHvc0tM49BuyjNUEpSSQYpO5twAxt+Z1bsKmfE00EmNQoZ1sJ26zi0PuwHxJSbY+9ZViEFKspwO53Ti7IOM6zvxzFhWy0M7vqFpszlz7tfbcDfOd0/FnHJWMyewpDLfYJ3/lMa6h2rMrEOVApDbBi5GXiDuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+KHOi7FgZAm3K8iSHKholn4WpEVJ/js/GdYQxduXJM=;
 b=XJ2QS5KP25FqnoIsVAD/Us7ciL2h6oS80X3Ih9KKagE+NOlo8fxoRgSruUilZnABD5elSsGJWq/JRMk/oFzJ7PCg4/J5oUAwWQwxpbZQFZEbNaqfSypI2vEUfEv7dEeUQ5LPtQGqN9VXVLHG1V1LQFoqQaYwT8Te6baLMZXm2sVkbTrk36lUBpMJ6riqEA928DN+77zqy/l0de+fpQQbUKAq9nxs/XaLa4+8kCpp70JWvpPfYpudOzdIwbP9w1se5L7CLoc50dNqmqZUlz957GuM6s9Zrg7+ygUM+lbYULhNhN9IMPpdgzxu7XlRpnLK48x8Vv9BrtWDusApglnY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+KHOi7FgZAm3K8iSHKholn4WpEVJ/js/GdYQxduXJM=;
 b=lH2uaFewe/XD4EHAMkU274wH8fuTSgfv2TmBoZk2i4dG7BQhvv77kOKv4257Ymt15auBo78TJ4/H3jOdZ46RGl2G2DOnkWruw25B9w9RdfIG5TLWb0jAt8AlhSZVAB+5Q4jZChOdxY+NSV4Jntyb4nA/iU5i06/JJASsRPD0ttj77ckw+qP648BFUcYnwDdAJqBdeQDtEkRSo6LDpDVK6bMahuRAvRbI0xOS4rIaqpqzPCXpLRHmSHi+M7o6h8WWo6QrQjOIoEO4W5ZzYNzRs9q2UJmWjIhUVyTDdSKK/pNAfMM5eiqxlF8eo2jlYhcpIDyFbgnQg2AUb7zaOt88yQ==
Received: from BN9PR03CA0509.namprd03.prod.outlook.com (2603:10b6:408:130::34)
 by CH0PR12MB5220.namprd12.prod.outlook.com (2603:10b6:610:d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 11:27:43 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::38) by BN9PR03CA0509.outlook.office365.com
 (2603:10b6:408:130::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Tue, 10 May 2022 11:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 11:27:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 10 May
 2022 11:27:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 04:27:41 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Tue, 10 May
 2022 04:27:39 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v5 1/3] vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
Date:   Tue, 10 May 2022 14:27:32 +0300
Message-ID: <20220510112734.205669-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510112734.205669-1-elic@nvidia.com>
References: <20220510112734.205669-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3988fd2-d450-4f34-af16-08da32781957
X-MS-TrafficTypeDiagnostic: CH0PR12MB5220:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5220E38DA6730688407B2291ABC99@CH0PR12MB5220.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7JwTy1Qd/nAS/RadGcLj76rrWFk8ZR4lkc7i25BPVAi5oyJwHSkrMmgs5gXggiOz2+5AzunZGXvXvwSrJVMcbP/J1Xxr+NSkRH5joDpIGyee3di+VS2l91jXl2BA+BI9eiItg1GVuQevzJv1hRD7z6VH3dNm55lhHSLic2Xk8u7YvFdhdS5Y9COc9/GHE/UNKunxdV3xdVI3ygkwwf4uwvOsUL3uXy33W2Xlb80CThyLWFeA1gCah8VxaZ044GCXTyBjqVJji8RDxGi8su7y0z2GgW+06AeDTgATtIBDOybuSZAOjbWXba3ZTy9Yxn58Ptz7FFGa4v0PzVlwdxBqEYH26NIOq0uqjdw7x/pFohorYLwe6LgKiqqntjwQktNHNm1ieRCNjizjBkzHXp1hMZOvmOH4NYrRZ8actfVBak28Bd4nNwRFwb5eftm7Gb9WCm+bkI98lR6cJ44SbJToD9wAawkJe1WeaGiPWm0DjO9LScnCq0LZhoAdXUkv+7XqBQ6kQfZIAq3DmeBA9sWRwuai3AU9s2BKoMRhRCzQ4RbUTG+tFoK9iwKk/9qbZc976AmzPH3PdcdBuBKKSGQYYTA7rtbqUg6AZU6QI3hst5Eafi0efm+u67HSzKz7UcpaubnVVHVCxfdkKeIAPQX8lBld2Q4gdLpTxOl94C1KswkUTmHmacxEySCVS+yKXv8MIKFhGN0rrB8v5cRuFXpEA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(81166007)(83380400001)(26005)(6666004)(40460700003)(5660300002)(36756003)(82310400005)(1076003)(2616005)(107886003)(186003)(47076005)(336012)(2906002)(426003)(8936002)(316002)(508600001)(356005)(4326008)(70586007)(86362001)(70206006)(8676002)(36860700001)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 11:27:42.7425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3988fd2-d450-4f34-af16-08da32781957
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5220
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

In vdpa_nl_cmd_dev_get_doit(), if the call to genlmsg_reply() fails we
must not call nlmsg_free() since this is done inside genlmsg_reply().

Fix it.

Fixes: bc0d90ee021f ("vdpa: Enable user to query vdpa device info")
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

