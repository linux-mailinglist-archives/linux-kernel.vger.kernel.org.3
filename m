Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030E0573FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiGMW5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGMW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:57:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8634F66B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5WswAMrEXbairbdvFW6cA3hAVEisPtkUIyU7DFjUNu7PbBxgWnjFpiQ6gTIFvXrkt0cGfQMakQ9Tl4SZnH4eho+mG865/l098wOVf4ytP9/zR4ESJM5Mw+asf9SyGlzLIemWUVBqRMWOv/gUhasMAI+l42rC/6CjNOgY5fMvwodtyJtRvmHknWKZF6HWpDvqDY6ML4eJ4Dt4vFq4ekLsyiE4cDkj4Vq58cj1SSSGhHLxyFZWTbzWLuajM2aemHnOpZJZMkhAksUshPzy2C2ziHxMXiwLG+nXbOZ4yB13F+WRPTnRIBXfKE5ClW2q37PGDs1lccCh0nZYyH+Vylh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK8oGJQC2CB92dtcgyWqjf5ak6vs82NvNiHrXHfnt7k=;
 b=hCFTHiszHP/KZxv51lzhBYXxEyzAOuH1tx1sFUu/TCr7xQ1MHfjP0LeqjXbL9Jki22CgTmaYAWod8JfSAu6LKYD3BYjDbY0DwAbgdynWP1XsO2f9+iDXp1wNLlACoT1yqoHQk/l7k2lewOgG2KTj0sgGLmmiILkQq9Z6dUKShHPT4DaJUuMrn3iyIsv4l9sLS3VA1vpe8nX3AHR56ilZycek7eTiQY8UUm89OT5/8WHlIW69rV8Nj7HQvr2GhOjkXKMdGyvOf9IkCqQxFn+7HK+RBeBPbZ8TxNoiZgtOPbgNtqOlDlDxEByXRBKkG/XaGpkOyfruWD8YzAddMf63ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK8oGJQC2CB92dtcgyWqjf5ak6vs82NvNiHrXHfnt7k=;
 b=ktl0NW+qGB191krtDA5rHqg8RBC9vhaWtU6TCqjG4V2M1DIrD3IqgLw3rFmaAl3YeTWBFEzSnmK84hohKdGZ2uUTGdw4n7iLl+WovBL2KT5rocCgWXGtZCRWfQ9yEL5SWb3VRuH5gkwTfyXBjVpJ8uAvnE0Xr2ihUV1xJrHvnAs=
Received: from BN9PR03CA0529.namprd03.prod.outlook.com (2603:10b6:408:131::24)
 by DM5PR12MB1580.namprd12.prod.outlook.com (2603:10b6:4:10::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 22:57:13 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::9d) by BN9PR03CA0529.outlook.office365.com
 (2603:10b6:408:131::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
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
 2022 17:57:08 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
        <ashish.kalra@amd.com>, <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 3/9] iommu/amd: Introduce global variable for storing common EFR and EFR2
