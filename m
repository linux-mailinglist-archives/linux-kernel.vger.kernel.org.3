Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713C5555216
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377206AbiFVRNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377209AbiFVRMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:12:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB7F1169
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyMAf99CaIjdV4Ki+zY5ba7TB34JVJo6l/YVz1E3VlJY5nBG62nk47iEt7j3rNRlW+BDLLebwam7bveMpYY5X+81UeFH6suy1zOnrRxf2dfvku5UeUGELuZEZndI8spuKpuOkRnZNJDez/Gvhed5VtusF2AKwTNOmOdyxJLoMzwV5ou7BWGhlG1CMx0WOszlNdOMfsdc9kIU3N34mqDME+wZsa/m1tRusyrUV48zR2hwwZBPOKUpJnYZ44YiFewM2avEWeCERk+A/0zMy4N+duxdZddvt38Z4SFQyK4flIQQpwwd+eHLeKGWBBQ6Ktoxv5Pi36Xt6h//kvnZp9prfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpJ7bkErcFqXegMKSsjREmOcNrSuahL+cgRI3UL9bro=;
 b=BehQ3VK2PjyYz9nWkGmZYf1et0/Qu+svi4/8XLLj+pB8vBqDiY8PboR8SFvXIN0aw1Mf4UarOLSxGMl62apzT80fHRODabO3weoqlf+tZVx5O9gOlqbDlLmvVNWblkORbg39oGzf1gG8kJWBnMh87U8Gi8cCYQfG4CAovbDhWeJtd+8u/L5AID7UWhsdRlHMvoVqnZgHAKlQvPVkuD6m+F7kZK6KgLmGnx2i95k98sKHRMWIAIRNmgo/DTtgK8V7vVe+U/yTgy/U3SopgyA1vbDf6MYijTH6+cc47OfuIjbkXBUeN+U65sWu7wK18ifhOYMo893JPCC318lURX0x0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpJ7bkErcFqXegMKSsjREmOcNrSuahL+cgRI3UL9bro=;
 b=pUFPS6tTHYSEw0kK1U+UHR5GAOGYKc6v5qDtCX3BK6lXUb41spgW+FCCc5f0cbSYGNzUgnQCG2tdhbgpQ3CAqVSa80MPTefz7xCVjw5tLX6WSiY9F6iFqp3TOocnm1qfvmtik4B8wDA8zuyULh+6ol2fcPGN34F2Oii51t0r4EM=
Received: from MWHPR08CA0038.namprd08.prod.outlook.com (2603:10b6:300:c0::12)
 by CY4PR12MB1527.namprd12.prod.outlook.com (2603:10b6:910:5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 17:12:41 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::b6) by MWHPR08CA0038.outlook.office365.com
 (2603:10b6:300:c0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 22 Jun 2022 17:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Wed, 22 Jun 2022 17:12:40 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 12:12:36 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
        <vasant.hegde@amd.com>, <thomas.lendacky@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 7/7] iommu/amd: Do not support IOMMUv2 APIs when SNP is enabled
Date:   Wed, 22 Jun 2022 12:11:31 -0500
Message-ID: <20220622171131.11870-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
References: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13066489-84b4-4d34-0697-08da54726a1e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1527:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1527E47A04242997818D674EF3B29@CY4PR12MB1527.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfFVSakdbJ2V2l40tZL8ehWdN/CbCJYpVSCt3i0s7Rx89p5ZW/z3FxJjnIo5PRVmQgYhH8cB5XIm4YPmpWCHaevwlOnTpgKxRDO9m/zjGUPYv9KMqvOsKqJxf5qqTfPK9/CIGhVe4I2he0FhgOJh68pxoDTcU+Y5dQPBrRDJ/3JzwDIZYMd1fVIuihRaHuNsqnfxPBpaNI/1RLMokH/H4xmyk4ZZa8kUwv4xFnDDEY8eDUTfeI2MyonUFdnReDbDm74OmL2vK6V8HyYSbBDYA7u1VZBsn2hDnti8QQdVDYiLXY/5/rMz2SQEx4jx0plLZsIhKSz4ZwwgboRrBROgJkm+vQzz7curTR7Lhu60Tw4EVvc2iyWGSv0NyD1l96ugusr94sf6qF8foOirEeuOnolMN9yvVctuuIiZYbZe3QrQ5lVFdtcYm252cWJuo+JiqZi2wuY7O2Eyocpw5TH7+e9UPMq9F+GqiB+2dCCjrsHIMJ2MvZCEqOXdzq6rW+I6/eEzACLppofizIdWcETXz9CPGpop1sXX1Bzw0RqiwXZ+7xPxFqPkTwOPSdFpmuwbuuM01dq3gtlxXtWhRJ2zOkWRatW1fG2wic3tmrDGs/Jc5kd0aXCfu3s2WfBIt670lipu7vBLHNvgF30IU+fPkp6nGn4i3LrEh4p+nc5dhsjUbHHdZAXdzKvzDzhYRwW23983tGLZBmbXq7Hyi7hCAkB2vROI49tBjI2mJlRKkB6clQeq81qT0GolO/EKkEP+/p+oRJ49+CwZgf6xmYKXWDBNcsFwmVPIZx2tPqZv3MI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(41300700001)(82310400005)(83380400001)(186003)(1076003)(81166007)(16526019)(426003)(2616005)(40480700001)(36860700001)(336012)(356005)(47076005)(82740400003)(70586007)(40460700003)(4326008)(36756003)(110136005)(26005)(5660300002)(4744005)(8676002)(2906002)(8936002)(7696005)(316002)(54906003)(70206006)(44832011)(86362001)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 17:12:40.7829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13066489-84b4-4d34-0697-08da54726a1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1527
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMUv2 APIs (for supporting shared virtual memory with PASID)
configures the domain with IOMMU v2 page table, and sets DTE[Mode]=0.
This configuration cannot be supported on SNP-enabled system.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f5695ccb7c81..4c9b96160a8b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3448,7 +3448,12 @@ __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
 bool amd_iommu_v2_supported(void)
 {
-	return amd_iommu_v2_present;
+	/*
+	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system
+	 * (i.e. EFR[SNPSup]=1), IOMMUv2 page table cannot be used without
+	 * setting up IOMMUv1 page table.
+	 */
+	return amd_iommu_v2_present && !amd_iommu_snp_en;
 }
 EXPORT_SYMBOL(amd_iommu_v2_supported);
 
-- 
2.32.0

