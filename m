Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393A3581460
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbiGZNoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbiGZNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:44:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E461F2EA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw7DQnJX1jjEzyYZy4NM9CU9Wc4zTcXUjbIXfyJLwmME8C8TOz/etCzxH9+1qy4hg8yYYRJ/JbusCEwmQlRKhwpOUws+MugyCzuB5dt6VJV3CC85u3LQ9Tzm40x6YUr6fzWdgMXam3CBOnG4QugAgHJu7z5wBzCiCw+DvPQOd810jOc4RZ1JqD3Ygu4Tc/FhojfOjXaUQDzk6GzU2Xs4AI71H3lLCxabZWpPvIhTmTZG8h1pPFMEQ5iYrWA5sXwxCMCWGDXOqeXpdVPCFDyCJaQxUZ59a1/Q7jW1uQ+mpEi3wgTTfHQgSJqnje/7cgjyNkrNFfzVNL9ivLTWCOiKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pvtjB5E5Wn0Em+4gJKN7YBwHfcjrAOHNdv6qXT7ZI0=;
 b=R68kXfp00H8vraQ819TbKyXjJuO3qXuvb3RtSgLWrU3+VphNP4rpdQeE5HP+c6hJYbDvJAeXmTTtLWrPB0TlIkZXWJclKDjINlv0dYCUWBXuil6vIdzCZUJVJp6rvBEEpnZGHPKbE8ACwZODbVmGaWJqr78r8QW+d4L6C0H3SzmmNnFn8XwJiWUR4Gu6kAyW0Y3ZF2gbdfRatk+9SXhphKAvHfQ4VhzaEjBFMEeK9c4c2tQzNWCqXBp04p3IV84Bq1pKJuKqXgA5j8F6/huRFWpH9GenMjWZMfNvLkAEsnqi3k4jQGEPNVC3NFb86xL+A9Z7KQZ35q8VGGwdyyoP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pvtjB5E5Wn0Em+4gJKN7YBwHfcjrAOHNdv6qXT7ZI0=;
 b=GUU8Ax6ekp5JEM5WkY/uwrYZNsB9cBGOKLKhFSd21vNMQgw/eWYqeyhh2LLY7sNzxAQLVA/4x+uHIGND4o/k9pU0nvgqkZmwWo3kAg68MgScoNB99230NxParbaA23sFvXyXBK+n5rATjqYBc+GfXRr7Gln8aVkUKSzi8N1/El0=
Received: from MW4PR03CA0183.namprd03.prod.outlook.com (2603:10b6:303:b8::8)
 by CY4PR1201MB2517.namprd12.prod.outlook.com (2603:10b6:903:da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Tue, 26 Jul
 2022 13:44:14 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::ec) by MW4PR03CA0183.outlook.office365.com
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
 15.20.5458.17 via Frontend Transport; Tue, 26 Jul 2022 13:44:13 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 26 Jul
 2022 08:44:11 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <will@kernel.org>, <jsnitsel@redhat.com>,
        <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 1/2] iommu/amd: Simplify and Consolidate Virtual APIC (AVIC) Enablement
Date:   Tue, 26 Jul 2022 08:43:47 -0500
Message-ID: <20220726134348.6438-2-suravee.suthikulpanit@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f2471759-cbea-43f0-ec58-08da6f0ced6d
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2517:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yC3eKPqgDaU+H5UJf2D1nmfzzKJo+vB2OuY4l0W7nJWN4dbjQ8unbm32iz/9+fyNaNywey/P5YEzofNoF/bIl450OmeDXIe/SnWUW6rQ4+i8NMfy0vVId3oO//Zz9XFO1aDPUbfl0p6dSaVkj3YbPePadpWG3ogcO0/AXUV6Ss5xNOQAgz2fcbtGWrjsWtvqbwmkomPbnvZgFFMKsq9Pxcmw+THxaVG9yT0mncNQqlZrFYKmKY/2TWq3KON2ErhyrA7EQpfkIcy0cj5o1POxTI5J/oCEdq2TGx4d3Dl3LNb72zRSpkhUkrcQd39dgL2juXXthGlfG9+HaXPXWgWnbTf1y7s3R/ybJFOHq7ZW/+fojaq6+rf4KfgdIaaXZMET1fhB6Pqpdlq2uQ1YVG8kH89Lglh3RdYnEl5kCwUH+P7FqXj2V64DN+y8vpl8QhQYNENAr6H8xbmEB/HXUKHdGxa5vUmZida67QNZeOYdvgBX+kMj1BnPoUYQwFQbDM8O7SyPGBhHcwUoAqcfJWmvUsnobA/VZlD+YCGn6ygcxEuB3yhtMoK+rIIDq+99jq3t2Es2Y0dm5778gqoEjNSNi40awXLZCTOWU+Zl8tvcBv5FZsCcPJV80EtGpq4G4msIQzkhD3vf5X5JyPvq+MOCimrwpTBUkgAu1M4aszdRhF5dMoC/6bwV+Dwl6jHuNgzowduP/TgFl1bplVQQzmuRK0p/bU1fR4VacBNgZ+8gv3PnI9yY2BRpvs5g3Ssz52YbOiynGkLVsNzzljZcFA9Dt7dCiywfG2ZuoIDYbuKU/uokpYASd3RQosTS5aOG1opOqNCmJww5ENolo+AhZAVThQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(40470700004)(36840700001)(82740400003)(356005)(8936002)(45080400002)(47076005)(426003)(336012)(41300700001)(36756003)(83380400001)(6666004)(86362001)(5660300002)(16526019)(186003)(54906003)(478600001)(110136005)(4326008)(70586007)(1076003)(8676002)(70206006)(40460700003)(82310400005)(2616005)(36860700001)(7696005)(40480700001)(81166007)(44832011)(26005)(2906002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 13:44:13.8166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2471759-cbea-43f0-ec58-08da6f0ced6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, enabling AVIC requires individually detect and enable GAM and
GALOG features on each IOMMU, which is difficult to keep track on
multi-IOMMU system, where the features needs to be enabled system-wide.

