Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9607855521D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377280AbiFVRNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377199AbiFVRMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:12:44 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3842871C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExPg+NEilw6G0RpPRKB3rTJB68AwvIiBvb5SmF8c7WWOO6kCv7qgCITsRLOJBrfXDOORhY3Bql/mhQKI9hmQAMHpnwAKQ9FO3vsnbM1qv+1OirxP8rNpY8GB+WfZX/5vurGyZHbxvrVeVft2aKH7tcHet/xsNQp5rH8BNN5MHHflpX6dN6ap8U/A/sc+wxxGWF7cu2dX/njXkq+WgPoG956wZi4xE9sPlFmNBH/AHIhmtwth3/Gd2GC6fMoRS54CPVrcxK6uGBeQ02TsKpLi5SlT5Tk3QT/DIwE04gk+sBFG9pNJOL0kUT6QtV6IpnT9ko8lWvaOEZ+FyA66d4SCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xNjoOGUpUbqBatM/2Ltlg9J+7hvci4yfPw5Ffv68so=;
 b=jnmIQ4z8ijXDgXVVh/783WX/BQ2/kUD5hMm9AX1JFaXNivGlNBWLEFPywQEXHiCecIABOCKH35U2KU2WB2r+M+Bk2jZ9B/L4qNDFRkiIjzi/glrh6EVqPjjiGPW9UXCcX7vLvUxj19CZ5dJ4BUykGvXA48XSvFZFpjRLAp8bJocgVdpWF+A4q7AJTvSFnDjzYtKFvqEbRk4ED/3tAQ0P9m9WzQbx9BH6MtW4pgHPdWTJODoDEPC0cjPYQUYIroOmYgbgK2EWYIFilHczFvltvKr4bwnYJ3bNQ7hYxaZGlb9hLPNHImDWWEofTv/xRYP+0GujQBjXZgTVdGfU4jkfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xNjoOGUpUbqBatM/2Ltlg9J+7hvci4yfPw5Ffv68so=;
 b=j2XkFJ41b2QJH+Ib1l2nHPUsLTEvRLUTKOC6vtDrH8wIPJYHSBeasQmcfAiIIF4cDNcxWmNv3vY1iKhP/5iXvQZYKWcYwAq0mt95k8TxOwyJNzpUPhFhgVMEkmLM7nc0Pto2vSK2neieP6pMYHrlGdheNtVQWoQRzL/c53vWSSs=
Received: from MWHPR08CA0048.namprd08.prod.outlook.com (2603:10b6:300:c0::22)
 by DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 17:12:40 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::d6) by MWHPR08CA0048.outlook.office365.com
 (2603:10b6:300:c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Wed, 22 Jun 2022 17:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Wed, 22 Jun 2022 17:12:39 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 12:12:35 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
        <vasant.hegde@amd.com>, <thomas.lendacky@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 6/7] iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY after SNP is enabled
Date:   Wed, 22 Jun 2022 12:11:30 -0500
Message-ID: <20220622171131.11870-7-suravee.suthikulpanit@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96a36770-816e-4e0b-ac49-08da5472699f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5216:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5216039D4D722A7A72CA5637F3B29@DM4PR12MB5216.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMnmzdS1fPySDKtSXkwxr5M5CXaJ3ifRZzBX1XyExkuIUc8XkCmh023b8Q+/n3x9nuE63Ljkdl2WmJmlMJgmGhpOQjO0CXIaor5vc5VEEO1dZbn6NEvOYxXnxfUAhn+ie9f8XoBF1ktzyDmUeFEe1oU0Onfkl3ubzBI+c2mEhhYxHzkTVS2sFSevCQo+UR8dtNItqAfLPXKO67wQn5W/Ns5OTnaB+3XkODoN95d3LQerSRCiyjNmIlTgMA/IYB4dEQhuLaPh7FEm8hnjVdZ1fiO5z3VcJ2vxAPX3SqQ3m1BFcNnBeiAxJYLUOXG/IqLRzxhcrv4KEcG1xnXh6u9CFxoxk/69VV1xUJlvJS90tvbjkFLfCBBEdSbBOSxjfV+JB8ve4PrMxTqSAABgejFzlKDTC52Sz9PpsJeI76fOBv4skQ9eRC7hWAxrVR9zdF41Ey3SEEjkMJgalrR81GPyN6O+73vXX6rlhrHEAb/GnVzMQOsV/m0QmlAwOgiih2E3LRYhK1NTWUy9hYpRCleifP+PWBDlUHWYnM4cNs+HDjg2Rwr4Qi7CKXmTIAs4/4FeNauMqBJHxljaM4oZ4bPFjXgAtyRQdeAAxv8symoAJmf+MLHuCBGxOjTQhqHomLZWoz0xTO6suG40KeXz64Oun32sqB7fn21NrTBn/bnKQEl2sLp/Nb2sAzqBkr2WY9DrfO+bsu2PggVDCdA/9OP64lDVFkd/isljt+4Rd5IesHjA4d2B2mC00GWUqi+h3Ztp3mtxF/hpS84wKvdya2GARMJtWr6L6Xh+46dX+kvhaFg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(40470700004)(36840700001)(478600001)(44832011)(110136005)(2906002)(26005)(54906003)(36756003)(70206006)(316002)(70586007)(41300700001)(2616005)(86362001)(8676002)(6666004)(1076003)(83380400001)(36860700001)(4326008)(336012)(82740400003)(40460700003)(8936002)(186003)(81166007)(82310400005)(426003)(356005)(7696005)(5660300002)(16526019)(40480700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 17:12:39.9548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a36770-816e-4e0b-ac49-08da5472699f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once SNP is enabled (by executing SNP_INIT command), IOMMU can no longer
support the passthrough domain (i.e. IOMMU_DOMAIN_IDENTITY).

The SNP_INIT command is called early in the boot process, and would fail
if the kernel is configure to default to passthrough mode.

After the system is already booted, users can try to change IOMMU domain
type of a particular IOMMU group. In this case, the IOMMU driver needs to
check the SNP-enable status and return failure when requesting to change
domain type to identity.

Therefore, return failure when trying to allocate identity domain.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4f4571d3ff61..7093e26fec59 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2119,6 +2119,14 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *domain;
 
+	/*
+	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system,
+	 * default to use IOMMU_DOMAIN_DMA[_FQ].
+	 */
+	if (WARN_ONCE(amd_iommu_snp_en && (type == IOMMU_DOMAIN_IDENTITY),
+		      "Cannot allocate identity domain due to SNP\n"))
+		return NULL;
+
 	domain = protection_domain_alloc(type);
 	if (!domain)
 		return NULL;
-- 
2.32.0

