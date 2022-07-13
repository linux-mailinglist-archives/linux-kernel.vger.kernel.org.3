Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA736573FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiGMW5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGMW5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:57:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489494F692
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS15tt0oS+Zne4u3rDndzV18rv4XgJLZHjwaLIsonh9Fll84k2BT+WSc0Fb/UdU0rrv2y6g5J3L7qWV2eaxe5RCEH1f6QL8sE/Pyl699O1i+Rw8EFV+6VsHt+B4aXHj0kTiPKWwYo9dDaAI+VNG3pf2WlLBxCREB6FrgewMU1us+UiPrC7NixOmuUFEjGpnwmuvPbWwSa9tdA2ZXhe6tgHiSmcDE43ueJsGNHrjjb+Zr+YLqvJUSCuURnihnKiaKeK27v9bq0f/sEAYocSMgPQ1pXm5PwL8CcFSNaceebhmfkzeDbm7DXum0XmS77S4+/csU8E+MWmpZ3is2kYBbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQDBq+ur5O59ppetGIMbO3zp80DyEFaNsS6xpxsFtdM=;
 b=aZi+SmS1bg/dW37lT2LhOPtW7m24E5SR/iKBxJUjzkLiboJzB9UvRbQPn9rCPXxcdRr+UpN+uXLnRTPTzlWfRhDk7Gg3Z09MJBdbtV0id14D9QsOXedG/cEyLhHLTByQXXM5Kclfy0lL5NwpfiITkhFhs3PaNaTQb3IZaRvcvrMfpF88q3SZf0ixE+HOK5YvoccWexKHQ1F6Pj3+1kXxLJcCIiWK3OUYS7GzK4rmy7tCgnAjtOZqKPJasn/3OCJuDfpbnA6CrOu3nlIOjqt6Qeyv1ncYcQjDQM2LC2svTk/UZkMjKNDpvYAADiAOAaYGVfsXCB5EMOihnX8D0h1OKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQDBq+ur5O59ppetGIMbO3zp80DyEFaNsS6xpxsFtdM=;
 b=ymkyGyD3gKKNb9Uv1f3HWJSoSyE6lSlpkD7hIx+qZBl56mbhHRGlZBhohj/DC1WbDv4uQpQusIGQVJQiJNXWdiW0L6WxIygUOfdgvykIH+Y2gVLDL7NpkvCFc4XsrxG4qkqsKSdidxz98hMfP7HnAAw/16IqKXcGRWC8/BzaQSw=
Received: from BN8PR15CA0041.namprd15.prod.outlook.com (2603:10b6:408:80::18)
 by MN2PR12MB3184.namprd12.prod.outlook.com (2603:10b6:208:100::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 22:57:14 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::12) by BN8PR15CA0041.outlook.office365.com
 (2603:10b6:408:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Wed, 13 Jul 2022 22:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 22:57:14 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 17:57:12 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
        <ashish.kalra@amd.com>, <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 9/9] iommu/amd: Do not support IOMMUv2 APIs when SNP is enabled
Date:   Wed, 13 Jul 2022 17:56:51 -0500
Message-ID: <20220713225651.20758-10-suravee.suthikulpanit@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: af13f706-9968-4b0f-f019-08da65230751
X-MS-TrafficTypeDiagnostic: MN2PR12MB3184:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFkoTfQ+eDfHWOnVUDVcrjUutmQiuS7aRdg4m0F6XztbqW485vF9CYQh9iOnOUVYoQtuugwNnQti78FWSpxImsIo7KmlpFgrTaPLZNMQBiUIG8se06tZPcUQl0fMtnULKSYck1W2ceBi0BqUSuIYWdHaeJGjTmJADavhekHuj5SHQxAYsqTSn95tSFx5CAqBQuuvjOijVnZbM4nnevc5t8rbCO0mcha6mv5eHaPjHJk8tpeYyMwVcyb3M/HPy5T+sxcDaD9TJLmCzH1vg6AnDsSRPHFRdrsER6ED0bWXWivAbXrew1mN5VGkfSOIHebfSLhVOcNvtnQ8bGFzfimLtszAqiTzyHC/7B6rIluPnIA1K0/JI9Kw5NenvKh/hWek1asq8J6L97wYFdn0i4ce2e+o2XjuGfn6Fx5hefXtTf5PSJo2E22Rgk4mq4qR/bgzjtVMi7O6T0S17rhCPWd/ixHnzoIP3sGfOvydlOogrulkUD/4wsaJMnEqpLAg0xl6Vc4G4uJywLfAmQruacbJ5ZniSYOsB7zKxfJ0Zzu6lPl8XtElycIAcd+aiHbdQpctF63uB+fw0KGVIS1oxw2jwrprxstN8jvn7A0COVhZivsO5QYDi2zTWf3sPhfYVkTAIKVvvEkP+e5eii484ewHcJClzZeJzugjO+L/MSjLUlo85C8NpNs7lSVz+61Tdxw0HgwIM24/UGBujadSs+uwFlhbYrYX+hB2C4U7RGRWw71x7z8BxAihQCW/HpERS3RuPMShlm7BIG90qTEoV7PMnh3Dqm/WG/fzD8C07VldG0gfsIX/FQAybKyXnq/tYiiK9YBQZdNX08V8Ppspk5nutn6PmuVYNCdCAJ0UbXgQjgM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(40470700004)(46966006)(36840700001)(2616005)(70206006)(36860700001)(7696005)(36756003)(4744005)(2906002)(54906003)(6666004)(5660300002)(478600001)(316002)(8936002)(110136005)(26005)(4326008)(41300700001)(47076005)(82740400003)(70586007)(82310400005)(186003)(8676002)(44832011)(426003)(336012)(83380400001)(81166007)(1076003)(86362001)(40480700001)(40460700003)(356005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 22:57:14.6792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af13f706-9968-4b0f-f019-08da65230751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3184
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
index 959595c49656..2cfac23d34a6 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3455,7 +3455,12 @@ __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
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