In addition, these features do not need to be enabled in early stage. 
It can be delayed until after amd_iommu_init_pci().

Therefore, consolidate logic for detecting and enabling IOMMU GAM and
GALOG features into a helper function, enable_iommus_vapic(), which uses
the check_feature_on_all_iommus() helper function to ensure system-wide
support of the features before enabling them, and postpone until after
amd_iommu_init_pci().

The new function also check and clean up feature enablement residue from
previous boot (e.g. in case of booting into kdump kernel), which triggers
a WARN_ON (shown below) introduced by the commit a8d4a37d1bb9 ("iommu/amd:
Restore GA log/tail pointer on host resume") in iommu_ga_log_enable().

[    7.731955] ------------[ cut here ]------------
[    7.736575] WARNING: CPU: 0 PID: 1 at drivers/iommu/amd/init.c:829 iommu_ga_log_enable.isra.0+0x16f/0x190
[    7.746135] Modules linked in:
[    7.749193] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        --------  ---  5.19.0-0.rc7.53.eln120.x86_64 #1
[    7.759706] Hardware name: Dell Inc. PowerEdge R7525/04D5GJ, BIOS 2.1.6 03/09/2021
[    7.767274] RIP: 0010:iommu_ga_log_enable.isra.0+0x16f/0x190
[    7.772931] Code: 20 20 00 00 8b 00 f6 c4 01 74 da 48 8b 44 24 08 65 48 2b 04 25 28 00 00 00 75 13 48 83 c4 10 5b 5d e9 f5 00 72 00 0f 0b eb e1 <0f> 0b eb dd e8 f8 66 42 00 48 8b 15 f1 85 53 01 e9 29 ff ff ff 48
[    7.791679] RSP: 0018:ffffc90000107d20 EFLAGS: 00010206
[    7.796905] RAX: ffffc90000780000 RBX: 0000000000000100 RCX: ffffc90000780000
[    7.804038] RDX: 0000000000000001 RSI: ffffc90000780000 RDI: ffff8880451f9800
[    7.811170] RBP: ffff8880451f9800 R08: ffffffffffffffff R09: 0000000000000000
[    7.818303] R10: 0000000000000000 R11: 0000000000000000 R12: 0008000000000000
[    7.825435] R13: ffff8880462ea900 R14: 0000000000000021 R15: 0000000000000000
[    7.832572] FS:  0000000000000000(0000) GS:ffff888054a00000(0000) knlGS:0000000000000000
[    7.840657] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.846400] CR2: ffff888054dff000 CR3: 0000000053210000 CR4: 0000000000350eb0
[    7.853533] Call Trace:
[    7.855979]  <TASK>
[    7.858085]  amd_iommu_enable_interrupts+0x180/0x270
[    7.863051]  ? iommu_setup+0x271/0x271
[    7.866803]  state_next+0x197/0x2c0
[    7.870295]  ? iommu_setup+0x271/0x271
[    7.874049]  iommu_go_to_state+0x24/0x2c
[    7.877976]  amd_iommu_init+0xf/0x29
[    7.881554]  pci_iommu_init+0xe/0x36
[    7.885133]  do_one_initcall+0x44/0x200
[    7.888975]  do_initcalls+0xc8/0xe1
[    7.892466]  kernel_init_freeable+0x14c/0x199
[    7.896826]  ? rest_init+0xd0/0xd0
[    7.900231]  kernel_init+0x16/0x130
[    7.903723]  ret_from_fork+0x22/0x30
[    7.907306]  </TASK>
[    7.909497] ---[ end trace 0000000000000000 ]---

