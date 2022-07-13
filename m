Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00729573FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiGMW5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiGMW5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:57:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B774A4F67D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSPqBZh3AMGJiH1Gt71YntKHFoQ3ZqgaCpkvi72Loz99MZRULAXi+YLKYnMN+0SnGCc2yBgXOAw60mAbQmVzHO17sAzMhaAfiekqjTOxWN+x+WaDQQOzQBpfM7FPqa9BDvVYwGNqZlc3K0QlnGooYgDAtVCHB5u1DvYwBPE/NXMvGi2bZV+J0LUA5aiZq5ZfQkDB4qgQ2NAkpFzGeZ4rWf0RBXq5NHC5SbhmrWaMm5Ryausfmb3tzD5mQFv0iJWxgqnXw36Bj4Xu9E9m5qg17/eCrOorq7XF2A9f7Q9BitmbqLfo+52W/Ntx3oee46tS8dU5m9W9PdWHMi+PgUAnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMmaodeeYOU19ZQMobrkPmzoCRGFrZnR9tmo+HdJutw=;
 b=m+9khCc7KFXT+FUiAHN2r/HTIU9BfjPDVUG8OdkV6M8UioNIkVtp9fgB6XAvfIogb5xXnKtJMPFAv5StEA/l2SLIszl3aJNsvOk97js9GwEucVGCNbd0EnPbeo/MJjh1hEHnn7CXHh4tjSCoHQ2NfL2usT5XRjYdAWvoQpCW/hcFanUW7mnkbv7wAlWKQ4x5tJSY00GWG6zVN6rwXtDoDqSNdnSDGH7JYVbDuNbaJg4velMt+yLvLxXhy8eXNjM0T7xLfCWjSpF2EmbqPiFILnxjuaOXCeLQ+Yi+G0d8cHD6Ei7z0X/+MJ32RgnK1QY6wz4PYLx0ujkfKcdcFQ7NUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMmaodeeYOU19ZQMobrkPmzoCRGFrZnR9tmo+HdJutw=;
 b=JpfRWDasc1Jb9OfabOHUsMRaiVp5YZ7a3qZhEOpiRQ1y/yxKWN5aM/SsKCLqXP6/yDSJRxAkPS1jX7L6K0nS0HSjBW7+r4ZPpGugeYEJ9DEIbfNEAzMUJGwZdqfSBuDUkTuvweid2rqheyqAKJ1+Gv2e8UKV+5HJ7ntFg5Zqsi0=
Received: from BN8PR15CA0065.namprd15.prod.outlook.com (2603:10b6:408:80::42)
 by BL0PR12MB2385.namprd12.prod.outlook.com (2603:10b6:207:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 22:57:14 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::36) by BN8PR15CA0065.outlook.office365.com
 (2603:10b6:408:80::42) with Microsoft SMTP Server (version=TLS1_2,
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
 2022 17:57:11 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
        <ashish.kalra@amd.com>, <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 7/9] iommu/amd: Set translation valid bit only when IO page tables are in use
Date:   Wed, 13 Jul 2022 17:56:49 -0500
Message-ID: <20220713225651.20758-8-suravee.suthikulpanit@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb0ec7a5-8182-456b-91d5-08da65230711
X-MS-TrafficTypeDiagnostic: BL0PR12MB2385:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weCMUBrRDgUk6eBjMSSTU+xmT9qjLUJSZd7o/zBBtna5zExV1sq9Q5XcCZHvfnDVdwT2VC5d58bkMgQUXfXbvEGrr0W0Tk80JwR97MV1y9gI4aniwFZxlHWAnttYSNrk9N36pN9H0eRqELCLtK3sefp1sz5ADA7jpNOdhwxphcnsRgWFeLzxqJwx02uCIvh6znLkUlvBR+rxTi/CegvDJaMWfAq3MEhYx0mdg4Lat65Gwb1zsP6QpiIf4rEEYSv0gNEJLBYSXrmhg5EhF6Xi8AhK/hvfjvzE6Gmu1DJEGdYf09nSn+oB1Pgza0iVV09FPal9dDrRbLhngPiCXLY0EEi2XL0gvvXVlv8PjCtzknBlh0wn3ozinvN0IllsEndb/g5zgqZ93JKUXsoJuvPMdHZ/WKuLf5z3jBp0bup2vGMdJ/rWW36GH1oGbSQsQN4kyxsZQRdDVjrrg5fM1z3TBc7GTqbY3TxuoPrnGXC6zFkpC5sTgyim/PGAltntLnsj1i6amTjZdj+PZTSl0UelUPkaK1ARlSeKGoUNvwSMKx7gyPVSACiCRjHaH3ujtOk1Kxe3bF+cY2lnBMIzjBqVCr2Jn+Ielveem5MGTyn+GUEfYuXmHtqeunwggVF0QEf8Zprk7XP+0hDP3iRlv+iHMWyGRKBLQywIGn6gCADrY0IHTNMJ2XmnvTGGm39URCKM/hNcf3TwTUb8HJvEyP6W202Iult+HxyYTasW5Jd12gWhYyK8WmxkGnvKl65FuqZWx1NaVKOgeQaWVZjBOx8jSRXtkWQxx1WwOJh6YBPqSELN7qXILsD6iL7WazeGVLMbwpC4KEsMSbvhhn7GblKgdEgj1hZrVio2KKvKZgkBpug=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(40470700004)(36840700001)(46966006)(83380400001)(426003)(86362001)(186003)(70206006)(316002)(44832011)(81166007)(6666004)(336012)(16526019)(82740400003)(36860700001)(40460700003)(4326008)(54906003)(47076005)(36756003)(110136005)(70586007)(8676002)(40480700001)(2616005)(8936002)(82310400005)(26005)(478600001)(2906002)(41300700001)(5660300002)(356005)(1076003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 22:57:14.2574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0ec7a5-8182-456b-91d5-08da65230711
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2385
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD system with SNP enabled, IOMMU hardware checks the host translation
valid (TV) and guest translation valid (GV) bits in the device table entry
(DTE) before accessing the corresponded page tables.

However, current IOMMU driver sets the TV bit for all devices regardless
of whether the host page table is in use. This results in
ILLEGAL_DEV_TABLE_ENTRY event for devices, which do not the host page
table root pointer set up.

Thefore, when SNP is enabled, only set TV bit when DMA remapping is not
used, which is when domain ID in the AMD IOMMU device table entry (DTE)
is zero.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c  |  3 ++-
 drivers/iommu/amd/iommu.c | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1dd1c2b25898..959595c49656 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2566,7 +2566,8 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 
 	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
 		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
-		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
+		if (!amd_iommu_snp_en)
+			__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
 	}
 }
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a56a9ad3273e..aedeff8af929 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1552,7 +1552,15 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 
 	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
+
+	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
+
+	/*
+	 * When SNP is enabled, Only set TV bit when IOMMU
+	 * page translation is in use.
+	 */
+	if (!amd_iommu_snp_en || (domain->id != 0))
+		pte_root |= DTE_FLAG_TV;
 
 	flags = dev_table[devid].data[1];
 
@@ -1612,7 +1620,11 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	/* remove entry from the device table seen by the hardware */
-	dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
+	dev_table[devid].data[0]  = DTE_FLAG_V;
+
+	if (!amd_iommu_snp_en)
+		dev_table[devid].data[0] |= DTE_FLAG_TV;
+
 	dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(iommu, devid);
-- 
2.32.0