Date:   Wed, 13 Jul 2022 17:56:45 -0500
Message-ID: <20220713225651.20758-4-suravee.suthikulpanit@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 38a6d26b-8c2c-4c14-5667-08da65230671
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+/QVp394EnZvpkVEtqt/CJ/i4rq3c6viR8zGjhj7Odjb3xhNmnP1hY3EPVxHvYYqX7gKWYWdkldiSPx+fnSUMG9liWqkcYlbBlTvnTHoxKgrzhV+V3JwNi5oXULKSao4cX+24Yy07vUjNY5k4Dz490ccI825uBIlPcx6kBVZ3EffzeZ3zweGfV3JAK3Fg273wzxcSkP0pc2e+rdZSAsnryLovufoFSnUiyGuu7nNR83Nowc82lwtFSwf+EThHv7w4BMaMS8thrALmt/OwiSK1HRFTMsW35Fzi8hLureth0gtd3kiO3LBIazJjub91shmDZnyr0vk/L3fLkK46dUY+cyVFMdB/sIzmqplwP7xhV2SrYKl0caeLaxhL0Za43FxUZiE4ke00Ecm9xvdw1FUqZ0m6CoBJGTfeyP/1uDxbWCm+OEVLZ7+h2n8JdMzF4pUjLX3MBxTDpusFqTdWHwdlNt1q5GKn8rcGouknLq/htEZHuFNvO4HuL2udTjM/YakupBZZFHHAxhgc6D7o57EnsslGVnnHdirBaR6V0t/X2uV34WeCb1pKw63i9KuJWIqTzukzY3FVGMdQi2Gpfk9A2oFZ6x83rbPaMXdvo+rWcEiLNfpKjJXgfnk0PRIUZgfnfpxnGBc2qMIZphA0IGmFK4DXJFmTpP0a3QNfGOeAGpiu1/PWjDlnhFnC/iBFfX1yTIaQuSy2SbuQV4l1fyBRtAzGv39o8eNV5RotcF5R58vKP3QjVi3CrJAgQMqHGktLhNUh/gDEd32yvKPj9OyfwbjaSBIH/Yf/0lSEPkvtnCT3qqZS6ZA2M+YKqNlyk0uXggNNNQFF+/Lo0S1XhossoRXFoBxFpcJGe4mhV9Iso=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(40470700004)(36840700001)(46966006)(44832011)(6666004)(16526019)(86362001)(186003)(1076003)(82310400005)(5660300002)(478600001)(8936002)(40460700003)(36860700001)(110136005)(2616005)(70206006)(36756003)(7696005)(40480700001)(316002)(4326008)(2906002)(82740400003)(336012)(426003)(47076005)(54906003)(356005)(41300700001)(8676002)(70586007)(26005)(83380400001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 22:57:13.2073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a6d26b-8c2c-4c14-5667-08da65230671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some IOMMU features require that all IOMMUs must support the feature,
which is determined by checking the support bit in the Extended Feature
Register 1 and 2 (EFR/EFR2) on all IOMMUs. This check is done by the
function check_feature_on_all_iommus(), which iterates through all
IOMMUs everytime it is called.

Instead, introduce a global variable to store common EFR/EFR2 among all
IOMMUs. In case of inconsistent EFR/EFR2 masks are detected on an IOMMU,
a FW_BUG warning is reported.

Suggested-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 +++
 drivers/iommu/amd/init.c      | 45 ++++++++++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 9b7092182ca7..1b945d47741c 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -137,4 +137,7 @@ static inline void amd_iommu_apply_ivrs_quirks(void) { }
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
 extern struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
+
+extern u64 amd_iommu_efr;
+extern u64 amd_iommu_efr2;
 #endif
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 92ab02f6c5dc..741fee1abfc4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -164,6 +164,10 @@ static bool amd_iommu_disabled __initdata;
 static bool amd_iommu_force_enable __initdata;
 static int amd_iommu_target_ivhd_type;
 
+/* Global EFR and EFR2 registers */
+u64 amd_iommu_efr;
+u64 amd_iommu_efr2;
+
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
@@ -259,21 +263,46 @@ int amd_iommu_get_num_iommus(void)
 	return amd_iommus_present;
 }
 
-#ifdef CONFIG_IRQ_REMAP
-static bool check_feature_on_all_iommus(u64 mask)
+/*
+ * Iterate through all the IOMMUs to get common EFR
+ * masks among all IOMMUs and warn if found inconsistency.
+ */
+static void get_global_efr(void)
 {
-	bool ret = false;
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
-		ret = iommu_feature(iommu, mask);
-		if (!ret)
-			return false;
+		u64 tmp = iommu->features;
+		u64 tmp2 = iommu->features2;
+
+		if (list_is_first(&iommu->list, &amd_iommu_list)) {
+			amd_iommu_efr = tmp;
+			amd_iommu_efr2 = tmp2;
+			continue;
+		}
+
+		if (amd_iommu_efr == tmp &&
+		    amd_iommu_efr2 == tmp2)
+			continue;
+
+		pr_err(FW_BUG
+		       "Found inconsistent EFR/EFR2 %#llx,%#llx (global %#llx,%#llx) on iommu%d (%04x:%02x:%02x.%01x).\n",
+		       tmp, tmp2, amd_iommu_efr, amd_iommu_efr2,
+		       iommu->index, iommu->pci_seg->id,
+		       PCI_BUS_NUM(iommu->devid), PCI_SLOT(iommu->devid),
+		       PCI_FUNC(iommu->devid));
+
+		amd_iommu_efr &= tmp;
+		amd_iommu_efr2 &= tmp2;
 	}
 
-	return true;
+	pr_info("Using global IVHD EFR:%#llx, EFR2:%#llx\n", amd_iommu_efr, amd_iommu_efr2);
+}
+
+static bool check_feature_on_all_iommus(u64 mask)
+{
+	return !!(amd_iommu_efr & mask);
 }
-#endif
 
 /*
  * For IVHD type 0x11/0x40, EFR is also available via IVHD.
-- 
2.32.0

