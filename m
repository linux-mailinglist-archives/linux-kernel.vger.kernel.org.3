Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D08858145D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiGZNo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbiGZNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:44:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A251FCD6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hy0enKK09e5BfSVbAsVk8v8ix++A6Zc7W/1m9NR4wkJ7BtduyOCc1Vw+KsAAyi95P+LkI97KyKG4JltoVtcTAXW4q9aW2uzJWSvnZ++aQzxBBhc4X+AiYabpHMGOKyhGWYoeu4ZNGzJlBSKfoIV1vKQ8nxQyJ4VV4RHeFqUNKbLxdATRO7f8Ayotu5KL/+W8qkrq8LXvwjn/sANP9D/jouj6fR6Z2EvhDhtKtKp/eIvPWQNb6pf7Cvh1Y5FYtSSo4Tv73NenAM+XCFIpC+y/GYh+gdyoebJIOrW+I8j9bEXwSYe4ojZ5tdxV0z7ehLaHFIc+1e7MD4pgo7m7WXhG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JewnuYvYkE+G1d5/s7qzbpzMIipsOKHs8rUG70UpspI=;
 b=IP5dccM+ZtTBiMsT1IzbnGsI/+ySz9BKLY3Jgt0ZAbKQ/j6RX+a6vmQXka/mnSXNLlx/00cLTisprgtkI40Mo6K/eS6hbrqNZT3tLDrvgBfYnVnjHMCtHTbgRQZsNkam7MNR9xt3ATB6oJzxHtDzFNkgTRTu4FeL3g0qywUt0YMGtvIne+mDrNlZat4usO03OoVoMbA+Ug+sjLDR7V3736OXppHiVWv+ur99ouzq7VmhCdUwazapd3yuIdTK0hOjAWEQ6BuNCxKiDDBXqr7qR6E2EKxuNGwkDizA5jWecH7LX+1khq0DAOFVjssvCBEsWbDb19uZAs2C6/wLLWwomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JewnuYvYkE+G1d5/s7qzbpzMIipsOKHs8rUG70UpspI=;
 b=H5hEtTAthGMNiEnYdsFbwaM1Q7gg/ahFZ3Lwt6NWWSmRMcB3BN7C5TXJkFLaItZ3qsq7dVse6K7KQCyYPIQn7XRGZ2k+hqZfzYrKVO+gfh1pYr6ojHy7adydvQY+e/bmT4etqPXEFEhnJ+TDiXVPxXOshZmRvcdWkU7n3EUu1vM=
Received: from MW4PR03CA0183.namprd03.prod.outlook.com (2603:10b6:303:b8::8)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 13:44:14 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::63) by MW4PR03CA0183.outlook.office365.com
 (2603:10b6:303:b8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Tue, 26 Jul 2022 13:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Tue, 26 Jul 2022 13:44:14 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 26 Jul
 2022 08:44:12 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <will@kernel.org>, <jsnitsel@redhat.com>,
        <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/2] iommu/amd: Add support for AVIC when SNP is enabled
