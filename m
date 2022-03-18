Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3922D4DE407
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbiCRWcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiCRWcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:32:23 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2063.outbound.protection.outlook.com [40.107.100.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0937D2EAF7B;
        Fri, 18 Mar 2022 15:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrIeNhk/zE7UKfP0WIlU+r+fHmoqMOk3FGdjZ9bGb3/9stEH4ldEZSyz8pGcCTtn31pSdd+uM1Cwou9W+z2ewtvoxQFNuo13pgFCvN99cr7y/HiQSwD9D7Xin2qm2FC9vL9cIoch61H0Nna16BpuFzI3q0JMjKV5zwwdGyjN7jSob/CEjBOlL+nDJGQMrp6NFb4rtmcoh6QdukXVyQR7kwSRKYcBrjSqBU23hOPnyAKL26Efz1A9HXiv0vpZeA+K7fdNaGonDj40dwWaVVRzpmjBxlZevDkSMAs2OGNey0LT+qjYLwj9rOy7y1/i683wSH95mOMOoRra+U8jebHRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5femNBHgTftfUNlc/sjCmOWiu++IMOrbHTv2AxnBvQ=;
 b=ZeX7iGsD/K1JsHqtp5N5yTORC1uRirwOpNTotdwyYDh7FxqULGPqN0S3Blt7QF/0kFNErGUeyx9q4iEWp7UthG7QVkI0VkpvIWc4X/xQQXtycUQddgXTlVEywQWjk9UfXP7j7u4a5mRh+3ZjyI9GwJCirt2hAuGy5DXhcaJdVGmVUiAPW3++Iotxs8r/iEcFleE68/59ppEFMuNd7OrXLZ9CTQae9a6caNoMIFcSLLfqSG4xdOxFphj13bK6mO7iqdC8Pth2uXks1YFK4hqDku7ckma8f7JLgnNAJZ5ux0b4zg1DZy1y8GpskeY5397XkkQaq1pyjpLi+Mp6fGTX1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5femNBHgTftfUNlc/sjCmOWiu++IMOrbHTv2AxnBvQ=;
 b=S0QIkl3/lCBeWCG+u5MRhdKdOO1BSZfcxfEfn/Xk+Jd7lnzXz/0SR4TCvKhciTh7H+2P5Ry+DT0hdib5Nh03kqmcL0/vqC5sqJ4NbqfcYgP4nAjMM4/A/vsZnbqAkw4YTbEOM9ugiCXjKBWKNQ5sZmHEI/pji5RUGnbO7HXZF4s=
Received: from DM5PR13CA0004.namprd13.prod.outlook.com (2603:10b6:3:23::14) by
 BL0PR12MB4754.namprd12.prod.outlook.com (2603:10b6:208:8e::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Fri, 18 Mar 2022 22:30:59 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::ed) by DM5PR13CA0004.outlook.office365.com
 (2603:10b6:3:23::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7 via Frontend
 Transport; Fri, 18 Mar 2022 22:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 22:30:59 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 17:30:58 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Will Deacon <will@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] iommu/amd: Add support to indicate whether DMA remap support is enabled
Date:   Fri, 18 Mar 2022 17:31:04 -0500
Message-ID: <20220318223104.7049-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b080306-ead4-4a78-2248-08da092efa04
X-MS-TrafficTypeDiagnostic: BL0PR12MB4754:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4754B7E3A65EDD3C7960222AE2139@BL0PR12MB4754.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NVXdOrBRnkMwWVERJJFs68W75Yg7ebfZNVMk/YMxC7X2eeGPVcl42P1f1Sbd4KDzDfV1CFAGcW5jIQcfuYD9lW+sglMGLMY4NHBnMhSyz/Babvgu2pX8Lc2fl/PGDiYE30mtwJvfh8SuIGA5YTVJtTDq2S0w2/aB6mVrJ/5lU3x610qI2/lPFQqhFmm6fdOS0Cf+fTVRgr33kbKkGIVn5nlEgNlI9iLC2dp1lJdGg2FOQPmbrC9B0RP77q+uFwiiSC3/Px2pClbBTbaGnACrKSoR7/JRggI6D1opIEVo+vPEAGoOZ7f0hcLy0v3ljUYta33UCXZwv38J+9ZPqKK0F0p8M0AzDNaXXL8w6JgKelZG0gvetp6x35iu1PD2G81WUI1q3Dcah9GhxdshY9+FrqwWxslhRBnNrM6oehmSIRyrpVa18leBObfQl3E65tZiYpxgUyhEO1aS92kYIRMFsD83Jb/TrpSs9DjaVpU+TjlxBQrOdbi26ypaZVE9cK7A5lq/awevgzu4uvMOc4V3G3bA3zEpkmlJSSLCZlxcpmXgEwL90HZa5f2Qoe+vk6UAQJLtNAZfuPSBrIYSS/jNiLFA5uhRlOB1rb30mZ5e00cHszx7/2SsLK+mhstbzGcBTEDGlYUXpD9HJCocJN8QAF8upFce+C55MroHHLHXJSWf0qwXg15Mz5m3CXEsZKWhYo7RRC3oFqHBqVs6nTt4Kqky0fTIry9l3lbDbMaFr3gSBWzas0LtYK1ysR6Ov2XBxK25T0T9zaNkBgokBmaWD7Mmv/k/gCg/YKAeyc3XLSpqV0n5fSNbmqnmwY9KkqqTYi53+i7FPHQhJQBVMEpDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(82310400004)(54906003)(110136005)(7416002)(2906002)(44832011)(5660300002)(8936002)(356005)(86362001)(70206006)(70586007)(4326008)(36756003)(8676002)(186003)(26005)(6666004)(40460700003)(16526019)(47076005)(426003)(336012)(36860700001)(508600001)(7696005)(81166007)(83380400001)(966005)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 22:30:59.2973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b080306-ead4-4a78-2248-08da092efa04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4754
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit 1 of the IVFS IVInfo field indicates that IOMMU has been used for
pre-boot DMA protection.

Export this capability to allow other places in the kernel to be able to
check for it on AMD systems.

Cc: Robin Murphy <robin.murphy@arm.com>
Link: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v1->v2:
 * Rebase on top of Robin Murphy's patch series to add generic interface
   https://lore.kernel.org/linux-usb/cover.1647624084.git.robin.murphy@arm.com/T/#t
 * Drop changes to Thunderbolt driver

Robin,
If your patch series revs again, and this looks good suggest to just roll it into
your series as a 3rd patch.

 drivers/iommu/amd/amd_iommu_types.h | 4 ++++
 drivers/iommu/amd/init.c            | 3 +++
 drivers/iommu/amd/iommu.c           | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 47108ed44fbb..72d0f5e2f651 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -407,6 +407,7 @@
 /* IOMMU IVINFO */
 #define IOMMU_IVINFO_OFFSET     36
 #define IOMMU_IVINFO_EFRSUP     BIT(0)
+#define IOMMU_IVINFO_DMA_REMAP  BIT(1)
 
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
 #define IOMMU_FEAT_GASUP_SHIFT	6
@@ -449,6 +450,9 @@ extern struct irq_remap_table **irq_lookup_table;
 /* Interrupt remapping feature used? */
 extern bool amd_iommu_irq_remap;
 
+/* IVRS indicates that pre-boot remapping was enabled */
+extern bool amdr_ivrs_remap_support;
+
 /* kmem_cache to get tables with 128 byte alignement */
 extern struct kmem_cache *amd_iommu_irq_cache;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7bfe37e52e21..fc12ead49a03 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -182,6 +182,7 @@ u32 amd_iommu_max_pasid __read_mostly = ~0;
 
 bool amd_iommu_v2_present __read_mostly;
 static bool amd_iommu_pc_present __read_mostly;
+bool amdr_ivrs_remap_support __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
@@ -326,6 +327,8 @@ static void __init early_iommu_features_init(struct amd_iommu *iommu,
 {
 	if (amd_iommu_ivinfo & IOMMU_IVINFO_EFRSUP)
 		iommu->features = h->efr_reg;
+	if (amd_iommu_ivinfo & IOMMU_IVINFO_DMA_REMAP)
+		amdr_ivrs_remap_support = true;
 }
 
 /* Access to l1 and l2 indexed register spaces */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a18b549951bb..e4b4dad027f7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2162,6 +2162,8 @@ static bool amd_iommu_capable(enum iommu_cap cap)
 		return (irq_remapping_enabled == 1);
 	case IOMMU_CAP_NOEXEC:
 		return false;
+	case IOMMU_CAP_PRE_BOOT_PROTECTION:
+		return amdr_ivrs_remap_support;
 	default:
 		break;
 	}
-- 
2.34.1

