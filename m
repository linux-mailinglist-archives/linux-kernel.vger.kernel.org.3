Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE514B1169
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbiBJPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:13:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbiBJPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:13:00 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47898D4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:13:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRzQ00bWSEZu95GRDCevO2J8VR34eulwc4G7A++GggITI96W7zkN0PzEZFte1BKMQf3s7TNmTZU46lFN4sXzQTNtt/r7+rkfGFHCkzXtkeLS+gfgjUswpSatR212vpHLbIAEo/aHd6kReDCALmZ+XTY72VcrlUXzBXRUjeTFekEzJWC9d1SMkgYLz3cv5QpKbqckOdfjI8MTCTQ7/VU3JWKfU0Keh1L/jQe9+Jxqe6IbK/5VqjnVhIPap8fVTjZehF7Y46qy8xNGv7DpO1KCfhWsoZ0YJWpvEc2j+Z99vvALUplLsrb1u/ytu4sDm/mwVuSlgDXp5NlJ//IFZwxMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tof2qvbErWuGU72m+INlTkGPIv5gpF6RDxmzRv04A1Y=;
 b=Jq2PM3i2Oc4AmVa5VDlQMtbnmHjVBPcGu3syeoP1D1UVjXoB3nUSWfhVEhI9bht+nLfJ90iSOB+3R0sRVUB0VNMTIbbGBZMgEPXMmCNIOrIaJUakzHZfoXc8mvq0W+Im9Hjabq2xkkfJ5zwW8rTcghcyM0k1Z214jrS1QOukNv7WwfCDxYWOcD92U0xo1yQ9vvmx70ocaiP7jGAnE5yOxKvW93z1rDgFUKBw8d+wFl5cLp50ayGS0d26WyAwYpBQD9rfCFRA8mAWRRN7j8EJEdlcPRwhYchssuLKTxINST0tnm+T/jckpc04+F7e5IQaXVV/tbLwe1WQEgpTJqJ5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tof2qvbErWuGU72m+INlTkGPIv5gpF6RDxmzRv04A1Y=;
 b=2AkjnSEc7LpnhwxRBwkvtko315ZJhxfbBfYr+xczsnt8dpoW1igj8C4kMAGyXLmD72aEf+HUE4IYIegXp3KjnI1mlPh4jsUgRaDaaShesOQwOM/sOTeT/rZNvsPOCGDLCd9vllFYqyqlzOV9hPMjjttmDavPtVVbuTXdmVjyIDw=
Received: from BN0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:408:e4::23)
 by DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 15:12:59 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::da) by BN0PR02CA0018.outlook.office365.com
 (2603:10b6:408:e4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 15:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 15:12:59 +0000
Received: from ethanolx5673host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 09:12:58 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <daniel.m.jordan@oracle.com>, <joro@8bytes.org>,
        <Jon.Grimm@amd.com>, <wei.huang2@amd.com>, <terry.bowman@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Fix I/O page table memory leak 
Date:   Thu, 10 Feb 2022 09:47:45 -0600
Message-ID: <20220210154745.11524-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85a8cd55-fe99-41c0-dba3-08d9eca7d2fc
X-MS-TrafficTypeDiagnostic: DM5PR12MB2439:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24394B31680D743DAACBC502F32F9@DM5PR12MB2439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFsWWraWjPrx6jDFKXuQioUq/Tkn+Xw8YiwgdvC6qPoWSBjNV4sEFIauhyutT+AICWueOV7AYbucPoSA9jNxnU9LgQQFwxcbtMBMM6aNfhE3N7OAJfwN51WgH2qj96IYGD/Ow/Ofm3OfTPmZFoN0KdmY0OxgXsnwKblQgvX/iH4mHCRhDJp7mzA8kIsuPJs/BA/7THCcI/npqCsADYOOaD9dYU0+u5ob2PvKtacfovhzxZFDqnxFBwm6Ec73AIcFCEwMdZfhdbgWgFqT/EkI0NnD6jmoxAVqPz9g2n6OZh4dSNMppDQMGENmVvZ785j0BwsCFr8RsjNSmCohilJnP0cNAxH3EwR1gzNrm+u+LsQ/DIjESwJ+k2kvjCPDaiNBBElCu6/uFliNN3ofazX8FTYohXTWHPwFYhZVaoUGzuuDJSYUo3dLX3GiRdDvtR+MPxXCStF2VYikddjEmIRE74+Vvj5l+cbUigZUDg0h5rn0oMWk2XJQDS9OmvEQY4EQr6TKMhiedA+jmxYFgp5DWPXYTwDz5YlCPjeCu7e5k+2uqGPo5rqM9LtoX1OTe9PHNEmZiMsrQYDYCCj1CHKzbbmh9isTJhoCr53D03jBf3AmDxvjIQYLp/mVwMWBcE0RroruLc2PtSi0olkK2v+N5WDWsTOfnuELq5V9H/nXYf042QL7NGtGYWkQLoT21Rz8VMI7OtoByuZxwUDO+HbYYldjgcUQpjRF2CeueLvZT6kyNNP6pjpAbDJADraEQgE1A6nvMw3QVFr5Tdu02AGl1o7W9w28csI+PTl1mKz3vks=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(70206006)(4326008)(83380400001)(44832011)(6666004)(110136005)(356005)(54906003)(7696005)(4743002)(508600001)(82310400004)(86362001)(70586007)(8936002)(8676002)(2906002)(2616005)(5660300002)(26005)(186003)(81166007)(336012)(1076003)(36860700001)(40460700003)(966005)(16526019)(426003)(36756003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 15:12:59.2334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a8cd55-fe99-41c0-dba3-08d9eca7d2fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current logic updates the I/O page table mode for the domain
before calling the logic to free memory used for the page table.
This results in IOMMU page table memory leak, and can be observed
when launching VM w/ pass-through devices.

Fix by freeing the memory used for page table before updating the mode.

Cc: Joerg Roedel <joro@8bytes.org>
Reported-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Tested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Fixes: e42ba0633064 ("iommu/amd: Restructure code for freeing page table")
Link: https://lore.kernel.org/all/20220118194720.urjgi73b7c3tq2o6@oracle.com/
---
 drivers/iommu/amd/io_pgtable.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index b1bf4125b0f7..6608d1717574 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -492,18 +492,18 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 
 	dom = container_of(pgtable, struct protection_domain, iop);
 
-	/* Update data structure */
-	amd_iommu_domain_clr_pt_root(dom);
-
-	/* Make changes visible to IOMMUs */
-	amd_iommu_domain_update(dom);
-
 	/* Page-table is not visible to IOMMU anymore, so free it */
 	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
 	       pgtable->mode > PAGE_MODE_6_LEVEL);
 
 	free_sub_pt(pgtable->root, pgtable->mode, &freelist);
 
+	/* Update data structure */
+	amd_iommu_domain_clr_pt_root(dom);
+
+	/* Make changes visible to IOMMUs */
+	amd_iommu_domain_update(dom);
+
 	put_pages_list(&freelist);
 }
 
-- 
2.17.1

