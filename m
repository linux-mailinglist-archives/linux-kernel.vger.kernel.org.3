Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939CC555214
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377167AbiFVRMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377133AbiFVRMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:12:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58AFB48
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrDeQ+mRszS9JGFtrGcC7LQeTtMyMiPJvzUjEOHm+F430sxcHee6uqp3fwMB4jGwh3i3NuVnLxQGQWX+TjokyNCyipAouWyGG8OpdUXpthQ4w2Tc8KYY4UMrVH7Y4kkglDrhjYUali3z3ZwQHe+etrU1XS+bpQpeO95OpjiJBcH1vsK65CvBErnKpPXWooUJec37h8IS041VknNZCn3iYSEyZvMdjTmVe5FyJA1vEq87hFSbVpXpgKT6MHChvNTuUV70qLPBbsoJAd/aaBSfiB6Iz7IMhV2LAQOk4kIUV7tkrQr6DjV0NXYl3BK0AgyZDq5ALNkUa8L1SPr6pgHntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIGbfdOxw2SxUQd9xfOv8DA2my2O4uYPD2LCqkA/fyg=;
 b=YkQWrkLH46jujJ3yY2XEAzzpo3P86M/YeQe+jP5Yrw7I2akoLWhvr0vrUIafC74sW74XWAISPxtyPwsoHGNJazyINm8eHtSfem7o8BAwfsiTSrgYJEiaIkxmhB5/4xo5rWcOmVjYTuo+osj674/SThBRy9VmMa/yIoYuCXgthbHfJnG7kpNAU0MBvKe56zZXY94g1OqZuR6u1g8nIqI5pdoyvD+0mMJGdu7Gk9bOS3Te5nn6kri2XlOtNvXCKbTSku0qiyATjdcjXz3ohJbLJWMxdeZoM8P58HjmyIZ5VMoQEsc/G3sWkwlSn8UwTbAEufGG2YhSTzk1eucmQe1Uxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIGbfdOxw2SxUQd9xfOv8DA2my2O4uYPD2LCqkA/fyg=;
 b=2i3GaoNKmbmctMXR8qLM96O0xl1sy74Sh5Z+oW4vZ80Gw++qzcJzhL+0tfp43XDbaNvSt+ckl7W9rsFnSTFhdm1fu3yU9ift59OOTwVaEkIN4qN0DDnBB9fllIkjIFZGBgFZtnlHUN4Evny4mroKCd2xGiWFCTQT0CY6KizjgHU=
Received: from MWHPR08CA0054.namprd08.prod.outlook.com (2603:10b6:300:c0::28)
 by MWHPR1201MB0077.namprd12.prod.outlook.com (2603:10b6:301:55::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Wed, 22 Jun
 2022 17:12:35 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::fe) by MWHPR08CA0054.outlook.office365.com
 (2603:10b6:300:c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 22 Jun 2022 17:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Wed, 22 Jun 2022 17:12:35 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 12:12:32 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
        <vasant.hegde@amd.com>, <thomas.lendacky@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 1/7] iommu/amd: Warn when found inconsistency EFR mask
Date:   Wed, 22 Jun 2022 12:11:25 -0500
Message-ID: <20220622171131.11870-2-suravee.suthikulpanit@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e64dc68c-774a-4c0a-79c8-08da547266b5
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0077:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00777A4A5D4188AE78CA8545F3B29@MWHPR1201MB0077.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VX704cx8i7183xQhHru+OOrhkF1J4kz8wTSnpxzDftRCXYD++aTXaciZ+MwGmlxcWGT3djBQWH49qGh1IEqXCuRt1zYdcFmvQyz2+u6nlXbVU3U0gH5ttJtG5hLhq5UuI/CYxNRSgVYbyGSbHkiTzxohS9q2SsIVojwlFADsxUPqlgpmUUdhf23qdcLyp1XYEhN79C7hyAZLlMDq0XYc58zCCwKIpj0zJI9Isn4PSHRbh5U/Wnr2pNfM7Pm463PFEYepIwtZgV4IYWH2/7/8obIy2tTMej1jBheWVxE1hFe/g0MRh9RIGCs9zVyWlLlkhDV7bIK1uZKA7pFk8CVIzEnKVpKcIu5x8c9AB3B1qV8dxD5h1q7H5n7SYVWlsJUPRikFUNafbEybKEbOSnnXi9dNxoYiUefoBm2t/ofp9g2ajhIgrrwKT0TbMWitN+uDZzjwOjkxSMjjhbAy816uebbeyHjddoeAcg/xnd5S0T0cYLhnqGSiZ17HUJnD3qZU/zOXy7ioV1Bf2or+cjQiusOd3AgbCQubEUUfYRs4TurZogXkRhEGVmbDwy4IEBACdbHZWvnNUkR/XpIK3xSje16186Pu/CxJZXHtWtM0L6EgATSx4eygzNOPNiyWj5s6RZtEL8exoLJJAFj5KE76q+mbYMmHZ8gbBTQ0+CrFR/3cRNe/SjxXAecimDpJtlfZdtV6ynEk6hqJ7UFk5bmxpeFoTX3O0tEKfjYFKJ59gnNbGaqzRNzJuUN9TbdStPyrUwrXzeKfHD4xrK94YnPFuHb4LWDsAL2zOvjuAMb+NIQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(47076005)(70586007)(426003)(336012)(186003)(16526019)(1076003)(82310400005)(83380400001)(356005)(5660300002)(40480700001)(2906002)(4326008)(82740400003)(70206006)(2616005)(44832011)(86362001)(36860700001)(40460700003)(81166007)(26005)(478600001)(8676002)(110136005)(7696005)(41300700001)(36756003)(316002)(8936002)(6666004)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 17:12:35.0645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64dc68c-774a-4c0a-79c8-08da547266b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function check_feature_on_all_iommus() checks to ensure if an IOMMU
feature support bit is set on the Extended Feature Register (EFR).
Current logic iterates through all IOMMU, and returns false when it
found the first unset bit.

To provide more thorough checking, modify the logic to iterate through all
IOMMUs even when found that the bit is not set, and also throws a FW_BUG
warning if inconsistency is found.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3dd0f26039c7..b3e4551ce9dd 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -261,18 +261,29 @@ int amd_iommu_get_num_iommus(void)
 }
 
 #ifdef CONFIG_IRQ_REMAP
+/*
+ * Iterate through all the IOMMUs to verify if the specified
+ * EFR bitmask of IOMMU feature are set.
+ * Warn and return false if found inconsistency.
+ */
 static bool check_feature_on_all_iommus(u64 mask)
 {
 	bool ret = false;
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
-		ret = iommu_feature(iommu, mask);
-		if (!ret)
+		bool tmp = iommu_feature(iommu, mask);
+
+		if ((ret != tmp) &&
+		    !list_is_first(&iommu->list, &amd_iommu_list)) {
+			pr_err(FW_BUG "Found inconsistent EFR mask (%#llx) on iommu%d (%04x:%02x:%02x.%01x).\n",
+			       mask, iommu->index, iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
+			       PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
 			return false;
+		}
+		ret = tmp;
 	}
-
-	return true;
+	return ret;
 }
 #endif
 
-- 
2.32.0