Date:   Tue, 26 Jul 2022 08:43:48 -0500
Message-ID: <20220726134348.6438-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726134348.6438-1-suravee.suthikulpanit@amd.com>
References: <20220726134348.6438-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 200eba34-e695-4500-48b4-08da6f0cedcd
X-MS-TrafficTypeDiagnostic: BY5PR12MB4147:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIkYbY5ZkvuHsvToaHe8OETG3WjwQ4gK38HiF7kGBIsb0QcBAYG2yuflA5XCwfzzpZI2HAh5iF4B95SLRAIhEJy4AaQ2ntEoiMcCpDjfGc1hcLTotY1wdrFSpICH8ZFETWRWQAJbMOF+O5oj/muj8k6gpBYARhe3AUFVAmMcpkJut2YCmwymB59xwdcvFK/hKMMl4yAYuUynaOGg1ZQkSbqn2z6oG+TMnHKhN0BDGvQYmXF1eHN3b+h9D2Es59vD9elK5CBR68lSuGsKiYoK/CZj8lUIEuJi/vq7zUiXyIkAC11pyTRomqSbMdSu4P8L8MnjQPkkz2b9mlaAQvp/oOvoR3+hdmcQVUFwYW26cTrng7UX7lc6wmaQtl0AjmAeQB/wlvsUMmATasU6lwV7ByymR+Jru3ARlcWTyRz6GJfd745UcTDE+t0pfaQAkaNqoKN+xByzYG67IiWQXwEi2Oitxvbb24+vHWVIKEoXiIH9TfhNp/iv+WMQ0ELR4qUgdiQ2FNfyt+B/w8Z11J9KZKBTvNxMpGerDuu17GZdUYWj7XKfYLtdY2QOsVMpruvRwLeJkkwrLdy0tny8JFlhKIw5AXeNwWqEqG1BMTgnyZts6Sg5zdnzYnnt+n/Q/qN5M0VsxNyKdumht+LBZN75MN6y2ROYDz3cFWNIT1ACnn3fcmhZRr5uYk+BBiwKEsJbIHyeOgRC7S1NjheTmtXzDtbmZnfo6NQ7Z1EK41z9RTSbGENrQi5/HG6HzH246WTXGMxskl/e+EV9b1ez14r3klAj/mAmM958IiXtpxLec41sO0t4rrjFSz0mBqD9uMFRUL2st9HAQsEfpEyvQensS14mKV2d7bMCJGAHe/CrANSFR720HE9phn9fHD7rene9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(40470700004)(46966006)(6666004)(41300700001)(2906002)(7696005)(26005)(336012)(186003)(44832011)(5660300002)(40460700003)(86362001)(47076005)(426003)(16526019)(2616005)(83380400001)(1076003)(478600001)(8936002)(36860700001)(110136005)(36756003)(82310400005)(316002)(54906003)(8676002)(82740400003)(40480700001)(70206006)(70586007)(356005)(4326008)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 13:44:14.4259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 200eba34-e695-4500-48b4-08da6f0cedcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support AVIC on SNP-enabled system, The IOMMU driver needs to
check EFR2[SNPAVICSup] and enables the support by setting SNPAVICEn bit
in the IOMMU control register (MMIO offset 18h).

For detail, please see section "SEV-SNP Guest Virtual APIC Support" of the
AMD I/O Virtualization Technology (IOMMU) Specification.
(https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf)

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
 drivers/iommu/amd/init.c            | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3c1205ba636a..5b1019dab328 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -103,6 +103,12 @@
 #define FEATURE_GLXVAL_SHIFT	14
 #define FEATURE_GLXVAL_MASK	(0x03ULL << FEATURE_GLXVAL_SHIFT)
 
+/* Extended Feature 2 Bits */
+#define FEATURE_SNPAVICSUP_SHIFT	5
+#define FEATURE_SNPAVICSUP_MASK		(0x07ULL << FEATURE_SNPAVICSUP_SHIFT)
+#define FEATURE_SNPAVICSUP_GAM(x) \
+	((x & FEATURE_SNPAVICSUP_MASK) >> FEATURE_SNPAVICSUP_SHIFT == 0x1)
+
 /* Note:
  * The current driver only support 16-bit PASID.
  * Currently, hardware only implement upto 16-bit PASID
@@ -165,6 +171,7 @@
 #define CONTROL_GAINT_EN	29
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_SNPAVIC_EN	61
 
 #define CTRL_INV_TO_MASK	(7 << CONTROL_INV_TIMEOUT)
 #define CTRL_INV_TO_NONE	0
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 4cd94d716122..6bbaf6b971e8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2794,13 +2794,22 @@ static void enable_iommus_vapic(void)
 		return;
 	}
 
-	/* Enabling GAM support */
+	if (amd_iommu_snp_en &&
+	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
+		pr_warn("Force to disable Virtual APIC due to SNP\n");
+		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
+		return;
+	}
+
+	/* Enabling GAM and SNPAVIC support */
 	for_each_iommu(iommu) {
 		if (iommu_init_ga_log(iommu) ||
 		    iommu_ga_log_enable(iommu))
 			return;
 
 		iommu_feature_enable(iommu, CONTROL_GAM_EN);
+		if (amd_iommu_snp_en)
+			iommu_feature_enable(iommu, CONTROL_SNPAVIC_EN);
 	}
 
 	amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
-- 
2.34.1