Fixes: commit a8d4a37d1bb9 ("iommu/amd: Restore GA log/tail pointer on host resume")
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Will Deacon <will@kernel.org> (maintainer:IOMMU DRIVERS)
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 85 ++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d86496114ca5..4cd94d716122 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -908,11 +908,6 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 	if (!iommu->ga_log)
 		return -EINVAL;
 
-	/* Check if already running */
-	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
-	if (WARN_ON(status & (MMIO_STATUS_GALOG_RUN_MASK)))
-		return 0;
-
 	entry = iommu_virt_to_phys(iommu->ga_log) | GA_LOG_SIZE_512;
 	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_BASE_OFFSET,
 		    &entry, sizeof(entry));
@@ -2068,10 +2063,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (iommu_feature(iommu, FEATURE_PPR) && alloc_ppr_log(iommu))
 		return -ENOMEM;
 
-	ret = iommu_init_ga_log(iommu);
-	if (ret)
-		return ret;
-
 	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
 		pr_info("Using strict mode due to virtualization\n");
 		iommu_set_dma_strict();
@@ -2155,8 +2146,6 @@ static void print_iommu_info(void)
 	}
 	if (irq_remapping_enabled) {
 		pr_info("Interrupt remapping enabled\n");
-		if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
-			pr_info("Virtual APIC enabled\n");
 		if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
 			pr_info("X2APIC enabled\n");
 	}
@@ -2446,9 +2435,6 @@ static int iommu_init_irq(struct amd_iommu *iommu)
 
 	if (iommu->ppr_log != NULL)
 		iommu_feature_enable(iommu, CONTROL_PPRINT_EN);
-
-	iommu_ga_log_enable(iommu);
-
 	return 0;
 }
 
@@ -2678,8 +2664,6 @@ static void iommu_enable_ga(struct amd_iommu *iommu)
 #ifdef CONFIG_IRQ_REMAP
 	switch (amd_iommu_guest_ir) {
 	case AMD_IOMMU_GUEST_IR_VAPIC:
-		iommu_feature_enable(iommu, CONTROL_GAM_EN);
-		fallthrough;
 	case AMD_IOMMU_GUEST_IR_LEGACY_GA:
 		iommu_feature_enable(iommu, CONTROL_GA_EN);
 		iommu->irte_ops = &irte_128_ops;
@@ -2759,19 +2743,6 @@ static void early_enable_iommus(void)
 			iommu_flush_all_caches(iommu);
 		}
 	}
-
-#ifdef CONFIG_IRQ_REMAP
-	/*
-	 * Note: We have already checked GASup from IVRS table.
-	 *       Now, we need to make sure that GAMSup is set.
-	 */
-	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
-	    !check_feature_on_all_iommus(FEATURE_GAM_VAPIC))
-		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
-
-	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
-		amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
-#endif
 }
 
 static void enable_iommus_v2(void)
@@ -2784,10 +2755,63 @@ static void enable_iommus_v2(void)
 	}
 }
 
+static void enable_iommus_vapic(void)
+{
+#ifdef CONFIG_IRQ_REMAP
+	u32 status, i;
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu) {
+		/*
+		 * Disable GALog if already running. It could have been enabled
+		 * in the previous boot before kdump.
+		 */
+		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+		if (!(status & MMIO_STATUS_GALOG_RUN_MASK))
+			continue;
+
+		iommu_feature_disable(iommu, CONTROL_GALOG_EN);
+		iommu_feature_disable(iommu, CONTROL_GAINT_EN);
+
+		/*
+		 * Need to set and poll check the GALOGRun bit to zero before
+		 * we can set/ modify GA Log registers safely.
+		 */
+		for (i = 0; i < LOOP_TIMEOUT; ++i) {
+			status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+			if (!(status & MMIO_STATUS_GALOG_RUN_MASK))
+				break;
+			udelay(10);
+		}
+
+		if (WARN_ON(i >= LOOP_TIMEOUT))
+			return;
+	}
+
+	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
+	    !check_feature_on_all_iommus(FEATURE_GAM_VAPIC)) {
+		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
+		return;
+	}
+
+	/* Enabling GAM support */
+	for_each_iommu(iommu) {
+		if (iommu_init_ga_log(iommu) ||
+		    iommu_ga_log_enable(iommu))
+			return;
+
+		iommu_feature_enable(iommu, CONTROL_GAM_EN);
+	}
+
+	amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
+	pr_info("Virtual APIC enabled\n");
+#endif
+}
+
 static void enable_iommus(void)
 {
 	early_enable_iommus();
-
+	enable_iommus_vapic();
 	enable_iommus_v2();
 }
 
@@ -3126,6 +3150,7 @@ static int __init state_next(void)
 		register_syscore_ops(&amd_iommu_syscore_ops);
 		ret = amd_iommu_init_pci();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
+		enable_iommus_vapic();
 		enable_iommus_v2();
 		break;
 	case IOMMU_PCI_INIT:
-- 
2.34.1

