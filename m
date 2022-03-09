Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9814D3850
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiCIR75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiCIR74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:59:56 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA7E12E9DE;
        Wed,  9 Mar 2022 09:58:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TptIv0yUKmOVsYvJIhQv//l7C12fN8wePJYPzkhGbLWkmgbAweNx0Oko08ydF5FRpZizeP8p6FUJ+xZHYfVPnRswFc7kBSiMEJQwNtlC2uUz/ZJZ8YPhzZA59rLJ0r3NGj3r4D1802T9pEi908SrSZq3bot34adzZKiVqmtusC18EYRXfTJP64dCYcD9QnRbbXetA3dozlsmZOIB/u/+kLHC/64BYZJlhWV7Pr7TFDn2z7YGo1eKt1BboGWsxu0D9V7S/iU0n9QLnoA/an3oiyPglCOrTrmaRqPbq2GIq/P1cIqp3wuwQquGY0TaJMUA+i436RTfv+l0JXM//vEOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjRPfGccae/SCO21pZD78EY6CcSgw8S9OV3B853pBm0=;
 b=mOzOpKQZIwj6QPxgbAJfUGGgiZ6UIuACQtEeavNCUc+zNEOgFNMPDB8NujpRA0oSO6QtX9NhTn+LNf2F6EAJEqsslYS1jnYQM7avXjcQ9aDxrZkTq6MW+NHsBye7AE7PF6R0JS7BsmHQGES4jfJqQ+N7TsAShfCnVwNDwdX6H7yoH9n5ONujVHE5g0R4c/KbWnJ2GT0Uy36RiPc94nGvyv1ywmjrPw8R+Ho+oWJTsWma7fTyeIpmgrG728D1AEfLhrJ0oH27WNCokQuNQuQytKXFPPnX7cJhIJmROUEzP/fFHX2A8uj0JQ+mt7rixQXCy71P+e8qvTtNBLFDUDo+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjRPfGccae/SCO21pZD78EY6CcSgw8S9OV3B853pBm0=;
 b=LoJ9yhT+590bgBJU9RnbLoQOFuQRwzEBXPypjCkKbwwe5W6FHHpbheO/w3BMYeS+JhmjYpe5MoMt32Tj6G+St9UMpG56ihC33cNAWV4YPWdT/hk3zB1MK14OKjYlwmWF9MClD97cqCZv8221/HRJeXd/QueiHPzcgGjTA62cWbE=
Received: from DM5PR20CA0020.namprd20.prod.outlook.com (2603:10b6:3:93::30) by
 MWHPR12MB1694.namprd12.prod.outlook.com (2603:10b6:301:11::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 9 Mar 2022 17:58:24 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::b3) by DM5PR20CA0020.outlook.office365.com
 (2603:10b6:3:93::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 17:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 17:58:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 11:58:20 -0600
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <joro@8bytes.org>,
        <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
        <iommu@lists.linux-foundation.org>, <robin.murphy@arm.com>
CC:     Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] Documentation: x86: Clarify Intel IOMMU documenation
Date:   Wed, 9 Mar 2022 12:58:05 -0500
Message-ID: <20220309175805.1298503-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309175805.1298503-1-alexander.deucher@amd.com>
References: <20220309175805.1298503-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac905de1-f8e1-47b0-07fa-08da01f6679a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1694:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16944A6E46288A0F3B1AB921F70A9@MWHPR12MB1694.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fvUd24HY5pwqhPuIOWl1OVtU5oX7VkLCAHGOzvT244HZWW2RkZAre0Kp2BQvcLjbxSYNzsDz1784GVHHT7+8sKJKJ7L2FZoiAv6AaTKna1GiUrhePRF3A87jqeIIRhrjJkcMcHAint9IYHDPThUoAYAkhBHzdWK2XmJYXGcZyk5Jwl56Y1ZWo+nM7H/83WtcdmwALT/ooL9fbkNU8Q7YBXO4PT2AZXoI8iJH9JRRg7MDdmYh3np4gU8N6va3dZdVj9QvSvBvSn970r4xTZNAWBFdl8K82Lcsh8ALcDBA+oAITwGtDMFvYmilTLxhvqzzH5JhUW0JuvB5jKWoe0g/DhaUmhuIkIi9MkhnmkYRZm/XHss0u32WIIRGemSwINzWae42dPuvzs4tTHOOYddnaYWOWGAdbL82yr5Z0ZyF7DF/dDfEV67IP/e6GVAtLixt113MWR4vFkhUi9tGPXSSFhfVYlSiXuEMxCvRjdYnHiWYVcrRkwXVI8ouYn/dusuoSVHltHbFRFKLAjRZ3bcQwkN3jEsL8DaafWwhDAC9NDBp48+4KYLu7XPQEZww9i2MbR0G7qoWupjZb04Ysg4oVL/V7hAO4x6Ez+wJy20qyIkQNBjFlxwb5F5BS9qxHZSqAjkTf7hnaaGoq1rGn1uMMpYWUa5Dj5e1Qii96uVJzXN2evS0qT2vgskaKc78+rkPVzcjmB5zgivvyjzahqPheQQzdI5F3BF91BlGK/Q8GU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(921005)(8676002)(70586007)(70206006)(86362001)(4326008)(82310400004)(7416002)(83380400001)(40460700003)(2906002)(356005)(16526019)(426003)(81166007)(36860700001)(8936002)(2616005)(1076003)(6666004)(186003)(336012)(36756003)(26005)(7696005)(316002)(110136005)(508600001)(47076005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 17:58:23.7139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac905de1-f8e1-47b0-07fa-08da01f6679a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1694
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on feedback from Robin on the initial AMD IOMMU
documentation, fix up the Intel documentation to
clarify IOMMU vs device and modern DMA API.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/x86/intel-iommu.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
index 4d3391c7bd3f..22e1934a1335 100644
--- a/Documentation/x86/intel-iommu.rst
+++ b/Documentation/x86/intel-iommu.rst
@@ -19,8 +19,8 @@ Some Keywords
 Basic stuff
 -----------
 
-ACPI enumerates and lists the different DMA engines in the platform, and
-device scope relationships between PCI devices and which DMA engine  controls
+ACPI enumerates and lists the different IOMMUs in the platform, and
+device scope relationships between PCI devices and which IOMMU controls
 them.
 
 What is RMRR?
@@ -36,9 +36,9 @@ unity mappings for these regions for these devices to access these regions.
 How is IOVA generated?
 ----------------------
 
-Well behaved drivers call pci_map_*() calls before sending command to device
+Well behaved drivers call dma_map_*() calls before sending command to device
 that needs to perform DMA. Once DMA is completed and mapping is no longer
-required, device performs a pci_unmap_*() calls to unmap the region.
+required, device performs a dma_unmap_*() calls to unmap the region.
 
 The Intel IOMMU driver allocates a virtual address per domain. Each PCIE
 device has its own domain (hence protection). Devices under p2p bridges
@@ -68,7 +68,7 @@ address from PCI MMIO ranges so they are not allocated for IOVA addresses.
 
 Fault reporting
 ---------------
-When errors are reported, the DMA engine signals via an interrupt. The fault
+When errors are reported, the IOMMU signals via an interrupt. The fault
 reason and device that caused it with fault reason is printed on console.
 
 See below for sample.
-- 
2.35.1

