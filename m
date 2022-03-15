Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8764E4D9FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350042AbiCOQ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbiCOQ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:27:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F6D56C13;
        Tue, 15 Mar 2022 09:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlntoGGSX+mz6V8B+wjrC65QuucXjCGREJnBSKJHfGFUGddNKQtZTHxfw9SEwouTaoVSsdH9kpQMuWW3UDiSeI84xoUZZa1Si/aXqpDRxTi65LmrvSWn8fhrWOgRET5/6GhgsudRohg4L2BBRMoDh3xcJkiV01uhSMiqBMBPPJhG0ZKQGg48q+QbBQGaood5A6ojIldLiHxDTl+Wzz4kYa7zvTSYjhYD9IJSdhtwVM+FlHHsHljtBamddVKW6nogGB6YkpHucwMK88CPleX7NvFXTtiCaj6jBu9d+kWYPzoFatywRRwZxppEcn7w09akMMBakK0rP5L77v+MYC0HVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0EQHHkf/VTb3rmTlnfa9a41JED/3nfcpRaIod8f4ZI=;
 b=J18CJ4E7zg5r9g0FJvXeVfsRgqYwHTnh3ujsS3KHMAIw/TpIoAyrSyK7e8sdoAIwIHVZEAg7SY9ehOcjBFRqVZTB5Fny+khj1U7L5xWz9z1pfzAt8eSkTC4cxmW2PhnFNia+cKk+uAF4HP22b063o901hSrMKURkaabkwB4l6dbWTCMsAnsvhgiifAn9QX7IoBQeCGBlhkg7jiGmNSiz4ONh4B+XdUEPu5dduUW9VEWjTHwufM0vWnKtQNUrAhFtUaFQRKnL0LIOxmg4BUHcsXcdp1OUdQsFT7JmBsC2r+2prAaa0aEEKv/uI//n0NvHBYKwM6lzfHMS31Ve9i6Ojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0EQHHkf/VTb3rmTlnfa9a41JED/3nfcpRaIod8f4ZI=;
 b=TbN6yMdU/zdwgvbZj0V95yC0Rn70ujV7vWDFW/Sooj4kep8YIEmNhxrj3zj+b64nO4kmU6pAaKqviq0sN5vfC5z8o82eUMXvyGRg1EKVRTD0dqkK2VMjGhfROBERiuqw4WBiH+f6lgw38muwPeJVqZI4tt5iAtfb8SSei93aHiA=
Received: from MWHPR19CA0078.namprd19.prod.outlook.com (2603:10b6:320:1f::16)
 by DM6PR12MB3228.namprd12.prod.outlook.com (2603:10b6:5:18c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 16:26:02 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::62) by MWHPR19CA0078.outlook.office365.com
 (2603:10b6:320:1f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Tue, 15 Mar 2022 16:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 16:26:01 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 11:25:54 -0500
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
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD systems
Date:   Tue, 15 Mar 2022 11:24:55 -0500
Message-ID: <20220315162455.5190-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315162455.5190-1-mario.limonciello@amd.com>
References: <20220315162455.5190-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 472eb2b1-7116-4328-ef7a-08da06a07ec0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3228:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB32283DBCE8E03DED9030F78AE2109@DM6PR12MB3228.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRQAOn4gwvOYRZ5ykALdvyzpzcbE5LXmfCj+q93zQSlPMbBgaBNrdNvtpfTsihEW8jnyuU31chubo0KbhTzvNP84IZcqV1PGbyebOQPh1yCPZIi1Fkt87Fx7wXKKYoUM5t+tTavHIZkvpDAgn5qaa8lAQ7OGYKfyinUpIlGRYfXggBggF200h3tRWMyItmujMJNTkrlAQKPL8U7WWpvXtpdCDtSZxg56qw23J3Lg/+3r0UkPGTlb0V+3j6YY0O5w4EAeI6iaZni2NRguc8xuVNNl4Sr4vhcmRofaTG7KxLqDlv3CPUM66OVhbhs9/DccwPUgtMCeYP7Tqc8lZ0vkOjsHc0/gC0wee219uezgP0UKDXorX2wKyjewVn3TCRJBF2dPLKvEzeV6gKXdyhncnpYdqbkHupJnGeTkDv3puTBRO+K3el3jwXiQZtF96OFq9Jz+wyzfVExTlLirVxX48FR6QiEqpfEJrAhrWG/zjg+u8vqvGKv7+kch/R77blUbtxG3O9oEz/M8gitEsUEDgVeP3Dd7wbykheRxat5E4IxpJbOtKpC2BaeZe7Pw185AkLvFfFj3dnS2g94FaUB491rW/H2hj+7Oeo5vNxat5RDuFdcaxQaYECf7hUmSbS0hJI1tR2+cmJEWVg4ToFOMHgS186i2GqfiQCbqezzDCTJYYiytcBliN3CIqCCpKrKTm6FSBB1nKXjWl0tD3REK1FVYMppHb47Tva2f/rnHa+jfZS/7rujwW3oUCf4qBuQzBvsrY3ezZNU9uNQz8j8apzEN9cGQWTzv7lvlhYB+EuSTrhe4Yy1yuLj8F5uQG8vHDKHguERoilOkKwJ0CYBKOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(54906003)(110136005)(316002)(36756003)(36860700001)(508600001)(82310400004)(70586007)(70206006)(966005)(8936002)(44832011)(5660300002)(2906002)(40460700003)(8676002)(4326008)(81166007)(7696005)(356005)(2616005)(86362001)(16526019)(26005)(1076003)(47076005)(336012)(426003)(83380400001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 16:26:01.5579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472eb2b1-7116-4328-ef7a-08da06a07ec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The information is exported from the IOMMU driver whether or not
pre-boot DMA protection has been enabled on AMD systems.  Use this
information to properly set iomma_dma_protection.

Link: https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection
Link: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/domain.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 7018d959f775..e03790735c12 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -6,6 +6,7 @@
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
+#include <linux/amd-iommu.h>
 #include <linux/device.h>
 #include <linux/dmar.h>
 #include <linux/idr.h>
@@ -259,11 +260,15 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
 {
 	/*
 	 * Kernel DMA protection is a feature where Thunderbolt security is
-	 * handled natively using IOMMU. It is enabled when IOMMU is
-	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
+	 * handled natively using IOMMU. It is enabled when the IOMMU is
+	 * enabled and either:
+	 * ACPI DMAR table has DMAR_PLATFORM_OPT_IN set
+	 * or
+	 * ACPI IVRS table has DMA_REMAP bitset
 	 */
 	return sprintf(buf, "%d\n",
-		       iommu_present(&pci_bus_type) && dmar_platform_optin());
+		       iommu_present(&pci_bus_type) &&
+		       (dmar_platform_optin() || amd_ivrs_remap_support()));
 }
 static DEVICE_ATTR_RO(iommu_dma_protection);
 
-- 
2.34.1

