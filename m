Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A06508700
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378102AbiDTLcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbiDTLcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:32:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C85332
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiaDUcACyHLyycvWwUD1GfTxGAA+pIe8tYQYN4Sg4zgqY1DYCnAsna7X2TAM1Xg+MKqw9cDx3B7y7eB2pav91ZsO94Q7SXgtkaPZHsA1PfpYl/kW2suBB/7u2qBvaVt5X0hERUD7WIo8T/9KB4DKacye8RazVHAv8Vbjo6uV7M+bu8Mn4IbR8sXcmhY7drQafiNuAe1ISozFHYf2cjcHBsp35c8VM2GayGCmjM6ag1bklZh6eXGWRMhWMgU9dXXzCn/Bi3AlFMpdYDRZ60mq0WUam6leSWCBxPbhFdX+x6dxbxRNBxvDU9jUQvQC6VFzq43F0UADUdRELjSIbq8OhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ybtfh4ubRyT6HXAwbp5rDNPI/riPeM6bZYu3+gH3Hfs=;
 b=JrHBBmawCxLqp8Uic2EjbXIxxjQj65LD51JvcyosB07/mQac53fAxELcJEdjZZcGo51PRMVNXIi7Be9wqK9ypjjIuREITZiL2t3RFKbjCXMTgUOUa1yAvUNs4ov1KDy09QRvJxNVQBHhixCINi0fsWFbRJqyc75zPl74v/YEI4hT7RpTZH9DssoD4OzqT1KJ/76Y1kmSqxHT5/b6/CfnBxe7oum87/Vr8Bwhwy9D+n8xV5kDbR3vGWwIaIKl05ofxLxJ92S+F+u3eiDrX4tEtkcRQx272bcHzb0dlqKXxOE7KVadBn7yiRxG/9g4snV3yc9N1IIev2whR6v6x5XcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybtfh4ubRyT6HXAwbp5rDNPI/riPeM6bZYu3+gH3Hfs=;
 b=rQIgO+6ckI9WtbHzwHc/F7TOZDk714nCyfyAhcDIV+8sNpiD00JN7k9YSO7DIejteqlx9oarOck/dn8eKnxP1OVxpuyXXo2vEBAc96FxeFdb3mnjXCT2rCp9o+Qo5w3TkzB93BYNvbQGSZhmm5P3/XNCmX3eXINzk5vCvx3K6Qc=
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 11:29:38 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::8c) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 11:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 11:29:38 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 06:29:30 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
        "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Set translation valid bit only when IO page tables are in used
Date:   Wed, 20 Apr 2022 06:29:20 -0500
Message-ID: <20220420112920.18091-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee8877ba-a670-4c54-40c6-08da22c10e32
X-MS-TrafficTypeDiagnostic: MN2PR12MB4288:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4288A1B3AF9BE39F96889310F3F59@MN2PR12MB4288.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIMW5LtdOE3CiNYXZbJ5PtIlq6tyHBJ8lZU8F1U0ABzddLm03e79eOYL5W/tSmVAFnnx9iEX/wWYPieYZR8JWpbegwkMkbWhhjt7zafoSrzJfCIOs3ZsRT3PgoJI6gK47VK8qeWBUsSWhPL0TamZhB9wUGyN9kgBwIxa7Ty8MgVYghAZF2mZisDwr0ravyG4cPmB3Uj77njUrwH9iuwxx0R77Fu6Ho4Dkj3G+hijVQjanAfB5/tm34u5MxXst7tyq/FVt5bptmRYBf9Oj1Jo1hUQPqNTubZaJZk5J/Cq3oLQdp+VrJNRQV4VQGJoCbAkfkoPQExotN3ilt9oZVdU45FnOvTgAKgBM2S/D1PI/mHuvJiaz32rRgl3quS6o3b+3SgkhwBViwmTtp9C5e4udZ5PxwhE11+sWdygas6jPVgVClHtfNS4C10Z2hywIDujfSZN+8HeUpCm38aBLXdHMNpz3oCQecU/Emmw3rYqTgqFZROfh7obGh1lV+b422gV4ewRxUg6b0RjARp6dFkKvlVoX28WBaIwbVznrxVBl3w9k+qPVUy6CkqAXyyDpCtujLESvkvRaw9tU+gMSS8CACvMCDyx7znCvIrBbE4Qv1rWsk0D7cv6TzA9Uq/DPk5WqLS23d7C/aoMN4roQkHMXzq73KZFMYqVBML3xclAdB3zqBSkux7L+uh85wYQzzsNHPjqG22rzhiUoHjLxN5VCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(8676002)(70586007)(86362001)(70206006)(83380400001)(40460700003)(44832011)(8936002)(5660300002)(82310400005)(336012)(356005)(4326008)(186003)(426003)(47076005)(81166007)(1076003)(16526019)(2906002)(2616005)(508600001)(26005)(7696005)(6666004)(110136005)(36756003)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:29:38.8084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8877ba-a670-4c54-40c6-08da22c10e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD system with SNP enabled, IOMMU hardware checks the host translation
valid (TV) and guest translation valid (GV) bits in the device
table entry (DTE) before accessing the corresponded page tables.

However, current IOMMU driver sets the TV bit for all devices
regardless of whether the host page table is in used.
This results in ILLEGAL_DEV_TABLE_ENTRY event for devices, which
do not the host page table root pointer set up.

Thefore, only set TV bit when host or guest page tables are in used.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c  |  4 +---
 drivers/iommu/amd/iommu.c | 13 +++++++++++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b4a798c7b347..4f483f22e58c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2337,10 +2337,8 @@ static void init_device_table_dma(void)
 {
 	u32 devid;
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid)
 		set_dev_entry_bit(devid, DEV_ENTRY_VALID);
-		set_dev_entry_bit(devid, DEV_ENTRY_TRANSLATION);
-	}
 }
 
 static void __init uninit_device_table_dma(void)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a1ada7bff44e..6dd35998e53c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1473,7 +1473,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 
 	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
+	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
 
 	flags = amd_iommu_dev_table[devid].data[1];
 
@@ -1513,6 +1513,15 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 		flags    |= tmp;
 	}
 
+	/*
+	 * Only set TV bit when:
+	 *   - IOMMUv1 table is in used.
+	 *   - IOMMUv2 table is in used.
+	 */
+	if ((domain->iop.mode != PAGE_MODE_NONE) ||
+	    (domain->flags & PD_IOMMUV2_MASK))
+		pte_root |= DTE_FLAG_TV;
+
 	flags &= ~DEV_DOMID_MASK;
 	flags |= domain->id;
 
@@ -1535,7 +1544,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 static void clear_dte_entry(u16 devid)
 {
 	/* remove entry from the device table seen by the hardware */
-	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
+	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V;
 	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(devid);
-- 
2.25.1

