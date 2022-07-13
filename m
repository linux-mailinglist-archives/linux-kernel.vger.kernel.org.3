Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA4D573FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiGMW5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGMW5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:57:18 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E0C4F66B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm3eEDcXN9Qhy2jFeTEdaFVDex/5/X45HaDXPYgZduGKR/MjDdrAabxHaaizay7KmwUsJtbAT/Djm5S+E7hXxiaZsx0TLWa7PerdxpI5WOxcNTyrKV5WLg8iKzrAt5tm0rdcudAvPLZSLjZaeD/iATrNb+m/PuRTwul5IqoH1UKxGhvzPcEUQ8yw78J/4yIsNbQWVRBBVXzCiDwXp2yQ8krvsCU4tZa4O7G1LJbbIWy+T/+1pHTX2WEsicM8t8opLv1VRu1f2Bl/8kl1Br+9U5HUkEF0jC10TW109fs8QsG8KROz2sskNMERj7c1bKTc+FCb+5LiTvbM4xQcv1czqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycS9jJzmGO1/xnfZTadn2YA8oEbhxzoqYRQiYzo+2BM=;
 b=hPvvwQOxv79+v5W84uYKkP7ttOpl5NtGy2H70UNSvwdqiDi0GrM8RjRnQv83gfn7wub6If9sVdej2fk6KxnVzrZKjBORcWFdRS7B8vxGdsLnn1sZnjIBX6DehYBlyLHdqHQtEARJzXwwBN83ViQcQA0hbmozi33y90Wo5jrmgVJZC9vys1izcqqUTTOmss8D4xUJ3WkyohWEgfJlvhJkj5Zq0mU69B9ZH1H6ntvqhCAn0IFe9hmk+VCm4Kzg8cHuGFqF/R4hTgD+CgbtDWBZQLSYBCY4o/iDP8rru+PVy/pAucUghpDn9byrdR6W4QNcObtza29wzBcN8vhbv2cU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycS9jJzmGO1/xnfZTadn2YA8oEbhxzoqYRQiYzo+2BM=;
 b=Xm69JXn7UfWYKjqFyMcVo1NiUfaGsELxEx6mYlNR2OXF4y5UtPXQ9OCIlvxysXo16RbqokyBgYgxjnehoUmTTTolhfu5MP3WFK4ckciOBL45unUMfoap2Ipczx06JSymvsjmry+iwNR+aN3NcukofgvrjqsWxxpKXljrm24If6s=
Received: from BN9PR03CA0532.namprd03.prod.outlook.com (2603:10b6:408:131::27)
 by CY4PR1201MB0215.namprd12.prod.outlook.com (2603:10b6:910:1d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 22:57:14 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::c3) by BN9PR03CA0532.outlook.office365.com
 (2603:10b6:408:131::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Wed, 13 Jul 2022 22:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
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
Subject: [PATCH v4 8/9] iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY after SNP is enabled
Date:   Wed, 13 Jul 2022 17:56:50 -0500
Message-ID: <20220713225651.20758-9-suravee.suthikulpanit@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51c82d32-3831-4b61-9a0a-08da6523071a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0215:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6h7qOdr5lZpzSwQiRC1d+bzx42w/EwYqP+C2Jjw10hKOtwA2A4ZTsBnkpttDKQAkoNxq0Z23P6CHVvwoETEbe/g9fUY+lrka0R5XfSMfai5zSuYHJO43auYcarDffWJyjB3GYGx7bdNnAZHBe5uBg4GkIuSpuumaYVDmoHNccsfP2cJuZpPnCjV/1tbQWuoq+s9V77AUlbWPWnkjfN6JEveYg7tavy0w/ewqItTbH5sAQloW5zXAHfUCGcUnTldpjapijomSixfeQfE2gEHm/i2jBV9S5SiW37KqGQJNTlWIqTd5Qz8+Co7cq7PUB0XQfGni7U7RY7jhHHAWXyT87wbLcC+k+ZOdFho/1xtj3bJBeySvjnzuGtplYOXcmqZWF2PPMa35sTDmJl7eqSf6/I3HGtr8O54fNpn4E/8Ms4P+YpbYE8899rFEBk6k2AdX9cBmptCNNeRFtU7b14pyUzPCnrG00NI99ytTtcYRdzpKsS4NBb8T9nUFkul0LsASDeWljW7awiY9JzZuB6H5GYN4A2IelzXpAp4GNslL03Wc2fvw29PSwtBH6j4kHClsKgFzi2I3I1yI8K7kJrMS/Ggk56dAXmcSL9De+92n2GjkHRZqX19Beq5jUK4ton1TZSt7dB3pT/enU+0kkX4N56hKuR+nynhgm52k5pR8n1rMkANmudnms1N15a3Rl4GSPAoMsohcZ6FqLEhg782t4BudKOz3GBOwCgbYNi+44oK6DMWspGUga9uPczeBDgUn+lEw8swOfcHlyGiJZJMlzZZQcgjTqkFfBosdgx3SJaJs22T2z1gCKFZHOMCA6jPVsBTPaAABNLlX4CLisXZcO+6Q1eAuWXrihiWQKNIFVw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(40470700004)(36840700001)(46966006)(336012)(40460700003)(36860700001)(82310400005)(83380400001)(186003)(47076005)(478600001)(316002)(2906002)(426003)(36756003)(40480700001)(7696005)(44832011)(16526019)(356005)(6666004)(82740400003)(41300700001)(110136005)(1076003)(54906003)(8936002)(86362001)(5660300002)(4326008)(70206006)(70586007)(8676002)(2616005)(81166007)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 22:57:14.2853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c82d32-3831-4b61-9a0a-08da6523071a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index aedeff8af929..59f9607b34bc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2068,6 +2068,14 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
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

