Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F6C573FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiGMW5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGMW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:57:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E814F67D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLb2dcz4z8lSR9bkA/kvx+W2FbIjPcmSLZScyKaUBluu2e5O5CO1+VREZvEzQIhdWGwxSlIrLyLDghHstyj1NSNmZl40F1c4T8FI+iTekIzzP0nJiDaJvnAPYpPdbdunYdfSjZ00l4DCJHrabH4ZptZqgD+FNksxFNXXlhu3ckPTkDq+Uf9RqRJif3dVD5Su2rSouMgnniLbvAg78eTvYROj2ir1jqDUHMOIdVvQ7Y46KYCz3Bf6dOD3rN0HK92ZxzcspQOhO6cAGyaOCx9okiB7DJ2EPF9bClnVNquEz9pbpgudwLJUZ4D2mvQzHyhJeOpn4wI2nf+G5UR2URkpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIFE5pldzlkvYqH8jFWXIpGjjVVrhptZNaIbUTfOyFo=;
 b=ffdSvEHscZ9vBLdwwE9kPVzrgAW3STPVlX9WLNwDqU+igpW5OdhBb6oi48FDhCIi3xHec0Sb0hm2s2iJxXg4ZFQNF81uJsaeAOu2SZ1Arm5V7YGN9ZDadN8XBGFL3WFNz0RlEaopCBeGRNssxvt+KAm5rLad5hOKpaE0RoZZViFpChZEEnvUzhZKHqcudT/ypa+yBaX/GZiC/YDFQUnJz5ia7pI/quK16W3Fv+1tJSU/51b8D0H/NkTNLZ2pxlY7/BPPpBge636Ad64Kjy3n04vTP8s1SUikKpnQszD2iC3QkIcy+LLUEK+9X6H9iVNvhRir1gKirj4SOUPPGNLG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIFE5pldzlkvYqH8jFWXIpGjjVVrhptZNaIbUTfOyFo=;
 b=cYQajuYjg7xaOiROCeBqd2RujscsBoPjC6ObxEoDyEs/6TdY+D1MXmCn5/FW8YFu4HiON/NTYkPeTrqWlo8JslHoOe6ZM81UVgARuDlMdiXk3WdX4Pq4IuXBTESSTe7OGqFhUQAc3HY6DqdIjbnWjamehx+xrHLuHUvN+W6tYtY=
Received: from BN9PR03CA0517.namprd03.prod.outlook.com (2603:10b6:408:131::12)
 by MN2PR12MB4030.namprd12.prod.outlook.com (2603:10b6:208:159::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 22:57:13 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::51) by BN9PR03CA0517.outlook.office365.com
 (2603:10b6:408:131::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13 via Frontend
 Transport; Wed, 13 Jul 2022 22:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 22:57:13 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 17:57:10 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
        <ashish.kalra@amd.com>, <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 5/9] iommu/amd: Globally detect SNP support
Date:   Wed, 13 Jul 2022 17:56:47 -0500
Message-ID: <20220713225651.20758-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
References: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5ad8e6b-92a8-4bcc-16e8-08da652306b4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4030:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IO0N7qSl0hBUJfzdrVYZADa3uSHnNZn0Mqa0rfZmGYcW4RbWUSyz1XLrSfMHPdESfvAYB32+DxuTNHoEJSUzyMWTb2leQKX4FSlvu/uTlV+DazySucp4sxkKhhV9+hx5DqBodciLtpNgla7sMhdmkLhqGJjy5UU4ruTqcVbyUPfNo/7h5y/4i1X/Cholxu3gPzQkuhZxVW7wJgkPFy4NWHKtnOSdI+8QV0MrOsCeKk7EWyd6Bu5m8EbNn4BFCkQPeZmkDfF8nlaCDE1dtrp9wxSU3wYO7dCZ2GFZV5IOsGEgr1JYmlkQ8/4oY+RzJIBM6SOoPdIbxp1GF/5yk+fvhtV3JFSe4QkAKE20UhOwQxMckBYWO+XZKoCmSqmX/lQiT+an8LHi/j8zGe5EbhMNWZcJU9qxjY1Wxqn+8TWP/beBxPakPVuEH3E5U0aMaW6pjkYnP80/kQLvYuOfRzSNYZrw5ssXK0tz7eoSAL0HkHS5iwPVGJJoLopnp3Y9EhYDTXechhrYrYpu40T8Youzrztedpw7p25aizzALio1TLLKPLyvGuawBQDijDo3tTAO9W+IhDMZhl2kN+mDrTANwKmg3lWKFFkqQvLSOn4erM7/4Q/492j9ZX1Wn4WbjO+pzB0RqUshWfAf4bptkeicceT4Es9IGWWEwPa1q6h5AyF2ujQKiHuXaqzyjtgI3HRQ3kEzJPUDwbQGDNEmhvkVm1BavWg4ECYzQwhbi83BPgJyymGI3sKwfZa/PRtEerC7/d4mn5TXFPB6lpVW5cG0Kr4IjJ4w4bzaL0IdsqwE3deVrQVvLYoceGaX5RLnNZ+8CvuNcno+TQFJl34rP6Zt0pU7WdBh1XiPEPq0auNf5NA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(36840700001)(40470700004)(6666004)(26005)(478600001)(7696005)(82310400005)(70206006)(70586007)(41300700001)(8676002)(86362001)(40460700003)(110136005)(54906003)(316002)(4326008)(81166007)(83380400001)(1076003)(36860700001)(2616005)(426003)(336012)(16526019)(47076005)(186003)(356005)(82740400003)(36756003)(40480700001)(8936002)(5660300002)(2906002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 22:57:13.6291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ad8e6b-92a8-4bcc-16e8-08da652306b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify existing SNP feature check to use the helper function
check_feature_on_all_iommus() to ensure consistency among all IOMMUs.
Also report IOMMU SNP support information for each IOMMU.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index a0f4b5bbd98c..2f338c8c3d10 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -389,7 +389,7 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 	u64 start = iommu_virt_to_phys((void *)iommu->cmd_sem);
 	u64 entry = start & PM_ADDR_MASK;
 
-	if (!iommu_feature(iommu, FEATURE_SNP))
+	if (!check_feature_on_all_iommus(FEATURE_SNP))
 		return;
 
 	/* Note:
@@ -804,7 +804,7 @@ static void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 	void *buf = (void *)__get_free_pages(gfp, order);
 
 	if (buf &&
-	    iommu_feature(iommu, FEATURE_SNP) &&
+	    check_feature_on_all_iommus(FEATURE_SNP) &&
 	    set_memory_4k((unsigned long)buf, (1 << order))) {
 		free_pages((unsigned long)buf, order);
 		buf = NULL;
@@ -2140,6 +2140,9 @@ static void print_iommu_info(void)
 			if (iommu->features & FEATURE_GAM_VAPIC)
 				pr_cont(" GA_vAPIC");
 
+			if (iommu->features & FEATURE_SNP)
+				pr_cont(" SNP");
+
 			pr_cont("\n");
 		}
 	}
-- 
2.32.0

